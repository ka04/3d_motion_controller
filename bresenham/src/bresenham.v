`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:14:18 03/01/2014 
// Design Name: 
// Module Name:    bresenham 
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
module bresenham(
      input                                      i_clk,
      input                                      i_reset,
      input                    [P_X_COORD_W-1:0] i_x0,
      input                    [P_X_COORD_W-1:0] i_x1,
      input                    [P_Y_COORD_W-1:0] i_y0,
      input                    [P_Y_COORD_W-1:0] i_y1,
      input                                      i_load_vals,
      output [P_MAX_LINE_LENGTH*P_X_COORD_W-1:0] o_x_vals, //[P_MAX_LINE_LENGTH-1:0],
      output [P_MAX_LINE_LENGTH*P_Y_COORD_W-1:0] o_y_vals, //[P_MAX_LINE_LENGTH-1:0],
      output             [P_MAX_LINE_LENGTH-1:0] o_vals_valid,
      output                                     o_vals_rdy
    );
    
   function integer log2;
      input [31:0] value;
      begin
	 value = value-1;
	 for (log2=0; value>0; log2=log2+1)
	   value = value>>1;
      end
   endfunction
   
   parameter  P_MAX_LINE_LENGTH = 10;
   parameter  P_X_COORD_W       = 11;
   parameter  P_Y_COORD_W       = 10;
   localparam P_LINE_LENGTH_W   = log2(P_MAX_LINE_LENGTH);//(P_X_COORD_W > P_Y_COORD_W) ? P_X_COORD_W : P_Y_COORD_W;
   
   localparam STATE__WAITING              = 0;
   localparam STATE__SETUP_IS_STEEP       = 1;
   localparam STATE__SETUP_REV_COORDS     = 2;
   localparam STATE__SETUP_ERROR_AND_STEP = 3;
   localparam STATE__DRAWING              = 4;

   reg                          [2:0] curr_state, next_state;
   reg signed       [P_X_COORD_W-1:0] x, x0, x1;
   reg signed       [P_Y_COORD_W-1:0] y, y0, y1;
   reg signed       [P_X_COORD_W-1:0] x_vals     [P_MAX_LINE_LENGTH-1:0];
   reg signed       [P_Y_COORD_W-1:0] y_vals     [P_MAX_LINE_LENGTH-1:0];
   //reg signed       [P_X_COORD_W-1:0] x_vals_reg [P_MAX_LINE_LENGTH-1:0];
   //reg signed       [P_Y_COORD_W-1:0] y_vals_reg [P_MAX_LINE_LENGTH-1:0];
   reg        [P_MAX_LINE_LENGTH-1:0] vals_valid;
   //reg        [P_MAX_LINE_LENGTH-1:0] vals_valid_reg;
   reg signed [P_MAX_LINE_LENGTH-1:0] delta_x, delta_y, error;
   reg signed                   [1:0] ystep;
   reg                                vals_rdy;
   reg        [log2(P_MAX_LINE_LENGTH)-1:0] vals_counter;
   reg                                steep;
   reg          [P_LINE_LENGTH_W-1:0] line_length;
   
   integer i;
   
   genvar j;
   generate
      for (j=0; j<P_MAX_LINE_LENGTH; j=j+1) begin : OUTPUT_GEN
         assign o_x_vals[(j+1)*P_X_COORD_W-1:j*P_X_COORD_W] = x_vals[j];//x_vals_reg[j];
         assign o_y_vals[(j+1)*P_Y_COORD_W-1:j*P_Y_COORD_W] = y_vals[j];//y_vals_reg[j];
      end
   endgenerate
   
   assign o_vals_valid = vals_valid;//vals_valid_reg;
   assign o_vals_rdy   = vals_rdy;

   always @(posedge i_clk)
   begin
      if (i_reset) begin
         x              <= 'b0;
         x0             <= 'b0;
         x1             <= 'b0;
         y              <= 'b0;
         y0             <= 'b0;
         y1             <= 'b0;
         error          <= 'b0;
         vals_valid     <= 'b0;
         //vals_valid_reg <= 'b0;
         vals_counter   <= 'b0;
         line_length    <= 'b0;
         curr_state     <= STATE__WAITING;
      end else begin
         vals_rdy       <= 0;
         x0             <= x0;
         x1             <= x1;
         y0             <= y0;
         y1             <= y1;
         error          <= error;
         vals_valid     <= vals_valid;
         //vals_valid_reg <= vals_valid_reg;
         vals_counter   <= vals_counter;
         curr_state     <= next_state;
         line_length    <= line_length;

         case (curr_state)
            STATE__WAITING : begin
               // Load input coordinates into registers
               if (i_load_vals) begin
                  x0             <= i_x0;
                  x1             <= i_x1;
                  y0             <= i_y0;
                  y1             <= i_y1;
                  error          <= 'b0;
                  vals_valid     <= 'b0;
                  vals_counter   <= 'b0;
                  line_length    <= 'b0;
               end
            end
            STATE__SETUP_IS_STEEP : begin
               // Determine if the slope of the line is steep 
               //  (i.e. abs(slope) > 1)
               if (y1 > y0) begin
                  if (x1 > x0) begin 
                     steep <= (y1-y0) > (x1-x0);
                  end else begin
                     steep <= (y1-y0) > (x0-x1);
                  end
               end else begin
                  if (x1 > x0) begin 
                     steep <= (y0-y1) > (x1-x0);
                  end else begin
                     steep <= (y0-y1) > (x0-x1);
                  end
               end
            end
            STATE__SETUP_REV_COORDS : begin
               // Adjust the coordinates to draw line with
               // a slope that is positive and less than 1
               if (steep) begin
                  if (y0 > y1) begin
                     x0      <= y1;
                     x1      <= y0;
                     y0      <= x1;
                     y1      <= x0;
                     delta_x <= y0-y1;
                     delta_y <= (x1>x0 ? x1-x0 : x0-x1);
                  end else begin
                     x0      <= y0;
                     x1      <= y1;
                     y0      <= x0;
                     y1      <= x1;
                     delta_x <= y1-y0;
                     delta_y <= (x1>x0 ? x1-x0 : x0-x1);
                  end
               end else begin
                  if (x0 > x1) begin
                     x0      <= x1;
                     x1      <= x0;
                     y0      <= y1;
                     y1      <= y0;
                     delta_x <= x0-x1;
                     delta_y <= (y1>y0 ? y1-y0 : y0-y1);
                  end else begin
                     delta_x <= x1-x0;
                     delta_y <= (y1>y0 ? y1-y0 : y0-y1);
                  end
               end
            end
            STATE__SETUP_ERROR_AND_STEP : begin
               error       <= error >>> 1;
               ystep       <= (y0<y1 ? 1 : -1);
               x           <= x0;
               y           <= y0;
               //line_length <= (delta_x > delta_y) ? delta_x : delta_y;
            end
            STATE__DRAWING : begin
               if (steep) begin
                  x_vals[vals_counter] <= y;
                  y_vals[vals_counter] <= x;
               end else begin
                  x_vals[vals_counter] <= x;
                  y_vals[vals_counter] <= y;
               end
               
               vals_valid[vals_counter] <= 1;
               vals_counter             <= vals_counter+1;
               x                        <= x+1;
               
               if (error-delta_y < 0) begin
                  error <= error-delta_y + delta_x;
                  y     <= y+ystep;
               end else begin
                  error <= error-delta_y;
               end
               
               if (x==x1) begin
                  vals_rdy       <= 1;
                  //vals_valid_reg <= 'b0;
                  /*
                  for(i=0; i < P_MAX_LINE_LENGTH; i=i+1) begin
                     x_vals_reg[i]     <= x_vals[i];
                     y_vals_reg[i]     <= y_vals[i];
                     vals_valid_reg[i] <= vals_valid[i];
                  end
                  if (steep) begin
                     x_vals_reg[vals_counter]     <= y;
                     y_vals_reg[vals_counter]     <= x;
                     vals_valid_reg[vals_counter] <= 1;
                  end else begin
                     x_vals_reg[vals_counter]     <= x;
                     y_vals_reg[vals_counter]     <= y;
                     vals_valid_reg[vals_counter] <= 1;
                  end
                  */
               end
            end
         endcase
      end
   end
   
   // Next state logic
   always @(curr_state, i_load_vals, x, x1)
   begin
      next_state = curr_state;
      case(curr_state)
         STATE__WAITING : begin
            if (i_load_vals) begin
               next_state = STATE__SETUP_IS_STEEP;
            end 
         end
         STATE__SETUP_IS_STEEP : begin
            next_state = STATE__SETUP_REV_COORDS;
         end
         STATE__SETUP_REV_COORDS : begin
            next_state = STATE__SETUP_ERROR_AND_STEP;
         end
         STATE__SETUP_ERROR_AND_STEP : begin
            next_state = STATE__DRAWING;
         end
         STATE__DRAWING : begin
            if (x == x1) begin
               next_state = STATE__WAITING;
            end 
         end         
      endcase
   end

endmodule
