library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IFF is
    Port(CLK:in std_logic;
    Instruction:out std_logic_vector(15 downto 0);
    PC:out std_logic_vector(15 downto 0);
    BranchAdr: in std_logic_vector(15 downto 0);
    JMPAdr:in std_logic_vector (15 downto 0);
    PCSrc:in std_logic;
    JMP:in std_logic
    );
end IFF;

architecture Behavioral of IFF is
Signal RA:std_logic_vector(15 downto 0):="0000000000000000";
Signal NI:std_logic_vector(15 downto 0);
Signal Calc:std_logic_vector(15 downto 0);
Signal Calc2:std_logic_vector(15 downto 0);
type Rom_Mem is array(0 to 40) of std_logic_vector(15 downto 0);
Signal rom:Rom_Mem:=(
B"011_001_110_0000000",
B"011_010_110_0000001",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"000_011_001_010_0_110",
B"100_011_111_0000010",
B"000_001_001_010_0_001",
B"111_0000000001011",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"100_001_010_0000001",
B"111_0000000000110",
B"000_000_000_0000000",
B"010_010_111_0000010",
B"011_001_110_0000000",
B"011_010_110_0000001",
B"000_000_000_0000000",
B"000_101_001_101_0_000",
B"000_000_000_0000000",
B"000_010_010_111_0_001",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"100_010_110_0000001",
B"111_0000000010101",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"011_010_110_0000010",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"000_101_101_010_0_001",
B"000_100_111_100_0_000",
B"000_000_000_0000000",
B"000_000_000_0000000",
B"100_101_110_0000001",
B"111_0000000100100",
B"000_000_000_0000000",
B"010_100_111_0000011");
begin

process(CLK)
begin
if rising_edge(CLK) then
    RA(15 downto 0)<=NI(15 downto 0);
  end if;
  end process;
  
process(RA)
begin
Instruction<=rom(conv_integer(RA));
end process;

process(RA)
begin
Calc<=RA+1;
if Calc>="1111111111111111" then
Calc<="0000000000000000";
end if;
PC<=Calc;
end process;

process(calc)
begin
if PCSrc='1' then
Calc2(15 downto 0)<=BranchAdr(15 downto 0);
else
Calc2(15 downto 0)<=Calc(15 downto 0);
end if;
end process;

process(Calc2)
begin
if JMP='1' then
NI(15 downto 0)<=JmpAdr(15 downto 0);
else
NI(15 downto 0)<=Calc2(15 downto 0);
end if;
end process;



end Behavioral;
