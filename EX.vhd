library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity EX is
Port(
    PCinc:in std_logic_vector(15 downto 0);
    RD1:in std_logic_vector(15 downto 0);
     RD2:in std_logic_vector(15 downto 0);
     Ext_imm:in std_logic_vector(15 downto 0);
     Alu_src:in std_logic;
     sa:in std_logic;
     func:in std_logic_vector(2 downto 0);
     AluOp:in std_logic_vector(2 downto 0);
     zero:out std_logic;
     Alures:inout std_logic_vector(15 downto 0);
     BranchAdr:out std_logic_vector(15 downto 0));
end EX;

architecture Behavioral of EX is
Signal Aluctrl:std_logic_vector(2 downto 0);
Signal temp:std_logic_vector(31 downto 0);
Signal temp2:std_logic_vector(15 downto 0);
Signal Tip:std_logic;
begin
   process (AluOp,func)
    begin
         if AluOp="000" then
           Aluctrl(2 downto 0)<=func(2 downto 0);Tip<='0';
         else
            Aluctrl(2 downto 0)<=AluOp(2 downto 0) - 1;Tip<='1';
            end if;
end process;
     process(Aluctrl)
     begin
     case Tip is
        when '0' =>
         case Aluctrl is
            when "000" => Alures<=RD1+RD2;
            when "001"=> Alures <=RD1-RD2;   --sub
            when "010"=> if sa='1' then Alures(15 downto 1) <=RD1(14 downto 0);Alures(0)<=RD1(15); end if; --shl
            when "011"=> if sa='1' then Alures(14 downto 0) <=RD1(15 downto 1);Alures(15)<=RD1(0); end if;
            when "100"=> Alures<=RD1 and RD2;
            when "101"=> Alures<=RD1 or RD2;
            when "110"=> if(RD1>RD2) then Alures<="0000000000000001"; else Alures<="0000000000000000"; end if;
            when "111"=> Alures<=RD1 xor RD2;
            end case;
         when '1' =>
            case Aluctrl is
            when "000" => Alures<=RD1+Ext_Imm;
            when "001" => Alures<=RD1;
            when "010" => Alures<=RD1;
            when "011" => Alures<=RD1-RD2;
            when "100" => if RD1/=RD2 then Alures<="0000000000000000"; end if;
            when "101" => if RD1>=RD2 then Alures<="0000000000000000"; end if;
            when others => Alures<=X"0000";
            end case;
       end case;
     if Alures="0000000000000000" then
        zero<='1';
     else
        zero<='0';
     end if;
     end process;
     process(PCinc,Ext_Imm)
     begin
        BranchAdr<=PCinc+Ext_Imm;
     end process;
end Behavioral;
