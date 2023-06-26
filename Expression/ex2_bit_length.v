module test;

	reg	[3:0]	a, b;
	reg	[7:0]	c;

// 10 = 1010(2), 7 = 0111(2)
// 10 * 7 = 70 = 1000110(2)


	initial begin
		a= 4'd10;
		b= 4'd7;
		$display("a*b=%d", a*b);
// 6
// a, b are 4 bit. So calc's result is 4 bit. 0110(2)
		c= a*b;
		$display("a*b=%d", c);
// 70
		c= {a*b};
		$display("a*b=%d", c);
// 6
	end

	endmodule
