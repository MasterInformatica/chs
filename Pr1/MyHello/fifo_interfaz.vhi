
-- VHDL Instantiation Created from source file fifo_interfaz.vhd -- 16:51:38 01/14/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

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

	Inst_fifo_interfaz: fifo_interfaz PORT MAP(
		clk => ,
		rst => ,
		din => ,
		wr_en => ,
		rd_en => ,
		dout => ,
		full => ,
		empty => ,
		data_count => ,
		data_space => 
	);


