library IEEE;
use  IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

--/** Defines what characters shoudl be displayed where
-- It defines the position of row and column where the character is supposed to be displayed
-- and all the other factor and sends rom_mux to char rom that sets what pixels should be painted*/

entity char_gen is
port( pixel_row, pixel_col			: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
		rom_mux_in						: IN STD_LOGIC;
		Mode 								: IN std_logic_vector(1 downto 0);
		Level								: IN std_logic_vector(2 downto 0);
		counterOnes, counterTens 	: IN std_logic_vector(3 downto 0);
		scoreOnes, scoreTens 		: IN std_logic_vector(3 downto 0);
		countdownTimer					: IN std_logic_vector(1 downto 0);
		display							: IN std_logic;
		GameFinished					: IN std_logic_vector(1 downto 0);
		char_address 					: OUT std_logic_vector(5 downto 0);
		font_row, font_col			: OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
		rom_mux_out						: OUT STD_LOGIC);
end entity;

architecture beh of char_gen is
begin

	char_address <=
					------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- player won
					"010110" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100000000") and (pixel_col < "0100010000") and (Mode = "01") and GameFinished = "01") else	-- V
					"001001" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (Mode = "01") and GameFinished = "01") else	-- I
					"000011" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (Mode = "01") and GameFinished = "01") else	-- C
					"010100" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01") and GameFinished = "01") else	-- T
					"001111" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0101000000") and (pixel_col < "0101010000") and (Mode = "01") and GameFinished = "01") else	-- O
					"010010" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0101010000") and (pixel_col < "0101100000") and (Mode = "01") and GameFinished = "01") else	-- R
					"011001" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0101100000") and (pixel_col < "0101110000") and (Mode = "01") and GameFinished = "01") else	-- Y
					--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------Player lost
					"010111" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100000000") and (pixel_col < "0100010000") and (Mode = "01") and GameFinished = "10") else	-- W
					"000001" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (Mode = "01") and GameFinished = "10") else	-- A
					"010011" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (Mode = "01") and GameFinished = "10") else	-- S
					"010100" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01") and GameFinished = "10") else	-- T
					"000101" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0101000000") and (pixel_col < "0101010000") and (Mode = "01") and GameFinished = "10") else	-- E
					"000100" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0101010000") and (pixel_col < "0101100000") and (Mode = "01") and GameFinished = "10") else	-- D
					"100001" when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0101100000") and (pixel_col < "0101110000") and (Mode = "01") and GameFinished = "10") else	-- !
					---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- Start button
					"010000" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0011110000") and (pixel_col < "0100000000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- P
					"010010" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0100000000") and (pixel_col < "0100010000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- R
					"000101" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- E
					"010011" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- S
					"010011" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- S
					"100000" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0101000000") and (pixel_col < "0101010000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- SPACE
					"000010" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0101010000") and (pixel_col < "0101100000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- B
					"010100" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0101100000") and (pixel_col < "0101110000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- T
					"001110" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0101110000") and (pixel_col < "0110000000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- N
					"110000" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0110000000") and (pixel_col < "0110010000") and (Mode = "01" or Mode = "10") and countdownTimer = "11" and Level = "111") else	-- 0
					"110010" when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0110000000") and (pixel_col < "0110010000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- 2
					----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- Countdown
					"110001" when ((pixel_row > "0011100000") and (pixel_row < "0011110000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01" or Mode = "10") and countdownTimer = "01") else -- 1
					"110010" when ((pixel_row > "0011100000") and (pixel_row < "0011110000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01" or Mode = "10") and countdownTimer = "10") else -- 2
					"110011" when ((pixel_row > "0011100000") and (pixel_row < "0011110000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01" or Mode = "10") and countdownTimer = "11") else	-- 3				
					--------------------------------------------------------------------------------------------------------------------------------------------- GAME MODE
					"001100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0000000000") and (pixel_col < "0000010000")) else	-- L
					"000101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0000010000") and (pixel_col < "0000100000")) else	-- E
					"010110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0000100000") and (pixel_col < "0000110000")) else	-- V
					"000101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0000110000") and (pixel_col < "0001000000")) else	-- E
					"001100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001000000") and (pixel_col < "0001010000")) else	-- L
					"100000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001010000") and (pixel_col < "0001100000")) else	-- SPACE
					"110001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001100000") and (pixel_col < "0001110000") and (Level(2 downto 0) = "001")) else	-- 1 or
					"110010" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001100000") and (pixel_col < "0001110000") and (Level(2 downto 0) = "010")) else	-- 2 or
					"110011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001100000") and (pixel_col < "0001110000") and (Level(2 downto 0) = "011")) else	-- 3 or
					"110100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001100000") and (pixel_col < "0001110000") and (Level(2 downto 0) = "100")) else	-- 4 or
					"110101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001100000") and (pixel_col < "0001110000") and (Level(2 downto 0) = "101")) else	-- 5 or
					"110110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0001100000") and (pixel_col < "0001110000") and (Level(2 downto 0) = "110")) else -- 6 or
					-------------------------------------------------------------------------------------------------------------------------------------------- TIME								-- TENS
					"110000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0000")) else	-- 0
					"110001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0001")) else	-- 1
					"110010" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0010")) else	-- 2
					"110011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0011")) else	-- 3
					"110100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0100")) else	-- 4
					"110101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0101")) else	-- 5
					"110110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0110")) else	-- 6
					"110111" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "0111")) else	-- 7
					"111000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "1000")) else	-- 8
					"111001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000") and (counterTens = "1001")) else	-- 9
					------------------------------------------------------------------------------------------------------------------------------------------------------------------------- ONES
					"110000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0000")) else	-- 0
					"110001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0001")) else	-- 1
					"110010" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0010")) else	-- 2
					"110011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0011")) else	-- 3
					"110100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0100")) else	-- 4
					"110101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0101")) else	-- 5
					"110110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0110")) else	-- 6
					"110111" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "0111")) else	-- 7
					"111000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "1000")) else	-- 8
					"111001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000") and (counterOnes = "1001")) else	-- 9
					-------------------------------------------------------------------------------------------------------------------------------------------- SCORE
					"010011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0111010000") and (pixel_col < "0111100000")) else	-- S
					"000011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0111100000") and (pixel_col < "0111110000")) else	-- C
					"001111" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0111110000") and (pixel_col < "1000000000")) else	-- O
					"010010" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "0111110000") and (pixel_col < "1000010000")) else	-- R
					"000101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000010000") and (pixel_col < "1000100000")) else	-- E
					"100000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000100000") and (pixel_col < "1000110000")) else	-- SPACE
					--------------------------------------------------------------------------------------------------------------------------------------------- Tens
					"110000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0000")) else	-- 0
					"110001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0001")) else	-- 1
					"110010" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0010")) else	-- 2
					"110011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0011")) else	-- 3
					"110100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0100")) else	-- 4
					"110101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0101")) else	-- 5
					"110110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0110")) else	-- 6
					"110111" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "0111")) else	-- 7
					"111000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "1000")) else	-- 8
					"111001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1000110000") and (pixel_col < "1001000000") and (scoreTens = "1001")) else	-- 9
					-------------------------------------------------------------------------------------------------------------------------------------------- Ones
					"110000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0000")) else	-- 0
					"110001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0001")) else	-- 1
					"110010" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0010")) else	-- 2
					"110011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0011")) else	-- 3
					"110100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0100")) else	-- 4
					"110101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0101")) else	-- 5
					"110110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0110")) else	-- 6
					"110111" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "0111")) else	-- 7
					"111000" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "1000")) else	-- 8
					"111001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001000000") and (pixel_col < "1001010000") and (scoreOnes = "1001")) else	-- 9
					------------------------------------------------------------------------------------------------------------------------------------------------
					"101111" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001010000") and (pixel_col < "1001100000")) else	-- /
					"110011" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001100000") and (pixel_col < "1001110000") and Level(2 downto 0) = "001") else	-- 3
					"110100" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001100000") and (pixel_col < "1001110000") and (Level(2 downto 0) = "010" or (Level(2 downto 0) = "011" or Level(2 downto 0) = "100"))) else	-- 4
					"110101" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001100000") and (pixel_col < "1001110000") and Level(2 downto 0) = "101") else	-- 5
					"110110" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001100000") and (pixel_col < "1001110000") and Level(2 downto 0) = "110") else	-- 6
					"111001" when ((pixel_row > "0000000000") and (pixel_row < "0000010000") and (pixel_col > "1001100000") and (pixel_col < "1001110000") and not Level(2 downto 0) = "") else	-- 9
					-------------------------------------------------------------------------------------------------------------------------------------------- Ones
					"110000" when ((pixel_row > "0000000000") and (pixel_row < "1001100000") and (pixel_col > "1001110000") and Mode(1 downto 0) = "01" and not (level = "111")) else	-- 0
					------------------------------------------------------------------------------------------------------------------------------------------- WELCOME SCREEN ---
					"010100" when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and (pixel_col > "0000000000") and (pixel_col < "0010000000")) else	-- T
					"000001" when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and (pixel_col > "0010000000") and (pixel_col < "0100000000")) else	-- A
					"001110" when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and (pixel_col > "0100000000") and (pixel_col < "0101101111")) else	-- N
					"001011" when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and (pixel_col > "0101100010") and (pixel_col < "1000000000")) else	-- K
					"010011" when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and (pixel_col > "1000000000") and (pixel_col < "1010000000")) else	-- S
					----------------------------------------------------------------------------------------------------------------------------------------------------
					"010100" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0011000000") and (pixel_col < "0011010000")) else	-- T
					"010010" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0011010000") and (pixel_col < "0011100000")) else	-- R
					"000001" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0011100000") and (pixel_col < "0011110000")) else	-- A
					"001001" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0011110000") and (pixel_col < "0100000000")) else	-- I
					"001110" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0100000000") and (pixel_col < "0100010000")) else	-- N
					"001001" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0100010000") and (pixel_col < "0100100000")) else	-- I
					"001110" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0100100000") and (pixel_col < "0100110000")) else	-- N
					"000111" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0100110000") and (pixel_col < "0101000000")) else	-- G
					"100000" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0101000000") and (pixel_col < "0101010000")) else	-- SPACE
					"101101" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0101010000") and (pixel_col < "0101100000")) else	-- LEFT ARROW
					"101101" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0101100000") and (pixel_col < "0101110000")) else	-- LEFT ARROW
					"100000" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0101110000") and (pixel_col < "0110000000")) else	-- SPACE
					"010011" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0110000000") and (pixel_col < "0110010000")) else	-- S
					"010111" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0110010000") and (pixel_col < "0110100000")) else	-- W
					"110000" when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0110100000") and (pixel_col < "0110110000")) else	-- 0
					----------------------------------------------------------------------------------------------------------------------------------------------------
					"100000" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0011000000") and (pixel_col < "0011010000")) else	-- SPACE
					"100000" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0011010000") and (pixel_col < "0011100000")) else	-- SAPCE
					"000111" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0011100000") and (pixel_col < "0011110000")) else	-- G
					"000001" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0011110000") and (pixel_col < "0100000000")) else	-- A
					"001101" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0100000000") and (pixel_col < "0100010000")) else	-- M
					"000101" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0100010000") and (pixel_col < "0100100000")) else	-- E
					"100000" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0100100000") and (pixel_col < "0100110000")) else	-- SPACE
					"100000" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0100110000") and (pixel_col < "0101000000")) else	-- SPACE
					"100000" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0101000000") and (pixel_col < "0101010000")) else	-- SPACE
					"101101" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0101010000") and (pixel_col < "0101100000")) else	-- LEFT ARROW
					"101101" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0101100000") and (pixel_col < "0101110000")) else	-- LEFT ARROW
					"100000" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0101110000") and (pixel_col < "0110000000")) else	-- SPACE
					"010011" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0110000000") and (pixel_col < "0110010000")) else	-- S
					"010111" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0110010000") and (pixel_col < "0110100000")) else	-- W
					"110001" when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0110100000") and (pixel_col < "0110110000")) else	-- 1

					"100000";	-- SPACE in case we misscalculate character position
					
	rom_mux_out <= 
						rom_mux_in when ((pixel_row > "0010100000") and (pixel_row < "0010110000") and (pixel_col > "0100000000") and (pixel_col < "0101110000") and (Mode = "01") and (GameFinished = "10" or GameFinished = "01") and countdownTimer = "11") else -- Display if player has won or lost
						rom_mux_in when ((pixel_row > "0011000000") and (pixel_row < "0011010000") and (pixel_col > "0011110000") and (pixel_col < "0110010000") and (Mode = "01"  or Mode = "10") and (countdownTimer = "11")) else -- Continue to next level button
						rom_mux_in when ((pixel_row > "0011100000") and (pixel_row < "0011110000") and (pixel_col > "0100110000") and (pixel_col < "0101000000") and (Mode = "01" or Mode = "10") and (countdownTimer = "01" or countdownTimer = "10" or countdownTimer = "11") and not (Level = "111")) else -- 3 2 1 countdown
						rom_mux_in when ((pixel_row < "0000010000") and (pixel_col > "0000000000") and (pixel_col < "0001110000") and (Mode(1 downto 0) = "01") and not (Level = "111")) else 	-- LEVEL indicator for Game Mode
						rom_mux_in when ((pixel_row < "0000010000") and (pixel_col > "0001110000") and (pixel_col < "1001100000") and ((Mode(1 downto 0) = "01") or (Mode(1 downto 0) = "10")) and not (Level = "111")) else	-- GAME MODE and TRAINING MODE TIMER AND SCORE
						rom_mux_in when ((pixel_row < "0000010000") and (pixel_col > "1001100000") and Mode(1 downto 0) = "01" and not (Level = "111")) else	-- REQUIRED SCORE
						rom_mux_in when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and (Mode(1 downto 0) = "00")) else																							-- TANKS for Welcome screen
						rom_mux_in when ((pixel_row > "0100110000") and (pixel_row < "0101000000") and (pixel_col > "0011000000") and (pixel_col < "0111000000") and (Mode(1 downto 0) = "00")) else 		-- TRAINING for Welcome screen
						rom_mux_in when ((pixel_row > "0101000000") and (pixel_row < "0101010000") and (pixel_col > "0011000000") and (pixel_col < "0111000000") and (Mode(1 downto 0) = "00")) else		-- GAME for Wlcome screen
						'0' when (Mode(1 downto 0) = "11") else
						'0';

	font_row <= pixel_row(6 downto 4) when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and Mode = "00") else pixel_row(3 downto 1) ;
	font_col <= pixel_col(6 downto 4) when ((pixel_row > "0010000000") and (pixel_row < "0100000000") and Mode = "00") else pixel_col(3 downto 1);

end architecture;