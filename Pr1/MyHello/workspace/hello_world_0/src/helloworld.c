/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 */
/*
//Extra: Accessing the GPIO, using xil_printf, and using the UART.
#include <stdio.h>
#include "platform.h"
#include "xparameters.h" // add
#include "xiomodule.h" // add
void print(char *str);
int main()
{
	init_platform();
	u32 data;
	XIOModule iomodule; // iomodule variable for gpi, gpo, and uart
	u8 msg[15] = "This is a test";// buffer for sending message using XIOModule_Send
	u8 rx_buf[10]; // receive buffer using XIOModule_Recv
	u32 counter;
	// example using xil_printf
	counter = 1234;
	xil_printf("The counter value is %d in decimal and %x in hex\n\r", counter, counter);
	print("Read switches, write to LED port, and UART send and receive chars\n\r");
	// Initialize module to obtain base address
	data = XIOModule_Initialize(&iomodule, XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start(&iomodule);
	// Need to call CfgInitialize to use UART Send and Recv functions
	// int XIOModule_CfgInitialize(XIOModule *InstancePtr, XIOModule_Config *Config, u32 EffectiveAddr);
	// note config and effective address arguments are not used
	data = XIOModule_CfgInitialize(&iomodule, NULL, 1);
	xil_printf("CFInitialize returned (0 = success) %d\n\r", data);
	// Send 12 characters using Send
	// Send is non-blocking so must be called in a loop, may return without sending a character
	// unsigned int XIOModule_Send(XIOModule *InstancePtr, u8 *DataBufferPtr, unsigned int NumBytes);
	const int count = 14;
	int index = 0;
	while (index < count) {
		data = XIOModule_Send(&iomodule, &msg[index], count - index);
		index += data;
	}
	xil_printf("\n\rThe number of bytes sent was %d\n\r", index);
	// Another way to send individual characters
	outbyte('X');
	outbyte(0x37); // number '7'
	outbyte('Z');
	outbyte('\n'); // line feed
	// Receive a character and store in rx_buf
	// unsigned int XIOModule_Recv(XIOModule *InstancePtr, u8 *DataBufferPtr, unsigned int NumBytes);
	while
		((data = XIOModule_Recv(&iomodule, rx_buf, 1)) == 0);
	xil_printf("The number of bytes received was %d\n\r", data);
	xil_printf("Recv: The received char was %c\n\r", rx_buf[0]);
	// Another way to receive a single character
	rx_buf[0] = inbyte();
	xil_printf("inbyte: The received char was %c\n\r", rx_buf[0]);
	while (1)
	{
		//data = XIOModule_DiscreteRead(&iomodule, 1); // read switches (channel 1)
		data = XIOModule_DiscreteRead(&iomodule, 2); // read push (channel 2)
		XIOModule_DiscreteWrite(&iomodule, 1, data); // turn on LEDs (channel 1)
	}
	cleanup_platform();
	return 0;
}


/*/
//Extra: Accessing the GPIO and xil_printf
#include <stdio.h>
#include "platform.h"
#include "xparameters.h" // add
#include "xiomodule.h" // add
void print(char *str);
int main()
{
	init_platform();
	u32 data;
	XIOModule gpi;
	XIOModule gpo;
	xil_printf("Reading switches and writing to LED port\n\r");
	data = XIOModule_Initialize(&gpi, XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start(&gpi);
	data = XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start(&gpo);
	while (1)
	{
		data = XIOModule_DiscreteRead(&gpi, 1); // read switches (channel 1)
		XIOModule_DiscreteWrite(&gpo, 1, data); // turn on LEDs (channel 1)
	}
	cleanup_platform();
	return 0;
}
/*/
//Basico
#include <stdio.h>
#include "platform.h"

void print(char *str);

int main()
{
    init_platform();

    print("Hello Worldasd\n\r");

    cleanup_platform();

    return 0;
}
//*/