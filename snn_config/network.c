#include "network.h"
const uint32_t n_inputs = 4;
const uint32_t n_outputs = 3;
uint32_t n_per_layer [] = {16, 3};
const uint32_t n_layers = 2;
float weights [] = {
	 0.69816952943801880,  0.63734722137451172, -0.39521703124046326, -0.88337951898574829, 
	 0.07714723050594330,  0.01574878767132759, -0.62947291135787964, -0.30766165256500244, 
	 0.56619447469711304, -0.00200790585950017,  0.53663992881774902,  0.64175510406494141, 
	 0.41176313161849976, -0.26623558998107910, -0.62263977527618408, -0.22327494621276855, 
	 0.15119557082653046,  1.18817222118377686, -0.38737633824348450, -0.74825274944305420, 
	 0.30310085415840149,  0.84899795055389404, -0.81558179855346680, -0.08490812778472900, 
	 0.11302136629819870, -0.45700308680534363,  0.15099051594734192, -0.36386486887931824, 
	-0.58307653665542603,  1.02729523181915283, -1.22331023216247559, -1.11628711223602295, 
	 0.45770537853240967, -0.36077663302421570,  0.64537501335144043,  0.15901891887187958, 
	-0.08232245594263077, -0.12813647091388702,  1.48289108276367188,  0.93435937166213989, 
	-0.27312985062599182,  0.73999059200286865, -1.67825293540954590, -1.45328140258789062, 
	 0.12065308541059494, -0.62214112281799316,  0.61895447969436646,  1.11731994152069092, 
	 0.09770596027374268, -0.22052989900112152,  0.97758382558822632,  0.65132462978363037, 
	 0.50593400001525879, -0.56687521934509277,  0.68821978569030762,  0.47295728325843811, 
	 0.55800604820251465,  0.32019087672233582, -0.43979761004447937, -0.92903482913970947, 
	 1.08560299873352051, -0.47780945897102356,  1.12982463836669922,  0.95935291051864624, 
	 1.56482672691345215,  0.29331478476524353, -0.69955474138259888,  0.45928168296813965, 
	 7.59997367858886719,  0.43034327030181885, -0.16938020288944244,  0.64292687177658081, 
	-1.25824940204620361, -4.49874258041381836,  0.82924830913543701, -0.81451588869094849, 
	-0.36981207132339478, -0.78015637397766113,  0.53707617521286011, -1.94433546066284180, 
	 0.89155280590057373,  1.00718724727630615, -0.83898741006851196,  0.45291092991828918, 
	-2.19067335128784180,  0.18637846410274506, -0.03313286229968071, -2.17024946212768555, 
	 0.17393080890178680, -1.54382991790771484, -2.63998818397521973, -0.29022225737571716, 
	-0.99983447790145874, -0.20577397942543030,  1.13037562370300293,  0.63492721319198608, 
	-1.30437839031219482, -1.39024186134338379,  0.75291723012924194, -1.06744098663330078, 
	-1.31223285198211670, -0.51145929098129272, -0.05022496357560158, -0.98204684257507324, 
	 0.38041338324546814,  1.47786951065063477, -0.96122813224792480,  0.81134819984436035, 
	 0.85232478380203247,  0.34476995468139648, -1.42148435115814209,  0.23278926312923431};
const uint32_t n_weights = 112;
float biases [] = {
	 0.86179894208908081,  1.06984353065490723, -0.53844094276428223,  0.61173886060714722, 
	 0.08822303265333176,  0.54639148712158203,  0.09196487069129944,  0.96324640512466431, 
	 0.44946017861366272, -0.82914310693740845,  1.19378554821014404, -0.18078321218490601, 
	-0.46224856376647949,  0.11873497813940048,  1.15900862216949463,  0.24390678107738495, 
	 0.44378954172134399,  0.48497578501701355,  0.19317300617694855};
const uint32_t n_biases = 19;