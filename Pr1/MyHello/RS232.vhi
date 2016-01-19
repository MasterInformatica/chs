
-- VHDL Instantiation Created from source file RS232.vhd -- 15:22:47 01/19/2016
--
-- Notes: 
-- 1) This instantiation template has been automatically generated using types
-- std_logic and std_logic_vector for the ports of the instantiated module
-- 2) To use this template to instantiate this entity, cut-and-paste and then edit

	COMPONENT RS232
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

	Inst_RS232: RS232 PORT MAP(
		clk => ,
		reset => ,
		Rx => ,
		Tx => ,
		datoAEnviar => ,
		enviarDato => ,
		TxBusy => ,
		datoRecibido => ,
		RxErr => ,
		RxRdy => 
	);


