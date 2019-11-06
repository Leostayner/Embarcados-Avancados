library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity RTL_Blink_LED is
	
	generic(
			-- LCD
			lF  : std_logic_vector(9 downto 0) := "1001000110"; --F
			lN  : std_logic_vector(9 downto 0) := "1001001110"; --N
			lO  : std_logic_vector(9 downto 0) := "1001001111"  --O
	);	

    port (
        -- Gloabals
        fpga_clk_50     : in  std_logic;        
		  
        -- I/Os
		  KEY 				: in  std_logic_vector(3 downto 0);
        SW					: in  std_logic_vector(9 downto 0);
		  LED    			: out std_logic_vector(5 downto 0);
		  
		  HEX0, 
		  HEX1      		: out STD_LOGIC_VECTOR(6 downto 0)
		  
		  /*
		  LCD_RW, 
		  LCD_RS,
		  LCD_EN  			: OUT   STD_LOGIC;  						 
		  
		  LCD_DATA			: OUT   STD_LOGIC_VECTOR(7 DOWNTO 0) 
	*/
	

		   
	);
end entity RTL_Blink_LED;

architecture rtl of RTL_Blink_LED is

signal d1  : std_logic_vector(3 downto 0); 
signal d2  : std_logic_vector(3 downto 0); 

begin
	
		with SW select
		d1  <=   "0001" WHEN "0000000001",
					"0010" WHEN "0000000010",
					"0011" WHEN "0000000100",
					"0100" WHEN "0000001000",
					"0101" WHEN "0000010000",
					"0110" WHEN "0000100000",
					"0111" WHEN "0001000000",
					"1000" WHEN "0010000000",
					"1001" WHEN "0100000000",
					"0000" WHEN "1000000000",
					d1 when others;

			with SW select
		d2  <=   "0000" WHEN "0000000001",
					"0000" WHEN "0000000010",
					"0000" WHEN "0000000100",
					"0000" WHEN "0000001000",
					"0000" WHEN "0000010000",
					"0000" WHEN "0000100000",
					"0000" WHEN "0001000000",
					"0000" WHEN "0010000000",
					"0000" WHEN "0100000000",
					"0001" WHEN "1000000000",
					d2 when others;

	
	--PORT MAP LED
	L: entity work.LED_peripheral 
		Port map ( fpga_clk_50 => fpga_clk_50, KEY => KEY(0), SW => SW, LED => LED);
	
	--PORT MAP DISPLAY
	display00 : entity work.conversorHex7seg
	 Port map (saida7seg => HEX0, dadoHex => d1, apaga => '0');
	 
	display01 : entity work.conversorHex7seg
	 Port map (saida7seg => HEX1, dadoHex => d2, apaga => '0');
	/*
	--LCD
	screen: lcd_controller
    Port map(clk => fpga_clk_50, reset_n => "0", lcd_enable => "1", lcd_bus => lO, 
             busy => "0", LCD_RW => LCD_RW, LCD_RS => LCD_RS, LCD_EN => LCD_EN, LCD_DATA => LCD_DATA);
	*/
	
end rtl;