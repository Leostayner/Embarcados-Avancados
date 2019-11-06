library IEEE;
use IEEE.std_logic_1164.all;

entity LED_peripheral is

    
	 port (
        -- Gloabals
        fpga_clk_50     : in  std_logic;        
		  
        -- I/Os
		  KEY 				: in std_logic;
		  SW					: in std_logic_vector(9 downto 0);
		  LED    			: out std_logic_vector(5 downto 0)
		   
	);
end entity LED_peripheral;

architecture ledphr of LED_peripheral is

-- Signal
signal blink      : std_logic := '0';
signal frequency  : integer   := 1; 
signal enable		: std_logic := '0';

begin

	with SW select
		frequency <=   1 WHEN "0000000001",
							2 WHEN "0000000010",
							3 WHEN "0000000100",
							4 WHEN "0000001000",
							5 WHEN "0000010000",
							6 WHEN "0000100000",
							7 WHEN "0001000000",
							8 WHEN "0010000000",
							9 WHEN "0100000000",
							10 WHEN "1000000000",
							frequency when others;
	process(KEY)
		begin
		
			if (not KEY) then
				enable <= not enable;
			end if;
		
		end process;
	
	process(fpga_clk_50)
		variable conter : integer range 0 to 250000000 := 0;
		
		begin
			if(rising_edge(fpga_clk_50) and enable = '1') then
				if(conter < 250000000) then 
					conter := conter + frequency;
				else
					blink 	<= not blink;
					conter 	:= 0;
				end if;
			end if;
	end process;
	
	LED(0) <= blink and enable;
	LED(1) <= blink and enable;
	LED(2) <= blink and enable;
	LED(3) <= blink and enable;
	LED(4) <= blink and enable;
	LED(5) <= blink and enable;


end ledphr;