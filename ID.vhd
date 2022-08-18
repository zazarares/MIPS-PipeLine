library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity ID is
Port(Instr:in Std_logic_vector(12 downto 0);
 RegWrite:in Std_logic;
 RegDst:in Std_logic;
 ExtOP:in std_logic;
 WD:in Std_logic_vector(15 downto 0);
 RD1:out std_logic_vector(15 downto 0);
 RD2:out std_logic_vector(15 downto 0);
 extimm:out std_logic_vector(15 downto 0);
 func:out std_logic_vector(2 downto 0);
 sa:out std_logic;
 clk:in std_logic
 );
end ID;

architecture Behavioral of ID is
type reg_file is array(7 downto 0) of std_logic_vector(15 downto 0);
Signal reg:reg_file:=(X"0000",X"0000",X"0000",X"0000",X"0000",X"0000",X"0000","00000000000000001");
Signal RA1:std_logic_vector(2 downto 0);
Signal RA2:std_logic_vector(2 downto 0);
Signal WA:std_logic_vector(2 downto 0);
begin
process(clk)
begin
RA1  <= instr(12 downto 10);
RA2  <= instr(9 downto 7);
if RegDst ='0' then
WA   <= instr(9 downto 7);
else
WA   <=instr(6 downto 4);
end if;
if rising_edge(CLK) and RegWrite='1' then
reg(conv_integer(WA))<=WD;
end if;
RD1<=reg(conv_integer(RA1));
RD2<=reg(conv_integer(RA2));
func<=instr(2 downto 0);
sa<=instr(3);
end process;

process(ExtOp)
begin
if ExtOp='1' then
extimm(15 downto 7)<="111111111";
extimm(6 downto 0)<=instr(6 downto 0);
else
extimm(15 downto 7)<="000000000";
extimm(6 downto 0)<=instr(6 downto 0);

end if;
end process;
end Behavioral;
