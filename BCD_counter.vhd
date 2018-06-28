library ieee;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCD_counter is
	port (clk, reset, enable : in std_logic ;
	      Q_out				  	 : out std_logic_vector(3 downto 0));
end entity;

-- Will function as a down counter only
architecture beh of BCD_counter is
signal temp : std_logic_vector(3 downto 0) := "1001";	
begin
	process (clk,reset)
	begin
		if (reset = '1') then
			temp <= "1001";
		elsif (Clk'event and Clk = '1') then
			if (enable = '1') then
					if (temp > "0000") then
						temp <= temp - 1;
					else
						temp <= "1001";
					end if;
			end if;
		end if;
end process;
Q_out <= temp;
end architecture;
				
				