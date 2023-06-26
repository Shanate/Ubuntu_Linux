module shift_reg_sequence_det(

	input	wire	w,clk,rst,
	output	wire		z

);

reg		[3:0]	shift_reg;
wire	[3:0]	next_shift_reg	=	{shift_reg[2:0], w};

always	@(posedge clk)
	if(rst)	shift_reg	<=	4'd0;
	else	shift_reg	<=	next_shift_reg;

	assign	z	=	(&shift_reg) | (~|shift_reg);

		endmodule
		
