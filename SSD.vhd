library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SSD is
    Port ( clk : in STD_LOGIC;
           Digits : in std_logic_vector (15 downto 0);
           an : out std_logic_vector (3 downto 0);
           cat: out std_logic_vector (6 downto 0)
           );
end SSD;

architecture Behavioral of SSD is

signal mux1 : std_logic_vector (3 downto 0);
signal count : std_logic_vector (15 downto 0) := "0000000000000000";
begin
    
    process(clk) --counter 
    begin
        if rising_edge(clk) then
            count <= count + 1;
        end if;
    end process;
    
    --anod 1110 1101 1011 0111
    process(count(15 downto 14))
    begin
        if count(15 downto 14) = "00" then
            mux1 <= Digits(3 downto 0);
            an <= "1110";
        elsif count(15 downto 14) = "01" then
            mux1 <= Digits(7 downto 4);
            an <= "1101";
        elsif count(15 downto 14) = "10" then
            mux1 <= Digits(11 downto 8);
            an <= "1011";
        elsif count(15 downto 14) = "11" then
            mux1 <= Digits(15 downto 12);
            an  <= "0111";
        end if;
    end process;

    process (mux1)
    begin
    case mux1 is
        when "0000"=> cat <="1000000";  -- '0'0000001 
        when "0001"=> cat <="1111001";  -- '1'1001111 
        when "0010"=> cat <="0100100";  -- '2'0010010 
        when "0011"=> cat <="0110000";  -- '3'0000110 
        when "0100"=> cat <="0011001";  -- '4'1001100 
        when "0101"=> cat <="0010010";  -- '5'0100100 
        when "0110"=> cat <="0000010";  -- '6'0100000 
        when "0111"=> cat <="1111000";  -- '7'0001111 
        when "1000"=> cat <="0000000";  -- '8'0000000 
        when "1001"=> cat <="0010000";  -- '9'0000100 
        when "1010"=> cat <="0001000";  -- 'A'0001000 
        when "1011"=> cat <="0000011";  -- 'B'1100000 
        when "1100"=> cat <="1000110";  -- 'C'0110001 
        when "1101"=> cat <="0100001";  -- 'D'1000010 
        when "1110"=> cat <="0000110";  -- 'E'0110000 
        when "1111"=> cat <="0001110";  -- 'F'0111000 
        when others =>  NULL;
    end case;
end process;

end Behavioral;