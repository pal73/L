#include "main.h"

void main_loop(void)
{
HAL_GPIO_TogglePin(GPIOC, GPIO_PIN_13); /* USER CODE END WHILE */
HAL_Delay(10);
}

