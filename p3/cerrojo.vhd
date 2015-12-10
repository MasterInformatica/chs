----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:06:59 12/10/2015 
-- Design Name: 
-- Module Name:    cerrojo - Behavioral 
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

entity cerrojo is
    Port ( 	clk : in  STD_LOGIC;
				rst : in  STD_LOGIC;
				intro_in : in  STD_LOGIC;
				switches : in  std_logic_vector(7 downto 0);
				display : out  std_logic_vector(6 downto 0);
				lock : out  STD_LOGIC
			);
end cerrojo;

architecture Behavioral of cerrojo is

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

signal intro : std_logic;

type states is (inicial,uno,dos,tres,final);
signal currentState,nextState: states;
signal eq,ld: std_logic;
signal st : std_logic_vector(2 downto 0);
signal pass : std_logic_vector(7 downto 0);


begin


dut : debouncer port map (
	rst => rst,
	clk => clk,
	x => intro_in,
	xDebFallingEdge => intro);
	

eq <= '1' when (switches = pass) else '0';
	
registerpass:
process ( clk, rst)
begin
	if (rst = '0') then 
		pass <= "00000000";
	elsif ( clk'EVENT and clk = '1' and ld = '1' ) then
		pass <= switches;
	end if;
end process registerpass;

stateGen:
process(currentState, intro, eq)
begin
	nextState <= currentState;
	case currentState is
		when inicial =>
			st <= "100";
			ld <= '1';
			lock <= '0';
			if ( intro = '1') then
				nextState <= tres;
			end if;
		when tres =>
			st <= "011";
			ld <= '0';
			lock <= '1';
			if ( intro = '1' and eq = '1') then
				nextState <= inicial;
			elsif ( intro = '1' and eq = '0' ) then
				nextState <= dos;
			end if;
		when dos =>
			st <= "010";
			ld <= '0';
			lock <= '1';
			if ( intro = '1' and eq = '1') then 
				nextState <= inicial;
			elsif ( intro = '1' and eq = '0' ) then
				nextState <= uno;
			end if;
		when uno =>
			st <= "001";
			ld <= '0';
			lock <= '1';
			if ( intro = '1' and eq = '1' ) then
				nextState <= inicial;
			elsif ( intro = '1' and eq = '0' ) then
				nextState <= final;
			end if;
		when final =>
			st <= "000";
			ld <= '0';
			lock <= '1';
	end case;
end process stateGen;

state:
process ( rst, clk)
begin
	if ( rst = '0' ) then
		currentState <= inicial;
	elsif (clk'EVENT and clk = '1') then
		currentState <= nextState;
	end if;
end process state;

conv7segm: 
process (st)
begin
case st is
  when "000" => display <= "0111111";
  when "001" => display <= "0000110";
  when "010" => display <= "1011011";
  when "011" => display <= "1001111";
  when "100" => display <= "1100110";
  when "101" => display <= "1101101";
  --when "110" => display <= "1111101";
  --when "111" => display <= "0000111";
  --when "1000" => display <= "1111111";
  --when "1001" => display <= "1100111";
  when others => display <= "0000000";
end case;
end process conv7segm;

end Behavioral;

