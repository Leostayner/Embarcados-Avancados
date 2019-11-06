library IEEE;
use IEEE.std_logic_1164.all;

entity RTL_Blink_LED is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(3 downto 0);
		  fpga_key_pio       : in std_logic_vector(3 downto 0);
		  
		  PS2_CLK   : inout std_logic;                    -- ps2_clock signal inout;
        PS2_DAT   : inout std_logic                    -- ps2_data  signal inout;

	);
end entity RTL_Blink_LED;

architecture rtl of RTL_Blink_LED is
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

begin
    u0 : component niosHello
        port map (
            clk_clk          => fpga_clk_50,          --       clk.clk
            key_export       => fpga_key_pio,       --       key.export
            leds_name        => fpga_led_pio,        --      leds.name
            ps2_0_clk_export => PS2_CLK, -- ps2_0_clk.export
            ps2_0_dat_export => PS2_DAT, -- ps2_0_dat.export
            reset_reset_n    => '1'     --     reset.reset_n
        );
		  
end rtl;