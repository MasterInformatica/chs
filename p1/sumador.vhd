----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:53 11/26/2015 
-- Design Name: 
-- Module Name:    sumador - Behavioral 
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
library ieee;	
use	ieee.std_logic_1164.all;	
use	ieee.numeric_std.all;	
entity	sumador	is
		port	(op1	:	in		std_logic_vector	(3	downto	0);	
								op2	:	in		std_logic_vector	(3	downto	0);	
								res	:	out std_logic_vector	(3	downto	0));	
end	sumador;	
architecture rtl	of	sumador	is
begin
		res	<=	std_logic_vector(unsigned(op1)+unsigned(op2));	
end rtl;	
