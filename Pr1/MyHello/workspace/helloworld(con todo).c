#include <stdio.h>
#include "platform.h"
#include "xparameters.h"
#include "xiomodule.h"

#define DIR_LEDS						(*(volatile u32 *) 0xC0000000)
#define DIR_SWITCHES					(*(volatile u32 *) 0xC0000004)
#define DIR_FIFO_LECTURA_DATO			(*(volatile u32 *) 0xC0000008)
#define DIR_FIFO_LECTURA_NUM_ELEM		(*(volatile u32 *) 0xC000000C)
#define DIR_FIFO_ESCRITURA_DATO			(*(volatile u32 *) 0xC0000010)
#define DIR_FIFO_ESCRITURA_NUM_ELEM  	(*(volatile u32 *) 0xC0000014)

int main()
{
	init_platform();
	u32 data;
	unsigned int libres;
	unsigned int ocupadas;
	unsigned int i;

	XIOModule iomodule;
	data = XIOModule_Initialize(&iomodule, XPAR_IOMODULE_0_DEVICE_ID);
	data = XIOModule_Start(&iomodule);

	DIR_FIFO_ESCRITURA_DATO = (u32) 'H';
	DIR_FIFO_ESCRITURA_DATO = (u32) 'O';
	DIR_FIFO_ESCRITURA_DATO = (u32) 'L';
	DIR_FIFO_ESCRITURA_DATO = (u32) 'A';
	DIR_FIFO_ESCRITURA_DATO = (u32) '\n';


	while (1) {
		data = DIR_FIFO_LECTURA_NUM_ELEM;
		ocupadas = (unsigned int) data;

		data = DIR_FIFO_ESCRITURA_NUM_ELEM;
		libres = (unsigned int) data;

		while(libres < ocupadas){}

		for (i=0; i < ocupadas; i++){
			data = DIR_FIFO_LECTURA_DATO;
			DIR_FIFO_ESCRITURA_DATO = data;
		}

		data = DIR_SWITCHES;
		DIR_LEDS = data;
	}

	cleanup_platform();
	return 0;
}
