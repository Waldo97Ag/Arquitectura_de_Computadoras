library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
entity archivoR is
  Port ( 
  readData2,readData1: out std_logic_vector(15 downto 0);
  dir,wr,she : in std_logic;
  writeReg,readReg1,readReg2, shamt : in std_logic_vector(3 downto 0);
  clk,clr : in std_logic;  
  writeData: in std_logic_vector(15 downto 0) 
  
  );
end archivoR;

architecture Behavioral of archivoR is
type registers is array (0 to 15) of std_logic_vector(15 downto 0);
signal  archivoReg : registers;
begin
    
    --Un circuito secuencial debe llevar la lista sensible 
    --Debe de llevar además las se?ales de control asincronas
    
    process(clk,clr)
    variable auxQ: bit_vector(15 downto 0 );
    --variable archivoReg : registers;   -- si se ocupa como variable fuera del proces no se puede leer    
    begin
        
        --Operacion de CLR no necesita flancos de subida.
        if(clr = '1')then
            for i in 0 to 15 loop
                archivoReg(i) <= (others => '0');
            end loop;
        
        elsif(rising_edge(clk))then
            --Se analizan las se?ales de wr, dir y  she                       
            if(wr = '1' and she = '0' and clr = '0')then --Carga
                archivoReg(TO_INTEGER(unsigned(writeReg))) <= writeData;
            end if; 
                                                 
            if(wr = '1' and she='1' and dir = '0')then --Desplazamiento a la derecha.
                auxQ :=   to_bitvector(archivoReg(TO_INTEGER(unsigned(readReg2))));
                archivoReg(TO_INTEGER(unsigned(writeReg))) <= to_stdlogicvector(auxQ srl TO_INTEGER(unsigned(shamt)));-- no se puede ocupar directo readData1, ya que no es inout :(             
            end if;
            if(wr = '1' and she='1' and dir = '1')then --Desplazamiento a la izquierda.
                archivoReg(TO_INTEGER(unsigned(writeReg))) <= std_logic_vector(unsigned(archivoReg(TO_INTEGER(unsigned(readReg2)))) sll TO_INTEGER(unsigned(shamt)));-- no se puede ocupar directo readData1, ya que no es inout :(             
            end if;                                            
        end if;      
    --como readReg1 es un tipo int se hace la conversión
    --tiene que ser unsigned ya que es lo que espera to_integer         
    --esto porque no tiene un valor por defecto    
    end process;
    readData1 <= archivoReg(TO_INTEGER(unsigned(readReg1)));
    readData2 <= archivoReg(TO_INTEGER(unsigned(readReg2)));


end Behavioral;