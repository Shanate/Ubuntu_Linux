module anothercounter(

	input	wire	en, // active high
	input	wire	clk,
	input	wire	rst, // active high async
	output	reg		[15:0]	q
);

	always	@(posedge clk, posedge rst)
	
		if(rst)	q <=	16'd0;
		else	if(en) q <= q + 1'b1;

endmodule
