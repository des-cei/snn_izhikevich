#ifndef _NETWORK_H_
#define _NETWORK_H_

#include <stdint.h>

extern const uint32_t n_inputs;
extern const uint32_t n_outputs;
extern uint32_t n_per_layer[];
extern const uint32_t n_layers;
extern float weights[];
extern const uint32_t n_weights;
extern float biases[];
extern const uint32_t n_biases;

#endif /* _NETWORK_H_ */