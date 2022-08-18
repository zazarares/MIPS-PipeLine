

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MEM is
Port(RD2:in std_logic_vector(15 downto 0);
    ALURes:in std_logic_vector(15 downto 0);
    MemWrite:in std_logic;
    Read_data:out std_logic_vector(15 downto 0);
    ALURes2:out std_logic_vector(15 downto 0);
    CLK:in std_logic);

end MEM;

architecture Behavioral of MEM is
type ram_type is array (0 to 255) of std_logic_vector (15 downto 0);
signal ram:ram_type:=("0000000000000110","0000000000001000",others=>X"0000");
begin
process(CLK)
begin
    if(rising_edge(CLK)) then
        if MemWrite='1' then
            ram(conv_integer(ALURes))<=RD2;  
         end if;
         end if;              
end process;
process(ALuRes)
begin
Read_data<=ram(conv_integer(ALURes));
ALURes2<=ALURes;
end process;
end Behavioral;
