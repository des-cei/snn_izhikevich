// ==============================================================
// Generated by Vitis HLS v2023.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module hls_snn_izikevich_hls_snn_izikevich_Pipeline_VITIS_LOOP_15_2 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        input_stream0_TVALID,
        input_stream0_TDATA,
        input_stream0_TREADY,
        input_stream0_TKEEP,
        input_stream0_TSTRB,
        input_stream0_TLAST,
        neuron_type_mem_0_i,
        neuron_type_mem_0_o,
        neuron_type_mem_0_o_ap_vld,
        neuron_type_mem_1_i,
        neuron_type_mem_1_o,
        neuron_type_mem_1_o_ap_vld
);

parameter    ap_ST_fsm_pp0_stage0 = 2'd1;
parameter    ap_ST_fsm_pp0_stage1 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input   input_stream0_TVALID;
input  [63:0] input_stream0_TDATA;
output   input_stream0_TREADY;
input  [7:0] input_stream0_TKEEP;
input  [7:0] input_stream0_TSTRB;
input  [0:0] input_stream0_TLAST;
input  [5:0] neuron_type_mem_0_i;
output  [5:0] neuron_type_mem_0_o;
output   neuron_type_mem_0_o_ap_vld;
input  [5:0] neuron_type_mem_1_i;
output  [5:0] neuron_type_mem_1_o;
output   neuron_type_mem_1_o_ap_vld;

reg ap_idle;
reg input_stream0_TREADY;
reg[5:0] neuron_type_mem_0_o;
reg neuron_type_mem_0_o_ap_vld;
reg[5:0] neuron_type_mem_1_o;
reg neuron_type_mem_1_o_ap_vld;

(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
reg    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
wire    ap_CS_fsm_pp0_stage1;
reg   [0:0] icmp_ln15_reg_301;
reg   [0:0] icmp_ln19_reg_305;
reg    ap_predicate_op23_read_state2;
reg    ap_block_state2_pp0_stage1_iter0;
reg    ap_block_pp0_stage1_subdone;
reg    ap_condition_exit_pp0_iter0_stage1;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    input_stream0_TDATA_blk_n;
wire    ap_block_pp0_stage1;
reg   [6:0] b_1_reg_295;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state3_pp0_stage0_iter1;
wire    ap_block_pp0_stage0_11001;
wire   [0:0] icmp_ln15_fu_110_p2;
wire   [0:0] icmp_ln19_fu_116_p2;
reg   [31:0] l_2_reg_309;
reg    ap_block_pp0_stage1_11001;
wire   [0:0] icmp_ln25_fu_149_p2;
reg   [0:0] icmp_ln25_reg_316;
reg    ap_enable_reg_pp0_iter0_reg;
wire    ap_block_pp0_stage0_subdone;
reg   [5:0] tmp_18_fu_200_p4;
wire    ap_block_pp0_stage0;
wire   [0:0] trunc_ln26_fu_181_p1;
reg   [31:0] y_1_fu_64;
wire   [31:0] y_fu_242_p3;
wire    ap_loop_init;
reg   [31:0] l_1_fu_68;
wire   [31:0] l_fu_250_p3;
reg   [6:0] b_fu_72;
wire   [6:0] add_ln15_fu_125_p2;
reg   [6:0] ap_sig_allocacmp_b_1;
reg   [63:0] bits_fu_76;
wire   [30:0] tmp_fu_139_p4;
wire   [63:0] zext_ln15_fu_160_p1;
wire   [5:0] select_ln26_fu_192_p3;
wire   [63:0] zext_ln26_fu_177_p1;
wire   [0:0] bit_select_i_i_i_i_i_fu_169_p3;
wire   [0:0] icmp_ln29_fu_225_p2;
wire   [31:0] y_2_fu_231_p2;
wire   [31:0] l_3_fu_237_p2;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [1:0] ap_NS_fsm;
reg    ap_idle_pp0_1to1;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 2'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter0_reg = 1'b0;
#0 ap_done_reg = 1'b0;
end

hls_snn_izikevich_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage1),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_loop_exit_ready == 1'b1) & (1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter0_reg <= 1'b0;
    end else begin
        if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
            ap_enable_reg_pp0_iter0_reg <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if (((1'b1 == ap_condition_exit_pp0_iter0_stage1) | ((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0)))) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
            ap_enable_reg_pp0_iter1 <= ap_enable_reg_pp0_iter0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        b_fu_72 <= 7'd0;
    end else if (((1'b0 == ap_block_pp0_stage1_11001) & (icmp_ln15_reg_301 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        b_fu_72 <= add_ln15_fu_125_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if ((ap_loop_init == 1'b1)) begin
            l_1_fu_68 <= 32'd0;
        end else if ((ap_enable_reg_pp0_iter1 == 1'b1)) begin
            l_1_fu_68 <= l_fu_250_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if ((ap_loop_init == 1'b1)) begin
            y_1_fu_64 <= 32'd0;
        end else if ((ap_enable_reg_pp0_iter1 == 1'b1)) begin
            y_1_fu_64 <= y_fu_242_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        b_1_reg_295 <= ap_sig_allocacmp_b_1;
        icmp_ln15_reg_301 <= icmp_ln15_fu_110_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (icmp_ln19_reg_305 == 1'd1) & (icmp_ln15_reg_301 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        bits_fu_76 <= input_stream0_TDATA;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln15_fu_110_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        icmp_ln19_reg_305 <= icmp_ln19_fu_116_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (icmp_ln15_reg_301 == 1'd0) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        icmp_ln25_reg_316 <= icmp_ln25_fu_149_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        l_2_reg_309 <= l_1_fu_68;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_subdone) & (icmp_ln15_reg_301 == 1'd1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_condition_exit_pp0_iter0_stage1 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage1 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_exit_ready == 1'b1) & (1'b0 == ap_block_pp0_stage1_subdone) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_pp0_stage0)) begin
        ap_enable_reg_pp0_iter0 = ap_start_int;
    end else begin
        ap_enable_reg_pp0_iter0 = ap_enable_reg_pp0_iter0_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (ap_start_int == 1'b0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if ((ap_enable_reg_pp0_iter1 == 1'b0)) begin
        ap_idle_pp0_1to1 = 1'b1;
    end else begin
        ap_idle_pp0_1to1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_b_1 = 7'd0;
    end else begin
        ap_sig_allocacmp_b_1 = b_fu_72;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1) & (ap_predicate_op23_read_state2 == 1'b1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        input_stream0_TDATA_blk_n = input_stream0_TVALID;
    end else begin
        input_stream0_TDATA_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage1_11001) & (ap_predicate_op23_read_state2 == 1'b1) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage1))) begin
        input_stream0_TREADY = 1'b1;
    end else begin
        input_stream0_TREADY = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln25_reg_316 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln26_fu_181_p1 == 1'd0))) begin
        neuron_type_mem_0_o = tmp_18_fu_200_p4;
    end else begin
        neuron_type_mem_0_o = neuron_type_mem_0_i;
    end
end

always @ (*) begin
    if (((icmp_ln25_reg_316 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln26_fu_181_p1 == 1'd0))) begin
        neuron_type_mem_0_o_ap_vld = 1'b1;
    end else begin
        neuron_type_mem_0_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    if (((icmp_ln25_reg_316 == 1'd1) & (1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln26_fu_181_p1 == 1'd1))) begin
        neuron_type_mem_1_o = tmp_18_fu_200_p4;
    end else begin
        neuron_type_mem_1_o = neuron_type_mem_1_i;
    end
end

always @ (*) begin
    if (((icmp_ln25_reg_316 == 1'd1) & (1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (trunc_ln26_fu_181_p1 == 1'd1))) begin
        neuron_type_mem_1_o_ap_vld = 1'b1;
    end else begin
        neuron_type_mem_1_o_ap_vld = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            if ((~((ap_start_int == 1'b0) & (ap_idle_pp0_1to1 == 1'b1)) & (1'b0 == ap_block_pp0_stage0_subdone))) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end
        end
        ap_ST_fsm_pp0_stage1 : begin
            if ((1'b0 == ap_block_pp0_stage1_subdone)) begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage0;
            end else begin
                ap_NS_fsm = ap_ST_fsm_pp0_stage1;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln15_fu_125_p2 = (b_1_reg_295 + 7'd1);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_pp0_stage1 = ap_CS_fsm[32'd1];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage1 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage1_11001 = ((ap_predicate_op23_read_state2 == 1'b1) & (input_stream0_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

always @ (*) begin
    ap_block_pp0_stage1_subdone = ((ap_predicate_op23_read_state2 == 1'b1) & (input_stream0_TVALID == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b1));
end

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_state2_pp0_stage1_iter0 = ((ap_predicate_op23_read_state2 == 1'b1) & (input_stream0_TVALID == 1'b0));
end

assign ap_block_state3_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage1;

always @ (*) begin
    ap_predicate_op23_read_state2 = ((icmp_ln19_reg_305 == 1'd1) & (icmp_ln15_reg_301 == 1'd0));
end

assign bit_select_i_i_i_i_i_fu_169_p3 = bits_fu_76[zext_ln15_fu_160_p1];

assign icmp_ln15_fu_110_p2 = ((ap_sig_allocacmp_b_1 == 7'd64) ? 1'b1 : 1'b0);

assign icmp_ln19_fu_116_p2 = ((ap_sig_allocacmp_b_1 == 7'd0) ? 1'b1 : 1'b0);

assign icmp_ln25_fu_149_p2 = (($signed(tmp_fu_139_p4) < $signed(31'd1)) ? 1'b1 : 1'b0);

assign icmp_ln29_fu_225_p2 = (($signed(y_1_fu_64) < $signed(32'd5)) ? 1'b1 : 1'b0);

assign l_3_fu_237_p2 = (l_2_reg_309 + 32'd1);

assign l_fu_250_p3 = ((icmp_ln29_fu_225_p2[0:0] == 1'b1) ? l_2_reg_309 : l_3_fu_237_p2);

assign select_ln26_fu_192_p3 = ((trunc_ln26_fu_181_p1[0:0] == 1'b1) ? neuron_type_mem_1_i : neuron_type_mem_0_i);

always @ (*) begin
    tmp_18_fu_200_p4 = select_ln26_fu_192_p3;
    tmp_18_fu_200_p4[zext_ln26_fu_177_p1] = |(bit_select_i_i_i_i_i_fu_169_p3);
end

assign tmp_fu_139_p4 = {{l_1_fu_68[31:1]}};

assign trunc_ln26_fu_181_p1 = l_2_reg_309[0:0];

assign y_2_fu_231_p2 = (y_1_fu_64 + 32'd1);

assign y_fu_242_p3 = ((icmp_ln29_fu_225_p2[0:0] == 1'b1) ? y_2_fu_231_p2 : 32'd0);

assign zext_ln15_fu_160_p1 = b_1_reg_295;

assign zext_ln26_fu_177_p1 = y_1_fu_64;

endmodule //hls_snn_izikevich_hls_snn_izikevich_Pipeline_VITIS_LOOP_15_2