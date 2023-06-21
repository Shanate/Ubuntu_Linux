module counter4( // DUT (design under test)
	input	wire	clk,
	output	reg	[3:0]	val,
	input	wire	nrst //active low, async
);

always @(posedge clk or negedge nrst)
	if(~nrst)	val <= 4'd0;
	else	val <= val + 1'b1;

	endmodule


module	tb; // test bench

reg	clk;
reg	nrst;
wire	[3:0]	val;

counter4	u0(.clk(clk), .val(val), .nrst(nrst));


initial begin
	clk		=	1'b0;
	forever	#10	clk = ~clk;
end


initial begin
	nrst	=	1'b1;
	#15
	nrst	=	1'b0;
	#10
	nrst	=	1'b1;
end

initial	begin
		#100
		$finish;
	end

	initial begin
		$monitor(val);
	end

	initial begin
		$dumpfile("counter4.vcd");
		$dumpvars;
	end


endmodule
