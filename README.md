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








