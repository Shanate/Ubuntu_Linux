module counter_k	#(
	parameter K	= 20
)
(

	input	wire			clk,
	input	wire			nrst, //active low, asymc
	input	wire			en,
	output	reg		[7:0]	val,
	output	wire			rollover

);

assign	rollover	=	(val	==	(K-1));

always @(posedge clk, negedge nrst)
	if(~nrst)				val	<=	8'd0;
	else	if(en)			val	<=	rollover ? 8'd0 : val + 1'b1;

endmodule
/////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////

module	tb;

	reg	clk;
	reg	nrst;
	reg	en;
	wire	rollover;
	wire	[7:0]	val;

	counter_k	u0(.clk(clk), .nrst(nrst), .val(val), .en(en), .rollover(rollover));

	initial begin
		clk	=	1'b0;
		forever	#10	clk	=	~clk;
	end

	initial begin
		nrst	=	1'b1;
		#13
		nrst	=	1'b0;
		#20
		nrst	=	1'b1;
	end

	initial	begin
		en		=	1'b1;
		#130
		en		=	1'b0;
		#20
		en		=	1'b1;

	end

	initial	begin
		$dumpfile("counter_k.vcd");
		$dumpvars;

		#1000
		$finish;
	end


	endmodule

