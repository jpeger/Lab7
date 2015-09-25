`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:24:40 08/23/2015 
// Design Name: 
// Module Name:    timer 
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
module timer(
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
	clk,
	rst_n,
	hour_en,
	day_en,
	mon_en,
	year_en,
	plus,
	ampm
);

output [3:0]year0,year1,year2,year3;
output [3:0]mon0,mon1,day0,day1;
output [3:0]hour0,hour1,hour2,hour3;
input clk,rst_n;
input hour_en,day_en,mon_en,year_en;
input plus,ampm;

reg [3:0]year0,year1,year2,year3,next_year0,next_year1,next_year2,next_year3;;
reg [3:0]mon0,mon1,next_mon0,next_mon1,day0,day1,next_day0,next_day1;
reg [3:0]hour0,hour1,hour2,hour3,next_hour0,next_hour1,next_hour2,next_hour3;

always@(posedge clk or negedge rst_n)
	if(~rst_n) begin
		year0 <= 4'd0;
		year1 <= 4'd0;
		year2 <= 4'd0;
		year3 <= 4'd2;
		mon0 <= 4'd1;
		mon1 <= 4'd0;
		day0 <= 4'd1;
		day1 <= 4'd0;
		hour0 <= 4'd0;
		hour1 <= 4'd0;
		hour2 <= 4'd0;
		hour3 <= 4'd0;
	end
	else begin
		year0 <= next_year0;
		year1 <= next_year1;
		year2 <= next_year2;
		year3 <= next_year3;
		mon0 <= next_mon0;
		mon1 <= next_mon1;
		day0 <= next_day0;
		day1 <= next_day1;
		hour0 <= next_hour0;
		hour1 <= next_hour1;
		hour2 <= next_hour2;
		hour3 <= next_hour3;
	end

always@(*)
	if(year_en==1'b1 && plus==1'b1) begin
		if(year3==4'd2 && year2==4'd2 && year1==4'd0 && year0==4'd0) begin
			next_year0 = 4'd0;
			next_year1 = 4'd0;
			next_year2 = 4'd0;
			next_year3 = 4'd2;
		end
		else if(year1==4'd9 && year0==4'd9) begin
			next_year0 = 4'd0;
			next_year1 = 4'd0;
			next_year2 = year2 + 4'd1;
			next_year3 = year3;
		end
		else if(year1!=4'd9 && year0==4'd9) begin
			next_year0 = 4'd0;
			next_year1 = year1 + 4'd1;
			next_year2 = year2;
			next_year3 = year3;
		end
		else begin
			next_year0 = year0 + 4'd1;
			next_year1 = year1;
			next_year2 = year2;
			next_year3 = year3;
		end
	end
	else begin
		next_year0 = year0;
		next_year1 = year1;
		next_year2 = year2;
		next_year3 = year3;
	end

always@(*)
	if(mon_en==1'b1 && plus==1'b1) begin
		if(mon1==4'd1 && mon0==4'd2) begin
			next_mon0 = 4'd1;
			next_mon1 = 4'd0;
		end
		else if(mon0==4'd9) begin
			next_mon0 = 4'd0;
			next_mon1 = 4'd1;
		end
		else begin
			next_mon0 = mon0 + 4'd1;
			next_mon1 = mon1;
		end
	end
	else begin
		next_mon0 = mon0;
		next_mon1 = mon1;
	end
	
always@(*)
	if((year_en==1'b1 && plus==1'b1)||(mon_en==1'b1 && plus==1'b1)) begin
		next_day0 = 4'd1;
		next_day1 = 4'd0;
	end
	else if(day_en==1'b1 && plus==1'b1) begin
		if(day1==4'd0 && day0==4'd9) begin
			next_day0 = 4'd0;
			next_day1 = day1 + 4'd1;
		end
		else if(day1==4'd1 && day0==4'd9) begin
			next_day0 = 4'd0;
			next_day1 = day1 + 4'd1;
		end
		else if(day1==4'd2 && day0==4'd8 && mon1==4'd0 && mon0==4'd2) begin
			if(year0==4'd0||year0==4'd4||year0==4'd8) begin
				if(year1==4'd0||year1==4'd2||year1==4'd4||year1==4'd6||year1==4'd8)begin
					next_day0 = 4'd9;
					next_day1 = 4'd2;
				end
				else begin
					next_day0 = 4'd1;
					next_day1 = 4'd0;
				end
			end
			else if(year0==4'd2||year0==4'd6) begin
				if(year1==4'd1||year1==4'd3||year1==4'd5||year1==4'd7||year1==4'd9)begin
					next_day0 = 4'd9;
					next_day1 = 4'd2;
				end
				else begin
					next_day0 = 4'd1;
					next_day1 = 4'd0;
				end
			end
			else begin
				next_day0 = 4'd1;
				next_day1 = 4'd0;
			end
		end
		else if(day1==4'd2 && day0==4'd9) begin
			if(mon1==4'd0 && mon0==4'd2)begin
				next_day0 = 4'd1;
				next_day1 = 4'd0;
			end
			else begin
				next_day0 = 4'd0;
				next_day1 = day1 + 4'd1;
			end
		end
		else if(day1==4'd3 && day0==4'd0) begin
			if((mon1==4'd0 && mon0==4'd4)||
				(mon1==4'd0 && mon0==4'd6)||
				(mon1==4'd0 && mon0==4'd9)||
				(mon1==4'd1 && mon0==4'd1)) begin
				next_day0 = 4'd1;
				next_day1 = 4'd0;
			end
			else begin
				next_day0 = 4'd1;
				next_day1 = 4'd3;
			end
		end
		else if(day1==4'd3 && day0==4'd1) begin
			next_day0 = 4'd1;
			next_day1 = 4'd0;
		end
		else begin
			next_day0 = day0 + 4'd1;
			next_day1 = day1;
		end
	end
	else begin
		next_day0 = day0;
		next_day1 = day1;
	end
	
always@(*)
	if(hour_en==1'b1 && plus==1'b0 && ampm==1'b0) begin	//24hr
		if(hour3==4'd1 && hour2==4'd2 && hour1==4'd10) begin //12AM->00:00 
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = 4'd0;
			next_hour3 = 4'd0;
		end
		else if(hour3==4'd1 && hour2==4'd2 && hour1==4'd11) begin //12PM->12:00
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = hour2;
			next_hour3 = hour3;
		end
		else if(hour1==4'd10) begin //1~11AM->01:00~11:00
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = hour2;
			next_hour3 = hour3;
		end		
		else if(hour1==4'd11) begin //1~11PM->13:00~23:00
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = hour2 + 4'd2;
			next_hour3 = hour3 + 4'd1;
		end
		else begin //24->24
			next_hour0 = hour0;
			next_hour1 = hour1;
			next_hour2 = hour2;
			next_hour3 = hour3;
		end
	end
	else if(hour_en==1'b1 && plus==1'b0 && ampm==1'b1) begin //12hr
		if(hour3==4'd0 && hour2==4'd0 && hour1==4'd0 && hour0==4'd0) begin //00:00->12AM
			next_hour0 = 4'd12;
			next_hour1 = 4'd10;
			next_hour2 = 4'd2;
			next_hour3 = 4'd1;
		end
		else if(hour3==4'd1 && hour2==4'd2 && hour1==4'd0 && hour0==4'd0) begin //12:00->12PM
			next_hour0 = 4'd12;
			next_hour1 = 4'd11;
			next_hour2 = hour2;
			next_hour3 = hour3;
		end
		else if(((hour3==4'd0 && hour2<4'd10)||(hour3==4'd1 && hour2<4'd12))
					&& hour1==4'd0 && hour0==4'd0)begin //01:00~09:00~10:00~11:00->1~11AM
			next_hour0 = 4'd12;
			next_hour1 = 4'd10;
			next_hour2 = hour2;
			next_hour3 = hour3;
		end
		else if(((hour3==4'd1 && hour2>4'd2)||(hour3==4'd1 && hour2>4'd2))
					&& hour1==4'd0 && hour0==4'd0)begin //13:00~19:00~20:00~23:00->1~11PM
			next_hour0 = 4'd12;
			next_hour1 = 4'd11;
			next_hour2 = hour2 - 4'd2;
			next_hour3 = hour3 - 4'd1;
		end
		else begin //12->12
			next_hour0 = hour0;
			next_hour1 = hour1;
			next_hour2 = hour2;
			next_hour3 = hour3;
		end 
	end
	else if(hour_en==1'b1 && plus==1'b1 && ampm==1'b0) begin //24hr mode
		if(hour3==4'd2 && hour2==4'd3) begin
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = 4'd0;
			next_hour3 = 4'd0;
		end
		else if(hour3!=4'd2 && hour2==4'd9) begin
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = 4'd0;
			next_hour3 = hour3 + 4'd1;
		end
		else begin
			next_hour0 = 4'd0;
			next_hour1 = 4'd0;
			next_hour2 = hour2 + 4'd1;
			next_hour3 = hour3;
		end
	end
	else if(hour_en==1'b1 && plus==1'b1 && ampm==1'b1) begin //AM,PM mode
		if(hour3==4'd1 && hour2==4'd1 && hour1==4'd10) begin // 11AM->12PM
			next_hour0 = 4'd12;	//M
			next_hour1 = 4'd11;	//P
			next_hour2 = hour2 + 4'd1;
			next_hour3 = hour3;
		end
		else if(hour3==4'd1 && hour2==4'd1 && hour1==4'd11) begin // 11PM->12AM
			next_hour0 = 4'd12;	//M
			next_hour1 = 4'd10;	//A
			next_hour2 = hour2 + 4'd1;
			next_hour3 = hour3;
		end
		else if(hour3==4'd1 && hour2==4'd2) begin //12PM->1PM; 12AM->1AM
			next_hour0 = hour0;
			next_hour1 = hour1;
			next_hour2 = 4'd1;
			next_hour3 = 4'd0;
		end
		else if(hour3==4'd0 && hour2==4'd9) begin
			next_hour0 = hour0;
			next_hour1 = hour1;
			next_hour2 = 4'd0;
			next_hour3 = hour3 + 4'd1;
		end
		else begin
			next_hour0 = hour0;
			next_hour1 = hour1;
			next_hour2 = hour2 + 4'd1;
			next_hour3 = hour3;
		end
	end
	else begin
		next_hour0 = hour0;
		next_hour1 = hour1;
		next_hour2 = hour2;
		next_hour3 = hour3;
	end
	
				
			
endmodule
