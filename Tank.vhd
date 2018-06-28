library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity Tank is
port( tank_row, tank_col 	: IN std_logic_vector(9 downto 0);
		vga_col, vga_row 		: IN std_logic_vector(9 downto 0);
		Mode						: IN std_logic_vector(1 downto 0);
		Display					: IN std_logic;
		tankType					: IN std_logic;
		sw8,sw7,sw6				: IN std_logic;	-- Change colour of tank with DIP switches
		rgbTank					: OUT std_logic_vector(2 downto 0);
		Tank_On					: OUT std_logic);
end Tank;

architecture beh of Tank is
	signal tank_width 	: std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(50,10));
	signal tank_height 	: std_logic_vector(9 downto 0) := std_logic_vector(to_unsigned(50,10));
	signal sTank_colEnd 	: std_logic_vector(9 downto 0) := std_logic_vector(unsigned(tank_col) + unsigned(tank_width));
	signal sTank_rowEnd 	: std_logic_vector(9 downto 0) := std_logic_vector(unsigned(tank_row) + unsigned(tank_height));

begin
	Tank_On <= '1' when (((vga_col >= tank_col) and (vga_col <= sTank_colEnd) and (vga_row >= tank_row) and (vga_row <= sTank_rowEnd)) and Display = '1' and ((Mode(1 downto 0) = "01") or (Mode(1 downto 0) = "10"))) else
					'0';
					
				-- Change tank colour based on user input else set it to white
	rgbTank <= 
				"100" when (tankType = '1' and sw8 = '0' and sw7 = '0' and sw6 = '0') else -- If black set it up to red so it's visible on the screen
				sw8&sw7&sw6 when (tankType = '1') else 
				"111";

end architecture;