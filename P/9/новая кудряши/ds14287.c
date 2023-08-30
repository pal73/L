#define SECONDS		0x00
#define SECONDS_ALARM	0x01
#define MINUTES		0x02
#define MINUTES_ALARM	0x03
#define HOURS			0x04
#define HOURS_ALARM		0x05
#define DAY_OF_THE_WEEK	0x06
#define DAY_OF_THE_MONTH	0x07
#define MONTH			0x08
#define YEAR			0x09
#define REGISTER_A		0x0A
#define REGISTER_B		0x0B
#define REGISTER_C		0x0C
#define REGISTER_D		0x0D

//-----------------------------------------------
char read_ds14287(char adr)
{ 
char temp;      
RESET_OFF
RD_OFF
WR_OFF                                         
CS_ON
PORT_OUT
PORT=adr;
AS_STROB 
PORT_IN
RD_ON
RD_ON
RD_ON
RD_ON
temp=PORT_PIN;
RD_OFF
CS_OFF
return temp;
} 

//-----------------------------------------------
void write_ds14287(char adr, char in)
{ 
RESET_OFF
RD_OFF
WR_OFF                                         
CS_ON
PORT_OUT
PORT=adr;
AS_STROB 
PORT_OUT
PORT=in;
WR_ON
WR_ON
WR_OFF
CS_OFF
}