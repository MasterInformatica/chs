----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:33:28 12/17/2015 
-- Design Name: 
-- Module Name:    register_8 - Behavioral 
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

entity register_n is
	generic (n: integer :=8);
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
			  load : in  STD_LOGIC;
           D : in  STD_LOGIC_vector(n-1 downto 0);
           OutD : out  STD_LOGIC_vector(n-1 downto 0)
			);
end register_n;

architecture Behavioral of register_n is
begin


register_n:
process ( clk, rst)
begin
	if (rst = '0') then 
		 OutD <= (OTHERS=>'0');
	elsif ( clk'EVENT and clk = '1' and load = '1') then
		OutD <= D;
	end if;	
	
end process register_n;	  


end Behavioral;

