/*----------------------------------------------------------------------------
 *      RL-ARM - TCPnet
 *----------------------------------------------------------------------------
 *      Name:    HTTP_DEMO.C
 *      Purpose: HTTP Server demo example
 *----------------------------------------------------------------------------
 *      This code is part of the RealView Run-Time Library.
 *      Copyright (c) 2004-2009 KEIL - An ARM Company. All rights reserved.
 *---------------------------------------------------------------------------*/

#include <stdio.h>
#include <RTL.h>
#include <Net_Config.h>
#include <LPC17xx.h>                    /* LPC17xx definitions               */
#include "GLCD.h"

BOOL LEDrun;
BOOL LCDupdate;
BOOL tick;
U32  dhcp_tout;
U8   lcd_text[2][16+1] = {" ",                /* Buffer for LCD text         */
                          "Waiting for DHCP"};

extern LOCALM localm[];                       /* Local Machine Settings      */
#define MY_IP localm[NETIF_ETH].IpAdr
#define DHCP_TOUT   50                        /* DHCP timeout 5 seconds      */

static void init_io (void);
static void init_display (void);

char plazma;

/*--------------------------- init ------------------------------------------*/

static void init () {
  /* Add System initialisation code here */ 

  init_io ();
  //init_display ();
  init_TcpNet ();

  /* Setup and enable the SysTick timer for 100ms. */
  SysTick->LOAD = (SystemFrequency / 10) - 1;
  SysTick->CTRL = 0x05;
}


/*--------------------------- timer_poll ------------------------------------*/


static void timer_poll () {
  /* System tick timer running in poll mode */

  if (SysTick->CTRL & 0x10000) {
    /* Timer tick every 100 ms */
    timer_tick ();
    tick = __TRUE;
  }
}


/*--------------------------- init_io ---------------------------------------*/

static void init_io () {

  /* Set the clocks. */
  SystemInit();

  /* Configure the GPIO for Push Buttons */
//  LPC_PINCON->PINSEL4 &= 0xFFCFFFFF;
//  LPC_GPIO2->FIODIR   &= 0xFFFFFBFF;

  /* Configure GPIO for JOYSTICK */
//  LPC_PINCON->PINSEL3 &= 0xFFC03CFF;
//  LPC_GPIO1->FIODIR   &= 0xF86FFFFF;

  /* Configure the GPIO for LEDs. */
 // LPC_GPIO1->FIODIR   |= 0xB0000000;
 // LPC_GPIO2->FIODIR   |= 0x0000007C;

  /* Configure UART1 for 115200 baud. */
//  LPC_PINCON->PINSEL4 &= 0xFFFFFFF0;
//  LPC_PINCON->PINSEL4 |= 0x0000000A;
//  LPC_UART1->LCR = 0x83;
//  LPC_UART1->DLL = 9;                              /* 115200 Baud Rate @ 25.0 MHZ PCLK */
//  LPC_UART1->FDR = 0x21;                           /* FR 1,507, DIVADDVAL = 1, MULVAL = 2 */
 // LPC_UART1->DLM = 0;
 // LPC_UART1->LCR = 0x03;

  /* Configure AD0.2 input. */
 // LPC_PINCON->PINSEL1 &= 0xFFF3FFFF;
 // LPC_PINCON->PINSEL1 |= 0x00040000;
 // LPC_SC->PCONP       |= 0x00001000;
 // LPC_ADC->ADCR        = 0x00200404;               /* ADC enable, ADC clock 25MHz/5, select AD0.2 pin */
}


/*--------------------------- fputc -----------------------------------------*/

int fputc(int ch, FILE *f)  {
  /* Debug output to serial port. */

  if (ch == '\n')  {
    while (!(LPC_UART1->LSR & 0x20));
    LPC_UART1->THR = 0x0D;
  }
  while (!(LPC_UART1->LSR & 0x20));
  LPC_UART1->THR = (ch & 0xFF);
  return (ch);
}


/*--------------------------- LED_out ---------------------------------------*/

void LED_out (U32 val) {
  const U8 led_pos[8] = { 28, 29, 31, 2, 3, 4, 5, 6 };
  U32 i,mask;

  for (i = 0; i < 8; i++) {
    mask = 1 << led_pos[i];
    if (val & (1<<i)) {
      if (i < 3) LPC_GPIO1->FIOSET = mask;
      else       LPC_GPIO2->FIOSET = mask;
    }
    else {
      if (i < 3) LPC_GPIO1->FIOCLR = mask;
      else       LPC_GPIO2->FIOCLR = mask;
    }
  }
}


/*--------------------------- AD_in -----------------------------------------*/

U16 AD_in (U32 ch) {
  /* Read ARM Analog Input */
  U32 val = 0;
  U32 adcr;

  if (ch < 8) {
    adcr = 0x01000000 | (1 << ch);
    LPC_ADC->ADCR = adcr | 0x00200100;        /* Setup A/D: 10-bit @ 9MHz  */

    do {
      val = LPC_ADC->ADGDR;                   /* Read A/D Data Register    */
    } while ((val & 0x80000000) == 0);        /* Wait for end of A/D Conv. */
    LPC_ADC->ADCR &= ~adcr;                   /* Stop A/D Conversion       */
    val = (val >> 6) & 0x03FF;                /* Extract AINx Value        */
  }
  return (val);
}


/*--------------------------- get_button ------------------------------------*/

U8 get_button (void) {
  /* Read ARM Digital Input */
  U32 val = 0;

  if ((LPC_GPIO2->FIOPIN & (1 << 10)) == 0) {
    /* INT0 button */
    val |= 0x01;
  }
  if ((LPC_GPIO1->FIOPIN & (1 << 23)) == 0) {
    /* Joystick left */
    val |= 0x02;
  }
  if ((LPC_GPIO1->FIOPIN & (1 << 25)) == 0) {
    /* Joystick right */
    val |= 0x04;
  }
  if ((LPC_GPIO1->FIOPIN & (1 << 24)) == 0) {
    /* Joystick up */
    val |= 0x08;
  }
  if ((LPC_GPIO1->FIOPIN & (1 << 26)) == 0) {
    /* Joystick down */
    val |= 0x10;
  }
  if ((LPC_GPIO1->FIOPIN & (1 << 20)) == 0) {
    /* Joystick select */
    val |= 0x20;
  }

  val=plazma;
  return (val);
}


/*--------------------------- upd_display -----------------------------------*/

static void upd_display () {
  /* Update GLCD Module display text. */

  GLCD_ClearLn (5, 1);
  GLCD_DisplayString (5, 0, 1, lcd_text[0]);
  GLCD_ClearLn (6, 1);
  GLCD_DisplayString (6, 0, 1, lcd_text[1]);

  LCDupdate =__FALSE;
}


/*--------------------------- init_display ----------------------------------*/

static void init_display () {
  /* LCD Module init */

  GLCD_Init ();
  GLCD_Clear (White);
  GLCD_SetTextColor (Blue);
  GLCD_DisplayString (1, 4, 1, "   RL-ARM");
  GLCD_DisplayString (2, 4, 1, "HTTP example");
}


/*--------------------------- dhcp_check ------------------------------------*/

static void dhcp_check () {
  /* Monitor DHCP IP address assignment. */

  if (tick == __FALSE || dhcp_tout == 0) {
    return;
  }
  if (mem_test (&MY_IP, 0, IP_ADRLEN) == __FALSE && !(dhcp_tout & 0x80000000)) {
    /* Success, DHCP has already got the IP address. */
    dhcp_tout = 0;
    sprintf((char *)lcd_text[0]," IP address:");
    sprintf((char *)lcd_text[1]," %d.%d.%d.%d", MY_IP[0], MY_IP[1],
                                                MY_IP[2], MY_IP[3]);
    LCDupdate = __TRUE;
    return;
  }
  if (--dhcp_tout == 0) {
    /* A timeout, disable DHCP and use static IP address. */
    dhcp_disable ();
    sprintf((char *)lcd_text[1]," DHCP failed    " );
    LCDupdate = __TRUE;
    dhcp_tout = 30 | 0x80000000;
    return;
  }
  if (dhcp_tout == 0x80000000) {
    dhcp_tout = 0;
    sprintf((char *)lcd_text[0]," IP address:");
    sprintf((char *)lcd_text[1]," %d.%d.%d.%d", MY_IP[0], MY_IP[1],
                                                MY_IP[2], MY_IP[3]);
    LCDupdate = __TRUE;
  }
}


/*--------------------------- blink_led -------------------------------------*/


static void blink_led () {
  /* Blink the LEDs on an eval board */
  const U8 led_val[16] = { 0x48,0x88,0x84,0x44,0x42,0x22,0x21,0x11,
                           0x12,0x0A,0x0C,0x14,0x18,0x28,0x30,0x50 };
  static U32 cnt;

  if (tick == __TRUE) {
    /* Every 100 ms */
    //tick = __FALSE;
    if (LEDrun == __TRUE) {
      LED_out (led_val[cnt]);
      if (++cnt >= sizeof(led_val)) {
        cnt = 0;
      }
    }
    if (LCDupdate == __TRUE) {
      upd_display ();
    }
  }
}

/*---------------------------------------------------------------------------*/


int main (void) {
  /* Main Thread of the TcpNet */

  init ();
  LEDrun = __TRUE;
  dhcp_tout = DHCP_TOUT;
  while (1) {
    timer_poll ();
    main_TcpNet ();
    //dhcp_check ();
    blink_led ();
    if (tick == __TRUE) plazma++;
    if (tick == __TRUE) tick = __FALSE;
  }
}


/*----------------------------------------------------------------------------
 * end of file
 *---------------------------------------------------------------------------*/
