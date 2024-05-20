LIBRARY ieee;
USE ieee.STD_LOGIC_1164.ALL; 

entity dacMCP48x2 is
PORT(
    clk     : IN     STD_LOGIC;                             --system clock
    cs	    : OUT    STD_logic;
    sclk    : OUT    STD_LOGIC;                             --spi clock
    mosi    : OUT    STD_LOGIC;                             --master out slave in
    txA	    : IN     STD_LOGIC_VECTOR(11 DOWNTO 0);  --data to transmit to DAC1
    txB     : IN     STD_LOGIC_VECTOR(11 DOWNTO 0);   --data to transmit to DAC2
    DACSel  : IN     std_logic;-- 0 seleciona DAC1 e 1 seleciona DAC2
    DACGain : IN     std_logic; -- Seleciona o ganho do DAC
    SHDN    : IN     std_logic -- 1 ativa o DAC selecionado, 0 desliga
);
end dacMCP48x2;

architecture hardware of dacMCP48x2 is

COMPONENT spi
    	PORT(
        	clk 		: IN  STD_LOGIC;
        	reset_n 	: IN  STD_LOGIC;
        	enable 		: IN  STD_LOGIC;
		cpol    	: IN  STD_LOGIC;
		cpha    	: IN  STD_LOGIC;
		miso		: IN  STD_LOGIC;
        	sclk 		: OUT STD_LOGIC;
        	ss_n 		: OUT STD_LOGIC;
        	mosi 		: OUT STD_LOGIC;
        	busy 		: OUT STD_LOGIC;
        	tx 		: IN  STD_LOGIC_VECTOR(15 downto 0);
        	rx 		: OUT STD_LOGIC_VECTOR(15 downto 0)
       		);
END COMPONENT;

-- Sinais para utilizar no SPI
SIGNAL TX : STD_LOGIC_VECTOR(15 downto 0);
SIGNAL ENABLE : std_logic;
SIGNAL BUSY : std_logic;

SIGNAL BufferTX : STD_LOGIC_VECTOR(15 downto 0);

TYPE StateMachine_DAC is (IDLE, TRANSMIT, WAITING);
SIGNAL State_DAC : StateMachine_DAC;

begin

process(CLK)
begin
if(falling_edge(clk)) then
	CASE State_DAC is

		When IDLE =>
		if(DACSel = '0') then
			BufferTX <= '0' & '0' & DACGain & SHDN & txA;
		elsif(DACSel = '1') then
			BufferTX <= '1' & '0' & DACGain & SHDN & txA;
		end if;

		When TRANSMIT =>
			TX <= BufferTX;
			enable <= '1';
			if(BUSY = '1') then
				State_DAC <= WAITING;
			end if;

		When WAITING =>

	END CASE;
END IF;
end process;

end hardware;

