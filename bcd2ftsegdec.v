`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:49:53 08/13/2015 
// Design Name: 
// Module Name:    bcd2ftsegdec 
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
module bcd2ftsegdec(
	display,
	bcd
);

output [14:0]display;
input [3:0]bcd;
reg [14:0]display;

always@(*) begin
	case(bcd)
		4'd0: display = 15'b0000_0011_1111_111;
		4'd1: display = 15'b1111_1111_1011_011;
		4'd2: display = 15'b0010_0100_1111_111;
		4'd3: display = 15'b0000_1100_1111_111;
		4'd4: display = 15'b1001_1000_1111_111;
		4'd5: display = 15'b0100_1000_1111_111;
		4'd6: display = 15'b0100_0000_1111_111;
		4'd7: display = 15'b0001_1111_1111_111;
		4'd8: display = 15'b0000_0000_1111_111;
		4'd9: display = 15'b0000_1000_1111_111;
		4'd10: display =  15'b0001_0000_1111_111;//A
		4'd11: display =  15'b0011_0000_1111_111;//P
		4'd12: display =  15'b1001_0011_0101_111;//M
		4'd13: display =  15'b1000_0100_1111_111;//D
		4'd14: display =  15'b0110_0000_1111_111;//E
		4'd15: display =  15'b0111_0000_1111_111;//F
		default :display = 15'b1111_1111_1111_111;
	endcase
end


endmodule
