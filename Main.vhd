
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Main is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Main;

architecture Behavioral of Main is

signal enable : std_logic;
signal digits : STD_LOGIC_VECTOR(15 downto 0);

component MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           enable : out STD_LOGIC);
end component;

component SSD is
    Port ( clk : in STD_LOGIC;
       Digits : in std_logic_vector (15 downto 0);
       an : out std_logic_vector (3 downto 0);
       cat: out std_logic_vector (6 downto 0)
       );
end component SSD;

 
 component IFF is
    Port(
 CLK:in std_logic;
 Instruction:out std_logic_vector(15 downto 0);
 PC:out std_logic_vector(15 downto 0);
 BranchAdr: in std_logic_vector(15 downto 0);
 JMPAdr:in std_logic_vector (15 downto 0);
 PCSrc:in std_logic;
 JMP:in std_logic
 );
 end component;
 
 component ID is
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
 end component;
 
 component UC is
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
 end component;
 
 component EX is
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
 end component;
 
 component MEM is
Port(RD2:in std_logic_vector(15 downto 0);
     ALURes:in std_logic_vector(15 downto 0);
     MemWrite:in std_logic;
     Read_data:out std_logic_vector(15 downto 0);
     ALURes2:out std_logic_vector(15 downto 0);
     CLK:in std_logic);
 end component;
 
 signal Instruction, PCinc, RD1, RD2, WD, Ext_Imm : STD_LOGIC_VECTOR(15 downto 0);
 signal JumpAddress, BranchAddress, ALURes, ALURes1, MemData : STD_LOGIC_VECTOR(15 downto 0);
 signal func : STD_LOGIC_VECTOR(2 downto 0);
 signal sa, zero : STD_LOGIC;
 signal en, rst, PCSrc : STD_LOGIC;

 signal RegDst, ExtOp, ALUSrc, Branch, Jump, MemWrite, MemtoReg, RegWrite : STD_LOGIC;
 signal ALUOp : STD_LOGIC_VECTOR(2 downto 0);
  
  
 signal I,PCI,BRADR,JADR:STD_LOGIC_VECTOR(15 downto 0);
 signal PCS,J:std_logic;
 
 signal INSTR,RD12,RD22,RD222,EXTIMM,WD1,PCIN,MemData1,ADR22:STD_LOGIC_VECTOR(15 downto 0);
  signal REGW,REGD,EXTO,SA1,MemtoR,MEMW,ALUS,Branc:std_logic;
  signal FUNCT,ALUOP1:std_logic_vector(2 downto 0);
  signal WA12:std_logic_vector(2 downto 0);
  signal ALURes2:std_logic_vector(15 downto 0);
  
  signal REGW1,SA2,MemtoR1,MEMW1,Branch2:std_logic;
  signal PCIN1:std_logic_vector(15 downto 0);
 begin
 
 MPG1: MPG port map(clk,btn(0),en);
 MPG2: MPG port map(clk,btn(1),rst);
 SSD1 : SSD port map(clk,digits, an, cat);
 inst_IF : IFF port map(clk, Instruction, PCInc,BranchAddress, JumpAddress, PCSrc, Jump);
 process(clk)
 begin
 I<=Instruction;
 PCI<=PCInc;
 end process;
 
 inst_ID : ID port map(I(12 downto 0),RegWrite,RegDst,ExtOp, WD,  RD1, RD2,  Ext_Imm, func,sa ,clk);
 inst_MC : UC port map(I(15 downto 13), RegDst, ExtOp, Branch, ALUSrc, Jump, ALUOp, MemWrite, MemtoReg, RegWrite);
 process(clk)
 begin
 if rising_edge(clk) then
 RD12<=RD1;
 RD22<=RD2;
 PCIN<=PCI;
 EXTIMM<=Ext_Imm;
 FUNCT<=func;
 SA1<=sa;
 REGW<=RegWrite;
 REGD<=RegDst;
 MemtoR<=MemtoReg;
 ALUS<=ALUSRC;
 MEMW<=MemWrite;
 Branc<=Branch;
 ALUOP1<=ALUOp;
 end if;
 end process;

 inst_EX : EX port map(PCIN, RD12, RD22, EXTIMM,ALUS,SA1, FUNCT,   ALUOP1,zero,  ALURes,BranchAddress); 
 process(clk)
 begin
 if rising_edge(clk) then 
 REGW1<=REGW;
 MemtoR1<=MemtoR;
 SA2<=SA1;
 MEMW1<=MEMW;
 Branch2<=Branc;
 PCIN1<=PCIN;
 ALURes1<=ALURes;
 RD222<=RD22;
 end if;
 end process;
 inst_MEM : MEM port map(RD222, ALURes1,  MEMW, MemData, ALURes2,clk);
 process(clk)begin
 MemtoReg<=MemtoR1;
 RegWrite<=REGW1;
 Memdata1<=Memdata;
 ADR22<=ALURes2;
 end process;
 --branch control
 PCSrc <= Zero and Branch;
 --jump address
 JumpAddress <= PCIN(15 downto 13) & I(12 downto 0);
 
 -- Write back
 with MemtoReg select
     WD <= Memdata1 when '1',
           ADR22 when '0',
           (others => 'X') when others;
 
 end Behavioral;