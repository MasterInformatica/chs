library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mcs_top is
	  PORT (
		 Clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 UART_Rx : IN STD_LOGIC;
		 UART_Tx : OUT STD_LOGIC;
		 GPO1 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 GPI1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
end mcs_top;

architecture rtl of mcs_top is

	COMPONENT microblaze_mcs
	  PORT (
		 Clk : IN STD_LOGIC;
		 Reset : IN STD_LOGIC;
		 UART_Rx : IN STD_LOGIC;
		 UART_Tx : OUT STD_LOGIC;
		 GPO1 : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		 GPI1 : IN STD_LOGIC_VECTOR(7 DOWNTO 0)
	  );
	END COMPONENT;
	
	SIGNAL Reset_n : STD_LOGIC;

begin

Reset_n <= NOT Reset;

mcs_0 : microblaze_mcs
	  PORT MAP(
		 Clk => Clk,
		 Reset => Reset_n,
		 UART_Rx => UART_Rx,
		 UART_Tx => UART_Tx,
		 GPO1 => GPO1,
		 GPI1 => GPI1
	  );

end rtl;

