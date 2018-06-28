library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity GameLogic is
     Port (	h_sync, v_sync 				: in std_logic;
				random_number					: in std_logic_vector(9 downto 0);
				mouse_col 						: in std_logic_vector(9 downto 0); 
				mouse_leftClick 				: in std_logic;
				pauseGame						: in std_logic;
				Level								: in std_logic_vector(2 downto 0);
				count_ones						: in std_logic_vector(3 downto 0);
				ResetGame						: in std_logic;
				collision						: out std_logic;
				tank_row,tank_col 			: out std_logic_vector(9 downto 0); -- AI Tank 1
				tank2_row,tank2_col 			: out std_logic_vector(9 downto 0); -- AI Tank 2
				pTank_row, pTank_col 		: out std_logic_vector(9 downto 0); -- Player's tank
				ball_row, ball_col 			: out std_logic_vector(9 downto 0);
				AI_ball_row, AI_ball_col	: out std_logic_vector(9 downto 0);
				AI_ball2_col, AI_ball2_row : out std_logic_vector(9 downto 0);
				rgb_player 						: out std_logic_vector(2 downto 0);
				rgb_AI 							: out std_logic_vector(2 downto 0);
				DisplayTank1					: out std_logic;
				DisplayTank2 					: out std_logic;
				DisplayBall						: out std_logic;
				Display_AI_Ball				: out std_logic;
				Display_AI_Ball2				: out std_logic;
				GameOver							: out std_logic);
				
end GameLogic;

architecture Behavioral of GameLogic is
-- Ball variables
signal ball_size		: signed(9 downto 0) := to_signed(10,10);
signal ball_col_vel 	: signed(9 downto 0);
signal ball_row_vel 	: signed(9 downto 0);
signal sBall_col 		: signed(9 downto 0);
signal sBall_row 		: signed(9 downto 0);

-- AI Ball 1 variables
signal AI_ball_size		: signed(9 downto 0) := to_signed(10,10);
signal AI_ball_col_vel 	: signed(9 downto 0);
signal AI_ball_row_vel 	: signed(9 downto 0);
signal AI_sBall_col 		: signed(9 downto 0);
signal AI_sBall_row 		: signed(9 downto 0);
signal AI_ball_flag		: std_logic := '1';

-- AI Ball 2 variable
signal AI_ball2_size		: signed(9 downto 0) := to_signed(10,10);
signal AI_ball2_col_vel 	: signed(9 downto 0);
signal AI_ball2_row_vel 	: signed(9 downto 0);
signal AI_sBall2_col 		: signed(9 downto 0);
signal AI_sBall2_row 		: signed(9 downto 0);
signal AI_ball2_flag		: std_logic := '1';

-- AI Tank 1 variables
signal tank_width 	: signed(9 downto 0) := to_signed(50,10);
signal s_tank_row 	: signed(9 downto 0) := to_signed(30,10);
signal s_tank_col 	: signed(9 downto 0);
signal tank_col_vel 	: signed(9 downto 0);
signal tankSpeed		: integer range 0 to 6;
signal random_active : std_logic := '1';

-- AI Tank 2 variables
signal s_tank2_row 	: signed(9 downto 0) := to_signed(90,10);
signal s_tank2_col 	: signed(9 downto 0);
signal tank2_col_vel : signed(9 downto 0);

-- Player Tank variables
signal s_pTank_col : signed (9 downto 0);
signal s_pTank_row : signed (9 downto 0);

-- Screen bounds and other variables
signal screen_width 	: signed(9 downto 0) := to_signed(640,10);
signal rightBounds 	: signed(9 downto 0) := to_signed(600,10);
signal leftBounds 	: signed(9 downto 0) := to_signed(10,10);
signal mouseClicked 	: std_logic := '0';
signal s_collision	: std_logic := '0';

begin
-- Fixed row position of player tank
s_pTank_row <= to_signed(400,10);

--================================ MOVE OBJECTS =========================================	
	move_objects : process (v_sync)
	begin
		if(rising_edge(v_sync)) then
			
			if(ResetGame = '1') then
				s_tank_row <= to_signed(30,10);
				GameOver <= '0';
			end if;
		
			if(pauseGame = '0') then
			
				--************************* AI TANKS ****************************************
				-- Set AI tank's initial speed based on the level
				if (Level = "001") then
					tankSpeed <= 3;
				elsif(Level = "010") then
					tankSpeed <= 4;
				elsif(Level = "011") then
					tankSpeed <= 4;
				elsif(Level = "100") then
					tankSpeed <= 5;
				elsif(Level = "101") then
					tankSpeed <= 5;
				elsif(Level = "110") then
					tankSpeed <= 6;
				else
					tankSpeed <= 2;
				end if;		
				
				------------------------ TANK 1(UPPER TANK) --------------------------------
				-- Constantly move the Tank 1 within screen bounds, move down if Level 4
				if ('0' & s_tank_col >= '0' & (to_signed(640,10) - tank_width)) then
					if (Level = "100") then
						s_tank_row <= s_tank_row + to_signed(15,10);
					end if;
					tank_col_vel <= - to_signed(tankSpeed,10);
				
				elsif ('0' & s_tank_col <= '0' & to_signed(10,10)) then
					if (Level = "100") then
						s_tank_row <= s_tank_row + to_signed(15,10);
					end if;
					tank_col_vel <= to_signed(tankSpeed,10);
				end if;
				s_tank_col <= s_tank_col + tank_col_vel;
				----------------------------------------------------------------------------
				
				------------------------ TANK 2(LOWER TANK) --------------------------------
				-- Tank 2 only present in Level 2
				-- Constantly move the Tank 2 within screen bounds
				if (Level = "010" or Level = "110") then
					if ('0' & s_tank2_col >= '0' & (to_signed(640,10) - tank_width)) then
						tank2_col_vel <= - to_signed(tankSpeed,10);
					elsif ('0' & s_tank2_col <= '0' & to_signed(10,10)) then
						tank2_col_vel <= to_signed(tankSpeed,10);
					end if;
					s_tank2_col <= s_tank2_col + tank2_col_vel;
				end if;	
				--**************************************************************************	
				--************************ PLAYER TANK *************************************
				-- Control player tank with mouse
				s_pTank_col <= signed(mouse_col);
				--**************************************************************************				
								
				--************************ BALL CONTROL ************************************
				-------------------------- PLAYER'S BALL -----------------------------------
				-- Ball follows player tank until it is fired
				if((mouse_leftClick = '1')) then
					mouseClicked <= '1';
				end if;
				
				-- If ball is shot, move it up until it's off screen, then set it back on the tank
				if (mouseClicked = '1') then
					if(sBall_row < 0) then	-- If the ball goes out of screen...
						sBall_row <= s_pTank_row;
						sBall_col <= s_pTank_col;
						mouseClicked <= '0';
					else
						sBall_row <= sBall_row - to_signed(15,10); -- Move ball upwards 
					end if;
				else
					sBall_row <= s_pTank_row; -- Ball follows player tank
					sBall_col <= signed(mouse_col) + to_signed(20,10);
				end if;
				-----------------------------------------------------------------------------
				
				-------------------------------- AI BALL ------------------------------------
				-- For Tank 1 only
				if (Level = "101" or Level = "110") then
					if ((count_ones = "0000" or count_ones = "0011" or count_ones = "0101" or count_ones = "0111") and AI_ball_flag = '1') then
						-- Fire the ball
						AI_sBall_row <= AI_sBall_row + to_signed(15,10); -- Move ball downwards
					elsif (count_ones = "0001" or count_ones = "0100" or count_ones = "0110" or count_ones = "1000" or (AI_sBall_row + ball_size > to_signed(480,10))) then
						AI_sBall_row <= s_tank_row + tank_width - ball_size; -- Ball follows the tank
						AI_sBall_col <= s_tank_col + to_signed(20,10);
						AI_ball_flag <= '1';
					else 
						AI_ball_flag <= '0';
					end if;
				end if;
				
				-- For Tank 2 only
				if (Level = "110") then
					if ((count_ones = "0001" or count_ones = "0100" or count_ones = "0110" or count_ones = "1000") and AI_ball2_flag = '1') then
						-- Fire the ball
						AI_sBall2_row <= AI_sBall2_row + to_signed(15,10); -- Move ball downwards
					elsif ((count_ones = "0000" or count_ones = "0011" or count_ones = "0101" or count_ones = "0111")or (AI_sBall_row + ball_size > to_signed(480,10))) then
						AI_sBall2_row <= s_tank2_row + tank_width - ball_size; -- Ball follows the tank
						AI_sBall2_col <= s_tank2_col + to_signed(20,10);
						AI_ball2_flag <= '1';
					else
						AI_ball2_flag <= '0';
					end if;
				end if;
				--***************************************************************************
					
				--***************************** COLLISIONS **********************************
				-- Ball and one tank must be intersecting. Check for Tank 2 first
				
				-------------------------- PLAYER BALL AND TANK 2 ---------------------------
				if((sBall_row <= s_tank2_row + tank_width) and (sBall_col + ball_size >= s_tank2_col) and (sBall_col <= s_tank2_col + tank_width)) then
					if(Level = "010" or Level = "110") then
						s_collision <= '1';		
						sBall_row <= s_pTank_row;
						sBall_col <= s_pTank_col;
						mouseClicked <= '0';
						
						-- Randomise the column position. Ignore the MSB if it's out of bounds. Limit lower bounds to 10
						if (signed(random_number) > to_signed(640, 10) - tank_width) then					
							s_tank_col <= signed('0' & random_number(8 downto 0));
						elsif (signed(random_number) < to_signed(10, 10)) then	
							s_tank_col <= to_signed(10,10);
						end if;
					end if;
				-----------------------------------------------------------------------------
				
				-------------------------- PLAYER BALL AND TANK 1 ---------------------------	
				-- Different things will happen during collision on different levels
				
				elsif((sBall_row <= s_tank_row + tank_width) and (sBall_col + ball_size >= s_tank_col) and (sBall_col <= s_tank_col + tank_width)) then
					s_collision <= '1';	
					sBall_row <= s_pTank_row;
					sBall_col <= s_pTank_col;
					mouseClicked <= '0';
					
					-- If Level 4 and tank is hit, move the tank back
					if (Level = "100") then
						if (s_tank_row > to_signed(30,10)) then
							s_tank_row <= s_tank_row - to_signed(10,10);
						else
							s_tank_row <= to_signed(30,10);
						end if;
					end if;
					
					tank_col_vel <= to_signed(tankSpeed,10);
					
					-- Randomise the column position. Ignore the MSB if it's out of bounds. Limit lower bounds to 10
					if (signed(random_number) > to_signed(640, 10) - tank_width) then					
						s_tank_col <= signed('0' & random_number(8 downto 0));
					elsif (signed(random_number) < to_signed(10, 10)) then	
						s_tank_col <= to_signed(10,10);
					end if;
				-----------------------------------------------------------------------------
				else
					s_collision <= '0';
				end if;			
			--	*******************************************************************
			
			--	************ TANK RANDOMISATION FOR LEVELS 3 AND 5 ****************
			-- Based on the game timer (seconds), the position will change to a random value, and direction will change
			
				if ((count_ones = "0000" or count_ones = "0011" or count_ones = "0101" or count_ones = "0111") and (Level = "011" or Level = "101") and random_active = '1') then
					-- Flip direction
					tank_col_vel <= - to_signed(tankSpeed,10);
					s_tank_col <= s_tank_col + tank_col_vel;
					
					-- Randomise position (within bounds)	
					if (signed(random_number) > to_signed(640, 10) - tank_width) then					
						s_tank_col <= signed('0' & random_number(8 downto 0));
						random_active <= '0';
					elsif (signed(random_number) < to_signed(10, 10)) then	
						s_tank_col <= to_signed(10,10);
						random_active <= '0';
					end if;
					
				elsif ((count_ones = "0001" or count_ones = "0100" or count_ones = "0110" or count_ones = "1000") and (Level = "011" or Level = "101" or Level = "110")) then
					random_active <= '1';
				end if;		
			--	*******************************************************************
			
			--	********************** GAME OVER CONDITIONS *********************** 
			-- Level 4: If vertical positioning of tanks will cause an overlap, end the game. Note that the tanks may not actually touch!
				if (Level = "100") then
					if (s_tank_row + tank_width >= s_pTank_row) then
						gameOver <= '1'; 
					else
						gameOver <= '0';
					end if;
				
			-- Level 5 and 6: If the player tank gets hit by the AI tank, the game is over
				elsif (Level = "101" or Level = "110") then
					if (((AI_sBall_row + ball_size >= s_PTank_row) and (AI_sBall_col + ball_size >= s_PTank_col) and (AI_sBall_col <= s_PTank_col + tank_width)) or
						((AI_sBall2_row + ball_size >= s_PTank_row) and (AI_sBall2_col + ball_size >= s_PTank_col) and (AI_sBall2_col <= s_PTank_col + tank_width))) then
						gameOver <= '1';
					end if;
				end if;
				-----------------------------------------------------------------------------	
			--	*******************************************************************
			end if;				
		end if;			
	end process move_objects;
	
		rgb_player <= "001";
		rgb_AI <= "001";
		collision <= std_logic(s_collision);	
		tank_col <= std_logic_vector(s_tank_col);
		tank_row <= std_logic_vector(s_tank_row);		
		tank2_col <= std_logic_vector(s_tank2_col);
		tank2_row <= std_logic_vector(s_tank2_row);
		ball_col <= std_logic_vector(sBall_col);
		ball_row <= std_logic_vector(sBall_row);
		AI_ball_col <= std_logic_vector(AI_sBall_col);
		AI_ball_row <= std_logic_vector(AI_sBall_row);
		AI_ball2_col <= std_logic_vector(AI_sBall2_col);
		AI_ball2_row <= std_logic_vector(AI_sBall2_row);
		DisplayTank1 <= '1';
		DisplayBall <= '1';
		pTank_row <= std_logic_vector(s_pTank_row);
		pTank_col <= std_logic_vector(s_pTank_col);
		
		DisplayTank2 <= '1' when (Level = "010" or Level = "110") else '0';
		Display_AI_Ball <= '1' when (Level = "101" or Level = "110") else '0';
		Display_AI_Ball2 <= '1' when (Level = "110") else '0';
--===================================================================================
end Behavioral;