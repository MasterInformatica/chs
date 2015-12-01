----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:15:28 12/01/2015 
-- Design Name: 
-- Module Name:    fsm - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fsm is
    Port ( 
			clk : in std_logic;
			rst : in std_logic;
			button : in  STD_LOGIC;
         motor : out  STD_LOGIC;
			nulls : out std_logic_vector(8 downto 0));
end fsm;

architecture Behavioral of fsm is

component debouncer
  port (
    rst: in std_logic;
    clk: in std_logic;
    x: in std_logic;
    xDeb: out std_logic;
    xDebFallingEdge: out std_logic;
    xDebRisingEdge: out std_logic
  );
end component;

type states is (apagado, encendido);
signal currentState, nextState: states;

signal salidaDebouncer : std_logic;

begin
dut : debouncer port map (
	rst => rst,
	clk => clk,
	x => button,
	xDebFallingEdge => salidaDebouncer);

stateGen:
process( currentState, salidaDebouncer)
begin
	nextState <= currentState;
	case currentState is 
		when apagado =>
			motor <= '0';
				if (salidaDebouncer='1') then
					nextState <= encendido;
				end if;
		when encendido =>
			motor <= '1';
			if(salidaDebouncer='1') then
				nextState <= apagado;
			end if;
	end case;
end process stateGen;


state:
process (rst, clk)
begin
	if(rst='0') then
		currentState <= apagado;
	elsif (clk'EVENT and clk='1') then
		currentState <= nextState;
	end if;
end process state;

	nulls <= "000000000";

end Behavioral;

