library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--FSM determines what level we are supposed to go next based on previous level.
--
--Player would progress to next level if:
--
--	1. Player reaches target score
--	2. Button 0 is pressed / Skip to next Level
--	
--Player would stay in the same level if:
--	- Player Presses button
--	
--Player will return to Level 1:  if:
--
--	1. Time runs out and player has not reached target score
--	2. Player goes back to Welcome Screen
--	3. Player Tank gets hit by the AI Tank/Ball
--
--Game can be paused and resumed by switching switch 2

entity FSM is
port( clk, btn0, btn1, btn2		: IN std_logic;
		sw0, sw1, sw2 					: IN std_logic;
		counterOnes, counterTens 	: IN std_logic_vector(3 downto 0);
		countdownTimer 				: IN std_logic_vector(1 downto 0);
		gameOver							: IN std_logic;
		ScoreOnes, ScoreTens			: IN std_logic_vector(3 downto 0);
		EnableCounter 					: OUT std_logic;
		CounterReset 					: OUT std_logic;
		Pause								: OUT std_logic;
		Mode 								: OUT std_logic_vector(1 downto 0);
		Level 							: OUT std_logic_vector(2 downto 0);
		ResetScore						: OUT std_logic;
		ResetCoundown 					: OUT std_logic;
		ResetGame						: OUT std_logic;
		GameFinished					: OUT std_logic_vector(1 downto 0));
end entity;

architecture beh of FSM is
	type level_state is (l1,l2,l3,l4,l5,l6,finished);
	signal lvl 					: level_state;
	signal sResetScore 		: std_logic := '0';
	signal sResetCountdown 	: std_logic := '0';
	signal sPause 				: std_logic := '0';
	signal sEnableCounter 	: std_logic := '1';
	signal sScore 				: integer := 0;
	signal sCounterReset 	: std_logic := '0';
	signal nextLevel 			: std_logic := '1';
	signal flag 				: std_logic := '1';
	signal sResetGame 		: std_logic := '1';
	signal sGameFinished 	: std_logic_vector(1 downto 0) := "00";
begin

	process(clk)
	begin
		if(rising_edge(clk)) then	
			case lvl is
				when l1=>
					if(((counterOnes = "0000" and counterTens = "0000") or btn0 = '0' or ScoreTens(3 downto 0) >= "0011") and sw1 = '1' and sw0 = '0') then
						if(btn0 = '0' or ScoreTens(3 downto 0) >= "0011") then 	-- If player has reached required score or skip level
							lvl <= l2;														-- Change state
							sGameFinished <= "01"; 										-- Player Completed the level
						else
							lvl <= l1;
							sGameFinished <= "10"; 										-- Player has NOT won the game
						end if;
							sResetScore <= '1';											-- Reset Score
							sCounterReset <= '1';										-- Reset Counter
							sResetCountdown <= '1';										-- Reset Coundown
							sPause <= '1';													-- Pause the Game and freeze objects on screen
							ResetGame <= '1';												-- reset Game and position of the tanks	
					elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then	-- If player goes to Welcome Screen
						lvl <= l1;															-- Return to level 1
						sGameFinished <= "00"; 											-- Nothing should be displayed (i.e. Neither Lost nor Win)
					else
						lvl <= l1;															-- Stay in the same state
						sResetCountdown <= '0';											-- 
						sPause <= '0';														--
						ResetGame <= '0';													-- Do not reset anything
						sCounterReset <= '0';											--
						sResetScore <= '0';												--
					end if;	
				when l2=>																	
					if(((counterOnes = "0000" and counterTens = "0000") or btn0 = '0' or ScoreTens(3 downto 0) >= "0100") and sw1 = '1' and sw0 = '0') then
						if(btn0 = '0' or ScoreTens(3 downto 0) >= "0100") then 	-- If player has reached required store or skip level
							lvl <= l3;														-- Change state
							sGameFinished <= "01"; 										-- Player Completed the level
						else
							lvl <= l1;
							sGameFinished <= "10"; 										-- Player has NOT won the game
						end if;
							sResetScore <= '1';											-- Reset Score
							sCounterReset <= '1';										-- Reset Counter
							sResetCountdown <= '1';										-- Reset Coundown
							sPause <= '1';													-- Pause the Game and freeze objects on screen
							ResetGame <= '1';												-- reset Game and position of the tanks	
					elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then	-- If player goes to Welcome Screen
						lvl <= l1;															-- Return to level 1
						sGameFinished <= "00"; 											-- Nothing should be displayed (i.e. Neither Lost nor Win)
					else
						lvl <= l2;															-- Stay in the same state
						sResetCountdown <= '0';											-- 
						sPause <= '0';														--
						ResetGame <= '0';													-- Do not reset anything
						sCounterReset <= '0';											--
						sResetScore <= '0';												--
					end if;	
				when l3=>
					if(((counterOnes = "0000" and counterTens = "0000") or btn0 = '0' or (ScoreTens(3 downto 0) >= "0100")) and sw1 = '1' and sw0 = '0') then
						if(btn0 = '0' or ScoreTens(3 downto 0) >= "0100") then 	-- If player has reached required store or skip level
							lvl <= l4;														-- Change state
							sGameFinished <= "01"; 										-- Player Completed the level
						else
							lvl <= l1;
							sGameFinished <= "10"; 										-- Player has NOT won the game
						end if;
							sResetScore <= '1';											-- Reset Score
							sCounterReset <= '1';										-- Reset Counter
							sResetCountdown <= '1';										-- Reset Coundown
							sPause <= '1';													-- Pause the Game and freeze objects on screen
							ResetGame <= '1';												-- reset Game and position of the tanks	
					elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then	-- If player goes to Welcome Screen
						lvl <= l1;															-- Return to level 1
						sGameFinished <= "00"; 											-- Nothing should be displayed (i.e. Neither Lost nor Win)
					else
						lvl <= l3;															-- Stay in the same state
						sResetCountdown <= '0';											-- 
						sPause <= '0';														--
						ResetGame <= '0';													-- Do not reset anything
						sCounterReset <= '0';											--
						sResetScore <= '0';												--
					end if;	
				when l4=>
					if(((counterOnes = "0000" and counterTens = "0000") or btn0 = '0' or (ScoreTens(3 downto 0) >= "0100")) and sw1 = '1' and sw0 = '0') then
						if(btn0 = '0' or ScoreTens(3 downto 0) >= "0100") then
							lvl <= l5;
							sGameFinished <= "01";
						else
							lvl <= l1;
							sGameFinished <= "10";
						end if;
						sResetScore <= '1';
						sCounterReset <= '1';
						sResetCountdown <= '1';
						sPause <= '1';
						ResetGame <= '1';
					elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then
						lvl <= l1;
						sGameFinished <= "00"; 										-- Nothing should be displayed
					elsif (gameOver = '1') then									-- If player dies
						lvl <= l1;														-- Set next state to Level 1
						sGameFinished <= "10"; 										-- Player has NOT won the game
						ResetGame <= '1';												-- Reset Game
						sResetCountdown <= '1';										-- reset Counter
						sPause <= '1';													-- Pause the Game and not let Tanks move
						sResetScore <= '1';											-- Reset Score
					else
						lvl <= l4;
						sResetCountdown <= '0';
						sPause <= '0';
						ResetGame <= '0';
						sCounterReset <= '0';
						sResetScore <= '0';
					end if;
				when l5=>
					if(((counterOnes = "0000" and counterTens = "0000") or btn0 = '0' or (ScoreTens(3 downto 0) >= "0101")) and sw1 = '1' and sw0 = '0') then
						if(btn0 = '0' or ScoreTens(3 downto 0) >= "0101") then 	-- If player has reached required store or skip level
							lvl <= l6;														-- Change state
							sGameFinished <= "01"; 										-- Player Completed the level
						else
							lvl <= l1;
							sGameFinished <= "10"; 										-- Player has NOT won the game
						end if;
							sResetScore <= '1';											-- Reset Score
							sCounterReset <= '1';										-- Reset Counter
							sResetCountdown <= '1';										-- Reset Coundown
							sPause <= '1';													-- Pause the Game and freeze objects on screen
							ResetGame <= '1';												-- reset Game and position of the tanks	
					elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then	-- If player goes to Welcome Screen
						lvl <= l1;															-- Return to level 1
						sGameFinished <= "00"; 											-- Nothing should be displayed (i.e. Neither Lost nor Win)
					elsif (gameOver = '1') then									-- If player dies
						lvl <= l1;														-- Set next state to Level 1
						sGameFinished <= "10"; 										-- Player has NOT won the game
						ResetGame <= '1';												-- Reset Game
						sResetCountdown <= '1';										-- reset Counter
						sPause <= '1';													-- Pause the Game and freeze objects on screen
						sResetScore <= '1';			
					else
						lvl <= l5;															-- Stay in the same state
						sResetCountdown <= '0';											-- 
						sPause <= '0';														--
						ResetGame <= '0';													-- Do not reset anything
						sCounterReset <= '0';											--
						sResetScore <= '0';												--
					end if;	
				when l6=>
						if(((counterOnes = "0000" and counterTens = "0000") or btn0 = '0' or (ScoreTens(3 downto 0) >= "0110")) and sw1 = '1' and sw0 = '0') then
							if(btn0 = '0' or ScoreTens(3 downto 0) >= "0110") then 	-- If player has reached required store or skip level
							lvl <= finished;														-- Change state
							sGameFinished <= "01"; 										-- Player Completed the level
						else
							lvl <= l1;
							sGameFinished <= "10"; 										-- Player has NOT won the game
						end if;
							sResetScore <= '1';											-- Reset Score
							sCounterReset <= '1';										-- Reset Counter
							sResetCountdown <= '1';										-- Reset Coundown
							sPause <= '1';													-- Pause the Game and freeze objects on screen
							ResetGame <= '1';												-- reset Game and position of the tanks	
					elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then	-- If player goes to Welcome Screen
						lvl <= l1;															-- Return to level 1
						sGameFinished <= "00"; 											-- Nothing should be displayed (i.e. Neither Lost nor Win)
					elsif (gameOver = '1') then									-- If player dies
						lvl <= l1;														-- Set next state to Level 1
						sGameFinished <= "10"; 										-- Player has NOT won the game
						ResetGame <= '1';												-- Reset Game
						sResetCountdown <= '1';										-- reset Counter
						sPause <= '1';													-- Pause the Game and not let Tanks move
						sResetScore <= '1';											-- Reset Score
					else
						lvl <= l6;															-- Stay in the same state
						sResetCountdown <= '0';											-- 
						sPause <= '0';														--
						ResetGame <= '0';													-- Do not reset anything
						sCounterReset <= '0';											--
						sResetScore <= '0';												--
					end if;	
					when finished =>
						-- Nothing but VICTORY should be displayed and asking player to press button to continue
						if((btn0 = '0' or btn2 = '0') and sw1 = '1' and sw0 = '0') then
							lvl <= l1;
							sGameFinished <= "11"; -- Game completed
							sResetScore <= '1';
							sCounterReset <= '1';
							sResetCountdown <= '1';
							sPause <= '1';
							ResetGame <= '1';
						elsif ((sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) then
							lvl <= l1;
							sGameFinished <= "00"; -- Nothing should be displayed
						else
							lvl <= finished;
							sResetCountdown <= '0';
							sPause <= '0';
							ResetGame <= '0';
							sCounterReset <= '0';
							sResetScore <= '0';
						end if;
				end case;
		end if;
	end process;
	
	process(lvl)
	begin
	-- Change level based on state
		case lvl is
			when l1 =>
				Level <= "001";
			when l2 =>
				Level <= "010";
			when l3 =>
				Level <= "011";
			when l4 =>
				Level <= "100";
			when l5 =>
				Level <= "101";
			when l6 =>
				Level <= "110";
			when finished =>
				level <= "111";
		end case;
	end process;
	
	-- Indicate whether to display Player Won or Player Lost based on whether the player goes back to Welcome screen or if player wants to continue
	GameFinished <= "00" when (btn2 = '0' or (sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) else sGameFinished;
	
	-- Enable counter when countdown timer runs out
	EnableCounter <= '0' when (sw2 = '1' or countdownTimer > "00") else sEnableCounter;
	
	-- Pause the game if counting down or pause switch is on
	Pause <= '1' when (sw2 = '1' or countdownTimer > "00") else sPause;
	
	-- Reset counter if reset is pressed or player goes back to welcome screen
	CounterReset <= '1' when (btn2 = '0' or (sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) else sCounterReset;
	
	-- Reset score when player goes back to welcome screen or resets game
	ResetScore <= '1' when (btn2 = '0' or (sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) else sResetScore;
	
	-- Reset countdown timer when mode is changed or player skips level
	ResetCoundown <= '1' when (btn1 = '0' or btn0 = '0' or (sw0 = '0' and sw1 = '0') or (sw0 = '1' and sw1 = '1')) else sResetCountdown;
	
	-- Mode is based on what switch is pressed on the screen
	Mode <= sw0 & sw1;
	
end architecture;
		