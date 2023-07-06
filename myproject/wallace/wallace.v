
module ha( //Half Adder

input	A, B, // Input Data
output	S, C //S is Sum, C is Carry
);

assign	C = A & B; // AND operation
assign	S = A ^ B; // XOR operation

endmodule

////////////////////////////

module fa( //Full Adder

input	A, B, Cin, // Input Data
output	S, C

);


	wire	S1,S2,C1,C2;
//	wire	S, C;
// instantiation
ha	ha1(
	.A(A),
	.B(B), 
	.S(S1), 
	.C(C1));
ha	ha2(
	.A(Cin), 
	.B(S1), 
	.S(S2), 
	.C(C2));


assign	S = S2;
assign	C = C1 | C2;

endmodule


///////////////////////////////////
module TB;

reg	A,B,Cin;
wire	S,C;

fa	u0(
	.A(A), 
	.B(B), 
	.Cin(Cin), 
	.S(S), 
	.C(C));


initial begin


	A = 0; B = 0; Cin = 0; #10;
	A = 0; B = 0; Cin = 1; #10;
	A = 0; B = 1; Cin = 0; #10;
	A = 0; B = 1; Cin = 1; #10;
	A = 1; B = 0; Cin = 0; #10;
	A = 1; B = 0; Cin = 1; #10;
	A = 1; B = 1; Cin = 0; #10;
	A = 1; B = 1; Cin = 1; #10;
end

initial	begin
$display("A	|	B	|	Cin	|	S	|	C");
$monitor("%b	|	%b	|	%b	|	%b	|	%b",
	A,B,Cin,S,C);
end

initial begin

	$dumpfile("FA.vcd");
	$dumpvars;
	#100
	$finish;
	end



endmodule
