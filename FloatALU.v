`timescale 1ns / 1ps

/*************************************************************************** 
* Date: October 10, 2011 
* File: 440_FloatAlu.v 
* 
* This ALU will be used in the 440 project to perform various manipulations 
* on 64-bit floating point numbers.  
* There are 4 "Op" inputs to perform up to 16 floating point operations. 
* 
* The 6-bit Status Register will always return the relationship 
* between the R and S operands as 6 boolean values, as defined below: 
* 
*   Status [ 5 | 4 | 3 | 2 | 1 | 0 ] ==  [ GT | GE | LT | LE | EQ | NE ] 
* 
* Note that more than one flag can be set at a time, For example a 
* value of 110001 means operand[R] was both GT, GE, and NE to operand[S].  
****************************************************************************/ 
module FloatALU(Y, R, S, Op, Status); 
   output  [63:0]  Y;      reg  [63:0] Y;       // 64-bit output 
   output   [5:0]  Status; reg   [5:0] Status;  //  6-bit output 
   input   [63:0]  R, S;                        // 64-bit inputs 
   input    [3:0]  Op;                          //  4-bit opcode 
   real fp_Y, fp_R, fp_S;
   always @(R or S or Op) begin 
      fp_R = $bitstoreal(R); 
      fp_S = $bitstoreal(S); 
      case (Op)
         0:  fp_Y = fp_R;                // pass R 
         1:  fp_Y = fp_S;                // pass S 
         2:  fp_Y = fp_R + 1;            // inc R 
         3:  fp_Y = fp_S + 1;            // inc S 
         4:  fp_Y = fp_R - 1;            // dec R 
         5:  fp_Y = fp_S - 1;            // dec S 
         6:  fp_Y = fp_R + fp_S;         // Addition 
         7:  fp_Y = fp_R - fp_S;         // Subtraction R-S 
         8:  fp_Y = fp_S - fp_R;         // Subtraction S-R 
         9:  fp_Y = fp_R *  fp_S;        // Multiply 
        10:  fp_Y = fp_R /  fp_S;        // Division R/S 
        11:  fp_Y = fp_S /  fp_R;        // Division S/R 
        12:  fp_Y = 0.0;           // zeros 
        13:  fp_Y = 1.0;           // 1.0 
        default:    fp_Y = 64'hx; 
      endcase 
      //  Status [5|4|3|2|1|0] ==  [GT|GE|LT|LE|EQ|NE]
      Status[5] = fp_R >  fp_S; 
      Status[4] = fp_R >= fp_S; 
      Status[3] = fp_R <  fp_S; 
      Status[2] = fp_R <= fp_S; 
      Status[1] = fp_R == fp_S; 
      Status[0] = fp_R != fp_S; 
      Y = $realtobits(fp_Y); 
   end 
endmodule
