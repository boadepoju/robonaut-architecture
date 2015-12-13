`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:04:57 10/24/2011 
// Design Name: 
// Module Name:    Lab6Top 
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
module Robonaut_Architecture(clk, reset, Flag_N_Sel, Flag_C_Sel, Flag_Z_Sel, Flag_V_Sel);

// Global Inputs
input clk, reset;   

// Output
output [2:0] Flag_N_Sel, Flag_C_Sel, Flag_Z_Sel, Flag_V_Sel;

// Wires
// ------------------------------------------------------------------------------
// IDP Wires
wire W_En, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg;
wire [1:0] S_Sel;
wire [4:0] W_Addr, S_Addr, R_Addr, ALU_OP;
wire SP_Dec, SP_Inc;
wire EX_En, WR_Sel;

// FDP Wires
wire FW_En, F_Sel;
wire [4:0] FW_Addr, FS_Addr, FR_Addr;
wire [3:0] FP_Op;

// VDP Wires
wire VW_En, VS_Sel;
wire [4:0] VR_Addr, VS_Addr, VW_Addr;
wire [4:0] VALU_OP;
wire [2:0] V_Mode;
wire MANDA_En;
wire VR1_En, VR0_En, VR1OE, VR0OE;

// BIU Wires
wire FP1_En, FP0_En, FP1OE, FP0OE, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_FP, inc_en,
     WR1_En, WR0_En, IR_En, WR1OE, WR0OE, WR0_FR_En;
	  
wire MAR_En_SP;

wire WR1Sel, WR0Sel;

wire [31:0] RdBuf0Wire, RdBuf1Wire;
	  
// Memory Wires
wire Mem_CS_, Mem_RD_, Mem_WR_;

// IO Wires
wire IO_CS_, IO_RD_, IO_WR_;

// Flag Wires
wire c, n, z, v, sol, sor; 
wire [5:0] FP_Status;

// IR Wire
wire [31:0] IR_Wire;

// Interrupt Initiation Wire
wire interrupt, int_ack;

// Interrupt MAR Enable Wire
wire Int_En;
	 
// Flag Register Path Wire
wire [63:0] FR_Out;

// Control Unit Module		  
CU64 CU64 (clk, reset,      
              c, n, z, v, sol, sor,      
              FP_Status,
				  int_ack,
				  W_En, W_Addr, S_Addr, S_Sel, Y_Sel, R_Addr, ALU_OP, Jump_En, Jump_Reg, 
				  PC_En, PC_Reset,
				  Call_En, Ret_En,
				  FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP1_En, FP0_En,
				  FP1OE, FP0OE,
				  Rd1_En, Rd0_En, MAR_En, MAR_En_PC, inc_en, WR1_En, WR0_En,
				  IR_En, WR1OE, WR0OE,
				  Mem_CS_, Mem_RD_, Mem_WR_, IR_Wire, Flag_N_Sel, Flag_Z_Sel, Flag_V_Sel, Flag_C_Sel,
				  MAR_En_SP, SP_Dec, SP_Inc, MAR_En_FP,
				  WR1Sel, WR0Sel,
				  VW_En, VR_Addr, VS_Addr, VW_Addr, VALU_OP, VS_Sel, V_Mode,
				  EX_En, WR_Sel,
				  IO_CS_, IO_RD_, IO_WR_, interrupt, Int_En,
				  FR_Out, WR0_FR_En,
				  RdBuf0Wire, RdBuf1Wire,
				  MANDA_En,
				  VR1_En, VR0_En, VR1OE, VR0OE);


// CPU_EU and Memory Module 
Core_Architecture Core_Architecture(clk, FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, 
							FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, MAR_En_FP, SP_Dec, SP_Inc, inc_en, WR1_En, 
							WR0_En, IR_En, W_En, S_Sel, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg, R_Addr, S_Addr,
							W_Addr, ALU_OP, FP_Status, n, z, c, v, sor, sol, Mem_CS_, Mem_RD_, Mem_WR_, 
							FP0OE, FP1OE, WR1OE, WR0OE, IR_Wire, WR1Sel, WR0Sel, VW_En, VR_Addr, VS_Addr, VW_Addr, VALU_OP, VS_Sel, V_Mode, EX_En, WR_Sel, IO_CS_, IO_RD_, IO_WR_, interrupt, int_ack, Int_En, FR_Out, WR0_FR_En, RdBuf0Wire, RdBuf1Wire, MANDA_En, VR1_En, VR0_En, VR1OE, VR0OE);


endmodule
