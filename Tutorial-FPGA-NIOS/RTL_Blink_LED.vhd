library IEEE;
use IEEE.std_logic_1164.all;

entity RTL_Blink_LED is
    port (
        -- Gloabals
        fpga_clk_50        : in  std_logic;             -- clock.clk
		  
        -- I/Os
        fpga_led_pio       : out std_logic_vector(5 downto 0)
	);
end entity RTL_Blink_LED;

architecture rtl of RTL_Blink_LED is

component niosHello is port (
  clk_clk       : in  std_logic                    := 'X'; -- clk
  reset_reset_n : in  std_logic                    := 'X'; -- reset_n
  leds_export   : out std_logic_vector(5 downto 0)         -- export
);
end component niosHello;

begin
 
u0 : component niosHello port map (
  clk_clk       => fpga_clk_50,    --  clk.clk
  reset_reset_n => '1',            --  reset.reset_n
  leds_export   => fpga_led_pio    --  leds.export
);
	
end rtl;