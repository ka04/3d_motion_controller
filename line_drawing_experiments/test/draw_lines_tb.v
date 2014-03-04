`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:20:34 03/01/2014
// Design Name:   draw_lines
// Module Name:   D:/Documents/Documents/XilinxProjects/EC551/line_drawing/draw_lines_tb.v
// Project Name:  line_drawing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: draw_lines
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module draw_lines_tb;

	// Inputs
	reg clk;
	reg btns;
   reg btnd;

	// Outputs
	wire [2:0] vgaRed;
	wire [2:0] vgaGreen;
	wire [2:1] vgaBlue;
	wire Hsync;
	wire Vsync;

	// Instantiate the Unit Under Test (UUT)
	draw_lines uut (
		.clk(clk), 
		.btns(btns), 
      .btnd(btnd), 
		.vgaRed(vgaRed), 
		.vgaGreen(vgaGreen), 
		.vgaBlue(vgaBlue), 
		.Hsync(Hsync), 
		.Vsync(Vsync)
	);
   initial begin
		clk=0;
		forever #5 clk=~clk;
	end
   
	initial begin
		// Initialize Inputs
		//clk = 0;
		btns = 0;
      btnd = 0;
        
		// Add stimulus here
      #20;
      #10 btnd = 1;
      #20 btnd = 0;
      #100;
      #10 btns = 1;
      #20 btns = 0;

	end
      
endmodule

