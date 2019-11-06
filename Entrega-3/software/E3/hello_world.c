#include <stdio.h>
#include "system.h"
#include <alt_types.h>
#include <io.h> /* Leiutura e escrita no Avalon */

//#define SIM

// LED Peripheral
//#define REG_DATA_OFFSET 1

#define success_read_peripheral 0xA5A5AA55

/// Header
/*
int PS2_init(volatile unsigned int base);
int PS2_halt(volatile unsigned int base);
int PS2_read_clickLeft(volatile unsigned int base);
int PS2_read_clickRight(volatile unsigned int base);
int PS2_read_clickMid(volatile unsigned int base);
int PS2_read_x(volatile unsigned int base);
int PS2_read_y(volatile unsigned int base);
*/

int PS2_init(volatile unsigned int *p_ps2){
	if(*(p_ps2+2) != success_read_peripheral)
		return 0;

	*(p_ps2+1) = 0x1;
	return 1;
}

int PS2_halt(volatile unsigned int *p_ps2){
	*(p_ps2) = 0x0;
	return 1;
}

unsigned int PS2_read_clickLeft(unsigned int *p_ps2){
	return (*(p_ps2) & 1);
}

int PS2_read_clickRight(unsigned int *p_ps2){
	return *(p_ps2) & 2;
}

int PS2_read_clickMid(unsigned int *p_ps2){
	return *(p_ps2) & 4;
}

int PS2_read_x(unsigned int *p_ps2){
	return *(p_ps2) & (0x00000FF0);
}

int PS2_read_y(unsigned int *p_ps2){
	return *(p_ps2) & (0x000FF000);
}

int main(void){
  //unsigned int led = 0;
  //volatile unsigned int *p_led = (unsigned int *) PERIPHERAL_LED_0_BASE;
  volatile unsigned int *p_ps2 = (unsigned int *) PS2_0_BASE;

  #ifndef SIM
  	  printf("Embarcados++ \n");
  #endif

  if(!PS2_init(p_ps2))
  	  return 0;

  while(1){
	  //blink led
      //if (led < 4){
      //    *(p_led+REG_DATA_OFFSET) = (0x1 << led++);

      //read controller

	  printf("LEFT: %d, RIGHT: %d, MID: %d, oX: %d, oY: %d\n",
    		  PS2_read_clickLeft(p_ps2), PS2_read_clickRight(p_ps2), PS2_read_clickMid(p_ps2),
			  PS2_read_x(p_ps2), PS2_read_y(p_ps2));

	  #ifndef SIM
          usleep(500000); // remover durante a simulação
	  #endif
      }

  PS2_halt(p_ps2);
  return 0;
};
