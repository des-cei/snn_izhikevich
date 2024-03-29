#ifndef _SNN_DEFS_H_
#define _SNN_DEFS_H_

#include "config.h"

/* Network specific functions and defines */
#if APP_TYPE == APP_XOR
#include "networks/snn_network_xor.h"
#endif

/*****************************************************************************/
/*                       	Pipeline II Max-Throughput                       */
/*****************************************************************************/
// MAX_PIPELINE_THROUGHPUT = round_upper(size(w) * NEURONS / AXI_WEIGHTS_THROUGHPUT)
#if PRECISION_TYPE == FIXED_POINT // ~ 25-30 weights/cycle
#if NEURONS_PER_LAYER <= 60
#define MAX_PIPELINE_THROUGHPUT		2
#elif NEURONS_PER_LAYER <= 90
#define MAX_PIPELINE_THROUGHPUT		3
#elif NEURONS_PER_LAYER <= 120
#define MAX_PIPELINE_THROUGHPUT		4
#elif NEURONS_PER_LAYER <= 150
#define MAX_PIPELINE_THROUGHPUT		5
#elif NEURONS_PER_LAYER <= 190
#define MAX_PIPELINE_THROUGHPUT		6
#elif NEURONS_PER_LAYER <= 230
#define MAX_PIPELINE_THROUGHPUT		7
#elif NEURONS_PER_LAYER <= 250
#define MAX_PIPELINE_THROUGHPUT		8
#else
#error Maximum network supported in Fixed-Point mode is NEURONS_PER_LAYER = 250
#endif
#if NEURONS_PER_LAYER <= 60
#define SYNAPSE_PARTITION_FACTOR	25
#else
#define SYNAPSE_PARTITION_FACTOR	30
#endif
#elif PRECISION_TYPE == FLOATING_POINT // ~ 7-8 weights/cycle
#if NEURONS_PER_LAYER <= 50
#define MAX_PIPELINE_THROUGHPUT		7
#elif NEURONS_PER_LAYER <= 60
#define MAX_PIPELINE_THROUGHPUT		8
#elif NEURONS_PER_LAYER <= 70
#define MAX_PIPELINE_THROUGHPUT		9
#elif NEURONS_PER_LAYER <= 80
#define MAX_PIPELINE_THROUGHPUT		10
#elif NEURONS_PER_LAYER <= 90
#define MAX_PIPELINE_THROUGHPUT		12
#elif NEURONS_PER_LAYER <= 100
#define MAX_PIPELINE_THROUGHPUT		13
#elif NEURONS_PER_LAYER <= 110
#define MAX_PIPELINE_THROUGHPUT		14
#elif NEURONS_PER_LAYER <= 120
#define MAX_PIPELINE_THROUGHPUT		15
#elif NEURONS_PER_LAYER <= 130
#define MAX_PIPELINE_THROUGHPUT		17
#elif NEURONS_PER_LAYER <= 140
#define MAX_PIPELINE_THROUGHPUT		18
#elif NEURONS_PER_LAYER <= 150
#define MAX_PIPELINE_THROUGHPUT		19
#elif NEURONS_PER_LAYER <= 160
#define MAX_PIPELINE_THROUGHPUT		20
#elif NEURONS_PER_LAYER <= 170
#define MAX_PIPELINE_THROUGHPUT		22
#elif NEURONS_PER_LAYER <= 180
#define MAX_PIPELINE_THROUGHPUT		23
#elif NEURONS_PER_LAYER <= 190
#define MAX_PIPELINE_THROUGHPUT		24
#elif NEURONS_PER_LAYER <= 200
#define MAX_PIPELINE_THROUGHPUT		25
#else
#error Maximum network supported in Floating-Point mode is NEURONS_PER_LAYER = 200
#endif
#define SYNAPSE_PARTITION_FACTOR	10
#endif


/*****************************************************************************/
/*                        Izhikevich Model Definitions                       */
/*****************************************************************************/
/*
Izhikevich model:
v - membrane potential
u - membrane recovery variable - provides negative feedback to v
I - Synaptic currents - Injected DC currects
a - 0.02 - time scape of recovery variable
b - 0.2 - sensitivity of recovery variable to subthreshold fluctuations of v
c - -65mv - after spike reset value
d - 2.0 - after spike reset of recovery variable

v' = 0.04v^2 + 5v + 140 - u + I    (1)
u' = a(bv - u)  (2)
with the auxiliary after-spike resetting
if v >= 30 mV; then v = c  and u = u + d: (3)

Synaptic Input model
I = sum ( w * s * ( E - v ) )
I - Synaptic currents - Injected DC currects
v - membrane potential
w - synapse connection weight
E - reversal potential - 0 mV for excitatory and -85 mV for inhibitory synapses
s - implements the dynamics of the nth synapse

s' = -s/t
s = s + h, if pre-synaptic neuron spikes

h = 1 - ( 1 + (U - 1) * h ) e ^ - dt * t
U - 0.5
dt - interval between current and previous spike
t - 500ms
*/

// Izhikevich model Parameters
#define IZHIKEVICH_A(neuronType) 		(neuronType) == INHIBITORY_NEURON ? 0.1f : 0.02f // 0.1 inhibitory, 0.02 excitatory
#define IZHIKEVICH_B 					0.2f
#define IZHIKEVICH_C 					-65
#define IZHIKEVICH_D(neuronType) 		(neuronType) == INHIBITORY_NEURON ? 2 : 8 // 2 inhibitory, 8 excitatory

//Decay of synapses ms
#define TAU_S 							10.0f
#define S_DECAY_FACTOR					(1.0f - (SIM_TIMESTEP_MS / TAU_S))
//synaptic depression ms
#define TAU_D 							500.0f
//STP parameter
#define STP_U 							0.5f
//Excitatory synapse potential
#define ES_EXCITATORY					0.0f
//Inhibitory synapse potential
#define ES_INHIBITORY					-85.0f
//Input firing rate Hz
#define FIRING_RATE_IN 					20
//Number of inputs
#define INPUT_SYNAPSES 					NEURONS_PER_LAYER		// must be <= NEURONS_PER_LAYER
//Synaptic input offset for weights matrix
#define INPUT_SYNAPSE_OFFSET			(NUMBER_OF_NEURONS-NEURONS_PER_LAYER)



#endif /* _SNN_DEFS_H_ */
