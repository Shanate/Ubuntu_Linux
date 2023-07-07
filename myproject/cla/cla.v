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
// 4bit CLA module

module CLA4(
input	wire	[3:0]	P,
input	wire	[3:0]	G,
input	wire		Cin,
output	wire	[3:0]	,
output	wire		Cout
);

	wire	[4:1]	C;

full_adder FA0(
		.A(A[0]),
		.B(B[0]),
		.Cin(Cin),
		.S(S[0]),
		.C(C[0])
		);

full_adder FA1(
		.A(A[1]),
		.B(B[1]),
		.Cin(C[0]),
		.S(S[1]),
		.C(C[1])
		);

full_adder FA2(
		.A(A[2]),
		.B(B[2]),
		.Cin(C[1]),
		.S(S[2]),
		.C(C[2])
		);

full_adder FA3(
		.A(A[3]),
		.B(B[3]),
		.Cin(C[2]),
		.S(S[3]),
		.C(C[3])
		);


endmodule

///////////////////////////////////
// 64bit Carry Look Ahead Adder Module

module CLA64(
input	wire	[63:0]	A,
input	wire	[63:0]	B,
input	wire		Cin,
input	wire	[63:0]	S,
output	wire		Cout	

);

	wire	[16:1]	C;




// G : Generation = A * B
// P : Propagation = A + B
// C(i+1) = A(i)B(i) + {A(i)+B(i)}C(i) = G(i) + P(i)C(i)
endmodule
