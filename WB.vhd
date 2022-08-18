----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/09/2022 12:58:55 PM
-- Design Name: 
-- Module Name: WB - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WB is
Port(MemtoReg:in std_logic;
     ALURes:in std_logic_vector(15 downto 0);
     MemData:in std_logic_vector(15 downto 0);
     WriteData:out std_logic_vector(15 downto 0);
     PcSrc:out std_logic;
     Branch:in std_logic;
     Zero:in std_logic;
     );
end WB;

architecture Behavioral of WB is

begin
process()

end Behavioral;
