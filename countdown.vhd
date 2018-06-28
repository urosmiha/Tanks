library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity countdown is
	port (clk, en 					: in std_logic;
			BCD_ones, BCD_tens 	: in std_logic_vector(3 downto 0);
			en_ones, en_tens 		: out std_logic;
			seg_ones, seg_tens	: out std_logic_vector(3 downto 0));		
end entity;

architecture beh of countdown is
signal s_seg_ones : std_logic_vector(3 downto 0) := "1001";
signal s_seg_tens : std_logic_vector(3 downto 0) := "1001";
begin
	process(clk)
	begin
		if (clk'event and clk = '1') then
			if (en = '1') then
				s_seg_tens <= BCD_tens;
				s_seg_ones <= BCD_ones;
				en_ones <= '1';				
			else 
				en_ones <= '0';
			end if;
		end if;
	end process;
	
en_tens <= '1' when BCD_ones = "0000" else '0';		
seg_ones <= s_seg_ones;
seg_tens <= s_seg_tens;
end architecture;