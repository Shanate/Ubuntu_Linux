`timescale 1ns/1ps

module updowncounter(
	input	wire	clk,
	input	wire	mode,
	input	wire	rst,
	output	reg	signed	[3:0]	val
);

wire	signed	[3:0]	next_val;

always @(posedge clk)
	if(rst)	val <= 4'sd0;
	else val	<= next_val;

assign	next_val	=	mode ? (val + 1'b1) : (val - 1'b1);

endmodule

module	tb;

	reg	clk;
	reg	mode;
	reg	rst;
	wire	signed	[3:0]	val;

	updowncounter u0(.clk(clk), .mode(mode), .rst(rst), .val(val));

	initial begin
	clk = 1'b0;
	forever #10 clk = ~clk;

	end

	initial begin
	rst = 1'b0;
	#13
	rst = 1'b1;
	#20
	rst = 1'b0;

	end

	initial begin
			mode = 1'b1;
		end

	initial begin
		$monitor("%d  ||||  %b", val, val);
	end

	initial begin
		$dumpfile("updowncounter.vcd");
		$dumpvars;
		#500
		$finish;
	end

	endmodule
