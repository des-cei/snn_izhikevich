# Izhikevich Spiked Neural Network
This repository automates the workflow to create the hardware platform required to use a spiking neural network (SNN) **hardware accelerator** on the Vitis IDE. The SNN computes neuron firings based on the Izhikevich neuron model, which is more biologically accurate than the commonly used Integrate and Fire (I&F) SNNs. This approach is more computationally intensive, which justifies the creation of this project. 

Thus far, this repository includes execution automation using **.tcl scripts** of Felipe Galindo's Thesis Project, which has been considerably restructured.

## Software Requirements
* **IDE**: This project has been developed and tested to run con *Vitis HLS*, *Vivado* and *Vitis* on the [2023.1](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2023-1.html) and [2022.2](https://www.xilinx.com/support/download/index.html/content/xilinx/en/downloadNav/vivado-design-tools/2022-2.html) [^1] [^2]versions.
* **OS**: The project has been tested on [Ubuntu 22.04 LTS](https://ubuntu.com/download/desktop).
* **Serial Terminal**: The simulation data is accessible via serial terminal. [Minicom](https://help.ubuntu.com/community/Minicom) is is the recommended text based communications program. It runs as intended with the default configuration.
* **JTAG drivers** can be installed by running the `install_drivers` script that is contained inside the Xilinx install directory `Xilinx/Vivado/2023.1/data/xicom/cable_drivers/lin64/install_script/install_drivers`.
* [GTK - 3.0](https://docs.gtk.org/gtk3/) is required to run [Vitis xsct commands](https://docs.xilinx.com/r/en-US/ug1400-vitis-embedded/XSCT-Commands).
* The configuration file for the Bash shell [bashrc](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html) must include as a source the shell script `settings64.sh`, which is inside the Xilinx install directory `Xilinx/Vivado/2023.1`.

[^1]: The `block_design.tcl` file was exported automatically from the Vivado 2023.1 GUI. It performs a Version check that can be eliminated to run it on the 2022.2 version. 

[^2]: If Vitis 2022.2 reports the following error when loading the .elf file `ERROR : Can't read "map": no such variable when trying to launch application on my target`, a workaround has already been published on the [Xilinx forums](https://support.xilinx.com/s/article/000034848?language=en_US).


## Getting started
1. **Board selection:** This repository has been tested with a *xc7z020clg400-1* FPGA. 
    1. To target a different device, please update the `BOARD` variable on the makefile.
    2. Update the `vivado/block_design.tcl` script. It has been exported manually from the Vivado GUI, after adding the `snn_ip` to the IP catalog. In order to only execute the Vitis HLS script to generate the IP, please execute: ```make create_ip```. The exported script will be valid for any future modifications of the automatically generated IP.

2. **Network selection:** Available networks can be found on the `snn_config/networks`. The `config.h` file selects the network that will be run on the by defining the `APP_TYPE`.
3. **Generating the Vitis workspace:** After selecting the board and network, please execute: ```make```. The default target generates the snn IP, exports the hardware and creates a new Vitis workspace inside `Vitis/ws`.
4. **Running the network:** Once the workspace has been created, please execute: ```make open_vitis```. It will automatically open the Vitis IDE on the workspace folder. In order to automate this process, it is possible to access [the Vitis xsct journal](https://support.xilinx.com/s/question/0D52E00006hpPegSAE/show-xsct-commands-in-vitis?language=en_US). Copying the xsct commands used to load the application on the FPGA inside `run_vitis.tcl` will allow the use of ```make run```, which executes the script without accessing the Vitis GUI. 
    
    *This section is being worked on to include a generic run_vitis.tcl script. It would avoid having to update the script manually for different boards.*

5. **Saving the results:** Once minicom is [set up](https://wiki.emacinc.com/wiki/Getting_Started_With_Minicom) with the correct port, `sudo minicom -C capturefile &` will execute it on the background and save the network results on the selected file.


## Project Structure

<pre>
├── Makefile
├── README.md
├── snn_config
│   ├── config.h                          # Selects the SNN that will run and the precision type.
│   ├── networks                          # Network specific defines and functions.
│   └── snn_defs.h                        # Common network defines, includes SNN selected in config.h
├── vitis
│   ├── create_project_vitis.tcl          # Script that adds the Vitis sources and creates workspace.
│   ├── run_vitis.tcl                     # Script that executes the Vitis App on the target board.
│   ├── src                               
│   │   ├── hw
│   │   │   ├── snn_izikevich_hw_zynq.h   # Hardware related functions: DMAs, interrupts...
│   │   │   └── zynq                      # Platform automatically generated drivers
│   │   ├── main_zynq.cpp                 # Program entry point
│   │   └── snn_start.h                   # Main functions of the program: init_network, run_network...
│   └── ws                                # [AUTO-GENERATED] Workspace by create_project_vitis.tcl
├── vitis_hls
│   ├── run_hls.tcl                       # Script that adds the Vitis HLS sources.
│   ├── snn_ip                            # [AUTO-GENERATED] SNN IP in Vivado catalog mode.
│   ├── config.ini                        # [AUTO-GENERATED] Specifies the Vitis HLS project config.
│   └── src
│       ├── snn_izhikevich_axi.h          # Functions used to transmit and receive data.
│       ├── snn_izhikevich.h              # Functions used to run the SNN.
│       ├── snn_izhikevich_top.cpp        # Top functions and memories.
│       └── snn_types.h                   # Type definitions specific to Vitis HLS.
└── vivado
    ├── block_design.tcl                  # Block design exported from the Vivado GUI.
    ├── create_bd.tcl                     # Configures and exports the design defined in block_design.
    ├── synth.tcl                         # Script that synthesizes the exported block design.
    ├── place_and_route.tcl               # Script that places and routes the synthesized design.
    ├── export_hw.tcl                     # Script that exports the design.
    ├── checkpoints                       # [AUTO-GENERATED] Checkpoints for synth, opt,place, ...
    ├── snn_hw.bit                        # [AUTO-GENERATED] Design bitstream.
    ├── snn_hw.xsa                        # [AUTO-GENERATED] Design platform (includes the bitstream).
    └── block_design                      # [AUTO-GENERATED] Block design exported by create_bd.
           
</pre>

## Execution flow
The **Makefile** automates the execution of all the project scripts, which target *Vitis HLS*, *Vivado* and *Vitis*. 

### Vitis HLS
1. The SNN accelerator is designed in Vitis HLS. The *C* or *C++* source files must be copied to the `vitis_hls/src` folder
2. The file `vitis_hls/run_hls.tcl` will read the source code, set up the top function as the one named `hls_snn_izikevich`, configure the technology and clock rate, which by default are a **xc7z020clg400-1** board with a **40ns** clock. The generated IP will be exported in the *ip_catalog* format. The generated IP can be found on `vitis_hls/snn_ip`

*This section is being worked on*