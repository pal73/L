#define FIFO_CAN_IN_LEN	10
#define FIFO_CAN_OUT_LEN	10
#define adres	0

#define CS_DDR	DDRB.0
#define CS	PORTB.0 
#define SPI_PORT_INIT  DDRB.5=1;DDRB.3=1;DDRB.4=0;DDRB.0=1;DDRB.2=1;SPCR=0x50;SPSR=0x01;

#define CNF1_INIT	0b00000001  //tq=500ns   //8MHz
//#define CNF2_INIT	0b10110001  //Ps1=7tq,Pr=2tq 
//#define CNF3_INIT	0b00000101  //Ps2=6tq

#define CNF2_INIT	0b11111100  //Ps1=8tq,Pr=5tq 
#define CNF3_INIT	0b00000001  //Ps2=2tq

#define RELE1	0
#define RELE2	1


#include <mega8.h>

char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;
bit b100Hz,b10Hz,b5Hz,b2Hz,b1Hz,b_mcp;

char data_out[30];
char plazma,plazma1;
char adc_cnt_main;
unsigned self_max,self_min;
char adc_ch;
flash char ADMUX_CONST[7]={0xC2,0xC3,0xC4,0xC5,0x46,0xC2,0xC2};
char adc_buff_zero_curr_cnt[4];
unsigned adc_buff_zero_curr[4,4];
unsigned adc_buff_zero_curr_[4];
//char self_cnt_zero_for;
char self_cnt_zero_after;
char self_cnt_not_zero;
unsigned curr_buff;
unsigned curr_ch_buff[4,16];
unsigned curr_ch_buff_[4];
char adc_cnt_main1[4];
char self_cnt;
unsigned adc_buff[8,16]; 
unsigned adc_buff_[8];
char adc_ch_cnt;
char flags[2];
//flash char adres=0;
flash char PTR_IN_TEMPER[2]={5,3};
flash char PTR_IN_VL[2]={7,0};
flash char PTR_IN_UPP[4]={5,7,3,0};
signed char cnt_avtHH[2],cnt_avtKZ[2],cnt_avtON[2],cnt_avtOFF[2],cnt_avvHH[2],cnt_avvKZ[2],cnt_avvON[2],cnt_avvOFF[2];
//signed char cnt_av_upp[2];
enum {avvON=0x55,avvOFF=0xaa,avvKZ=0x69,avvHH=0x66} av_vl[2];
enum {avtON=0x55,avtOFF=0xaa,avtKZ=0x69,avtHH=0x66} av_temper[2];

bit bon0,bon1;



//***********************************************
//Работа с логическими входами (сервис и УПП)
signed char log_in_cnt;
signed char upp_cnt[4];
signed char serv_cnt[4];
enum {avuON=0x55,avuOFF=0xAA}av_upp[4];
enum {avsON=0x55,avsOFF=0xAA}av_serv[4];


enum {dvOFF=0x81,dvSTAR=0x42,dvTRIAN=0x24,dvFR=0x66,dvFULL=0x99} dv_on[4]={dvOFF,dvOFF,dvOFF,dvOFF},dv_on_old[4]={dvOFF,dvOFF,dvOFF,dvOFF},dv_stat[4]={dvOFF,dvOFF,dvOFF,dvOFF};
char dv_cnt[4];

unsigned plazma_int[4];
signed main_cnt;
char out_word;

char out_stat[4]; //побитовое состояние реле для двух моторов


#include "mcp2510.h"
#include "mcp_can.c"   
char can_st,can_st1;
char ptr_tx_wr,ptr_tx_rd;
char fifo_can_in[FIFO_CAN_IN_LEN,13];
char ptr_rx_wr,ptr_rx_rd;
char rx_counter;
char fifo_can_out[FIFO_CAN_OUT_LEN,13];

char tx_counter;
char rts_delay;
bit bMCP_DRV;
//-----------------------------------------------
void mcp_drv(void)
{
char j; 
char data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12;
char ptr,*ptr_;
if(bMCP_DRV) goto mcp_drv_end;		
bMCP_DRV=1;
//		DDRA.1=1;
//		PORTA.1=!PORTA.1;
if(rts_delay)rts_delay--;
can_st=spi_read_status();
//plazma=can_st;
if(can_st&0b10101000)
	{
   	spi_bit_modify(CANINTF,0b00011100,0x00);
	}  
	
if(can_st&0b00000001)
	{
     spi_bit_modify(CANINTF,0b00000011,0x00);
	
	if(rx_counter<FIFO_CAN_IN_LEN)
		{
		//plazma++;
		rx_counter++;
		ptr_=&fifo_can_in[ptr_rx_wr,0];
		for(j=0;j<13;j++)
	    		{
	    		*ptr_++=spi_read(RXB0SIDH+j);
			}
		ptr_=&fifo_can_in[ptr_rx_wr,0];
		
		j=ptr_[4];
		ptr_[4]=ptr_[3];
		ptr_[3]=ptr_[2];
    		ptr_[2]=j;
    		
    	 	ptr_rx_wr++;
		if(ptr_rx_wr>=FIFO_CAN_IN_LEN)ptr_rx_wr=0; 	 			 
		}
	}  
else if((!(can_st&0b01010100))&&(!rts_delay))
	{
	if(tx_counter)
		{
		#asm("cli")
		ptr_=&(fifo_can_out[ptr_tx_rd,0]);

 
		
	    	data0=*ptr_++;
		data1=*ptr_++;
		data2=*ptr_++;
		data3=*ptr_++;
		data4=*ptr_++;
		data5=*ptr_++;
		data6=*ptr_++;
		data7=*ptr_++;
		data8=*ptr_++;
		data9=*ptr_++;
		data10=*ptr_++;
		data11=*ptr_++;
		data12=*ptr_++; 
		

				 
          ptr_=&(fifo_can_out[ptr_tx_rd,0]);
		tx_counter--;
		ptr_tx_rd++;
		if(ptr_tx_rd>=FIFO_CAN_OUT_LEN) 
			
			{
			ptr_tx_rd=0;
			}
          #asm("sei")
          
        	spi_write(TXB0SIDH,data0);
  		spi_write(TXB0SIDL,data1);
  		spi_write(TXB0DLC,data2&0b10111111);
   	     spi_write(TXB0EID8,data3);
    	     spi_write(TXB0EID0,data4);
  		spi_write(TXB0D0,data5);
		spi_write(TXB0D1,data6);
		spi_write(TXB0D2,data7);
		spi_write(TXB0D3,data8);
		spi_write(TXB0D4,data9);
		spi_write(TXB0D5,data10);
		spi_write(TXB0D6,data11);
		spi_write(TXB0D7,data12);
																		
		spi_rts(0);
          
          rts_delay=5;
		}     
	}  
//		DDRA.1=1;
//		PORTA.1=!PORTA.1; 
            
bMCP_DRV=0;		
mcp_drv_end:		
}

//-----------------------------------------------
void can_out_adr_len(char adr0,char adr1,char* data_ptr,char len)
{
char ptr,*ptr_;
ptr=ptr_tx_wr;

if(tx_counter<FIFO_CAN_OUT_LEN)
	
	{
	tx_counter++; 
	
	ptr_tx_wr++;
	if(ptr_tx_wr>=FIFO_CAN_OUT_LEN) ptr_tx_wr=0;

	ptr_=&fifo_can_out[ptr,0];
	
	*ptr_++=adr0;
	*ptr_++=adr1|0b00001000;
	if(len>2)*ptr_++=len-2;
	else *ptr_++=0;
	*ptr_++=data_ptr[0];
	*ptr_++=data_ptr[1];
	*ptr_++=data_ptr[2];
	*ptr_++=data_ptr[3];
	*ptr_++=data_ptr[4];
	*ptr_++=data_ptr[5];
	*ptr_++=data_ptr[6];
	*ptr_++=data_ptr[7];
	*ptr_++=data_ptr[8];
	*ptr_++=data_ptr[9];
	} 


} 

//-----------------------------------------------
void can_out_adr(char adr0,char adr1,char* data_ptr)
{
char ptr,*ptr_;
ptr=ptr_tx_wr;
#asm("cli")
if(tx_counter<FIFO_CAN_OUT_LEN)
	
	{
	tx_counter++; 
	
	ptr_tx_wr++;
	if(ptr_tx_wr>=FIFO_CAN_OUT_LEN) ptr_tx_wr=0;

	ptr_=&fifo_can_out[ptr,0];
	
	*ptr_++=adr0;
	*ptr_++=adr1|0b00001000;
	*ptr_++=8;
	*ptr_++=data_ptr[0];
	*ptr_++=data_ptr[1];
	*ptr_++=data_ptr[2];
	*ptr_++=data_ptr[3];
	*ptr_++=data_ptr[4];
	
	*ptr_++=data_ptr[5];
	*ptr_++=data_ptr[6];
	*ptr_++=data_ptr[7];
	*ptr_++=data_ptr[8];
	*ptr_++=data_ptr[9];
	
    //	*ptr_++=0x46;//data_ptr[5];
    //	*ptr_++=/*0x47;//*/data_ptr[6];
    //	*ptr_++=/*0x48;//*/data_ptr[7];
   //	*ptr_++=/*0x49;//*/data_ptr[8];
   //	*ptr_++=0x4a;//data_ptr[9];	
	}
#asm("sei")	 
/*fifo_can_out[ptr,0]=adr0;	
fifo_can_out[ptr,1]=adr1|0b00001000;
fifo_can_out[ptr,2]=8;
fifo_can_out[ptr,3]=data_ptr[0];
fifo_can_out[ptr,4]=data_ptr[1];
fifo_can_out[ptr,5]=data_ptr[2];
fifo_can_out[ptr,6]=data_ptr[3];
fifo_can_out[ptr,7]=data_ptr[4];
fifo_can_out[ptr,8]=data_ptr[5];
fifo_can_out[ptr,9]=data_ptr[6];
fifo_can_out[ptr,10]=data_ptr[7];
fifo_can_out[ptr,11]=data_ptr[8];
fifo_can_out[ptr,12]=data_ptr[9];



             
tx_counter++; */

//DDRA.0=1;
//PORTA.0=!PORTA.0;
}                 

//-----------------------------------------------
void gran_ring_char(signed char *adr, signed char min, signed char max)
{
if (*adr<min) *adr=max;
if (*adr>max) *adr=min; 
} 
 
//-----------------------------------------------
void gran_char(signed char *adr, signed char min, signed char max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void gran(signed int *adr, signed int min, signed int max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void gran_ring(signed int *adr, signed int min, signed int max)
{
if (*adr<min) *adr=max;
if (*adr>max) *adr=min; 
} 

//-----------------------------------------------
void granee_ee(eeprom signed int *adr, signed int min, eeprom signed int* adr_max)
{
if (*adr<min) *adr=min;
if (*adr>*adr_max) *adr=*adr_max; 
} 

//-----------------------------------------------
void granee(eeprom signed int *adr, signed int min, signed int max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void gran_ring_ee(eeprom signed int *adr, signed int min, signed int max)
{
if (*adr<min) *adr=min;
if (*adr>max) *adr=max; 
} 

//-----------------------------------------------
void can_init(void)
{
char spi_temp;
mcp_reset();
spi_temp=spi_read(CANSTAT);
if((spi_temp&0xe0)!=0x80)
	{
	spi_bit_modify(CANCTRL,0xe0,0x80);
	}
delay_us(10);	
spi_write(CNF1,CNF1_INIT);
spi_write(CNF2,CNF2_INIT);
spi_write(CNF3,CNF3_INIT);

spi_write(RXB0CTRL,0b01000000);	// Расширенный идентификатор
spi_write(RXB1CTRL,0b01000000);	// Расширенный идентификатор

spi_write(RXM0SIDH, 0xf8); 
spi_write(RXM0SIDL, 0xe3); 
spi_write(RXM0EID8, 0x00); 
spi_write(RXM0EID0, 0x00); 


spi_write(RXF0SIDH, 0b00000000+((adres<<5)&0xe0)); 
spi_write(RXF0SIDL, 0b00001000);
spi_write(RXF0EID8, 0x00000000); 
spi_write(RXF0EID0, 0b00000000);


spi_write(RXM1SIDH, 0xff); 
spi_write(RXM1SIDL, 0xff); 
spi_write(RXM1EID8, 0xff); 
spi_write(RXM1EID0, 0xff);

delay_ms(10);



spi_bit_modify(CANCTRL,0xe7,0b00000110);

spi_write(CANINTE,0b00011111);
delay_ms(100);
spi_write(BFPCTRL,0b00000000);  

}             

//-----------------------------------------------
void transmit_hndl(void)
{
data_out[0]=flags[0];    
data_out[1]=flags[1];
data_out[2]=*((char*)&curr_ch_buff_[0]);
data_out[3]=*(((char*)&curr_ch_buff_[0])+1); 
data_out[4]=*((char*)&curr_ch_buff_[1]);
data_out[5]=*(((char*)&curr_ch_buff_[1])+1);
data_out[6]=*((char*)&curr_ch_buff_[2]);
data_out[7]=*(((char*)&curr_ch_buff_[2])+1);
data_out[8]=*((char*)&curr_ch_buff_[3]);
data_out[9]=*(((char*)&curr_ch_buff_[3])+1);


/*
data_out[2]=*((char*)&adc_buff_zero_curr_[0]);
data_out[3]=*(((char*)&adc_buff_zero_curr_[0])+1); 
data_out[4]=*((char*)&adc_buff_zero_curr_[1]);
data_out[5]=*(((char*)&adc_buff_zero_curr_[1])+1);
data_out[6]=*((char*)&adc_buff_zero_curr_[2]);
data_out[7]=*(((char*)&adc_buff_zero_curr_[2])+1);
data_out[8]=*((char*)&adc_buff_zero_curr_[3]);
data_out[9]=*(((char*)&adc_buff_zero_curr_[3])+1);
*/

data_out[10]=*((char*)&plazma_int[0]);
data_out[11]=*(((char*)&plazma_int[0])+1);
data_out[12]=av_serv[0];
data_out[13]=av_serv[0]; 
data_out[14]=av_serv[1];
data_out[15]=av_serv[1];
data_out[16]=av_serv[2];
data_out[17]=av_serv[2];
data_out[18]=av_serv[3];
data_out[19]=av_serv[3];

data_out[20]=*((char*)&plazma_int[1]);
data_out[21]=*(((char*)&plazma_int[1])+1);
data_out[22]=av_upp[0];
data_out[23]=av_upp[0]; 
data_out[24]=av_upp[1];
data_out[25]=av_upp[1];
data_out[26]=av_upp[2];
data_out[27]=av_upp[2];
data_out[28]=av_upp[3];
data_out[29]=av_upp[3];

can_out_adr(0b00001000,0b00000001+((adres<<5)&0xe0),&data_out[0]);
can_out_adr(0b00001001,0b00000001+((adres<<5)&0xe0),&data_out[10]);
can_out_adr(0b00001010,0b00000001+((adres<<5)&0xe0),&data_out[20]);
}

//-----------------------------------------------
void log_in_drv(void)
{
if(PINC.0)serv_cnt[0]++;
else serv_cnt[0]--;
gran_char(&serv_cnt[0],0,100); 
if(serv_cnt[0]>=90)av_serv[0]=avsON;
else if(serv_cnt[0]<=10)av_serv[0]=avsOFF;

if(PINC.1)serv_cnt[1]++;
else serv_cnt[1]--;
gran_char(&serv_cnt[1],0,100); 
if(serv_cnt[1]>=90)av_serv[1]=avsON;
else if(serv_cnt[1]<=10)av_serv[1]=avsOFF;

if(PIND.0)serv_cnt[2]++;
else serv_cnt[2]--;
gran_char(&serv_cnt[2],0,100); 
if(serv_cnt[2]>=90)av_serv[2]=avsON;
else if(serv_cnt[2]<=10)av_serv[2]=avsOFF;

if(PIND.6)serv_cnt[3]++;
else serv_cnt[3]--;
gran_char(&serv_cnt[3],0,100); 
if(serv_cnt[3]>=90)av_serv[3]=avsON;
else if(serv_cnt[3]<=10)av_serv[3]=avsOFF;


DDRC&=0xfc;
PORTC|=0x03; 
DDRD&=0xbe;
PORTD|=0x41;
}


//-----------------------------------------------
void out_hndl(void)
{  
char i;
for(i=0;i<4;i++)
	{
	if(dv_stat[i]==dvOFF)
		{
		out_stat[i]=0;
		}             
	else if(dv_stat[i]==dvSTAR)
		{
		out_stat[i]=(1<<RELE1);
		}
	else if(dv_stat[i]==dvTRIAN)
		{
		out_stat[i]=(1<<RELE1);
		} 
	else if(dv_stat[i]==dvFULL)
		{
		out_stat[i]=(1<<RELE1);
		} 
	else if(dv_stat[i]==dvFR)
		{
		out_stat[i]=(1<<RELE2);
		}		
	else out_stat[i]=0;						
	if(dv_cnt[i])dv_cnt[i]--;		
	}
}

//-----------------------------------------------
void out_drv(void)
{
char i; 

DDRD.1=1;
if(out_stat[0]&(1<<RELE1))PORTD.2=1;
else PORTD.2=0;

DDRD.2=1; 
if(out_stat[0]&(1<<RELE2))PORTD.1=1;
else PORTD.1=0;

out_word=0;
if(out_stat[1]&(1<<RELE1))out_word|=(1<<0);
if(out_stat[1]&(1<<RELE2))out_word|=(1<<1);

if(out_stat[2]&(1<<RELE1))out_word|=(1<<2);
if(out_stat[2]&(1<<RELE2))out_word|=(1<<3);

if(out_stat[3]&(1<<RELE1))out_word|=(1<<4);
if(out_stat[3]&(1<<RELE2))out_word|=(1<<5);

spi(out_word);
DDRD.3=1;
PORTD.3=1;
delay_us(100);
PORTD.3=0;


}

//-----------------------------------------------
void avar_drv(void)
{
//adc_bank_[5] - датчик т-ры двигателя №1
//adc_bank_[7] - датчик вл. двигателя №1
//adc_bank_[3] - датчик т-ры двигателя №2
//adc_bank_[0] - датчик вл. двигателя №2

char i;
signed temp_S;
char temp;

for(i=0;i<2;i++)
	{
	temp_S=adc_buff_[PTR_IN_TEMPER[i]];
	if((temp_S>680)&&(main_cnt>10))
		{
		cnt_avtHH[i]++;
		cnt_avtKZ[i]=0;
		cnt_avtON[i]=0;
		cnt_avtOFF[i]=0;
		gran_char(&cnt_avtHH[i],0,50);
		if(cnt_avtHH[i]>=50) av_temper[i]=avtHH;
		}
	else if((temp_S<15)&&(main_cnt>10))
		{
		cnt_avtHH[i]=0;
		cnt_avtKZ[i]++;
		cnt_avtON[i]=0;
		cnt_avtOFF[i]=0;
		gran_char(&cnt_avtKZ[i],0,50);
		if(cnt_avtKZ[i]>=50) av_temper[i]=avtKZ;
		}
	else if((temp_S>195)&&(main_cnt>10))
		{
		cnt_avtHH[i]=0;
		cnt_avtKZ[i]=0;
		cnt_avtON[i]++;
		cnt_avtOFF[i]=0;
		gran_char(&cnt_avtON[i],0,50);
		if(cnt_avtON[i]>=50) av_temper[i]=avtON;
		}
	else if((temp_S<145)&&(main_cnt>10))
		{
		cnt_avtHH[i]=0;
		cnt_avtKZ[i]=0;
		cnt_avtON[i]=0;
		cnt_avtOFF[i]++;
		gran_char(&cnt_avtOFF[i],0,50);
		if(cnt_avtOFF[i]>=50) av_temper[i]=avtOFF;
		}
	else if(main_cnt<=10)av_temper[i]=avtOFF;
	
	temp_S=adc_buff_[PTR_IN_VL[i]];
	if((temp_S>670)&&(main_cnt>10))
		{
		cnt_avvHH[i]++;
		cnt_avvKZ[i]=0;
		cnt_avvON[i]=0;
		cnt_avvOFF[i]=0;
		gran_char(&cnt_avvHH[i],0,50);
		if(cnt_avvHH[i]>=50) av_vl[i]=avvHH;
		}
	else if((temp_S<20)&&(main_cnt>10))
		{
		cnt_avvHH[i]=0;
		cnt_avvKZ[i]++;
		cnt_avvON[i]=0;
		cnt_avvOFF[i]=0;
		gran_char(&cnt_avvKZ[i],0,50);
		if(cnt_avvKZ[i]>=50) av_vl[i]=avvKZ;
		}
	else if((temp_S<510)&&(main_cnt>10))
		{
		cnt_avvHH[i]=0;
		cnt_avvKZ[i]=0;
		cnt_avvON[i]++;
		cnt_avvOFF[i]=0;
		gran_char(&cnt_avvON[i],0,50);
		if(cnt_avvON[i]>=50) av_vl[i]=avvON;
		}
	else if((temp_S>540)&&(main_cnt>10))
		{
		cnt_avvHH[i]=0;
		cnt_avvKZ[i]=0;
		cnt_avvON[i]=0;
		cnt_avvOFF[i]++;
		gran_char(&cnt_avvOFF[i],0,50);
		if(cnt_avvOFF[i]>=50) av_vl[i]=avvOFF;
		}
	else if(main_cnt<=10)av_vl[i]=avvOFF;		
	}

for(i=0;i<4;i++)
	{
	temp_S=adc_buff_[PTR_IN_UPP[i]];
	if(temp_S<100)upp_cnt[i]++;
	else if(temp_S>200) upp_cnt[i]--;
	gran_char(&upp_cnt[i],0,10);
	
	if(upp_cnt[i]>=9)av_upp[i]=avuON;
	else if(upp_cnt[i]<=1)av_upp[i]=avuOFF;
	}
}


//-----------------------------------------------
void can_in_an(void)
{ 
char i;

if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00000000) //сообщение от платы контроллера
	{
	if(fifo_can_in[ptr_rx_rd,0]==((adres<<5)&0b11100000))//сообщение №0 именно для этой платы расширения
		{
	    
	    	if((fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])&&
	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,7])&&
	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,8]))	
	    	   	{
	    	   	dv_on[0]=fifo_can_in[ptr_rx_rd,6];
	    	   	
	    	     }
	    	if((fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])&&
	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,11])&&
	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,12]))	dv_on[1]=fifo_can_in[ptr_rx_rd,9];
	    	   
	    	
	    	for(i=0;i<2;i++)
	    		{
	    		if(dv_on[i]!=dv_on_old[i])
	    			{
	    			if(dv_on[i]==dvOFF)
	    				{
	    				dv_stat[i]=dvOFF;
	    				dv_on_old[i]=dvOFF;
	    				}                  
	    			else if(dv_on[i]==dvSTAR)
	    				{
	    				dv_stat[i]=dvSTAR;
	    				dv_cnt[i]=10;
	    				dv_on_old[i]=dvSTAR;
	    				} 
	    			else if(dv_on[i]==dvTRIAN)
	    				{
	    				dv_stat[i]=dvTRIAN;
	    				dv_cnt[i]=10;
	    				dv_on_old[i]=dvTRIAN;
	    				}  
	    			else if(dv_on[i]==dvFULL)
	    				{
	    				dv_stat[i]=dvFULL;
	    				dv_cnt[i]=35;
	    				dv_on_old[i]=dvFULL;
	    				}	   
	    				
	    			else if(dv_on[i]==dvFR)
	    				{
	    				dv_stat[i]=dvFR;
	    				dv_cnt[i]=35;
	    				dv_on_old[i]=dvFR;
	    				}	  	    				 				 
	    			}
	    		}   
	 	}
	else if(fifo_can_in[ptr_rx_rd,0]==(((adres<<5)&0b11100000)+1))//сообщение №1 именно для этой платы расширения
		{
		    //	plazma++;
	    	if((fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])&&
	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,7])&&
	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,8]))	
	    	   	{
	    	   	dv_on[2]=fifo_can_in[ptr_rx_rd,6];
	    	   	
	    	     }
	    	if((fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])&&
	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,11])&&
	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,12]))	dv_on[3]=fifo_can_in[ptr_rx_rd,9];
	    	   
	    	
	    	for(i=2;i<4;i++)
	    		{
	    		if(dv_on[i]!=dv_on_old[i])
	    			{
	    			if(dv_on[i]==dvOFF)
	    				{
	    				dv_stat[i]=dvOFF;
	    				dv_on_old[i]=dvOFF;
	    				}                  
	    			else if(dv_on[i]==dvSTAR)
	    				{
	    				dv_stat[i]=dvSTAR;
	    				dv_cnt[i]=10;
	    				dv_on_old[i]=dvSTAR;
	    				} 
	    			else if(dv_on[i]==dvTRIAN)
	    				{
	    				dv_stat[i]=dvTRIAN;
	    				dv_cnt[i]=10;
	    				dv_on_old[i]=dvTRIAN;
	    				}  
	    			else if(dv_on[i]==dvFULL)
	    				{
	    				dv_stat[i]=dvFULL;
	    				dv_cnt[i]=35;
	    				dv_on_old[i]=dvFULL;
	    				}
	    			else if(dv_on[i]==dvFR)
	    				{
	    				dv_stat[i]=dvFR;
	    				dv_cnt[i]=35;
	    				dv_on_old[i]=dvFR;
	    				}	    					    				 
	    			}
	    		}
	    	}	 	
	}	
}

//-----------------------------------------------
void can_hndl(void)
{            
while(rx_counter)
	{
	can_in_an();
	rx_counter--;
	ptr_rx_rd++;
	if(ptr_rx_rd>=FIFO_CAN_IN_LEN)ptr_rx_rd=0;
	
	}
}

//-----------------------------------------------
void adc_hndl(void)
{
char i,j;
int temp_UI;
for(i=0;i<8;i++)
	{  
	temp_UI=0;
	for(j=0;j<16;j++)
		{
		temp_UI+=adc_buff[i,j];
		}
	adc_buff_[i]=temp_UI>>4;	
	}

for(i=0;i<4;i++)
	{  
	temp_UI=0;
	for(j=0;j<16;j++)
		{
		temp_UI+=curr_ch_buff[i,j];
		}
	curr_ch_buff_[i]=temp_UI>>1;
	
	//curr_ch_buff_[0]=58;	
	}	
plazma_int[0]=adc_buff_[PTR_IN_TEMPER[0]];
plazma_int[1]=adc_buff_[PTR_IN_TEMPER[1]];
plazma_int[2]=adc_buff_[PTR_IN_VL[0]];
plazma_int[3]=adc_buff_[PTR_IN_VL[1]];	
}

//-----------------------------------------------
void adc_drv(void)
{ 
unsigned self_adcw,temp_UI;
char temp;

DDRB.1=1;
             
self_adcw=ADCW;

if(adc_cnt_main<4)
	{
	if(self_adcw<self_min)self_min=self_adcw; 
	if(self_adcw>self_max)self_max=self_adcw;
	
	self_cnt++;
	if(self_cnt>=30)
		{
		curr_ch_buff[adc_cnt_main,adc_cnt_main1[adc_cnt_main]]=self_max-self_min;
		if(adc_cnt_main==0)
			{
		    //	plazma_int[0]=self_max;
		    //	plazma_int[1]=self_min;
			}
		
		adc_cnt_main1[adc_cnt_main]++;
		if(adc_cnt_main1[adc_cnt_main]>=16)adc_cnt_main1[adc_cnt_main]=0;
		adc_cnt_main++;
		if(adc_cnt_main<4)
			{
			curr_buff=0;
			self_cnt=0;
		    //	self_cnt_zero_for=0;
			self_cnt_not_zero=0;
			self_cnt_zero_after=0;
			self_min=1023;
			self_max=0;			
			} 			
 
						
	 	}  		
	}
else if(adc_cnt_main==4)
	{
	adc_buff[adc_ch,adc_ch_cnt]=self_adcw;
	
	adc_ch++;
	if(adc_ch>=8)
		{
		adc_ch=0;
		
		adc_cnt_main=5;
		
		curr_buff=0;
		self_cnt=0;
		//self_cnt_zero_for=0;
		self_cnt_not_zero=0;
		self_cnt_zero_after=0;         
		
		adc_ch_cnt++;
		if(adc_ch_cnt>=16)adc_ch_cnt=0;
		}
	}

else if(adc_cnt_main==5)
	{
	adc_cnt_main=6;
	curr_buff=0;
	self_cnt=0;
    //	self_cnt_zero_for=0;
	self_cnt_not_zero=0;
	self_cnt_zero_after=0;
	self_min=1023;
	self_max=0;
	}
else if(adc_cnt_main==6)
	{
	adc_cnt_main=0;
	curr_buff=0;
	self_cnt=0;
    //	self_cnt_zero_for=0;
	self_cnt_not_zero=0;
	self_cnt_zero_after=0;
	self_min=1023;
	self_max=0;
	}	
				     
DDRB|=0b11000000;
DDRD.5=1;
PORTB=(PORTB&0x3f)|(adc_ch<<6); 
PORTD.5=adc_ch>>2; 

ADCSRA=0x86;
ADMUX=ADMUX_CONST[adc_cnt_main];
ADCSRA|=0x40;	
} 

//-----------------------------------------------
void t0_init(void)
{
TCCR0=0x03;
TCNT0=-125;
TIMSK|=0b00000001;
}                                                

//***********************************************
//***********************************************
//***********************************************
//***********************************************
// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
t0_init();
adc_drv();

b_mcp=!b_mcp;
if(b_mcp)mcp_drv();
if(++t0_cnt0>=10)
	{        
	t0_cnt0=0;
	b100Hz=1;

    	if(++t0_cnt1>=10)
    		{
    		t0_cnt1=0;
		b10Hz=1;
		}
    	if(++t0_cnt2>=20)
    		{
    		t0_cnt2=0;
		b5Hz=1;
		}
    	if(++t0_cnt3>=50)
    		{
    		t0_cnt3=0;
		b2Hz=1;
		}
    	if(++t0_cnt4>=100)
    		{
    		t0_cnt4=0;
		b1Hz=1;
		}								
	}
/*DDRB=0xFF;
PORTB.0=!PORTB.0;*/
}

//===============================================
//===============================================
//===============================================
//===============================================
void main(void)
{

PORTB=0x00;
DDRB=0x00;

PORTC=0x00;
DDRC=0x00;

PORTD=0x00;
DDRD=0x00;

TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;

ASSR=0x00;
TCCR2=0x00;
TCNT2=0x00;
OCR2=0x00;

MCUCR=0x00;

t0_init();

ACSR=0x80;
SFIOR=0x00;

#asm("sei")
can_init(); 


spi(0);
DDRD.3=1;
PORTD.3=1;
delay_us(100);
PORTD.3=0;
while (1)
	{
	if(b100Hz)
		{
		b100Hz=0;
		
         	//Подпрограммы исполняемые 100 раз в секунду
          log_in_drv();				//Драйвер логических входов(УПП,сервис)		
		can_hndl();                   //Обработка входящих сообщений по CAN
		}	   
	if(b10Hz)
		{
		b10Hz=0;                                    
		
      	//Подпрограммы исполняемые 10 раз в секунду
      	avar_drv();	        		//отслеживание всех аварий
      	out_hndl();
      	out_drv();				//управление реле
      	

      	}	
	if(b5Hz)
		{                            
		b5Hz=0;                      
		
		//Подпрограммы исполняемые 5 раз в секунду
		adc_hndl();
          
          //out_stat[0]=(1<<RELE2)|(1<<RELE4);
		}
	if(b2Hz)
		{
		b2Hz=0;
          transmit_hndl(); 
          //bon0=!bon0;                                                       
		}								
	if(b1Hz)
		{
		b1Hz=0;
          if(main_cnt<1000)main_cnt++;

		}
	}
}
