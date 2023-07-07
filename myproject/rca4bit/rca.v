module half_adder( //Half Adder

input	A, B, // Input Data
output	S, C //S is Sum, C is Carry
);

assign	C = A & B; // AND operation
assign	S = A ^ B; // XOR operation

endmodule

////////////////////////////

module full_adder( //Full Adder

input	A, B, Cin, // Input Data
output	S, C

);


	wire	S1,S2,C1,C2;
//	wire	S, C;
// instantiation
half_adder	ha1(
		.A(A),
		.B(B), 
		.S(S1), 
		.C(C1));
half_adder	ha2(
		.A(Cin), 
		.B(S1), 
		.S(S2), 
		.C(C2));


assign	S = S2;
assign	C = C1 | C2;

endmodule


///////////////////////////////////

module ripple_carry_adder_4bit(
input	wire	[3:0]	A,
input	wire	[3:0]	B,
output	wire	[4:0]	O
);

wire	[3:0]	c;
wire	[3:0]	s;

full_adder	FA1(
		.A(A[0]),
		.B(B[0]),
		.Cin(1'b0),
		.S(s[0]),
		.C(c[0])
		);

full_adder	FA2(
		.A(A[1]),
		.B(B[1]),
		.Cin(c[0]),
		.S(s[1]),
		.C(c[1])
		);

full_adder	FA3(
		.A(A[2]),
		.B(B[2]),
		.Cin(c[1]),
		.S(s[2]),
		.C(c[2])
		);

full_adder	FA4(
		.A(A[3]),
		.B(B[3]),
		.Cin(c[2]),
		.S(s[3]),
		.C(c[3])
		);

// Output Setting
assign	O[0]	=	s[0];
assign	O[1]	=	s[1];
assign	O[2]	=	s[2];
assign	O[3]	=	s[3];
assign	O[4]	=	c[3]; // Final Carry Out

endmodule


// Stimulus for Test Bench

module	tb;
reg	[3:0]	A, B;
wire	[4:0]	O;


ripple_carry_adder_4bit	UUT( // Unit Under Test
			.A(A),
			.B(B),
			.O(O)
			);

initial begin
	#10	
	A = 4'b0000;	B = 4'b0000;
	#10
	A = 4'b0001;	B = 4'b0010;
	#10
	A = 4'b1000;	B = 4'b1111;
	#10
	A = 4'b0111;	B = 4'b1100;
	#10
	A = 4'b1111;	B = 4'b1111;
	#10
	A = 4'b0011;	B = 4'b0101;
	#10
	A = 4'b1010;	B = 4'b0010;
	#10
	A = 4'b0101;	B = 4'b1010;
	

end

initial begin

$display("|	A	|	B	|	Output     |");
$monitor("|	%b	|	%b	|	%b         |", A, B, O);

end

initial begin

$dumpfile("rca.vcd");
$dumpvars;
#100

$finish;
end

endmodule



