----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.11.2020 22:42:53
-- Design Name: 
-- Module Name: alunbits - Behavioral
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

entity alunbits is
 generic( N: Integer := 4);
    Port ( AVec,BVec : in STD_LOGIC_VECTOR (N-1 downto 0);
           selA,selB : in STD_LOGIC;
           op : in STD_LOGIC_VECTOR (1 downto 0);
           ResVec : out STD_LOGIC_VECTOR ( N-1 downto 0);
           C,Negative,Ov,Z : out STD_LOGIC
           );
end alunbits;

architecture Behavioral of alunbits is
component alu1bit is
Port(
          a,b,sela,selb,cin:in std_logic;
          co,res: out std_logic;
          op: in std_logic_vector(1 downto 0)
          );
end component;
signal COutIn :STD_LOGIC_VECTOR (N downto 0);
signal ResVecT: std_logic_vector( N-1 DOWNTO 0);
begin
 process(selB)
    begin
    COutIn(0) <= selB;
    end process;
    
    Ciclo: for i in 0 to N-1 generate
        ---compoennt  
        objAlu: Alu1Bit PORT MAP ( 
            a => AVec(i),
            b => BVec(i),
            sela => selA,
            selb => selB,
            cin => COutIn(i),
            co => COutIn(i+1),
            res=>ResVecT(i),
            op => op
        );
        -----component  
    end generate; 
process(ResVecT,COutIn)
    variable resOrAux:std_logic;
    begin
        for i in 0 to N-1 loop
            if(i=0) then
                resOrAux := ResVecT(i);
            else
                resOrAux := resOrAux OR ResVecT(i);
            end if;
        end loop;
        Z <= NOT(resOrAux);
    end process;
        ResVec <= ResVecT;
        c <= COutIn(N);
        Negative <= ResVecT(N-1);
        Ov <= COutIn(N) xor COutIn(N-1);
    
end Behavioral;
