#ifndef _SNN_IZIKEVICH_H_
#define _SNN_IZIKEVICH_H_

#include "snn_types.h"
#include "../../snn_config/snn_defs.h"

/***************************************************************************
 *        Function: snn_update_neuron_synapses                             *
 ***************************************************************************
 * 	Iterations: NUMBER_OF_NEURONS                                          *
 *  Pipeline II: 1                                                         *
 *  Inputs: v, p                                                           *
 *  Outputs: synapse_s                                                     *
 ***************************************************************************/
void snn_update_neuron_synapses(
		const	vu_dat_t	v[NUMBER_OF_NEURONS],
		const 	uint1_t 	p[INPUT_SYNAPSES],
				s_dat_t 	synapse_s[NUMBER_OF_LAYERS][NEURONS_PER_LAYER]) {

	int32_t l, xl, x;

	synapses_layer_updates: for (x = 0, l = 0; l < NUMBER_OF_LAYERS; l++) for (xl = 0; xl < NEURONS_PER_LAYER; xl++, x++) {
		#pragma HLS PIPELINE II=1

		s_dat_t synapse_value = synapse_s[l][xl];
		s_dat_t new_synapse = synapse_value * (s_dat_t)S_DECAY_FACTOR;

		if (l < NUMBER_OF_LAYERS - 1 && v[x] >= (vu_dat_t)35.0f) // firing input (t-1)
			synapse_s[l][xl] = new_synapse + (s_dat_t)1.0f;
		else if (l == NUMBER_OF_LAYERS - 1 && p[x-INPUT_SYNAPSE_OFFSET] == 1) // synaptic input
			synapse_s[l][xl] = new_synapse + (s_dat_t)1.0f;
		else // only decay
			synapse_s[l][xl] = new_synapse;
	}
	return;
}

/***************************************************************************
 *        Function: snn_update_izikevich_equations_by_neuron               *
 ***************************************************************************
 * 	Iterations: NUMBER_OF_NEURONS                                          *
 *  Inputs: x, neuron_type, g_exh, g_inh, v, u                             *
 *  Outputs: v, u                                                          *
 ***************************************************************************/
INLINE void snn_update_izikevich_equations_by_neuron(
		const   uint32_t    x,
		const	uint1_t 	neuron_type,
		const	vu_dat_t	g_exh,
		const	vu_dat_t 	g_inh,
				vu_dat_t 	v[NUMBER_OF_NEURONS],
				vu_dat_t 	u[NUMBER_OF_NEURONS]) {

	vu_dat_t dv, du;
	vu_dat_t v_t = v[x];
	vu_dat_t u_t = u[x];
	vu_dat_t I = (g_exh * ((vu_dat_t)ES_EXCITATORY - v_t)) + (g_inh * ((vu_dat_t)ES_INHIBITORY - v_t));
	vu_dat_t IZH_A = (vu_dat_t)IZHIKEVICH_A(neuron_type);
	vu_dat_t IZH_B = (vu_dat_t)IZHIKEVICH_B;
	vu_dat_t IZH_C = (vu_dat_t)IZHIKEVICH_C;
	vu_dat_t IZH_D = (vu_dat_t)IZHIKEVICH_D(neuron_type);

	if (v_t < (vu_dat_t)35.0f) { // Not firing
		// First 0.5 ms
		dv = ((((vu_dat_t)0.04f * v_t) + (vu_dat_t)5.0f) * v_t) + (vu_dat_t)140.0f - u_t + I;
		du = IZH_A * ((IZH_B * v_t) - u_t);
		v_t = v_t + (dv * ((vu_dat_t)TIMESTEP_MS));
		u_t = u_t + (du * ((vu_dat_t)TIMESTEP_MS));

		// Second 0.5 ms
		dv = ((((vu_dat_t)0.04f * v_t) + (vu_dat_t)5.0f) * v_t) + (vu_dat_t)140.0f - u_t + I;
		du = IZH_A * ((IZH_B * v_t) - u_t);
		if (v_t < (vu_dat_t)35.0f)
			v_t = v_t + (dv * ((vu_dat_t)TIMESTEP_MS));
		u_t = u_t + (du * ((vu_dat_t)TIMESTEP_MS));

		// Persist results
		v[x] = v_t > (vu_dat_t)35.0f? (vu_dat_t)35.0f : v_t;
		u[x] = u_t;
	}
	else { // Firing
		v[x] = IZH_C;
		vu_dat_t new_u = u_t + IZH_D;
		u[x] = new_u;
		#if PRECISION_TYPE == FLOATING_POINT
		#pragma HLS RESOURCE variable=new_u core=FAddSub_fulldsp latency=8
		#endif
	}
	return;
}

/***************************************************************************
 *        Function: get_weight_line                                        *
 ***************************************************************************
 * 	Iterations: NUMBER_OF_NEURONS                                          *
 *  Inputs: streams                                                        *
 *  Outputs: weight_line                                                   *
 ***************************************************************************/
INLINE ap_uint<AXI_WEIGHTS_LINE_BITS> get_weight_line(
		hls_stream_64_t& stream0,
		hls_stream_64_t& stream1,
		hls_stream_64_t& stream2,
		hls_stream_64_t& stream3) {

	ap_uint<AXI_WEIGHTS_LINE_BITS> bits;
	for (uint32_t b = 0; b < AXI_WEIGHTS_LINE_BITS; b+= AXI_WEIGHTS_THROUGHPUT) {
		// Collect data from input streams
		ap_uint<AXI_WEIGHTS_THROUGHPUT> axi_word;
		axi_word.range( 63,   0) = ap_uint<AXI_SIZE>(stream0.read().data).range(AXI_SIZE - 1, 0);
		axi_word.range(127,  64) = ap_uint<AXI_SIZE>(stream1.read().data).range(AXI_SIZE - 1, 0);
		axi_word.range(191, 128) = ap_uint<AXI_SIZE>(stream2.read().data).range(AXI_SIZE - 1, 0);
		axi_word.range(255, 192) = ap_uint<AXI_SIZE>(stream3.read().data).range(AXI_SIZE - 1, 0);

		// Store data into cache line(s)
		bits.range(b + (AXI_WEIGHTS_THROUGHPUT) - 1, b) = axi_word.range(AXI_WEIGHTS_THROUGHPUT - 1, 0);
	}
	return bits;
}

/***************************************************************************
 *        Function: snn_get_synaptic_conductances                          *
 ***************************************************************************
 * 	Iterations: NUMBER_OF_NEURONS                                          *
 *  Pipeline II: round_upper(NEURONS_PER_LAYER * 8 / 64)                   *
 *  Cycles per iteration: 2 cycle/iteration                                *
 *  Inputs: streams, neuron_type, synapse_s, v, u                          *
 *  Outputs: v, u                                                          *
 ***************************************************************************/
void snn_get_synaptic_conductances(
		const	uint1_t 	neuron_type[NUMBER_OF_LAYERS][NEURONS_PER_LAYER],
		const	s_dat_t 	synapse_s[NUMBER_OF_LAYERS][NEURONS_PER_LAYER],
				vu_dat_t 	v[NUMBER_OF_NEURONS],
				vu_dat_t 	u[NUMBER_OF_NEURONS],
				hls_stream_64_t& stream0,
				hls_stream_64_t& stream1,
				hls_stream_64_t& stream2,
				hls_stream_64_t& stream3,
				ap_uint<AXI_SIZE>firings[AXI_FIRINGS_LENGTH]) {

	// Temporal indexes and cache
	uint32_t y, xl, l, x, b;
	uint32_t firings_idx = 0, firings_bit = 0;
	// Cache arrays
	static 	s_dat_t 	synapse_cache[NEURONS_PER_LAYER];
	static 	s_dat_t 	synapse_fetch[NEURONS_PER_LAYER];

	PRAGMA_HLS(HLS ARRAY_RESHAPE variable=neuron_type complete dim=2)
	PRAGMA_HLS(HLS ARRAY_PARTITION variable=synapse_fetch block factor=SYNAPSE_PARTITION_FACTOR dim=1)
	PRAGMA_HLS(HLS ARRAY_PARTITION variable=synapse_cache block factor=SYNAPSE_PARTITION_FACTOR dim=1)

	input_synapses_cache: for (y = 0; y < NEURONS_PER_LAYER; y++) {
		synapse_cache[y] = synapse_s[NUMBER_OF_LAYERS-1][y];
	}

	synaptic_conductances: for (x = 0, l = 0; l < NUMBER_OF_LAYERS; l++) for (xl = 0; xl < NEURONS_PER_LAYER; xl++, x++) {

		PRAGMA_HLS(HLS PIPELINE II=MAX_PIPELINE_THROUGHPUT)

		uint32_t l_pre = (l==0 ? NUMBER_OF_LAYERS-1 : l - 1);
		vu_dat_t sum_g_exh = 0;
		vu_dat_t sum_g_inh = 0;
		s_dat_t current_s = synapse_s[l][xl];
		ap_uint<AXI_WEIGHTS_LINE_BITS> wline = get_weight_line(stream0, stream1, stream2, stream3);
		uint1_t current_neuron_type = neuron_type[l][xl];

		// Add current neuron synapses to cache pre-fetch
		synapse_fetch[xl] = current_s;

		// Perform sum of synaptic conductances per neuron
		synapses_per_neuron: for (b = 0, y = 0; y < NEURONS_PER_LAYER; y++, b+= WEIGHT_BITS) {

			s_dat_t synapse_value = synapse_cache[y];
			#if PRECISION_TYPE == FIXED_POINT
			s_dat_t synapse_weight_value = 0;
			#if WEIGHT_BITS < (SYNAPSE_BITS_FRACTIONAL-WEIGHT_SCALE_BITS)
			synapse_weight_value.range(SYNAPSE_BITS_FRACTIONAL-WEIGHT_SCALE_BITS-1, SYNAPSE_BITS_FRACTIONAL-WEIGHT_SCALE_BITS-WEIGHT_BITS) =
					wline.range(b + WEIGHT_BITS - 1, b);
			#else
			synapse_weight_value.range(SYNAPSE_BITS_FRACTIONAL-WEIGHT_SCALE_BITS-1, 0) =
					wline.range(b + WEIGHT_BITS - 1, b + WEIGHT_BITS-(SYNAPSE_BITS_FRACTIONAL-WEIGHT_SCALE_BITS));
			#endif /* WEIGHT_BITS > 24 */
			#elif PRECISION_TYPE == FLOATING_POINT
			ap_uint<WEIGHT_BITS> uweight = ap_uint<WEIGHT_BITS>(wline.range(b + WEIGHT_BITS - 1, b));
			s_dat_t synapse_weight_value = uint32_to_float32(uweight.to_uint());
			#endif
			vu_dat_t conductance = synapse_weight_value * synapse_value;
			uint1_t neuron_type_value = neuron_type[l_pre][y];

			#if PRECISION_TYPE == FLOATING_POINT
			#pragma HLS RESOURCE variable=sum_g_exh core=FAddSub_fulldsp latency=8
			#pragma HLS RESOURCE variable=sum_g_inh core=FAddSub_fulldsp latency=8
			#endif
			if (l == 0 || neuron_type_value == EXCITATORY_NEURON)
				sum_g_exh += conductance;
			else
				sum_g_inh += conductance;
		}

		// Copy synapses pre-fetched from last layer into cache
		if (xl==NEURONS_PER_LAYER-1) for (y = 0; y < NEURONS_PER_LAYER; y++) {
			synapse_cache[y] = synapse_fetch[y];
		}

		// Update neuron states
		snn_update_izikevich_equations_by_neuron(x, current_neuron_type, sum_g_exh, sum_g_inh, v, u);

		// Save firing
		firings[firings_idx][firings_bit++]= (v[x] >= (vu_dat_t)35.0f);
		if (firings_bit >= AXI_SIZE) { firings_bit = 0; firings_idx++; }
	}
	return;
}

/***************************************************************************
 *                       Wrapper (snn_process_step)                        *
 ***************************************************************************
 * 	Iterations: NUMBER_OF_NEURONS                                          *
 *  Pipeline II: 2 + 2 + 1                                                 *
 *  Cycles per iteration: 1 cycle/iteration                                *
 ***************************************************************************/
void snn_process_step(
		const	uint1_t		p[INPUT_SYNAPSES],
		const	uint1_t		neuron_type[NUMBER_OF_LAYERS][NEURONS_PER_LAYER],
				s_dat_t 	synapse_s[NUMBER_OF_LAYERS][NEURONS_PER_LAYER],
				vu_dat_t 	v[NUMBER_OF_NEURONS],
				vu_dat_t 	u[NUMBER_OF_NEURONS],
				hls_stream_64_t& input_stream0,
				hls_stream_64_t& input_stream1,
				hls_stream_64_t& input_stream2,
				hls_stream_64_t& input_stream3,
				ap_uint<AXI_SIZE>firings[AXI_FIRINGS_LENGTH]) {

	// Compute neuron synapses for all neurons
	snn_update_neuron_synapses(
			/* Input  */ v, p,
			/* Output */ synapse_s);

	// Compute matrix of synaptic conductances
	snn_get_synaptic_conductances(
			/* Input  */ neuron_type, synapse_s,
			/* Output */ v, u,
			input_stream0, input_stream1, input_stream2, input_stream3, firings);
	return;
}

#endif /* _SNN_IZIKEVICH_H_ */
