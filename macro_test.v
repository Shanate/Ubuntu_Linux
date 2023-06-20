module macro_test;

initial begin
	`ifdef TEST
		$display("test is defined");
	`else
		$display("test is not defined");
	`endif

	end

endmodule
