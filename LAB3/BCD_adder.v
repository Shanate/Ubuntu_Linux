module	bcdadder( // X + Y + Cin -> S1S0

	input	wire	[3:0]	X,
	input	wire	[3:0]	Y,
	input	wire			Cin,
	output	wire	[3:0]	S1,
	output	wire	[3:0]	S0


);

wire	[4:0]	sum	= X + Y	+ Cin;

bin2bcd	u0(.i(sum),	.S1(S1), .S0(S0)); // different from bin2bcd in the prev part.

endmodule



module	bin2bcd(
	input	wire	[4:0]	i,
	output	wire	[3:0]	S1,
	output	wire	[3:0]	S0
);

assign	S1	=	(i >= 5'd10) ? 4'd1 : 4'd0;
assign	S0	=	(i >= 5'd10) ? (i - 4'd10) : i;

endmodule

module tb; //TEST BENCH

	reg		[4:0]	i;
	reg		[3:0]	X;
	reg		[3:0]	Y;
	reg		[0:0]	Cin;
	wire	[3:0]	S1;
	wire	[3:0]	S0;

bcdadder	u0(.X(X), .Y(Y), .Cin(Cin),	.S1(S1), .S0(S0));

	initial	begin
		
		X	=	4'd3;	Y	=	4'd5;	Cin	=	0;
		#10
		X	=	4'd7;	Y	=	4'd6;	Cin	=	0;
		#10
		X	=	4'd7;	Y	=	4'd9;	Cin	=	1;
	
	end

	initial begin

		$dumpfile("bcdadder.vcd");
		$dumpvars;
		#100
		$finish;

	end





endmodule
