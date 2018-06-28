library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity seven_seg is
    port (value	: in std_logic_vector(3 downto 0);
			 segs		: out std_logic_vector(7 downto 0));
end seven_seg;

-- Display is active-low
-- MSB is decimal point
architecture beh of seven_seg is
begin
    process (value) is
    begin 
	   case value is
			when "0000" => segs <= "11000000"; -- 0
			when "0001" => segs <= "11111001"; -- 1
			when "0010" => segs <= "10100100"; -- 2
			when "0011" => segs <= "10110000"; -- 3
			when "0100" => segs <= "10011001"; -- 4
			when "0101" => segs <= "10010010"; -- 5
			when "0110" => segs <= "10000010"; -- 6
			when "0111" => segs <= "11111000"; -- 7
			when "1000" => segs <= "10000000"; -- 8
			when "1001" => segs <= "10011000"; -- 9
			when others => segs <= "10000110"; -- E (error)
	   end case;
    end process;
end beh;