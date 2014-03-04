`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:10:25 03/01/2014 
// Design Name: 
// Module Name:    draw_lines 
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
module draw_lines(
	 input clk,
    input [7:0] sw,
    input btns,
    input btnu,
    //input btnl,
    input btnd,
    //input btnr,
    //output [7:0] seg,
    //output [3:0] an,
    //output [7:0] Led,
    output [2:0] vgaRed,
    output [2:0] vgaGreen,
    output [2:1] vgaBlue,
    output Hsync,
    output Vsync
    );

   localparam  P_MAX_LINE_LENGTH = 31;
   localparam  P_X_COORD_W       = 9;//11;
   localparam  P_Y_COORD_W       = 9;//11;
   
   localparam  P_MULT_FACTOR     = 2;
   localparam  P_SCALE           = 2;
   localparam  P_COUNT_W         = 4;

   // VGA
   wire        vga_clk;
   reg   [2:0] vga_red;
   reg   [2:0] vga_grn;
   reg   [1:0] vga_blu;
   wire [10:0] vga_hcounter;
   wire [10:0] vga_vcounter;
   wire        vga_blank;
   
   // Bresenham
   wire [P_MAX_LINE_LENGTH*P_X_COORD_W-1:0] line_x_vals;
   wire [P_MAX_LINE_LENGTH*P_Y_COORD_W-1:0] line_y_vals;
   wire [P_MAX_LINE_LENGTH-1:0] line_vals_valid;
   wire [P_MAX_LINE_LENGTH-1:0] pixel_on_arr;
   //integer i;

   // Buttons
   wire        btns_debounce;
   wire        btns_pulse;
   wire        btnu_debounce;
   wire        btnu_pulse;
   wire        btnd_debounce;
   wire        btnd_pulse;

   // Counter
   wire [P_COUNT_W-1:0] count;

   // Button debounce
   button_debounce button_debounce_btns (
      .i_clk(clk),
      .i_button(btns),
      .o_button_state(btns_debounce)
      );      

   // Level to pulse
	level_to_pulse lvl_to_pulse_btns (
		.i_clk(clk), 
		.i_data(btns_debounce), 
		.o_pulse(btns_pulse)
	);

   // Button debounce
   button_debounce button_debounce_btnu (
      .i_clk(clk),
      .i_button(btnu),
      .o_button_state(btnu_debounce)
      );      

   // Level to pulse
	level_to_pulse lvl_to_pulse_btnu (
		.i_clk(clk), 
		.i_data(btnu_debounce), 
		.o_pulse(btnu_pulse)
	);
   
   // Button debounce
   button_debounce button_debounce_btnd (
      .i_clk(clk),
      .i_button(btnd),
      .o_button_state(btnd_debounce)
      );      

   // Level to pulse
	level_to_pulse lvl_to_pulse_btnd (
		.i_clk(clk), 
		.i_data(btnd_debounce), 
		.o_pulse(btnd_pulse)
	);

   counter #(.P_COUNT_W(P_COUNT_W)) counter (
		.i_clk(btnu_pulse), 
		.o_count(count)
	);

	bresenham #(
         P_MAX_LINE_LENGTH,
         P_X_COORD_W,
         P_Y_COORD_W
      ) bres (
         .i_clk(clk), 
         .i_reset(btnd_pulse), 
         .i_x0(5),//0), 
         .i_x1(20),//2*sw[3:0]), 
         .i_y0(count),//0), 
         .i_y1(15-count),//2*sw[7:4]), 
         .i_load_vals(btns_pulse), 
         .o_x_vals(line_x_vals), 
         .o_y_vals(line_y_vals), 
         .o_vals_valid(line_vals_valid), 
         .o_vals_rdy()
	);

   clk_divider #(4) vga_clk_div(
      .i_clk(clk),
      .o_clk(vga_clk)
    );

   vga_controller_640_60 vga_controller(
      .pixel_clk(vga_clk),
      .HS(Hsync),
      .VS(Vsync),
      .blank(vga_blank),
      .hcounter(vga_hcounter),
      .vcounter(vga_vcounter)
      );

   always@(vga_clk, vga_hcounter, vga_vcounter, vga_blank, 
           line_vals_valid, line_x_vals, line_y_vals, pixel_on_arr)
   begin
      if (vga_blank == 0) begin
         if (pixel_on_arr) begin
            vga_red = 3'b111;
            vga_grn = 3'b111;
            vga_blu = 2'b11;
         end else begin
            vga_red = 3'b000;
            vga_grn = 3'b000;
            vga_blu = 2'b00;
         end
      end else begin
         vga_red = 3'b000;
         vga_grn = 3'b000;
         vga_blu = 2'b00;
      end
   end

   genvar i;
   generate
      for (i=0; i<P_MAX_LINE_LENGTH; i=i+1) begin : PIXEL_GEN
         line_logic #(.P_SCALE(P_SCALE)) line (
            .i_hcount(vga_hcounter), 
            .i_vcount(vga_vcounter), 
            .i_x_val(P_MULT_FACTOR*line_x_vals[((i+1)*P_X_COORD_W)-1:i*P_X_COORD_W]), 
            .i_y_val(P_MULT_FACTOR*line_y_vals[((i+1)*P_Y_COORD_W)-1:i*P_Y_COORD_W]), 
            .i_vals_valid(line_vals_valid[i]), 
            .o_pixel_on(pixel_on_arr[i])
            );
      end
   endgenerate

   assign vgaRed   = vga_red;
   assign vgaGreen = vga_grn;
   assign vgaBlue  = vga_blu;

endmodule
