#define CNF1_INIT	0b00000001  //tq=500ns   //8MHz
#define CNF2_INIT	0b10110001  //Ps1=7tq,Pr=2tq 
#define CNF3_INIT	0b00000101  //Ps2=6tq

#define RESURS_CNT_SEC_IN_HOUR 3600

#define FIFO_CAN_IN_LEN	10
#define FIFO_CAN_OUT_LEN	10
                
#define CS_DDR	DDRB.4
#define CS	PORTB.4 
#define SPI_PORT_INIT  DDRB.1=1;DDRB.2=1;DDRB.3=0;DDRB.4=1;SPCR=0x50;SPSR=0x00; 

#define RESET_OFF      	DDRG|=0b00000010; PORTG|=0b00000010;
#define RD_OFF      	DDRG|=0b00000001; PORTG|=0b00000001;
#define WR_OFF      	DDRD.7=1; PORTD.7=1;
#define CS_ON      		DDRD.5=1; PORTD.5=0;
#define PORT_OUT      	DDRC=0xff;
#define AS_STROB   		DDRD.6=1; PORTD.6=1;PORTD.6=1;PORTD.6=1;PORTD.6=0;
#define PORT			PORTC
#define PORT_PIN		PINC
#define PORT_IN      	DDRC=0x00;
#define RD_ON      		DDRG|=0b00000001; PORTG&=0b11111110;
#define CS_OFF      	DDRD.5=1; PORTD.5=1;
#define WR_ON	      	DDRD.7=1; PORTD.7=0;

#include <mega128.h>
#include <delay.h>
#include <stdio.h> 
#include <math.h>
#include "gran.c"

#include "ds14287.c"

//**********************************************
//Переменные в EEPROM 
eeprom signed BEGIN_DUMM[10];

eeprom enum {emAVT=0x55,emMNL=0xaa,emTST=0xcc}EE_MODE; //Режим работы станции   

eeprom char TEMPER_SIGN;							//Сигнал климат-контроля(0-внутр,1-внешний)
eeprom signed AV_TEMPER_COOL; 					//Температура аварии по холоду климатконтроля
eeprom signed T_ON_WARM;							//Температура включения отопителя климатконтроля
eeprom signed T_ON_COOL;							//Температура включения вентилятора климатконтроля
eeprom signed AV_TEMPER_HEAT;                         	//Температура аварии по теплу климатконтроля
eeprom signed TEMPER_GIST;                         	//Гистерезис климатконтроля  
eeprom signed Kt[2];							//Калибровка датчиков температуры климатконтроля(0 - внутренний, 1 - внешний)
eeprom signed KLIMAT_DUMM[10];

eeprom signed AV_NET_PERCENT;						//Допуск напряжения сети
eeprom enum {f_ABC=0x55,f_ACB=0xAA}fasing;			//фазировка сети
eeprom signed Kun[3];                                  //Калибровка напряжения фаз сети
eeprom signed NET_DUMM[10];

eeprom char P_SENS;                                    //Тип датчика давления
eeprom signed P_MIN;							//
eeprom signed P_MAX;							//
eeprom signed T_MAXMIN;							//
eeprom signed G_MAXMIN;							//
eeprom signed Kp0,Kp1;							//Калибровка датчика давления
eeprom signed P_DUMM[10];

eeprom char EE_DV_NUM;							//Количество насосов
//#define EE_DV_NUM	2 
eeprom enum {stON=0x55,stOFF=0xAA}STAR_TRIAN;		//
eeprom enum {dm_AVT=0x55,dm_MNL=0xAA}DV_MODE[7];		//режимы работы насосов
eeprom unsigned int RESURS_CNT[6];					//Счетчики моторесурса насосов
eeprom signed Idmin;							//Ток насоса минимальный 
eeprom signed Idmax;							//Ток насоса максимальный 
eeprom signed Kida[6],Kidc[6]; 					//Калибровка токов двигателей
eeprom signed C1N;
eeprom enum {dasLOG=0x55,dasDAT=0xAA}DV_AV_SET;		//
eeprom signed DV_DUMM[9];

eeprom signed SS_LEVEL;							//Ступенчатый пуск - 
eeprom signed SS_STEP;							//Ступенчатый пуск -
eeprom signed SS_TIME;							//Ступенчатый пуск -
eeprom signed SS_FRIQ;							//Ступенчатый пуск -
eeprom signed SS_DUMM[10];

eeprom signed DVCH_T_UP;							//Переключение насосов - 
eeprom signed DVCH_T_DOWN;						//Переключение насосов -
eeprom signed DVCH_P_KR;							//Переключение насосов -
eeprom signed DVCH_KP;							//Переключение насосов -
eeprom signed DVCH_TIME;							//Переключение насосов - 
eeprom enum {dvch_ON=0x55,dvch_OFF=0xAA}DVCH;		//Переключение насосов - 
eeprom signed DVCH_DUMM[10];

eeprom signed FP_FMIN;							//Частотный преобразователь - минимальная частота
eeprom signed FP_FMAX;							//Частотный преобразователь - максимальная частота  
eeprom signed FP_TPAD;							//Частотный преобразователь - 
eeprom signed FP_TVOZVR;							//Частотный преобразователь -  
eeprom signed FP_CH; 							//Частотный преобразователь - 
eeprom signed FP_P_PL;							//Частотный преобразователь - 
eeprom signed FP_P_MI;							//Частотный преобразователь - 
eeprom signed FP_DUMM[10];

eeprom enum {dON=0x55,dOFF=0xAA}DOOR;				//Задвижка - 
eeprom signed DOOR_IMIN;							//Задвижка - 
eeprom signed DOOR_IMAX;							//Задвижка -
eeprom enum {dmS=0x55,dmA=0xAA}DOOR_MODE;			//Задвижка -
eeprom signed DOOR_DUMM[10];

eeprom enum {pON=0x55,pOFF=0xAA}PROBE;				//Пробный пуск - 
eeprom signed PROBE_DUTY;						//Пробный пуск -
eeprom signed PROBE_TIME;						//Пробный пуск -
eeprom signed PROBE_DUMM[10];

eeprom enum {hhWMS=0x55}HH_SENS;					//Сухой ход - 
eeprom signed HH_P;								//Сухой ход - 
eeprom signed HH_TIME;					    		//Сухой ход - 
eeprom signed HH_DUMM[10];

eeprom signed ZL_TIME;					    		//Нулевая нагрузка - 
eeprom signed ZL_DUMM[10];       

eeprom signed  P_UST_EE;

eeprom enum {tsWINTER=0x55,tsSUMMER=0xAA}time_sezon; 

signed p_ust;
int plazma;
char p_ind_cnt;
enum char {iMn=33,iSet,iK,iNet=39,iPopl_sel=66,iPopl=72,iDv=92,iT_sel=133,iT1=155,iT2=166,iPrl=189,iWrk_popl=191,
		iWrk_p=192,iDavl=117,iDnd=150,iStat,iKnet,iKdt_in,iKdt_out,iSetT,iSet_warm,iSet_cool,iNet_set,iPid_set,iTimer_sel,
		iKi1,iKi2,iPopl_set,iKd_sel,iKd_i,iDv_sel,iDv_set,iAv_sel,iAv,iStep_start,iLev_sign,iLev_set,iKd_p,iKd_i1,iKd_i2
		,iDv_change,iDv_change1,iTemper_set,iMode_set,iDeb,iFp_set,iDoor_set,iProbe_set,iHh_set,iTimer_set,iZero_load_set,iDv_av_log
		,iDv_num_set,iDv_start_set,iDv_imin_set,iDv_imax_set,iDv_mode_set,iDv_resurs_set,iDv_i_kalibr,iDv_c_set,iDv_out}ind;
flash char DAY_MONTHS[12]={31,29,31,30,31,30,31,31,30,31,30,31};
flash char __weeks_days_[8][15]={"   ","воскр.","понед.","вторн.","среда","четверг","пятн.","суббота"};
//**********************************************
//Глобальные переменные
char data_for_ind[40];
unsigned main_cnt;
char out_stat;
//**********************************************
//Работа с кнопками                             
char but_n;
char but_s;
char but;
char but0_cnt;
char but1_cnt;
char but_onL_temp;
//bit speed; 
bit l_but;
bit n_but;
signed char but_cnt[5];
//***********************************************
//Битовые переменные
bit b500Hz;
bit b100Hz;
bit b10Hz;
bit b5Hz; 
bit b2Hz;
bit b1Hz;
static char t0cnt000,t0cnt0_,t0cnt0,t0cnt1,t0cnt2,t0cnt3,t0cnt4,t0cnt5,t0cnt6;

char cob[20],cib[20];
char data_out[10];

//***********************************************
//Работа с АЦП 
unsigned int result;
char result_adr0,result_adr1;
char adc_cnt0; 	//
char adc_cnt1; 	//
char adc_cnt2; 	//
char adc_cnt3; 	// 
unsigned unet_bank_buff[3];
unsigned char unet_zero_cnt[3],unet_cnt[3];
unsigned unet_bank[3][32],unet_bank_[3];  
unsigned adc_bank[8][16],adc_bank_[8];
//eeprom enum {AV_EN=0x55,AV_DIS=0xAA}aven;


//***********************************************
//Мониторинг питающей сети
//enum {asu_ON=0x55,asu_OFF=0xaa} av_st_unet;
enum {asuc_AV=0x55,asuc_NORM=0xaa} av_st_unet_cher;
signed unet[3]={135,335,535};
//signed eeprom UNET_MAX_EE,UNET_MIN_EE;
//signed char unet_avar_cnt;
bit bA,bB,bC;
char cnt_x;
char cher_cnt=25;
enum {nfABC=0x55,nfACB=0xAA}net_fase=0;

char but_pult;
char unet_min_cnt[3],unet_max_cnt[3];
enum {unet_st_NORM,unet_st_MIN,unet_st_MAX}unet_st[3];

//***********************************************
//Температура
signed t[2];

//signed eeprom AV_TEMPER_HEAT,TEMPER_GIST,T_ON_COOL,T_ON_WARM,T_GIST_WARM_DUMM,T_GIST_COOL_DUMM;
enum{tCOOL,tNORM,tHEAT,tAVSENS}t_air_st;
enum{cool_ON,cool_OFF,cool_AVSENS}cool_st;
enum{warm_ON=0x55,warm_OFF=0xaa,warm_AVSENS=0xbb}warm_st; 
//eeprom char COOL_SIGN_DUMM,AV_TEMPER_SIGN_DUMM;
signed char t_on_warm_cnt,t_on_cool_cnt;
enum{av_temper_NORM=0xaa,av_temper_COOL=0x99,av_temper_HEAT=0x88,av_temper_AVSENS=0xbb}av_temper_st; 
char av_temper_cool_cnt,av_temper_heat_cnt;
//***********************************************
//Время
char _sec,_min,_hour,_day,_month,_year,_week_day;    




//***********************************************
//Работа с поплавками
enum {poplUP=0x55,poplDN=0xaa,poplAV=0x69} popl_st[4];
signed char popl_cnt_p[4],popl_cnt_m[4],popl_cnt_av[4];
//eeprom enum {popl2kont=0x55,popl3kont=0xaa,poplisoff=0xcd}popl_ust; 
//eeprom enum {popl2kont=0x55,popl3kont=0xaa,poplisoff=0xcd}popl_ust_dumm[3];
enum {avON=0x55,avOFF=0xaa}hh_av;

signed char level,level_old;


//***********************************************
//Входы 4-20mA
signed p;
signed height_level_i[2];
//signed eeprom Kdi__[2];

//**********************************************
//Состояние двигателей
unsigned Ida[6],Idc[6],Id[6];

//enum {avvON=0x55,avvOFF=0xaa,avvKZ=0x69,avvHH=0x66} av_vl[6],av_vl_old[6];
enum {avuON=0x55,avuOFF=0xaa} av_upp[6],av_upp_old[6];
signed char cnt_avtHH[4],cnt_avtKZ[4],cnt_avtON[4],cnt_avtOFF[4],cnt_avvHH[4],cnt_avvKZ[4],cnt_avvON[4],cnt_avvOFF[4];
char cnt_control_blok;
enum {dvOFF=0x81,dvSTAR=0x42,dvTRIAN=0x24,dvFR=0x66,dvFULL=0x99,dvON=0xAA} fp_stat=dvOFF,dv_on[6]={dvOFF,dvOFF,dvOFF,dvOFF,dvOFF,dvOFF},dv_access[6]={dvOFF,dvOFF,dvOFF,dvOFF,dvOFF,dvOFF};
signed fp_poz;
char potenz,potenz_off;
unsigned comm_curr;
char num_wrks_new,num_wrks_new_new,num_wrks_old;
char num_necc,num_necc_old;

//eeprom enum {el_420_1=0x55,el_420_2=0x66,el_P=0x88,el_popl=0xaa}EE_LOG; //тип датчиков - поплавки или датчик давления


//enum {avuON=0x55,avuOFF=0xAA}av_upp[6];
enum {avsON=0x55,avsOFF=0xAA}av_serv[6];

//***********************************************
//Подсчёт моторесурса двигателей

unsigned int resurs_cnt_[6];  //счетчик секунд 
unsigned long resurs_cnt__[6];  //полный счетчик


//unsigned int eeprom RESURS_MAX[6];
enum {resOFF,resON} dv_res[6];

//eeprom enum {dvON=0x55,dvOFF=0xaa} dv_on_mnl[6];

char data_for_ex[3][10];
enum {cast_ON1=0x55,cast_ON2=0x69,cast_OFF=0xAA} comm_av_st; 
bit bCONTROL;

unsigned fp_step_num;		//количество шагов частотного преобразователя от минимума  до максимума
signed power=0;               //виртуальная "сила" установки
signed fp_power;			//частота пробразователя равна FP_FMIN+(10*fp_power) 
//enum {dv_ON=0x55,dvOFF};	//состояние частотника
//***********************************************
//Авария по переливу
enum {av_pereliv_ON=0x55,av_pereliv_OFF=0xAA}av_pereliv=av_pereliv_OFF;
signed av_pereliv_cnt;
//***********************************************
//Аварии двигателей по току и АПВ
signed char av_id_min_cnt[6];
signed char av_id_max_cnt[6];
//signed char av_id_per_cnt[6];
signed char av_id_log_cnt[6];
signed char av_id_not_cnt[6];
enum {aviON=0x55,aviOFF=0xAA}av_i_dv_min[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
					    av_i_dv_max[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
					    av_i_dv_not[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
					    //av_i_dv_per[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
					    av_i_dv_log[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
					    av_i_dv_log_old[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF};
char apv_cnt[6];
enum {apvON=0x55,apvOFF=0xaa} apv[6]={apvOFF,apvOFF,apvOFF,apvOFF,apvOFF,apvOFF};
char cnt_av_i_not_wrk[6];

//eeprom signed EE_LEVEL_DUMM[4]; 
signed height_level=127;

//***********************************************
//Датчик давления
signed height_level_p;


//signed eeprom Kdi1[2],Kdi0[2];

//***********************************************
//Журнал аварий


eeprom char av_hour[20],av_min[20],av_sec[20],av_day[20],av_month[20],av_year[20];
eeprom signed av_code[20],av_data0[20],av_data1[20];
eeprom signed ptr_last_av;
//eeprom signed EE_LEVEL[5];

char skb_cnt;

enum {lON=0x55,lOFF=0xAA}level_on[5];
char level_cnt[5];
char test_cnt;
signed temper_result;
signed not_wrk_cnt;
char av_level_sensor_cnt;
enum{av_lsON=0x55,av_lsOFF=0xaa}av_ls_stat=av_lsOFF;
bit bLEVEL0;
char not_wrk,not_wrk_old;
char wrk_cnt;
//eeprom signed time_wrk_off;
signed time_off;  
char plazma_i[6];



#define LCD_SIZE 40

extern void can_out_adr(char adr0,char adr1,char* data_ptr);	    	
extern void can_out_adr_len(char adr0,char adr1,char* data_ptr,char len);
extern char read_ds14287(char adr);
signed char p1,p2;
bit zero_on;
char dig[5];
flash char ABC[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

flash char sm_[]	={"                "}; 
flash char sm_exit[]={" Выход          "}; 

#pragma ruslcd+ 
//char lcd_buffer[40]={"0123456789abcdefghijABCDEFGHIJ+-"};
char lcd_buffer[40]={" "};

//flash char sm300[]	={"     АВАРИИ     "};

//flash char sm303[]	={" Аварий нет     "};

//flash char sm400[]	={};





/*flash char sm415[]	={" перекос токов  "};
flash char sm416[]	={"  температура   "};
flash char sm417[]	={"   влажность    "}; */

#pragma ruslcd-

flash char sm_mont[12][4]={"янв","фев","мар","апр","май","июн","июл","авг","сен","окт","ноя","дек"}; // 
flash char sm_av[224][3]={"00","01","02","03","04","05","06","07","08","09","0а","0б","0в","0г","0д","0е","00","01","02","03","04","05","06","07","08","09","0а","0б","0в","0г","0д","0е",
					"10","11","12","13","14","15","16","17","18","19","1а","1б","1в","1г","1д","1е","10","11","12","13","14","15","16","17","18","19","1а","1б","1в","1г","1д","1е",
				    	"20","21","22","23","24","25","26","27","28","29","2а","2б","2в","2г","2д","2е","20","21","22","23","24","25","26","27","28","29","2а","2б","2в","2г","2д","2е",
				    	"30","31","32","33","34","35","36","37","38","39","3а","3б","3в","3г","3д","3е","30","31","32","33","34","35","36","37","38","39","3а","3б","3в","3г","3д","3е",
				    	"40","41","42","43","44","45","46","47","48","49","4а","4б","4в","4г","4д","4е","40","41","42","43","44","45","46","47","48","49","4а","4б","4в","4г","4д","4е",
				    	"50","51","52","53","54","55","56","57","58","59","5а","5б","5в","5г","5д","5е","50","51","52","53","54","55","56","57","58","59","5а","5б","5в","5г","5д","5е",
				    	"60","61","62","63","64","65","66","67","68","69","6а","6б","6в","6г","6д","6е","60","61","62","63","64","65","66","67","68","69","6а","6б","6в","6г","6д","6е"}; //



//char plazma;
int plazma_int[8];
enum {rON=0x55,rOFF=0xaa}rel_in_st[4];

eeprom signed pilot_dv;
char sub_ind,index_set,sub_ind1,sub_ind2;
#include "ret.c"
#include "mcp2510.h"
#include "mcp_can.c"
#include "ruslcd.c"

char modbus_buffer[20];
char modbus_cnt; 
unsigned __fp_fmin,__fp_fmax,__fp_fcurr; 
unsigned read_parametr;
#include "crc16.c"
#define _485_tx_en_		PORTB.5
#define _485_tx_en_dd_	DDRB.5
#define _485_rx_en_		PORTB.6
#define _485_rx_en_dd_	DDRB.6
#include "modbus.c" 
signed fr_stat=0;
enum {mSTOP=0x00,mSTART=0x11,mREG=0x22,mTORM=0x88,mFPAV=0x99}mode=mSTOP;
signed power_cnt;
signed hh_av_cnt; 
signed p_old; 
signed pid_cnt;
signed e[3];
signed long u;
signed bPOWER;
#define a0	245L 
#define a1	-350L
#define a2	125L
eeprom signed PID_PERIOD; 
eeprom signed PID_K;
eeprom signed PID_K_P;
eeprom signed PID_K_D;
eeprom signed PID_K_FP_DOWN;
signed long p_bank[16];
char p_bank_cnt;  
bit bPOTENZ_UP,bPOTENZ_DOWN;
char net_motor_potenz,net_motor_wrk;
char mode_ust;  

/*typedef eeprom struct
	{  */
eeprom unsigned timer_time1[7,5];
eeprom unsigned timer_time2[7,5];
eeprom char timer_mode[7,5];
eeprom signed timer_data1[7,5];
eeprom signed timer_data2[7,5];
/*	}
	TIMER_STRUCT;

TIMER_STRUCT eeprom timer_data[7][5]; */ 

bit bDVCH;
bit bPMIN; 
signed p_max_cnt,p_min_cnt;	
enum {avpOFF=0x00,avpMIN=0x11,avpMAX=0x22}av_p_stat=avpOFF; 
unsigned avp_day_cnt[4]={0,0,0,0};

unsigned CURR_TIME;
char temp_DVCH;
unsigned plazma_plazma; 

//enum {fpavON=0x55,fpavOFF=0xAA} fp_av_st=fpavOFF;

enum {aspOFF=0xaa,aspON=0x55}av_sens_p_stat=aspOFF;  
signed char av_sens_p_hndl_cnt;
signed pid_poz;
signed av_fp_cnt;                                                      
enum {afsON=0x55,afsOFF=0xAA}av_fp_stat=afsOFF;
enum {faOFF=0xaa,faON=0x55} fp_apv[6]={faOFF,faOFF,faOFF,faOFF,faOFF,faOFF};    
char temp_fp; 
signed p_ust_pl,p_ust_mi;
char day_period;     
signed zl_cnt;

char adc_cnt_main;
signed self_min;
signed self_max;
char self_cnt;
signed curr_ch_buff[4,16];
char adc_cnt_main1[4]; 
char adc_ch_cnt;
signed curr_ch_buff_[4];
char temp_m8[15];
bit bCAN_EX;
//-----------------------------------------------
char crc_87(char* ptr,char num)
{
char r,j,lb;
r=*ptr;

for(j=1;j<num;j++)
	{
     ptr++;
	r=((*ptr)^Table87[r]);
	}

return r;	
} 

//-----------------------------------------------
char crc_95(char* ptr,char num)
{
char r,j,lb;
r=*ptr;

for(j=1;j<num;j++)
	{
     ptr++;
	r=((*ptr)^Table95[r]);
	}

return r;	
}


//-----------------------------------------------
void power_start (void)
{
power=1;
power_cnt=0;
}

//-----------------------------------------------
void pid_start(void)
{             
pid_cnt=0;
e[0]=0;
e[1]=0;
e[2]=0;

u=fp_poz;
}
 
//
#define AVAR_FP	0x00                 
//
#define AVAR_P_SENS	0x01
//
#define AVAR_UNET	0x04
//
#define AVAR_CHER	0x06
//
#define AVAR_HEAT	0x07
//
#define AVAR_COOL	0x08
//
#define AVAR_HH 	0x0A
//
#define AVAR_P_MIN 	0x0B
//
#define AVAR_P_MAX 	0x0C
//
#define AVAR_START	0x0e


//
#define AVAR_I_MIN	9
//
#define AVAR_I_MAX	2
//
#define AVAR_I_LOG	5





//-----------------------------------------------
void av_hndl(char in,signed in0,signed in1)
{
//granee(&ptr_last_av,0,19); 

ptr_last_av++;
if(ptr_last_av>=20)ptr_last_av=0; 

av_hour[ptr_last_av]=read_ds14287(HOURS)&0x1f;
av_min[ptr_last_av]=read_ds14287(MINUTES);
av_sec[ptr_last_av]=read_ds14287(SECONDS);
av_day[ptr_last_av]=read_ds14287(DAY_OF_THE_MONTH);
av_month[ptr_last_av]=read_ds14287(MONTH);
av_year[ptr_last_av]=read_ds14287(YEAR);
av_code[ptr_last_av]=in;
av_data0[ptr_last_av]=in0;
av_data1[ptr_last_av]=in1;


}
 

//-----------------------------------------------
void zl_hndl(void)
{

if((p_ust<=p)&&(mode==mREG)&&(num_wrks_new==0)&&(fp_poz<1000))
	{
	if(zl_cnt<ZL_TIME)
		{
		zl_cnt++;
		if(zl_cnt>=ZL_TIME) 
			{
			mode=mTORM;
			}
		}
	}
else zl_cnt=0;
}

//-----------------------------------------------
void av_sens_p_hndl(void)
{
signed long temp_SL;

temp_SL=(signed long)adc_bank_[3];
temp_SL*=500L;
temp_SL/=1024;

if((temp_SL<35)||(temp_SL>250))
	{
	if(av_sens_p_hndl_cnt<25)
		{
		av_sens_p_hndl_cnt++;
		if((av_sens_p_hndl_cnt>=25)&&(av_sens_p_stat!=aspON))
			{
			av_sens_p_stat=aspON;
			av_hndl(AVAR_P_SENS,temp_SL,0);
			}
		}
	else if(av_sens_p_hndl_cnt>25)av_sens_p_hndl_cnt=20;	
	}

else if((temp_SL>35)&&(temp_SL<250))
	{
	if(av_sens_p_hndl_cnt>0)
		{
		av_sens_p_hndl_cnt--;
		if((av_sens_p_hndl_cnt<=0)&&(av_sens_p_stat!=aspOFF))
			{
			av_sens_p_stat=aspOFF;
			}
		}
	else if(av_sens_p_hndl_cnt>25)av_sens_p_hndl_cnt=20;	
	}

}

//-----------------------------------------------
void mode_hndl (void)
{ 

if(EE_MODE==emAVT)
	{
	
	if(mode==mSTOP)
		{
		if((rel_in_st[0]==rON)&&(comm_av_st!=cast_ON2)&&(!bDVCH)&&((p_ust>p) && ((p_ust-p)>(SS_LEVEL*10)) ))
   			{ 
   			if(av_fp_stat!=afsON)
   				{
   				mode=mSTART;
  				power_start();
  				}
  			else 
  				{
  				mode=mFPAV;
  				}	 
  			av_hndl(AVAR_START,0,0);
  			}
  		} 
	
	else if(mode==mSTART)
   		{
  		if((rel_in_st[0]==rOFF)||(comm_av_st==cast_ON2))
  			{
  			mode=mTORM;
  			}
  		}
	
	else if(mode==mREG)
   		{
    		if((rel_in_st[0]==rOFF)||(comm_av_st==cast_ON2))
    			{
    			mode=mTORM;
    			}
    		} 
    		
	else if(mode==mFPAV)
   		{
  		if((rel_in_st[0]==rOFF)||(comm_av_st==cast_ON2))
  			{
  			mode=mTORM;
  			}
  		}
  		    		
	else if(mode==mTORM)
   		{             
   		if((!bPOTENZ_DOWN)&&(fp_stat==dvOFF))
   			{
   			mode=mSTOP;
   			}
   		}    		
    	}
else if (EE_MODE==emAVT) 
	{
	}  			
}

//-----------------------------------------------
void power_hndl (void)
{
if(EE_MODE==emAVT)
	{
	if(mode==mSTOP)
		{
		power=0;
		}
	else if(mode==mSTART)
		{
		if(++power_cnt>=(10*SS_TIME))
			{
			power_cnt=0;
		
			if((p_ust>p) && ((p_ust-p)>(SS_LEVEL*10)) )
				{
				if((p<=p_old) || ((p-p_old)<SS_STEP))
					{
					if((power%100)<fp_step_num)power++;
					else
						{
						if(bPOTENZ_UP)power=(((power/100)+1)*100)+1;
						else
							{
							//power--;
							mode=mREG;
    							pid_start();
							}
						}
					
					
				  /*	power++;
					if((&& bPOTENZ_UP)power=(((power/100)+1)*100)+1;
					else
						{
					
						} */
					} 
				}
			else 
				{
    				mode=mREG;
    				pid_start();
	 			}	
	  		p_old=p;
	   		}
		
   		}

	else if(mode==mREG)
    		{
   		if(bPOWER==1)
   			{
   			bPOWER=0;
   			power+=100;
   			} 
   		else if(bPOWER==-1)
   			{
   			bPOWER=0;
			power-=100;
   			}		
   		}

    	else if(mode==mTORM)
		{
		power=0;
		}
	
    	gran(&power,0,1000);
    	}	
     
else if(EE_MODE==emMNL)
	{
	}
}

//-----------------------------------------------
void fp_hndl (void)
{
if(main_cnt<10)
	{
	fp_stat=dvOFF;
	}
else if(EE_MODE==emMNL)
	{
	
	if(!power)
		{
		fp_stat=dvOFF;
		fp_poz=0;
		}        
	else 
		{
		if(!(power%100))
			{
			fp_stat=dvOFF;
			}             
		else fp_stat=dvON;	
		
		fp_poz=(0x4000/100)*(power%100);
		}	
	
	}
else if(EE_MODE==emAVT)
	{
	if(mode==mSTOP)
		{
		fp_stat=dvOFF;
		fp_poz=0;
		}
	else if(mode==mSTART)
		{
		fp_stat=dvON;
		fp_poz=(unsigned)((0x4000UL*(unsigned long)(((power%100)-1)*SS_FRIQ))/(FP_FMAX-FP_FMIN));
		} 

	else if(mode==mREG)
		{
		fp_stat=dvON;
		fp_poz=pid_poz;
		}

	else if(mode==mTORM)
		{
		if((bPOTENZ_DOWN)||(cnt_control_blok))fp_stat=dvON;
		else 
			{
			fp_stat=dvOFF;
			fp_poz=0;
			}
		}
		
	if((av_sens_p_stat==aspON)&&(EE_MODE==emAVT)&&(mode!=mSTOP)&&(mode!=mTORM))	
		{                
		signed long temp_SL;
		temp_SL=0x4000L*(signed long)FP_CH;
		temp_SL/=100L;
		fp_poz=(signed)temp_SL;
		gran(&fp_poz,0,16384);
		
		if(fp_poz)fp_stat=dvON;
		else fp_stat=dvOFF;
		} 
		
	if(av_fp_stat==afsON)fp_stat=dvOFF;			
	}	
}

//-----------------------------------------------
void p_kr_drv(void)
{
if(cnt_control_blok&&((p>(p_ust+(DVCH_P_KR*10)))||(p<(p_ust-(DVCH_P_KR*10)))))cnt_control_blok=0;
}

//-----------------------------------------------
void av_hh_drv(void)
{
if(1)
	{
	if(rel_in_st[3]==rOFF)
		{
		if(hh_av_cnt<(HH_TIME*10))
			{
			hh_av_cnt++;
			if(hh_av_cnt>=(HH_TIME*10))
				{
				hh_av=avON;
				av_hndl(AVAR_HH,0,0);
				}
			}               
		else hh_av_cnt=HH_TIME*10;	
		}                         
	else if(rel_in_st[3]==rON)
		{
		if(hh_av_cnt>0)
			{
			hh_av_cnt--;
			if(hh_av_cnt==0)
				{
				hh_av=avOFF;
				}
			}               
		else hh_av_cnt=0;	
		}     	
	}
	
}


//-----------------------------------------------
void av_fp_hndl(void)
{ 

if(dv_on[pilot_dv]==dvFR)
	{
if(rel_in_st[1]==rOFF)
	{
	if(av_fp_cnt<10)
		{
		av_fp_cnt++;
		if(av_fp_cnt>=10)
			{
			char i;
			fp_apv[pilot_dv]=faON;
			
			temp_fp=0;
			for(i=0;i<EE_DV_NUM;i++)
				{
				if(fp_apv[i]!=faON)temp_fp++;
				}                            
			
			if(temp_fp)
				{
				bDVCH=1;
				mode=mTORM;
				}	      
			else 
				{
				av_fp_stat=afsON; 
				av_hndl(AVAR_FP,0,0);
				mode=mTORM;
				}	
			} 
		}	              
	else av_fp_cnt=10;	
	}                         
else if(rel_in_st[1]==rON)
	{
	av_fp_cnt=0;	
	} 
	}
	
}
//-----------------------------------------------
void pid_drv(void)
{
signed long temp_SL;
if(!((EE_MODE==emAVT) && (mode==mREG) /*&& ()*/)) goto pid_drv_end;
            
if(++pid_cnt<PID_PERIOD)goto pid_drv_end;

if(cnt_control_blok)goto pid_drv_end;

pid_cnt=0;

e[2]=e[1];
e[1]=e[0];
e[0]=p_ust-p;
if(e[0]>50)e[0]=50;

temp_SL=0;
temp_SL=(((signed long)e[0])*((signed long)a0));
temp_SL+=(((signed long)e[1])*((signed long)a1)*((signed long)PID_K_P)/10L);
temp_SL+=(((signed long)e[2])*((signed long)a2)*((signed long)PID_K_D)/10L);
temp_SL*=((signed long)PID_K);
temp_SL/=5L;

u+=temp_SL;

if(u>=0x4000)
	{
	if(bPOTENZ_UP)
		{
		bPOWER=1;
		//u-=0x4000;
		u=0;
		pid_cnt=0;
		e[0]=0;
		e[1]=0;
		e[2]=0;
		}
	else 
		{
		bPOWER=0;
		u=0x4000;
		}	
	} 
	        
else if(u<0)
	{
 	if(bPOTENZ_DOWN)
		{         
		bPOWER=-1;
		u=(0x4000/100)*PID_K_FP_DOWN;
		pid_cnt=0;
		e[0]=0;
		e[1]=0;
		e[2]=0;
		}
	else 
		{
		bPOWER=0;
		u=0;
		}	
	}	  
else bPOWER=0;	

pid_poz=(signed int)u;

pid_drv_end:
}

//-----------------------------------------------
void time_sezon_drv (void)
{
char temp;
if((time_sezon!=tsWINTER)&&
	( 
	((_month<3)||(_month>10))
	||((_month==3) && (((_week_day==1)&&((_hour<1)||(_day<25))) || ((_week_day==2)&&(_day<26))  || ((_week_day==3)&&(_day<27)) || ((_week_day==4)&&(_day<28)) || ((_week_day==5)&&(_day<29)) || ((_week_day==6)&&(_day<30)) || ((_week_day==7)&&(_day<31))))
	||((_month==10) && (((_week_day==1)&&((_hour>=2)&&(_day>=25))) || ((_week_day==2)&&(_day>=26))  || ((_week_day==3)&&(_day>=27)) || ((_week_day==4)&&(_day>=28)) || ((_week_day==5)&&(_day>=29)) || ((_week_day==6)&&(_day>=30)) || ((_week_day==7)&&(_day>=31))))
     ))                     
	{
	time_sezon=tsWINTER;
	temp=read_ds14287(HOURS);
	if(!temp)
		{
		temp=23;
		write_ds14287(HOURS,temp); 
		
		temp=read_ds14287(DAY_OF_THE_MONTH);
		if(temp==1)
			{
			temp=DAY_MONTHS[_month-2];
			write_ds14287(DAY_OF_THE_MONTH,temp);
			
			temp=read_ds14287(MONTH);
			if(temp==1)
				{
				temp=12;
				write_ds14287(MONTH,temp);
				
				temp=read_ds14287(YEAR);
					{
					temp--;
					write_ds14287(YEAR,temp);
				     }
				}
			else 
				{
				temp--;
				write_ds14287(MONTH,temp);
				}
			}
		else
			{
			temp--;
			write_ds14287(DAY_OF_THE_MONTH,temp);
		     } 
		temp=read_ds14287(DAY_OF_THE_WEEK);
		if(temp==1)
			{
			temp=7;
			write_ds14287(DAY_OF_THE_WEEK,temp);
			}
		else
			{
			temp--;
			write_ds14287(DAY_OF_THE_WEEK,temp);
		     }		     
		} 
	else 
		{
		temp--;
		write_ds14287(HOURS,temp);
		}
	}  

if((time_sezon!=tsSUMMER)&&
	( 
	((_month>3)&&(_month<10))
	||((_month==10) && (((_week_day==1)&&((_hour<1)||(_day<25))) || ((_week_day==2)&&(_day<26))  || ((_week_day==3)&&(_day<27)) || ((_week_day==4)&&(_day<28)) || ((_week_day==5)&&(_day<29)) || ((_week_day==6)&&(_day<30)) || ((_week_day==7)&&(_day<31))))
	||((_month==3) && (((_week_day==1)&&((_hour>=2)&&(_day>=25))) || ((_week_day==2)&&(_day>=26))  || ((_week_day==3)&&(_day>=27)) || ((_week_day==4)&&(_day>=28)) || ((_week_day==5)&&(_day>=29)) || ((_week_day==6)&&(_day>=30)) || ((_week_day==7)&&(_day>=31))))
     ))                     
	{
	time_sezon=tsSUMMER;
/*	temp=read_ds14287(HOURS);
	if(temp==23)temp=0;
	else temp++;
	write_ds14287(HOURS,temp);*/
	
	temp=read_ds14287(HOURS);
	if(temp==23)
		{
		temp=0;
		write_ds14287(HOURS,temp); 
		
		temp=read_ds14287(DAY_OF_THE_MONTH);
		if(temp==DAY_MONTHS[_month-1])
			{
			temp=1;
			write_ds14287(DAY_OF_THE_MONTH,temp);
			
			temp=read_ds14287(MONTH);
			if(temp==12)
				{
				temp=1;
				write_ds14287(MONTH,temp);
				
				temp=read_ds14287(YEAR);
					{
					temp++;
					write_ds14287(YEAR,temp);
				     }
				}
			else 
				{
				temp++;
				write_ds14287(MONTH,temp);
				}
			}
		else
			{
			temp++;
			write_ds14287(DAY_OF_THE_MONTH,temp);
		     } 
		temp=read_ds14287(DAY_OF_THE_WEEK);
		if(temp==7)
			{
			temp=1;
			write_ds14287(DAY_OF_THE_WEEK,temp);
			}
		else
			{
			temp++;
			write_ds14287(DAY_OF_THE_WEEK,temp);
		     }		     
		} 
	else 
		{
		temp++;
		write_ds14287(HOURS,temp);
		}	
	
	}	
}

//-----------------------------------------------
void modbus_request_hndl (void)
{
if(read_parametr==204)
	{
	read_vlt_register(204,2);
	read_parametr=0;
	}
else if(read_parametr==205)
	{
	read_vlt_register(205,2);
	read_parametr=0;
	}
read_vlt_coil(33); 
read_vlt_register(518,1); 
read_vlt_register(520,2);
if(fp_stat!=dvON) write_vlt_coil(1,0x043c,0);
else write_vlt_coil(1,0x047c,fp_poz);
}

//-----------------------------------------------
void out_usart0 (char num,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7,char data8)
{
char i,t=0;

char UOB0[12]; 
UOB0[0]=data0;
UOB0[1]=data1;
UOB0[2]=data2;
UOB0[3]=data3;
UOB0[4]=data4;
UOB0[5]=data5;
UOB0[6]=data6;
UOB0[7]=data7;
UOB0[8]=data8;

for (i=0;i<num;i++)
	{
	putchar0(UOB0[i]);
	}   	
}

//-----------------------------------------------
void usart_out_adr0 (char *ptr, char len)
{

char UOB0[100];
char i,t=0;

/*for(i=0;i<len;i++)
	{
	UOB0[i]=ptr[i];
	}*/

for (i=0;i<len;i++)
	{
	putchar0(ptr[i]);
	}  
//	out_usart0(2,MEM_KF1,(char)TZAS,0,0,0,0,0,0,0);
}

//-----------------------------------------------
void p_ust_hndl (void)
{
signed long temp_SL;
if(P_UST_EE)
	{
	p_ust=P_UST_EE;
	mode_ust=0xff;
	}
else if(P_UST_EE==0)
	{
	char ___day;
	if(_week_day==1)___day=7;
	else ___day=_week_day-2; 
	day_period=0; 
	if((CURR_TIME>=timer_time1[___day,0])&&(CURR_TIME<timer_time2[___day,0]))day_period=0;
	else if((CURR_TIME>=timer_time1[___day,1])&&(CURR_TIME<timer_time2[___day,1]))day_period=1;
	else if((CURR_TIME>=timer_time1[___day,2])&&(CURR_TIME<timer_time2[___day,2]))day_period=2;
	else if((CURR_TIME>=timer_time1[___day,3])&&(CURR_TIME<timer_time2[___day,3]))day_period=3;
	else if((CURR_TIME>=timer_time1[___day,4])&&(CURR_TIME<timer_time2[___day,4]))day_period=4; 
	
	if(timer_mode[___day,day_period]==1)p_ust=timer_data1[___day,day_period];
	}

temp_SL=(signed long)p_ust;
temp_SL*=(100L+(signed long)FP_P_PL);
temp_SL/=100L;
p_ust_pl=(unsigned)temp_SL;

temp_SL=(signed long)p_ust;
temp_SL*=(100L-(signed long)FP_P_MI);
temp_SL/=100L;
p_ust_mi=(unsigned)temp_SL;
}

//-----------------------------------------------
char find(char xy)
{
char i=0;
do i++;
while ((lcd_buffer[i]!=xy)&&(i<LCD_SIZE));
if(i>(33)) i=255;
return i;
}

//-----------------------------------------------
void sub_bgnd(char flash *adr,char xy)
{
char temp;
temp=find(xy);

//ptr_ram=&lcd_buffer[find(xy)];
if(temp!=255)
while (*adr)
	{
	lcd_buffer[temp]=*adr++;
	temp++;
    	}
}

//-----------------------------------------------
void bin2bcd_int(unsigned int in)
{
char i=5;
for(i=0;i<5;i++)
	{
	dig[i]=in%10;
	in/=10;
	}   
}

//-----------------------------------------------
void bcd2lcd_zero(char sig)
{
char i;
zero_on=1;
for (i=5;i>0;i--)
	{
	if(zero_on&&(!dig[i-1])&&(i>sig))
		{
		dig[i-1]=0x20;
		}
	else
		{
		dig[i-1]=dig[i-1]+0x30;
		zero_on=0;
		}	
	}
}    

//-----------------------------------------------
void int2lcd_mm(signed int in,char xy,char des)
{
char i;
char n;
char minus='+';
if(in<0)
	{
	in=abs(in);
	minus='-';
	}
bin2bcd_int(in);
bcd2lcd_zero(des+1);
i=find(xy);
for (n=0;n<5;n++)
	{
   	if(!des&&(dig[n]!=' '))
   		{
   		if((dig[n+1]==' ')&&(minus=='-'))lcd_buffer[i-1]='-';
   		lcd_buffer[i]=dig[n];	 
   		}
   	else 
   		{
   		if(n<des)lcd_buffer[i]=dig[n];
   		else if (n==des)
   			{
   			lcd_buffer[i]='.';
   			lcd_buffer[i-1]=dig[n];
   			} 
   		else if ((n>des)&&(dig[n]!=' ')) lcd_buffer[i-1]=dig[n]; 
   		else if ((minus=='-')&&(n>des)&&(dig[n]!=' ')&&(dig[n+1]==' ')) lcd_buffer[i]='-';  		
   		}  
		
	i--;	
	}
}

//-----------------------------------------------
void int2lcdxy(unsigned int in,char xy,char des)
{
char i;
char n;
bin2bcd_int(in);
bcd2lcd_zero(des+1);
i=((xy&0b00000011)*16)+((xy&0b11110000)>>4);
if ((xy&0b00000011)>=2) i++;
if ((xy&0b00000011)==3) i++;
for (n=0;n<5;n++)
	{ 
	if(n<des)
		{
		lcd_buffer[i]=dig[n];
		}   
	if((n>=des)&&(dig[n]!=0x20))
		{
		if(!des)lcd_buffer[i]=dig[n];	
		else lcd_buffer[i-1]=dig[n];
   		}   
	i--;	
	}
}

//-----------------------------------------------
void int2lcd(unsigned int in,char xy,char des)
{
char i;
char n;

bin2bcd_int(in);
bcd2lcd_zero(des+1);
i=find(xy);
for (n=0;n<5;n++)
	{
   	if(!des&&(dig[n]!=' '))
   		{
   		lcd_buffer[i]=dig[n];	 
   		}
   	else 
   		{
   		if(n<des)lcd_buffer[i]=dig[n];
   		else if (n==des)
   			{
   			lcd_buffer[i]='.';
   			lcd_buffer[i-1]=dig[n];
   			} 
   		else if ((n>des)&&(dig[n]!=' ')) lcd_buffer[i-1]=dig[n];   		
   		}  
		
	i--;	
	}
}

//-----------------------------------------------
void char2lcdhxy(unsigned char in,char xy)
{
char i;
char n;
for(i=0;i<2;i++)
	{
	dig[i]=ABC[in%16];
	in/=16;
	}   
i=((xy&0b00000011)*16)+((xy&0b11110000)>>4);
if ((xy&0b00000011)>=2) i++;
if ((xy&0b00000011)==3) i++;
for (n=0;n<2;n++)
	{ 
	lcd_buffer[i]=dig[n];
	i--;	
	}
}
//-----------------------------------------------
void bgnd_par(char flash *ptr0,char flash *ptr1)
{
char i,*ptr_ram;
for (i=0;i<LCD_SIZE;i++)
	{
	lcd_buffer[i]=0x20;
	}
ptr_ram=lcd_buffer;
while (*ptr0)
	{
	*ptr_ram++=*ptr0++;
   	}
while (*ptr1)
	{
	*ptr_ram++=*ptr1++;
   	}
} 


//-----------------------------------------------
void ind_transmit_hndl(void)
{
static char tr_ind_delay,tr_ind_cnt;
            
if(tr_ind_delay)tr_ind_delay--;
if(!tr_ind_delay)
	{
	tr_ind_delay=10;
	tr_ind_cnt++;                 
	if(tr_ind_cnt>=4)tr_ind_cnt=0;
	//can_out_adr(0b11110000+tr_ind_cnt,0b00000000,&data_for_ind[10*tr_ind_cnt]);
	can_out_adr(0b11110000,0b00000000,&data_for_ind[0]);
	}

}

//-----------------------------------------
void t0_init(void)
{
TCCR0=0x04;
TCNT0=-125;
TIMSK|=0x01;
}                                                

//-----------------------------------------------
void set_kalibr_blok_drv(void)
{
DDRC.0=0;
PORTC.0=1;
#asm("nop")
#asm("nop")
#asm("nop")
if(PINC.0==1)
	{
	if(skb_cnt<10)skb_cnt++;
	}                       
else
	{
	if(skb_cnt)skb_cnt--;
	}
		
}


//-----------------------------------------------
void dv_pusk(char in)
{
//dv_on[in]=dvON;
}

//-----------------------------------------------
void dv_stop(char in)
{
//dv_on[in]=dvOFF;
}

//-----------------------------------------------
void control(void)
{

granee(&pilot_dv,0,EE_DV_NUM);
if(cnt_control_blok)cnt_control_blok--;


//dv_on[pilot_dv]=dvFR;


num_wrks_old=0;
if((dv_on[0]==dvSTAR)||(dv_on[0]==dvTRIAN)||(dv_on[0]==dvFULL)/*||((dv_on[0]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
if((dv_on[1]==dvSTAR)||(dv_on[1]==dvTRIAN)||(dv_on[1]==dvFULL)/*||((dv_on[1]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
if((dv_on[2]==dvSTAR)||(dv_on[2]==dvTRIAN)||(dv_on[2]==dvFULL)/*||((dv_on[2]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
if((dv_on[3]==dvSTAR)||(dv_on[3]==dvTRIAN)||(dv_on[3]==dvFULL)/*||((dv_on[3]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
if((dv_on[4]==dvSTAR)||(dv_on[4]==dvTRIAN)||(dv_on[4]==dvFULL)/*||((dv_on[4]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
if((dv_on[5]==dvSTAR)||(dv_on[5]==dvTRIAN)||(dv_on[5]==dvFULL)/*||((dv_on[5]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;


if((av_serv[0]==avsON)||//(av_temper[0]!=avtOFF)||
	(av_i_dv_min[0]!=aviOFF)||(av_i_dv_max[0]!=aviOFF)||(apv_cnt[0])||(av_i_dv_log[0]!=aviOFF))
	{
    	dv_on[0]=dvOFF;
	}

if((av_serv[1]==avsON)||//(av_temper[1]!=avtOFF)||
	(av_i_dv_min[1]!=aviOFF)||(av_i_dv_max[1]!=aviOFF)||(apv_cnt[1])||(av_i_dv_log[1]!=aviOFF)||(EE_DV_NUM<2))
	{
    	dv_on[1]=dvOFF;
	}

if((av_serv[2]==avsON)||//(av_temper[2]!=avtOFF)||
	(av_i_dv_min[2]!=aviOFF)||(av_i_dv_max[2]!=aviOFF)||(apv_cnt[2])||(av_i_dv_log[2]!=aviOFF)||(EE_DV_NUM<3))
	{
   	dv_on[2]=dvOFF;
	}

if((av_serv[3]==avsON)||//(av_temper[3]!=avtOFF)||
	(av_i_dv_min[3]!=aviOFF)||(av_i_dv_max[3]!=aviOFF)||(apv_cnt[3])||(av_i_dv_log[3]!=aviOFF)||(EE_DV_NUM<4))
	{
    	dv_on[3]=dvOFF;
	}
	
if((av_serv[4]==avsON)||//(av_temper[4]!=avtOFF)||
	(av_i_dv_min[4]!=aviOFF)||(av_i_dv_max[4]!=aviOFF)||(apv_cnt[4])||(av_i_dv_log[4]!=aviOFF)||(EE_DV_NUM<5))
	{
    	dv_on[4]=dvOFF;
	}

if((av_serv[5]==avsON)||//(av_temper[5]!=avtOFF)||
	(av_i_dv_min[5]!=aviOFF)||(av_i_dv_max[5]!=aviOFF)||(apv_cnt[5])||(av_i_dv_log[5]!=aviOFF)||(EE_DV_NUM<6))
	{
    	dv_on[5]=dvOFF;
	}


num_wrks_new=0;
if((dv_on[0]==dvSTAR)||(dv_on[0]==dvTRIAN)||(dv_on[0]==dvFULL))num_wrks_new++;
if((dv_on[1]==dvSTAR)||(dv_on[1]==dvTRIAN)||(dv_on[1]==dvFULL))num_wrks_new++;
if((dv_on[2]==dvSTAR)||(dv_on[2]==dvTRIAN)||(dv_on[2]==dvFULL))num_wrks_new++;
if((dv_on[3]==dvSTAR)||(dv_on[3]==dvTRIAN)||(dv_on[3]==dvFULL))num_wrks_new++;
if((dv_on[4]==dvSTAR)||(dv_on[4]==dvTRIAN)||(dv_on[4]==dvFULL))num_wrks_new++;
if((dv_on[5]==dvSTAR)||(dv_on[5]==dvTRIAN)||(dv_on[5]==dvFULL))num_wrks_new++;

if((main_cnt<=10)/*||(comm_av_st==cast_ON2)*/)
	{
	dv_on[0]=dvOFF;
	dv_on[1]=dvOFF;
	dv_on[2]=dvOFF;
	dv_on[3]=dvOFF;
	dv_on[4]=dvOFF;
	dv_on[5]=dvOFF;
	}
/*	
num_wrks_new_new=0;
if(dv_on[0]==dvON)num_wrks_new_new++;
if(dv_on[1]==dvON)num_wrks_new_new++;
if(dv_on[2]==dvON)num_wrks_new_new++;
if(dv_on[3]==dvON)num_wrks_new_new++;
if(dv_on[4]==dvON)num_wrks_new_new++;
if(dv_on[5]==dvON)num_wrks_new_new++;
*/
/*if((num_wrks_new_new==4)&&(num_wrks_old!=num_wrks_new_new))
	{
	if(EE_LOG==el_popl)
		{
		av_max_cnt=30;
		}
	else if(EE_LOG==el_420)
		{
		av_max_cnt=5;
		av_max_level=I420;
		}		
	} */
//	



if(EE_MODE==emMNL)
	{
	
	
	
	if((but_cnt[0]==100)&&(av_serv[0]!=avsON))
		{
		if(STAR_TRIAN==stON)dv_on[0]=dvFULL;
		else dv_on[0]=dvTRIAN;
		}	
     else dv_on[0]=dvOFF; 
     
	if((but_cnt[1]==100)&&(EE_DV_NUM>=2)&&(av_serv[1]!=avsON))
		{
		if(STAR_TRIAN==stON)dv_on[1]=dvFULL;
		else dv_on[1]=dvTRIAN;
		}
	else dv_on[1]=dvOFF; 
		
	if((but_cnt[2]==100)&&(EE_DV_NUM>=3)&&(av_serv[2]!=avsON))
		{
		if(STAR_TRIAN==stON)dv_on[2]=dvFULL;
		else dv_on[2]=dvTRIAN;
		}
	else dv_on[2]=dvOFF; 
	
	if((but_cnt[3]==100)&&(EE_DV_NUM>=4)&&(av_serv[3]!=avsON))
		{
		if(STAR_TRIAN==stON)dv_on[3]=dvFULL;
		else dv_on[3]=dvTRIAN;
		}
	else dv_on[3]=dvOFF;
	
	

/*	if(power)dv_on[pilot_dv]=dvFR;
		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
			{
			if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
     		else dv_on[potenz]=dvTRIAN;
     		cnt_control_blok=50;
			}
    		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
			{
    	    		dv_on[potenz_off]=dvOFF;
			cnt_control_blok=50;
			}*/
				   	
	}
else if(EE_MODE==emAVT)
	{
	if((mode==mSTOP)||(main_cnt<10))
		{
		fp_stat=dvOFF;
		dv_on[0]=dvOFF;
		dv_on[1]=dvOFF;
		dv_on[2]=dvOFF;
		dv_on[3]=dvOFF;
		dv_on[4]=dvOFF;
		dv_on[5]=dvOFF;
		}
	else if(mode==mSTART)
		{
		
		if((power)&&(av_fp_stat!=afsON))dv_on[pilot_dv]=dvFR;

		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
			{
		 	if(potenz<EE_DV_NUM)
				{
				if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
     				else dv_on[potenz]=dvTRIAN;
     				cnt_control_blok=50;
     				}
			}
    		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
			{
    	    		dv_on[potenz_off]=dvOFF;
			cnt_control_blok=50;
			}  
		
		//dv_on[2]=dvTRIAN;
   		} 
 
	else if(mode==mFPAV)
		{
		
		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
			{
		 	if(potenz<EE_DV_NUM)
				{
				if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
     			else dv_on[potenz]=dvTRIAN;
     			cnt_control_blok=50;
     			}
			}
    		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
			{
    	    		dv_on[potenz_off]=dvOFF;
			cnt_control_blok=50;
			}
   		}   		
   		
	else if(mode==mREG)
		{
		
		if((power)&&(av_fp_stat!=afsON))dv_on[pilot_dv]=dvFR;

		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
			{
			if(potenz<EE_DV_NUM)
				{
				if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
     				else dv_on[potenz]=dvTRIAN;
     				cnt_control_blok=50;
     				}
			}
    		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
			{
    	    		dv_on[potenz_off]=dvOFF;
			cnt_control_blok=50;
			}
   		}   	
   		
	else if(mode==mTORM)
		{
		
		if(((power)&&(av_fp_stat!=afsON)))dv_on[pilot_dv]=dvFR;

		if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
			{
    	    		dv_on[potenz_off]=dvOFF;
			cnt_control_blok=20;
			}
   		}   	   			
	}
//else if(EE_MODE==emMNL)
//dv_on[0]=dvTRIAN;


}

//-----------------------------------------------
void plata_ex_hndl(void)
{
data_for_ex[0,2]=dv_on[0];
data_for_ex[0,3]=dv_on[0];
data_for_ex[0,4]=dv_on[0];
data_for_ex[0,5]=dv_on[0];

data_for_ex[0,6]=dv_on[1];
data_for_ex[0,7]=dv_on[1];
data_for_ex[0,8]=dv_on[1];
data_for_ex[0,9]=dv_on[1];

data_for_ex[1,2]=dv_on[2];
data_for_ex[1,3]=dv_on[2];
data_for_ex[1,4]=dv_on[2];
data_for_ex[1,5]=dv_on[2]; 

data_for_ex[1,6]=dv_on[3];
data_for_ex[1,7]=dv_on[3];
data_for_ex[1,8]=dv_on[3];
data_for_ex[1,9]=dv_on[3];
}

//-----------------------------------------------
void serv_drv(void)
{         
char i;
for(i=0;i<EE_DV_NUM;i++)
	{
	if(av_serv[i]==avsON)
		{
		//av_vl[i]=avvOFF;
		//av_temper[i]=avtOFF;
	    //	av_upp[i]=avuOFF;
		av_i_dv_min[i]=aviOFF;
		av_i_dv_max[i]=aviOFF;
		//av_i_dv_per[i]=aviOFF; 
		av_i_dv_not[i]=aviOFF;
		av_id_min_cnt[i]=0;
		av_id_max_cnt[i]=0;
		//av_id_max_cnt[i]=0;
		av_id_not_cnt[i]=0;
		apv_cnt[i]=0;
		apv[i]=apvOFF;
		fp_apv[i]=faOFF;
		if(i==pilot_dv) 
			{
			bDVCH=1;
			mode=mTORM;
			}
		}
	}
}

//-----------------------------------------------
void num_necc_drv(void)
{
fp_step_num=(((FP_FMAX-FP_FMIN)-1)/SS_FRIQ)+2;
/*
if(power==0)
	{
	fp_stat=dvOFF;
	fp_power=0;
	num_necc=0;
	}
else if(power<=fp_step_num)
	{
	fp_stat=dvON;
	fp_power=power-1;
	num_necc=0;
	}          
else if(power>fp_step_num) 
	{
	fp_stat=dvON;
	fp_power=(power-1)%fp_step_num;
	num_necc=(power-1)/fp_step_num;
	} */  

if((EE_MODE==emAVT)&&(mode!=mFPAV))
	{	
	if(power<100)num_necc=0;
	else num_necc=power/100;	
     }

if((av_sens_p_stat==aspON)&&(EE_MODE==emAVT)&&(mode!=mSTOP)&&(mode!=mTORM))	num_necc=C1N;
else if((av_fp_stat==afsON)&&(EE_MODE==emAVT)&&(mode==mFPAV))
	{  
	if((p<p_ust_mi)&&(!cnt_control_blok)) num_necc++;
	else if((p>p_ust_pl)&&(!cnt_control_blok))num_necc--;
	gran_char(&num_necc,0,EE_DV_NUM);
	}	
}

//-----------------------------------------------
void rel_in_drv(void)
{                
char i,temp;
DDRA&=0b00001111; 
 
for(i=0;i<4;i++)
	{
	temp=0;
 	if((PINA&(1<<(7-i))))temp=1;
	if(((PORTG&0b00000100)&&(temp))||(!(PORTG&0b00000100)&&(!temp)))
		{
		popl_cnt_p[i]++;
		popl_cnt_m[i]-=2; 
		}
	else if((!(PORTG&0b00000100)&&(temp))||((PORTG&0b00000100)&&(!temp)))
		{
		popl_cnt_m[i]++;
		popl_cnt_p[i]-=2; 
		}  
	gran_char(&popl_cnt_p[i],0,10);
	gran_char(&popl_cnt_m[i],0,10);	
	
	if(popl_cnt_p[i]>=10) rel_in_st[i]=rON;
	else if(popl_cnt_p[i]<=0) rel_in_st[i]=rOFF;
	}
	 
DDRG|=0b00000100;
if(PING&0b00000100)PORTG&=0b11111011;
else PORTG|=0b00000100; 

DDRA|=0b11110000;
PORTA&=0b00001111;
}

//-----------------------------------------------
void t2_init(void)
{
// Timer/Counter 2 initialization
// Clock source: System Clock
// Clock value: 250,000 kHz
// Mode: Normal top=FFh
// OC2 output: Disconnected
ASSR=0x00;
TCCR2=0x03;
TCNT2=-62;
OCR2=0x00;
TIMSK|=0x40;
}

//-----------------------------------------------
void out_hndl(void)
{
#define OUT_AV		4
#define OUT_COOL	1
#define OUT_WARM	0



if(cool_st==cool_ON)out_stat|=(1<<OUT_COOL);
else out_stat&=~(1<<OUT_COOL);

if(warm_st==warm_ON)out_stat|=(1<<OUT_WARM);
else out_stat&=~(1<<OUT_WARM);

if((comm_av_st==cast_ON1)||(comm_av_st==cast_ON2)||(main_cnt<10))out_stat&=~(1<<OUT_AV);
else out_stat|=(1<<OUT_AV);
}

//-----------------------------------------------
void out_drv(void)
{
DDRD|=0b00010011;
DDRG|=0b00001000;

if((comm_av_st==cast_ON1)||(comm_av_st==cast_ON2)||(main_cnt<10)) PORTD.4=0;
else PORTD.4=1;

if((main_cnt<10)) PORTD.1=0;
else PORTD.1=1;
 
if(cool_st==cool_ON)PORTD.0=1;
else PORTD.0=0;

if(warm_st==warm_ON)PORTG|=(1<<3);
else PORTG&=~(1<<3);
                  
}



//-----------------------------------------------
void ds14287_drv(void)
{
_sec=read_ds14287(SECONDS); 
_min=read_ds14287(MINUTES);
_hour=read_ds14287(HOURS);
_day=read_ds14287(DAY_OF_THE_MONTH);
_month=read_ds14287(MONTH);
_year=read_ds14287(YEAR);
_week_day=read_ds14287(DAY_OF_THE_WEEK);
}



//-----------------------------------------------
void resurs_drv(void)
{
char i;

for(i=0;i<6;i++)
	{
	
	if(dv_on[i]!=dvOFF)
		{
		resurs_cnt_[i]++;
		if(resurs_cnt_[i]>=RESURS_CNT_SEC_IN_HOUR)
			{
			resurs_cnt_[i]=0;
		     RESURS_CNT[i]++;
		    	}
		}
	resurs_cnt__[i]=((unsigned long)RESURS_CNT[i]*RESURS_CNT_SEC_IN_HOUR)+(unsigned long)resurs_cnt_[i];
	}
}

//-----------------------------------------------
void motor_potenz_hndl(void)
{
char i,temp_potenz;
i=0;
potenz=0xff;

if((EE_DV_NUM>=1)&&((pilot_dv!=0)||(av_fp_stat==faON))&&(dv_on[0]==dvOFF)&&(av_serv[0]==avsOFF)&&(apv_cnt[0]==0)&&(dv_access[0]==dvON))
	{
	potenz=0;
	}

if((EE_DV_NUM>=2)&&((pilot_dv!=1)||(av_fp_stat==faON))&&(dv_on[1]==dvOFF)&&(av_serv[1]==avsOFF)&&(apv_cnt[1]==0)&&(dv_access[1]==dvON)) 
	{
	if((potenz==0xff)||(resurs_cnt__[1]<resurs_cnt__[potenz]))potenz=1;
	}

if((EE_DV_NUM>=3)&&((pilot_dv!=2)||(av_fp_stat==faON))&&(dv_on[2]==dvOFF)&&(av_serv[2]==avsOFF)&&(apv_cnt[2]==0)&&(dv_access[2]==dvON))
	{
	if((potenz==0xff)||(resurs_cnt__[2]<resurs_cnt__[potenz]))potenz=2;
	}

if((EE_DV_NUM>=4)&&((pilot_dv!=3)||(av_fp_stat==faON))&&(dv_on[3]==dvOFF)&&(av_serv[3]==avsOFF)&&(apv_cnt[3]==0)&&(dv_access[3]==dvON))
	{
	if((potenz==0xff)||(resurs_cnt__[3]<resurs_cnt__[potenz]))potenz=3;
	}

if((EE_DV_NUM>=5)&&((pilot_dv!=4)||(av_fp_stat==faON))&&(dv_on[4]==dvOFF)&&(av_serv[4]==avsOFF)&&(apv_cnt[4]==0)&&(dv_access[4]==dvON))
    	{
	if((potenz==0xff)||(resurs_cnt__[4]<resurs_cnt__[potenz]))potenz=4;
	}
	
if((EE_DV_NUM>=6)&&((pilot_dv!=5)||(av_fp_stat==faON))&&(dv_on[5]==dvOFF)&&(av_serv[5]==avsOFF)&&(apv_cnt[5]==0)&&(dv_access[5]==dvON))
    	{
	if((potenz==0xff)||(resurs_cnt__[4]<resurs_cnt__[potenz]))potenz=5;
	}


potenz_off=0xff;

if((dv_on[0]!=dvOFF)&&(dv_on[0]!=dvFR))
	{
	potenz_off=0;
	}

if((dv_on[1]!=dvOFF)&&(dv_on[1]!=dvFR))
	{             
	if((potenz_off==0xff)||(resurs_cnt__[1]>resurs_cnt__[potenz_off]))potenz_off=1;
	}

if((dv_on[2]!=dvOFF)&&(dv_on[2]!=dvFR))
	{             
	if((potenz_off==0xff)||(resurs_cnt__[2]>resurs_cnt__[potenz_off]))potenz_off=2;
	}

if((dv_on[3]!=dvOFF)&&(dv_on[3]!=dvFR))
	{             
	if((potenz_off==0xff)||(resurs_cnt__[3]>resurs_cnt__[potenz_off]))potenz_off=3;
	}
                                                                                   
if((dv_on[4]!=dvOFF)&&(dv_on[4]!=dvFR))
	{             
	if((potenz_off==0xff)||(resurs_cnt__[4]>resurs_cnt__[potenz_off]))potenz_off=4;
	}
	
if((dv_on[5]!=dvOFF)&&(dv_on[5]!=dvFR))
	{             
	if((potenz_off==0xff)||(resurs_cnt__[5]>resurs_cnt__[potenz_off]))potenz_off=5;
	}
	
temp_potenz=0;	
for(i=0;i<EE_DV_NUM;i++)
	{
	if((i<EE_DV_NUM)&&(av_serv[i]!=avsON)&&
	   (av_i_dv_min[i]!=aviON) && (av_i_dv_max[i]!=aviON) && (av_i_dv_log[i]!=aviON) && ((pilot_dv!=i) || (av_fp_stat==faON))) 
		{          
		temp_potenz++;
		}
	}	             
net_motor_potenz=temp_potenz;

temp_potenz=0;
for(i=0;i<EE_DV_NUM;i++)
	{
	if((av_serv[i]!=avsON) && (av_i_dv_min[i]!=aviON) && (av_i_dv_max[i]!=aviON) && (av_i_dv_log[i]!=aviON) 
	 && (dv_on[i]!=dvOFF) && (dv_on[i]!=dvFR)) 
		{          
		temp_potenz++;
		}
	} 
net_motor_wrk=temp_potenz;

if(net_motor_potenz>net_motor_wrk)bPOTENZ_UP=1;
else bPOTENZ_UP=0;

if(net_motor_wrk)bPOTENZ_DOWN=1;
else bPOTENZ_DOWN=0;		 
		
}

//-----------------------------------------------
void dv_access_hndl(void)
{
char i;
for(i=0;i<6;i++)
	{
	if((i<EE_DV_NUM)&&(dv_on[i]==dvOFF)&&(av_serv[i]!=avsON)&&
	   (av_i_dv_min[i]!=aviON) && (av_i_dv_max[i]!=aviON) && (av_i_dv_log[i]!=aviON)) 
	   	{
	   	dv_access[i]=dvON;
	   	}
	else dv_access[i]=dvOFF;
	}
}

//-----------------------------------------------
void pilot_ch_hndl(void)
{
char i;

CURR_TIME=((unsigned)_hour*60U)+(unsigned)_min;
if((CURR_TIME==DVCH_TIME)&&((_sec==0)||(_sec==1)||(_sec==2)))
      	{
      	bDVCH=1;
      	mode=mTORM;
      	}
	
if(bDVCH&&(mode==mSTOP))
	{
//char temp;
	dv_access_hndl();
	temp_DVCH=0xff;
	
	if((dv_access[0]==dvON)&&(fp_apv[0]!=faON)&&(pilot_dv!=0))temp_DVCH=0;
	
	if((dv_access[1]==dvON)&&(fp_apv[1]!=faON)&&(pilot_dv!=1)&&((temp_DVCH==0xff)||(resurs_cnt__[1]<resurs_cnt__[temp_DVCH])))temp_DVCH=1;
	if((dv_access[2]==dvON)&&(fp_apv[2]!=faON)&&(pilot_dv!=2)&&((temp_DVCH==0xff)||(resurs_cnt__[2]<resurs_cnt__[temp_DVCH])))temp_DVCH=2;
	if((dv_access[3]==dvON)&&(fp_apv[3]!=faON)&&(pilot_dv!=3)&&((temp_DVCH==0xff)||(resurs_cnt__[3]<resurs_cnt__[temp_DVCH])))temp_DVCH=3;
	if((dv_access[4]==dvON)&&(fp_apv[4]!=faON)&&(pilot_dv!=4)&&((temp_DVCH==0xff)||(resurs_cnt__[4]<resurs_cnt__[temp_DVCH])))temp_DVCH=4;
	if((dv_access[5]==dvON)&&(fp_apv[5]!=faON)&&(pilot_dv!=5)&&((temp_DVCH==0xff)||(resurs_cnt__[5]<resurs_cnt__[temp_DVCH])))temp_DVCH=5;
	
	if(temp_DVCH<EE_DV_NUM)
		{
		pilot_dv=temp_DVCH;
		av_fp_cnt=0;
		}
	bDVCH=0; 
	
    //	mode=mSTART;
	
	}	
}

//-----------------------------------------------
void p_max_min_hndl(void)
{             
static signed avp_sec_cnt;
if((mode==mSTOP)||(mode==mTORM))bPMIN=0;
else if(p>((P_MIN+G_MAXMIN)*10))bPMIN=1;

if(p>(P_MAX*10))
	{         
	if(p_max_cnt<(T_MAXMIN*10))
		{
		p_max_cnt++;
		if(p_max_cnt>=(T_MAXMIN*10))
			{
			//av_hndl(AVAR_P_MAX,0,0);
			av_p_stat=avpMAX;
			avp_day_cnt[3]=avp_day_cnt[2];
			avp_day_cnt[2]=avp_day_cnt[1];
			avp_day_cnt[1]=avp_day_cnt[0];
			avp_day_cnt[0]=1440;
			
			if(avp_day_cnt[3])av_hndl(AVAR_P_MAX,p/10,0);
			}
		}
	}
else if(p<((P_MAX-G_MAXMIN)*10))
	{
	if(p_max_cnt)p_max_cnt--;
	}	

if((p<(P_MIN*10))&&bPMIN)
	{         
	if(p_min_cnt<(T_MAXMIN*10))
		{
		p_min_cnt++;
		if(p_min_cnt>=(T_MAXMIN*10))
			{
			av_hndl(AVAR_P_MIN,p/10,0);
			av_p_stat=avpMIN;
			
			}
		}
	}                 
	
else if(p>((P_MIN+G_MAXMIN)*10))
	{
	if(p_min_cnt)p_min_cnt--;
	}
	
		                 
if((!p_max_cnt)&&(!p_min_cnt))av_p_stat=avpOFF;		

avp_sec_cnt++;
if(avp_sec_cnt>=600)
	{
	avp_sec_cnt=0;

	if(avp_day_cnt[3])
		{
		avp_day_cnt[3]--;
		}
	if(avp_day_cnt[2])
		{
		avp_day_cnt[2]--;
		}
	if(avp_day_cnt[1])
		{
		avp_day_cnt[1]--;
		}
	if(avp_day_cnt[0])
		{
		avp_day_cnt[0]--;
		}				
	}


}

//-----------------------------------------------
void cool_warm_drv(void)
{ 
signed temper;

if((((adc_bank_[2]<100)||(adc_bank_[2]>800))))
	{
	warm_st=warm_AVSENS;
	}
else 
	{
	if(TEMPER_SIGN==0)temper=t[0];
	else temper=t[1];

	if(temper<T_ON_WARM)
		{
		t_on_warm_cnt++;
		}               
	else if(temper>(T_ON_WARM+TEMPER_GIST))
		{
		t_on_warm_cnt--;
		}
	gran_char(&t_on_warm_cnt,0,50);
	if(t_on_warm_cnt>45) warm_st=warm_ON;
	else if(t_on_warm_cnt<5) warm_st=warm_OFF;	
     }
     
if((((adc_bank_[2]<100)||(adc_bank_[2]>800))))
	{
	cool_st=cool_AVSENS;
	}
else 
	{
     if(TEMPER_SIGN==0)temper=t[0];
	else temper=t[1];

	if(temper>T_ON_COOL)
		{
		t_on_cool_cnt++;
		}               
	else if(temper<T_ON_COOL-TEMPER_GIST)
		{
		t_on_cool_cnt--;
		}
	gran_char(&t_on_cool_cnt,0,50);
	if(t_on_cool_cnt>45) cool_st=cool_ON;
	else if(t_on_cool_cnt<5) cool_st=cool_OFF;
	}
}	

//-----------------------------------------------
void apv_start(char in)
{
av_id_min_cnt[in]=0;
av_i_dv_min[in]=aviOFF;
av_id_max_cnt[in]=0;
av_i_dv_max[in]=aviOFF;
av_id_not_cnt[in]=0;
av_i_dv_not[in]=aviOFF;
}
//-----------------------------------------------
void avar_i_drv(void)
{
char i;
signed temp_SI,temp_SI1;
signed Ia,Ic;

if(DV_AV_SET==dasLOG)
	{
	for(i=0;i<EE_DV_NUM;i++)
		{
		if(av_upp[i]==avuON)av_i_dv_log[i]=aviON;
		else av_i_dv_log[i]=aviOFF;
		
		if((av_i_dv_log[i]==aviON)&&(av_i_dv_log_old[i]!=aviON))av_hndl(AVAR_I_LOG+32+(32*i),temp_SI,temp_SI1);
		av_i_dv_log_old[i]=av_i_dv_log[i];
		}   
	}
else
{
av_i_dv_log[0]=aviOFF;
av_i_dv_log[1]=aviOFF;
av_i_dv_log[2]=aviOFF;
av_i_dv_log[3]=aviOFF;

for(i=0;i<EE_DV_NUM;i++)
	{   
	if(apv_cnt[i])
		{
		apv_cnt[i]--; 
		if(!apv_cnt[i])
			{
		       //	apv_start(i);
		       //	av_id_not_cnt[i]=0;
			}  
	  	}
	
	if(dv_on[i]!=dvOFF)
		{

		Ia=Ida[i];
		Ic=Idc[i];
		//Аварии по занижению токов
		if(((Ia<Idmin)||(Ic<Idmin))&&(!apv_cnt[i])&&(!cnt_av_i_not_wrk[i]))
			{
			if(av_id_min_cnt[i]<10)                    
				{
				av_id_min_cnt[i]++;
				if((av_id_min_cnt[i]>=10)&&(av_serv[i]!=avsON)&&(main_cnt>10))
					{                                   
				 	if(apv[i]==apvON)
						{
				       		av_i_dv_min[i]=aviON;
						temp_SI=Ia;
						temp_SI1=0;
						if(Ic<Ia)
							{
							temp_SI=Ic;
							temp_SI1=1;
							}
						av_hndl(AVAR_I_MIN+32+(32*i),temp_SI,temp_SI1);


						}
					else
						{
						apv[i]=apvON;
						apv_cnt[i]=50;
						plazma_i[i]=11;
						av_id_min_cnt[i]=0;
						av_i_dv_min[i]=aviOFF;
						av_id_max_cnt[i]=0;
						av_i_dv_max[i]=aviOFF;
						av_id_not_cnt[i]=0;
						av_i_dv_not[i]=aviOFF;
						}	
					}
				}
			}
		else if((Ia>=Idmin)&&(Ic>=Idmin))
			{
			if(av_id_min_cnt[i])
				{
				av_id_min_cnt[i]--;
				if(av_id_min_cnt[i]<=0)
					{
					av_i_dv_min[i]=aviOFF;
					}
				}			
			} 	
		//Аварии по превышению токов
		if(((Ia>Idmax)||(Ic>Idmax))&&(!apv_cnt[i])&&(!cnt_av_i_not_wrk[i]))
			{
			if(av_id_max_cnt[i]<10)
				{
				av_id_max_cnt[i]++;
				if((av_id_max_cnt[i]>=10)&&(av_serv[i]!=avsON)&&(main_cnt>10))
					{
					if(apv[i]==apvON)
						{
						temp_SI=Ia;
						temp_SI1=0;
						if(Ic>Ia)
							{
							temp_SI=Ic;
							temp_SI1=1;
							}
						av_i_dv_max[i]=aviON;
						av_hndl(AVAR_I_MAX+32+(32*i),temp_SI,temp_SI1);
						}
					else
						{
						apv[i]=apvON;
						apv_cnt[i]=50;
						plazma_i[i]=22;
						}						
					}
				}
			}
		else if((Ia<Idmax)&&(Ic<Idmax))
			{
			if(av_id_max_cnt[i])
				{
				av_id_max_cnt[i]--;
				if(av_id_max_cnt[i]<=0)
					{
					av_i_dv_max[i]=aviOFF;
					}
				}			
			} 	
		//Аварии по перкосу токов
/*		temp_SI=Ia-Ic;
		temp_SI=abs(temp_SI);
		temp_SI1=Ia;
		if(Ic>temp_SI1)temp_SI1=Ic;
		temp_SI=(temp_SI*100)/temp_SI1;
		if((temp_SI>20)&&(!apv_cnt[i])&&(!cnt_av_i_not_wrk[i]))
			{
			if(av_id_per_cnt[i]<10)
				{
				av_id_per_cnt[i]++;
				if((av_id_per_cnt[i]>=10)&&(av_serv[i]!=avsON)&&(main_cnt>10))
					{
					if(apv[i]==apvON)
						{
						av_i_dv_per[i]=aviON;
						if(i==0)av_hndl(AV_I_PER_0,0,0);
						if(i==1)av_hndl(AV_I_PER_1,0,0);
						if(i==2)av_hndl(AV_I_PER_2,0,0);
						if(i==3)av_hndl(AV_I_PER_3,0,0);
						if(i==4)av_hndl(AV_I_PER_4,0,0);
						if(i==5)av_hndl(AV_I_PER_5,0,0);
						}
					else
						{
						apv[i]=apvON;
						apv_cnt[i]=50;
						plazma_i[i]=33;
						}						
					}
				}
			}
		else if(temp_SI<20)
			{
			if(av_id_per_cnt[i])
				{
				av_id_per_cnt[i]--;
				if(av_id_per_cnt[i]<=0)
					{
					av_i_dv_per[i]=aviOFF;
					}
				}			
			} */				
		}		
	}
	

for(i=0;i<6;i++)
	{
	if((dv_on[i]==dvOFF)||(apv_cnt[i]))cnt_av_i_not_wrk[i]=20;
	else if(cnt_av_i_not_wrk[i])cnt_av_i_not_wrk[i]--;
	} 
	
for(i=0;i<6;i++)
	{
	if((dv_on[i]!=dvOFF)&&(!apv_cnt[i])&&(av_id_min_cnt[i]<2)/*&&(av_id_per_cnt[i]<2)&&(av_id_per_cnt[i]<2)*/)
		{
	     if(av_id_not_cnt[i]<50)
	     	{
	     	av_id_not_cnt[i]++;
	     	if(av_id_not_cnt[i]>=50)
	     		{
	     		apv_cnt[i]=0;
	     		apv[i]=apvOFF;
	     		plazma_i[i]=44;
	     		}
	     	}
	     }    
	else av_id_not_cnt[i]=0;     
	}  

}
				
}


//-----------------------------------------------
void avar_drv(void)
{

char i;
signed temp_S,temp_S1;
char temp;

if((((adc_bank_[2]<100)||(adc_bank_[2]>800))))
	{
	av_temper_st=av_temper_AVSENS;
	}
else 
	{
	if(TEMPER_SIGN==0)temp_S=t[0];
	else temp_S=t[1];
	}	

if(temp_S<AV_TEMPER_COOL)
	{
	if(av_temper_cool_cnt<50)
		{
		av_temper_cool_cnt++;
		if((av_temper_cool_cnt==50)&&(main_cnt>10))
			{
			av_temper_st=av_temper_COOL;
			av_hndl(AVAR_COOL,0,temp_S);
			}
		}
	
	}
else if(temp_S>(AV_TEMPER_COOL+TEMPER_GIST))
	{
	if(av_temper_cool_cnt)
		{
		av_temper_cool_cnt--;
		if((av_temper_cool_cnt==0)&&(av_temper_heat_cnt==0))
			{
			av_temper_st=av_temper_NORM;
			}
		}
	} 

if(temp_S>AV_TEMPER_HEAT)
	{
	if(av_temper_heat_cnt<50)
		{
		av_temper_heat_cnt++;
		if((av_temper_heat_cnt==50)&&(main_cnt>10))
			{
			av_temper_st=av_temper_HEAT;
			av_hndl(AVAR_HEAT,0,temp_S);
			}
		}
	
	}
else if(temp_S<(AV_TEMPER_HEAT-TEMPER_GIST))
	{
	if(av_temper_heat_cnt)
		{
		av_temper_heat_cnt--;
		if((av_temper_heat_cnt==0)&&(av_temper_cool_cnt==0))
			{
			av_temper_st=av_temper_NORM;
			}
		}
	} 

temp_S=220-((220*AV_NET_PERCENT)/100);
temp_S1=220+((220*AV_NET_PERCENT)/100);


if(cher_cnt>45)
	{
	if(net_fase!=nfABC)net_fase=nfABC;
	}
else if(cher_cnt<5)
	{
	if(net_fase!=nfACB)net_fase=nfACB;
	} 
	
if(((fasing==f_ABC)&&(net_fase==nfACB))||((fasing==f_ACB)&&(net_fase==nfABC)))
	{
	if(av_st_unet_cher!=asuc_AV)
		{
		av_st_unet_cher=asuc_AV;
		av_hndl(AVAR_CHER,0,0);
		}
	}
else if(((fasing==f_ABC)&&(net_fase==nfABC))||((fasing==f_ACB)&&(net_fase==nfACB)))
	{
	av_st_unet_cher=asuc_NORM;
	}	

for(i=0;i<3;i++)
	{
	if((unet[i]<temp_S)&&(main_cnt>10))
		{
		if(unet_min_cnt[i]<5)
			{
			unet_min_cnt[i]++;
			if((unet_min_cnt[i]==5)&&(main_cnt>10))
				{
				unet_st[i]=unet_st_MIN;
				if(i==0)av_hndl(AVAR_UNET,0,0);
				else if(i==1)av_hndl(AVAR_UNET,1,0);
				else if(i==2)av_hndl(AVAR_UNET,2,0);
				}
		     }
		}
	else 
		{
		if(unet_min_cnt[i])
			{
			unet_min_cnt[i]--;
		     }
		}     			

	if((unet[i]>temp_S1)&&(main_cnt>10))
		{
		if(unet_max_cnt[i]<5)
			{
			unet_max_cnt[i]++;
			if((unet_max_cnt[i]==5)&&(main_cnt>10))
				{
				unet_st[i]=unet_st_MAX;
				if(i==0)av_hndl(AVAR_UNET,0,1);
				else if(i==1)av_hndl(AVAR_UNET,1,1);
				else if(i==2)av_hndl(AVAR_UNET,2,1);				
				}
		     }
		}
	else 
		{
		if(unet_max_cnt[i])
			{
			unet_max_cnt[i]--;
		     }
		}
	if((unet_max_cnt[i]==0)&&(unet_min_cnt[i]==0))unet_st[i]=unet_st_NORM;	  
     }
/*
if((adc_bank_[13]<100)||(adc_bank_[13]>800))t_air_st[0]=tAVSENS;
else if(t[0]<T_AV_MIN[0])t_air_st[0]=tCOOL;
else if((t[0]>=(T_AV_MIN[0]+5))&&(t[0]<=(T_AV_MAX[0]-5)))t_air_st[0]=tNORM;
else if(t[0]>T_AV_MAX[0])t_air_st[0]=tHEAT;

if(t[0]>=T_ON_COOL[0])cool_st[0]=cool_ON;
else if(t[0]<=(T_ON_COOL[0]-5))cool_st[0]=cool_OFF; 
                                                
if(t[0]<=T_ON_HEAT[0])heat_st[0]=heat_ON;
else if(t[0]>(T_ON_HEAT[0]+5))heat_st[0]=heat_OFF;

if(((unet[0]>UNET_MIN)&&(unet[0]<UNET_MAX))&&((unet[1]>UNET_MIN)&&(unet[1]<UNET_MAX))&&((unet[1]>UNET_MIN)&&(unet[1]<UNET_MAX)))
	{
	if(unet_avar_cnt)unet_avar_cnt--;
	}
else
	{
	if(unet_avar_cnt<10) unet_avar_cnt++;
	}

gran_char(&unet_avar_cnt,0,10);            

if(unet_avar_cnt>=10)av_st_unet=asu_ON;
else if(unet_avar_cnt<=0) av_st_unet=asu_OFF;

for(i=0;i<4;i++)
	{
	if(log_in_ch_cnt[PTR_IN_UPP[i]]>=50) av_upp[i]=avuON;
	else if(log_in_ch_cnt[PTR_IN_UPP[i]]<=0) av_upp[i]=avuOFF;

	if(log_in_ch_cnt[PTR_IN_SERV[i]]>=20) av_serv[i]=avsON;
	else if(log_in_ch_cnt[PTR_IN_SERV[i]]<=0) av_serv[i]=avsOFF;

	temp_S=adc_bank_[PTR_IN_TEMPER[i]];
	if(temp_S>680)
		{
		cnt_avtHH[i]++;
		cnt_avtKZ[i]=0;
		cnt_avtON[i]=0;
		cnt_avtOFF[i]=0;
		gran_char(&cnt_avtHH[i],0,50);
		if(cnt_avtHH[i]>=50) av_temper[i]=avtHH;
		}
	else if(temp_S<15)
		{
		cnt_avtHH[i]=0;
		cnt_avtKZ[i]++;
		cnt_avtON[i]=0;
		cnt_avtOFF[i]=0;
		gran_char(&cnt_avtKZ[i],0,50);
		if(cnt_avtKZ[i]>=50) av_temper[i]=avtKZ;
		}
	else if(temp_S>195)
		{
		cnt_avtHH[i]=0;
		cnt_avtKZ[i]=0;
		cnt_avtON[i]++;
		cnt_avtOFF[i]=0;
		gran_char(&cnt_avtON[i],0,50);
		if(cnt_avtON[i]>=50) av_temper[i]=avtON;
		}
	else if(temp_S<145)
		{
		cnt_avtHH[i]=0;
		cnt_avtKZ[i]=0;
		cnt_avtON[i]=0;
		cnt_avtOFF[i]++;
		gran_char(&cnt_avtOFF[i],0,50);
		if(cnt_avtOFF[i]>=50) av_temper[i]=avtOFF;
		}
	
	temp_S=adc_bank_[PTR_IN_VL[i]];
	if(temp_S>680)
		{
		cnt_avvHH[i]++;
		cnt_avvKZ[i]=0;
		cnt_avvON[i]=0;
		cnt_avvOFF[i]=0;
		gran_char(&cnt_avvHH[i],0,50);
		if(cnt_avvHH[i]>=50) av_vl[i]=avvHH;
		}
	else if(temp_S<20)
		{
		cnt_avvHH[i]=0;
		cnt_avvKZ[i]++;
		cnt_avvON[i]=0;
		cnt_avvOFF[i]=0;
		gran_char(&cnt_avvKZ[i],0,50);
		if(cnt_avvKZ[i]>=50) av_vl[i]=avvKZ;
		}
	else if(temp_S<510)
		{
		cnt_avvHH[i]=0;
		cnt_avvKZ[i]=0;
		cnt_avvON[i]++;
		cnt_avvOFF[i]=0;
		gran_char(&cnt_avvON[i],0,50);
		if(cnt_avvON[i]>=50) av_vl[i]=avvON;
		}
	} 
	 */

if(main_cnt<10)comm_av_st=cast_OFF;
else
	{
	if((unet_st[0]!=unet_st_NORM)||(unet_st[1]!=unet_st_NORM)||(unet_st[2]!=unet_st_NORM)||(av_st_unet_cher!=asuc_NORM)
	||(av_temper_st!=av_temper_NORM)||(hh_av==avON) || ((av_p_stat==avpMAX)&&(av_sens_p_stat!=aspON)))
		{
		comm_av_st=cast_ON2;
		}
	else if(((EE_DV_NUM>=1)&&(av_serv[0]==avsOFF)&&((av_i_dv_min[0]!=aviOFF)||(av_i_dv_max[0]!=aviOFF)||(av_i_dv_log[0]!=aviON))) 
		||((EE_DV_NUM>=2)&&(av_serv[1]==avsOFF)&&((av_i_dv_min[1]!=aviOFF)||(av_i_dv_max[1]!=aviOFF)||(av_i_dv_log[1]!=aviON)))
		||((EE_DV_NUM>=3)&&(av_serv[2]==avsOFF)&&((av_i_dv_min[2]!=aviOFF)||(av_i_dv_max[2]!=aviOFF)||(av_i_dv_log[2]!=aviON)))
		||((EE_DV_NUM>=4)&&(av_serv[3]==avsOFF)&&((av_i_dv_min[3]!=aviOFF)||(av_i_dv_max[3]!=aviOFF)||(av_i_dv_log[3]!=aviON)))
	   /*	||((EE_DV_NUM>=5)&&(av_serv[4]==avsOFF)&&((av_i_dv_min[4]!=aviOFF)||(av_i_dv_max[4]!=aviOFF)||(av_i_dv_per[4]!=aviOFF)))
		||((EE_DV_NUM>=6)&&(av_serv[5]==avsOFF)&&((av_i_dv_min[5]!=aviOFF)||(av_i_dv_max[5]!=aviOFF)||(av_i_dv_per[5]!=aviOFF))) */ 
		|| (av_p_stat==avpMIN)
		|| (av_sens_p_stat==aspON)
		
		)
		{
		comm_av_st=cast_ON1;
		}	
	else comm_av_st=cast_OFF;
	}	

}

//-----------------------------------------------
void matemat(void)
{
signed long temp_SL;
signed temp_s;
char j,i;



//adc_bank_[12] - датчик 4-20
//adc_bank_[13] - датчик т-ры воздуха(внешний)
//adc_bank_[14] - датчик т-ры воздуха(внутренний) 


granee(&Kun[0],300,500);
granee(&Kun[1],300,500);
granee(&Kun[2],300,500);

temp_SL=unet_bank_[0]*200L;
temp_SL/=(signed long)Kun[0];
unet[0]=(unsigned)temp_SL;
temp_SL=unet_bank_[1]*200L;
temp_SL/=(signed long)Kun[1];
unet[1]=(unsigned)temp_SL;
temp_SL=unet_bank_[2]*200L;
temp_SL/=(signed long)Kun[2];
unet[2]=(unsigned)temp_SL;

temp_SL=adc_bank_[0];
height_level_p=(signed)temp_SL;

temp_SL=((adc_bank_[2]*(unsigned long)Kt[0])/1024UL)-273UL;
t[0]=(signed)temp_SL;
temper_result=t[0];


temp_SL=adc_bank_[3]-Kp0;
if(temp_SL<0)temp_SL=0;
temp_SL*=(unsigned long)Kp1;
p_bank[p_bank_cnt]=temp_SL;

if(++p_bank_cnt>=16)p_bank_cnt=0;
temp_SL=0;
for(i=0;i<16;i++)
	{
	temp_SL+=p_bank[i];
	}                  
p=(signed)(temp_SL/1600);	

if(dv_on[2]!=dvFR)
	{ 
	temp_SL=curr_ch_buff_[0];
	if(temp_SL<10)temp_SL=0;
	Ida[2]=(temp_SL*(signed long)Kida[2])/10000; 
	
 	temp_SL=curr_ch_buff_[1];
	if(temp_SL<10)temp_SL=0;		
	Idc[2]=(temp_SL*(signed long)Kidc[2])/10000;
	  		
	Id[2]=(Ida[2]+Idc[2])/2;
	}	

if(dv_on[3]!=dvFR)
	{    
	temp_SL=curr_ch_buff_[2];
	if(temp_SL<10)temp_SL=0;
	Ida[3]=(temp_SL*(signed long)Kida[3])/10000;
	
	temp_SL=curr_ch_buff_[3];
	if(temp_SL<10)temp_SL=0;
	Idc[3]=(temp_SL*(signed long)Kidc[3])/10000;
                 
     Id[3]=(Ida[3]+Idc[3])/2;
     } 

temp_SL=0;
for(j=0;j<EE_DV_NUM;j++)
	{
	temp_SL+=Id[j];
	}
comm_curr=(unsigned)temp_SL;
}

//-----------------------------------------------
char ind_fl(char in1,char in2)
{
lcd_buffer[32]=in1;
lcd_buffer[33]=in2;
} 
//-----------------------------------------------
char spi_p(char in)
{
char temp,i;
temp=in;
for(i=0;i<8;i++)
	{
	if(temp&0x80)
		{
		PORTB.2=1;
		}      
	else PORTB.2=0;
	temp<<=1;
	PORTB.1=1;
	//delay_us(1);
	if(PINB.3) temp|=0x01;
	else temp&=0xFE;
	PORTB.1=0;
	//delay_us(1);

	}
//delay_us(1);

return temp;
}


//-----------------------------------------------
void adc_drv(void)
{ 
unsigned self_adcw,temp_UI;
char temp;


             
self_adcw=ADCW;

if(adc_cnt_main<4)
	{
	if(self_adcw<self_min)self_min=self_adcw; 
	if(self_adcw>self_max)self_max=self_adcw;
	
	self_cnt++;
	if(self_cnt>=30)
		{
		curr_ch_buff[adc_cnt_main,adc_cnt_main1[adc_cnt_main]]=self_max-self_min;
/*		if(adc_cnt_main==0)
			{
			plazma_int[0]=self_max;
			plazma_int[1]=self_min;
			}*/
		
		adc_cnt_main1[adc_cnt_main]++;
		if(adc_cnt_main1[adc_cnt_main]>=16)adc_cnt_main1[adc_cnt_main]=0;
		adc_cnt_main++;
		if(adc_cnt_main<4)
			{
			//curr_buff=0;
			self_cnt=0;
		    //	self_cnt_zero_for=0;
			//self_cnt_not_zero=0;
			//self_cnt_zero_after=0;
			self_min=1023;
			self_max=0;			
			} 			
 
						
	 	}
	}
else if((adc_cnt_main>=4)&&(adc_cnt_main<=7))
	{
	adc_bank[adc_cnt_main-4,adc_ch_cnt]=self_adcw;
	
	adc_cnt_main++;
	if(adc_cnt_main==8)
		{
		adc_ch_cnt++;
		if(adc_ch_cnt>=16)
			{
			adc_ch_cnt=0;
			}
		}
	
	}

else if(adc_cnt_main==8)
	{
	adc_cnt_main=9;
	self_cnt=0;
	self_min=1023;
	self_max=0;
	}
else if(adc_cnt_main==9)
	{
	adc_cnt_main=0;
	self_cnt=0;
	self_min=1023;
	self_max=0;
	}
	
if(adc_cnt_main<4)
	{	
	ADCSRA=0x86;
	SFIOR&=0x0F;
	SFIOR|=0x10;
	ADMUX=0b01000100+adc_cnt_main;
	ADCSRA|=0x40;		 	  		
	}
else if((adc_cnt_main>=4)&&(adc_cnt_main<=7))
	{		
	ADCSRA=0x86;
	SFIOR&=0x0F;
	SFIOR|=0x10;
	ADMUX=0b01000000+(adc_cnt_main&0b11111011);
	ADCSRA|=0x40;	
     }
		     

} 

//-----------------------------------------------
void adc_mat_hndl(void)
{
char i1,i2;
unsigned int temp;

for(i1=0;i1<4;i1++)
	{  
	temp=0;
	for(i2=0;i2<16;i2++)
		{
		temp+=curr_ch_buff[i1,i2];
		}
	curr_ch_buff_[i1]=temp>>1;
	
	}	

for(i1=0;i1<4;i1++)
	{
	temp=0;
	for(i2=0;i2<16;i2++)
		{
		temp+=adc_bank[i1][i2];
		}
	adc_bank_[i1]=temp>>4;
	} 

}

//-----------------------------------------------
void ind_hndl(void)
{
#define speed	lcd_buffer[34]
signed int temp;
flash char* ptrs[11];
char temp_;

speed=0;

ind_fl(0xff,0xff);

if(ind==iAv_sel)
     {
     p1=ptr_last_av;
     p1-=index_set;
     p1--;
     if(p1<0)p1+=20;
     p2=p1+1;
     if(p2>19)p2-=20; 
     
     ptrs[0]=" !  0@:0# 0$0%0<";
     if(av_code[p2]==0xff)ptrs[0]=" Аварий нет     "; 
     
     ptrs[1]=" ^  0&:0* 0(0)0>";
     if(av_code[p1]==0xff)ptrs[1]=" Аварий нет     ";     
     
	if(sub_ind<index_set) index_set=sub_ind;
	else if((sub_ind-index_set)>1) index_set=sub_ind-1;
	
 	bgnd_par(ptrs[0],ptrs[1]);
    	
	if((sub_ind-index_set)==0) lcd_buffer[0]=1; 
	else if((sub_ind-index_set)==1) lcd_buffer[16]=1; 
  
     sub_bgnd(sm_av[av_code[p2]],'!');
     int2lcd(av_hour[p2]&0x1f,'@',0);
    	int2lcd(av_min[p2],'#',0);
     int2lcd(av_day[p2],'$',0);
     int2lcd(av_month[p2],'%',0);
     int2lcd(av_year[p2],'<',0);
        	
     sub_bgnd(sm_av[av_code[p1]],'^');
     int2lcd(av_hour[p1]&0x1f,'&',0);
	int2lcd(av_min[p1],'*',0);
     int2lcd(av_day[p1],'(',0);
     int2lcd(av_month[p1],')',0);
     int2lcd(av_year[p1],'>',0);

//int2lcdxy(ptr_last_av,0x21,0);
//int2lcdxy(level,0x01,0);	     
     }	

else if(ind==iDeb)
	{
	if(sub_ind==0)  
	{
	bgnd_par(sm_,sm_); 
	//int2lcdxy(cher_cnt,0x30,0);
//	int2lcdxy(plazma,0x30,0);
//	int2lcdxy(plazma_int[0],0x31,0);
//	int2lcdxy(plazma_int[1],0x81,0); 
	//int2lcdxy(av_level_sensor_cnt,0x30,0);
	//char2lcdhxy(av_ls_stat,0x31);
 //    int2lcdxy(not_wrk_cnt,0xf0,0);
 //    int2lcdxy(bLEVEL0,0xf1,0);
 //    int2lcdxy(not_wrk,0xc0,0);
 //    int2lcdxy(not_wrk_old,0xc1,0);
 //    int2lcdxy(wrk_cnt,0x80,0);
     //int2lcdxy(adc_bank_[6],0xc1,0);
      //    int2lcdxy(adc_bank_[7],0xc0,0);
     //int2lcdxy(adc_bank_[6],0xc1,0);
     /*char2lcdhxy(level_on[0],0x10);
     char2lcdhxy(level_on[1],0x40);
     char2lcdhxy(level_on[2],0x70);
     char2lcdhxy(level_on[3],0xa0);
     char2lcdhxy(level_on[4],0xd0); 
     char2lcdhxy(level_cnt[0],0x11);
     char2lcdhxy(level_cnt[1],0x41);
     char2lcdhxy(level_cnt[2],0x71);*/
     	//char2lcdhxy(apv[0],0x10);
     	//char2lcdhxy(apv[1],0x11);
     	 
    /* 	int2lcdxy(popl_cnt_p[0],0x20,0);
 	int2lcdxy(popl_cnt_m[0],0x21,0);
 	int2lcdxy(popl_cnt_p[1],0x50,0);
 	int2lcdxy(popl_cnt_m[1],0x51,0);
 	int2lcdxy(popl_cnt_p[2],0x80,0);
 	int2lcdxy(popl_cnt_m[2],0x81,0);
 	int2lcdxy(popl_cnt_p[3],0xb0,0);
 	int2lcdxy(popl_cnt_m[3],0xb1,0);  */
 	
       //	int2lcdxy(Idc[0],0x80,0);
 	//int2lcdxy(Idc[1],0x81,0); 	     	
    // 	int2lcdxy(apv_cnt[0],0xc0,0);
    //	int2lcdxy(apv_cnt[1],0xc1,0);
        /* 	char2lcdhxy(rel_in_st[0],0x20);
         	char2lcdhxy(rel_in_st[1],0x60);
         	char2lcdhxy(rel_in_st[2],0xa0);
         	char2lcdhxy(rel_in_st[3],0xe0);
       	char2lcdhxy(hh_av,0xe1);*/ 
       
 /*    char2lcdhxy(UIB0[0],0x10); 
     char2lcdhxy(UIB0[1],0x30);
     char2lcdhxy(UIB0[2],0x50);
     char2lcdhxy(UIB0[3],0x70);
     char2lcdhxy(UIB0[4],0x90);
     char2lcdhxy(UIB0[5],0xb0);
     char2lcdhxy(UIB0[6],0xd0);
     char2lcdhxy(UIB0[7],0xf0);
     char2lcdhxy(UIB0[8],0x11);
     char2lcdhxy(UIB0[9],0x31);
     char2lcdhxy(UIB0[10],0x51);
     char2lcdhxy(UIB0[11],0x71);
     char2lcdhxy(UIB0[12],0x91);
     char2lcdhxy(UIB0[13],0xb1);
     //char2lcdhxy(UIB0[14],0xd1); 
     int2lcdxy(UIB0_CNT,0xd1,0);*/
/*     int2lcdxy(bMODBUS_FREE,0xf0,0);
     int2lcdxy(modbus_cnt,0xf1,0);
     int2lcdxy(repeat_transmission_cnt,0x51,0);	 
     int2lcdxy(modbus_out_ptr_wr,0x20,0);
     int2lcdxy(modbus_out_ptr_rd,0x21,0);*/
     
    //
    //int2lcdxy(but_cnt[3],0x21,0);
    /*	char2lcdhxy(av_upp[0],0x50);
     char2lcdhxy(av_upp[1],0x80);
     char2lcdhxy(av_upp[2],0xb0);
     char2lcdhxy(av_upp[3],0xe0);*/
     
     
    char2lcdhxy(dv_on[0],0x20);
     char2lcdhxy(dv_on[1],0x50);
     char2lcdhxy(dv_on[2],0x80); 
     char2lcdhxy(dv_on[3],0xc0);
     /* char2lcdhxy(av_fp_stat,0xb0);
     char2lcdhxy(pilot_dv,0xc0);*/
     
    /* char2lcdhxy(dv_on[3],0xb0);
     char2lcdhxy(dv_on[4],0xe0); */ 
     
     //int2lcdxy(fr_stat,0x40,0);   
     //int2lcdxy(p_ust,0x51,0);
     //int2lcdxy(power,0x21,0);
      //int2lcdxy(plazma,0xf1,0);
     
     //char2lcdhxy(warm_st,0x20);
     //char2lcdhxy(av_temper_st,0x21);
     //
     /*
     int2lcdxy(fp_power,0x61,0);
     
     int2lcdxy(potenz,0xe0,0);
     int2lcdxy(potenz_off,0xe1,0);*/

    /* int2lcdxy(FP_FMAX,0x60,0);
     int2lcdxy(FP_FMIN,0x61,0);*/ 
   //  int2lcdxy(bPOTENZ_UP,0x50,0); 
   //  int2lcdxy(bPOTENZ_DOWN,0x70,0);
   //  int2lcdxy(p,0x30,0);
     //int2lcdxy(p_ust,0x31,0);
     //int2lcdxy(potenz,0x31,0);
   /*  char2lcdhxy(dv_on[0],0x60);
     char2lcdhxy(dv_on[1],0x80);
      */
     //char2lcdhxy(comm_av_st,0x31);   
   //  int2lcdxy(num_necc,0x51,0);
    // int2lcdxy(net_motor_potenz,0x71,0);
    // int2lcdxy(net_motor_wrk,0x91,0);
   //  int2lcdxy(cnt_control_blok,0xa0,0);
    // char2lcdhxy(mode,0xf1);
    
    // int2lcdxy(power,0xc1,0);
    // int2lcdxy(fp_poz,0xf0,0);
     //int2lcdxy(__fp_fcurr,0xa1,1);  
     }           
     
	else if(sub_ind==1)  
	{
	bgnd_par(sm_,sm_); 

/*     char2lcdhxy(data_for_ex[0,2],0x10);
    char2lcdhxy(data_for_ex[0,3],0x30);
     char2lcdhxy(data_for_ex[0,4],0x50);
     char2lcdhxy(data_for_ex[0,5],0x70);
     
     char2lcdhxy(data_for_ex[0,6],0x90);
     char2lcdhxy(data_for_ex[0,7],0xb0);
     char2lcdhxy(data_for_ex[0,8],0xd0);
      char2lcdhxy(data_for_ex[0,9],0xf0);

    char2lcdhxy(data_for_ex[1,2],0x11);
     char2lcdhxy(data_for_ex[1,3],0x31);
     char2lcdhxy(data_for_ex[1,4],0x51);
     char2lcdhxy(data_for_ex[1,5],0x71);
     
     char2lcdhxy(data_for_ex[1,6],0x91);
     char2lcdhxy(data_for_ex[1,7],0xb1);
     char2lcdhxy(data_for_ex[1,8],0xd1);
       
  /*                                        
     char2lcdhxy(temp_DVCH,0x80);
     char2lcdhxy(mode,0x81);                                     
     int2lcdxy(CURR_TIME,0xf0,0);
     int2lcdxy(DVCH_TIME,0xf1,0);
     int2lcdxy(bDVCH,0x20,0); 
     int2lcdxy(pilot_dv,0x21,0);  
     */
    
    //char2lcdhxy(av_p_stat,0x81); 
 /*   int2lcdxy(p_max_cnt,0xf0,0); 
    int2lcdxy(p_min_cnt,0xf1,0);
    int2lcdxy(bPMIN,0x20,0); 
    int2lcdxy(plazma_plazma,0x71,0); 
    
    int2lcdxy(Id[0],0x40,0); 
    int2lcdxy(Id[1],0x70,0);
    int2lcdxy(Id[2],0xa0,0);*/
    
    int2lcdxy(av_id_min_cnt[0],0x20,0); 
    // int2lcdxy(av_id_min_cnt[1],0x50,0);
     // int2lcdxy(av_id_min_cnt[2],0x80,0);
     
     int2lcdxy(Idmin,0x21,0); 
     int2lcdxy(Ida[0],0x51,0); 
     int2lcdxy(Idc[0],0x81,0);
     int2lcdxy(apv_cnt[0],0x50,0);
     int2lcdxy(cnt_av_i_not_wrk[0],0x80,0); 
     int2lcdxy(num_necc,0xf0,0); 
     int2lcdxy(potenz,0xf1,0); 
     
      char2lcdhxy(apv[0],0xd0);                           
     }     

	
		else if(sub_ind==2)  
	{
	bgnd_par(sm_,sm_); 


    
/*    int2lcdxy(av_id_min_cnt[2],0x20,0); 
    // int2lcdxy(av_id_min_cnt[1],0x50,0);
     // int2lcdxy(av_id_min_cnt[2],0x80,0);
     
     int2lcdxy(Idmin,0x21,0); 
     int2lcdxy(Ida[2],0x51,0); 
     int2lcdxy(Idc[2],0x81,0);
     int2lcdxy(apv_cnt[2],0x50,0);
     int2lcdxy(cnt_av_i_not_wrk[2],0x80,0); 
     int2lcdxy(num_necc,0xf0,0); 
     int2lcdxy(potenz,0xf1,0);
	char2lcdhxy(apv[2],0xd0);  */   
	
/*	char2lcdhxy(dv_access[0],0x20);
	char2lcdhxy(dv_access[1],0x50);
	char2lcdhxy(dv_access[2],0x80);	 */
	                          
     /*char2lcdhxy(rel_in_st[1],0x30);
     int2lcdxy(av_fp_cnt,0x31,0);
     int2lcdxy(temp_fp,0x61,0);*/
     
     //int2lcdxy(bDVCH,0x81,0);	   
     
 //    char2lcdhxy(fp_apv[0],0x60);   
 //     char2lcdhxy(fp_apv[1],0x90); 
  //     char2lcdhxy(fp_apv[2],0xc0); 
     
  /*	int2lcdxy(p,0x20,0);
  	int2lcdxy(p_ust,0x60,0); 
  	int2lcdxy(day_period,0xa0,0); 
  	int2lcdxy(p_ust_pl,0xf0,0);
  	
  	int2lcdxy(num_necc,0x21,0);
  	int2lcdxy(num_wrks_new,0x51,0);
  	int2lcdxy(cnt_control_blok,0x81,0);
  	int2lcdxy(potenz,0xf1,0); 
  	int2lcdxy(pilot_dv,0xa1,0); */
 	
  	int2lcdxy(123,0x20,0)  ;   
  	
  	int2lcdxy(cnt_control_blok,0x21,0)  ; 
  	int2lcdxy(p,0xf0,0);
  	int2lcdxy(p_ust,0xf1,0); 
  	int2lcdxy(DVCH_P_KR,0x81,0); 
          
     }     
	
	}    
	
/*
*#define AVAR_LEVEL	0x01
#define AVAR_UNET	0x04
#define AVAR_CHER	0x06
#define AVAR_HEAT	0x07
#define AVAR_COOL	0x08
#define AVAR_PERELIV 0x05
#define AVAR_POPL 	0x0b

#define AV_I_MIN_0	0x19
#define AV_I_MAX_0	0x12
#define AV_I_PER_0	0x1c
#define AV_HIDRO_0 	0x1a
#define AV_TERMO_0 	0x13
#define AV_PP_0	0x10

#define AV_I_MIN_1	0x29
#define AV_I_MAX_1	0x22
#define AV_I_PER_1	0x2c
#define AV_HIDRO_1 	0x2a
#define AV_TERMO_1 	0x23
#define AV_PP_1	0x20

#define AV_I_MIN_2	0x39
#define AV_I_MAX_2	0x32
#define AV_I_PER_2	0x3c 
#define AV_HIDRO_2 	0x3a
#define AV_TERMO_2 	0x33
#define AV_PP_2	0x30

#define AV_I_MIN_3	0x49
#define AV_I_MAX_3	0x42
#define AV_I_PER_3	0x4c
#define AV_HIDRO_3 	0x4a
#define AV_TERMO_3 	0x43
#define AV_PP_3	0x40

#define AV_I_MIN_4	0x59
#define AV_I_MAX_4	0x52
#define AV_I_PER_4	0x5c 
#define AV_HIDRO_4 	0x5a
#define AV_TERMO_4 	0x53
#define AV_PP_4	0x50

#define AV_I_MIN_5	0x69 
#define AV_I_MAX_5	0x62 
#define AV_I_PER_5	0x6c 
#define AV_HIDRO_5 	0x6a
#define AV_TERMO_5 	0x63
#define AV_PP_5	0x60
*/


else if(ind==iAv)
	{
	ptrs[0]=sm_;
	ptrs[1]=sm_;
	ptrs[2]="0@:0#:0$ 0%  &0^";
	
	if(av_code[sub_ind1]==AVAR_START)
		{
		ptrs[0]="     Станция    ";
		ptrs[1]="    включена    ";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		}
	else if(av_code[sub_ind1]==AVAR_FP)
		{
		ptrs[0]="Авария частотн. ";
		ptrs[1]="преобразователя ";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		}
		

	else if(av_code[sub_ind1]==AVAR_UNET)
		{
		ptrs[0]="   Напряжение   ";
		if(av_data0[sub_ind1]==0x00)
			{
			if(av_data1[sub_ind1]==0x00)ptrs[1]=" фазы A занижено";
			if(av_data1[sub_ind1]==0x01)ptrs[1]=" фазы A завышено";
			}
		else if(av_data0[sub_ind1]==0x01)
			{
			if(av_data1[sub_ind1]==0x00)ptrs[1]=" фазы B занижено";
			if(av_data1[sub_ind1]==0x01)ptrs[1]=" фазы B завышено";
			}
		else if(av_data0[sub_ind1]==0x02)
			{
			if(av_data1[sub_ind1]==0x00)ptrs[1]=" фазы C занижено";
			if(av_data1[sub_ind1]==0x01)ptrs[1]=" фазы C завышено";
			} 
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);		
		} 

	else if(av_code[sub_ind1]==AVAR_CHER) //чередование
		{
		ptrs[0]="  Неправильное  ";
		ptrs[1]=" чередование фаз";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		} 

	else if(av_code[sub_ind1]==AVAR_HEAT) //горячо
		{
		ptrs[0]="  Температура   ";
		ptrs[1]=" завышена    gC ";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		int2lcd(av_data1[sub_ind1],'@',0);
		lcd_buffer[find('g')]=2;
		} 
		
	else if(av_code[sub_ind1]==AVAR_COOL) //холодно
		{
		ptrs[0]="  Температура   ";
		ptrs[1]=" занижена    gC ";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		int2lcd(av_data1[sub_ind1],'@',0);
		lcd_buffer[find('g')]=2;
		}	
		

	else if(av_code[sub_ind1]==0x0a) //сухой ход
		{
		
		ptrs[0]="    Авария!!!   ";
		ptrs[1]="    Сухой ход   ";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		} 
	
  	else if(av_code[sub_ind1]==AVAR_P_SENS)
		{
		ptrs[0]=" Авария датчика ";
		ptrs[1]="давления     @мА";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]); 
		int2lcd(av_data0[sub_ind1],'@',1);
		}       
		
  	else if(av_code[sub_ind1]==AVAR_P_MIN)
		{
		ptrs[0]="    Давление    ";
		ptrs[1]="занижено   @атм.";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]); 
		int2lcd(av_data0[sub_ind1],'@',1);
		}    
		
  	else if(av_code[sub_ind1]==AVAR_P_MAX)
		{
		ptrs[0]="    Давление    ";
		ptrs[1]="завышено   @атм.";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]); 
		int2lcd(av_data0[sub_ind1],'@',1);
		}    				

	else if((av_code[sub_ind1]&0x1f)==AVAR_I_MIN)//недогруз насоса
		{
		ptrs[0]=" Двигатель N&   ";
		ptrs[1]="ток занижен   @А";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		int2lcd(av_data0[sub_ind1],'@',1);
		}  

	else if((av_code[sub_ind1]&0x1f)==AVAR_I_MAX)//превышение тока
		{
		ptrs[0]=" Двигатель N&   ";
		ptrs[1]="ток завышен   @А";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		int2lcd(av_data0[sub_ind1],'@',1);
		}  

	else if((av_code[sub_ind1]&0x1f)==AVAR_I_LOG)//тепловушка
		{
		ptrs[0]=" Двигатель N&   ";
		ptrs[1]="сработала защита";
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		int2lcd(av_data0[sub_ind1],'@',1);
		}  
		
/*	else if((av_code[sub_ind1]==0x13)||(av_code[sub_ind1]==0x23))//перегрев
		{
		ptrs[0]=" Двигатель N!   ";
		ptrs[1]=sm416;
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		}   */
/*	else if((av_code[sub_ind1]==0x1c)||(av_code[sub_ind1]==0x2c))//перекос токов
		{
		ptrs[0]=" Двигатель N!   ";
		ptrs[1]=sm415;
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		}*/ 						

	   /*		else if((av_code[sub_ind1]==0x1a)||(av_code[sub_ind1]==0x2a))//влажность
		{
		ptrs[0]=" Двигатель N!   ";
		ptrs[1]=sm417;
		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
		} */
	

		       
		
				
	int2lcd(av_code[sub_ind1]>>5,'&',0);
	if(index_set==1)
		{
		int2lcd(av_hour[sub_ind1],'@',0);
		int2lcd(av_min[sub_ind1],'#',0);
		int2lcd(av_sec[sub_ind1],'$',0);
		int2lcd(av_day[sub_ind1],'%',0);
		int2lcd(av_year[sub_ind1],'^',0);
		 	
		lcd_buffer[27]=sm_mont[av_month[sub_ind1]-1,0];
		lcd_buffer[28]=sm_mont[av_month[sub_ind1]-1,1];
		lcd_buffer[29]=sm_mont[av_month[sub_ind1]-1,2];
	     }
	}

else if(ind==iSet)
     {
     if(sub_ind==0)
     	{  
     	if(EE_MODE==emAVT)ptrs[0]=" Режим   автомат";
     	else if(EE_MODE==emMNL)ptrs[0]=" Режим   ручной ";
		else ptrs[0]=" Режим      тест";
		ptrs[1]="                ";
		bgnd_par(ptrs[0],ptrs[1]);
     	}
     else if(sub_ind==1)
     	{ 
     	ptrs[0]=" Время и дата   ";
		ptrs[1]="0@:0#:0$ 0%  &0^";
		bgnd_par(ptrs[0],ptrs[1]);
		
		int2lcd(_hour,'@',0);
		int2lcd(_min,'#',0);
		int2lcd(_sec,'$',0);
		int2lcd(_day,'%',0);
		int2lcd(_year,'^',0);
	
 		lcd_buffer[27]=sm_mont[_month-1,0];
		lcd_buffer[28]=sm_mont[_month-1,1];
		lcd_buffer[29]=sm_mont[_month-1,2];
     	}	
     else if(sub_ind==2)
     	{
   	
     	if(TEMPER_SIGN==0)ptrs[0]="Климат   внутр. ";
 		else ptrs[0]="Климат   внешн. ";     	
     	ptrs[1]="0!.0@(0#.$)0%.0^";
		bgnd_par(ptrs[0],ptrs[1]);
		int2lcd(AV_TEMPER_COOL,'!',0);
		int2lcd(T_ON_WARM,'@',0);
		int2lcd(temper_result,'#',0);
		int2lcd(TEMPER_GIST,'$',0);
		int2lcd(T_ON_COOL,'%',0);
		int2lcd(AV_TEMPER_HEAT,'^',0);
     	}
     	
     else if(sub_ind==3)
     	{     
     	if(fasing==f_ABC)ptrs[0]=" Cеть   ABC     "; 
		else ptrs[0]=" Cеть   ACB     ";
		ptrs[1]="  !   @   #   $%";
		bgnd_par(ptrs[0],ptrs[1]);
		int2lcd(unet[0],'!',0);
		int2lcd(unet[1],'@',0);
		int2lcd(unet[2],'#',0);
		int2lcd(AV_NET_PERCENT,'$',0);
		}
		
     else if(sub_ind==4)
     	{     
		bgnd_par(" Давление  !    ","@/  #(  $)/%    ");
     	int2lcd(P_SENS,'!',0);
		int2lcd(P_MIN/10,'@',0);
		int2lcd(P_MAX/10,'%',0);
		int2lcd(p/10,'$',1);
		}		

     else if(sub_ind==5)
     	{ 
     	bgnd_par(" Насосов !  @  #","$(  %)(  &) >   ");  
          int2lcd(EE_DV_NUM,'!',0);
          if(RESURS_CNT[0]>=10)int2lcd(RESURS_CNT[0]/10,'@',0);
          else int2lcd(RESURS_CNT[0],'@',1);
          if(RESURS_CNT[1]>=10)int2lcd(RESURS_CNT[1]/10,'#',0);
          else int2lcd(RESURS_CNT[1],'#',1);
      	int2lcd(Idmin/10,'$',0);
      	int2lcd(Id[0],'%',1);
      	int2lcd(Id[1],'&',1);
      	int2lcd(Idmax/10,'>',0);      	
		}
			
     else if(sub_ind==6)
     	{ 
     	bgnd_par(" Ступ.пуск   !а.","  @а  #сек  $Гц ");  
          int2lcd(SS_LEVEL,'!',1); 
          int2lcd(SS_STEP,'@',1);
          int2lcd(SS_TIME,'#',0);
          int2lcd(SS_FRIQ,'$',0);    	
		}	

     else if(sub_ind==7)
     	{ 
     	bgnd_par(" Переключение   ","  насосов       ");  
  	
		}

     else if(sub_ind==8)
     	{
     	if(DVCH==dvch_ON)ptrs[0]=" Вкл.    0!.0@  "; 
     	else ptrs[0]=" Выкл.   0!.0@  ";
     	bgnd_par(" Смена насосов  ",ptrs[0]);
     	int2lcd(DVCH_TIME/60,'!',0);
     	int2lcd(DVCH_TIME%60,'@',0);  
  	
		}		 
     else if(sub_ind==9)
     	{
     	bgnd_par(" Частотник      ","  !/0@/#/$/0%   ");
     	int2lcd(FP_FMIN,'!',0);
     	int2lcd(FP_FMAX,'@',0);  
     	int2lcd(FP_TPAD,'#',0);
     	int2lcd(FP_TVOZVR,'$',0); 
     	int2lcd(FP_CH,'%',0); 
     	//int2lcdxy(fp_step_num,0xf0,0);
     	}

     else if(sub_ind==10)
     	{
     	bgnd_par(" Задвижка  !    "," @       $  %   ");
          if(DOOR==dON)sub_bgnd("вкл",'!');
          else sub_bgnd("выкл",'!'); 
          if(DOOR_MODE==dmS)sub_bgnd("Синх.",'@');
          else sub_bgnd("Асинх.",'@');
     	int2lcd(DOOR_IMIN/10,'$',0);
     	int2lcd(DOOR_IMAX/10,'%',0);  
     	}
     	
     else if(sub_ind==11)
     	{
     	bgnd_par(" Пр.пуск   !    ","  @ч.   0$.0%   ");
          if(PROBE==pON)sub_bgnd("вкл",'!');
          else sub_bgnd("выкл",'!');
          int2lcd(PROBE_DUTY,'@',0); 
     	int2lcd(PROBE_TIME/60,'$',0);
     	int2lcd(PROBE_TIME%60,'%',0);  
     	}    
     else if(sub_ind==12)
     	{
     	bgnd_par(" Сухой ход  !   ","  @атм.  $сек.  ");
        if(HH_SENS==hhWMS)sub_bgnd("wms",'!');
        else sub_bgnd("    ",'!');
        int2lcd(HH_P,'@',1); 
     	int2lcd(HH_TIME,'$',0);
  
     	}        	

     else if(sub_ind==13)
     	{
     	bgnd_par(" Таймер         ","                ");
     	} 
     else if(sub_ind==14)
     	{
     	bgnd_par(" Нулевая нагруз.","                ");
     	}   
     else if(sub_ind==15)
     	{
     	bgnd_par(" ПИД            ","                ");
     	}      	  	     	
     else if(sub_ind==16)
     	{     
     	bgnd_par(sm_exit,sm_);  
		} 
	}

else if(ind==iMode_set)
	{
	if(EE_MODE==emAVT)ptrs[0]=" Автомат        ";
	else if(EE_MODE==emMNL)ptrs[0]=" Ручной         ";
	else ptrs[0]=" Тест           ";
	bgnd_par(ptrs[0],sm_);
	}	
	
else if(ind==iSetT)
	{
	
	if(index_set==0)
		{
		bgnd_par("0@:0#:0$ 0%  &0^",sm_);	
		lcd_buffer[11]=sm_mont[_month-1,0];
		lcd_buffer[12]=sm_mont[_month-1,1];
		lcd_buffer[13]=sm_mont[_month-1,2];
		
		if(sub_ind==0)
			{
			lcd_buffer[17]=4;
			}
		else if(sub_ind==1)
			{
			lcd_buffer[20]=4;
			} 
		else if(sub_ind==2)
			{
			lcd_buffer[23]=4;
			}
		else if(sub_ind==3)
			{
			lcd_buffer[26]=4;
			}
		else if(sub_ind==4)
			{
			lcd_buffer[28]=4;
			}
		else if(sub_ind==5)
			{
			lcd_buffer[31]=4;
			} 
		}	

	else if(index_set==1)
		{
		bgnd_par("0%  &0^ !       ",sm_);	
		lcd_buffer[2]=sm_mont[_month-1,0];
		lcd_buffer[3]=sm_mont[_month-1,1];
		lcd_buffer[4]=sm_mont[_month-1,2];
		
		sub_bgnd(&__weeks_days_[_week_day,0],'!');

		if(sub_ind==3)
			{
			lcd_buffer[17]=4;
			}
		else if(sub_ind==4)
			{
			lcd_buffer[19]=4;
			}
		else if(sub_ind==5)
			{
			lcd_buffer[22]=4;
			}     
		else if(sub_ind==6)
			{
			lcd_buffer[26]=4;
			} 			
		}			



	int2lcd(_hour,'@',0);
	int2lcd(_min,'#',0);
	int2lcd(_sec,'$',0);
	int2lcd(_day,'%',0);
	int2lcd(_year,'^',0);
	
	//int2lcdxy(_week_day,0x31,0);
	
     //char2lcdhxy(time_sezon,0xc1);
	
 
	}	

else if(ind==iTemper_set)
	{
	if(sub_ind==0)
		{
     	if(TEMPER_SIGN==0)bgnd_par(" Датчик - внутр.",sm_);
 		else bgnd_par(" Датчик - внешн.",sm_);   
		} 
	else if(sub_ind==1)
    		{
		bgnd_par("  Авария холод  ","            @gC ");
		int2lcd(AV_TEMPER_COOL,'@',0);
		} 
    	else if(sub_ind==2)
    		{
		bgnd_par(" Вкл. отопителя ","            @gC ");
		int2lcd(T_ON_WARM,'@',0);
		}	  
	else if(sub_ind==3)
    		{
		bgnd_par(" Калибр.датчика ","            @gC ");
		int2lcd_mm(temper_result,'@',0);
    		}
    	else if(sub_ind==4)
    		{
		bgnd_par("Вкл. вентилятора","            @gC ");
		int2lcd(T_ON_COOL,'@',0);
		}  
	else if(sub_ind==5)
		{
  		bgnd_par(" Авария перегрев","            @gC ");
		int2lcd(AV_TEMPER_HEAT,'@',0);
    		}
	else if(sub_ind==6)
		{
  		bgnd_par(" Гистерезис     ","            @gC ");
		int2lcd(TEMPER_GIST,'@',0);
    		}        
	else if(sub_ind==7)
		{
  		bgnd_par(" Выход          ",sm_);
    		} 
    	lcd_buffer[find('g')]=2;	   				
   	}

else if(ind==iNet_set)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Допуск    !%   ",sm_);
		int2lcd(AV_NET_PERCENT,'!',0);
		} 
	else if(sub_ind==1)
    		{
    		if(fasing==f_ABC) bgnd_par(" Фазировка  ABC ",sm_);
    		else bgnd_par(" Фазировка  ACB ",sm_);
   		} 
    	else if(sub_ind==2)
    		{
		bgnd_par("Калибр.фазаA  !В",sm_);
		int2lcd(unet[0],'!',0);
		}	  
	else if(sub_ind==3)
    		{
		bgnd_par("Калибр.фазаB  !В",sm_);
		int2lcd(unet[1],'!',0);
    		}
    	else if(sub_ind==4)
    		{
		bgnd_par("Калибр.фазаC  !В",sm_);
		int2lcd(unet[2],'!',0);
		}  
	else if(sub_ind==5)
		{
    		bgnd_par(" Выход          ",sm_);
    		}
   	}	

else if(ind==iDavl)
	{
	if(sub_ind==0)
		{
		bgnd_par("Тип датчиков  ! ",sm_);
		int2lcd(P_SENS,'!',0);
		} 
	else if(sub_ind==1)
    		{
    		bgnd_par("Pmin        !атм",sm_);
		int2lcd(P_MIN,'!',1);
   		} 
    	else if(sub_ind==2)
    		{
		bgnd_par("Калибр. насухую ",sm_); 
		int2lcdxy(adc_bank_[7],0xf0,0);
	       //	int2lcdxy(Kp0,0xa0,0);
	       //	int2lcdxy(Kp1,0x50,0);
		}
    	else if(sub_ind==3)
    		{
		bgnd_par("Калибровка      ","   P =     !атм."); 
		int2lcd(p/10,'!',1);
		int2lcdxy(adc_bank_[7],0xf0,0);
		//int2lcdxy(Kp0,0xa0,0);
		//int2lcdxy(Kp1,0x50,0);
		}			  
	else if(sub_ind==4)
    		{
    		bgnd_par("Pmax        !атм",sm_);
		int2lcd(P_MAX,'!',1);
    		}
    	else if(sub_ind==5)
    		{
    		bgnd_par("Tmax_min    !сек",sm_);
		int2lcd(T_MAXMIN,'!',0);
		}  
	else if(sub_ind==6)
		{
    		bgnd_par("Gmax_min    !атм",sm_);
		int2lcd(G_MAXMIN,'!',1);
    		}
    	else if(sub_ind==7)
    		{
    		bgnd_par(sm_exit,sm_);
		} 
  	}

else if(ind==iDv_num_set)
	{
	bgnd_par("Насосов    !    ",sm_);
	int2lcd(EE_DV_NUM,'!',0);
	} 
else if(ind==iDv_start_set)
	{
	bgnd_par("Звезда-треугольн","         !      ");
	if(STAR_TRIAN==stON)sub_bgnd("вкл.",'!');
	else sub_bgnd("выкл.",'!');
	} 
else if(ind==iDv_av_log)
	{
	bgnd_par(" Аварии по току "," !              ");
	if(DV_AV_SET==dasLOG)sub_bgnd("логические",'!');
	else sub_bgnd("по датчикам",'!');
	}
else if(ind==iDv_imin_set)
	{ 
	bgnd_par(" Iнмin.       #A",sm_);
	int2lcd(Idmin,'#',1);
	}
else if(ind==iDv_imax_set)
	{  
 	bgnd_par(" Iнмax.       #A",sm_);
 	int2lcd(Idmax,'#',1);	
	} 
else if(ind==iDv_mode_set)
	{
	bgnd_par("Реж.насос# !    ",sm_);
	if(DV_MODE[sub_ind]==dm_AVT)sub_bgnd("авт.",'!');
	else sub_bgnd("ручн.",'!');
	int2lcd(sub_ind+1,'#',0);
	}
else if(ind==iDv_resurs_set)
	{
	if(index_set==0)bgnd_par(" Сброс наработки"," насоса!    нет ");
 	else bgnd_par(" Сброс наработки"," насоса!    да  ");
 	int2lcd(sub_ind+1,'!',0); 
	}
else if(ind==iDv_i_kalibr)
	{
	if(index_set==0)bgnd_par(" Калибровка I#A ","     ! A        ");
	else bgnd_par(" Калибровка I#C ","     @ A        ");
	int2lcd(Ida[sub_ind],'!',1);
	int2lcd(Idc[sub_ind],'@',1);
	int2lcd(sub_ind+1,'#',0); 
	//int2lcdxy(Kida[sub_ind],0x30,0);
	//int2lcdxy(Kidc[sub_ind],0x70,0);
	}
else if(ind==iDv_c_set)
	{
	bgnd_par(" С!Н            ","                ");
 	int2lcd(C1N,'!',0);
	}
else if(ind==iDv_out)
    	{
    	bgnd_par(sm_exit,sm_);
	} 
								

					
else if(ind==iStep_start)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Уровень        ","   Pп =    !атм.");
		int2lcd(SS_LEVEL,'!',1);
		}  
	else if(sub_ind==1)
		{
		bgnd_par(" Прирост        ","   Pпр =   !атм.");
		int2lcd(SS_STEP,'!',1);
		}       
	else if(sub_ind==2)
		{
		bgnd_par(" Время          ","   Тпр =   !сек.");
		int2lcd(SS_TIME,'!',0);
		} 
	else if(sub_ind==3)
		{
		bgnd_par(" Частота        ","   Fпр =   !Гц  ");
		int2lcd(SS_FRIQ,'!',0);
		}     		    		
	else if(sub_ind==4)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}

else if(ind==iDv_change)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Tверх     !сек.",sm_);
		int2lcd(DVCH_T_UP,'!',0);
		}  
	else if(sub_ind==1)
		{
		bgnd_par(" Tниз      !сек.",sm_);
		int2lcd(DVCH_T_DOWN,'!',0);
		}       
	else if(sub_ind==2)
		{
		bgnd_par(" Pкр.      !атм.",sm_);
		int2lcd(DVCH_P_KR,'!',1);
		} 
	else if(sub_ind==3)
		{
		bgnd_par(" Kp        !    ",sm_);
		int2lcd(DVCH_KP,'!',1);
		}     		    		
	else if(sub_ind==4)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	

else if(ind==iDv_change1)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Tсм   0!ч.0@мин",sm_);
		int2lcd(DVCH_TIME/60,'!',0);
     	int2lcd(DVCH_TIME%60,'@',0); 
		}  
	else if(sub_ind==1)
		{
		if(DVCH==dvch_ON)bgnd_par("Разрешение  вкл.",sm_);
		else bgnd_par("Разрешение выкл.",sm_);
		}       
	else if(sub_ind==2)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	

else if(ind==iFp_set)
	{
	if(sub_ind==0)
		{
		bgnd_par("Fmin    #(  !)Гц",sm_);
		int2lcd(FP_FMIN,'#',0);
		int2lcd(__fp_fmin,'!',0);
		read_parametr=204;
		}  
	else if(sub_ind==1)
		{
		bgnd_par("Fmax    #(  !)Гц",sm_);
		int2lcd(FP_FMAX,'#',0);
		int2lcd(__fp_fmax,'!',0);
		read_parametr=205;
		}       
	else if(sub_ind==2)
		{
		bgnd_par(" Tпад      !сек.",sm_);
		int2lcd(FP_TPAD,'!',0);
		} 
	else if(sub_ind==3)
		{
		bgnd_par(" Tвозвр    !сек.",sm_);
		int2lcd(FP_TVOZVR,'!',0);
		}     		    	
	else if(sub_ind==4)
		{
		bgnd_par(" Ч         !%   ",sm_);
		int2lcd(FP_CH,'!',0);
		}       
	else if(sub_ind==5)
		{
		bgnd_par(" П+        !%   ",sm_);
		int2lcd(FP_P_PL,'!',0);
		} 
	else if(sub_ind==6)
		{
		bgnd_par(" П-        !%   ",sm_);
		int2lcd(FP_P_MI,'!',0);
		}     		    			
	else if(sub_ind==7)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	
else if(ind==iDoor_set)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Состояние !    ",sm_);
          if(DOOR==dON)sub_bgnd("вкл",'!');
          else sub_bgnd("выкл",'!');		
		}  
	else if(sub_ind==1)
		{
		bgnd_par(" Iзmin     !A   ",sm_);
		int2lcd(DOOR_IMIN,'!',1);
		}       
	else if(sub_ind==2)
		{
		bgnd_par(" Iзmax     !A   ",sm_);
		int2lcd(DOOR_IMAX,'!',1);
		} 
	else if(sub_ind==3)
		{
		bgnd_par("Режим !         ",sm_);
          if(DOOR_MODE==dmS)sub_bgnd("cинхронно",'!');
          else sub_bgnd("асинхронно",'!');
		}     		    	
	else if(sub_ind==4)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	  
else if(ind==iProbe_set)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Состояние !    ",sm_);
          if(PROBE==pON)sub_bgnd("вкл",'!');
          else sub_bgnd("выкл",'!');		
		}  
	else if(sub_ind==1)
		{
		bgnd_par(" Tисп.     !ч.  ",sm_);
		int2lcd(PROBE_DUTY,'!',0);
		}       
	else if(sub_ind==2)
		{
		bgnd_par(" Tп.п.   0$.0%  ",sm_);
     	int2lcd(PROBE_TIME/60,'$',0);
     	int2lcd(PROBE_TIME%60,'%',0);
		} 
	else if(sub_ind==3)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	     	

else if(ind==iHh_set)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Датчик   !     ",sm_);
          if(HH_SENS==hhWMS)sub_bgnd("wms",'!');
          else sub_bgnd("    ",'!');	
		}  
	else if(sub_ind==1)
		{
		bgnd_par(" Tсх.    !сек.  ",sm_);
		int2lcd(HH_TIME,'!',0);
		}       
	else if(sub_ind==2)
		{
		bgnd_par(" Pвх.    !атм.  ",sm_);
		int2lcd(HH_P,'!',1);
		} 
	else if(sub_ind==3)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	     	  

else if(ind==iTimer_sel)
	{
	ptrs[0]=" Pуст      !атм.";
	ptrs[1]=" Понедельник    ";
	ptrs[2]=" Вторник        ";
	ptrs[3]=" Среда          ";
	ptrs[4]=" Четверг        ";
	ptrs[5]=" Пятница        ";
	ptrs[6]=" Суббота        ";
	ptrs[7]=" Воскресенье    ";
	ptrs[8]=sm_exit; 
	
	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	else if(sub_ind<index_set)index_set=sub_ind;
	bgnd_par(ptrs[index_set],ptrs[index_set+1]);
	if(index_set==sub_ind)lcd_buffer[0]=1;
	else lcd_buffer[16]=1;
	
    	int2lcd(P_UST_EE/10,'!',1);
    //	int2lcdxy(sub_ind,0x30,0);
	}

else if(ind==iTimer_set)
	{ 
	if(sub_ind<5)
		{
	if(sub_ind1==0)	ptrs[0]=" Пн! 0@:0#-0$:0%";
	else if(sub_ind1==1)ptrs[0]=" Вт! 0@:0#-0$:0%";
	else if(sub_ind1==2)ptrs[0]=" Ср! 0@:0#-0$:0%";
	else if(sub_ind1==3)ptrs[0]=" Чт! 0@:0#-0$:0%";
	else if(sub_ind1==4)ptrs[0]=" Пт! 0@:0#-0$:0%";
	else if(sub_ind1==5)ptrs[0]=" Сб! 0@:0#-0$:0%";
	else if(sub_ind1==6)ptrs[0]=" Вс! 0@:0#-0$:0%";
	
	ptrs[1]=" Реж (   )      "; 
	
   	bgnd_par(ptrs[0],ptrs[1]); 
	
	if(timer_mode[sub_ind1,sub_ind]==1)
		{
		sub_bgnd("1     )атм.",'(');
		} 
	else if(timer_mode[sub_ind1,sub_ind]==2)
		{
		sub_bgnd("2     )Гц. ",'(');
		} 	
	else if(timer_mode[sub_ind1,sub_ind]==3)
		{
		sub_bgnd("3     )нас.",'(');
		}
	else 
		{
		sub_bgnd(" не устан. ",'(');
		}		   
	int2lcd(sub_ind+1,'!',0);
	if(timer_time1[sub_ind1,sub_ind]<1440)
		{
		int2lcd(timer_time1[sub_ind1,sub_ind]/60,'@',0);
		int2lcd(timer_time1[sub_ind1,sub_ind]%60,'#',0); 
		}
	else 
		{
		int2lcd(33,'@',0);
		int2lcd(33,'#',0); 
		}
	if(timer_time2[sub_ind1,sub_ind]<1440)
		{
		int2lcd(timer_time2[sub_ind1,sub_ind]/60,'$',0);
		int2lcd(timer_time2[sub_ind1,sub_ind]%60,'%',0);
		}
	else 
		{
		int2lcd(33,'$',0);
		int2lcd(33,'%',0); 
		}	
	
	if(timer_mode[sub_ind1,sub_ind]==1)int2lcd(timer_data1[sub_ind1,sub_ind]/10,')',1);
	else int2lcd(timer_data1[sub_ind1,sub_ind],')',0);
	
	     if(sub_ind2==0)ind_fl(5,2);
		else if(sub_ind2==1)ind_fl(8,2);
		else if(sub_ind2==2)ind_fl(11,2);
		else if(sub_ind2==3)ind_fl(14,2);
		else if(sub_ind2==4)ind_fl(17,5);
		else if(sub_ind2==5)ind_fl(22,10);
		}
	else bgnd_par(sm_exit,sm_);
	

	}
	
    	
else if(ind==iZero_load_set)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Tzero    !сек. ",sm_);
          int2lcd(ZL_TIME,'!',0);	
		}  
	else if(sub_ind==1)
		{
		bgnd_par(sm_exit,sm_);
		}
    	}	     	     	  	

else if(ind==iPid_set)
	{
	if(sub_ind==0)
		{
		bgnd_par(" Период    !сек.",sm_);
          int2lcd(PID_PERIOD,'!',1);	
		}  
	else if(sub_ind==1)
		{
		bgnd_par(" Усиление     ! ",sm_);
          int2lcd(PID_K,'!',1);	
		}		
	else if(sub_ind==2)
		{
		bgnd_par(" Усиление И   ! ",sm_);
          int2lcd(PID_K_P,'!',1);	
		}			
	else if(sub_ind==3)
		{
		bgnd_par(" Усиление Д   ! ",sm_);
          int2lcd(PID_K_D,'!',1);	
		}			
	else if(sub_ind==4)
		{
		bgnd_par(" Обороты частон."," перекл вниз  !%");
          int2lcd(PID_K_FP_DOWN,'!',0);	
		}			
	else if(sub_ind==5)
		{
		bgnd_par(sm_exit,sm_);
		}	
	}

ruslcd(lcd_buffer); 

/*lcd_buffer[32]=5; 
lcd_buffer[33]=5;*/
} 

//----------------------------------------------
void plata_ind_hndl(void) 
{
#define LED_COMM_AV	7 
#define LED_HH_AV	6
#define LED_NET_COND	4
#define LED_NET_CHER	5
#define LED_NET_NORM	3

#define LED_DV_ON	5
#define LED_AV_IDV	6
#define LED_AV_TEMPER	4
#define LED_AV_VL	7

#define LED_POPL1	4
#define LED_POPL2	5
#define LED_POPL3	2
#define LED_POPL4	3

data_for_ind[0]=read_ds14287(HOURS);

data_for_ind[1]=read_ds14287(MINUTES);

if(comm_curr<100) data_for_ind[2]=128+(char)comm_curr;
else data_for_ind[2]=(char)(comm_curr/10);

///data_for_ind[2]=plazma;
/*if((EE_LOG==el_popl)||(EE_MODE==emTST))data_for_ind[3]=0xff;
else 
	{
	if(height_level<100)data_for_ind[3]=height_level;
	else if(height_level>=100)data_for_ind[3]=128+(height_level/10);
	} */

if(p_ind_cnt)
	{
	p_ind_cnt--;
	if(p_ust<1000)data_for_ind[3]=p_ust/10+128;
	else if(p_ust>=1000)data_for_ind[3]=(p_ust/100);
	} 
else
	{
	if(p<1000)data_for_ind[3]=p/10+128;
	else if(p>=1000)data_for_ind[3]=(p/100);
     }
     
data_for_ind[4]=0xff;
data_for_ind[5]=0x00;

if(comm_av_st!=cast_OFF)
	{
	data_for_ind[4]&=~(1<<LED_COMM_AV);
	data_for_ind[5]|=(1<<LED_COMM_AV);
	}




if(hh_av==avON)
	{
	data_for_ind[4]&=~(1<<LED_HH_AV);
	}

if((unet_st[0]!=unet_st_NORM)||(unet_st[1]!=unet_st_NORM)||(unet_st[2]!=unet_st_NORM)) 
	{
	data_for_ind[4]&=~(1<<LED_NET_COND);
	}
if(av_st_unet_cher==asuc_AV)
	{
	data_for_ind[4]&=~(1<<LED_NET_CHER);
	}
if((unet_st[0]==unet_st_NORM)&&(unet_st[1]==unet_st_NORM)&&(unet_st[2]==unet_st_NORM)&&(av_st_unet_cher==asuc_NORM))
	{
	data_for_ind[4]&=~(1<<LED_NET_NORM);
	}		
data_for_ind[6]=0xFF;
data_for_ind[7]=0x00;
data_for_ind[8]=0xff;
data_for_ind[9]=0x00;


if(av_temper_st==av_temper_AVSENS)
	{
	data_for_ind[6]&=0b00111111;
	data_for_ind[7]|=0b11000000;
	}
else if (av_temper_st==av_temper_NORM)
	{
	data_for_ind[6]|=0b11000000;
	data_for_ind[7]&=0b00111111;
	}		
else if (av_temper_st==av_temper_COOL)
	{
	data_for_ind[6]&=0b01111111;
	data_for_ind[7]|=0b00000000;
	}
else if (av_temper_st==av_temper_HEAT)
	{
	data_for_ind[6]&=0b10111111;
	data_for_ind[7]|=0b00000000;
	} 

if(av_fp_stat==afsON)
	{
	data_for_ind[6]&=~(1<<LED_POPL3);
	data_for_ind[7]|=(1<<LED_POPL3);
	}


if(av_sens_p_stat==aspON)
	{
	data_for_ind[6]&=~(1<<LED_POPL4);
	data_for_ind[7]|=(1<<LED_POPL4);
	}
	
if(warm_st==warm_AVSENS)
	{
	data_for_ind[8]&=0b01111111;
	data_for_ind[9]|=0b10000000;
	}
else if((warm_st==warm_ON)&&(av_temper_st==av_temper_NORM))data_for_ind[8]&=0b01111111;


if(cool_st==cool_AVSENS)
	{
	data_for_ind[8]&=0b10111111;
	data_for_ind[9]|=0b01000000;
	}
else if((cool_st==cool_ON)&&(av_temper_st==av_temper_NORM))data_for_ind[8]&=0b10111111; 

if((pilot_dv==0)&&(fp_stat==dvON))data_for_ind[10]=(char)(__fp_fcurr/10);
else if(RESURS_CNT[0]>=10)data_for_ind[10]=RESURS_CNT[0]/10;
else data_for_ind[10]=128+RESURS_CNT[0];
if(av_serv[0]==avsON)data_for_ind[10]=0xff; 
data_for_ind[11]=0xff;
data_for_ind[12]=0x00; 

if(av_serv[0]==avsON)
	{
	data_for_ind[11]|=0b11111111;
	data_for_ind[12]&=0b00000000;
	}
else 
	{
	if((av_i_dv_min[0]!=aviOFF)||(av_i_dv_max[0]!=aviOFF)||(av_i_dv_log[0]!=aviOFF))
		{
		data_for_ind[11]&=~(1<<LED_AV_IDV);
		}
		
	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
		{
		if(dv_on[0]!=dvOFF)data_for_ind[11]&=~(1<<LED_DV_ON);
		else if(apv_cnt[0])
			{
			data_for_ind[11]&=~(1<<LED_DV_ON);
			data_for_ind[12]|=(1<<LED_DV_ON);
			}
		}				
	}	


if((pilot_dv==1)&&(fp_stat==dvON))data_for_ind[13]=(char)(__fp_fcurr/10);
else if(RESURS_CNT[1]>=10)data_for_ind[13]=RESURS_CNT[1]/10;
else data_for_ind[13]=128+RESURS_CNT[1];
if((av_serv[1]==avsON)||(EE_DV_NUM<2))data_for_ind[13]=0xff;


data_for_ind[14]=0xff;
data_for_ind[15]=0x00;
if((av_serv[1]==avsON)||(EE_DV_NUM<2))
	{
	data_for_ind[14]|=0b11111111;
	data_for_ind[15]&=0b11111111;
	}
else 
	{
	if((av_i_dv_min[1]!=aviOFF)||(av_i_dv_max[1]!=aviOFF)||(av_i_dv_log[1]!=aviOFF))
		{
		data_for_ind[14]&=~(1<<LED_AV_IDV);
		}
	
	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
		{
		if(dv_on[1]!=dvOFF)data_for_ind[14]&=~(1<<LED_DV_ON);
		else if(apv_cnt[1])
			{
			data_for_ind[14]&=~(1<<LED_DV_ON);
			data_for_ind[15]|=(1<<LED_DV_ON);
			}
		}						
	}


if((pilot_dv==2)&&(fp_stat==dvON))data_for_ind[16]=(char)(__fp_fcurr/10);
else if(RESURS_CNT[2]>=10)data_for_ind[16]=RESURS_CNT[2]/10;
else data_for_ind[16]=128+RESURS_CNT[2];
if((av_serv[2]==avsON)||(EE_DV_NUM<3))data_for_ind[16]=0xff; 


data_for_ind[17]=0xff;
data_for_ind[18]=0x00; 
if((av_serv[2]==avsON)||(EE_DV_NUM<3))
	{
	data_for_ind[17]|=0b11111111;
	data_for_ind[18]&=0b00000000;
	}
else 
	{
	if((av_i_dv_min[2]!=aviOFF)||(av_i_dv_max[2]!=aviOFF)||(av_i_dv_log[2]!=aviOFF))
		{
		data_for_ind[17]&=~(1<<LED_AV_IDV);
		}
 	
	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
		{
		if(dv_on[2]!=dvOFF)data_for_ind[17]&=~(1<<LED_DV_ON);
		else if(apv_cnt[2])
			{
			data_for_ind[17]&=~(1<<LED_DV_ON);
			data_for_ind[18]|=(1<<LED_DV_ON);
			}
		}				
	}


if((pilot_dv==3)&&(fp_stat==dvON))data_for_ind[20]=(char)(__fp_fcurr/10);
else if(RESURS_CNT[3]>=10)data_for_ind[20]=RESURS_CNT[3]/10;
else data_for_ind[20]=128+RESURS_CNT[3];
if((av_serv[3]==avsON)||(EE_DV_NUM<4))data_for_ind[20]=0xff;

 
data_for_ind[21]=0xff;
data_for_ind[22]=0x00; 
if((av_serv[3]==avsON)||(EE_DV_NUM<4))
	{
	data_for_ind[21]|=0b11111111;
	data_for_ind[22]&=0b00000000;
	}
else 
	{
	if((av_i_dv_min[3]!=aviOFF)||(av_i_dv_max[3]!=aviOFF)||(av_i_dv_log[3]!=aviOFF))
		{
		data_for_ind[21]&=~(1<<LED_AV_IDV);
		}
		
	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
		{
		if(dv_on[3]!=dvOFF)data_for_ind[21]&=~(1<<LED_DV_ON);
		else if(apv_cnt[4])
			{
			data_for_ind[21]&=~(1<<LED_DV_ON);
			data_for_ind[22]|=(1<<LED_DV_ON);
			}
		}				
	}


if(main_cnt<10)
	{
	data_for_ind[2]=0xff;
	data_for_ind[3]=0xff;
	data_for_ind[4]=0xff;
	data_for_ind[5]=0;
	data_for_ind[6]=0xff;
	data_for_ind[7]=0;
	data_for_ind[8]=0xff;
	data_for_ind[9]=0;
	data_for_ind[10]=0xff;
	data_for_ind[11]=0xff;
	data_for_ind[12]=0;
	data_for_ind[13]=0xff;
	data_for_ind[14]=0xff;
	data_for_ind[15]=0;
	data_for_ind[16]=0xff;
	data_for_ind[17]=0xff;
	data_for_ind[18]=0;
	data_for_ind[20]=0xff;
	data_for_ind[21]=0xff;
	data_for_ind[22]=0;
	}


}


//-----------------------------------------------
void but_drv(void)
{
DDRC&=0b00000000;
PORTC|=0b11111111;

DDRG|=0b00010000;
PORTG&=0b11101111;

if(!PINC.4)but_cnt[0]++;
else but_cnt[0]=0;
gran_char(&but_cnt[0],0,100);

if(!PINC.5)but_cnt[1]++;
else but_cnt[1]=0;
gran_char(&but_cnt[1],0,100);

if(!PINC.6)but_cnt[2]++;
else but_cnt[2]=0;
gran_char(&but_cnt[2],0,100);

if(!PINC.7)but_cnt[3]++;
else but_cnt[3]--;
gran_char(&but_cnt[3],0,100);  



}

#define butE	0b11110111
#define butE_	0b11110110
#define butU_	0b11101110
#define butU	0b11101111
#define butD	0b11011111
#define butD_	0b11011110
#define butL	0b10111111
#define butL_	0b10111110
#define butR	0b01111111 
#define butR_	0b01111110
#define butLER	0b00110111
#define butUD	0b11001111
//#define butD	0b11011111
//-----------------------------------------------
void but_an_pult(void)
{
//plazma=but_pult; 
if(but_pult==butUD)
	{
	if(ind!=iDeb)
		{
		//ret_ind(ind,sub_ind,30);
		ind=iDeb;
		}
	else
		{
		ind=iAv_sel;
		sub_ind=0;
		}	
    	}
if(ind==iDeb)
	{
 	if(but_pult==butR)
    		{
    		    		unsigned temp_U;
                //if(sub_ind!=0)sub_ind=0;
		sub_ind++;
		gran_ring_char(&sub_ind,0,2);
		//write_vlt_registers(204,15000);
    		}    				  
 	else if(but_pult==butL)
    		{
    		
    		
    		unsigned temp_U;
if(sub_ind!=1)sub_ind=1;
		
          }
          
	else if(but_pult==butU)
    		{
    	    /*	fr_stat++;
    		gran(&fr_stat,0,100);
    		write_vlt_coil(1,0x047c,0x2000); */
 /*   		unsigned temp_U;		
		
		temp_U=2050-1;	
		modbus_buffer[0]=0x02;
		modbus_buffer[1]=0x03;
		modbus_buffer[2]=*(((char*)(&temp_U))+1);
		modbus_buffer[3]=*((char*)&temp_U);
		modbus_buffer[4]=0x00;
		modbus_buffer[5]=0x02;
	    //	modbus_buffer[6]=0x02;
		//modbus_buffer[7]=0x02;
		temp_U=crc16(modbus_buffer,6);
		modbus_buffer[6]=*(((char*)(&temp_U))+1);
		modbus_buffer[7]=*((char*)&temp_U);
		usart_out_adr0(modbus_buffer,8);	*/
		
		if(EE_MODE==emMNL)power=((power/10)+1)*10;   		
    		} 
	else if(but_pult==butD)
    		{
    		/*fr_stat--;
    		gran(&fr_stat,0,100);
    		write_vlt_coil(1,0x043c,0x2000);*/
    		if(EE_MODE==emMNL)power=((power/10)-1)*10;
    		}    		   	
	}
    	
else if(ind==iAv_sel)
	{
	if(but_pult==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,19);
		}
	else if(but_pult==butU)
		{         
 		sub_ind--; 
		gran_char(&sub_ind,0,19);
		}

	else if(but_pult==butLER)
		{
		av_code[0]=0xff;
		av_code[1]=0xff;
		av_code[2]=0xff;
		av_code[3]=0xff;
		av_code[4]=0xff;
		av_code[5]=0xff;
		av_code[6]=0xff;
		av_code[7]=0xff;
		av_code[8]=0xff;
		av_code[9]=0xff;
		av_code[10]=0xff;
		av_code[11]=0xff;
		av_code[12]=0xff;
		av_code[13]=0xff;
		av_code[14]=0xff;
		av_code[15]=0xff;
		av_code[16]=0xff;
		av_code[17]=0xff;
		av_code[18]=0xff;
		av_code[19]=0xff;
		}
    	else if(but_pult==butE)
    		{
    		if((sub_ind>=0)&&(sub_ind<=19))
    			{
    			if(sub_ind>index_set)sub_ind1=p1;
    			else sub_ind1=p2;
    			if(av_code[sub_ind1]!=0xff)
    				{
    				ind=iAv;
    			     index_set=0;
    				ret_ind(iAv_sel,sub_ind,20);
    				}
    			}
    		}
    	else if((but_pult==butE_)&&(but_cnt[4]==0))
    			{
    			ind=iSet;   
    			sub_ind=0;  
    			index_set=0;
    			}    				
	}	  

else if(ind==iAv)
	{
	if(but_pult==butD)
		{
		index_set=1;
		}
	else if(but_pult==butU)
		{         
		index_set=0;
		}
    	else if(but_pult==butE)
    		{
		ind=iAv_sel;
    		} 
    		
 
    		
    				
	}

else if(ind==iSet)
	{
	if(but_pult==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,16);
		}
	else if(but_pult==butU)
		{         
		sub_ind--; 
		gran_char(&sub_ind,0,16);
		}
    	else if(but_pult==butE)
    		{
    		if(sub_ind==0)
    			{
    			ind=iMode_set;
    			}
    		else if(sub_ind==1)
    			{
    			ind=iSetT;
    			sub_ind=0;
    			}           
    		else if(sub_ind==2)
    			{
    			ind=iTemper_set;
    			sub_ind=0;
    			index_set=0;
    			}  
    		else if(sub_ind==3)
    			{
    			ind=iNet_set;
    			sub_ind=0;
    			index_set=0;
    			}  
    		else if(sub_ind==4)
    			{
    			ind=iDavl;
    			sub_ind=0;
    			index_set=0;
    			}  
   		else if(sub_ind==5)
    			{
    			ind=iDv_num_set;
    			sub_ind=0;
    			index_set=0;
    			}      			      			  
    		else if(sub_ind==6)
    			{
    			ind=iStep_start;
    			sub_ind=0;
    			}    
    		else if(sub_ind==7)
    			{
    			ind=iDv_change;
    			sub_ind=0;
    			}   
    		else if(sub_ind==8)
    			{
    			ind=iDv_change1;
    			sub_ind=0;
    			}      
    		else if(sub_ind==9)
    			{
    			ind=iFp_set;
    			sub_ind=0;
    			read_vlt_register(204,2);
    			}        
    		else if(sub_ind==10)
    			{
    			ind=iDoor_set;
    			sub_ind=0;
    			}        
    		else if(sub_ind==11)
    			{
    			ind=iProbe_set;
    			sub_ind=0;
    			} 
    		else if(sub_ind==12)
    			{
    			ind=iHh_set;
    			sub_ind=0;
    			}  
    		else if(sub_ind==13)
    			{
    			ind=iTimer_sel;
    			sub_ind=0;
    			index_set=0;
    			} 
    		else if(sub_ind==14)
    			{
    			ind=iZero_load_set;
    			sub_ind=0;
    			} 
    		else if(sub_ind==15)
    			{
    			ind=iPid_set;
    			sub_ind=0;
    			}    			
    		else if(sub_ind==16)
    			{
    			ind=iAv_sel;
    			sub_ind=0;
    			}     			     			    			   			        			 			  			     			 						    			
    		}

		
	}
else if(ind==iSetT)
	{     
	char temp;
	if(but_pult==butR)
		{
		sub_ind++;
		gran_ring_char(&sub_ind,0,6);
		if(sub_ind>5)index_set=1;
		else if(sub_ind==0)index_set=0;
		}
	else if(but_pult==butL)
		{         
		sub_ind--;
		gran_ring_char(&sub_ind,0,6);
		if(sub_ind<3)index_set=0;
		else if(sub_ind==6)index_set=1;
		}
    	else if(but_pult==butE)
    		{
		ind=iSet;
  		sub_ind=1;
    		}
    	else if(sub_ind==0)
    		{    
    		temp=_hour;
    		if((but_pult==butU)||(but_pult==butU_))
    			{
    			temp++;
    			gran_ring_char(&temp,0,23);
    			speed=1;
    			} 
   		else if((but_pult==butD)||(but_pult==butD_))
    			{
    			temp--;
    			gran_ring_char(&temp,0,23);
    			speed=1;
    			}       			                         
    		write_ds14287(HOURS,temp);
    		_hour=read_ds14287(HOURS);	
    		}
    	else if(sub_ind==1)
    		{    
    		temp=_min;
    		if((but_pult==butU)||(but_pult==butU_))
    			{
    			temp++;
    			gran_ring_char(&temp,0,59);
    			speed=1;
    			} 
   		else if((but_pult==butD)||(but_pult==butD_))
    			{
    			temp--;
    			gran_ring_char(&temp,0,59);
    			speed=1;
    			}       			                         
    		write_ds14287(MINUTES,temp);
    		_min=read_ds14287(MINUTES);	
    		}
    	else if(sub_ind==2)
    		{    
 		if(but_pult==butE)
 			{
 			write_ds14287(SECONDS,0);
 			_sec=read_ds14287(SECONDS);
 			}	
    		}
    	else if(sub_ind==3)
    		{    
    		temp=_day;
    		if((but_pult==butU)||(but_pult==butU_))
    			{
    			temp++;
    			gran_ring_char(&temp,1,DAY_MONTHS[_month-1]);
    			speed=1;
    			} 
   		else if((but_pult==butD)||(but_pult==butD_))
    			{
    			temp--;
    			gran_ring_char(&temp,1,DAY_MONTHS[_month-1]);
    			speed=1;
    			}       			                         
    		write_ds14287(DAY_OF_THE_MONTH,temp);
    		_day=read_ds14287(DAY_OF_THE_MONTH);	
    		} 
    	else if(sub_ind==4)
    		{    
    		temp=_month;
    		if((but_pult==butU)||(but_pult==butU_))
    			{
    			temp++;
    			gran_ring_char(&temp,1,12);
    			speed=1;
    			} 
   		else if((but_pult==butD)||(but_pult==butD_))
    			{
    			temp--;
    			gran_ring_char(&temp,1,12);
    			speed=1;
    			}       			                         
    		write_ds14287(MONTH,temp);
    		_month=read_ds14287(MONTH);	
    		} 
    	else if(sub_ind==5)
    		{    
    		temp=_year;
    		if((but_pult==butU)||(but_pult==butU_))
    			{
    			temp++;
    			gran_ring_char(&temp,0,99);
    			speed=1;
    			} 
   		else if((but_pult==butD)||(but_pult==butD_))
    			{
    			temp--;
    			gran_ring_char(&temp,0,99);
    			speed=1;
    			}       			                         
    		write_ds14287(YEAR,temp);
    		_year=read_ds14287(YEAR);	
    		}      
    	else if(sub_ind==6)
    		{    
    		temp=_week_day;
    		if((but_pult==butU)||(but_pult==butU_))
    			{
    			temp++;
    			gran_ring_char(&temp,1,7);
    			speed=1;
    			} 
   		else if((but_pult==butD)||(but_pult==butD_))
    			{
    			temp--;
    			gran_ring_char(&temp,1,7);
    			speed=1;
    			}       			                         
    		write_ds14287(DAY_OF_THE_WEEK,temp);
    		_week_day=read_ds14287(DAY_OF_THE_WEEK);	
    		}         				    		   		    		
		
	}    
	
else if(ind==iMode_set)
	{
	if((but_pult==butR)||(but_pult==butR_))
		{
		if(EE_MODE==emAVT)EE_MODE=emTST;
		else if(EE_MODE==emTST)EE_MODE=emMNL;
		else EE_MODE=emAVT; 
		} 

	else if((but_pult==butL)||(but_pult==butL_))
		{
		if(EE_MODE==emAVT)EE_MODE=emMNL;
		else if(EE_MODE==emMNL)EE_MODE=emTST;
		else EE_MODE=emAVT; 
		}		
	else if(but_pult==butE)
		{
		ind=iSet;
		sub_ind=0;
		}				
	}		
	
else if(ind==iTemper_set)
	{
 	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_)||(but_pult==butL)||(but_pult==butL_))
			{
			if(TEMPER_SIGN==0)TEMPER_SIGN=1;
			else TEMPER_SIGN=0;
			}
		else if(but_pult==butE)
			{
			sub_ind=1;
			}	 		 
		}	
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			AV_TEMPER_COOL++;
			granee(&AV_TEMPER_COOL,0,50);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			AV_TEMPER_COOL--;
			granee(&AV_TEMPER_COOL,0,50);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=2;
			}		
		}
	else if(sub_ind==2)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			T_ON_WARM++;
			granee(&T_ON_WARM,0,50);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			T_ON_WARM--;
			granee(&T_ON_WARM,0,50);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=3;
			}		
		}							

	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kt[TEMPER_SIGN]++;
			granee(&Kt[TEMPER_SIGN],400,550);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			Kt[TEMPER_SIGN]--;
			granee(&Kt[TEMPER_SIGN],400,550);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=4;
			}
		}
	else if(sub_ind==4)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			T_ON_COOL++;
			granee(&T_ON_COOL,0,100);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			T_ON_COOL--;
			granee(&T_ON_COOL,0,100);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=5;
			}
		}		 
	else if(sub_ind==5)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			AV_TEMPER_HEAT++;
			granee(&AV_TEMPER_HEAT,0,100);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			AV_TEMPER_HEAT--;
			granee(&AV_TEMPER_HEAT,0,100);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=6;
			}
		}		  
	else if(sub_ind==6)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			TEMPER_GIST++;
			granee(&TEMPER_GIST,0,10);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			TEMPER_GIST--;
			granee(&TEMPER_GIST,0,10);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=7;
			}
		}														
	else if(sub_ind==7)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=2;
    			}		
		}			
	} 
	 		 
else if(ind==iNet_set)
	{
 	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_)||(but_pult==butL)||(but_pult==butL_))
			{
			if(AV_NET_PERCENT==15)AV_NET_PERCENT=10;
			else AV_NET_PERCENT=15;
			}
		else if(but_pult==butE)
			{
			sub_ind=1;
			}	 		 
		}	
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_)||(but_pult==butL)||(but_pult==butL_))
			{
			if(fasing==f_ABC)fasing=f_ACB;
			else fasing=f_ABC;
			}
		else if(but_pult==butE)
			{
			sub_ind=2;
			}	 			
		}
	else if(sub_ind==2)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kun[0]--;
			granee(&Kun[0],300,500);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			Kun[0]++;
			granee(&Kun[0],300,500);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=3;
			}
		}							

	else if(sub_ind==3)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kun[1]--;
			granee(&Kun[1],300,500);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			Kun[1]++;
			granee(&Kun[1],300,500);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=4;
			}
		}
	else if(sub_ind==4)
		{		
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kun[2]--;
			granee(&Kun[2],300,500);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			Kun[2]++;
			granee(&Kun[2],300,500);
			speed=1;
			} 
		else if(but_pult==butE)
			{
			sub_ind=5;
			}
		}										
	else if(sub_ind==5)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=3;
    			}		
		}			

	}  	          	
else if(ind==iDavl)
	{
	speed=1;
	if(sub_ind==0)
		{
		if(but_pult==butR)
			{
			if(P_SENS==6)P_SENS=10;
			else if(P_SENS==10)P_SENS=16;
			else P_SENS=6;
			}           
		else if(but_pult==butL)
			{
			if(P_SENS==6)P_SENS=16;
			else if(P_SENS==10)P_SENS=6;
			else P_SENS=10;
			} 
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		}
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			speed=1;
			P_MIN++;
			granee(&P_MIN,1,80);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			speed=1;
			P_MIN--;
			granee(&P_MIN,1,80);
			}       
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}
	else if(sub_ind==2)
		{
		if(but_pult==butE_)
			{
			Kp0=adc_bank_[3];
			sub_ind=3;
			}
		else if(but_pult==butE)
			{
			sub_ind=3;
			}						 		 
		}		
	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kp1++;
			granee(&Kp1,100,10000);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			Kp1--;
			granee(&Kp1,100,10000);
			speed=1;
			}
		else if(but_pult==butE)
			{
			sub_ind=4;
			}			 		 
		}
	else if(sub_ind==4)
		{ 
		speed=1;
		if((but_pult==butR)||(but_pult==butR_))
			{
			P_MAX++;
			granee(&P_MAX,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			P_MAX--;
			granee(&P_MAX,1,100);
			}       
		else if(but_pult==butE)
			{
			sub_ind=5;
			}			 		 
		}		
	else if(sub_ind==5)
		{ 
		speed=1;
		if((but_pult==butR)||(but_pult==butR_))
			{
			T_MAXMIN++;
			granee(&T_MAXMIN,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			T_MAXMIN--;
			granee(&T_MAXMIN,1,100);
			}       
		else if(but_pult==butE)
			{
			sub_ind=6;
			}			 		 
		}		
	else if(sub_ind==6)
		{ 
		speed=1;
		if((but_pult==butR)||(but_pult==butR_))
			{
			G_MAXMIN++;
			granee(&G_MAXMIN,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			G_MAXMIN--;
			granee(&G_MAXMIN,1,100);
			}       
		else if(but_pult==butE)
			{
			sub_ind=7;
			}			 		 
		}	 
	
	else if(sub_ind==7)
		{ 
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=4;
    			}
    		}																	
	}

else if(ind==iDv_num_set)
	{
	speed=1;
	if((but_pult==butR)||(but_pult==butR_))
		{
		EE_DV_NUM++;
		granee(&EE_DV_NUM,1,6);
		}           
	else if((but_pult==butL)||(but_pult==butL_))
		{
		EE_DV_NUM--;
		granee(&EE_DV_NUM,1,6);
		}
	else if(but_pult==butE)
    		{
    		ind=iDv_av_log; 
    		sub_ind=0;
    		index_set=0;
    		}			           
	}
/*else if(ind==iDv_start_set)
	{
	if((but_pult==butR)||(but_pult==butL))
    		{
    		if(STAR_TRIAN==stON)STAR_TRIAN=stOFF;
    		else STAR_TRIAN=stON;
    		}           
    	else if(but_pult==butE)
    		{
    		ind=iDv_av_set; 
    		sub_ind=0;
    		index_set=0;
    		} 	
	}  */
	
else if(ind==iDv_av_log)
	{
	if((but_pult==butR)||(but_pult==butL))
    		{
    		if(DV_AV_SET==dasLOG)DV_AV_SET=dasDAT;
    		else DV_AV_SET=dasLOG;
    		}           
    	else if(but_pult==butE)
    		{
    		if(DV_AV_SET==dasLOG)
    			{
    			ind=iDv_resurs_set;
    			sub_ind=0;
    			index_set=0;
    			}
    		else
    			{
    			ind=iDv_imin_set; 
    			sub_ind=0;
    			index_set=0;
    			}

    		} 	
	}
		
else if(ind==iDv_imin_set)
	{ 
	speed=1;
	if((but_pult==butR)||(but_pult==butR_))
		{
		Idmin++;
		granee(&Idmin,1,100);
		}           
	else if((but_pult==butL)||(but_pult==butL_))
		{
		Idmin--;
		granee(&Idmin,1,100);
	    	}
 	else if(but_pult==butE)
		{
    		ind=iDv_imax_set; 
    		sub_ind=0;
    		index_set=0;
		}			  
	}		 
else if(ind==iDv_imax_set)
	{ 
	speed=1;
	if((but_pult==butR)||(but_pult==butR_))
		{
		Idmax++;
		granee(&Idmax,1,300);
	    	}           
	else if((but_pult==butL)||(but_pult==butL_))
		{
    		Idmax--;
		granee(&Idmax,1,300);
		}
 	else if(but_pult==butE)
		{
    		ind=iDv_resurs_set; 
    		sub_ind=0;
    		index_set=0;
		}			  
	} 
else if(ind==iDv_mode_set)
	{
	if((but_pult==butR)||(but_pult==butL))
		{
		if(DV_MODE[sub_ind]==dm_MNL)DV_MODE[sub_ind]=dm_AVT;
		else DV_MODE[sub_ind]=dm_MNL;
	   	} 
	 else if(but_pult==butE)
		{
		sub_ind++;
		if(sub_ind>=EE_DV_NUM)
			{
			ind=iDv_resurs_set;
			sub_ind=0;
			index_set=0;
			}
		}	     
	}
else if(ind==iDv_resurs_set)
	{
	if(but_pult==butE)
		{
		if(index_set)
			{
			RESURS_CNT[sub_ind]=0; 
			resurs_cnt_[sub_ind]=0; 
			}
		sub_ind++;
		index_set=0;
		if(sub_ind>=EE_DV_NUM)
			{
			ind=iDv_i_kalibr;
			sub_ind=0;
			index_set=0;
			}
		}
	else if((but_pult==butL)||(but_pult==butR))
		{
		if(index_set==0)index_set=1;
		else index_set=0;
		}		  
	}
else if(ind==iDv_i_kalibr)
	{
	if(!index_set)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kida[sub_ind]+=2;
			granee(&Kida[sub_ind],150,500);
			speed=1; 
			}
		else if((but_pult==butL)||(but_pult==butL_))
			{
			Kida[sub_ind]--;
			granee(&Kida[sub_ind],150,500);
			speed=1;
			}
		else if(but_pult==butE)
			{
			index_set=1;
			}		
		}
	else if(index_set)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			Kidc[sub_ind]+=2;
			granee(&Kidc[sub_ind],150,500);
			speed=1;
			}
		else if((but_pult==butL)||(but_pult==butL_))
		   	{
		    	Kidc[sub_ind]--;
		    	granee(&Kidc[sub_ind],150,500);
		    	speed=1;
			}	
		else if(but_pult==butE)
			{
			sub_ind++;
			index_set=0;
			if(sub_ind>=EE_DV_NUM)
				{
				ind=iDv_c_set;
				sub_ind=0;
				index_set=0;
				}
			} 	 
		}		 
	}
else if(ind==iDv_c_set)
	{
	if((but_pult==butR)||(but_pult==butR_))
		{
		C1N++;
		granee(&C1N,0,EE_DV_NUM);
		} 
	else if((but_pult==butL)||(but_pult==butL_))
		{
		C1N--;
		granee(&C1N,0,EE_DV_NUM);
		}			
	else if(but_pult==butE)
		{
		ind=iDv_out;
		} 	 
	}														 
else if(ind==iDv_out)
	{
	if(but_pult==butE)
    		{
    		ind=iSet;
    		sub_ind=5;
    		}		
	}								


else if(ind==iStep_start)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			SS_LEVEL++;
			granee(&SS_LEVEL,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			SS_LEVEL--;
			granee(&SS_LEVEL,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			SS_STEP++;
			granee(&SS_STEP,1,50);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			SS_STEP--;
			granee(&SS_STEP,1,50);
			}          
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			SS_TIME++;
			granee(&SS_TIME,1,60);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			SS_TIME--;
			granee(&SS_TIME,1,60);
			}
		else if(but_pult==butE)
			{
			sub_ind=3;
			}			 		 
		}
	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			SS_FRIQ++;
			granee(&SS_FRIQ,1,70);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			SS_FRIQ--;
			granee(&SS_FRIQ,1,70);
			}
		else if(but_pult==butE)
			{
			sub_ind=4;
			}				 		 
		} 
		
	else if(sub_ind==4)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=6;
    			}		
		}		
	}  	      	

else if(ind==iDv_change)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DVCH_T_UP++;
			granee(&DVCH_T_UP,1,60);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DVCH_T_UP--;
			granee(&DVCH_T_UP,1,60);
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DVCH_T_DOWN++;
			granee(&DVCH_T_DOWN,1,60);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DVCH_T_DOWN--;
			granee(&DVCH_T_DOWN,1,60);
			}          
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DVCH_P_KR++;
			granee(&DVCH_P_KR,1,50);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DVCH_P_KR--;
			granee(&DVCH_P_KR,1,50);
			}
		else if(but_pult==butE)
			{
			sub_ind=4;
			}			 		 
		}
	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DVCH_KP++;
			granee(&DVCH_KP,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DVCH_KP--;
			granee(&DVCH_KP,1,100);
			}
		else if(but_pult==butE)
			{
			sub_ind=4;
			}				 		 
		} 
		
	else if(sub_ind==4)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=7;
    			}		
		}		
	}  
	
else if(ind==iDv_change1)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DVCH_TIME=((DVCH_TIME/15)+1)*15;
			granee(&DVCH_TIME,15,1440);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DVCH_TIME=((DVCH_TIME/15)-1)*15;
			granee(&DVCH_TIME,15,1440);
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DVCH=dvch_ON;
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DVCH=dvch_OFF;
			}          
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		
	else if(sub_ind==2)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=8;
    			}		
		}			
	}

else if(ind==iFp_set)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_FMIN++;
			granee(&FP_FMIN,10,70);
			write_vlt_registers(204,(unsigned long)FP_FMIN*1000UL);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_FMIN--;
			granee(&FP_FMIN,10,70);
			write_vlt_registers(204,(unsigned long)FP_FMIN*1000UL);
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_FMAX++;
			granee(&FP_FMAX,10,70);
			write_vlt_registers(205,(unsigned long)FP_FMAX*1000UL);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_FMAX--;
			granee(&FP_FMAX,10,70);
			write_vlt_registers(205,(unsigned long)FP_FMAX*1000UL);
			}   
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		 
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_TPAD++;
			granee(&FP_TPAD,1,10);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_TPAD--;
			granee(&FP_TPAD,1,10);
			}   
		else if(but_pult==butE)
			{
			sub_ind=3;
			}			 		 
		}  
	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_TVOZVR++;
			granee(&FP_TVOZVR,1,10);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_TVOZVR--;
			granee(&FP_TVOZVR,1,10);
			}   
		else if(but_pult==butE)
			{
			sub_ind=4;
			}			 		 
		} 
	else if(sub_ind==4)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_CH++;
			granee(&FP_CH,0,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_CH--;
			granee(&FP_CH,0,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=5;
			}			 		 
		} 		  
	else if(sub_ind==5)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_P_PL++;
			granee(&FP_P_PL,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_P_PL--;
			granee(&FP_P_PL,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=6;
			}			 		 
		} 
	else if(sub_ind==6)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			FP_P_MI++;
			granee(&FP_P_MI,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			FP_P_MI--;
			granee(&FP_P_MI,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=7;
			}			 		 
		} 									
	else if(sub_ind==7)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=9;
    			}		
		}			
	}	

else if(ind==iDoor_set)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DOOR=dON;
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DOOR=dOFF;
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DOOR_IMIN++;
			granee(&DOOR_IMIN,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DOOR_IMIN--;
			granee(&DOOR_IMIN,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		 
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DOOR_IMAX++;
			granee(&DOOR_IMAX,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DOOR_IMAX--;
			granee(&DOOR_IMAX,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=3;
			}			 		 
		}  
	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			DOOR_MODE=dmS;
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			DOOR_MODE=dmA;
			}   
		else if(but_pult==butE)
			{
			sub_ind=4;
			}			 		 
		} 
	else if(sub_ind==4)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=10;
    			}		
		}			
	}	 
	
else if(ind==iProbe_set)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PROBE=pON;
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PROBE=pOFF;
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PROBE_DUTY=((PROBE_DUTY/24)+1)*24;
			granee(&PROBE_DUTY,24,96);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PROBE_DUTY=((PROBE_DUTY/24)-1)*24;
			granee(&PROBE_DUTY,24,96);
			}   
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		 
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PROBE_TIME=((PROBE_TIME/15)+1)*15;
			granee(&PROBE_TIME,0,1425);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PROBE_TIME=((PROBE_TIME/15)-1)*15;
			granee(&PROBE_TIME,0,1425);
			}   
		else if(but_pult==butE)
			{
			sub_ind=3;
			}			 		 
		}  
	else if(sub_ind==3)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=11;
    			}		
		}			
	}	    
	
else if(ind==iHh_set)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			HH_SENS=hhWMS;
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			HH_SENS=hhWMS;
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			HH_TIME++;
			granee(&HH_TIME,1,10);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			HH_TIME--;
			granee(&HH_TIME,1,10);
			}   		
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		}  
		 
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			HH_P++;
			granee(&HH_P,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			HH_P--;
			granee(&HH_P,1,100);
			}   		
		else if(but_pult==butE)
			{
			sub_ind=3;
			}			 		 
		}  
	else if(sub_ind==3)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=12;
    			}		
		}			
	}

else if(ind==iTimer_sel)
	{
	if(but_pult==butU)
		{
		sub_ind--;
		gran_char(&sub_ind,0,8);
		}
    	else	if(but_pult==butD)
		{
		sub_ind++;
		gran_char(&sub_ind,0,8);
		}
	else if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			P_UST_EE=((P_UST_EE/10)+1)*10;
			granee(&P_UST_EE,0,300);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			P_UST_EE=((P_UST_EE/10)-1)*10;
			granee(&P_UST_EE,0,300);
			}
		}   	 
	else if((sub_ind>=1)&&(sub_ind<=7))
		{
		if(but_pult==butE)
			{
			ind=iTimer_set;
			sub_ind1=sub_ind-1;
			sub_ind=0;
			sub_ind2=0;
			}
		}
	else if(sub_ind==8)
		{
		if(but_pult==butE)
			{	
			ind=iSet;
			sub_ind=13;
			}
		}   						
	}

else if(ind==iTimer_set)
	{ 
	if(but_pult==butE)
		{
		if(sub_ind<5)sub_ind++;
		else 
			{
			ind=iTimer_sel;
			sub_ind=sub_ind1+1;
			}
		}
	else if(but_pult==butR)
		{
		sub_ind2++;
		gran_ring_char(&sub_ind2,0,5);
		}   
	else if(but_pult==butL)
		{
		sub_ind2--;
		gran_ring_char(&sub_ind2,0,5);
		}
	else if(sub_ind2==0)
		{
		if((but_pult==butU)||(but_pult==butU_))
			{
			timer_time1[sub_ind1,sub_ind]+=60;
			granee(&timer_time1[sub_ind1,sub_ind],0,1439);
			}
		else if((but_pult==butD)||(but_pult==butD_))
			{
			timer_time1[sub_ind1,sub_ind]-=60;
			granee(&timer_time1[sub_ind1,sub_ind],0,1439);
			}			
		}	  	
	else if(sub_ind2==1)
		{
		if((but_pult==butU)||(but_pult==butU_))
			{
			timer_time1[sub_ind1,sub_ind]=((timer_time1[sub_ind1,sub_ind]/5)+1)*5;
			granee(&timer_time1[sub_ind1,sub_ind],0,1435);
			}
		else if((but_pult==butD)||(but_pult==butD_))
			{
			timer_time1[sub_ind1,sub_ind]=((timer_time1[sub_ind1,sub_ind]/5)-1)*5;
			granee(&timer_time1[sub_ind1,sub_ind],0,1435);
			}			
		}	  				 
	else if(sub_ind2==2)
		{
		if((but_pult==butU)||(but_pult==butU_))
			{
			timer_time2[sub_ind1,sub_ind]+=60;
			granee(&timer_time2[sub_ind1,sub_ind],0,1439);
			}
		else if((but_pult==butD)||(but_pult==butD_))
			{
			timer_time2[sub_ind1,sub_ind]-=60;
			granee(&timer_time2[sub_ind1,sub_ind],0,1439);
			}			
		}	  	
	else if(sub_ind2==3)
		{
		if((but_pult==butU)||(but_pult==butU_))
			{
			timer_time2[sub_ind1,sub_ind]=((timer_time2[sub_ind1,sub_ind]/5)+1)*5;
			granee(&timer_time2[sub_ind1,sub_ind],0,1435);
			}
		else if((but_pult==butD)||(but_pult==butD_))
			{
			timer_time2[sub_ind1,sub_ind]=((timer_time2[sub_ind1,sub_ind]/5)-1)*5;
			granee(&timer_time2[sub_ind1,sub_ind],0,1435);
			}			
		} 
		
	else if(sub_ind2==4)
		{
		if((but_pult==butU)||(but_pult==butU_))
			{
			if(timer_mode[sub_ind1,sub_ind]==1)timer_mode[sub_ind1,sub_ind]=2;
			else if(timer_mode[sub_ind1,sub_ind]==2)timer_mode[sub_ind1,sub_ind]=3; 
			else timer_mode[sub_ind1,sub_ind]=1;
			}
		else if((but_pult==butD)||(but_pult==butD_))
			{
			if(timer_mode[sub_ind1,sub_ind]==1)timer_mode[sub_ind1,sub_ind]=3;
			else if(timer_mode[sub_ind1,sub_ind]==2)timer_mode[sub_ind1,sub_ind]=1; 
			else timer_mode[sub_ind1,sub_ind]=2;
			}			
		}		
		
	else if(sub_ind2==5)
		{
		if(timer_mode[sub_ind1,sub_ind]==1)
			{
			if((but_pult==butU)||(but_pult==butU_))
		    		{
				timer_data1[sub_ind1,sub_ind]=((timer_data1[sub_ind1,sub_ind]/10)+1)*10;
				granee(&timer_data1[sub_ind1,sub_ind],0,3000);
				}	
	    		else if((but_pult==butD)||(but_pult==butD_))
				{
				timer_data1[sub_ind1,sub_ind]=((timer_data1[sub_ind1,sub_ind]/10)-1)*10;
				granee(&timer_data1[sub_ind1,sub_ind],0,3000);
		    		}
		    	}	
		else if(timer_mode[sub_ind1,sub_ind]==2)
			{
			if((but_pult==butU)||(but_pult==butU_))
		    		{
				timer_data1[sub_ind1,sub_ind]++;
				granee(&timer_data1[sub_ind1,sub_ind],FP_FMIN,FP_FMAX);
				}	
	    		else if((but_pult==butD)||(but_pult==butD_))
				{
				timer_data1[sub_ind1,sub_ind]--;
				granee(&timer_data1[sub_ind1,sub_ind],FP_FMIN,FP_FMAX);
				}
		    	}	 
		else if(timer_mode[sub_ind1,sub_ind]==3)
			{
			if((but_pult==butU)||(but_pult==butU_))
		    		{
				timer_data1[sub_ind1,sub_ind]++;
				granee(&timer_data1[sub_ind1,sub_ind],0,EE_DV_NUM);
				}	
	    		else if((but_pult==butD)||(but_pult==butD_))
				{
				timer_data1[sub_ind1,sub_ind]--;
				granee(&timer_data1[sub_ind1,sub_ind],0,EE_DV_NUM);
				}
		    	}			    			
		}					  						
	}
		
else if(ind==iZero_load_set)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			ZL_TIME++;
			granee(&ZL_TIME,1,30);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			ZL_TIME--;
			granee(&ZL_TIME,1,30);
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
		
	else if(sub_ind==1)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=14;
    			}		
		}			
	}		 
	
else if(ind==iPid_set)
	{
	speed=1;
	if(sub_ind==0)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PID_PERIOD++;
			granee(&PID_PERIOD,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PID_PERIOD--;
			granee(&PID_PERIOD,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=1;
			}			 		 
		} 
	else if(sub_ind==1)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PID_K++;
			granee(&PID_K,1,10);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PID_K--;
			granee(&PID_K,1,10);
			}   
		else if(but_pult==butE)
			{
			sub_ind=2;
			}			 		 
		} 		   
	else if(sub_ind==2)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PID_K_P++;
			granee(&PID_K_P,1,10);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PID_K_P--;
			granee(&PID_K_P,1,10);
			}   
		else if(but_pult==butE)
			{
			sub_ind=3;
			}			 		 
		}  
	else if(sub_ind==3)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PID_K_D++;
			granee(&PID_K_D,1,10);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PID_K_D--;
			granee(&PID_K_D,1,10);
			}   
		else if(but_pult==butE)
			{
			sub_ind=4;
			}			 		 
		} 	
	else if(sub_ind==4)
		{
		if((but_pult==butR)||(but_pult==butR_))
			{
			PID_K_FP_DOWN++;
			granee(&PID_K_FP_DOWN,1,100);
			}           
		else if((but_pult==butL)||(but_pult==butL_))
			{
			PID_K_FP_DOWN--;
			granee(&PID_K_FP_DOWN,1,100);
			}   
		else if(but_pult==butE)
			{
			sub_ind=5;
			}			 		 
		} 											
	else if(sub_ind==5)
		{
		if(but_pult==butE)
    			{
    			ind=iSet;
    			sub_ind=15;
    			}		
		}			
	}					

but_pult=0;
}

//-----------------------------------------------
void can_in_an(void)
{ 
if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00000011)       //плата индикации
	{ 
	if(fifo_can_in[ptr_rx_rd,0]==0xff)
		{
		char temp;
		if((fifo_can_in[ptr_rx_rd,3]==0x55)&&(fifo_can_in[ptr_rx_rd,4]==0x55)&&(fifo_can_in[ptr_rx_rd,5]==0x55)&&(fifo_can_in[ptr_rx_rd,6]==0x55))
			{
		    //	plazma++;
			temp=read_ds14287(HOURS);
			temp++;
			gran_ring_char(&temp,0,23);
			write_ds14287(HOURS,temp);
			}
   /*		else if((fifo_can_in[ptr_rx_rd,3]==0xaa)&&(fifo_can_in[ptr_rx_rd,4]==0xaa)&&(fifo_can_in[ptr_rx_rd,5]==0xaa)&&(fifo_can_in[ptr_rx_rd,6]==0xaa))
			{
			temp=read_ds14287(HOURS);
			temp--;
			gran_ring_char(&temp,0,23);
			write_ds14287(HOURS,temp);
			}*/ 
		else if((fifo_can_in[ptr_rx_rd,3]==0x99)&&(fifo_can_in[ptr_rx_rd,4]==0x99)&&(fifo_can_in[ptr_rx_rd,5]==0x99)&&(fifo_can_in[ptr_rx_rd,6]==0x99))
			{
			temp=read_ds14287(MINUTES);
			temp++;
			gran_ring_char(&temp,0,59);
			write_ds14287(MINUTES,temp);
			}
 /*		else if((fifo_can_in[ptr_rx_rd,3]==0x66)&&(fifo_can_in[ptr_rx_rd,4]==0x66)&&(fifo_can_in[ptr_rx_rd,5]==0x66)&&(fifo_can_in[ptr_rx_rd,6]==0x66))
			{
			temp=read_ds14287(MINUTES);
			temp--;
			gran_ring_char(&temp,0,59);
			write_ds14287(MINUTES,temp);
			}  */
		else if((fifo_can_in[ptr_rx_rd,3]==0x66)&&(fifo_can_in[ptr_rx_rd,4]==0x66)&&(fifo_can_in[ptr_rx_rd,5]==0x66)&&(fifo_can_in[ptr_rx_rd,6]==0x66))
			{
		    //	plazma++;
			p_ind_cnt=20;
			P_UST_EE=((P_UST_EE/10)+1)*10;
			granee(&P_UST_EE,0,3000);
			}

		else if((fifo_can_in[ptr_rx_rd,3]==0x67)&&(fifo_can_in[ptr_rx_rd,4]==0x67)&&(fifo_can_in[ptr_rx_rd,5]==0x67)&&(fifo_can_in[ptr_rx_rd,6]==0x67))
			{
			p_ind_cnt=20;
			P_UST_EE=((P_UST_EE/10)+10)*10;
			granee(&P_UST_EE,0,3000);
			}												
		
		else if((fifo_can_in[ptr_rx_rd,3]==0x77)&&(fifo_can_in[ptr_rx_rd,4]==0x77)&&(fifo_can_in[ptr_rx_rd,5]==0x77)&&(fifo_can_in[ptr_rx_rd,6]==0x77))
			{
			p_ind_cnt=20;
			P_UST_EE=((P_UST_EE/10)-1)*10;
			granee(&P_UST_EE,0,3000);
			}

		else if((fifo_can_in[ptr_rx_rd,3]==0x76)&&(fifo_can_in[ptr_rx_rd,4]==0x76)&&(fifo_can_in[ptr_rx_rd,5]==0x76)&&(fifo_can_in[ptr_rx_rd,6]==0x76))
			{
			p_ind_cnt=20;
			P_UST_EE=((P_UST_EE/10)-10)*10;
			granee(&P_UST_EE,0,3000);
			}												
		}		
	}

else if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00100011)       //пульт
	{   
	if(fifo_can_in[ptr_rx_rd,0]==0xff)
		{
		if(fifo_can_in[ptr_rx_rd,3]==fifo_can_in[ptr_rx_rd,4])
			{
			but_pult=fifo_can_in[ptr_rx_rd,3];
			but_an_pult();
			}
		}         
	}

else if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00000001)
	{
    	//plazma++;
	if(fifo_can_in[ptr_rx_rd,0]==0x08)
		{
		signed long temp_SL;
	    	granee(&Kida[0],150,500);
		granee(&Kidc[0],150,500);
		granee(&Kida[1],150,500);
		granee(&Kidc[1],150,500); 
		
		
		
		if(dv_on[0]!=dvFR)
			{
			temp_SL=fifo_can_in[ptr_rx_rd,5]+(fifo_can_in[ptr_rx_rd,6]*256);
			//plazma=(int)temp_SL;
			if(temp_SL<10)temp_SL=0;
			Ida[0]=(temp_SL*(signed long)Kida[0])/10000; 
			//Ida[0]=50;
		
			temp_SL=fifo_can_in[ptr_rx_rd,7]+(fifo_can_in[ptr_rx_rd,8]*256);
			if(temp_SL<10)temp_SL=0;		
	    		Idc[0]=(temp_SL*(signed long)Kidc[0])/10000;
			//Idc[0]=50;   
			
			Id[0]=(Ida[0]+Idc[0])/2;
		     }
		//if(!((pilot_dv==0)&&(fp_stat==dvON)))Id[0]=(Ida[0]+Idc[0])/2;
		
		if(dv_on[1]!=dvFR)
			{    
			temp_SL=fifo_can_in[ptr_rx_rd,9]+(fifo_can_in[ptr_rx_rd,10]*256);
			if(temp_SL<10)temp_SL=0;
			Ida[1]=(temp_SL*(signed long)Kida[1])/10000;
	     	//Ida[1]=50;
	 	
	 		temp_SL=fifo_can_in[ptr_rx_rd,11]+(fifo_can_in[ptr_rx_rd,12]*256);
			if(temp_SL<10)temp_SL=0;
	    		Idc[1]=(temp_SL*(signed long)Kidc[1])/10000;
          	//Idc[1]=50;   
          	
          	Id[1]=(Ida[1]+Idc[1])/2;
          	}
       	
       	if(!((pilot_dv==1)&&(fp_stat==dvON)))Id[1]=(Ida[1]+Idc[1])/2;
		}
	else if(fifo_can_in[ptr_rx_rd,0]==0x09)
		{
			plazma++;
		plazma_int[0]=fifo_can_in[ptr_rx_rd,3]+(fifo_can_in[ptr_rx_rd,4]*256);
	    	if(fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])av_serv[0]=fifo_can_in[ptr_rx_rd,6];
	    	if(fifo_can_in[ptr_rx_rd,7]==fifo_can_in[ptr_rx_rd,7])av_serv[1]=fifo_can_in[ptr_rx_rd,8];
	    	if(fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])av_serv[2]=fifo_can_in[ptr_rx_rd,10];
	    	if(fifo_can_in[ptr_rx_rd,11]==fifo_can_in[ptr_rx_rd,12])av_serv[3]=fifo_can_in[ptr_rx_rd,12];		
	    	}	
	else if(fifo_can_in[ptr_rx_rd,0]==0x0a)
		{
		plazma_int[1]=fifo_can_in[ptr_rx_rd,3]+(fifo_can_in[ptr_rx_rd,4]*256);
		if(fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])av_upp[0]=fifo_can_in[ptr_rx_rd,6];
	    	if(fifo_can_in[ptr_rx_rd,7]==fifo_can_in[ptr_rx_rd,7])av_upp[1]=fifo_can_in[ptr_rx_rd,8];
		if(fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])av_upp[2]=fifo_can_in[ptr_rx_rd,10];
	   	if(fifo_can_in[ptr_rx_rd,11]==fifo_can_in[ptr_rx_rd,12])av_upp[3]=fifo_can_in[ptr_rx_rd,12];
		}			
     } 
     
else if((fifo_can_in[ptr_rx_rd,0]==0xff)&&((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00100011))
	{
    //	plazma--;
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

spi_write(RXM0SIDH, 0x00); 
spi_write(RXM0SIDL, 0x00); 
spi_write(RXM0EID8, 0x00); 
spi_write(RXM0EID0, 0x00); 


spi_write(RXF0SIDH, 0b00000000); 
spi_write(RXF0SIDL, 0b00001000);
spi_write(RXF0EID8, 0x00000000); 
spi_write(RXF0EID0, 0b00000100);


spi_write(RXM1SIDH, 0xff); 
spi_write(RXM1SIDL, 0xff); 
spi_write(RXM1EID8, 0xff); 
spi_write(RXM1EID0, 0xff);

delay_ms(10);



spi_bit_modify(CANCTRL,0xe7,0b00000111);

spi_write(CANINTE,0b00011111);
delay_ms(100);
spi_write(BFPCTRL,0b00000000);  

}       


//-----------------------------------------------
void read_m8(void)
{
char i,temp_D,temp_P;
DDRE|=0b11000000;
temp_P=PORTA;
temp_D=DDRA;

DDRA=0;

PORTE&=~(1<<6);
delay_us(5);

for(i=0;i<12;i++)
	{
	PORTE&=~(1<<7);
	delay_us(25);
	temp_m8[i]=PINA;
	PORTE|=(1<<7);
	delay_us(25);
	}
PORTE|=(1<<6);	

if((temp_m8[7]==crc_87(temp_m8,7))&&(temp_m8[8]==crc_95(temp_m8,8)))
	{
    //	plazma++;
	*((char*)&unet_bank_[0])=temp_m8[0];
	*(((char*)&unet_bank_[0])+1)=temp_m8[1];
	*((char*)&unet_bank_[1])=temp_m8[2];
	*(((char*)&unet_bank_[1])+1)=temp_m8[3];
	*((char*)&unet_bank_[2])=temp_m8[4];
	*(((char*)&unet_bank_[2])+1)=temp_m8[5];
	cher_cnt=temp_m8[6];
	} 

DDRA=temp_D;
PORTA=temp_P;	

}
//***********************************************
//***********************************************
//***********************************************
// Timer 2 overflow interrupt service routine
interrupt [TIM2_OVF] void timer2_ovf_isr(void)
{ 
#asm("cli")
TCCR2=0x03;
TCNT2=-122;
TIMSK|=0x40;

adc_drv();

#asm("sei")	

}

//***********************************************
// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{        
t0_init();
#asm("cli")
if(++t0cnt000>=2)
	{
	t0cnt000=0;
	mcp_drv();
	}	
#asm("sei") 

modbus_drv();

if(++t0cnt0_>=10)
	{
	t0cnt0_=0;
	b100Hz=1;
	
	
	if(++t0cnt0>=10)
		{
    		t0cnt0=0;
		b10Hz=1;
		if(++t0cnt1>=2)
	    		{
	    		t0cnt1=0;
			b5Hz=1;
		
			}
    		if(++t0cnt2>=5)
			{
			t0cnt2=0;
			b2Hz=1;
			} 
		if(++t0cnt3>=10)
			{
	    		t0cnt3=0;
			b1Hz=1;
  
			}				
		}	
	}
}






//===============================================
//===============================================
//===============================================
//===============================================

void main(void)
{
// Declare your local variables here
char temp;
unsigned temp_U; 
/*
modbus_buffer[0]=0x01;
modbus_buffer[1]=0x0f;
modbus_buffer[2]=0x00;
modbus_buffer[3]=0x00;
modbus_buffer[4]=0x00;
modbus_buffer[5]=0x20;
modbus_buffer[6]=0x04;
modbus_buffer[7]=0x3c;
modbus_buffer[8]=0x04;
modbus_buffer[9]=0x00;
modbus_buffer[10]=0x00;
modbus_buffer[11]=0x00;
modbus_buffer[12]=0x00;
temp_U=crc16(modbus_buffer,11);
modbus_buffer[11]=*(((char*)(&temp_U))+1);
modbus_buffer[12]=*((char*)&temp_U);
*/

// Reset Source checking
if (MCUCSR & 1)
   {
   // Power-on Reset
   MCUCSR&=0xE0;
   // Place your code here

   }
else if (MCUCSR & 2)
   {
   // External Reset
   MCUCSR&=0xE0;
   // Place your code here

   }
else if (MCUCSR & 4)
   {
   // Brown-Out Reset
   MCUCSR&=0xE0;
   // Place your code here

   }
else if (MCUCSR & 8)
   {
   // Watchdog Reset
   MCUCSR&=0xE0;
   // Place your code here

   }
else if (MCUCSR & 0x10)
   {
   // JTAG Reset
   MCUCSR&=0xE0;
   // Place your code here

   };

 
PORTA=0x00;
DDRA=0x00;

PORTB=0x01;
DDRB=0x00;

PORTC=0x00;
DDRC=0x00;

PORTD=0x00;
DDRD=0x00;

PORTE=0x01;
DDRE=0x00;

PORTF=0x00;
DDRF=0x00;

PORTG=0x00;
DDRG=0x00;

t0_init();
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: Timer 1 Stopped
// Mode: Normal top=FFFFh
// OC1A output: Discon.
// OC1B output: Discon.
// OC1C output: Discon.
// Noise Canceler: Off
// Input Capture on Falling Edge
TCCR1A=0x00;
TCCR1B=0x00;
TCNT1H=0x00;
TCNT1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

t2_init();

// Timer/Counter 3 initialization
// Clock source: System Clock
// Clock value: Timer 3 Stopped
// Mode: Normal top=FFFFh
// OC3A output: Discon.
// OC3B output: Discon.
// OC3C output: Discon.
TCCR3A=0x00;
TCCR3B=0x00;
TCNT3H=0x00;
TCNT3L=0x00;
OCR3AH=0x00;
OCR3AL=0x00;
OCR3BH=0x00;
OCR3BL=0x00;
OCR3CH=0x00;
OCR3CL=0x00;

// External Interrupt(s) initialization
// INT0: Off
// INT1: Off
// INT2: Off
// INT3: Off
// INT4: Off
// INT5: Off
// INT6: Off
// INT7: Off
EICRA=0x00;
EICRB=0x00;
EIMSK=0x00;

// Timer(s)/Counter(s) Interrupt(s) initialization
TIMSK=0x41;
ETIMSK=0x00;

// Analog Comparator initialization
// Analog Comparator: Off
// Analog Comparator Input Capture by Timer/Counter 1: Off
// Analog Comparator Output: Off
ACSR=0x80;
SFIOR=0x00;



// USART0 initialization
// Communication Parameters: 8 Data, 2 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud rate: 9600
UCSR0A=0x00;
UCSR0B=0xD8;
UCSR0C=0x0E;
/*UBRR0H=0x06;
UBRR0L=0x82; //300*/
/*UBRR0H=0x03;
UBRR0L=0x40;//600*/
/*UBRR0H=0x01;
UBRR0L=0xA0;//1200*/
/*UBRR0H=0x00;
UBRR0L=0xCF;//2400 */
UBRR0H=0x00;
UBRR0L=0x67;//4800 

#asm("sei")
can_init();
write_ds14287(REGISTER_A,0x20);
write_ds14287(REGISTER_B,read_ds14287(REGISTER_B)|0x06);
ind=iAv_sel; 
//ind=iDeb;
sub_ind=0;
index_set=0;
/*EE_LEVEL[3]=75;
EE_LEVEL[2]=60;
EE_LEVEL[1]=50;
EE_LEVEL[0]=20;*/

//av_hndl(0x2a,0,0);

//RESURS_CNT[0]=6;
//RESURS_CNT[1]=8;
//pilot_dv=0;


/*
EE_MODE=emMNL;
TEMPER_SIGN=0;
AV_TEMPER_COOL=10;
T_ON_WARM=15;
T_ON_COOL=40;
AV_TEMPER_HEAT=50;
TEMPER_GIST=5;
AV_NET_PERCENT=10;
fasing=f_ABC;
P_SENS=6;
P_MIN=10;
P_MAX=20;
T_MAXMIN=5;
G_MAXMIN=5;
EE_DV_NUM=3;
STAR_TRIAN=stON;
DV_MODE[0]=dm_AVT;
DV_MODE[1]=dm_AVT;
DV_MODE[2]=dm_AVT;
RESURS_CNT[0]=0;
RESURS_CNT[1]=0;
RESURS_CNT[2]=0;
*/


/*
//Переменные в EEPROM 
eeprom enum {dm_AVT=0x55,dm_MNL=0xAA};		//режимы работы насосов
eeprom unsigned int RESURS_CNT[6];					//Счетчики моторесурса насосов
eeprom signed Idmin;							//Ток насоса минимальный 
eeprom signed Idmax;							//Ток насоса максимальный 
eeprom signed Kida[6],Kidc[6]; 					//Калибровка токов двигателей
eeprom signed C1N;								//_____________________
eeprom signed DV_DUMM[10];

eeprom signed SS_LEVEL;							//Ступенчатый пуск - 
eeprom signed SS_STEP;							//Ступенчатый пуск -
eeprom signed SS_TIME;							//Ступенчатый пуск -
eeprom signed SS_FRIQ;							//Ступенчатый пуск -
eeprom signed SS_DUMM[10];

eeprom signed DVCH_T_UP;							//Переключение насосов - 
eeprom signed DVCH_T_DOWN;						//Переключение насосов -
eeprom signed DVCH_P_KR;							//Переключение насосов -
eeprom signed DVCH_KP;							//Переключение насосов -
eeprom signed DVCH_TIME;							//Переключение насосов - 
eeprom enum {dvch_ON=0x55,dvch_OFF=0xAA}DVCH;		//Переключение насосов - 
eeprom signed DVCH_DUMM[10];

eeprom signed FP_FMIN;							//Частотный преобразователь - минимальная частота
eeprom signed FP_FMAX;							//Частотный преобразователь - максимальная частота  
eeprom signed FP_TPAD;							//Частотный преобразователь - 
eeprom signed FP_TVOZVR;							//Частотный преобразователь -  
eeprom signed FP_CH; 							//Частотный преобразователь - 
eeprom signed FP_P_PL;							//Частотный преобразователь - 
eeprom signed FP_P_MI;							//Частотный преобразователь - 
eeprom signed FP_DUMM[10];

eeprom enum {dON=0x55,dOFF=0xAA}DOOR;				//Задвижка - 
eeprom signed DOOR_IMIN;							//Задвижка - 
eeprom signed DOOR_IMAX;							//Задвижка -
eeprom enum {dmS=0x55,dmA=0xAA}DOOR_MODE;			//Задвижка -
eeprom signed DOOR_DUMM[10];

eeprom enum {pON=0x55,pOFF=0xAA}PROBE;				//Пробный пуск - 
eeprom signed PROBE_DUTY;						//Пробный пуск -
eeprom signed PROBE_TIME;						//Пробный пуск -
eeprom signed PROBE_DUMM[10];

eeprom enum {hhWMS=0x55}HH_SENS;					//Сухой ход - 
eeprom signed HH_P;								//Сухой ход - 
eeprom signed HH_TIME;					    		//Сухой ход - 
eeprom signed HH_DUMM[10];

eeprom signed ZL_TIME;					    		//Нулевая нагрузка - 
eeprom signed ZL_DUMM[10];       

eeprom signed  ;
*/
//p_ust=200;


while (1)
	{
	static char tr_ind_cnt;
	if(bModbus_in)
		{
		
		bModbus_in=0;
		modbus_in_an();
		}
	if(b100Hz)
		{
		b100Hz=0;
		can_hndl();
		//ind_transmit_hndl();
		but_drv();

		}	   
	if(b10Hz)
		{
		
		b10Hz=0;
		
		//Подпрограммы исполняемые 10 раз в секунду 
		rel_in_drv();  
		
	          if(++tr_ind_cnt>=4)tr_ind_cnt=0;
		can_out_adr(0b11110000+tr_ind_cnt,0b00000000,&data_for_ind[10*tr_ind_cnt]); 
          
		mode_hndl();
		power_hndl(); 
		fp_hndl();
		av_hh_drv();
		pid_drv();
		
		p_max_min_hndl();
		p_kr_drv();
		
		if(bCAN_EX)
          	{
          	can_out_adr(0b00000000,0b00000000,&data_for_ex[0,0]); 
          	bCAN_EX=0;
          	}
	    else 
	    		{
	    		can_out_adr(0b00000001,0b00000000,&data_for_ex[1,0]);
               bCAN_EX=1;
               }
		}	
	if(b5Hz)
		{
		b5Hz=0;
          
          //Подпрограммы исполняемые 5 раз в секунду
          out_drv();                    //Вывод на реле
          adc_mat_hndl();               //Драйвер АЦП, цифровая фильтрация измеренных величин
         	matemat();				//Математическая обработка измеренных АЦП величин
		cool_warm_drv();			//управление отопителем и охладителем
		avar_i_drv();                 //драйвер аварий по току
		avar_drv();                   //драйвер аварий
		serv_drv();				//действия в режиме сервиса(сброс аварий)
		//can_init();
		
		motor_potenz_hndl();		//Определение насоса, выключаемого или(и) включаемого 
		control();				//Включение и выключение насосов  
		plata_ex_hndl();
	    	
		
	    
		dv_access_hndl();
		//ptr_tx_rd=0;
	    	//can_out_adr(0b11110000,0b00000000,&data_for_ind[0]);
	    	/*can_out_adr(0b11110001,0b00000000,&data_for_ind[10]);
	    	can_out_adr(0b11110010,0b00000000,&data_for_ind[20]);*/
	    	//can_out_adr(0b11110011,0b00000000,&data_for_ind[30]);

		ind_hndl();    			//обработка индикации для пульта
          plata_ind_hndl();             //обработка индикации для платы индикации 
	    	
	    	can_out_adr(0xfc,0x00,lcd_buffer);
	    	can_out_adr(0xfd,0x00,lcd_buffer+10);
	    	can_out_adr(0xfe,0x00,lcd_buffer+20);
	    	can_out_adr(0xff,0x00,lcd_buffer+30); 
	    	

	   //	set_kalibr_blok_drv();		//обработка джампера, непускающего в установки и калибровки
          ret_ind_hndl();
          
          av_sens_p_hndl();
          av_fp_hndl();
          read_m8();
		}
	if(b2Hz)
		{
		b2Hz=0;
		ds14287_drv();
                                                       
		}								
	if(b1Hz)
		{
		b1Hz=0;
          
		//Подпрограммы исполняемые 1 раз в секунду
		if(main_cnt<100)main_cnt++;   //Счетчик секунд от начала работы, досчитывает до 100
		out_hndl();				//Включение и выключение насосов, реле аварии, вентилятора и отопителя

		resurs_drv();				//Подсчёт ресурса(наработки) насосов
          
          
          
          
          //out_usart0(9,1,2,3,4,5,6,7,8,9);
          
          num_necc_drv();     		//Расчёт количества необходимых насосов
          modbus_request_hndl();
          
          time_sezon_drv(); 
          p_ust_hndl();
          
          pilot_ch_hndl();
          zl_hndl();
		}
	}
}

/*		tr_ind_cnt++;
		if(tr_ind_cnt==25)tr_ind_cnt=0;
		
		if(tr_ind_cnt==0)can_out_adr(0b00000000,0b00000000,&data_for_ex[0,0]);
          else if(tr_ind_cnt==3)can_out_adr(0xfc,0x00,lcd_buffer);
          else if(tr_ind_cnt==6)can_out_adr(0b11110000,0b00000000,&data_for_ind[0]);
          else if(tr_ind_cnt==9)can_out_adr(0xfc,0x00,lcd_buffer+10);
          else if(tr_ind_cnt==12)can_out_adr(0b11110001,0b00000000,&data_for_ind[10]);
          else if(tr_ind_cnt==15)can_out_adr(0xfc,0x00,lcd_buffer+20);
          else if(tr_ind_cnt==18)can_out_adr(0b11110010,0b00000000,&data_for_ind[20]);
          else if(tr_ind_cnt==21)can_out_adr(0xfc,0x00,lcd_buffer+30);

 */


