`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:32:36 08/23/2015 
// Design Name: 
// Module Name:    scan_mux 
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
module scan_mux(
	out0,
	out1,
	out2,
	out3,
	year0,
	year1,
	year2,
	year3,
	mon0,
	mon1,
	day0,
	day1,
	hour0,
	hour1,
	hour2,
	hour3,
	hour_en,
	day_en,
	mon_en,
	year_en
);
	 
output [3:0]out0,out1,out2,out3;

input [3:0]year0,year1,year2,year3;
input [3:0]mon0,mon1,day0,day1;
input [3:0]hour0,hour1,hour2,hour3;
input hour_en,day_en,mon_en,year_en;

reg [3:0]out0,out1,out2,out3;


always@(*)
  case({hour_en,day_en,mon_en,year_en})
	4'b0001: begin
		out0 = year0;
		out1 = year1;
		out2 = year2;
		out3 = year3;
	end
	4'b0010: begin
		out0 = day0;
		out1 = day1;
		out2 = mon0;
		out3 = mon1;
	end
	4'b0100: begin
		out0 = day0;
		out1 = day1;
		out2 = mon0;
		out3 = mon1;
	end
	4'b1000: begin
		out0 = hour0;
		out1 = hour1;
		out2 = hour2;
		out3 = hour3;
	end
	default: begin
		out0 = hour0;
		out1 = hour1;
		out2 = hour2;
		out3 = hour3;
	end
  endcase


endmodule
