`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   22:32:03 02/23/2014
// Design Name:   vga_controller_640_60
// Module Name:   D:/Documents/Documents/XilinxProjects/EC551/lab2/vga_controller_tb.v
// Project Name:  lab2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: vga_controller_640_60
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module vga_controller_tb;

	// Inputs
	reg pixel_clk;

	// Outputs
	wire HS;
	wire VS;
	wire [10:0] hcounter;
	wire [10:0] vcounter;
	wire blank;

	// Instantiate the Unit Under Test (UUT)
	vga_controller_640_60 uut (
		.pixel_clk(pixel_clk), 
		.HS(HS), 
		.VS(VS), 
		.hcounter(hcounter), 
		.vcounter(vcounter), 
		.blank(blank)
	);

   initial 
      pixel_clk = 0;
      always #40 pixel_clk = ~pixel_clk;
      
	initial begin
		// Initialize Inputs
		pixel_clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

