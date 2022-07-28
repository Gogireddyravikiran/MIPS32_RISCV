# read design

read_verilog iiitb_mips32_RISCV.v

# generic synthesis
synth -top iiitb_mips32_RISCV

# mapping to mycells.lib
dfflibmap -liberty /home/gogireddyravikiranreddy1/Desktop/iiitb_mips32_RISCV/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
abc -liberty /home/gogireddyravikiranreddy1/Desktop/iiitb_mips32_RISCV/lib/sky130_fd_sc_hd__tt_025C_1v80.lib
clean
flatten
# write synthesized design
write_verilog -noattr iiitb_mips32_RISCV_synth.v
