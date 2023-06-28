module part1(

	input	wire	[7:0]	a,
	input	wire			clk,
	input	wire			nrst,

	output	reg				carry,
	output	reg				ov,
	output	wire	[6:0]	hex1_s,
	output	wire	[6:0]	hex0_s

);
// each s_ and a_ is s prime & a prime
			reg		[7:0]	s_;
			reg		[7:0]	a_;
			wire	[8:0]	s;
			reg				ov_;

always	@(posedge clk,	negedge	nrst)
	if(~nrst)	a_		<=	8'd0;
	else		a_		<=	a;

assign			s		=	a_	+	s_; // 8bit + 8bit -> 9bit	
always	@(posedge clk,	negedge	nrst)
	if(~nrst)	carry	<=	1'b0;
	else		carry	<=	s[8];

always	@(posedge clk, negedge nrst)
	if(~nrst)	s_		<=	8'd0;
	else		s_		<=	s[7:0];

always	@*
	case({a_[7], s_[7],	s[7]})
		3'b110, 3'b001 : ov_ <= 1'b1;
		default : ov_	<= 1'b0;
	endcase

always @(posedge	clk, negedge nrst)
	if(~nrst)	ov		<=	1'b0;
	else		ov		<=	ov_;



segdec	u0(.i(s_[3:0]), .o(hex0_s));
segdec	u1(.i(s_[7:4]), .o(hex1_s));

	endmodule

// 7-segment module
module segdec(
	input		[3:0]	i,
	output	reg	[6:0]	o
);

always @*
	case	(i)
		4'h0	:	o	=	7'b1000000;
		4'h1	:	o	=	7'b1111001;
		4'h2	:	o	=	7'b0100100;
		4'h3	:	o	=	7'b0110000;
		4'h4	:	o	=	7'b0011001;
		4'h5	:	o	=	7'b0010010;
		4'h6	:	o	=	7'b0000010;
		4'h7	:	o	=	7'b1111000;
		4'h8	:	o	=	7'b0000000;
		4'h9	:	o	=	7'b0011000;
		4'ha	:	o	=	7'b0001000;
		4'hb	:	o	=	7'b0000011;
		4'hc	:	o	=	7'b1000110;
		4'hd	:	o	=	7'b0100001;
		4'he	:	o	=	7'b0000110;
		4'hf	:	o	=	7'b0001110;
	endcase
endmodule







