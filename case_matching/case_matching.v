module test;

reg [1:0] a;

initial begin
	a = 2'b10;
	$display(a);

	case(a)
		2'd0 : $display("first case in case");
		2'd1 : $display("second case in case");
		default : $display("default case in case");
	endcase


	casex(a)
		2'd0 : $display("first case in case");
		2'd1 : $display("second case in case");
		default : $display("default case in casex");
	endcase

	casez(a)
		2'd0 : $display("first case in case");
		2'd1 : $display("second case in case");
		default : $display("default case in casez");
	endcase

end


endmodule

