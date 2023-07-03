module SR_latch(Q, Qbar, Sbar, Rbar);

output Q, Qbar;
input Sbar, Rbar;

nand n1(Q, Sbar, Qbar);
nand n2(Qbar, Rbar, Q);
endmodule

module Top;

wire q, qbar;
reg set, reset;

SR_latch m1(q, qbar, ~set, ~reset);
initial
begin
	$monitor($time, "set = %b, reset= %b, q= %b\n", set, reset, q);
	set =0; reset =0;
	#5 reset = 1;
	#5 reset =0;
	#5 set=1;
	#100 $finish;
end
initial begin
	$dumpfile("tesetbench.vcd");
	$dumpvars;
end


endmodule
