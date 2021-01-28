----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2020 22:34:07
-- Design Name: 
-- Module Name: alu1bit - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity alu1bit is
Port(
          a,b,sela,selb,cin:in std_logic;
          co,res: out std_logic;
          op: in std_logic_vector(1 downto 0)
          );
end alu1bit;

architecture Behavioral of alu1bit is
Signal  auxA,auxB,auxAnd,AuxOr,AuxXor,AuxSuma: std_logic;
begin
auxA <= A XOR selA;
	auxB <= B XOR selB;
	
	auxAnd <= auxA  and AuxB ;
	auxOr <= auxA  or AuxB ;
	auxXor <= auxA  xor AuxB ;
	auxSuma <= auxA  xor AuxB  xor Cin;
	
	co <= (auxA and Cin)   OR (auxA and AuxB) OR ( auxB and Cin) When op = "11" else 
	       '0';
	res <= auxAnd   When op = "00" else
		auxOr   When op = "01" else
		auxXor   When op = "10" else
		auxSuma;
end Behavioral;
