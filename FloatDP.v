`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:43:08 10/09/2011 
// Design Name: 
// Module Name:    FloatDP 
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
module FloatDP(W_Clk, FW_En, FW_Addr, FS_Addr, Float_In, F_Sel, FP_Op, FR_Addr, Y, FP_Status, FP_R_OUT);

// Inputs
input W_Clk, FW_En, F_Sel;
input [4:0] FW_Addr, FS_Addr, FR_Addr;
input [3:0] FP_Op;
input [63:0] Float_In;

// Outputs
output [63:0] FP_R_OUT;
output [63:0] Y;
wire [63:0] Y;
output [5:0] FP_Status;
wire [5:0] FP_Status;

// Wires
wire [63:0] R, S, WR;

assign WR = F_Sel? Y : Float_In;
assign FP_R_OUT = R;


// module FPRegFile(clk, W_En, W_Addr, S_Addr, R_Addr, WR, R, S);
FPRegFile FPRegFile(W_Clk, FW_En, FW_Addr, FS_Addr, FR_Addr, WR, R, S);

// module FloatALU (Y, R, S, Op, Status); 
FloatALU FloatALU(Y, R, S, FP_Op, FP_Status);


endmodule
