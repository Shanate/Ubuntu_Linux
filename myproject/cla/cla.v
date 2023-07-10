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
input	wire	[3:0]	P,   // Propagation = A(i) ^ B(i)
input	wire	[3:0]	G,   // Generation = A(i) & B(i)
input	wire		Cin, // Initial Carry In, it means C[0]
output	wire	[4:1]	C,
output	wire		PG,  // PG = P(0)&P(1)&P(2)&P(3)
output	wire		GG   // GG = G(3)+G(2)P(3)+G(1)P(3)P(2)+G(0)P(3)P(2)P(1)
);

//	wire	[4:1]	C; // C(i+1) = G(i) + P(i)C(i)

full_adder FA0(
		.A(A[0]),
		.B(B[0]),
		.Cin(Cin),
		.S(S[0]),
		.C(C[1])
		);

full_adder FA1(
		.A(A[1]),
		.B(B[1]),
		.Cin(C[1]),
		.S(S[1]),
		.C(C[2])
		);

full_adder FA2(
		.A(A[2]),
		.B(B[2]),
		.Cin(C[2]),
		.S(S[2]),
		.C(C[3])
		);

full_adder FA3(
		.A(A[3]),
		.B(B[3]),
		.Cin(C[3]),
		.S(S[3]),
		.C(C[4])
		);


endmodule

///////////////////////////////////
// 64bit Carry Look Ahead Adder Module

module CLA16(
input	wire	[15:0]	A,
input	wire	[15:0]	B,
input	wire	[,
input	wire	[15:0]	S,
output	wire		Cout	

);

//test			wire	[16:1]	C;

CLA4	cla1(
	.P(P[0]),
	.G(G[0]),
	.C(C[0]),
	.PG(),
	.GG()
	);


input	wire	[3:0]	P,   // Propagation = A(i) ^ B(i)
input	wire	[3:0]	G,   // Generation = A(i) & B(i)
input	wire		Cin, // Initial Carry In, it means C[0]
output	wire	[4:1]	C,
output	wire		PG,  // PG = P(0)&P(1)&P(2)&P(3)
output	wire		GG   // GG = G(3)+G(2)P(3)+G(1)P(3)P(2)+G(0)P(3)P(2)P(1)
);

// G : Generation = A * B
// P : Propagation = A ^ B
// C(i+1) = A(i)B(i) + {A(i)+B(i)}C(i) = G(i) + P(i)C(i)
endmodule
