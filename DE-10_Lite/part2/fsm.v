module fsm(

	input	wire	w,clk,rst,
	output	reg		z

);

parameter	A	=	9'b000000001;
parameter	B	=	9'b000000010;
parameter	C	=	9'b000000100;
parameter	D	=	9'b000001000;
parameter	E	=	9'b000010000;
parameter	F	=	9'b000100000;
parameter	G	=	9'b001000000;
parameter	H	=	9'b010000000;
parameter	I	=	9'b100000000;

reg	[8:0]	st;
reg	[8:0]	next_st;

always	@(posedge clk)
	if(rst)	st	<=	A;
	else	st	<=	next_st;

always	@*
	case({st, w})
		{A, 1'b0} : {next_st, z} = {B, 1'b0};
		{A, 1'b1} : {next_st, z} = {F, 1'b0};
		
		{B, 1'b0} : {next_st, z} = {C, 1'b0};
		{B, 1'b1} : {next_st, z} = {F, 1'b0};
		
		{C, 1'b0} : {next_st, z} = {D, 1'b0};
		{C, 1'b1} : {next_st, z} = {F, 1'b0};
		
		{D, 1'b0} : {next_st, z} = {E, 1'b0};
		{D, 1'b1} : {next_st, z} = {F, 1'b0};
		
		{E, 1'b0} : {next_st, z} = {E, 1'b1};
		{E, 1'b1} : {next_st, z} = {F, 1'b1};
		
		{F, 1'b0} : {next_st, z} = {B, 1'b0};
		{F, 1'b1} : {next_st, z} = {G, 1'b0};
		
		{G, 1'b0} : {next_st, z} = {B, 1'b0};
		{G, 1'b1} : {next_st, z} = {H, 1'b0};
		
		{H, 1'b0} : {next_st, z} = {B, 1'b0};
		{H, 1'b1} : {next_st, z} = {I, 1'b0};
		
		{I, 1'b0} : {next_st, z} = {B, 1'b0};
		{I, 1'b1} : {next_st, z} = {I, 1'b1};
		
		default	  : {next_st, z} = {A, 1'b0};

	endcase

endmodule



module tb; // TEST BENCH

parameter	CLK_PERIOD = 10;

reg clk;
reg rst;
reg w;
wire z;

fsm u0(.w(w), .clk(clk), .rst(rst), .z(z));

initial begin
	clk = 1'b0;
	forever #(CLK_PERIOD/2) clk = ~clk;
end

initial begin
	rst = 1'b0;
	#(CLK_PERIOD*0.3)
	rst = 1'b1;
	#(CLK_PERIOD)
	rst = 1'b0;
end

initial begin
	w = 0;
	#(CLK_PERIOD*3.3) w = 1;
	#(CLK_PERIOD*5)	  w = 0;
end

initial begin
	$dumpfile("fsm.vcd");
	$dumpvars;
	#(CLK_PERIOD*50)
	$finish;
end

endmodule
