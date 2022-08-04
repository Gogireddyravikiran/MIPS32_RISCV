module RISCV32Itb;

reg clk;
integer k;

wire [31:0]WB1_OUT,PC,EX_MEM_ALUOUT;

iiitb_RISCV riscv(clk,WB1_OUT,PC,EX_MEM_ALUOUT);

initial clk=1'b1;

always #10 clk=!clk;

initial begin 

for(k=0;k<32;k=k+1) 
	riscv.REG[k] <=k ;
	
end
initial begin
$dumpfile("riscv.vcd");
$dumpvars(0,RISCV32Itb);
riscv.PC = 0;

riscv.MEM[0] = 32'h00208180; //add r3,r1,r2
riscv.MEM[1] = 32'h00208201;   
riscv.MEM[2] = 32'h0020E201; 
riscv.MEM[3] = 32'h00520302;//STORE R6,R5(R4)
riscv.MEM[4] = 32'h00521302;  // LOAD R6,R5(R4)

riscv.MEM[5] = 32'h00F00003; // beq r2,r3,immediate(12)
riscv.MEM[17]= 32'h00208180;//add 
end
initial #1000 $finish;
endmodule

