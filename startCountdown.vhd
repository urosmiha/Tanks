LIBRARY ieee;
USE ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL; 

--/** Counter that just count's from 3 to 0 to indicate idle state before starting the game*/

entity startCountdown is
port(clk, btn2, reset : IN std_logic;
		timer_out : OUT std_logic_vector(1 downto 0));
end entity;

architecture beh of startCountdown is
	signal sEnable : std_logic := '0';
begin
	process(clk, reset, btn2)
		variable s_out : std_logic_vector(1 downto 0) := "00";
	begin
	
		if(btn2 = '0') then
			sEnable <= '1';
		elsif (reset = '1') then
			s_out := "11"; -- 3
		elsif(rising_edge(clk)) then
			if(sEnable = '1') then
				if(s_out > "00") then
					s_out := s_out - 1;
				else
					sEnable <= '0';
				end if;
			end if;
		end if;
		
		timer_out(1 downto 0) <= s_out(1 downto 0);
		
	end process;
end architecture;