/********************************** (C) COPYRIGHT *******************************
 * File Name          : ch32v20x_it.c
 * Author             : WCH
 * Version            : V1.0.0
 * Date               : 2021/06/06
 * Description        : Main Interrupt Service Routines.
*********************************************************************************
* Copyright (c) 2021 Nanjing Qinheng Microelectronics Co., Ltd.
* Attention: This software (modified or not) and binary are used for 
* microcontroller manufactured by Nanjing Qinheng Microelectronics.
*******************************************************************************/
#include "ch32v20x_it.h"

/*********************************************************************
 * @fn      NMI_Handler
 *
 * @brief   This function handles NMI exception.
 *
 * @return  none
 */
__attribute__((naked)) void NMI_Handler()
{
  __asm volatile ("call NMI_Handler_real; mret");
}
void NMI_Handler_real(void)
{
}

/*********************************************************************
 * @fn      HardFault_Handler
 *
 * @brief   This function handles Hard Fault exception.
 *
 * @return  none
 */
__attribute__((naked)) void HardFault_Handler()
{
  __asm volatile ("call HardFault_Handler_real; mret");
}
void HardFault_Handler_real(void)
{
  while (1)
  {
  }
}


