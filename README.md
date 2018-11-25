# Q-function-on-Zybo-SOC-
Implemented a mathematical function coded in Verilog and System C  on Zybo-SOC FPGA and output was verified using UART console on XIlinx Vivado SDK.

Q-Function is
(X/T)+(2*2.303*log(N)/T)
X,N,T are real valued inputs

How to use this code-
1. Create a custom IP of q-function using q-func.v and user logic.v
2. Create a new block diagram and call the custom IP into it and Zync-7 Processing System.
3. Create HDL-Wrapper and generate the bit stream.
4. Open SDK by importing the current project into it.
5. Create a new project and import hello_world.c in it.
6. Make the necessary changes in the address variables in x-parameters.h and call the necessary header fies.
7. Save the project and check the output on UART console in the SDK by connecting it to Zybo-board.