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
module wallace_tree( // 4-bit Multiplier using Wallace Tree

input	wire	[3:0]	A,
input	wire	[3:0]	B,
output	wire	[7:0]	O
);

wire	[11:0]	s;
wire	[11:0]	c;
reg	p	[3:0]	[3:0];
integer	i,j;

 always	@(A or B) begin // setting p[j][i]
	for(i=0; i<=3; i=i+1)
	for(j=0; j<=3; j=j+1)

p[j][i]	<= A[j]	& B[i];

 end
// Half Adder instantiation
half_adder	HA1(
		.A(p[0][1]),
		.B(p[1][0]),
		.S(s[0]),
		.C(c[0])
		);
// it's critical error. I mistake adding carry.
/*
half_adder	HA2(
		.A(s[5]),
		.B(c[4]),
		.S(s[8]),
		.C(c[5])
		);

half_adder	HA3(
		.A(s[6]),
		.B(c[5]),
		.S(s[9]),
		.C(c[6])
		);

half_adder	HA4(
		.A(s[7]),
		.B(c[6]),
		.S(s[10]),
		.C(c[7])
		);

half_adder	HA5(
		.A(p[3][3]),
		.B(c[7]),
		.S(s[11]),
		.C(c[8])
		);
*/
// Full Adder Instantiation
full_adder	FA1(
		.A(p[0][2]),
		.B(p[1][1]),
		.Cin(p[2][0]),
		.S(s[1]),
		.C(c[1])
		);

full_adder	FA2(
		.A(p[0][3]),
		.B(p[1][2]),
		.Cin(p[2][1]),
		.S(s[2]),
		.C(c[2])
		);

full_adder	FA3(
		.A(1'b0),
		.B(p[1][3]),
		.Cin(p[2][2]),
		.S(s[3]),
		.C(c[3])
		);

full_adder	FA4(
		.A(s[1]),
		.B(c[0]),
		.Cin(1'b0),
		.S(s[4]),
		.C(c[4])
		);

full_adder	FA5(
		.A(s[2]),
		.B(c[1]),
		.Cin(p[3][0]),
		.S(s[5]),
		.C(c[5])
		);

full_adder	FA6(
		.A(s[3]),
		.B(c[2]),
		.Cin(p[3][1]),
		.S(s[6]),
		.C(c[6])
		);

full_adder	FA7(
		.A(p[2][3]),
		.B(c[3]),
		.Cin(p[3][2]),
		.S(s[7]),
		.C(c[7])
		);

full_adder	FA8(
		.A(s[5]),
		.B(c[4]),
		.Cin(1'b0),
		.S(s[8]),
		.C(c[8])
		);

full_adder	FA9(
		.A(s[6]),
		.B(c[5]),
		.Cin(c[8]),
		.S(s[9]),
		.C(c[9])
		);

full_adder	FA10(
		.A(s[7]),
		.B(c[6]),
		.Cin(c[9]),
		.S(s[10]),
		.C(c[10])
		);

full_adder	FA11(
		.A(p[3][3]),
		.B(c[7]),
		.Cin(c[10]),
		.S(s[11]),
		.C(c[11])
		);

// Output Setting
assign	O[0]	=	p[0][0];
assign	O[1]	=	s[0];
assign	O[2]	=	s[4];
assign	O[3]	=	s[8];
assign	O[4]	=	s[9];
assign	O[5]	=	s[10];
assign	O[6]	=	s[11];
assign	O[7]	=	c[11];
	
endmodule

// Stimulus for Test Bench

module tb;
reg	[3:0]	A;
reg	[3:0]	B;
wire	[7:0]	O;

wallace_tree	UUT( // Unit Under Test
		.A(A),
		.B(B),
		.O(O)
		);

initial	begin

	A = 4'b0000; B = 4'b0000; #10;
	A = 4'b0010; B = 4'b0100; #10;
	A = 4'b0111; B = 4'b0111; #10;
	A = 4'b0001; B = 4'b1100; #10;
	A = 4'b0011; B = 4'b0110; #10;
	A = 4'b0001; B = 4'b1111; #10;
	A = 4'b1111; B = 4'b1111; #10;
	A = 4'b1101; B = 4'b0100; #10;

end

initial	begin

$display("A	|	B	|	Out");
$monitor("%b	|	%b	|	%b", A,B,O);

end

initial	begin

$dumpfile("wallace_tree.vcd");
$dumpvars;
#90
$finish;
end

endmodule




