`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: CECS 440, Lab 3
// Engineer: Abodunrin Adepoju, 007209772
// 
// Create Date:    13:15:32 09/05/2011 
// Design Name: 
// Module Name:    alu 
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
module alu(R, S, Alu_Op, Y, N, Z, C, V, SOR, SOL);

	input   [63:0] R, S;                                                                // 64 bits get brought into both inputs -- R and S
	input	  [4:0] Alu_Op;                                                               // 5 bit ALU Op Code is imported
	output  [63:0] Y;				
	reg	  [63:0] Y;                                                                   // 64 bit output Y
	output  N, Z, C, V, SOR, SOL;		
	reg	  N, Z, C, V, SOR, SOL;                                                       // N = Negative, Z = Zero, C = Carry, V = Overflow
	
	reg [63:0] Multiplicand;                                                          	// Register to house the multiplicand
	reg [127:0] Product_Register;                                                       // Register to house the product 
	
	reg [63:0] Divisor;                                                                 // Register to house the divisor
	reg [127:0] Remainder_Register;                                                     // Register to house the remainder 
	
	initial 
	begin
		N = 1'b0;
		Z = 1'b0;
		C = 1'b0;
		V = 1'b0;
	end
	
	always @(R or S or Alu_Op) 
	begin
	  
		case (Alu_Op)
		   5'b00000:   
							begin
							
								{C, Y} = R + S;                                                // Addition, with Carry-Flag

								if (R[63] == 1'b0 && S[63] == 1'b0 && Y[63] == 1'b1)				// Overflow-Flag Case 1
									V = 1;
								else if (R[63] == 1'b1 && S[63] == 1'b1 && Y[63] == 1'b0)				// Overflow-Flag Case 2
									V = 1;
								else
									V = 0;
							
							end
									
			5'b00001:   begin
							{C, Y} = R - S;                                                   // Subtraction
			
							if (R[63] == 1'b0 && S[63] == 1'b1 && Y[63] == 1'b1)
								V = 1;
								
							if (R[63] == 1'b1 && S[63] == 1'b0 && Y[63] == 1'b0)
								V = 1;
								
							end
			5'b00010:   begin                                                    			// Multiplication
								
                   		case ({R[63],S[63]})                                            // Positive (R) times a Positive (S)
								2'b00: 
								begin		
                           Product_Register = {64'b0, S};	
                           Multiplicand = R;									
									repeat (64)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end	
								{C,Y} = {1'b0, Product_Register[63:0]};
								end
								
								2'b01:                                                         // Positive Multiplicand (R) times a Negative (S)
								begin
								   // Change multiplier to a positive number
									Product_Register = {64'b0, (~(S) + 1'b1)};
									Multiplicand = R;
									repeat (64)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
							   // Change result back to a negative number
								//Y = ~(Product_Register[63:0] + 1);
								Product_Register = -Product_Register;
								{C, Y} = {1'b0, Product_Register[63:0]};
								//{C, Y} = {1'b0, (~Product_Register[63:0] + 1'b1)};
								end
									
								2'b10:                                                        	// Negative Multiplicand (R) times a Positive Multiplier (S)
								begin
								   Product_Register = {64'b0, S};
									Multiplicand = ~R + 1'b1;
									repeat (64)
			
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								Product_Register = -Product_Register;
								{C, Y} = {1'b0, Product_Register[63:0]};
								end
								
								2'b11:                                                         // Negative Multiplicand (R) times a Negative Multiplier (S)
								begin
									Product_Register = {64'b0, -S};
									Multiplicand = -R;
									repeat (64)
									begin
										if (Product_Register[0] == 1'b1)
										begin
											Product_Register[127:64] = Product_Register[127:64] + Multiplicand;
											Product_Register = Product_Register >> 1;
										end
										else
										begin
											Product_Register = Product_Register >> 1;
										end
									end
								//Y = ~Product_Register[63:0] + 1'b1;
								
								{C, Y} = {1'b0, Product_Register[63:0]};
								end
									
								endcase
							end 
			5'b00011:   {C, Y} = {1'b0, Product_Register[127:64]};                       // Most Significant Word (MSW) of Multiplication
			5'b00100:   begin                                                    			// Division
			               if (S == 64'b0)
								$display("Cannot divide by zero");
									
								else begin 
								case ({R[63],S[63]})                                           // Positive Dividend [R] and Positive Divisor [S]
								2'b00:
								begin
								Remainder_Register = {64'b0, R};                
								Divisor = S;
								Remainder_Register = Remainder_Register << 1;
								repeat (64)
								begin
								  Remainder_Register[127:64] = Remainder_Register[127:64] - Divisor;
								  if (Remainder_Register[127] == 1'b0)
								  begin
								     Remainder_Register = Remainder_Register << 1;
									  Remainder_Register[0] = 1'b1;
								  end
								  else
								  begin
								    Remainder_Register[127:64] = Remainder_Register[127:64] + Divisor;
									 Remainder_Register = Remainder_Register << 1;
									 Remainder_Register[0] = 1'b0;
								  end
							  end 
							  Remainder_Register[127:64] = Remainder_Register[127:64] >> 1;
							  {C, Y} = {1'b0, (Remainder_Register[63:0])};
							  end
							  
			              2'b01:                                     							// Positive Dividend [R] and Negative Divisor [S]
							  begin
							  Remainder_Register ={64'b0, R};
							  Divisor = ~S + 1'b1;
							  Remainder_Register = Remainder_Register << 1;
							  repeat (64)
							  begin
								Remainder_Register[127:64] = Remainder_Register[127:64] - Divisor;
								if (Remainder_Register[127] == 1'b0)
								begin
									Remainder_Register = Remainder_Register << 1;
									Remainder_Register[0] = 1'b1;
								end
								else
								begin
									Remainder_Register[127:64] = Remainder_Register[127:64] + Divisor;
									Remainder_Register = Remainder_Register << 1;
									Remainder_Register[0] = 1'b0;
								end
							 end
							 Remainder_Register[127:64] = Remainder_Register[127:64] >> 1;
							 {C, Y} = {1'b0, (~Remainder_Register[63:0] + 1'b1)};
							 end
							 
							 2'b10:                                                           // Negative Dividend [R] and Negative Divisor [S]
							 begin
							 Remainder_Register = {64'b0, (~(R) + 1'b1)};
							 Divisor = S;
							 Remainder_Register = Remainder_Register << 1;
							 repeat (64)
							 begin
								Remainder_Register[127:64] = Remainder_Register[127:64] - Divisor;
								if (Remainder_Register[127] == 1'b0)
								begin
									Remainder_Register = Remainder_Register << 1;
									Remainder_Register[0] = 1'b1;
								end
								else
								begin
									Remainder_Register[127:64] = Remainder_Register[127:64] + Divisor;
									Remainder_Register = Remainder_Register << 1;
									Remainder_Register[0] = 1'b0;
								end
							end
							Remainder_Register[127:64] = Remainder_Register[127:64] >> 1;
							{C, Y} = {1'b0, (~Remainder_Register[63:0] + 1'b1)};
							end
							
							2'b11:                                                            // Negative Dividend [R] and Negative Divisor [S]
							begin
							Remainder_Register = {64'b0, (~(R) + 1'b1)};
							 Divisor = ~S + 1'b1;
							 Remainder_Register = Remainder_Register << 1;
							 repeat (64)
							 begin
								Remainder_Register[127:64] = Remainder_Register[127:64] - Divisor;
								if (Remainder_Register[127] == 1'b0)
								begin
									Remainder_Register = Remainder_Register << 1;
									Remainder_Register[0] = 1'b1;
								end
								else
								begin
									Remainder_Register[127:64] = Remainder_Register[127:64] + Divisor;
									Remainder_Register = Remainder_Register << 1;
									Remainder_Register[0] = 1'b0;
								end
							end
							Remainder_Register[127:64] = Remainder_Register[127:64] >> 1;
							{C, Y} = {1'b0, Remainder_Register[63:0]};
							end
							  endcase
							  end
							end
			5'b00101:   {C, Y} = {1'b0, Remainder_Register[127:64]};                      // Remainder of Division
			5'b00110:   
							begin
							{C, Y} = S + 1;                                                   // Increment
							
							if (Y[63] != S[63])
								V = 1;
							else
								V = 0;
					
							end
							
			5'b00111:   
							begin
						
							Y = S - 1'b1;                                                   // Decrement
							
							if (Y[63] != S[63])
								V = 1;
							else
								V = 0;
							
							
							end
			5'b01000:   {C, Y} = {1'b0, R & S};                                           // AND
			5'b01001:   {C, Y} = {1'b0, R | S};                                           // OR
			5'b01010:   {C, Y} = {1'b0, R ^ S};                                           // XOR
			5'b01011:   {C, Y} = {1'b0, ~S};                                              // NOT
			5'b01100:   {C, Y} = {1'b0, -S};                                              // NEG
			5'b01101:   begin                                                             // Logical Shift Left
                          C = S[63];
								  SOR = S[63];
                          Y = S << 1;
                     end	
         5'b01110:   begin                                                             // Logical Shift Right
                          C = S[0];
								  SOR = S[0];
                          Y = S >> 1;   
                     end							
			5'b01111:   {C, Y} = {1'b0, 64'b0};                                           // All Zeros
			5'b10000:   {C, Y} = {1'b0, 64'hFFFFFFFFFFFFFFFF};                            // All Ones
			5'b10001:   {C, Y} = {1'b0, R};                                               // Pass R
			5'b10010:   {C, Y} = {1'b0, S};                                               // Pass S
			5'b10011:																							// Arithmetic Shift Right
							Y = {S[63], S[63:1]};
			5'b10100:   Y = -S; 																				// Negate
			5'b10101:   begin                                                             // Arithmetic Shift Left
								C = S[63];
								SOR = S[63];
								Y = S << 1;
								if (Y[63] != S[63])
									V = 1;
							end
							// Need to check for Overflow in Arithmetic Shift Left
			5'b10110:   Y = ~S;																				// Not
			5'b10111:   Y = {S[0], S[63:1]};                                              // Rotate Right
			5'b11000:   Y = {S[62:0], S[63]};                                             // Rotate Left
			default:    {C, Y} = {1'b0, S};                                               // Pass S for default
		endcase
		
		// handle last two status flags
		 N = Y[63];
		
		if (Y == 64'b0)
		  Z = 1'b1;
		  else
		  Z = 1'b0;
		
		//if (Y == 64'b0)
		//	Z = 1'b1;
			
	end                                                                                 // End Always Block

endmodule                                                                              // End Module
