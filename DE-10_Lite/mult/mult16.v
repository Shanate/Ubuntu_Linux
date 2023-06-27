module	mult16( // 16bit multiplier with input and output registered

	input	wire	[15:0]	a,
	input	wire	[15:0]	b,
	output	reg		[31:0]	product,
	input	wire			clk
);

			reg		[15:0]	a_;
			reg		[15:0]	b_;

always	@(posedge clk)
	{b_, a_} <= {b, a};

always	@(posedge clk)
	product <= b_ * a_;


endmodule
