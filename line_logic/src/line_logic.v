`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:26:14 03/01/2014 
// Design Name: 
// Module Name:    line_logic 
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
module line_logic(
    input [P_DATA_W-1:0] i_hcount,
    input [P_DATA_W-1:0] i_vcount,
    input [P_DATA_W-1:0] i_x_val,
    input [P_DATA_W-1:0] i_y_val,
    input                i_vals_valid,
    output               o_pixel_on
    );

   parameter P_DATA_W = 11;
   parameter P_SCALE  = 2;
   
   reg pixel_on;

   always @(i_hcount, i_vcount, i_x_val, i_y_val, i_vals_valid)
   begin
      pixel_on = 1'b0;
      if (i_vals_valid) begin
         if ((i_hcount >= i_x_val) && (i_hcount <= i_x_val+P_SCALE) && 
             (i_vcount >= i_y_val) && (i_vcount <= i_y_val+P_SCALE)) begin
         //if ((i_hcount == i_x_val) && (i_vcount == i_y_val)) begin
         //if (((i_hcount >= i_x_val) || (i_hcount <= i_x_val+P_SCALE)) &&
         //    ((i_vcount >= i_y_val) || (i_vcount <= i_y_val+P_SCALE))) begin
            pixel_on = 1'b1;
         end
      end
   end

   assign o_pixel_on = pixel_on;

endmodule
