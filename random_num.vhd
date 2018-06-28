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
-- CREATED		"Thu May 11 16:19:41 2017"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY random_num IS 
	PORT
	(
		clk :  IN  STD_LOGIC;
		random :  OUT  STD_LOGIC_VECTOR(9 DOWNTO 0)
	);
END random_num;

ARCHITECTURE bdf_type OF random_num IS 

SIGNAL	high :  STD_LOGIC;
SIGNAL	random_ALTERA_SYNTHESIZED :  STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;


BEGIN 



PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(0) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(0) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(0) <= random_ALTERA_SYNTHESIZED(9);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(1) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(1) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(1) <= random_ALTERA_SYNTHESIZED(0);
END IF;
END PROCESS;


SYNTHESIZED_WIRE_0 <= random_ALTERA_SYNTHESIZED(9) XOR random_ALTERA_SYNTHESIZED(1);


SYNTHESIZED_WIRE_1 <= NOT(random_ALTERA_SYNTHESIZED(9) XOR random_ALTERA_SYNTHESIZED(8));



PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(2) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(2) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(2) <= SYNTHESIZED_WIRE_0;
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(3) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(3) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(3) <= random_ALTERA_SYNTHESIZED(2);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(4) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(4) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(4) <= random_ALTERA_SYNTHESIZED(3);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(5) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(5) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(5) <= random_ALTERA_SYNTHESIZED(4);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(6) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(6) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(6) <= random_ALTERA_SYNTHESIZED(5);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(7) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(7) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(7) <= random_ALTERA_SYNTHESIZED(6);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(8) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(8) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(8) <= random_ALTERA_SYNTHESIZED(7);
END IF;
END PROCESS;


PROCESS(clk,high,high)
BEGIN
IF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(9) <= '0';
ELSIF (high = '0') THEN
	random_ALTERA_SYNTHESIZED(9) <= '1';
ELSIF (RISING_EDGE(clk)) THEN
	random_ALTERA_SYNTHESIZED(9) <= SYNTHESIZED_WIRE_1;
END IF;
END PROCESS;

random <= random_ALTERA_SYNTHESIZED;

high <= '1';
END bdf_type;