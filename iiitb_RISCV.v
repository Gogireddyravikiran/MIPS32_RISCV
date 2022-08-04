`timescale 1ns / 1ps
module iiitb_RISCV(clk,WB1_OUT,PC,EX_MEM_ALUOUT);
input clk;
reg[31:0] IF_ID_IR;//instruction fetch stage

reg[31:0] ID_EX_A,ID_EX_B,ID_EX_IMMEDIATE;//instruction decode

reg[2:0] ID_EX_TYPE,EX_MEM_TYPE,MEM_WB_TYPE;//TYPES OF INSTRUCTONS

reg[31:0] EX_MEM_CONDITION,EX_MEM_B,EX_MEM_LATCH;//EXECUTION stage 

parameter ARTHIMETIC=7'd0,LOGICAL=7'd1,LOAD_STORE=7'd2,BRANCH=7'd3;//INSTRUCTIONS PRESENT IN RISCV 32I
parameter ADD=3'd0,SUB=3'd1,MUL=3'd2,DIV=3'd3,ADDI=3'd4,SUBI=3'd5;//Arthimetic instructions 
parameter AND=3'd0,OR=3'd1,XOR=3'd2,ANDI=3'd3,ORI=3'd4,XORI=3'd5,SLL=3'd6,SRL=3'd7,SRA=3'd8;
parameter SDW=3'd0,LDW=3'd1;
parameter BEQ=3'd0;
reg[31:0] MEM_WB_ALUOUT;//MEMORY  stage

output reg [31:0] EX_MEM_ALUOUT;

output reg [31:0]PC;///program counter
reg [31:0] ID_EX_IR,EX_MEM_IR,MEM_WB_IR,WB_IR;//INSTRUCTION REGISTERS
reg [31:0]ID_EX_PC,EX_MEM_PC,MEM_WB_PC;

reg [31:0]WB_OUT;
output reg[31:0]WB1_OUT;

 reg [31:0]REG[0:31];//register bank

reg [31:0]MEM[0:31];//32*32  instruction memory

reg [31:0]DM[0:31];//32*32 DATA MEMORY

//instruction fetch stage
always@(posedge clk) begin
if((EX_MEM_CONDITION==1) && EX_MEM_IR[6:0] == BRANCH) begin
PC = EX_MEM_ALUOUT;
IF_ID_IR = MEM[PC];
end

else begin
PC<=PC+1;
IF_ID_IR<=MEM[PC];
 end
 
end 
//fetch end      1st cycle--- fetch

//DECODE STAGE START 
always @(posedge clk) begin

ID_EX_A <= REG[IF_ID_IR[19:15]];
ID_EX_B <= REG[IF_ID_IR[24:20]];
ID_EX_IR <= IF_ID_IR;
ID_EX_IMMEDIATE <= {{20{IF_ID_IR[11]}},IF_ID_IR[31:20]};
ID_EX_PC <= PC;

end
//decode stage completion


//EXCECUTION STAGE START

always@(posedge clk) begin

EX_MEM_IR <=  ID_EX_IR;
EX_MEM_PC <= ID_EX_PC;

case(ID_EX_IR[6:0])

ARTHIMETIC:begin
case(ID_EX_IR[14:12]) 
ADD:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
SUB:EX_MEM_ALUOUT <= ID_EX_A - ID_EX_B;
MUL:EX_MEM_ALUOUT <= ID_EX_A * ID_EX_B;
DIV:EX_MEM_ALUOUT <= ID_EX_A / ID_EX_B;
ADDI:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_IMMEDIATE;
SUBI:EX_MEM_ALUOUT <= ID_EX_A - ID_EX_IMMEDIATE;
endcase
end

LOGICAL:begin
case(ID_EX_IR[14:12])
AND:EX_MEM_ALUOUT <= ID_EX_A & ID_EX_B;
OR:EX_MEM_ALUOUT <= ID_EX_A | ID_EX_B;
XOR:EX_MEM_ALUOUT <= ID_EX_A ^ ID_EX_B;
ANDI:EX_MEM_ALUOUT <= ID_EX_A & ID_EX_B;
ORI:EX_MEM_ALUOUT <= ID_EX_A | ID_EX_B;
XORI:EX_MEM_ALUOUT <= ID_EX_A ^ ID_EX_B;
SLL:EX_MEM_ALUOUT <= ID_EX_A << ID_EX_B;
SRL:EX_MEM_ALUOUT <= ID_EX_A >> ID_EX_B;

endcase
end

LOAD_STORE:begin
case(ID_EX_IR[14:12])
SDW:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
LDW:EX_MEM_ALUOUT <= ID_EX_A + ID_EX_B;
endcase
end

BRANCH: begin
case(ID_EX_IR[14:12])
BEQ:begin
EX_MEM_ALUOUT <= PC + ID_EX_IMMEDIATE;
EX_MEM_CONDITION <= (ID_EX_A == REG[ID_EX_IR[11:7]])?1:0;
end
endcase
end
endcase
end
//memory stage start

always@(posedge clk) begin
MEM_WB_IR <= EX_MEM_IR;

case(EX_MEM_IR[6:0])

ARTHIMETIC:MEM_WB_ALUOUT <= EX_MEM_ALUOUT;
LOGICAL:MEM_WB_ALUOUT <= EX_MEM_ALUOUT;
LOAD_STORE:begin
case(EX_MEM_IR[14:12])
SDW:DM[EX_MEM_IR[11:7]]=REG[EX_MEM_ALUOUT];
LDW:DM[EX_MEM_ALUOUT] = REG[EX_MEM_IR[11:7]];
endcase
end
endcase
end


//WRITE BACK STAGE START 

always@(posedge clk) begin
WB_IR <= MEM_WB_IR;

case(MEM_WB_IR[6:0])

ARTHIMETIC:begin 
WB_OUT<=MEM_WB_ALUOUT;
REG[MEM_WB_IR[11:7]]<=WB_OUT;
end

LOGICAL:begin
WB_OUT <= MEM_WB_ALUOUT;
REG[MEM_WB_IR[11:7]]<=WB_OUT;
end

LOAD_STORE:begin
WB_OUT <= DM[EX_MEM_ALUOUT];
end

endcase
end

//WRITE BACK AFTER 5 STAGES

always@(posedge clk) begin  //output after five stages.

case(WB_IR[6:0])

ARTHIMETIC:WB1_OUT<=WB_OUT;
LOGICAL:WB1_OUT<=WB_OUT;
LOAD_STORE:WB1_OUT <= WB_OUT;

endcase
end


endmodule
