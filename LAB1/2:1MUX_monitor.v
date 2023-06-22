// 2-to-1 Multiplexer with a Select input s.
// If s=0, multiplexer's output m is equal to the input x, and if s=1, the output is equal to y.
// Verilog statement : assign m = (~s & x) | (s & y);

module MUX1(

	input	wire	x,
	input	wire	y,
	input	wire	s,
	output	wire	m

);

assign m = s ? y : x; // (s = 1) => y , (s = 0) => x

// second case, if you want to use not 'wire' but 'reg'
// you should use 'output reg m' & 'always sentence'
// always @*
// m = s ? y : x;
// However, Why use the Procedure Block? It's very easy code. So We had better use the Continuous Block.
endmodule


module MUX4(

	input	wire	[3:0]	x,
	input	wire	[3:0]	y,
	input	wire	[0:0]	s,
	output	wire	[3:0]	m

);

MUX1	u0	(.x(x[0]), .y(y[0]), .s(s), .m(m[0]));
MUX1	u1	(.x(x[1]), .y(y[1]), .s(s), .m(m[1]));
MUX1	u2	(.x(x[2]), .y(y[2]), .s(s), .m(m[2]));
MUX1	u3	(.x(x[3]), .y(y[3]), .s(s), .m(m[3]));

endmodule



	module	tb;

	reg	[3:0]	x;
	reg	[3:0]	y;
	reg	s;
	wire	[3:0]	m;

MUX4	u0	(.x(x), .y(y), .s(s), .m(m));


	initial	begin
		x = 4'd0; y= 4'd0; s= 1'b0;
		#10
		x = 4'd1; y= 4'd2; s= 1'b0;
		#20
		x = 4'd3; y= 4'd4; s= 1'b1;
		end

	initial begin
	$monitor("%d	|	%d	|	%d	|	%d",x,y,s,m);
	end

	initial	begin
		$dumpfile("2:1MUX_monitor.vcd");
		$dumpvars;
	#100 $finish;
	end

endmodule

