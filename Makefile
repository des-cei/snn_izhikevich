# Configuration
BOARD:= xc7z020clg400-1
ORIGIN_NETWORK = ./snn_config/networks/wineNetwork.pt
ORIGIN_DATA = 	 ./snn_config/databases/wine.data 

# Run scripts
RUN_HLS := vitis_hls
RUN_VIVADO:= vivado -mode batch -nojournal -nolog
RUN_VITIS := xsct
SCRIPT = python3

# Phony targets
.PHONY: create_sources clean_sources clean_hls clean_vivado clean_vitis run_app open_vitis

# Default target
# ===============================================================
all: create_sources create_ip create_platform create_app

# Secondary targets
# ===============================================================
create_sources: snn_config/data.cpp snn_config/network.cpp Makefile 

create_ip: vitis_hls/snn_ip/component.xml 

create_platform: create_bd synth place_and_route export_hw

create_app : vitis/ws/*

# Tertiary targets
# ===============================================================
create_bd: vivado/block_design/block_design.bd

synth: vivado/checkpoints/opt.dcp

place_and_route : vivado/checkpoints/route.dcp

export_hw : vivado/snn_hw.xsa

# Dependencies
# ===============================================================
snn_config/data.cpp: $(ORIGIN_DATA) Makefile
	$(SCRIPT) snn_config/scripts/store_data.py $(ORIGIN_DATA)

snn_config/network.cpp: $(ORIGIN_NETWORK) Makefile
	$(SCRIPT) snn_config/scripts/store_network.py $(ORIGIN_NETWORK)

vitis_hls/snn_ip/component.xml : vitis_hls/src/* snn_config/*
	@echo "part=$(BOARD)" > vitis_hls/config.ini
	@rm -rf vitis_hls/snn_ip
	@$(RUN_HLS) -f vitis_hls/run_hls.tcl
	@unzip vitis_hls/snn_ip/export.zip -d vitis_hls/snn_ip

vivado/block_design/block_design.bd: vivado/create_bd.tcl \
	vitis_hls/snn_ip/component.xml
	@$(RUN_VIVADO) -source vivado/create_bd.tcl -tclargs $(BOARD)

vivado/checkpoints/opt.dcp: vivado/block_design/block_design.bd
	@$(RUN_VIVADO) -source vivado/synth.tcl -tclargs $(BOARD)

vivado/checkpoints/route.dcp: vivado/checkpoints/synth.dcp
	@$(RUN_VIVADO) -source vivado/place_and_route.tcl

vivado/snn_hw.xsa: vivado/checkpoints/route.dcp
	@$(RUN_VIVADO) -source vivado/export_hw.tcl

vitis/ws/*: vitis/src/* vitis/src/hw/* vivado/snn_hw.xsa snn_config/*
	@rm -rf vitis/ws
	@$(RUN_VITIS) vitis/create_project_vitis.tcl


# Delete temporal project files
# ===============================================================
clean : clean_sources clean_hls clean_vivado clean_vitis

clean_sources :
	@rm -f snn_config/data.cpp
	@rm -f snn_config/network.cpp

clean_hls : 
	@rm -f  vitis_hls.log
	@rm -rf vitis_hls/proj/
	@rm -f  vitis_hls/config.ini
	@rm -f  vitis_hls/sources.ini
	@rm -rf vitis_hls/snn_ip

clean_vivado:
	@rm -rf .srcs
	@rm -rf .Xil
	@rm -rf NA
	@rm -rf vivado/checkpoints/opt.dcp
	@rm -rf vivado/checkpoints/place.dcp
	@rm -rf vivado/checkpoints/route.dcp
	@rm -rf vivado/checkpoints/synth.dcp

clean_vitis:
	@rm -rf .Xil
	@rm -f xrc.log
	@rm -rf vitis/ws/