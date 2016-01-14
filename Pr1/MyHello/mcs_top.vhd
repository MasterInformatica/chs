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
    IO_Ready : IN STD_LOGIC;
    UART_Rx : IN STD_LOGIC;
    UART_Tx : OUT STD_LOGIC
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
	constant DIRLEDS : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000000";
	constant DIRSWIT : STD_LOGIC_VECTOR(31 DOWNTO 0) := x"C0000004";
	
	SIGNAL Reset_n : STD_LOGIC;
	
	SIGNAL loadSwitches  : STD_LOGIC;
	SIGNAL loadLeds  : STD_LOGIC;
	SIGNAL out_Switches : STD_LOGIC_VECTOR(7 downto 0);
	SIGNAL in_Leds : STD_LOGIC_VECTOR(9 downto 0);
	
	
	signal CLKO : std_logic;
	-- mcb signals
	signal addr_ready : STD_LOGIC;
	signal ld_ready : std_logic;
	signal st_ready : std_logic;
	
	signal addr : std_logic_vector(31 downto 0);
	signal ready : std_logic;
	
	signal read_D : std_logic_vector(31 downto 0);
	signal write_D : std_logic_vector(31 downto 0);
begin


Reset_n <= NOT Reset;

Inst_divisor: divisor PORT MAP(
		CLKIN_IN => Clk ,
		RST_IN => Reset_n,
		CLKDV_OUT => CLKO,
		CLKIN_IBUFG_OUT => open,
		CLK0_OUT => open,
		LOCKED_OUT => open
	);

mcs_0: microblaze_mcs
  PORT MAP (
    Clk => CLKO,
    Reset => Reset_n,
    IO_Addr_Strobe => addr_ready,
    IO_Read_Strobe => ld_ready,
	 IO_Write_Strobe => st_ready,
    IO_Address => addr,
    IO_Byte_Enable => open,
    IO_Write_Data => write_D,
    IO_Read_Data => read_D,
    IO_Ready => ready,
    UART_Rx => UART_Rx,
    UART_Tx => UART_Tx
  );
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

read_D (7 downto 0) <= out_Switches;
read_D (31 downto 8) <= (OTHERS=> '0');
in_Leds <= write_D (9 downto 0);

ready <= '1';
loadSwitches <= '1';
loadLeds <= '1' when (addr_ready = '1' and st_ready = '1' and addr = DIRLEDS) else '0';

end rtl;
