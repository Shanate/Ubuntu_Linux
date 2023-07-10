//64 bit Carry Look Ahead Project 
module Carry_Look_Ahead_64bit(
	input	[63:0]	A, B,
	input		Cin,
	output	[63:0]	S,
	output		Cout
);
	wire	[7:1]	C;

Carry_Look_Ahead_8bit CLA1(.A(A[7:0]),   .B(B[7:0]),   .Cin(Cin), .S(S[7:0]),   .Cout(C1));
Carry_Look_Ahead_8bit CLA2(.A(A[15:8]),  .B(B[15:8]),  .Cin(C1),  .S(S[15:8]),  .Cout(C2));
Carry_Look_Ahead_8bit CLA3(.A(A[23:16]), .B(B[23:16]), .Cin(C2),  .S(S[23:16]), .Cout(C3));
Carry_Look_Ahead_8bit CLA4(.A(A[31:24]), .B(B[31:24]), .Cin(C3),  .S(S[31:24]), .Cout(C4));
Carry_Look_Ahead_8bit CLA5(.A(A[39:32]), .B(B[39:32]), .Cin(C4),  .S(S[39:32]), .Cout(C5));
Carry_Look_Ahead_8bit CLA6(.A(A[47:40]), .B(B[47:40]), .Cin(C5),  .S(S[47:40]), .Cout(C6));
Carry_Look_Ahead_8bit CLA7(.A(A[55:48]), .B(B[55:48]), .Cin(C6),  .S(S[55:48]), .Cout(C7));
Carry_Look_Ahead_8bit CLA8(.A(A[63:56]), .B(B[63:56]), .Cin(C7),  .S(S[63:56]), .Cout(Cout));

endmodule

//8-bit Carry Look Ahead Adder 

module Carry_Look_Ahead_8bit(
	input	[7:0]	A, B,
	input		Cin,
	output	[7:0]	S,
	output		Cout
);

	wire	[7:0]	C;
	wire	[7:0]	P, G;

assign	P = A ^ B; // Propagate formula
assign	G = A & B; // Generate formula


//C(i+1) = G(i) + P(i)C(i)
assign C[0] = Cin;
assign C[1] = G[0] | (P[0]&C[0]);
assign C[2] = G[1] | P[1]&G[0] | P[1]&P[0]&C[0];
assign C[3] = G[2] | P[2]&G[1] | P[2]&P[1]&G[0] | P[2]&P[1]&P[0]&C[0];
assign C[4] = G[3] | P[3]&G[2] | P[3]&P[2]&G[1] | P[3]&P[2]&P[1]&G[0] | P[3]&P[2]&P[1]&P[0]&C[0];
assign C[5] = G[4] | P[4]&G[3] | P[4]&P[3]&G[2] | P[4]&P[3]&P[2]&G[1] | P[4]&P[3]&P[2]&P[1]&G[0] | P[4]&P[3]&P[2]&P[1]&P[0]&C[0];
assign C[6] = G[5] | P[5]&G[4] | P[5]&P[4]&G[3] | P[5]&P[4]&P[3]&G[2] | P[5]&P[4]&P[3]&P[2]&G[1] | P[5]&P[4]&P[3]&P[2]&P[1]&G[0] | P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&C[0];
assign C[7] = G[6] | P[6]&G[5] | P[6]&P[5]&G[4] | P[6]&P[5]&P[4]&G[3] | P[6]&P[5]&P[4]&P[3]&G[2] | P[6]&P[5]&P[4]&P[3]&P[2]&G[1] | P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0] | P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&C[0];
assign Cout = G[7] | P[7]&G[6] | P[7]&P[6]&G[5] | P[7]&P[6]&P[5]&G[4] | P[7]&P[6]&P[5]&P[4]&G[3] | P[7]&P[6]&P[5]&P[4]&P[3]&G[2] | P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&G[1] | P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&G[0] | P[7]&P[6]&P[5]&P[4]&P[3]&P[2]&P[1]&P[0]&C[0];
assign S = P ^ C;


endmodule

////Testbench
module TB;
	reg	[63:0]	A, B;
	reg		Cin;
	wire	[63:0]	S;
	wire		Cout;

Carry_Look_Ahead_64bit UUT(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));

initial begin

	A = 64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
	B = 64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
	Cin = 1'b0;
	#10

	A = 64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000001;
	B = 64'b00000000_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
	Cin = 1'b0;
	#10
	
	A = 64'b00000000_00000000_00000000_00000000_00011000_11110000_00000000_10000000;
	B = 64'b00000000_00000000_00000000_00000000_11110000_10000000_00000001_00000000;
	Cin = 1'b0;
	#10

	A = 64'b11111000_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
	B = 64'b00111111_00000000_00000000_00000000_00000000_00000000_00000000_00000000;
	Cin = 1'b0;
	
end

initial begin

	$display("A	|	B	|	Out");
	$monitor("%b	|	%b	|	%b",	A, B, S);

end

initial begin

	$dumpfile("CLA.vcd");
	$dumpvars;
	#60
	$finish;

end

endmodule
