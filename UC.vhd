
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity UC is
    Port ( OpCode : in STD_LOGIC_VECTOR (2 downto 0);
           RegDst : out STD_LOGIC;
           ExtOp : out STD_LOGIC;
           Branch : out STD_LOGIC;
           ALUsrc : out STD_LOGIC;
           Jump : out STD_LOGIC;
           ALUop : out STD_LOGIC_VECTOR (2 downto 0);
           MemWrite : out STD_LOGIC;
           MemToReg : out STD_LOGIC;
           RegWrite : out STD_LOGIC);
end UC;

architecture Behavioral of UC is

begin
process(OpCode)
begin
case OpCode is 
    when "000" => 
         ALUop <= "000";
         RegDst <= '1';
         ExtOp <= 'X';
         ALUSrc <= '0';
         Branch <= '0';
         Jump <= '0';
         MemWrite <='0';
         MemtoReg <= '0';
         RegWrite <= '1';
    when "001" => --ADDI
         ALUop <= "000";
         RegDst <= '0';
         ExtOp <= '1';
         ALUSrc <= '1';
         Branch <= '0';
         Jump <= '0';
         MemWrite <='0';
         MemtoReg <= '0';
         RegWrite <= '1';
    when "010" => --LW
         ALUop <= "001";
         RegDst <= '0';
         ExtOp <= '1';
         ALUSrc <= '1';
         Branch <= '0';
         Jump <= '0';
         MemWrite <='0';
         MemtoReg <= '1';
         RegWrite <= '1';
    when "011" => --SW
         ALUop <= "010";
         RegDst <= 'X';
         ExtOp <= '1';
         ALUSrc <= '1';
         Branch <= '0';
         Jump <= '0';
         MemWrite <='1';
         MemtoReg <= 'X';
         RegWrite <= '0';
    when "100" => --BEQ
         ALUop <= "011";
         RegDst <= 'X';
         ExtOp <= '1';
         ALUSrc <= '0';
         Branch <= '1';
         Jump <= '0';
         MemWrite <='0';
         MemtoReg <= 'X';
         RegWrite <= '0';
    when "101" => --BNE
         ALUop <= "100";
         RegDst <= '0';
         ExtOp <= '1';
         ALUSrc <= '1';
         Branch <= '0';
         Jump <= '0';
         MemWrite <='0';
         MemtoReg <= '0';
         RegWrite <= '1';
    when "110" => --BG
         ALUop <= "110";
         RegDst <= '0';
         ExtOp <= '0';
         ALUSrc <= '1';
         Branch <= '0';
         Jump <= '0';
         MemWrite <='0';
         MemtoReg <= '0';
         RegWrite <= '1';
    when "111" =>
         ALUop <= "000";
         RegDst <= 'X';
         ExtOp <= 'X';
         ALUSrc <= 'X';
         Branch <= 'X';
         Jump <= '1';
         MemWrite <='0';
         MemtoReg <= 'X';
         RegWrite <= '1';
 end case;
 end process;
 
end Behavioral;