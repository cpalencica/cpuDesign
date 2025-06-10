`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:39:32 03/21/2017 
// Design Name: 
// Module Name:    discussion_tb 
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
//////////////////////////////////////////////////////////////////////////////
module discussion_tb;

   // Inputs
   reg clk;
   reg Reset;
   reg LoadInstructions;
   reg [31:0] Instruction;
   
   // Outputs
   wire [31:0] out;
   
   // Instantiate the Unit Under Test (UUT)
   CPU uut (
            .out(out), 
            .clk(clk), 
            .Reset(Reset), 
            .LoadInstructions(LoadInstructions), 
            .Instruction(Instruction)
            );
   
   initial begin
      // Initialize Inputs
      clk = 0;
      Reset = 1;
      LoadInstructions = 0;
      Instruction = 0;
      #10;
      
      Reset = 0;
      LoadInstructions = 1;
      // #10;
      // 0
      Instruction = 32'b001000_00000_00001_0000000110100111; // addi $R1, $0, 423
      #10; // 1                                              // -> 423
      Instruction = 32'b001000_00000_00010_0000000001011100; // addi $R2, $0, 92
      #10; // 2                                              // -> 92
      Instruction = 32'b001000_00000_00011_0000000000001101; // addi $R3, $0, 13
      #10; // 3                                              // -> 13
      Instruction = 32'b001000_00000_00100_0000000010010010; // addi $R4, $0, 146
      #10; // 4                                              // -> 146
      Instruction = 32'b001000_00000_00101_0000000000000101; // addi $R5, $0, 5
      #10; // 5                                              // -> 5
      Instruction = 32'b000000_00001_00100_00101_00000_100000; // add $R5, $R1, $R4
      #10; // 6                                             // -> 569 (423 if wrong)
      Instruction = 32'b000000_00011_00101_00110_00000_101010; // slt $R6, $R3, $R5
      #10; // 7                                                // -> 1 (0 if wrong)
      Instruction = 32'b100011_00000_00100_0000000000000100;   // LW $R4, 4(R0)
      #10; // 8                                                // -> 4
      Instruction = 32'b000000_00100_00110_00111_00000_100010; // sub $R7, $R4, $R6
      #10; // 9                                         // -> 3 (146 or 145 if wrong)
      
     
      
      // NO WRITE
      // test R2 didnt change with SW command : R8 should get 95 because R7 shouldn't write 0 to R7
      Instruction = 32'b101011_00000_00111_0000000000000000;   // SW $R7, 0(R0)
      #10; // 10
      Instruction = 32'b000000_00111_00010_01000_00000_100000; // add R8, R7, R2    
      #10; // 11  
      
      
      
      // R0 WRITE
      /* test writing to R0: R20 should be 15 by the end not 30 */
      Instruction = 32'b001000_00001_00000_0000000000001111; // addi R0, R1, 15 (test writing to to R0, should not happen) --> wrong 423 + 15 = 438
      #10
      Instruction = 32'b001000_00000_10100_0000000000001111; // addi R20, R0, 15 (test writing to to R0, should not happen) --> wrong 438 + 15 = 453
      #10
      
      // Check register Bypass
      Instruction = 32'b001000_00100_00100_0000000000001010;    // addi R4, R4, 10 --? should become 14
      #10
		
      LoadInstructions = 0;
      Reset = 1;
      #10;
		
      Reset = 0;
      #100;
      
   end
	
   always begin
      #5;
      clk = ~clk;
   end
   
endmodule
