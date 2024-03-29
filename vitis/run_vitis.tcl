# XSDB Script
connect -url tcp:127.0.0.1:3121
targets -set -nocase -filter {name =~"APU*"}
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Xilinx PYNQ-Z1 003017A6DC79A" && level==0 && jtag_device_ctx=="jsn-Xilinx PYNQ-Z1-003017A6DC79A-23727093-0"}
fpga -file vitis/ws/snn_izhikevich_app/_ide/bitstream/snn_hw.bit
targets -set -nocase -filter {name =~"APU*"}
loadhw -hw vitis/ws/snn_izhikevich_pl/export/snn_izhikevich_pl/hw/snn_hw.xsa -mem-ranges [list {0x40000000 0xbfffffff}] -regs
configparams force-mem-access 1
targets -set -nocase -filter {name =~"APU*"}
source vitis/ws/snn_izhikevich_app/_ide/psinit/ps7_init.tcl
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "*A9*#0"}
dow vitis/ws/snn_izhikevich_app/Debug/snn_izhikevich_app.elf
configparams force-mem-access 0

# Connect
con
