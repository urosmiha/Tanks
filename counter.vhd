-- Copyright (C) 1991-2013 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 13.0.1 Build 232 06/12/2013 Service Pack 1 SJ Web Edition"
-- CREATED		"Fri May 12 19:08:35 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY counter IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		reset :  IN  STD_LOGIC;
		en :  IN  STD_LOGIC;
		ones :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
		tens :  OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END counter;

ARCHITECTURE bdf_type OF counter IS 

COMPONENT bcd_counter
	PORT(clk : IN STD_LOGIC;
		 reset : IN STD_LOGIC;
		 enable : IN STD_LOGIC;
		 Q_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

COMPONENT countdown
	PORT(clk : IN STD_LOGIC;
		 en : IN STD_LOGIC;
		 BCD_ones : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 BCD_tens : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 en_ones : OUT STD_LOGIC;
		 en_tens : OUT STD_LOGIC;
		 seg_ones : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 seg_tens : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_2 :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_3 :  STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN 



b2v_inst : bcd_counter
PORT MAP(clk => clk,
		 reset => reset,
		 enable => SYNTHESIZED_WIRE_0,
		 Q_out => SYNTHESIZED_WIRE_2);


b2v_inst1 : bcd_counter
PORT MAP(clk => clk,
		 reset => reset,
		 enable => SYNTHESIZED_WIRE_1,
		 Q_out => SYNTHESIZED_WIRE_3);


b2v_inst2 : countdown
PORT MAP(clk => clk,
		 en => en,
		 BCD_ones => SYNTHESIZED_WIRE_2,
		 BCD_tens => SYNTHESIZED_WIRE_3,
		 en_ones => SYNTHESIZED_WIRE_0,
		 en_tens => SYNTHESIZED_WIRE_1,
		 seg_ones => ones,
		 seg_tens => tens);


END bdf_type;