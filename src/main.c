/********************************** (C) COPYRIGHT *******************************
* File Name          : main.c
* Author             : WCH, Patrick Van Oosterwijck
* Version            : V1.0.0
* Date               : 2021/06/06
* Description        : Main program body.
*******************************************************************************/
#include "debug.h"

/*******************************************************************************
* Function Name  : main
* Description    : Main program.
* Input          : None
* Return         : None
*******************************************************************************/
int main(void)
{
	Delay_Init();
	USART_Printf_Init(115200);
	printf("CH32V203-makefile-example demo\r\n");
	printf("SystemClk: %d\r\n", SystemCoreClock);
	printf("Connect LED to PB9 to see it blink\r\n");

  GPIO_InitTypeDef GPIO_InitStructure = {0};

  RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);
  GPIO_InitStructure.GPIO_Pin = GPIO_Pin_9;
  GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
  GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
  GPIO_Init(GPIOB, &GPIO_InitStructure);
  GPIO_ResetBits(GPIOB, GPIO_Pin_9);
  while(1)
  {
    GPIO_SetBits(GPIOB, GPIO_Pin_9);
    Delay_Ms(500);
    GPIO_ResetBits(GPIOB, GPIO_Pin_9);
    Delay_Ms(500);
  }
}







