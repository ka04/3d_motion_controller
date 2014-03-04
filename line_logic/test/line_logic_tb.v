`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:30:37 03/01/2014
// Design Name:   line_logic
// Module Name:   D:/Documents/Documents/XilinxProjects/EC551/line_drawing/line_logic_tb.v
// Project Name:  line_drawing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: line_logic
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module line_logic_tb;

	// Inputs
	reg [10:0] i_hcount;
	reg [10:0] i_vcount;
	reg [10:0] i_x_val;
	reg [10:0] i_y_val;
	reg i_vals_valid;

	// Outputs
	wire o_pixel_on;

	// Instantiate the Unit Under Test (UUT)
	line_logic uut (
		.i_hcount(i_hcount), 
		.i_vcount(i_vcount), 
		.i_x_val(i_x_val), 
		.i_y_val(i_y_val), 
		.i_vals_valid(i_vals_valid), 
		.o_pixel_on(o_pixel_on)
	);

	initial begin
		// Initialize Inputs
		i_hcount = 0;
		i_vcount = 0;
		i_x_val = 0;
		i_y_val = 0;
		i_vals_valid = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
      #10 i_vals_valid = 1;
      #10 i_x_val = 1; i_y_val = 1;
      #10 i_hcount=0; i_vcount=0;
      #10 i_hcount=1; i_vcount=1;
      #10 i_hcount=2; i_vcount=2;
      #10 i_hcount=3; i_vcount=3;
      #10 i_hcount=4; i_vcount=4;
      


	end
      
endmodule

