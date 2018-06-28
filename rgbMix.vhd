library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity rgbMix is
	port( tankAI_on, tankPlayer_on, ball_on, text_on, AIball_on, AIball2_on	: IN std_logic;
			rgbAI, rgbPlayer, rgbBall, rgbAIBall, rgbAIBall2						: IN std_logic_vector(2 downto 0);
			rgb_out 																				: OUT std_logic_vector(2 downto 0));
end entity;

architecture beh of rgbMix is
begin
	
	rgb_out <= 
				rgbAIBall(2 downto 0) when (AIball_on = '1') else
				rgbBall(2 downto 0) when (ball_on = '1') else
				rgbAI(2 downto 0) when (tankAI_on = '1') else
				rgbAIBall2(2 downto 0) when (AIball2_on = '1') else
				rgbPlayer(2 downto 0) when (tankPlayer_on = '1') else
				"010" when (text_on = '1') else
				"000";
end architecture;