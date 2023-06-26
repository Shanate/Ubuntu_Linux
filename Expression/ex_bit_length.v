module	test1;

reg	[3:0]	a, b;
wire	[3:0]	result;

assign	result	=	(a+b)>>1;

initial begin
	a	=	4'd10;
	b	=	4'd7;
	#1
	$display("result=%d", result);
end

endmodule
// result = 0
// a = 10, b = 7 => result = 17
// but, 17 is expressed 10001(2) in origin.
// however, we define result as 4-bit. So 10001(2) is 0001(2).
// Then, it operates (>>), 0000(2).

module test2;

reg [3:0] a, b;
wire	[3:0] result;

assign	result	=	(a+b+0)>>1;

initial begin
	a	=	4'd10;
	b	=	4'd7;
	#1
	$display("result=%d", result);
end

endmodule
// result = 8
// 0 is same a integer. It means that 0 is 32-bit.
// no matter waht a and b are 4-bit, it is expressed the 32-bit.
// So, it purely defines result as 32-bit. 10001(2)
// it operates 10001(2) >>. 1000(2) = 8

