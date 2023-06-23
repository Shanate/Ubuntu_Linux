// requirement : Each digit should be displayed for about 1ms.
// This counter should be incremented by the 50-MHz clock made in the testbench.
// => 1/50M = 20ns Thus, 1ms / 20ns = 50000
// enable signal pops at 50000. ~ 655.35 (log2^50000)


`timescale	10ns/10ns

// for slower counter
module counter_mod10(
	input	wire	en,
	input	wire	clk,
	input	wire	rst, //async
	output	reg	[3:0]	q
);

wire	[3:0] next_q = (q == 4'd9) ? 4'd0 : (q+1'b1);

always @(posedge clk, posedge rst)
	if(rst) q <= 4'd0;
	else if(en)	q <= next_q;

	endmodule


// for faster counter
module counter(
	input	wire	en,
	input	wire	clk,
	input	wire	rst, //async
	output	reg	[15:0]	q
);

wire	[15:0] next_q = q + 1'b1;

always @(posedge clk, posedge rst)
	if(rst) q <= 16'd0;
	else if(en)	q <= next_q;

	endmodule


module	part6(
	input	wire	clk,
	input	wire	rst,
	output	wire	[3:0]	q // 0~9
);

wire	[15:0]	q16;

counter faster_cter(.en(1'b1), .clk(clk), .rst(rst), .q(q16));
counter_mod10 slower_cter(.en(&q16), .clk(clk), .rst(rst), .q(q));

endmodule



module	tb;

reg	clk;
reg	rst;
wire	[3:0]	q;

part6 u0(.clk(clk), .rst(rst), .q(q));

initial begin
	clk	=	1'b0;
	forever	#1	clk = ~clk;
end

initial	begin
	rst	=	1'b0;
	#2
	rst	=	1'b1;
	#2
	rst	=	1'b0;
end

initial begin
	$dumpfile("counter.vcd");
	$dumpvars;
	#1000000
	$finish;
end

endmodule




