module bin2bcd(

input	wire	[3:0]	i,
output	reg				d1,
output	reg		[3:0]	d0 // if we use the 'assign', we should use not reg, but wire.
//Continuous block -> wire 
//Procedural block -> reg
// Error of Continuous is higher than Procedural

);

always @*
	case(i)  // why don't use 'begin & end'.
			 // It is the only one block.
		4'd0  : {d1, d0} = {1'd0, 4'd0};
		4'd1  : {d1, d0} = {1'd0, 4'd1};
		4'd2  : {d1, d0} = {1'd0, 4'd2};
		4'd3  : {d1, d0} = {1'd0, 4'd3};
		4'd4  : {d1, d0} = {1'd0, 4'd4};
		4'd5  : {d1, d0} = {1'd0, 4'd5};
		4'd6  : {d1, d0} = {1'd0, 4'd6};
		4'd7  : {d1, d0} = {1'd0, 4'd7};
		4'd8  : {d1, d0} = {1'd0, 4'd8};
		4'd9  : {d1, d0} = {1'd0, 4'd9};
		4'd10 : {d1, d0} = {1'd1, 4'd0};
		4'd11 : {d1, d0} = {1'd1, 4'd1};
		4'd12 : {d1, d0} = {1'd1, 4'd2};
		4'd13 : {d1, d0} = {1'd1, 4'd3};
		4'd14 : {d1, d0} = {1'd1, 4'd4};
		4'd15 : {d1, d0} = {1'd1, 4'd5};
	endcase

	endmodule

module tb;

	reg		[3:0]	i; // External Random Input
	wire	[0:0]	d1;
	wire	[3:0]	d0;

bin2bcd		u0(.i(i), .d1(d1), .d0(d0));

initial	begin

	i	=	4'd9;
	#10
	i	=	4'd10;
	#10
	i	=	4'd7;

end

initial begin

	$dumpfile("bin2bcd.vcd");
	$dumpvars;
	#100
	$finish;

end

endmodule
