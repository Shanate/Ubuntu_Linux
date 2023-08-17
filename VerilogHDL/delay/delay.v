module	D(
input	a, b, c,
output	out
);

wire	e;

and	#(5) a1(e, a, b);
or	#(4) o1(out, e, c);

endmodule

module	tb;

reg	A, B, C;
wire	Output;

D	D1(
	.a(A),
	.b(B),
	.c(C),
	.out(Output)
	);

initial	begin

A = 1'b0; B = 1'b0; C = 1'b0;
#10
A = 1'b1; B = 1'b1; C = 1'b1;
#10
A = 1'b1; B = 1'b0; C = 1'b0;
#10
$finish;

end

initial begin
$dumpfile("delay.vcd");
$dumpvars;
end


endmodule


