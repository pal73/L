#define TX_BUFFER_SIZE0 24
char tx_buffer0[TX_BUFFER_SIZE0];
unsigned char tx_wr_index0,tx_rd_index0,tx_counter0; 

#define RXB8 1
#define TXB8 0
#define UPE 2
#define OVR 3
#define FE 4
#define UDRE 5
#define RXC 7
#define vlt_adress 2
#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
#define modbus_baud	2400
#define modbus_simbol_time   10000/modbus_baud

// USART0 Receiver buffer
#define RX_BUFFER_SIZE0 32
char rx_buffer0[RX_BUFFER_SIZE0];
unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
// This flag is set on USART0 Receiver buffer overflow
bit rx_buffer_overflow0;

char cnt_of_not_recieve;			
char UIB0_CNT;					//���������� ���� � �������� �������
char UIB0[50];					//����� �����
bit bModbus_in;				//������� �������
bit bMODBUS_FREE=1;                //������ �� ������� ������ �� VLT
char modbus_out_buffer[10,20],modbus_in_buffer[20];
char modbus_out_len[10],modbus_in_len;
char modbus_out_ptr_rd,modbus_out_ptr_rd_old,modbus_out_ptr_wr;
//extern void usart_out_adr0 (char *ptr, char len);
unsigned cnt_of_end_recieve;		//����������� ������� ����������� ����� ������ ���������� �������
unsigned cnt_of_end_transmission;	//����������� ������� ����������� ����� �������� ���������� �������
char repeat_transmission_cnt;
extern unsigned plazma_plazma;  
unsigned fp_error_code;
//-----------------------------------------------
void modbus_in_an(void)
{
unsigned temp_U;
unsigned long temp_UL;
char i;
//modbus_cnt++;
temp_U=crc16(modbus_in_buffer,modbus_in_len-2);

if((modbus_in_buffer[modbus_in_len-1]==*((char*)&temp_U))
 &&(modbus_in_buffer[modbus_in_len-2]==*(((char*)&temp_U)+1))
 &&(modbus_in_buffer[0]==vlt_adress))
	{
	modbus_cnt++;
	bMODBUS_FREE=1;
	repeat_transmission_cnt=0;
	cnt_of_end_transmission=0;
	modbus_out_ptr_rd_old=modbus_out_ptr_rd;
	modbus_out_ptr_rd++;
	if(modbus_out_ptr_rd>=10)modbus_out_ptr_rd=0;

	if(modbus_out_buffer[modbus_out_ptr_rd,0]==0x01)
		{
		temp_U=0;
		for(i=2;i<6;i++)
			{
			if(modbus_out_buffer[modbus_out_ptr_rd,i]!=modbus_in_buffer[i])temp_U=1;
			}
		if(temp_U==0)
			{
			

			}
		}
			
//������ ���������
	if((modbus_out_buffer[modbus_out_ptr_rd_old,1]==0x03)&&(modbus_in_buffer[1]==0x03))
		{
		
		if((modbus_in_buffer[2]==0x04)&&
		   (modbus_out_buffer[modbus_out_ptr_rd_old,4]==0x00)&&
		   (modbus_out_buffer[modbus_out_ptr_rd_old,5]==0x02))
		   	{
		   	if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x07)&&  ////204 ��������
		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0xF7))
		  		{
		  		temp_UL=0UL;
			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
				temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
				temp_UL+=(unsigned long)modbus_in_buffer[4];
		    		temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
				temp_UL<<=8;
		    		temp_UL&=0xffffff00UL;  
			
				temp_UL+=(unsigned long)modbus_in_buffer[6];
               
				temp_UL/=1000UL;
			
				__fp_fmin=(unsigned int)temp_UL;
				}
			else if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x08)&&  ////205 ��������
		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x01))
		  		{
		  		temp_UL=0UL;
			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
				temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
				temp_UL+=(unsigned long)modbus_in_buffer[4];
		    		temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
				temp_UL<<=8;
		    		temp_UL&=0xffffff00UL;  
			
				temp_UL+=(unsigned long)modbus_in_buffer[6];
               
				temp_UL/=1000UL;
			
				__fp_fmax=(unsigned int)temp_UL;
				}

			else if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x14)&&  ////520 ��������
		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x4f))
		  		{
		  		temp_UL=0UL;
			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
				temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
				temp_UL+=(unsigned long)modbus_in_buffer[4];
		    		temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
				temp_UL<<=8;
		    		temp_UL&=0xffffff00UL;  
			
				temp_UL+=(unsigned long)modbus_in_buffer[6];
               
				temp_UL/=10UL;
			
				//fp_fmax=(unsigned int)temp_UL;
			    	if(fp_stat==dvON)
			    		{
			    		Id[pilot_dv]=(unsigned int)temp_UL;
			    		Ida[pilot_dv]=(unsigned int)temp_UL;
			    		Idc[pilot_dv]=(unsigned int)temp_UL;
			    		}
			    	
			    	plazma_plazma=(unsigned int)temp_UL;
				}

			else if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x15)&&  ////538 ��������
		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x03))
		  		{
		  		temp_UL=0UL;
			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
				temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
				temp_UL+=(unsigned long)modbus_in_buffer[4];
		    		temp_UL<<=8;
				temp_UL&=0xffffff00UL;
			
		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
				temp_UL<<=8;
		    		temp_UL&=0xffffff00UL;  
			
				temp_UL+=(unsigned long)modbus_in_buffer[6];
               
				fp_error_code=temp_UL;
			
				}				
			}
		if((modbus_in_buffer[2]==0x02)&&
		   (modbus_out_buffer[modbus_out_ptr_rd_old,4]==0x00)&&
		   (modbus_out_buffer[modbus_out_ptr_rd_old,5]==0x01))
		   	{plazma++;
		   	if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x14)&&  ////518 ��������,�������
		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x3b))
		  		{
			 	temp_UL=0UL;
				temp_UL+=modbus_in_buffer[3];
				temp_UL<<=8;
				temp_UL&=0xffffff00;
			
				temp_UL+=modbus_in_buffer[4];
			
				__fp_fcurr=(unsigned int)temp_UL;
				}
		   	}			
		}	
	
	
	
	
				
	if(modbus_out_buffer[modbus_out_ptr_rd,0]==0x06)
		{
		temp_U=0;
		for(i=2;i<6;i++)
			{
			if(modbus_out_buffer[modbus_out_ptr_rd,i]!=modbus_in_buffer[i])temp_U=1;
			}
		if(temp_U==0)
			{
			

			}
		}
	}
}

//----------------------------------------------
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
	UDR0=c;
	bMODBUS_FREE=0;
	}
#asm("sei")
}

//----------------------------------------------
void read_vlt_coil(unsigned coil_adress)
{ 
unsigned int temp_U;
temp_U=coil_adress-1;
modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
modbus_out_buffer[modbus_out_ptr_wr,1]=0x01;
modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
modbus_out_buffer[modbus_out_ptr_wr,5]=0x20;
temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],6);
modbus_out_buffer[modbus_out_ptr_wr,6]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&temp_U);
modbus_out_len[modbus_out_ptr_wr]=8;
modbus_out_ptr_wr++;
if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
}   

//----------------------------------------------
void write_vlt_coil(unsigned coil_adress,unsigned data1,unsigned data2)
{ 
unsigned int temp_U;
temp_U=coil_adress-1;
modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
modbus_out_buffer[modbus_out_ptr_wr,1]=0x0f;
modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
modbus_out_buffer[modbus_out_ptr_wr,5]=0x20;
modbus_out_buffer[modbus_out_ptr_wr,6]=0x04;
modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&data1);
modbus_out_buffer[modbus_out_ptr_wr,8]=*(((char*)(&data1))+1);
modbus_out_buffer[modbus_out_ptr_wr,9]=*((char*)&data2);
modbus_out_buffer[modbus_out_ptr_wr,10]=*(((char*)(&data2))+1);
temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],11);
modbus_out_buffer[modbus_out_ptr_wr,11]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,12]=*((char*)&temp_U);
modbus_out_len[modbus_out_ptr_wr]=13;
modbus_out_ptr_wr++;
if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
}



//----------------------------------------------
void write_vlt_register(unsigned reg_adress,unsigned data)
{ 
unsigned int temp_U;
temp_U=(reg_adress*10)-1;
modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
modbus_out_buffer[modbus_out_ptr_wr,1]=0x06;
modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
modbus_out_buffer[modbus_out_ptr_wr,4]=*(((char*)(&data))+1);
modbus_out_buffer[modbus_out_ptr_wr,5]=*((char*)&data);
temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],6);
modbus_out_buffer[modbus_out_ptr_wr,6]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&temp_U);
modbus_out_len[modbus_out_ptr_wr]=8;
modbus_out_ptr_wr++;
if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
}

//----------------------------------------------
void write_vlt_registers(unsigned reg_adress,unsigned long data)
{ 
unsigned int temp_U;
temp_U=(reg_adress*10)-1;
modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
modbus_out_buffer[modbus_out_ptr_wr,1]=0x10;
modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
modbus_out_buffer[modbus_out_ptr_wr,5]=0x02;
modbus_out_buffer[modbus_out_ptr_wr,6]=0x04;
modbus_out_buffer[modbus_out_ptr_wr,7]=*(((char*)(&data))+3);
modbus_out_buffer[modbus_out_ptr_wr,8]=*(((char*)(&data))+2);
modbus_out_buffer[modbus_out_ptr_wr,9]=*(((char*)(&data))+1);
modbus_out_buffer[modbus_out_ptr_wr,10]=*((char*)&data);
temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],11);
modbus_out_buffer[modbus_out_ptr_wr,11]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,12]=*((char*)&temp_U);
modbus_out_len[modbus_out_ptr_wr]=13;
modbus_out_ptr_wr++;
if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
}

//----------------------------------------------
void read_vlt_register(unsigned reg_adress,char numbers)
{ 
unsigned int temp_U;
temp_U=(reg_adress*10)-1;
modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
modbus_out_buffer[modbus_out_ptr_wr,1]=0x03;
modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
modbus_out_buffer[modbus_out_ptr_wr,5]=numbers;
temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],6);
modbus_out_buffer[modbus_out_ptr_wr,6]=*(((char*)(&temp_U))+1);
modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&temp_U);
modbus_out_len[modbus_out_ptr_wr]=8;
modbus_out_ptr_wr++;
if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
}


//-----------------------------------------------
void modbus_out (char *ptr, char len)
{

char i,t=0;

for (i=0;i<len;i++)
	{
	putchar0(ptr[i]);
	}  
}

//----------------------------------------------
//������������ ���������� ������������ modbus,
//���������� 1 ��� � ������������
void modbus_drv(void)
{

if(cnt_of_end_recieve)
	{
	cnt_of_end_recieve--;
	if(cnt_of_end_recieve==0)
		{
		char i;
		for(i=0;i<rx_wr_index0;i++)
			{
			modbus_in_buffer[i]=rx_buffer0[i];
			modbus_in_len=rx_wr_index0;
			}
		rx_counter0=0;
		rx_wr_index0=0;
		modbus_in_an();			
	   //	_485_rx_en_dd_=1;
	   //	_485_rx_en_=0;
		}
	}

if(!bMODBUS_FREE)
	{
	if(cnt_of_end_transmission)
		{
		cnt_of_end_transmission--;
		if(!cnt_of_end_transmission)
			{
			if(repeat_transmission_cnt<10)
				{
				modbus_out(&modbus_out_buffer[modbus_out_ptr_rd,0],modbus_out_len[modbus_out_ptr_rd]);
				repeat_transmission_cnt++;
				}
			else 
				{
				bMODBUS_FREE=1;
				modbus_out_ptr_rd++;
				if(modbus_out_ptr_rd>=10)modbus_out_ptr_rd=0;
				}
			}
		}
	}  

/*if(cnt_of_not_recieve<50)
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
	}*/
if((modbus_out_ptr_wr!=modbus_out_ptr_rd)&&(bMODBUS_FREE))
	{
	modbus_out(&modbus_out_buffer[modbus_out_ptr_rd,0],modbus_out_len[modbus_out_ptr_rd]);
	repeat_transmission_cnt=0;

	}    
}



//----------------------------------------------
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
   cnt_of_end_recieve=(modbus_simbol_time*3)+1;
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


//----------------------------------------------
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
	cnt_of_end_transmission=150;	
	}   	
}






