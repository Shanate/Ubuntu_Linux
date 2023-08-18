module SRlatch(

input	set, reset,
output	q, qbar
);

nand	#(1)	n1(q, reset, qbar);	// Delay of 1 on gate n1
nand	#(1)	n2(qbar, set, q);	// Delay of 1 on gate n2

endmodule

//TEST BENCH
module tb;

reg	SET, RST;
wire	Q, QBAR;


SRlatch	Latch1(.set(SET), .reset(RST), .q(Q), .qbar(QBAR));

initial begin
// 1 cycle
SET = 1'b0; RST = 1'b0;
#5
SET = 1'b0; RST = 1'b1;
#5
SET = 1'b1; RST = 1'b0;
#5
SET = 1'b1; RST = 1'b1;
// 2 cycle
SET = 1'b0; RST = 1'b0;
#5
SET = 1'b0; RST = 1'b1;
#5
SET = 1'b1; RST = 1'b0;
#5
SET = 1'b1; RST = 1'b1;
#10
$finish;

end

initial begin
$dumpfile("delay_SRlatch.vcd");
$dumpvars;

end

endmodule
