
module RISCV32Itb;

reg clk,reset;
integer k;

wire [31:0]WB1_OUT,PC;

iiitb_RISCV riscv(clk,WB1_OUT,PC,reset);

initial clk=1'b0;

always #10 clk=!clk;


initial begin
reset =0;#5;reset=1;#5;reset =0;
end
initial #1000 $finish;
endmodule
