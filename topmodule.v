`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  CECS 440
// Engineer: Abodunrin Adepoju, Bruno Venegas
// 
// Create Date:    17:48:16 10/16/2011 
// Design Name: 
// Module Name:    topmodule 
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
module Core_Architecture(clk, FW_En, F_Sel, FW_Addr, FS_Addr, FR_Addr, FP_Op, FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, MAR_En_FP, SP_Dec, SP_Inc, inc_en, WR1_En, WR0_En, IR_En, W_En, S_Sel, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg, R_Addr, S_Addr,
W_Addr, ALU_OP, FP_Status, N, Z, C, V, SOR, SOL, CS_, RD_, WR_, FP0OE, FP1OE, WR1OE, WR0OE, IR_Wire, WR1Sel, WR0Sel, VW_En, VR_Addr, VS_Addr, VW_Addr, VALU_OP, VS_Sel, V_Mode, EX_En, WR_Sel, IO_CS_, IO_RD_, IO_WR_, interrupt, int_ack, Int_En, FR_Out, WR0_FR_En, RdBuf0Wire, RdBuf1Wire, MANDA_En, VR1_En, VR0_En, VR1OE, VR0OE);

// Inputs 
input clk, FW_En, F_Sel;
input [4:0] FW_Addr, FS_Addr, FR_Addr;
input [3:0] FP_Op;
input FP1_En, FP0_En, Rd1_En, Rd0_En, MAR_En, MAR_En_PC, inc_en, WR1_En, WR0_En, IR_En, FP0OE, FP1OE, WR1OE, WR0OE, MAR_En_SP, SP_Inc, SP_Dec, MAR_En_FP;
input W_En, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset;
input [1:0] S_Sel;
input [4:0] R_Addr, S_Addr, W_Addr;
input [4:0] ALU_OP;
input CS_, RD_, WR_;
input IO_CS_, IO_RD_, IO_WR_;

input Jump_En, Jump_Reg;
input EX_En, WR_Sel;
input Int_En;

input WR1Sel, WR0Sel;

input [63:0] FR_Out;

input WR0_FR_En;

input VR1_En, VR0_En, VR1OE, VR0OE;

// Vector Datapath
// **************************************************************
// Inputs
input VW_En, VS_Sel;
input [4:0] VR_Addr, VS_Addr, VW_Addr;
input [4:0] VALU_OP;
input [2:0] V_Mode;
input MANDA_En;


// Outputs
output [5:0] FP_Status;
wire [5:0] FP_Status;

output N, Z, C, V, SOR, SOL;
wire N, Z, C, V, SOR, SOL;

output [31:0] IR_Wire;
wire [31:0] IR_Wire;

wire [63:0] mem_addr_bus;

wire [31:0] mem_data_bus;

output [31:0] RdBuf0Wire, RdBuf1Wire;
wire [31:0] RdBuf0Wire, RdBuf1Wire;

// Interrupt 
output interrupt, int_ack;


// CPU_EU(clk, FW_En, FW_Addr, FS_Addr, F_Sel, FP_Op, FR_Addr, FP_Status, W_En, W_Addr, S_Addr, DS, S_Sel, DY, Y_Sel, R_Addr, ALU_OP, SOL, SOR, N, Z, C, FP1_En, FP0_En,
//        Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, IR_En, mem_data_bus, mem_addr_bus, FP0OE, FP1OE, WR1OE, WR0OE);

// module CPU_EU(clk, FW_En, FW_Addr, FS_Addr, F_Sel, FP_Op, FR_Addr, FP_Status, W_En, W_Addr, S_Addr, S_Sel, DY, Y_Sel, R_Addr, ALU_OP, SOL, SOR, N, Z, C, FP1_En, FP0_En,
// Rd1_En, Rd0_En, MAR_En, inc_en, WR1_En, WR0_En, IR_En, mem_data_bus, mem_addr_bus, FP0OE, FP1OE, WR1OE, WR0OE);
CPU_EU CPU_EU(clk, FW_En, FW_Addr, FS_Addr, F_Sel, FP_Op, FR_Addr, FP_Status, W_En, W_Addr, S_Addr, S_Sel, Y_Sel, PC_En, Call_En, Ret_En, PC_Reset, Jump_En, Jump_Reg, R_Addr, ALU_OP, SOL, SOR, N, Z, C, V, FP1_En, FP0_En,
				  Rd1_En, Rd0_En, MAR_En, MAR_En_PC, MAR_En_SP, MAR_En_FP, SP_Dec, SP_Inc, inc_en, WR1_En, WR0_En, IR_En, mem_data_bus, mem_addr_bus, FP0OE, FP1OE, WR1OE, WR0OE, IR_Wire, WR1Sel, WR0Sel, VW_En, VR_Addr, VS_Addr, VW_Addr, VALU_OP, VS_Sel, V_Mode, EX_En, WR_Sel, Int_En, FR_Out, WR0_FR_En, RdBuf0Wire, RdBuf1Wire, MANDA_En, VR1_En, VR0_En, VR1OE, VR0OE);

// memory(Addr, Data, CS_, RD_, WR_, Clk);
memory memory(mem_addr_bus[9:0], mem_data_bus, CS_, RD_, WR_, clk);

// IO(Addr, Data, IO_CS_, IO_RD_, IR_WR_, Clk);
IO IO(mem_addr_bus[9:0], mem_data_bus, IO_CS_, IO_RD_, IO_WR_, clk, interrupt, int_ack);





endmodule
