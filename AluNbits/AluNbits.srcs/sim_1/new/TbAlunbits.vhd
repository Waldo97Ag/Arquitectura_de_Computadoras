----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2020 22:52:34
-- Design Name: 
-- Module Name: TbAlunbits - Behavioral
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

entity TbAlunbits is

end TbAlunbits;

architecture Behavioral of TbAlunbits is
component alunbits is
    Port ( AVec,BVec : in STD_LOGIC_VECTOR (3 downto 0);
           selA,selB : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           ResVec : out STD_LOGIC_VECTOR ( 3 downto 0);
           C,Negative,Ov,Z : out STD_LOGIC
           );
end component;
signal AVec,BVec : STD_LOGIC_VECTOR (3 downto 0);
signal selA,selB : STD_LOGIC;
signal op : STD_LOGIC_VECTOR (1 downto 0);
signal ResVec : STD_LOGIC_VECTOR ( 3 downto 0);
signal C,Negative,Ov,Z : STD_LOGIC;

begin
alu:alunbits Port map(
        AVec=>AVec,
        BVec=>BVec,
           selA=>selA,
           selB=>selB, 
           op=>op, 
           ResVec=>ResVec, 
           C=>C,
           Negative=>Negative,
           Ov=>Ov,
           Z=>Z
           );
           
process 
    begin 
    -- 1 - 4
    AVec <="0101";
    BVec <="1110";
    --suma
    selA<='0';
    selB<='0';
    op <= "11";
    wait for 50ns;
    --resta
    selA<='0';
    selB<='1';
    op <= "11";
    wait for 50ns;
    --and
    selA<='0';
    selB<='0';
    op <= "00";
    wait for 50ns;
    --nand
    selA<='1';
    selB<='1';
    op <= "01";
    wait for 50ns;
    --or
    selA<='0';
    selB<='0';
    op <= "01";
    wait for 50ns;
    --nor
    selA<='1';
    selB<='1';
    op <= "00";
    wait for 50ns;
    --xor
    selA<='0';
    selB<='0';
    op <= "10";
    wait for 50ns;
    --xnor
    selA<='1';
    selB<='0';
    op <= "10";
    wait for 50ns;
    --suma
    AVec <="0101";
    BVec <="0111";
    selA<='0';
    selB<='0';
    op <= "11";
    wait for 50ns;
    --resta
    AVec <="0101";
    BVec <="0101";
    selA<='0';
    selB<='1';
    op <= "11";
    wait for 50ns;
    --nand(not)
    selA<='1';
    selB<='1';
    op <= "01";
    wait for 50ns;
end process; 

end Behavioral;
