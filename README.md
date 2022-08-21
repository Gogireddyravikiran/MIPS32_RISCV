# iiitb_riscv32i


# What is RISCV ? 
Pronounced "risk-five," RISC-V is an ISA based on reduced instruction set computer (RISC) principles. Unlike most other ISA designs, it is provided under a open source license that does not require fees to use.

## 1.RISC-V RV32I

This project provides an insight into the working of a few important instructions of the instruction set of a pipelined Reduced Instruction Set Computer - Five(RISC-V) Instruction Set Architecture suitable for use across wide-spectrum of Applications from low power embedded devices to high performance Cloud based Server processors. The base RISC-V is a 32-bit processor with 31 general-purpose registers, so all the instructions are 32-bit long. Some Applications where the RISC-V processors have begun to make some significant threads are in Artificial intelligence and machine learning, Embedded systems, Ultra Low power processing systems etc.

### 2.BLOCK DIAGRAM OF RISC-V RV32I
![image](https://user-images.githubusercontent.com/110079770/185805070-ec1064d6-c38b-40f9-a56c-49884f82c7bf.png)

### 3.INSTRUCTION SET OF RISC-V RV32I
### Arthimetic Instructions
![image](https://user-images.githubusercontent.com/110079770/185805197-89877575-aade-4055-bc8d-e19b78aa2326.png)

### Logical Instructions
![image](https://user-images.githubusercontent.com/110079770/185805205-08f275e8-55cf-43dd-ad33-eb05a954a636.png)

### Load_store Instructions
![image](https://user-images.githubusercontent.com/110079770/185805224-ece3b50f-1733-4ec5-845d-246d78d97559.png)

### Branching Instructions
![image](https://user-images.githubusercontent.com/110079770/185805268-2c0139b4-9c45-407f-9a32-3b88682154a7.png)

### 4.FUNCTIONAL SIMULATION

**ABOUT VERILOG**
Icarus Verilog is an implementation of the Verilog hardware description language.

**ABOUT GTKWAVE**
GTKWave is a fully featured GTK+ v1. 2 based wave viewer for Unix and Win32 which reads Ver Structural Verilog Compiler generated AET files as well as standard Verilog VCD/EVCD files and allows their viewing.

**Installing iverilog and gtkwave**

**For Ubuntu**
Open your terminal and type the following to install iverilog and GTKWave
```
$   sudo apt get update
$   sudo apt get install iverilog gtkwave
```

**To clone the repository and download the netlist files for simulation , enter the following commands in your terminal.**
