#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xparameters.h"
#include <IP_4MACHINE.h>
#include <xil_io.h>
#include <math.h>
int getNumber (){
	unsigned char byte;
	unsigned char uartBuffer[16];
	unsigned char validNumber;
	int digitIndex;
	int digit, number, sign;
	int c;

	while(1){
		byte = 0x00;
		digit = 0;
		digitIndex = 0;
		number = 0;
		validNumber = TRUE;

		//get bytes from uart until RETURN is entered

		while(byte != 0x0d){
			byte = inbyte();
			uartBuffer[digitIndex] = byte;
			xil_printf("%c", byte);
			digitIndex++;
		}

		//calculate number from string of digits

		for(c = 0; c < (digitIndex - 1); c++){
			if(c == 0){
							//check if first byte is a "-"
							if(uartBuffer[c] == 0x2D){
								sign = -1;
								digit = 0;
							}
							//check if first byte is a digit
							else if((uartBuffer[c] >> 4) == 0x03){
								sign = 1;
								digit = (uartBuffer[c] & 0x0F);
							}
							else
								validNumber = FALSE;
						}
						else{
							//check byte is a digit
							if((uartBuffer[c] >> 4) == 0x03){
								digit = (uartBuffer[c] & 0x0F);
							}
							else
								validNumber = FALSE;
						}
						number = (number * 10) + digit;
					}
					number *= sign;
					if(validNumber == TRUE){
						return number;
					}
					print("This is not a valid number.\n\r");
				}
			}

int main()
{
	int X,N,T,cont=0;
	float Q_c=0,Q_correct=0;
	    signed int Q;
	    //init_platform();
	    while(1)
	    {
	    	print("Value of X: ");
	    	X = getNumber();
	    	print("\r\n");

	    	print("Value of N: ");
	    	N = getNumber();
	    	print("\r\n");

	    	print("Value of T: ");
	    	T = getNumber();
	    	print("\r\n");
	    	//writing values to register
	    	IP_4MACHINE_mWriteReg(XPAR_IP_4MACHINE_0_S00_AXI_BASEADDR, 0, X);
	    	IP_4MACHINE_mWriteReg(XPAR_IP_4MACHINE_0_S00_AXI_BASEADDR, 4, N);
	    	IP_4MACHINE_mWriteReg(XPAR_IP_4MACHINE_0_S00_AXI_BASEADDR, 8, T);

	    	usleep(20000);
	    	//read value
	    	Q=IP_4MACHINE_mReadReg(XPAR_IP_4MACHINE_0_S00_AXI_BASEADDR, 12);
	    	Q_c = (X/(float)T)-sqrt(2*log(N)/T);
	    	Q_correct = Q/((float)10);
	    	printf("\n X: %d \n N: %d \n T: %d \n Q= %f ",X,N,T,Q);
	    	printf("\n Q_c=%f \t Q_correct =%f",Q_c,Q_correct);
	    	printf("\n Continue? (1/0)");
	    	if(getNumber()==0){
	    	    break;
	    	   }
	    }
	    init_platform();


    print("Hello World\n\r");

    cleanup_platform();
    return 0;
}
