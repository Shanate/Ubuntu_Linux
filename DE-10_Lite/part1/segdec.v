module	segdec(

	input	wire	[1:0]	c,
	output	reg		[6:0]	o

);

always	@*
	case(c) // LED ON = 0, LED OFF = 1
		2'b00 : o = 7'b0100001; // d
		2'b01 : o = 7'b0000110; // E
		2'b10 : o = 7'b1111001; // 1
		2'b11 : o = 7'b1000000; // 0
	endcase


endmodule
