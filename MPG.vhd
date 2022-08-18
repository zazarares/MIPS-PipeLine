library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC ;
           enable : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal Q1 : std_logic ;
signal Q2 : std_logic ;
signal Q3 : std_logic;

signal count : std_logic_vector (15 downto 0) := "0000000000000000";

begin
    enable <= Q2 and (not Q3);
    process(clk)
    begin
        if rising_edge(clk) then
            if count(15 downto 0) = "1111111111111111" then
                        Q1 <= btn;
            end if;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
             Q2 <= Q1;
             Q3 <= Q2;
        end if;
    end process;
    
    process(clk)
    begin
        if rising_edge(clk) then
            count <= count +1;
        end if;
    end process;
            
end Behavioral;