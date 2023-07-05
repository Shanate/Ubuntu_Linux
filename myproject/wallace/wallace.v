/*module wallace(

input	wire	[3:0]	A, B, // Input Data
output	wire	[7:0]	prod;

);

	wire	[11:0]	s,c;

endmodule
//////////////////////////////////////
*/
module ha( //Half Adder

input	A, B, // Input Data
output	S, C //S is Sum, C is Carry
);

assign	C = A & B; // AND operation
assign	S = ~(A | B); // XOR operation

endmodule

////////////////////////////

module fa( //Full Adder

input	A, B, Cin, // Input Data
output	S, C

);


	wire	S1,S2,C1,C2;
	wire	Data_Sum, Data_Carry;
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


assign	Data_Sum = S2;
assign	Data_Carry = C1 | C2;

endmodule


///////////////////////////////////
module TB;

reg	A,B,C;
wire	Data_Sum, Data_Carry;

fa	u0(
	.A(A), 
	.B(B), 
	.Cin(C), 
	.S(Data_Sum), 
	.C(Data_Carry));


initial begin


	A = 0; B = 0; C = 0; #10;
	A = 0; B = 0; C = 1; #10;
	A = 0; B = 1; C = 0; #10;
	A = 0; B = 1; C = 1; #10;
	A = 1; B = 0; C = 0; #10;
	A = 1; B = 0; C = 1; #10;
	A = 1; B = 1; C = 0; #10;
	A = 1; B = 1; C = 1; #10;
end

initial	begin
$monitor("%b	|	%b	|	%b	|	%b	|	%b",
	A,B,C,Data_Sum,Data_Carry);
end

initial begin

	$dumpfile("FA.vcd");
	$dumpvars;
	#100
	$finish;
	end



endmodule
