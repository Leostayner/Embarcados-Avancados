-- nioshello_peripheral_led_0.vhd

-- Generated using ACDS version 18.1 625

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity nioshello_peripheral_led_0 is
	generic (
		LEN : natural := 4
	);
	port (
		clk           : in  std_logic                     := '0';             --          clock.clk
		reset         : in  std_logic                     := '0';             --          reset.reset
		avs_address   : in  std_logic_vector(3 downto 0)  := (others => '0'); -- avalon_slave_0.address
		avs_read      : in  std_logic                     := '0';             --               .read
		avs_readdata  : out std_logic_vector(31 downto 0);                    --               .readdata
		avs_write     : in  std_logic                     := '0';             --               .write
		avs_writedata : in  std_logic_vector(31 downto 0) := (others => '0'); --               .writedata
		LEDs          : out std_logic_vector(3 downto 0)                      --    conduit_end.name
	);
end entity nioshello_peripheral_led_0;

architecture rtl of nioshello_peripheral_led_0 is
	component peripheral_LED is
		generic (
			LEN : natural := 4
		);
		port (
			clk           : in  std_logic                     := 'X';             -- clk
			reset         : in  std_logic                     := 'X';             -- reset
			avs_address   : in  std_logic_vector(3 downto 0)  := (others => 'X'); -- address
			avs_read      : in  std_logic                     := 'X';             -- read
			avs_readdata  : out std_logic_vector(31 downto 0);                    -- readdata
			avs_write     : in  std_logic                     := 'X';             -- write
			avs_writedata : in  std_logic_vector(31 downto 0) := (others => 'X'); -- writedata
			LEDs          : out std_logic_vector(3 downto 0)                      -- name
		);
	end component peripheral_LED;

begin

	peripheral_led_0 : component peripheral_LED
		generic map (
			LEN => LEN
		)
		port map (
			clk           => clk,           --          clock.clk
			reset         => reset,         --          reset.reset
			avs_address   => avs_address,   -- avalon_slave_0.address
			avs_read      => avs_read,      --               .read
			avs_readdata  => avs_readdata,  --               .readdata
			avs_write     => avs_write,     --               .write
			avs_writedata => avs_writedata, --               .writedata
			LEDs          => LEDs           --    conduit_end.name
		);

end architecture rtl; -- of nioshello_peripheral_led_0
