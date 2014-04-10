`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:56:42 04/08/2014 
// Design Name: 
// Module Name:    CF 
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
module CF(gyroData,y_accel_data,z_accel_data,clk,RST,
			 x_temp,x_final
    );
	 
input gyroData, y_accel_data,z_accel_data,clk,RST;//gyroData read from gyro, y_accel_data and z_accel_data read from accelerometer
output x_temp, x_final;//x_temp = arctan results in degree, x_final=final degree of x axis

wire [15:0] gyroData,y_accel_data,z_accel_data;
wire [15:0] x_out;//arctan results, internal
wire clk;
wire RST;


reg [15:0] x_gyro;//use to do gyro date integral by sumation
reg [15:0] x_temp;
reg [31:0] x_final;

always @ (posedge clk) begin
	if (!RST)begin
	x_gyro <= 0;
	end else 
	x_gyro <= x_gyro + (gyroData >>> 6);//shift six == (1/(sensitivity 2^-7)) * (dt=2^-13)//sensitivity = 8.75m degree/sec//dt=0.0001s
end

arctan x_cc (
	.x_in(y_accel_data),//x and y format 1QN =>XX.XXXXXXXXXXXXXX
	.y_in(z_accel_data),//
	.phase_out(x_out),//out format 2QN =>XXX.XXXXXXXXXXXXX
	.clk(clk)
);


// 180/PI ~= 180/4=45=101101, take first 6 bits that has value, do multiplication, then shift back.
//take from bit 13 but not 15 because arctan maximum=1.57<2, so x_out maximum is e.g. 001.......
always @ (posedge clk) begin
	x_temp = (x_out[13:8]*6'b101101)>>6;
	x_final = ((16'h3D09*x_gyro) + (20'hF0537*x_temp))>>6;//BUG here(x_final ==0): should shift 7, but when x_gyro is small, it effectively shifts out to zero.
																					 //how to get fractional numbers???
	//gyro coe=0.984375=(0.1111110), acc coe=0.015625=0.0000010000
end



endmodule
