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

#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xiomodule.h"


void print(char *str);

int main()
{
    init_platform();

    u32 data;
    XIOModule gpi;
    XIOModule gpo;

    print("Reading switches and writing to LED port\n\r");

    data = XIOModule_Initialize(&gpi, XPAR_IOMODULE_0_DEVICE_ID);
    data = XIOModule_Start(&gpi);

    data = XIOModule_Initialize(&gpo, XPAR_IOMODULE_0_DEVICE_ID);
    data = XIOModule_Start(&gpo);

    while(1){
    	data = XIOModule_DiscreteRead(&gpi, 1); // read switches (channel 1)
    	XIOModule_DiscreteWrite(&gpo, 1, data); // turn on LEDs (channel 1)
    }

    cleanup_platform();

    return 0;
}
