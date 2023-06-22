module	counter4(

	input	wire	clk,
	input	wire	en,
	input	wire	nclear,
	output	wire	[3:0]	q

);

wire	en0,en1,en2,en3;

t_ff u0(.clk(clk), .nclear(nclear), .en(en0), .q(q[0]));
t_ff u1(.clk(clk), .nclear(nclear), .en(en1), .q(q[1]));
t_ff u2(.clk(clk), .nclear(nclear), .en(en2), .q(q[2]));
t_ff u3(.clk(clk), .nclear(nclear), .en(en3), .q(q[3]));

assign	en0 = 			en;
assign	en1	=	en0	& q[0];
assign	en2	=	en1	& q[1];
assign	en3	=	en2	& q[2];


endmodule



module	t_ff(
	input	wire	clk,
	input	wire	en,
	input	wire	nclear,
	output	reg		q
);

always @(posedge clk)
	if(~nclear) q <= 1'b0;
	else if(en) q <= ~q;

endmodule


module tb; // TEST BENCH

reg clk;
reg en;
reg nclear;
wire [3:0] q;


counter4 u0(.clk(clk), .en(en), .nclear(nclear), .q(q));

initial begin
	clk	=	1'b0;
	forever	#10 clk	=	~clk;
end

initial begin
	nclear	=	1'b1;
	#12
	nclear	=	1'b0;
	#20
	nclear	=	1'b1;
end


initial begin
	en	=	1'b0;
	#40
	en	=	1'b1;
end

initial	begin
	$monitor("%d", q);
end

initial begin

	$dumpfile("counter.vcd");
	$dumpvars;
	#200
	$finish;
	end


	endmodule




