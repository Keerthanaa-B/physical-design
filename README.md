# Physical_Design
## This is Keerthana B (MS2024010)
## Course - Physical Design of ASICs ( VLS508)
# LAB-1
## Objective
Compile and verify a basic C code using GCC and the RISC-V GNU compiler toolchain on Ubuntu, and compare the outputs.
## Materials and Tools
 ## Software Tools:
 GCC (GNU Compiler Collection)<br/>
 RISC-V GNU Compiler Toolchain<br/>
 Ubuntu OS<br/>
## Pre-Lab Preparation
Installed GCC and RISC-V GNU Compiler Toolchain on Ubuntu.<br/>
Prepared a simple C program for compilation.<br/>
## Procedure
## Task 1: Compile and Verify C Code using GCC
### 1. Code Snippet:
```c
include<stdio.h>
int main()
{ int i,sum=0,n=5;
for(i=1;i<=n;++i)
{sum+=i;}
printf("sum of numbers from 1 to %d is %d\n",n,sum);
return 0;
}
```
### 2. Compile the code using GCC:
```
gcc sum1ton.c
```
### 3. Run the compiled code:
```
./a.out
```
### 4. Output: For different values of n values which is 5, 10, 100 the following figure contains the output.
```
The sum from 1 to 5 is 15
```
![results](https://github.com/user-attachments/assets/68da1fe2-13a7-4770-a7ca-0db35fd1c7d3)
## Task 2: Compile and Verify C Code using RISC-V GNU Compiler Toolchain
### 1. Display and Compile the code using RISC-V GCC:
```
riscv64-unknown-elf-gcc -O1 -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
```
![risc1](https://github.com/user-attachments/assets/1d2a7bce-3d6b-46ac-bf73-57ad7ba683a9)

### 2. Run the compiled code (using an emulator if necessary):
```
riscv64-unknown-elf-objdump -d sum1ton.o | less
```
![risc2](https://github.com/user-attachments/assets/6d815db7-44b3-4d33-bc72-0b96b62e4d85)

### 3. Output(i): Here the -O1 optimization is used so the number of instructions is 15.

![risc3](https://github.com/user-attachments/assets/3b42727f-5f97-4f1f-8d8a-281de6c5b8ab)

### 4. Output(ii): Here the -Ofast optimization is used so the number of instructions are reduced to 12.

![risc5](https://github.com/user-attachments/assets/de60fb49-dae5-49e7-b3e2-129bf0ac015e)

![risc6](https://github.com/user-attachments/assets/c2eca8d6-feda-485d-b8de-eb6d860efb6c)

By comparing both -O1 and -Ofast, -Ofast gives the better optimization results which as only 12 instructions withrespect to the 15 instructions in -O1.

# LAB 2
## TASK 1
### Debugging with Spike Simulator and running object file generated by RISC-V Compiler in Spike Simulator
 The following steps to be followed. <br/>
## Step 1
 Compile sum1ton.c (C source file) into sum1ton.o (Object file) for RISC-V with Ofast Optimization
 ```
riscv64-unknown-elf-gcc -Ofast -mabi=lp64 -march=rv64i -o sum1ton.o sum1ton.c
```
## Step 2
Get the object dump using the command mentioned below
```
riscv64-unknown-elf-objdump -d sum1ton.o | less
```
![Screenshot from 2024-08-12 14-47-23](https://github.com/user-attachments/assets/1e802cc2-b16e-4d59-8ee9-ddd8e030088d)

 we get the following output 
 The snapshot of the assembly level of the main section of the program is shown below for reference

 ![Screenshot from 2024-08-12 14-53-44](https://github.com/user-attachments/assets/0ae0fe24-5c59-49a4-b463-23a7abe51002)

 ## Step 3

 Again compile the c program using gcc compiler and spike simulator. we get the following output shown below
![Screenshot from 2024-08-12 15-06-07](https://github.com/user-attachments/assets/d51a2222-9c63-4887-b90d-078b9f68b8cf)

## Step 4
For debugging the code, we use debugger using spike
```
spike -d pk sum1ton.o
```
we want to run our program till 100b0
```
until pc 0 100b0
```
After running the program manually, we can see the "bbl loader", this ensures that assembly code has run till 100b0 address, in my case <br/> 
* First command is lui a2,0x1 which changes a2 register <br/>
After excution of first instruction manually with spike debugger the a2 register value changes from 0x0000000000000000 to 0x0000000000001000 <br/>

we check the content of the register using following command
```
reg 0 a2
```
we will manually execute the next instruction i.e, lui a0,0x21 and addi sp,sp,-16 . this instruction will decrements the stact pointer. Before the execution the stack pointer register holds the value 0x0000003ffffffb50 and updated to 0x0000003ffffffb40 
```
reg 0 sp
```
after this instruction the stack pointer value is decremented by 10 in hexadecimal which is equivalent to 16 in decimal
![Screenshot from 2024-08-12 15-16-15](https://github.com/user-attachments/assets/eb7daffd-3b2b-4ddf-a586-2ccf4b0982c9)

# LAB 3

## TASK 1 : 32-bit RISC-V Instruction Formats: Encoding, Simulation and Waveform analysis
### RISC-V Instruction formats and Hexadecimal Encoding of Specific Instructions
### Base Instruction Formats

RISC-V has six core instruction formats: R,I,S,B,U and J. These are all fixed32 bit length. Here is a brief description of each format:

There are four core instruction formats (R/I/S/U), and there are a further two variants of the instruction formats (B/J) based on the handling of immediates.
1. **R-Type (Register)**
   + Format: funct7[31:25] | rs2[24:20] | rs1[19:15] | funct3[14:12] | rd[11:7] | opcode[6:0]
   + Used for register-register arithmetic, logical operations and load instructions.
   ![Screenshot 2024-07-24 191624](https://github.com/user-attachments/assets/41f5fc12-5e58-4e60-bebc-8b1cef556214)

2. **I-Type (Immediate)**
   + Format: imm[31:25] | rs2[24:20] | rs1[19:15] | funct3[14:12] | rd[11:7] | opcode[6:0]
   + Used for immediate arithmetic, logical operations and load instructions.
   ![Screenshot 2024-07-24 191624](https://github.com/user-attachments/assets/41f5fc12-5e58-4e60-bebc-8b1cef556214)    

3. **S-Type (Store)**
   + Format: imm[31:25] | rs2[24:20] | rs1[19:15] | funct3[14:12] | imm[11:7] | opcode[6:0]
   + Used for store instructions.
   ![Screenshot 2024-07-24 191625](https://github.com/user-attachments/assets/446beff5-399d-4426-b868-0d9c6d2ef271)

4. **U-Type (Upper Immediate)**
   + Format: imm[31:12] | rd[11:7] | opcode[6:0]
   + Used for instructions that operate with a 20-bit upper immediate , such as LUI (Load Upper Immediate).
   ![Screenshot 2024-07-24 191626](https://github.com/user-attachments/assets/60c0073d-2e33-4fbd-a54b-01a606aeb353)

5. **B-Type (Branch)**
   +  Format: imm[31:25] | rs2[24:20] | rs1[19:15] | funct3[14:12] | imm[11:7] | opcode[6:0]
   + Used for conditional branch instructions.
   ![Screenshot 2024-07-24 191847](https://github.com/user-attachments/assets/33c0c62f-3fe2-48bd-a1f5-18db951807cf)

6. **J-Type (Jump)**
   + Format: imm[31:20] | imm[19:12] | rd[11:7] | opcode[6:0]
   + Used for jump instructions such as JAL (Jump and Link).
   ![Screenshot 2024-07-24 191848](https://github.com/user-attachments/assets/7b2e93a1-1fc8-447f-95ed-1d34b82e8625)


   
     









