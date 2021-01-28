LIBRARY ieee;
LIBRARY STD;

USE STD.TEXTIO.ALL;

USE ieee.std_logic_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_textio.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
 
ENTITY tb_archivoR IS
END tb_archivoR;
 
ARCHITECTURE behavior OF tb_archivoR IS 
 
    ------Declaracion de componente archivoR------
    COMPONENT archivoR
        Port ( 
            writeData : in STD_LOGIC_VECTOR (15 downto 0);
            clk,clr: in STD_LOGIC;
            
            WR,SHE,DIR : in STD_LOGIC;
           
            writeReg : in std_logic_vector(3 downto 0);
            ReadReg1,ReadReg2: in std_logic_vector(3 downto 0);
            shamt : in std_logic_vector(3 downto 0);
            
            ReadData1,ReadData2 : out STD_LOGIC_VECTOR (15 downto 0)
        );
    END COMPONENT;
    -----------------------------------------------   

    ----------Entradas----------
    signal writeData : STD_LOGIC_VECTOR (15 downto 0);
    signal CLK,CLR: std_logic := '0';
    
    signal WR,SHE,DIR : STD_LOGIC :='0'; --OPER
    
    signal writeReg: std_logic_vector(3 downto 0) := (others => '0');
    signal ReadReg1,ReadReg2: std_logic_vector(3 downto 0) := (others => '0');
    signal shamt : std_logic_vector(3 downto 0) := (others => '0');
            
    signal ReadData1,ReadData2 : STD_LOGIC_VECTOR (15 downto 0);
    -----------------------------------------------   
    
    
    ----------Reloj----------
    constant CLK_period : time := 10 ns;
    -----------------------------------------------   
 
BEGIN
	-- Instanciar el registro de 16x2^4
  tb_archivoR: archivoR
        Port  MAP( 
            writeData => writeData,
            clk => clk,clr => clr,
            WR => WR,SHE => SHE,DIR => DIR,
            writeReg => writeReg,
            ReadReg1 => ReadReg1,ReadReg2 => ReadReg2,
            shamt => shamt,
            ReadData1 => ReadData1,ReadData2 => ReadData2
        );

    -- Clock process definitions
    CLK_process :process
    begin
        CLK <= '0';
        wait for CLK_period/2;
        CLK <= '1';
        wait for CLK_period/2;
    end process;
     -- Stimulus process																	
    stim_proc: process
	file ARCH_RES : TEXT;																					
	variable LINEA_RES : line;
	file ARCH_VEC : TEXT;
	variable LINEA_VEC : line;
	-------------------------------------------
	VARIABLE var_xd : Integer;
	VARIABLE var_writeData : std_logic_vector(15 downto 0);
	
    VARIABLE var_CLR: std_logic;
    VARIABLE var_WR,var_SHE,var_DIR: std_logic; --OPER
    VARIABLE var_writeReg: std_logic_vector(3 downto 0);
    VARIABLE var_ReadReg1,var_ReadReg2: std_logic_vector(3 downto 0);
    VARIABLE var_shamt : std_logic_vector(3 downto 0);
    VARIABLE var_ReadData1,var_ReadData2 : STD_LOGIC_VECTOR (15 downto 0);
	------------------------------------------------
	VARIABLE CADENA : STRING(1 TO 7);
    begin		
		file_open(ARCH_VEC, "C:\Users\helbo\AppData\Roaming\Xilinx\Vivado\Archivo_Registros\Vectors.txt", READ_MODE); 	
		file_open(ARCH_RES, "C:\Users\helbo\AppData\Roaming\Xilinx\Vivado\Archivo_Registros\Results.txt", WRITE_MODE); 	

		CADENA := "ReR1x16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "ReR2x16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "shamt16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "WrRgx16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "WrDtx16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "     WR";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);	--ESCRIBE LA CADENA "OPER"
		CADENA := "    SHE";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "    DIR";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "    CLR";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "RDa1x16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		CADENA := "RDa2x16";
		write(LINEA_RES, CADENA, right, CADENA'LENGTH+1);
		
		writeline(ARCH_RES,LINEA_RES);-- escribe la linea en el archivo

        writeData<=x"0000";

		WAIT FOR 10 NS;
		
		FOR I IN 0 TO 15 LOOP
			readline(ARCH_VEC,LINEA_VEC); -- lee una linea completa

			Hread(LINEA_VEC, var_ReadReg1);
			ReadReg1 <= var_ReadReg1;
			Hread(LINEA_VEC, var_ReadReg2);
			ReadReg2 <= var_ReadReg2;
			Hread(LINEA_VEC, var_shamt);			
			shamt <= var_shamt;
			Hread(LINEA_VEC, var_writeReg);
			writeReg <= var_writeReg;
			Hread(LINEA_VEC, var_writeData);
			writeData <= var_writeData;
			read(LINEA_VEC, var_WR);
			WR <= var_WR;
			read(LINEA_VEC, var_SHE);
			SHE <= var_SHE;
			read(LINEA_VEC, var_DIR);
			DIR <= var_DIR;
			read(LINEA_VEC, VAR_CLR);  
			CLR <= VAR_CLR;
			
			WAIT UNTIL RISING_EDGE(CLK);	--ESPERO AL FLANCO DE SUBIDA 
			
			var_ReadData1 := ReadData1;
			var_ReadData2 := ReadData2;
			
			Hwrite(LINEA_RES, var_ReadReg1,	right, 8);
			Hwrite(LINEA_RES, var_ReadReg2,	right, 8);
			Hwrite(LINEA_RES, var_shamt,right, 8);
			Hwrite(LINEA_RES, var_writeReg,right, 8);
			Hwrite(LINEA_RES, var_writeData,right, 8);
			write(LINEA_RES, var_WR, right, 8);	
			write(LINEA_RES, var_SHE, right, 8);	
		write(LINEA_RES, var_DIR, right, 8);	
			write(LINEA_RES, VAR_CLR,right,8);
			Hwrite(LINEA_RES, var_ReadData1,right,8);			
			Hwrite(LINEA_RES, var_ReadData2,right, 8);

		writeline(ARCH_RES,LINEA_RES);-- escribe la linea en el archivo
			
		end loop;
		file_close(ARCH_VEC);  -- cierra el archivo
		file_close(ARCH_RES);  -- cierra el archivo

      wait;
   end process;
	
END;
