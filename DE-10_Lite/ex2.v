ex2 u0(.nrst(KEY[0]), .clk(MAX10_CLK1_50), .msb_q(LEDR[0]));


module ex2(

	input	wire 	nrst,
	input	wire	clk,
	output	wire	msb_q

);

reg	[25:0] q;	// clk cycle

always @(posedge clk)
	if(~nrst) q <=0;
	else	q	<=q+1'b1;

	assign	msb_q = q[25];

endmodule
