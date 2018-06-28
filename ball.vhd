library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity ball is
	port (ball_row, ball_col 	: in std_logic_vector(9 downto 0);
			vga_row, vga_col 		: in std_logic_vector(9 downto 0);	
			Mode						: in std_logic_vector(1 downto 0);
			Display					: in std_logic;
			rgbBall 					: out std_logic_vector(2 downto 0);
			Ball_On 					: out std_logic);
end ball;

architecture beh of ball is
	signal ball_width 	: STD_LOGIC_VECTOR (9 downto 0) := std_logic_vector(to_unsigned(10,10));
	signal ball_height 	: STD_LOGIC_VECTOR (9 downto 0) := std_logic_vector(to_unsigned(10,10));

	signal sCol_End 		: STD_LOGIC_VECTOR (9 downto 0) := std_logic_vector(unsigned(ball_col) + unsigned(ball_width));
	signal sRow_End 		: STD_LOGIC_VECTOR (9 downto 0) := std_logic_vector(unsigned(ball_row) + unsigned(ball_height));

	-- Defines the boundaries of what pixels should be coloured
	-- It loks ugly but it creates round ball. That's what happens when you spend 3 hours trying to get for loop to work and
	-- end up giving up on life
	signal Col_0 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(0,10));
	signal Col_1 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(1,10));
	signal Col_2 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(2,10));
	signal Col_3 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(3,10));
	signal Col_4 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(4,10));
	signal Col_5 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(5,10));
	signal Col_6 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(6,10));
	signal Col_7 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(7,10));
	signal Col_8 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(8,10));
	signal Col_9 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(9,10));
	signal Col_10 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_col) + to_unsigned(10,10));

	signal Row_0 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(0,10));
	signal Row_1 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(1,10));
	signal Row_2 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(2,10));
	signal Row_3 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(3,10));
	signal Row_4 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(4,10));
	signal Row_5 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(5,10));
	signal Row_6 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(6,10));
	signal Row_7 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(7,10));
	signal Row_8 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(8,10));
	signal Row_9 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(9,10));
	signal Row_10 : std_logic_vector(9 downto 0) := std_logic_vector(unsigned(ball_row) + to_unsigned(10,10));

begin
	-- Only turn ball on when vga sync is on ball pixels
	Ball_On <= '1' when ((vga_col >= ball_col) and (vga_col <= sCol_End) and (vga_row >= ball_row) and (vga_row <= sRow_End) and (Display = '1') and ((Mode(1 downto 0) = "01") or (Mode(1 downto 0) = "10"))) else '0';

	-- Decide whether to colour the pixel in yellow (ball colour) or black (background colour)
	rgbBall <= 
				"000" when ((vga_row = Row_0 or vga_row = Row_10)) else
				"000" when ((vga_row = Row_1 or vga_row = Row_9) and (vga_col < Col_4 or vga_col > Col_6)) else
				"000" when ((vga_row = Row_2 or vga_row = Row_8) and (vga_col < Col_3 or vga_col > Col_7)) else
				"000" when ((vga_row = Row_3 or vga_row = Row_7) and (vga_col < Col_2 or vga_col > Col_8)) else
				"000" when ((vga_row = Row_4 or vga_row = Row_6) and (vga_col < Col_2 or vga_col > Col_8)) else
				"000" when ((vga_row = Row_5) and (vga_col < Col_1 or vga_col > Col_9)) else
				"110";
	
end beh;