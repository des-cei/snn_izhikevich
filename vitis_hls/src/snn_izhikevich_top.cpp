#ifndef _SNN_IZIKEVICH_TOP_H_
#define _SNN_IZIKEVICH_TOP_H_

#include "../../snn_config/snn_defs.h"
#include "snn_types.h"
#include "snn_izhikevich.h"
#include "snn_izhikevich_axi.h"

// Input firings
static 	uint1_t 		p_mem[INPUT_SYNAPSES];

// Network configuration
static 	uint1_t 		neuron_type_mem[NUMBER_OF_LAYERS][NEURONS_PER_LAYER];

// Neuron states
static  s_dat_t 		synapse_s_mem[NUMBER_OF_LAYERS][NEURONS_PER_LAYER];
static 	vu_dat_t 		v_mem[NUMBER_OF_NEURONS];
static 	vu_dat_t 		u_mem[NUMBER_OF_NEURONS];

// Potential output indexes
static uint32_t 		output_indexes_mem[AXI_POTENTIAL_OUTPUTS];
static ap_uint<AXI_SIZE>firings_mem[AXI_FIRINGS_LENGTH];

#define STATE_INIT		0
#define STATE_PROCESS	1
#define SUCCESS_OK		1

void hls_snn_initialize(hls_stream_64_t& input_stream, uint32_t output_indexes[AXI_POTENTIAL_OUTPUTS]) {

	// Copy neuron_type and synapse_weights to memory from stream
	axis_cp_network_to_mem(input_stream, neuron_type_mem);

	// Set output indexes values
	for (int32_t x = 0; x < AXI_POTENTIAL_OUTPUTS; x++) {
		#pragma HLS UNROLL
		output_indexes_mem[x] = output_indexes[x];
	}

	// Set default values for v's and u's
	for (int32_t x = 0; x < NUMBER_OF_NEURONS; x++) {
		#pragma HLS PIPELINE
		v_mem[x] = -70.0; //resting potential
		u_mem[x] = -14.0; //steady state
	}
	return;
}

void hls_snn_process_step(
		uint32_t p_input[AXI_INPUT_LENGTH],
		hls_stream_64_t& input_stream0,
		hls_stream_64_t& input_stream1,
		hls_stream_64_t& input_stream2,
		hls_stream_64_t& input_stream3) {

	// Copy inputs (p) from axi-stream to memory
	axis_cp_inputs_to_mem(p_input, p_mem);

	// Process inputs
	snn_process_step(p_mem, neuron_type_mem, synapse_s_mem, v_mem, u_mem,
					 input_stream0, input_stream1, input_stream2, input_stream3, firings_mem);
	return;
}

uint1_t hls_snn_izikevich(
		uint1_t state,
		uint32_t p_input[AXI_INPUT_LENGTH],
		uint32_t output_indexes[AXI_POTENTIAL_OUTPUTS],
		hls_stream_64_t& input_stream0,
		hls_stream_64_t& input_stream1,
		hls_stream_64_t& input_stream2,
		hls_stream_64_t& input_stream3,
		hls_stream_64_t& output_stream) {

	#pragma HLS INTERFACE s_axilite port=return bundle=control
	#pragma HLS INTERFACE s_axilite port=state bundle=control
	#pragma HLS INTERFACE s_axilite port=p_input bundle=control
	#pragma HLS INTERFACE s_axilite port=output_indexes bundle=control
	#pragma HLS INTERFACE axis port=input_stream0
	#pragma HLS INTERFACE axis port=input_stream1
	#pragma HLS INTERFACE axis port=input_stream2
	#pragma HLS INTERFACE axis port=input_stream3
	#pragma HLS INTERFACE axis port=output_stream

	// Process logic
	if (state == STATE_INIT) {
		hls_snn_initialize(input_stream0, output_indexes);
	}
	else {
		hls_snn_process_step(p_input, input_stream0, input_stream1, input_stream2, input_stream3);
	}

	// Send (v) to output stream
	axis_cp_output_to_stream(output_stream, v_mem, output_indexes_mem, firings_mem);

	return SUCCESS_OK;
}

#endif /* _SNN_IZIKEVICH_TOP_H_ */
