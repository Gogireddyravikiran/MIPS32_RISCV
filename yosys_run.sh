# read design

read_verilog iiitb_mips32_RISCV.v

# generic synthesis
synth -top iiitb_mips32_RISCV

# mapping to mycells.lib
dfflibmap -liberty /home/ravi/RISCV_32I/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/ravi/RISCV_32I/lib/sky130_fd_sc_hd__tt_025C_1v80.lib -script +strash;scorr;ifraig;retime,{D};strash;dch,-f;map,-M,1,{D}
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_mips32_RISCV_synth.v
