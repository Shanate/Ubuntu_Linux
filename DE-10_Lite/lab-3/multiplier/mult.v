module mutl8(
	input	wire	[7:0]	a,
	input	wire	[7:0]	b,
	input	wire			wea,
	input	wire			web,

	output	reg		[7:0]	a_,
	output	reg		[7:0]	b_,

	output	reg		[7:0]	p

	input	wire			clk,
	input	wire			rst // active high, sync

); 

always @(posedge clk)
	if(rst)	{a_, b_} <= 16'd0;
	else if(wea) a_ <= a;
	else if(web) b_ <= b;

always @(posedge clk)
	if(rst) p <= 16'd0;
	else p <= a_ * b_;

	endmodule
