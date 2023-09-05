#define RXB8 1
#define TXB8 0
#define UPE 2
#define OVR 3
#define FE 4
#define UDRE 5
#define RXC 7

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)

// USART0 Receiver buffer
#define RX_BUFFER_SIZE0 32
char rx_buffer0[RX_BUFFER_SIZE0];
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
// This flag is set on USART0 Receiver buffer overflow
bit rx_buffer_overflow0;

char cnt_of_not_recieve;			//счетчик миллисикунд после приема последнего символа
char UIB0_CNT;					//количество байт в принятой посылке
char UIB0[50];					//буфер приёма
bit bModbus_in;				//принята посылка
//----------------------------------------------
//Подпрограмма временнОго обслуживания 485,
//вызывается 1 раз в миллисикунду
void _485_drv(void)
{
if(cnt_of_not_recieve<50)
	{
	cnt_of_not_recieve++;
	if(cnt_of_not_recieve==16)
		{
		char i;
		for(i=0;i<rx_wr_index0;i++)
			{
			UIB0[i]=rx_buffer0[i];
			UIB0_CNT=rx_wr_index0;
			}
		rx_counter0=0;
		rx_wr_index0=0;
		bModbus_in=1;			
		_485_rx_en_dd_=1;
		_485_rx_en_=0;
			
		}
	}
}




// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;
if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
   rx_buffer0[rx_wr_index0]=data;
   if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=RX_BUFFER_SIZE0;
   if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
      rx_counter0=0;
      rx_buffer_overflow0=1;
      };
   cnt_of_not_recieve=0;
   };
}

#ifndef _DEBUG_TERMINAL_IO_
// Get a character from the USART0 Receiver buffer
#define _ALTERNATE_GETCHAR_
#pragma used+
char getchar(void)
{
char data;
while (rx_counter0==0);
data=rx_buffer0[rx_rd_index0];
if (++rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
#asm("cli")
--rx_counter0;
#asm("sei")
return data;
}
#pragma used-
#endif

// USART0 Transmitter buffer
#define TX_BUFFER_SIZE0 24
char tx_buffer0[TX_BUFFER_SIZE0];
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0;

// USART0 Transmitter interrupt service routine
interrupt [USART0_TXC] void usart0_tx_isr(void)
{
if (tx_counter0)
   	{
	_485_tx_en_dd_=1;
	_485_tx_en_=1; 
	_485_rx_en_dd_=1;
	_485_rx_en_=1;  
   	--tx_counter0;
   	UDR0=tx_buffer0[tx_rd_index0];
   	if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
   	}
else 
	{
	_485_tx_en_dd_=1;
	_485_tx_en_=0;	 
	_485_rx_en_dd_=1;
	_485_rx_en_=0;	
	}   	
}

#ifndef _DEBUG_TERMINAL_IO_
// Write a character to the USART0 Transmitter buffer
#define _ALTERNATE_PUTCHAR_
#pragma used+
void putchar0(char c)
{
while (tx_counter0 == TX_BUFFER_SIZE0);
#asm("cli")
if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
   {
   tx_buffer0[tx_wr_index0]=c;
   if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
   ++tx_counter0;
   }
else
	{
	_485_tx_en_dd_=1;
	_485_tx_en_=1;
	_485_rx_en_dd_=1;
	_485_rx_en_=1;  	
	//delay_ms(2);
	UDR0=c;
	}
#asm("sei")
}
#pragma used-
#endif




