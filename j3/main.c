#include "stm8s.h"

/* MAIN.C file
 * 
 * Copyright (c) 2002-2005 STMicroelectronics
 */
long cnt;

main()
{

CLK->CKDIVR=0;

	GPIOD->DDR|=(1<<6);
	GPIOD->CR1|=(1<<6);
	GPIOD->CR2&=~(1<<6);
	
	GPIOC->ODR|=(1<<5);
	GPIOC->ODR&=~(1<<5);
	

	while (1)
	{
			GPIOD->ODR^=(1<<);
		//	cnt = 1000L;
		//while(cnt--){};
			
};
	
	
}