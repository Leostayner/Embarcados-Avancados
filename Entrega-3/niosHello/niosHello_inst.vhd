	component niosHello is
		port (
			clk_clk          : in    std_logic                    := 'X';             -- clk
			key_export       : in    std_logic_vector(3 downto 0) := (others => 'X'); -- export
			leds_name        : out   std_logic_vector(3 downto 0);                    -- name
			ps2_0_clk_export : inout std_logic                    := 'X';             -- export
			ps2_0_dat_export : inout std_logic                    := 'X';             -- export
			reset_reset_n    : in    std_logic                    := 'X'              -- reset_n
		);
	end component niosHello;

	u0 : component niosHello
		port map (
			clk_clk          => CONNECTED_TO_clk_clk,          --       clk.clk
			key_export       => CONNECTED_TO_key_export,       --       key.export
			leds_name        => CONNECTED_TO_leds_name,        --      leds.name
			ps2_0_clk_export => CONNECTED_TO_ps2_0_clk_export, -- ps2_0_clk.export
			ps2_0_dat_export => CONNECTED_TO_ps2_0_dat_export, -- ps2_0_dat.export
			reset_reset_n    => CONNECTED_TO_reset_reset_n     --     reset.reset_n
		);

