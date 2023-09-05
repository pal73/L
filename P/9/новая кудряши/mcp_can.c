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