LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL; 
USE ieee.numeric_std.ALL;
 
ENTITY SPI_TB IS
END SPI_TB;
 
ARCHITECTURE behavior OF SPI_TB IS 

COMPONENT dacMCP48x2 is
port(
    clk     : IN     STD_LOGIC;                             --system clock
    cs	    : OUT    STD_logic;
    sclk    : OUT    STD_LOGIC;                             --spi clock
    mosi    : OUT    STD_LOGIC;                             --master out slave in
    txA	    : IN     STD_LOGIC_VECTOR(11 DOWNTO 0);  --data to transmit to DAC1
    txB     : IN     STD_LOGIC_VECTOR(11 DOWNTO 0);   --data to transmit to DAC2
    DACSel  : IN     std_logic;-- 0 seleciona DAC1 e 1 seleciona DAC2
    DACGain : IN     std_logic; -- Seleciona o ganho do DAC
    SHDN    : IN     std_logic; -- 1 ativa o DAC selecionado, 0 desliga
    START   : IN     std_logic
);
end component;

-- Sinais para controle do componente
SIGNAL CLK_tb : std_logic := '0';
SIGNAL CS_tb : std_logic;
SIGNAL sclk_tb : std_logic;
SIGNAL mosi_tb : std_logic;
SIGNAL txA_tb  : std_logic_vector(11 downto 0) := "101010101010";
SIGNAL txB_tb  : std_logic_vector(11 downto 0) := "101010101010";
SIGNAL DACSel_tb : std_logic := '0';
SIGNAL DACGain_tb : std_logic := '0';
SIGNAL SHDN_tb : std_logic := '1';
SIGNAL START_tb : std_logic := '1';
constant dt : time := 25 ns;

BEGIN		
 
	process
	begin
	CLK_tb <= not CLK_tb;
	wait for dt;
	end process;

uut1 : dacMCP48x2 port map (
    clk     	=> CLK_tb,
    cs	    	=> CS_tb,
    sclk    	=> sclk_tb,
    mosi    	=> mosi_tb,
    txA	    	=> txA_tb,
    txB     	=> txB_tb,
    DACSel  	=> DACSel_tb,
    DACGain 	=> DACGain_tb,
    SHDN  	=> SHDN_tb,
    START	=> START_tb
);
END;
