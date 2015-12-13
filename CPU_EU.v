`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 440
// Engineer: Abodunrin Adepoju, Bruno Venegas
// 
// Create Date:    14:29:30 10/16/2011 
// Design Name: 
// Module Name:    CPU_EU 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module CPU_EU(clk, FW_En, FW_Addr, FS_Addr, F_Sel, FP_Op, FR_Addr, FP_Status, W_En, W_Addr, S_Addr, S_Sel, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg, R_Addr, ALU_OP, SOL, SOR, N, Z, C, V, FP1_En, FP0_En,
Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, MAR_En_FP, SP_Dec, SP_Inc, inc_en, WR1_En, WR0_En, IR_En, mem_data_bus, mem_addr_bus, FP0OE, FP1OE, WR1OE, WR0OE, IR_Wire, WR1Sel, WR0Sel, VW_En, VR_Addr, VS_Addr, VW_Addr, VALU_OP, VS_Sel, V_Mode, EX_En, WR_Sel, Int_En, FR_Out, WR0_FR_En, RdBuf0Wire, RdBuf1Wire, MANDA_En, VR1_En, VR0_En, VR1OE, VR0OE);

// Floating Point Datapath    
// **************************************************************
// Inputs
input clk, FW_En, F_Sel;
input [4:0] FW_Addr, FS_Addr, FR_Addr;
input [3:0] FP_Op;

// Outputs
output [5:0] FP_Status;
wire [5:0] FP_Status;

output [31:0] IR_Wire;
wire [31:0] IR_Wire;
// **************************************************************


// Integer Datapath
// **************************************************************
// Inputs
input W_En, Y_Sel;
input [1:0] S_Sel;
input [4:0] R_Addr, S_Addr, W_Addr;
input [4:0] ALU_OP;
input PC_En, Call_En, Ret_En, PC_Reset;
input Jump_En, Jump_Reg;
input SP_Dec, SP_Inc;
input EX_En, WR_Sel;

// Outputs
output N, Z, C, V, SOR, SOL;
wire N, Z, C, V, SOR, SOL;
// **************************************************************

// Vector Datapath
// **************************************************************
// Inputs
input VW_En, VS_Sel;
input [4:0] VR_Addr, VS_Addr, VW_Addr;
input [4:0] VALU_OP;
input [2:0] V_Mode;
input MANDA_En;

input VR1_En, VR0_En, VR1OE, VR0OE;


// BIU
// **************************************************************
// Inputs
input FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, inc_en, WR1_En, WR0_En, IR_En, FP0OE, FP1OE, WR1OE, WR0OE, MAR_En_FP, WR0_FR_En;

input WR1Sel, WR0Sel;

input Int_En;

input [63:0] FR_Out;

// Outputs
output [63:0] mem_addr_bus;
wire [63:0] mem_addr_bus;
inout [31:0] mem_data_bus;
wire [31:0] mem_data_bus;
// **************************************************************


// Connecting Wires
// **************************************************************
wire [63:0] FP_OUT;
wire [63:0] FP_IN;
wire [63:0] REG_OUT, ALU_OUT;
wire [63:0] DS;
wire [63:0] imm_Op;
wire [63:0] PC_Out;
wire [63:0] SP_Out;
wire [63:0] FP_R_OUT;

wire [63:0] VALU_Out;

output [31:0] RdBuf1Wire, RdBuf0Wire;
// **************************************************************


// FloatDP(W_Clk, FW_En, FW_Addr, FS_Addr, Float_In, F_Sel, FP_Op, FR_Addr, Y, FP_Status);
FloatDP FloatDP(clk, FW_En, FW_Addr, FS_Addr, FP_IN, F_Sel, FP_Op, FR_Addr, FP_OUT, FP_Status, FP_R_OUT);

// Integer_Datapath(W_En, W_Clk, W_Addr, S_Addr, DS, S_Sel, DY, Y_Sel, R_Addr, ALU_OP, REG_OUT, ALU_OUT, SOL, SOR, N, Z, C, V);
Integer_Datapath Integer_Datapath(W_En, clk, W_Addr, S_Addr, DS, imm_Op, S_Sel, FP_IN, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg, PC_Out, SP_Dec, SP_Inc, SP_Out, R_Addr, ALU_OP, REG_OUT, ALU_OUT, SOL, SOR, N, Z, C, V, RdBuf1Wire, RdBuf0Wire, EX_En, WR_Sel);

// VectorDP(W_En, W_Clk, W_Addr, R_Addr, S_Addr, ALU_Op);
VectorDP VectorDP(VS_Sel, VW_En, clk, VW_Addr, VR_Addr, VS_Addr, VALU_OP, FP_IN, V_Mode, MANDA_En, VALU_Out);


// biu(clk, FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, IR_En, FP_Out, REG_OUT, ALU_OUT, DS, mem_addr_bus, mem_data_bus, Rd_Buff_Out, FP1OE, FP0OE, WR1OE, WR0OE);
// biu(clk, FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, IR_En, FP_Out, REG_OUT, ALU_OUT, DS, mem_addr_bus, mem_data_bus, Rd_Buff_Out, FP1OE, FP0OE, WR1OE, WR0OE);
biu biu(clk, FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, inc_en, WR1_En, WR0_En, IR_En, FP_OUT, REG_OUT, ALU_OUT, DS, imm_Op, mem_addr_bus, mem_data_bus, FP_IN, FP1OE, FP0OE, WR1OE, WR0OE, IR_Wire, PC_Out, SP_Out, WR1Sel, WR0Sel, RdBuf1Wire, RdBuf0Wire, FP_R_OUT, MAR_En_FP, Int_En, FR_Out, WR0_FR_En, VALU_Out, VR1_En, VR0_En, VR1OE, VR0OE);




endmodule
