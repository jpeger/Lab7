`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:23:54 08/24/2015 
// Design Name: 
// Module Name:    control 
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
module control(
	state,
	clk,
	rst_n,
	button
);

output [3:0]state;
input clk,rst_n;
input button;

reg [3:0]state,next_state;

always@(posedge clk or negedge rst_n)
	if(~rst_n)
		state <= 4'b0001;
	else
		state <= next_state;
		
always@(*)		
  case(state)
	4'b0001: 
		if(button==1'b1) begin
			next_state = 4'b0010;
		end
		else begin
			next_state = state;
		end
	4'b0010: 
		if(button==1'b1) begin
			next_state = 4'b0100;
		end
		else begin
			next_state = state;
		end
	4'b0100: 
		if(button==1'b1) begin
			next_state = 4'b1000;
		end
		else begin
			next_state = state;
		end
	4'b1000: 
		if(button==1'b1) begin
			next_state = 4'b0001;
		end
		else begin
			next_state = state;
		end
	default: begin
		next_state = 4'b1000;
	end
  endcase
		

endmodule
