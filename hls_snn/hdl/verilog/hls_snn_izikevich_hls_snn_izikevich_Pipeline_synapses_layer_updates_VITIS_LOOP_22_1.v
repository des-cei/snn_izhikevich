// ==============================================================
// Generated by Vitis HLS v2023.1
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module hls_snn_izikevich_hls_snn_izikevich_Pipeline_synapses_layer_updates_VITIS_LOOP_22_1 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        synapse_s_mem_address0,
        synapse_s_mem_ce0,
        synapse_s_mem_we0,
        synapse_s_mem_d0,
        synapse_s_mem_address1,
        synapse_s_mem_ce1,
        synapse_s_mem_q1,
        v_mem_address0,
        v_mem_ce0,
        v_mem_q0,
        p_mem_address0,
        p_mem_ce0,
        p_mem_q0,
        grp_fu_537_p_din0,
        grp_fu_537_p_din1,
        grp_fu_537_p_opcode,
        grp_fu_537_p_dout0,
        grp_fu_537_p_ce,
        grp_fu_541_p_din0,
        grp_fu_541_p_din1,
        grp_fu_541_p_dout0,
        grp_fu_541_p_ce
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [3:0] synapse_s_mem_address0;
output   synapse_s_mem_ce0;
output   synapse_s_mem_we0;
output  [31:0] synapse_s_mem_d0;
output  [3:0] synapse_s_mem_address1;
output   synapse_s_mem_ce1;
input  [31:0] synapse_s_mem_q1;
output  [3:0] v_mem_address0;
output   v_mem_ce0;
input  [31:0] v_mem_q0;
output  [2:0] p_mem_address0;
output   p_mem_ce0;
input  [0:0] p_mem_q0;
output  [31:0] grp_fu_537_p_din0;
output  [31:0] grp_fu_537_p_din1;
output  [0:0] grp_fu_537_p_opcode;
input  [31:0] grp_fu_537_p_dout0;
output   grp_fu_537_p_ce;
output  [31:0] grp_fu_541_p_din0;
output  [31:0] grp_fu_541_p_din1;
input  [31:0] grp_fu_541_p_dout0;
output   grp_fu_541_p_ce;

reg ap_idle;
reg synapse_s_mem_ce0;
reg synapse_s_mem_we0;
reg synapse_s_mem_ce1;
reg v_mem_ce0;
reg p_mem_ce0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_enable_reg_pp0_iter2;
reg    ap_enable_reg_pp0_iter3;
reg    ap_enable_reg_pp0_iter4;
reg    ap_idle_pp0;
wire    ap_block_state1_pp0_stage0_iter0;
wire    ap_block_state2_pp0_stage0_iter1;
wire    ap_block_state3_pp0_stage0_iter2;
wire    ap_block_state4_pp0_stage0_iter3;
wire    ap_block_state5_pp0_stage0_iter4;
wire    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln22_fu_178_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
wire    ap_block_pp0_stage0_11001;
reg   [1:0] l_load_reg_497;
reg   [1:0] l_load_reg_497_pp0_iter1_reg;
reg   [1:0] l_load_reg_497_pp0_iter2_reg;
wire   [0:0] icmp_ln22_1_fu_202_p2;
reg   [0:0] icmp_ln22_1_reg_503;
reg   [0:0] icmp_ln22_1_reg_503_pp0_iter1_reg;
reg   [0:0] icmp_ln22_1_reg_503_pp0_iter2_reg;
reg   [0:0] icmp_ln22_1_reg_503_pp0_iter3_reg;
wire   [0:0] cmp6_i_i_i_mid1_fu_254_p2;
reg   [0:0] cmp6_i_i_i_mid1_reg_511;
reg   [0:0] cmp6_i_i_i_mid1_reg_511_pp0_iter1_reg;
reg   [0:0] cmp6_i_i_i_mid1_reg_511_pp0_iter2_reg;
reg   [3:0] synapse_s_mem_addr_reg_516;
reg   [3:0] synapse_s_mem_addr_reg_516_pp0_iter1_reg;
reg   [3:0] synapse_s_mem_addr_reg_516_pp0_iter2_reg;
reg   [3:0] synapse_s_mem_addr_reg_516_pp0_iter3_reg;
wire   [2:0] trunc_ln22_fu_327_p1;
reg   [2:0] trunc_ln22_reg_527;
reg   [31:0] new_synapse_reg_532;
reg   [31:0] new_synapse_reg_532_pp0_iter3_reg;
wire   [0:0] cmp6_i_i_i5_fu_347_p2;
reg   [0:0] cmp6_i_i_i5_reg_543;
wire   [0:0] cmp14_i_i_i3_fu_358_p2;
reg   [0:0] cmp14_i_i_i3_reg_548;
wire   [0:0] and_ln28_1_fu_415_p2;
reg   [0:0] and_ln28_1_reg_558;
wire   [63:0] zext_ln25_2_fu_270_p1;
wire    ap_block_pp0_stage0;
wire   [63:0] zext_ln22_fu_322_p1;
wire   [63:0] zext_ln30_fu_410_p1;
reg   [3:0] x_fu_70;
wire   [3:0] add_ln22_3_fu_331_p2;
wire    ap_loop_init;
reg   [2:0] xl_fu_74;
wire   [2:0] add_ln22_2_fu_275_p2;
reg   [2:0] ap_sig_allocacmp_xl_load;
reg   [3:0] x_1_fu_78;
wire   [3:0] select_ln22_5_fu_315_p3;
reg   [1:0] l_fu_82;
wire   [1:0] select_ln22_2_fu_216_p3;
reg   [1:0] ap_sig_allocacmp_l_load;
reg   [3:0] indvar_flatten_fu_86;
wire   [3:0] add_ln22_4_fu_184_p2;
reg   [3:0] ap_sig_allocacmp_indvar_flatten_load;
wire   [1:0] add_ln22_fu_196_p2;
wire   [0:0] trunc_ln25_fu_224_p1;
wire   [2:0] tmp_1_fu_236_p3;
wire   [3:0] tmp_s_fu_228_p3;
wire   [3:0] zext_ln25_fu_244_p1;
wire   [2:0] select_ln22_fu_208_p3;
wire   [3:0] sub_ln25_fu_248_p2;
wire   [3:0] zext_ln25_1_fu_260_p1;
wire   [3:0] add_ln25_fu_264_p2;
wire   [3:0] add_ln22_1_fu_302_p2;
wire   [3:0] select_ln22_1_fu_308_p3;
wire   [31:0] bitcast_ln28_fu_363_p1;
wire   [7:0] tmp_8_fu_367_p4;
wire   [22:0] trunc_ln28_fu_377_p1;
wire   [0:0] icmp_ln28_1_fu_387_p2;
wire   [0:0] icmp_ln28_fu_381_p2;
wire   [0:0] or_ln28_fu_393_p2;
wire   [0:0] tmp_9_fu_144_p2;
wire   [2:0] add_ln30_fu_405_p2;
wire   [0:0] select_ln22_3_fu_352_p3;
wire   [0:0] and_ln28_fu_399_p2;
wire   [0:0] select_ln22_4_fu_421_p3;
wire   [0:0] xor_ln28_fu_432_p2;
wire   [0:0] and_ln28_2_fu_437_p2;
wire   [0:0] and_ln28_3_fu_443_p2;
wire   [31:0] select_ln28_fu_426_p3;
wire    ap_block_pp0_stage0_00001;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg    ap_loop_exit_ready_pp0_iter1_reg;
reg    ap_loop_exit_ready_pp0_iter2_reg;
reg    ap_loop_exit_ready_pp0_iter3_reg;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 ap_enable_reg_pp0_iter2 = 1'b0;
#0 ap_enable_reg_pp0_iter3 = 1'b0;
#0 ap_enable_reg_pp0_iter4 = 1'b0;
#0 ap_done_reg = 1'b0;
end

hls_snn_izikevich_fcmp_32ns_32ns_1_1_no_dsp_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .din0_WIDTH( 32 ),
    .din1_WIDTH( 32 ),
    .dout_WIDTH( 1 ))
fcmp_32ns_32ns_1_1_no_dsp_1_U16(
    .din0(v_mem_q0),
    .din1(32'd1108082688),
    .opcode(5'd3),
    .dout(tmp_9_fu_144_p2)
);

hls_snn_izikevich_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
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
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter3_reg == 1'b1))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter2 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter2 <= ap_enable_reg_pp0_iter1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter3 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter3 <= ap_enable_reg_pp0_iter2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter4 <= 1'b0;
    end else begin
        if ((1'b0 == ap_block_pp0_stage0_subdone)) begin
            ap_enable_reg_pp0_iter4 <= ap_enable_reg_pp0_iter3;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln22_fu_178_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten_fu_86 <= add_ln22_4_fu_184_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten_fu_86 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln22_fu_178_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            l_fu_82 <= select_ln22_2_fu_216_p3;
        end else if ((ap_loop_init == 1'b1)) begin
            l_fu_82 <= 2'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
            x_1_fu_78 <= 4'd0;
        end else if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
            x_1_fu_78 <= select_ln22_5_fu_315_p3;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        if (((1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
            x_fu_70 <= 4'd0;
        end else if ((ap_enable_reg_pp0_iter2 == 1'b1)) begin
            x_fu_70 <= add_ln22_3_fu_331_p2;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln22_fu_178_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            xl_fu_74 <= add_ln22_2_fu_275_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            xl_fu_74 <= 3'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if ((1'b0 == ap_block_pp0_stage0_11001)) begin
        and_ln28_1_reg_558 <= and_ln28_1_fu_415_p2;
        ap_loop_exit_ready_pp0_iter3_reg <= ap_loop_exit_ready_pp0_iter2_reg;
        cmp6_i_i_i5_reg_543 <= cmp6_i_i_i5_fu_347_p2;
        cmp6_i_i_i_mid1_reg_511_pp0_iter2_reg <= cmp6_i_i_i_mid1_reg_511_pp0_iter1_reg;
        icmp_ln22_1_reg_503_pp0_iter2_reg <= icmp_ln22_1_reg_503_pp0_iter1_reg;
        icmp_ln22_1_reg_503_pp0_iter3_reg <= icmp_ln22_1_reg_503_pp0_iter2_reg;
        l_load_reg_497_pp0_iter2_reg <= l_load_reg_497_pp0_iter1_reg;
        new_synapse_reg_532 <= grp_fu_541_p_dout0;
        new_synapse_reg_532_pp0_iter3_reg <= new_synapse_reg_532;
        synapse_s_mem_addr_reg_516_pp0_iter2_reg <= synapse_s_mem_addr_reg_516_pp0_iter1_reg;
        synapse_s_mem_addr_reg_516_pp0_iter3_reg <= synapse_s_mem_addr_reg_516_pp0_iter2_reg;
        trunc_ln22_reg_527 <= trunc_ln22_fu_327_p1;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_loop_exit_ready_pp0_iter1_reg <= ap_loop_exit_ready;
        ap_loop_exit_ready_pp0_iter2_reg <= ap_loop_exit_ready_pp0_iter1_reg;
        cmp6_i_i_i_mid1_reg_511_pp0_iter1_reg <= cmp6_i_i_i_mid1_reg_511;
        icmp_ln22_1_reg_503_pp0_iter1_reg <= icmp_ln22_1_reg_503;
        l_load_reg_497_pp0_iter1_reg <= l_load_reg_497;
        synapse_s_mem_addr_reg_516_pp0_iter1_reg <= synapse_s_mem_addr_reg_516;
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (icmp_ln22_1_reg_503_pp0_iter2_reg == 1'd0))) begin
        cmp14_i_i_i3_reg_548 <= cmp14_i_i_i3_fu_358_p2;
    end
end

always @ (posedge ap_clk) begin
    if (((icmp_ln22_fu_178_p2 == 1'd0) & (1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        cmp6_i_i_i_mid1_reg_511 <= cmp6_i_i_i_mid1_fu_254_p2;
        icmp_ln22_1_reg_503 <= icmp_ln22_1_fu_202_p2;
        l_load_reg_497 <= ap_sig_allocacmp_l_load;
        synapse_s_mem_addr_reg_516 <= zext_ln25_2_fu_270_p1;
    end
end

always @ (*) begin
    if (((icmp_ln22_fu_178_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_loop_exit_ready_pp0_iter3_reg == 1'b1))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter4 == 1'b0) & (ap_enable_reg_pp0_iter3 == 1'b0) & (ap_enable_reg_pp0_iter2 == 1'b0) & (ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_indvar_flatten_load = 4'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten_load = indvar_flatten_fu_86;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_l_load = 2'd0;
    end else begin
        ap_sig_allocacmp_l_load = l_fu_82;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_loop_init == 1'b1))) begin
        ap_sig_allocacmp_xl_load = 3'd0;
    end else begin
        ap_sig_allocacmp_xl_load = xl_fu_74;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter3 == 1'b1))) begin
        p_mem_ce0 = 1'b1;
    end else begin
        p_mem_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1))) begin
        synapse_s_mem_ce0 = 1'b1;
    end else begin
        synapse_s_mem_ce0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        synapse_s_mem_ce1 = 1'b1;
    end else begin
        synapse_s_mem_ce1 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter4 == 1'b1))) begin
        synapse_s_mem_we0 = 1'b1;
    end else begin
        synapse_s_mem_we0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter2 == 1'b1))) begin
        v_mem_ce0 = 1'b1;
    end else begin
        v_mem_ce0 = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign add_ln22_1_fu_302_p2 = (x_1_fu_78 + 4'd6);

assign add_ln22_2_fu_275_p2 = (select_ln22_fu_208_p3 + 3'd1);

assign add_ln22_3_fu_331_p2 = (select_ln22_1_fu_308_p3 + 4'd1);

assign add_ln22_4_fu_184_p2 = (ap_sig_allocacmp_indvar_flatten_load + 4'd1);

assign add_ln22_fu_196_p2 = (ap_sig_allocacmp_l_load + 2'd1);

assign add_ln25_fu_264_p2 = (sub_ln25_fu_248_p2 + zext_ln25_1_fu_260_p1);

assign add_ln30_fu_405_p2 = (trunc_ln22_reg_527 + 3'd2);

assign and_ln28_1_fu_415_p2 = (select_ln22_3_fu_352_p3 & and_ln28_fu_399_p2);

assign and_ln28_2_fu_437_p2 = (xor_ln28_fu_432_p2 & select_ln22_4_fu_421_p3);

assign and_ln28_3_fu_443_p2 = (p_mem_q0 & and_ln28_2_fu_437_p2);

assign and_ln28_fu_399_p2 = (tmp_9_fu_144_p2 & or_ln28_fu_393_p2);

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_00001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_11001 = ~(1'b1 == 1'b1);

assign ap_block_pp0_stage0_subdone = ~(1'b1 == 1'b1);

assign ap_block_state1_pp0_stage0_iter0 = ~(1'b1 == 1'b1);

assign ap_block_state2_pp0_stage0_iter1 = ~(1'b1 == 1'b1);

assign ap_block_state3_pp0_stage0_iter2 = ~(1'b1 == 1'b1);

assign ap_block_state4_pp0_stage0_iter3 = ~(1'b1 == 1'b1);

assign ap_block_state5_pp0_stage0_iter4 = ~(1'b1 == 1'b1);

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign bitcast_ln28_fu_363_p1 = v_mem_q0;

assign cmp14_i_i_i3_fu_358_p2 = ((l_load_reg_497_pp0_iter2_reg == 2'd1) ? 1'b1 : 1'b0);

assign cmp6_i_i_i5_fu_347_p2 = ((l_load_reg_497_pp0_iter2_reg == 2'd0) ? 1'b1 : 1'b0);

assign cmp6_i_i_i_mid1_fu_254_p2 = ((add_ln22_fu_196_p2 == 2'd0) ? 1'b1 : 1'b0);

assign grp_fu_537_p_ce = 1'b1;

assign grp_fu_537_p_din0 = new_synapse_reg_532;

assign grp_fu_537_p_din1 = 32'd1065353216;

assign grp_fu_537_p_opcode = 2'd0;

assign grp_fu_541_p_ce = 1'b1;

assign grp_fu_541_p_din0 = synapse_s_mem_q1;

assign grp_fu_541_p_din1 = 32'd1063675494;

assign icmp_ln22_1_fu_202_p2 = ((ap_sig_allocacmp_xl_load == 3'd6) ? 1'b1 : 1'b0);

assign icmp_ln22_fu_178_p2 = ((ap_sig_allocacmp_indvar_flatten_load == 4'd12) ? 1'b1 : 1'b0);

assign icmp_ln28_1_fu_387_p2 = ((trunc_ln28_fu_377_p1 == 23'd0) ? 1'b1 : 1'b0);

assign icmp_ln28_fu_381_p2 = ((tmp_8_fu_367_p4 != 8'd255) ? 1'b1 : 1'b0);

assign or_ln28_fu_393_p2 = (icmp_ln28_fu_381_p2 | icmp_ln28_1_fu_387_p2);

assign p_mem_address0 = zext_ln30_fu_410_p1;

assign select_ln22_1_fu_308_p3 = ((icmp_ln22_1_reg_503_pp0_iter1_reg[0:0] == 1'b1) ? add_ln22_1_fu_302_p2 : x_fu_70);

assign select_ln22_2_fu_216_p3 = ((icmp_ln22_1_fu_202_p2[0:0] == 1'b1) ? add_ln22_fu_196_p2 : ap_sig_allocacmp_l_load);

assign select_ln22_3_fu_352_p3 = ((icmp_ln22_1_reg_503_pp0_iter2_reg[0:0] == 1'b1) ? cmp6_i_i_i_mid1_reg_511_pp0_iter2_reg : cmp6_i_i_i5_fu_347_p2);

assign select_ln22_4_fu_421_p3 = ((icmp_ln22_1_reg_503_pp0_iter3_reg[0:0] == 1'b1) ? cmp6_i_i_i5_reg_543 : cmp14_i_i_i3_reg_548);

assign select_ln22_5_fu_315_p3 = ((icmp_ln22_1_reg_503_pp0_iter1_reg[0:0] == 1'b1) ? add_ln22_1_fu_302_p2 : x_1_fu_78);

assign select_ln22_fu_208_p3 = ((icmp_ln22_1_fu_202_p2[0:0] == 1'b1) ? 3'd0 : ap_sig_allocacmp_xl_load);

assign select_ln28_fu_426_p3 = ((and_ln28_1_reg_558[0:0] == 1'b1) ? grp_fu_537_p_dout0 : new_synapse_reg_532_pp0_iter3_reg);

assign sub_ln25_fu_248_p2 = (tmp_s_fu_228_p3 - zext_ln25_fu_244_p1);

assign synapse_s_mem_address0 = synapse_s_mem_addr_reg_516_pp0_iter3_reg;

assign synapse_s_mem_address1 = zext_ln25_2_fu_270_p1;

assign synapse_s_mem_d0 = ((and_ln28_3_fu_443_p2[0:0] == 1'b1) ? grp_fu_537_p_dout0 : select_ln28_fu_426_p3);

assign tmp_1_fu_236_p3 = {{select_ln22_2_fu_216_p3}, {1'd0}};

assign tmp_8_fu_367_p4 = {{bitcast_ln28_fu_363_p1[30:23]}};

assign tmp_s_fu_228_p3 = {{trunc_ln25_fu_224_p1}, {3'd0}};

assign trunc_ln22_fu_327_p1 = select_ln22_1_fu_308_p3[2:0];

assign trunc_ln25_fu_224_p1 = select_ln22_2_fu_216_p3[0:0];

assign trunc_ln28_fu_377_p1 = bitcast_ln28_fu_363_p1[22:0];

assign v_mem_address0 = zext_ln22_fu_322_p1;

assign xor_ln28_fu_432_p2 = (1'd1 ^ and_ln28_1_reg_558);

assign zext_ln22_fu_322_p1 = select_ln22_1_fu_308_p3;

assign zext_ln25_1_fu_260_p1 = select_ln22_fu_208_p3;

assign zext_ln25_2_fu_270_p1 = add_ln25_fu_264_p2;

assign zext_ln25_fu_244_p1 = tmp_1_fu_236_p3;

assign zext_ln30_fu_410_p1 = add_ln30_fu_405_p2;

endmodule //hls_snn_izikevich_hls_snn_izikevich_Pipeline_synapses_layer_updates_VITIS_LOOP_22_1
