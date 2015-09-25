`timescale 1ns / 1ps

module lab7(
	ftsd_ctl,
	ftseg,
	clk,
	rst_n,
	button,
	plus,
	ampm
);

output [3:0]ftsd_ctl;
output [14:0]ftseg;

input clk,rst_n;
input button,plus;
input ampm;

wire [25:0]cnt;
wire [3:0]bcd;
wire [3:0]state;
wire [3:0]scan_in0,scan_in1,scan_in2,scan_in3;
wire [3:0]year0,year1,year2,year3;
wire [3:0]mon0,mon1,day0,day1;
wire [3:0]hour0,hour1,hour2,hour3;

freq_div U0(
	.clk(clk),
	.rst_n(rst_n),
	.cnt(cnt)
);

control U1(
	.state(state),
	.clk(cnt[23]),
	.rst_n(rst_n),
	.button(~button)
);

timer U2(
	.year0(year0),
	.year1(year1),
	.year2(year2),
	.year3(year3),
	.mon0(mon0),
	.mon1(mon1),
	.day0(day0),
	.day1(day1),
	.hour0(hour0),
	.hour1(hour1),
	.hour2(hour2),
	.hour3(hour3),
	.clk(cnt[23]),
	.rst_n(rst_n),
	.hour_en(state[3]),
	.day_en(state[2]),
	.mon_en(state[1]),
	.year_en(state[0]),
	.plus(~plus),
	.ampm(ampm)
);

scan_mux U4(
	.out0(scan_in0),
	.out1(scan_in1),
	.out2(scan_in2),
	.out3(scan_in3),
	.year0(year0),
	.year1(year1),
	.year2(year2),
	.year3(year3),
	.mon0(mon0),
	.mon1(mon1),
	.day0(day0),
	.day1(day1),
	.hour0(hour0),
	.hour1(hour1),
	.hour2(hour2),
	.hour3(hour3),
	.hour_en(state[3]),
	.day_en(state[2]),
	.mon_en(state[1]),
	.year_en(state[0])
);

scan_ctl U5(
	.ftsd_ctl(ftsd_ctl),
	.ftsd_in(bcd),
	.in0(scan_in0),
	.in1(scan_in1),
	.in2(scan_in2),
	.in3(scan_in3),
	.ftsd_ctl_en(cnt[15:14])
);

bcd2ftsegdec U6(
	.display(ftseg),
	.bcd(bcd)
);

endmodule
