LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

entity mcs_top is
	  PORT (
		 Clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 UART_Rx : IN STD_LOGIC;
		 UART_Tx : OUT STD_LOGIC; 
		 Leds : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 Switches : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
end mcs_top;

architecture rtl of mcs_top is

	COMPONENT microblaze_mcs
  PORT (
    Clk : IN STD_LOGIC;
    Reset : IN STD_LOGIC;
    IO_Addr_Strobe : OUT STD_LOGIC;
    IO_Read_Strobe : OUT STD_LOGIC;
    IO_Write_Strobe : OUT STD_LOGIC;
    IO_Address : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    IO_Byte_Enable : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    IO_Write_Data : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    IO_Read_Data : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    IO_Ready : IN STD_LOGIC
  );
END COMPONENT;
		COMPONENT divisor
	PORT(
		CLKIN_IN : IN std_logic;
		RST_IN : IN std_logic;          
		CLKDV_OUT : OUT std_logic;
		CLKIN_IBUFG_OUT : OUT std_logic;
		CLK0_OUT : OUT std_logic;
		LOCKED_OUT : OUT std_logic
		);
	END COMPONENT;
	COMPONENT register_n
		generic (n: integer :=8);
		Port ( 
			clk : in  STD_LOGIC;
         rst : in  STD_LOGIC;
			load : in  STD_LOGIC;
         D : in  STD_LOGIC_vector(n-1 downto 0);
         OutD : out  STD_LOGIC_vector(n-1 downto 0)
		);
	END COMPONENT;
	
		COMPONENT fifo_interfaz
	PORT(
		clk : IN std_logic;
		rst : IN std_logic;
		din : IN std_logic_vector(7 downto 0);
		wr_en : IN std_logic;
		rd_en : IN std_logic;          
		dout : OUT std_logic_vector(7 downto 0);
		full : OUT std_logic;
		empty : OUT std_logic;
		data_count : OUT std_logic_vector(7 downto 0);
		data_space : OUT std_logic_vector(7 downto 0)
		);
	END COMPONENT;
	
	COMPONENT RS232
		generic (	
			F: natural := 50000;
			min_baud	: natural := 19200
			);
		PORT(
			clk : IN std_logic;
			reset : IN std_logic;
			Rx : IN std_logic;
			datoAEnviar : IN std_logic_vector(7 downto 0);
			enviarDato : IN std_logic;          
			Tx : OUT std_logic;
			TxBusy : OUT std_logic;
			datoRecibido : OUT std_logic_vector(7 downto 0);
			RxErr : OUT std_logic;
			RxRdy : OUT std_logic
		);
	END COMPONENT;
	
	
	-- DIRS
	constant DIR_LEDS  : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000000";
	constant DIR_SWIT  : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000004";
	constant DIR_FR_DA : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000010";
	constant DIR_FR_ST : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000014";
	constant DIR_FW_DA : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000018";
	constant DIR_FW_ST : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C000001C";
	
	SIGNAL Reset_n : STD_LOGIC;
	signal CLKO : std_logic;
	-- UART signals
	signal TxBusy : std_logic_vector(7 downto 0);
	
	-- Register signals
	SIGNAL loadSwitches  : STD_LOGIC;
	SIGNAL loadLeds  : STD_LOGIC;
	SIGNAL out_Switches : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL in_Leds : STD_LOGIC_VECTOR(9 downto 0);
	
	
	-- mcb signals
	signal addr_ready : STD_LOGIC;
	signal ld_ready : std_logic;
	signal st_ready : std_logic;
	
	signal addr : std_logic_vector(31 downto 0);
	signal ready : std_logic;
	
	signal read_D : std_logic_vector(31 downto 0);
	signal write_D : std_logic_vector(31 downto 0);
	
	-- FIFO signals
	signal loadFW : std_logic;
	signal readFW : std_logic;
	signal in_FW  : std_logic_vector(7 downto 0);
	signal out_FW : std_logic_vector(7 downto 0);
	
	signal loadFR : std_logic;
	signal readFR : std_logic;
	signal in_FR  : std_logic_vector(7 downto 0);
	signal out_FR : std_logic_vector(7 downto 0);
	
	
begin
	Reset_n <= NOT Reset;

  -- --------------------------------------------------------------------------
  -- PROCESS
  -- -------------------------------------------------------------------------- 

-- WRITE
loadLeds <= '1' when (addr_ready = '1' and st_ready = '1' and addr = DIR_LEDS ) else '0';
loadFW   <= '1' when (addr_ready = '1' and st_ready = '1' and addr = DIR_FW_DA) else '0';
in_FW <= write_D(7 downto 0);


-- READ MCB
proc_read: process (addr_ready,addr,ld_ready)
begin
	if( addr_ready ='1' and ld_ready ='1') then
		if (addr = DIR_SWIT) then
			read_D (7 downto 0)  <= out_Switches;
			read_D (31 downto 8) <= (OTHERS=> '0'); 
		elsif (addr = DIR_FR_DA) then
			read_D (7 downto 0)  <= out_FR;
			read_D (31 downto 8) <= (OTHERS=> '0');
		else
			read_D <= (OTHERS => '0');
		end if;
	else
		read_D <= (OTHERS => '0');
	end if;
end process proc_read;

proc_W2U: process (TxBusy)
begin

end process proc_W2U;
  -- --------------------------------------------------------------------------
  -- Instancias
  -- -------------------------------------------------------------------------- 

	UART: RS232 
	generic map (
		F => 50000, min_baud => 19200)
	PORT MAP(
		clk => CLKO, -- in
		reset => Reset_n,-- in
		Rx => UART_Rx,-- in
		Tx => UART_Tx, -- out
		datoAEnviar => out_FW, -- in 7-0
		enviarDato => open, -- in
		TxBusy => TxBusy, -- out
		datoRecibido => in_FR, -- out 7-0
		RxErr => open, -- out
		RxRdy => loadFR -- out
	);

	read_fifo: fifo_interfaz PORT MAP(
		clk => CLKO,
		rst => Reset_n,
		din => in_FR,
		wr_en => loadFR,
		rd_en => readFR,
		dout => out_FR,
		full => open,
		empty => open
	);
	write_fifo: fifo_interfaz PORT MAP(
		clk => CLKO,
		rst => Reset_n,
		din => in_FW,
		wr_en => loadFW,
		rd_en => readFW,
		dout => out_FW,
		full => open,
		empty => open
	);

	divisor_0: divisor PORT MAP(
		CLKIN_IN => Clk ,
		RST_IN => Reset_n,
		CLKDV_OUT => CLKO,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open,
		LOCKED_OUT => open
	);

	mcs_0: microblaze_mcs PORT MAP (
		Clk => CLKO,
		Reset => Reset_n,
		IO_Addr_Strobe => addr_ready,
		IO_Read_Strobe => ld_ready,
		IO_Write_Strobe => st_ready,
		IO_Address => addr,
		IO_Byte_Enable => open,
		IO_Write_Data => write_D,
		IO_Read_Data => read_D,
		IO_Ready => ready
  );

  
  -- --------------------------------------------------------------------------
  -- Register for leds and switchs
  -- -------------------------------------------------------------------------- 
  
reg_led : register_n
	generic map (10)
	Port map (
			clk => CLKO,
         rst => Reset_n,
			load => loadLeds,
         D => in_Leds,
         OutD => Leds
		);
	  
reg_swi : register_n	  
	generic map (8)
	Port map (
			clk => CLKO,
         rst => Reset_n,
			load => loadSwitches,
         D => Switches,
         OutD => out_Switches
		);



in_Leds <= write_D (9 downto 0);

ready <= '1';
loadSwitches <= '1';
--loadLeds <= '1' when (addr_ready = '1' and st_ready = '1' and addr = DIR_LEDS) else '0';

end rtl;
