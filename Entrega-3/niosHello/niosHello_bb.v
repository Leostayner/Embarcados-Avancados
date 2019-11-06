
module niosHello (
	clk_clk,
	key_export,
	leds_name,
	ps2_0_clk_export,
	ps2_0_dat_export,
	reset_reset_n);	

	input		clk_clk;
	input	[3:0]	key_export;
	output	[3:0]	leds_name;
	inout		ps2_0_clk_export;
	inout		ps2_0_dat_export;
	input		reset_reset_n;
endmodule
