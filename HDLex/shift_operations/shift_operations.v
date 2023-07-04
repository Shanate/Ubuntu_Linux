module shift_operations(

);
// Shift Operations

reg	signed	[3:0]	a;
reg		[3:0]	b;

wire	signed	[3:0]	shifted_a0;
wire	signed	[3:0]	shifted_a1;
wire		[3:0]	shifted_b0;
wire		[3:0]	shifted_b1;

assign	shifted_a0 = a >> 1;
assign	shifted_a1 = a >>> 1;
assign	shifted_b0 = b >> 1;
assign	shifted_b1 = b >>> 1;


initial begin
	a = -4'sd7; // 4'sb1001
	b = 4'd6;   // 4'b0110
	
#0
$display("shifted_a0	=	%d", shifted_a0);
$display("shifted_a1	=	%d", shifted_a1);
$display("shifted_b0	=	%d", shifted_b0);
$display("shifted_b1	=	%d", shifted_b1);

end

endmodule
