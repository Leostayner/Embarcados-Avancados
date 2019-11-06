#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

#include <unistd.h>
#include "altera_avalon_pio_regs.h"
#include "sys/alt_irq.h"

int n = 0;
volatile int edge_capture;
void init_pio();

int main(void){
  unsigned int led = 0;
  n = 0;

  init_pio();

  printf("Embarcados++ \n");
  volatile int in,  out;
  volatile int cd = 20000;

  while(1){
	  //IOWR_ALTERA_AVALON_PIO_DATA(PIO_1_BASE, n);
	  in = IORD_ALTERA_AVALON_PIO_DATA(PIO_1_BASE);
	  out = in;
	  IOWR_ALTERA_AVALON_PIO_DATA(PIO_1_BASE, out);

	  if(out == 7)  cd = 20000;
	  else if(out == 11) cd = 50000;
	  else if(out == 13) cd = 220000;
	  else if(out == 14) cd = 320000;

	  if (led <= 5){
		  IOWR_32DIRECT(PIO_0_BASE, 0, 0x01 << led++);
		  usleep(cd);
	  }

	  else
		  led = 0;

  };

  return 0;
}


void handle_button_interrupts(void *context , alt_u32 id){
	volatile int* edge_capture_ptr = (volatile int*) context;
	*edge_capture_ptr = IORD_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE);
	n++;
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0);

}

void init_pio(){
	void* edge_capture_ptr = (void*) &edge_capture;
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(PIO_1_BASE, 0xf);
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(PIO_1_BASE, 0x0);
	alt_irq_register( PIO_1_IRQ, edge_capture_ptr, handle_button_interrupts );
}
