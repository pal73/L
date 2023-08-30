;CodeVisionAVR C Compiler V1.24.1d Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.ro
;e-mail:office@hpinfotech.ro

;Chip type           : ATmega128
;Program type        : Application
;Clock frequency     : 8,000000 MHz
;Memory model        : Small
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : long, width
;External SRAM size  : 0
;Data Stack size     : 1024 byte(s)
;Heap size           : 0 byte(s)
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_adc_noise_red=0x08
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "snk7mb.vec"
	.INCLUDE "snk7mb.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30
	OUT  RAMPZ,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x1000)
	LDI  R25,HIGH(0x1000)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x10FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x10FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x500)
	LDI  R29,HIGH(0x500)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500
;       1 #define CNF1_INIT	0b00000001  //tq=500ns   //8MHz
;       2 #define CNF2_INIT	0b10110001  //Ps1=7tq,Pr=2tq 
;       3 #define CNF3_INIT	0b00000101  //Ps2=6tq
;       4         
;       5 #define RESURS_CNT_SEC_IN_HOUR 3600
;       6 
;       7 #define FIFO_CAN_IN_LEN	10
;       8 #define FIFO_CAN_OUT_LEN	10
;       9                 
;      10 #define CS_DDR	DDRB.4
;      11 #define CS	PORTB.4 
;      12 #define SPI_PORT_INIT  DDRB.1=1;DDRB.2=1;DDRB.3=0;DDRB.4=1;SPCR=0x50;SPSR=0x00; 
;      13 
;      14 #define RESET_OFF      	DDRG|=0b00000010; PORTG|=0b00000010;
;      15 #define RD_OFF      	DDRG|=0b00000001; PORTG|=0b00000001;
;      16 #define WR_OFF      	DDRD.7=1; PORTD.7=1;
;      17 #define CS_ON      		DDRD.5=1; PORTD.5=0;
;      18 #define PORT_OUT      	DDRC=0xff;
;      19 #define AS_STROB   		DDRD.6=1; PORTD.6=1;PORTD.6=1;PORTD.6=1;PORTD.6=0;
;      20 #define PORT			PORTC
;      21 #define PORT_PIN		PINC
;      22 #define PORT_IN      	DDRC=0x00;
;      23 #define RD_ON      		DDRG|=0b00000001; PORTG&=0b11111110;
;      24 #define CS_OFF      	DDRD.5=1; PORTD.5=1;
;      25 #define WR_ON	      	DDRD.7=1; PORTD.7=0;
;      26 
;      27 #include <mega128.h>
;      28 #include <delay.h>
;      29 #include <stdio.h> 
;      30 #include <math.h>
;      31 #include "gran.c"
;      32 //-----------------------------------------------
;      33 void gran_ring_char(signed char *adr, signed char min, signed char max)
;      34 {

	.CSEG
_gran_ring_char:
;      35 if (*adr<min) *adr=max;
	CALL SUBOPT_0x0
	BRGE _0x3
	CALL SUBOPT_0x1
;      36 if (*adr>max) *adr=min; 
_0x3:
	CALL SUBOPT_0x2
	BRGE _0x4
	CALL SUBOPT_0x3
;      37 } 
_0x4:
	RJMP _0xB47
;      38  
;      39 //-----------------------------------------------
;      40 void gran_char(signed char *adr, signed char min, signed char max)
;      41 {
_gran_char:
;      42 if (*adr<min) *adr=min;
	CALL SUBOPT_0x0
	BRGE _0x5
	CALL SUBOPT_0x3
;      43 if (*adr>max) *adr=max; 
_0x5:
	CALL SUBOPT_0x2
	BRGE _0x6
	CALL SUBOPT_0x1
;      44 } 
_0x6:
	RJMP _0xB47
;      45 
;      46 //-----------------------------------------------
;      47 void gran(signed int *adr, signed int min, signed int max)
;      48 {
_gran:
;      49 if (*adr<min) *adr=min;
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	CALL SUBOPT_0x4
	BRGE _0x7
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
;      50 if (*adr>max) *adr=max; 
_0x7:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __GETW1P
	CALL SUBOPT_0x5
	BRGE _0x8
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ST   X+,R30
	ST   X,R31
;      51 } 
_0x8:
	RJMP _0xB49
;      52 
;      53 //-----------------------------------------------
;      54 void gran_ring(signed int *adr, signed int min, signed int max)
;      55 {
;      56 if (*adr<min) *adr=max;
;      57 if (*adr>max) *adr=min; 
;      58 } 
;      59 
;      60 //-----------------------------------------------
;      61 void granee_ee(eeprom signed int *adr, signed int min, eeprom signed int* adr_max)
;      62 {
;      63 if (*adr<min) *adr=min;
;      64 if (*adr>*adr_max) *adr=*adr_max; 
;      65 } 
;      66 
;      67 //-----------------------------------------------
;      68 void granee(eeprom signed int *adr, signed int min, signed int max)
;      69 {
_granee:
;      70 if (*adr<min) *adr=min;
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	CALL SUBOPT_0x4
	BRGE _0xD
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
;      71 if (*adr>max) *adr=max; 
_0xD:
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMRDW
	CALL SUBOPT_0x5
	BRGE _0xE
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL __EEPROMWRW
;      72 } 
_0xE:
_0xB49:
	ADIW R28,6
	RET
;      73 
;      74 //-----------------------------------------------
;      75 void gran_ring_ee(eeprom signed int *adr, signed int min, signed int max)
;      76 {
;      77 if (*adr<min) *adr=min;
;      78 if (*adr>max) *adr=max; 
;      79 } 
;      80 
;      81 flash char Table95[]={
;      82 0x00, 0x2A, 0x54, 0x7E, 0xA8, 0x82, 0xFC, 0xD6, 0x7A, 0x50, 0x2E, 0x04, 0xD2, 0xF8, 0x86, 0xAC,
;      83 0xF4, 0xDE, 0xA0, 0x8A, 0x5C, 0x76, 0x08, 0x22, 0x8E, 0xA4, 0xDA, 0xF0, 0x26, 0x0C, 0x72, 0x58,
;      84 0xC2, 0xE8, 0x96, 0xBC, 0x6A, 0x40, 0x3E, 0x14, 0xB8, 0x92, 0xEC, 0xC6, 0x10, 0x3A, 0x44, 0x6E,
;      85 0x36, 0x1C, 0x62, 0x48, 0x9E, 0xB4, 0xCA, 0xE0, 0x4C, 0x66, 0x18, 0x32, 0xE4, 0xCE, 0xB0, 0x9A,
;      86 0xAE, 0x84, 0xFA, 0xD0, 0x06, 0x2C, 0x52, 0x78, 0xD4, 0xFE, 0x80, 0xAA, 0x7C, 0x56, 0x28, 0x02,
;      87 0x5A, 0x70, 0x0E, 0x24, 0xF2, 0xD8, 0xA6, 0x8C, 0x20, 0x0A, 0x74, 0x5E, 0x88, 0xA2, 0xDC, 0xF6,
;      88 0x6C, 0x46, 0x38, 0x12, 0xC4, 0xEE, 0x90, 0xBA, 0x16, 0x3C, 0x42, 0x68, 0xBE, 0x94, 0xEA, 0xC0,
;      89 0x98, 0xB2, 0xCC, 0xE6, 0x30, 0x1A, 0x64, 0x4E, 0xE2, 0xC8, 0xB6, 0x9C, 0x4A, 0x60, 0x1E, 0x34,
;      90 0x76, 0x5C, 0x22, 0x08, 0xDE, 0xF4, 0x8A, 0xA0, 0x0C, 0x26, 0x58, 0x72, 0xA4, 0x8E, 0xF0, 0xDA,
;      91 0x82, 0xA8, 0xD6, 0xFC, 0x2A, 0x00, 0x7E, 0x54, 0xF8, 0xD2, 0xAC, 0x86, 0x50, 0x7A, 0x04, 0x2E,
;      92 0xB4, 0x9E, 0xE0, 0xCA, 0x1C, 0x36, 0x48, 0x62, 0xCE, 0xE4, 0x9A, 0xB0, 0x66, 0x4C, 0x32, 0x18,
;      93 0x40, 0x6A, 0x14, 0x3E, 0xE8, 0xC2, 0xBC, 0x96, 0x3A, 0x10, 0x6E, 0x44, 0x92, 0xB8, 0xC6, 0xEC, 
;      94 0xD8, 0xF2, 0x8C, 0xA6, 0x70, 0x5A, 0x24, 0x0E, 0xA2, 0x88, 0xF6, 0xDC, 0x0A, 0x20, 0x5E, 0x74, 
;      95 0x2C, 0x06, 0x78, 0x52, 0x84, 0xAE, 0xD0, 0xFA, 0x56, 0x7C, 0x02, 0x28, 0xFE, 0xD4, 0xAA, 0x80, 
;      96 0x1A, 0x30, 0x4E, 0x64, 0xB2, 0x98, 0xE6, 0xCC, 0x60, 0x4A, 0x34, 0x1E, 0xC8, 0xE2, 0x9C, 0xB6, 
;      97 0xEE, 0xC4, 0xBA, 0x90, 0x46, 0x6C, 0x12, 0x38, 0x94, 0xBE, 0xC0, 0xEA, 0x3C, 0x16, 0x68, 0x42}; 
;      98 
;      99 const char Table87[]={ 
;     100 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     101 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     102 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     103 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     104 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     105 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     106 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     107 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     108 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     109 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     110 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     111 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     112 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     113 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     114 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     115 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     116 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     117 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     118 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     119 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     120 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     121 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     122 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     123 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     124 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     125 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     126 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     127 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     128 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     129 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     130 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     131 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     132 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     133 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     134 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     135 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     136 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     137 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     138 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     139 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     140 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     141 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     142 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     143 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     144 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     145 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     146 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     147 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     148 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     149 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     150 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     151 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     152 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     153 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     154 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     155 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     156 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     157 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     158 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     159 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     160 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     161 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     162 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     163 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     164 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     165 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     166 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     167 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     168 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     169 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     170 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     171 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     172 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     173 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     174 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     175 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     176 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     177 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     178 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     179 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     180 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     181 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     182 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     183 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     184 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     185 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     186 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     187 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     188 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     189 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     190 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     191 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     192 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     193 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     194 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     195 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     196 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     197 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     198 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     199 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     200 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     201 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     202 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     203 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     204 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     205 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     206 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     207 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     208 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     209 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     210 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     211 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     212 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     213 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     214 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     215 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     216 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     217 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     218 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     219 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     220 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     221 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     222 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     223 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     224 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     225 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     226 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     227 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     228 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     229 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     230 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     231 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     232 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     233 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     234 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     235 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     236 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     237 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     238 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     239 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     240 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     241 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     242 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     243 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     244 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     245 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     246 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     247 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     248 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     249 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     250 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     251 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     252 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     253 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     254 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     255 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     256 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     257 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     258 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     259 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     260 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     261 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     262 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     263 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     264 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     265 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     266 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     267 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     268 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     269 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     270 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     271 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     272 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     273 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     274 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     275 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     276 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     277 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     278 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     279 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     280 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     281 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     282 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     283 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     284 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     285 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     286 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     287 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     288 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     289 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     290 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     291 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     292 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     293 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     294 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     295 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     296 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     297 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     298 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     299 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     300 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     301 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     302 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     303 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     304 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     305 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     306 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     307 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     308 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     309 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     310 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     311 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     312 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     313 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     314 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     315 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     316 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     317 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     318 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     319 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     320 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     321 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     322 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     323 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     324 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     325 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     326 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     327 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     328 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     329 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     330 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     331 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     332 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     333 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     334 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     335 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     336 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     337 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     338 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     339 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     340 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     341 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     342 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     343 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     344 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     345 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     346 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     347 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     348 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     349 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     350 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     351 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     352 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     353 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     354 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     355 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     356 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     357 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     358 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     359 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     360 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     361 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     362 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     363 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     364 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     365 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     366 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     367 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     368 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     369 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     370 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     371 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     372 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     373 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     374 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     375 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     376 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     377 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     378 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     379 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     380 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     381 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     382 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     383 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     384 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     385 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     386 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     387 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     388 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     389 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     390 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     391 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     392 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     393 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     394 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     395 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     396 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     397 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     398 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     399 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     400 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     401 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     402 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     403 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     404 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     405 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     406 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     407 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     408 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     409 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     410 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     411 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     412 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     413 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     414 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     415 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     416 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     417 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     418 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     419 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     420 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     421 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     422 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     423 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     424 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     425 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     426 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     427 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     428 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     429 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     430 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     431 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     432 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     433 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     434 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     435 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     436 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     437 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     438 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     439 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     440 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     441 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     442 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     443 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     444 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     445 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     446 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     447 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     448 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     449 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     450 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     451 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     452 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     453 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     454 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     455 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     456 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     457 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     458 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     459 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     460 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     461 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     462 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     463 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     464 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     465 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     466 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     467 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     468 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     469 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     470 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     471 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     472 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     473 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     474 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     475 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     476 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     477 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     478 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     479 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     480 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     481 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     482 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     483 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     484 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     485 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     486 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     487 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     488 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     489 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     490 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     491 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     492 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     493 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     494 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     495 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     496 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     497 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     498 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     499 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     500 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     501 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     502 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     503 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     504 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     505 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     506 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     507 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     508 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     509 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     510 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     511 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     512 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     513 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     514 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     515 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     516 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     517 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     518 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     519 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     520 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     521 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     522 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     523 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     524 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     525 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     526 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     527 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     528 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     529 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     530 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     531 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     532 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     533 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     534 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     535 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     536 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     537 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     538 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     539 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     540 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     541 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     542 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     543 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     544 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     545 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     546 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     547 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     548 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     549 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     550 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     551 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     552 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     553 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     554 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     555 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     556 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     557 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     558 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     559 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     560 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     561 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     562 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     563 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     564 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     565 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     566 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     567 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     568 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     569 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     570 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     571 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     572 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     573 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     574 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     575 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     576 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     577 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     578 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     579 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     580 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     581 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     582 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     583 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     584 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     585 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     586 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     587 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     588 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     589 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     590 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     591 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     592 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     593 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     594 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     595 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     596 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     597 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     598 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     599 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     600 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     601 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     602 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     603 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     604 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     605 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     606 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     607 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     608 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     609 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     610 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     611 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     612 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     613 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     614 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     615 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     616 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     617 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     618 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     619 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     620 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     621 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     622 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     623 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     624 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     625 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     626 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     627 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     628 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     629 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     630 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     631 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     632 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     633 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     634 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     635 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     636 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     637 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     638 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     639 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     640 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     641 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     642 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     643 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     644 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     645 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     646 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     647 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     648 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     649 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     650 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     651 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     652 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     653 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     654 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     655 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     656 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     657 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     658 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     659 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     660 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     661 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     662 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     663 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     664 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     665 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     666 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     667 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     668 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     669 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     670 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     671 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     672 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     673 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     674 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     675 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     676 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     677 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     678 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     679 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     680 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     681 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     682 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     683 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     684 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     685 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     686 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     687 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     688 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     689 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     690 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     691 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     692 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     693 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     694 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     695 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     696 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     697 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     698 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     699 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     700 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     701 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     702 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     703 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     704 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     705 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     706 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     707 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     708 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     709 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     710 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     711 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     712 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     713 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     714 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     715 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     716 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     717 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     718 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     719 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     720 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     721 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     722 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     723 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     724 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     725 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     726 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     727 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     728 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     729 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     730 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     731 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     732 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     733 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     734 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     735 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     736 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     737 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     738 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     739 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     740 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     741 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     742 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     743 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     744 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     745 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     746 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     747 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     748 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     749 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     750 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     751 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     752 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     753 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     754 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     755 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     756 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     757 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     758 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     759 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     760 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     761 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     762 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     763 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     764 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     765 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     766 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     767 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     768 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     769 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     770 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     771 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     772 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     773 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     774 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     775 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     776 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     777 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     778 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     779 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     780 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     781 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     782 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     783 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     784 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     785 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     786 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     787 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     788 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     789 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     790 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     791 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     792 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     793 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     794 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     795 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     796 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     797 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     798 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     799 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     800 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     801 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     802 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     803 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     804 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     805 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     806 0xCE, 0xC0, 0xD2, 0xDC, 0xF6, 0xF8, 0xEA, 0xE4, 0xBE, 0xB0, 0xA2, 0xAC, 0x86, 0x88, 0x9A, 0x94,
;     807 0x2E, 0x20, 0x32, 0x3C, 0x16, 0x18, 0x0A, 0x04, 0x5E, 0x50, 0x42, 0x4C, 0x66, 0x68, 0x7A, 0x74,
;     808 0x92, 0x9C, 0x8E, 0x80, 0xAA, 0xA4, 0xB6, 0xB8, 0xE2, 0xEC, 0xFE, 0xF0, 0xDA, 0xD4, 0xC6, 0xC8,
;     809 0x72, 0x7C, 0x6E, 0x60, 0x4A, 0x44, 0x56, 0x58, 0x02, 0x0C, 0x1E, 0x10, 0x3A, 0x34, 0x26, 0x28,
;     810 0x5C, 0x52, 0x40, 0x4E, 0x64, 0x6A, 0x78, 0x76, 0x2C, 0x22, 0x30, 0x3E, 0x14, 0x1A, 0x08, 0x06,
;     811 0xBC, 0xB2, 0xA0, 0xAE, 0x84, 0x8A, 0x98, 0x96, 0xCC, 0xC2, 0xD0, 0xDE, 0xF4, 0xFA, 0xE8, 0xE6,
;     812 0x2A, 0x24, 0x36, 0x38, 0x12, 0x1C, 0x0E, 0x00, 0x5A, 0x54, 0x46, 0x48, 0x62, 0x6C, 0x7E, 0x70,
;     813 0xCA, 0xC4, 0xD6, 0xD8, 0xF2, 0xFC, 0xEE, 0xE0, 0xBA, 0xB4, 0xA6, 0xA8, 0x82, 0x8C, 0x9E, 0x90,
;     814 0xE4, 0xEA, 0xF8, 0xF6, 0xDC, 0xD2, 0xC0, 0xCE, 0x94, 0x9A, 0x88, 0x86, 0xAC, 0xA2, 0xB0, 0xBE,
;     815 0x04, 0x0A, 0x18, 0x16, 0x3C, 0x32, 0x20, 0x2E, 0x74, 0x7A, 0x68, 0x66, 0x4C, 0x42, 0x50, 0x5E,
;     816 0xB8, 0xB6, 0xA4, 0xAA, 0x80, 0x8E, 0x9C, 0x92, 0xC8, 0xC6, 0xD4, 0xDA, 0xF0, 0xFE, 0xEC, 0xE2,
;     817 0x58, 0x56, 0x44, 0x4A, 0x60, 0x6E, 0x7C, 0x72, 0x28, 0x26, 0x34, 0x3A, 0x10, 0x1E, 0x0C, 0x02,
;     818 0x76, 0x78, 0x6A, 0x64, 0x4E, 0x40, 0x52, 0x5C, 0x06, 0x08, 0x1A, 0x14, 0x3E, 0x30, 0x22, 0x2C,
;     819 0x96, 0x98, 0x8A, 0x84, 0xAE, 0xA0, 0xB2, 0xBC, 0xE6, 0xE8, 0xFA, 0xF4, 0xDE, 0xD0, 0xC2, 0xCC,
;     820 0x00, 0x0E, 0x1C, 0x12, 0x38, 0x36, 0x24, 0x2A, 0x70, 0x7E, 0x6C, 0x62, 0x48, 0x46, 0x54, 0x5A,
;     821 0xE0, 0xEE, 0xFC, 0xF2, 0xD8, 0xD6, 0xC4, 0xCA, 0x90, 0x9E, 0x8C, 0x82, 0xA8, 0xA6, 0xB4, 0xBA,
;     822 0xCE, 0xC0
;     823 
;     824 };
;     825 
;     826 
;     827 
;     828 
;     829 
;     830 #include "ds14287.c"
;     831 #define SECONDS		0x00
;     832 #define SECONDS_ALARM	0x01
;     833 #define MINUTES		0x02
;     834 #define MINUTES_ALARM	0x03
;     835 #define HOURS			0x04
;     836 #define HOURS_ALARM		0x05
;     837 #define DAY_OF_THE_WEEK	0x06
;     838 #define DAY_OF_THE_MONTH	0x07
;     839 #define MONTH			0x08
;     840 #define YEAR			0x09
;     841 #define REGISTER_A		0x0A
;     842 #define REGISTER_B		0x0B
;     843 #define REGISTER_C		0x0C
;     844 #define REGISTER_D		0x0D
;     845 
;     846 //-----------------------------------------------
;     847 char read_ds14287(char adr)
;     848 { 
_read_ds14287:
;     849 char temp;      
;     850 RESET_OFF
	ST   -Y,R16
;	adr -> Y+1
;	temp -> R16
	CALL SUBOPT_0x6
;     851 RD_OFF
;     852 WR_OFF                                         
	SBI  0x11,7
	SBI  0x12,7
;     853 CS_ON
	SBI  0x11,5
	CBI  0x12,5
;     854 PORT_OUT
	CALL SUBOPT_0x7
;     855 PORT=adr;
;     856 AS_STROB 
	SBI  0x11,6
	SBI  0x12,6
	SBI  0x12,6
	SBI  0x12,6
	CBI  0x12,6
;     857 PORT_IN
	LDI  R30,LOW(0)
	OUT  0x14,R30
;     858 RD_ON
	CALL SUBOPT_0x8
;     859 RD_ON
	CALL SUBOPT_0x8
;     860 RD_ON
	CALL SUBOPT_0x8
;     861 RD_ON
	CALL SUBOPT_0x8
;     862 temp=PORT_PIN;
	IN   R16,19
;     863 RD_OFF
	LDS  R30,100
	ORI  R30,1
	STS  100,R30
	LDS  R30,101
	ORI  R30,1
	STS  101,R30
;     864 CS_OFF
	SBI  0x11,5
	SBI  0x12,5
;     865 return temp;
	MOV  R30,R16
	LDD  R16,Y+0
	RJMP _0xB48
;     866 } 
;     867 
;     868 //-----------------------------------------------
;     869 void write_ds14287(char adr, char in)
;     870 { 
_write_ds14287:
;     871 RESET_OFF
	CALL SUBOPT_0x6
;     872 RD_OFF
;     873 WR_OFF                                         
	SBI  0x11,7
	SBI  0x12,7
;     874 CS_ON
	SBI  0x11,5
	CBI  0x12,5
;     875 PORT_OUT
	CALL SUBOPT_0x7
;     876 PORT=adr;
;     877 AS_STROB 
	SBI  0x11,6
	SBI  0x12,6
	SBI  0x12,6
	SBI  0x12,6
	CBI  0x12,6
;     878 PORT_OUT
	LDI  R30,LOW(255)
	OUT  0x14,R30
;     879 PORT=in;
	LD   R30,Y
	OUT  0x15,R30
;     880 WR_ON
	SBI  0x11,7
	CBI  0x12,7
;     881 WR_ON
	SBI  0x11,7
	CBI  0x12,7
;     882 WR_OFF
	SBI  0x11,7
	SBI  0x12,7
;     883 CS_OFF
	SBI  0x11,5
	SBI  0x12,5
;     884 }
_0xB48:
	ADIW R28,2
	RET
;     885 
;     886 //**********************************************
;     887 //Переменные в EEPROM 
;     888 eeprom signed BEGIN_DUMM[10];

	.ESEG
_BEGIN_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     889 
;     890 eeprom enum {emAVT=0x55,emMNL=0xaa,emTST=0xcc}EE_MODE; //Режим работы станции   
_EE_MODE:
	.DB  0x0
;     891 
;     892 eeprom char TEMPER_SIGN;							//Сигнал климат-контроля(0-внутр,1-внешний)
_TEMPER_SIGN:
	.DB  0x0
;     893 eeprom signed AV_TEMPER_COOL; 					//Температура аварии по холоду климатконтроля
_AV_TEMPER_COOL:
	.DW  0x0
;     894 eeprom signed T_ON_WARM;							//Температура включения отопителя климатконтроля
_T_ON_WARM:
	.DW  0x0
;     895 eeprom signed T_ON_COOL;							//Температура включения вентилятора климатконтроля
_T_ON_COOL:
	.DW  0x0
;     896 eeprom signed AV_TEMPER_HEAT;                         	//Температура аварии по теплу климатконтроля
_AV_TEMPER_HEAT:
	.DW  0x0
;     897 eeprom signed TEMPER_GIST;                         	//Гистерезис климатконтроля  
_TEMPER_GIST:
	.DW  0x0
;     898 eeprom signed Kt[2];							//Калибровка датчиков температуры климатконтроля(0 - внутренний, 1 - внешний)
_Kt:
	.DW  0x0
	.DW  0x0
;     899 eeprom signed KLIMAT_DUMM[10];
_KLIMAT_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     900 
;     901 eeprom signed AV_NET_PERCENT;						//Допуск напряжения сети
_AV_NET_PERCENT:
	.DW  0x0
;     902 eeprom enum {f_ABC=0x55,f_ACB=0xAA}fasing;			//фазировка сети
_fasing:
	.DB  0x0
;     903 eeprom signed Kun[3];                                  //Калибровка напряжения фаз сети
_Kun:
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     904 eeprom signed NET_DUMM[10];
_NET_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     905 
;     906 eeprom char P_SENS;                                    //Тип датчика давления
_P_SENS:
	.DB  0x0
;     907 eeprom signed P_MIN;							//
_P_MIN:
	.DW  0x0
;     908 eeprom signed P_MAX;							//
_P_MAX:
	.DW  0x0
;     909 eeprom signed T_MAXMIN;							//
_T_MAXMIN:
	.DW  0x0
;     910 eeprom signed G_MAXMIN;							//
_G_MAXMIN:
	.DW  0x0
;     911 eeprom signed Kp0,Kp1;							//Калибровка датчика давления
_Kp0:
	.DW  0x0
_Kp1:
	.DW  0x0
;     912 eeprom signed P_DUMM[10];
_P_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     913 
;     914 eeprom char EE_DV_NUM;							//Количество насосов
_EE_DV_NUM:
	.DB  0x0
;     915 //#define EE_DV_NUM	2 
;     916 eeprom enum {stON=0x55,stOFF=0xAA}STAR_TRIAN;		//
_STAR_TRIAN:
	.DB  0x0
;     917 eeprom enum {dm_AVT=0x55,dm_MNL=0xAA}DV_MODE[7];		//режимы работы насосов
_DV_MODE:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
;     918 eeprom unsigned int RESURS_CNT[6];					//Счетчики моторесурса насосов
_RESURS_CNT:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     919 eeprom signed Idmin;							//Ток насоса минимальный 
_Idmin:
	.DW  0x0
;     920 eeprom signed Idmax;							//Ток насоса максимальный 
_Idmax:
	.DW  0x0
;     921 eeprom signed Kida[6],Kidc[6]; 					//Калибровка токов двигателей
_Kida:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
_Kidc:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     922 eeprom signed C1N;
_C1N:
	.DW  0x0
;     923 eeprom enum {dasLOG=0x55,dasDAT=0xAA}DV_AV_SET;		//
_DV_AV_SET:
	.DB  0x0
;     924 eeprom signed DV_DUMM[9];
_DV_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     925 
;     926 eeprom signed SS_LEVEL;							//Ступенчатый пуск - 
_SS_LEVEL:
	.DW  0x0
;     927 eeprom signed SS_STEP;							//Ступенчатый пуск -
_SS_STEP:
	.DW  0x0
;     928 eeprom signed SS_TIME;							//Ступенчатый пуск -
_SS_TIME:
	.DW  0x0
;     929 eeprom signed SS_FRIQ;							//Ступенчатый пуск -
_SS_FRIQ:
	.DW  0x0
;     930 eeprom signed SS_DUMM[10];
_SS_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     931 
;     932 eeprom signed DVCH_T_UP;							//Переключение насосов - 
_DVCH_T_UP:
	.DW  0x0
;     933 eeprom signed DVCH_T_DOWN;						//Переключение насосов -
_DVCH_T_DOWN:
	.DW  0x0
;     934 eeprom signed DVCH_P_KR;							//Переключение насосов -
_DVCH_P_KR:
	.DW  0x0
;     935 eeprom signed DVCH_KP;							//Переключение насосов -
_DVCH_KP:
	.DW  0x0
;     936 eeprom signed DVCH_TIME;							//Переключение насосов - 
_DVCH_TIME:
	.DW  0x0
;     937 eeprom enum {dvch_ON=0x55,dvch_OFF=0xAA}DVCH;		//Переключение насосов - 
_DVCH:
	.DB  0x0
;     938 eeprom signed DVCH_DUMM[10];
_DVCH_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     939 
;     940 eeprom signed FP_FMIN;							//Частотный преобразователь - минимальная частота
_FP_FMIN:
	.DW  0x0
;     941 eeprom signed FP_FMAX;							//Частотный преобразователь - максимальная частота  
_FP_FMAX:
	.DW  0x0
;     942 eeprom signed FP_TPAD;							//Частотный преобразователь - 
_FP_TPAD:
	.DW  0x0
;     943 eeprom signed FP_TVOZVR;							//Частотный преобразователь -  
_FP_TVOZVR:
	.DW  0x0
;     944 eeprom signed FP_CH; 							//Частотный преобразователь - 
_FP_CH:
	.DW  0x0
;     945 eeprom signed FP_P_PL;							//Частотный преобразователь - 
_FP_P_PL:
	.DW  0x0
;     946 eeprom signed FP_P_MI;							//Частотный преобразователь - 
_FP_P_MI:
	.DW  0x0
;     947 eeprom signed FP_RESET_TIME;						//Частотный преобразователь - 
_FP_RESET_TIME:
	.DW  0x0
;     948 eeprom signed FP_DUMM[9];
_FP_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     949 
;     950 eeprom enum {dON=0x55,dOFF=0xAA}DOOR;				//Задвижка - 
_DOOR:
	.DB  0x0
;     951 eeprom signed DOOR_IMIN;							//Задвижка - 
_DOOR_IMIN:
	.DW  0x0
;     952 eeprom signed DOOR_IMAX;							//Задвижка -
_DOOR_IMAX:
	.DW  0x0
;     953 eeprom enum {dmS=0x55,dmA=0xAA}DOOR_MODE;			//Задвижка -
_DOOR_MODE:
	.DB  0x0
;     954 eeprom signed DOOR_DUMM[10];
_DOOR_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     955 
;     956 eeprom enum {pON=0x55,pOFF=0xAA}PROBE;				//Пробный пуск - 
_PROBE:
	.DB  0x0
;     957 eeprom signed PROBE_DUTY;						//Пробный пуск -
_PROBE_DUTY:
	.DW  0x0
;     958 eeprom signed PROBE_TIME;						//Пробный пуск -
_PROBE_TIME:
	.DW  0x0
;     959 eeprom signed PROBE_DUMM[10];
_PROBE_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     960 
;     961 eeprom enum {hhWMS=0x55}HH_SENS;					//Сухой ход - 
_HH_SENS:
	.DB  0x0
;     962 eeprom signed HH_P;								//Сухой ход - 
_HH_P:
	.DW  0x0
;     963 eeprom signed HH_TIME;					    		//Сухой ход - 
_HH_TIME:
	.DW  0x0
;     964 eeprom signed HH_DUMM[10];
_HH_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     965 
;     966 eeprom signed ZL_TIME;					    		//Нулевая нагрузка - 
_ZL_TIME:
	.DW  0x0
;     967 eeprom signed ZL_DUMM[10];       
_ZL_DUMM:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;     968 
;     969 eeprom signed  P_UST_EE;
_P_UST_EE:
	.DW  0x0
;     970 
;     971 eeprom enum {tsWINTER=0x55,tsSUMMER=0xAA}time_sezon; 
_time_sezon:
	.DB  0x0
;     972 
;     973 signed p_ust;
;     974 int plazma;
;     975 char p_ind_cnt;
;     976 enum char {iMn=33,iSet,iK,iNet=39,iPopl_sel=66,iPopl=72,iDv=92,iT_sel=133,iT1=155,iT2=166,iPrl=189,iWrk_popl=191,
;     977 		iWrk_p=192,iDavl=117,iDnd=150,iStat,iKnet,iKdt_in,iKdt_out,iSetT,iSet_warm,iSet_cool,iNet_set,iPid_set,iTimer_sel,
;     978 		iKi1,iKi2,iPopl_set,iKd_sel,iKd_i,iDv_sel,iDv_set,iAv_sel,iAv,iStep_start,iLev_sign,iLev_set,iKd_p,iKd_i1,iKd_i2
;     979 		,iDv_change,iDv_change1,iTemper_set,iMode_set,iDeb,iFp_set,iDoor_set,iProbe_set,iHh_set,iTimer_set,iZero_load_set,iDv_av_log
;     980 		,iDv_num_set,iDv_start_set,iDv_imin_set,iDv_imax_set,iDv_mode_set,iDv_resurs_set,iDv_i_kalibr,iDv_c_set,iDv_ch_set,iDv_out}ind;
;     981 flash char DAY_MONTHS[12]={31,29,31,30,31,30,31,31,30,31,30,31};

	.CSEG
;     982 flash char __weeks_days_[8][15]={"   ","воскр.","понед.","вторн.","среда","четверг","пятн.","суббота"};
;     983 //**********************************************
;     984 //Глобальные переменные
;     985 char data_for_ind[40];

	.DSEG
_data_for_ind:
	.BYTE 0x28
;     986 unsigned main_cnt;
_main_cnt:
	.BYTE 0x2
;     987 char out_stat;
;     988 //**********************************************
;     989 //Работа с кнопками                             
;     990 char but_n;
_but_n:
	.BYTE 0x1
;     991 char but_s;
_but_s:
	.BYTE 0x1
;     992 char but;
_but:
	.BYTE 0x1
;     993 char but0_cnt;
_but0_cnt:
	.BYTE 0x1
;     994 char but1_cnt;
_but1_cnt:
	.BYTE 0x1
;     995 char but_onL_temp;
_but_onL_temp:
	.BYTE 0x1
;     996 //bit speed; 
;     997 bit l_but;
;     998 bit n_but;
;     999 signed char but_cnt[5];
_but_cnt:
	.BYTE 0x5
;    1000 //***********************************************
;    1001 //Битовые переменные
;    1002 bit b500Hz;
;    1003 bit b100Hz;
;    1004 bit b10Hz;
;    1005 bit b5Hz; 
;    1006 bit b2Hz;
;    1007 bit b1Hz;
;    1008 static char t0cnt000,t0cnt0_,t0cnt0,t0cnt1,t0cnt2,t0cnt3,t0cnt4,t0cnt5,t0cnt6;
_t0cnt000_G1:
	.BYTE 0x1
_t0cnt0__G1:
	.BYTE 0x1
_t0cnt0_G1:
	.BYTE 0x1
_t0cnt1_G1:
	.BYTE 0x1
_t0cnt2_G1:
	.BYTE 0x1
_t0cnt3_G1:
	.BYTE 0x1
_t0cnt4_G1:
	.BYTE 0x1
_t0cnt5_G1:
	.BYTE 0x1
_t0cnt6_G1:
	.BYTE 0x1
;    1009 
;    1010 char cob[20],cib[20];
_cob:
	.BYTE 0x14
_cib:
	.BYTE 0x14
;    1011 char data_out[10];
_data_out:
	.BYTE 0xA
;    1012 
;    1013 //***********************************************
;    1014 //Работа с АЦП 
;    1015 unsigned int result;
_result:
	.BYTE 0x2
;    1016 char result_adr0,result_adr1;
_result_adr0:
	.BYTE 0x1
_result_adr1:
	.BYTE 0x1
;    1017 char adc_cnt0; 	//
_adc_cnt0:
	.BYTE 0x1
;    1018 char adc_cnt1; 	//
_adc_cnt1:
	.BYTE 0x1
;    1019 char adc_cnt2; 	//
_adc_cnt2:
	.BYTE 0x1
;    1020 char adc_cnt3; 	// 
_adc_cnt3:
	.BYTE 0x1
;    1021 unsigned unet_bank_buff[3];
_unet_bank_buff:
	.BYTE 0x6
;    1022 unsigned char unet_zero_cnt[3],unet_cnt[3];
_unet_zero_cnt:
	.BYTE 0x3
_unet_cnt:
	.BYTE 0x3
;    1023 unsigned unet_bank[3][32],unet_bank_[3];  
_unet_bank:
	.BYTE 0xC0
_unet_bank_:
	.BYTE 0x6
;    1024 unsigned adc_bank[8][16],adc_bank_[8];
_adc_bank:
	.BYTE 0x100
_adc_bank_:
	.BYTE 0x10
;    1025 //eeprom enum {AV_EN=0x55,AV_DIS=0xAA}aven;
;    1026 
;    1027 
;    1028 //***********************************************
;    1029 //Мониторинг питающей сети
;    1030 //enum {asu_ON=0x55,asu_OFF=0xaa} av_st_unet;
;    1031 enum {asuc_AV=0x55,asuc_NORM=0xaa} av_st_unet_cher;
_av_st_unet_cher:
	.BYTE 0x1
;    1032 signed unet[3]={135,335,535};
_unet:
	.BYTE 0x6
;    1033 //signed eeprom UNET_MAX_EE,UNET_MIN_EE;
;    1034 //signed char unet_avar_cnt;
;    1035 bit bA,bB,bC;
;    1036 char cnt_x;
_cnt_x:
	.BYTE 0x1
;    1037 char cher_cnt=25;
_cher_cnt:
	.BYTE 0x1
;    1038 enum {nfABC=0x55,nfACB=0xAA}net_fase=0;
_net_fase:
	.BYTE 0x1
;    1039 
;    1040 char but_pult;
_but_pult:
	.BYTE 0x1
;    1041 char unet_min_cnt[3],unet_max_cnt[3];
_unet_min_cnt:
	.BYTE 0x3
_unet_max_cnt:
	.BYTE 0x3
;    1042 enum {unet_st_NORM,unet_st_MIN,unet_st_MAX}unet_st[3];
_unet_st:
	.BYTE 0x3
;    1043 
;    1044 //***********************************************
;    1045 //Температура
;    1046 signed t[2];
_t:
	.BYTE 0x4
;    1047 
;    1048 //signed eeprom AV_TEMPER_HEAT,TEMPER_GIST,T_ON_COOL,T_ON_WARM,T_GIST_WARM_DUMM,T_GIST_COOL_DUMM;
;    1049 enum{tCOOL,tNORM,tHEAT,tAVSENS}t_air_st;
_t_air_st:
	.BYTE 0x1
;    1050 enum{cool_ON,cool_OFF,cool_AVSENS}cool_st;
_cool_st:
	.BYTE 0x1
;    1051 enum{warm_ON=0x55,warm_OFF=0xaa,warm_AVSENS=0xbb}warm_st; 
_warm_st:
	.BYTE 0x1
;    1052 //eeprom char COOL_SIGN_DUMM,AV_TEMPER_SIGN_DUMM;
;    1053 signed char t_on_warm_cnt,t_on_cool_cnt;
_t_on_warm_cnt:
	.BYTE 0x1
_t_on_cool_cnt:
	.BYTE 0x1
;    1054 enum{av_temper_NORM=0xaa,av_temper_COOL=0x99,av_temper_HEAT=0x88,av_temper_AVSENS=0xbb}av_temper_st; 
_av_temper_st:
	.BYTE 0x1
;    1055 char av_temper_cool_cnt,av_temper_heat_cnt;
_av_temper_cool_cnt:
	.BYTE 0x1
_av_temper_heat_cnt:
	.BYTE 0x1
;    1056 //***********************************************
;    1057 //Время
;    1058 char _sec,_min,_hour,_day,_month,_year,_week_day;    
__sec:
	.BYTE 0x1
__min:
	.BYTE 0x1
__hour:
	.BYTE 0x1
__day:
	.BYTE 0x1
__month:
	.BYTE 0x1
__year:
	.BYTE 0x1
__week_day:
	.BYTE 0x1
;    1059 
;    1060 
;    1061 
;    1062 
;    1063 //***********************************************
;    1064 //Работа с поплавками
;    1065 enum {poplUP=0x55,poplDN=0xaa,poplAV=0x69} popl_st[4];
_popl_st:
	.BYTE 0x4
;    1066 signed char popl_cnt_p[4],popl_cnt_m[4],popl_cnt_av[4];
_popl_cnt_p:
	.BYTE 0x4
_popl_cnt_m:
	.BYTE 0x4
_popl_cnt_av:
	.BYTE 0x4
;    1067 //eeprom enum {popl2kont=0x55,popl3kont=0xaa,poplisoff=0xcd}popl_ust; 
;    1068 //eeprom enum {popl2kont=0x55,popl3kont=0xaa,poplisoff=0xcd}popl_ust_dumm[3];
;    1069 enum {avON=0x55,avOFF=0xaa}hh_av;
_hh_av:
	.BYTE 0x1
;    1070 
;    1071 signed char level,level_old;
_level:
	.BYTE 0x1
_level_old:
	.BYTE 0x1
;    1072 
;    1073 
;    1074 //***********************************************
;    1075 //Входы 4-20mA
;    1076 signed p;
_p:
	.BYTE 0x2
;    1077 signed height_level_i[2];
_height_level_i:
	.BYTE 0x4
;    1078 //signed eeprom Kdi__[2];
;    1079 
;    1080 //**********************************************
;    1081 //Состояние двигателей
;    1082 unsigned Ida[6],Idc[6],Id[6];
_Ida:
	.BYTE 0xC
_Idc:
	.BYTE 0xC
_Id:
	.BYTE 0xC
;    1083 
;    1084 //enum {avvON=0x55,avvOFF=0xaa,avvKZ=0x69,avvHH=0x66} av_vl[6],av_vl_old[6];
;    1085 enum {avuON=0x55,avuOFF=0xaa} av_upp[6],av_upp_old[6];
_av_upp:
	.BYTE 0x6
_av_upp_old:
	.BYTE 0x6
;    1086 signed char cnt_avtHH[4],cnt_avtKZ[4],cnt_avtON[4],cnt_avtOFF[4],cnt_avvHH[4],cnt_avvKZ[4],cnt_avvON[4],cnt_avvOFF[4];
_cnt_avtHH:
	.BYTE 0x4
_cnt_avtKZ:
	.BYTE 0x4
_cnt_avtON:
	.BYTE 0x4
_cnt_avtOFF:
	.BYTE 0x4
_cnt_avvHH:
	.BYTE 0x4
_cnt_avvKZ:
	.BYTE 0x4
_cnt_avvON:
	.BYTE 0x4
_cnt_avvOFF:
	.BYTE 0x4
;    1087 signed int cnt_control_blok,cnt_control_blok1;
_cnt_control_blok:
	.BYTE 0x2
_cnt_control_blok1:
	.BYTE 0x2
;    1088 enum {dvOFF=0x81,dvSTAR=0x42,dvTRIAN=0x24,dvFR=0x66,dvFULL=0x99,dvON=0xAA} fp_stat=dvOFF,dv_on[6]={dvOFF,dvOFF,dvOFF,dvOFF,dvOFF,dvOFF},dv_access[6]={dvOFF,dvOFF,dvOFF,dvOFF,dvOFF,dvOFF};
_fp_stat:
	.BYTE 0x1
_dv_on:
	.BYTE 0x6
_dv_access:
	.BYTE 0x6
;    1089 signed fp_poz;
_fp_poz:
	.BYTE 0x2
;    1090 char potenz,potenz_off;
_potenz:
	.BYTE 0x1
_potenz_off:
	.BYTE 0x1
;    1091 unsigned comm_curr;
_comm_curr:
	.BYTE 0x2
;    1092 char num_wrks_new,num_wrks_new_new,num_wrks_old;
_num_wrks_new:
	.BYTE 0x1
_num_wrks_new_new:
	.BYTE 0x1
_num_wrks_old:
	.BYTE 0x1
;    1093 char num_necc,num_necc_old;
_num_necc:
	.BYTE 0x1
_num_necc_old:
	.BYTE 0x1
;    1094 
;    1095 //eeprom enum {el_420_1=0x55,el_420_2=0x66,el_P=0x88,el_popl=0xaa}EE_LOG; //тип датчиков - поплавки или датчик давления
;    1096 
;    1097 
;    1098 //enum {avuON=0x55,avuOFF=0xAA}av_upp[6];
;    1099 enum {avsON=0x55,avsOFF=0xAA}av_serv[6];
_av_serv:
	.BYTE 0x6
;    1100 
;    1101 //***********************************************
;    1102 //Подсчёт моторесурса двигателей
;    1103 
;    1104 unsigned int resurs_cnt_[6];  //счетчик секунд 
_resurs_cnt_:
	.BYTE 0xC
;    1105 unsigned long resurs_cnt__[6];  //полный счетчик
_resurs_cnt__:
	.BYTE 0x18
;    1106 
;    1107 
;    1108 //unsigned int eeprom RESURS_MAX[6];
;    1109 enum {resOFF,resON} dv_res[6];
_dv_res:
	.BYTE 0x6
;    1110 
;    1111 //eeprom enum {dvON=0x55,dvOFF=0xaa} dv_on_mnl[6];
;    1112 
;    1113 char data_for_ex[3][10];
_data_for_ex:
	.BYTE 0x1E
;    1114 enum {cast_ON1=0x55,cast_ON2=0x69,cast_OFF=0xAA} comm_av_st; 
_comm_av_st:
	.BYTE 0x1
;    1115 bit bCONTROL;
;    1116 
;    1117 unsigned fp_step_num;		//количество шагов частотного преобразователя от минимума  до максимума
_fp_step_num:
	.BYTE 0x2
;    1118 signed power=0;               //виртуальная "сила" установки
_power:
	.BYTE 0x2
;    1119 signed fp_power;			//частота пробразователя равна FP_FMIN+(10*fp_power) 
_fp_power:
	.BYTE 0x2
;    1120 //enum {dv_ON=0x55,dvOFF};	//состояние частотника
;    1121 //***********************************************
;    1122 //Авария по переливу
;    1123 enum {av_pereliv_ON=0x55,av_pereliv_OFF=0xAA}av_pereliv=av_pereliv_OFF;
_av_pereliv:
	.BYTE 0x1
;    1124 signed av_pereliv_cnt;
_av_pereliv_cnt:
	.BYTE 0x2
;    1125 //***********************************************
;    1126 //Аварии двигателей по току и АПВ
;    1127 signed char av_id_min_cnt[6];
_av_id_min_cnt:
	.BYTE 0x6
;    1128 signed char av_id_max_cnt[6];
_av_id_max_cnt:
	.BYTE 0x6
;    1129 //signed char av_id_per_cnt[6];
;    1130 signed char av_id_log_cnt[6];
_av_id_log_cnt:
	.BYTE 0x6
;    1131 signed char av_id_not_cnt[6];
_av_id_not_cnt:
	.BYTE 0x6
;    1132 enum {aviON=0x55,aviOFF=0xAA}av_i_dv_min[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
_av_i_dv_min:
	.BYTE 0x6
;    1133 					    av_i_dv_max[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
_av_i_dv_max:
	.BYTE 0x6
;    1134 					    av_i_dv_not[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
_av_i_dv_not:
	.BYTE 0x6
;    1135 					    //av_i_dv_per[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
;    1136 					    av_i_dv_log[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF},
_av_i_dv_log:
	.BYTE 0x6
;    1137 					    av_i_dv_log_old[6]={aviOFF,aviOFF,aviOFF,aviOFF,aviOFF,aviOFF};
_av_i_dv_log_old:
	.BYTE 0x6
;    1138 char apv_cnt[6];
_apv_cnt:
	.BYTE 0x6
;    1139 enum {apvON=0x55,apvOFF=0xaa} apv[6]={apvOFF,apvOFF,apvOFF,apvOFF,apvOFF,apvOFF};
_apv:
	.BYTE 0x6
;    1140 char cnt_av_i_not_wrk[6];
_cnt_av_i_not_wrk:
	.BYTE 0x6
;    1141 
;    1142 //eeprom signed EE_LEVEL_DUMM[4]; 
;    1143 signed height_level=127;
_height_level:
	.BYTE 0x2
;    1144 
;    1145 //***********************************************
;    1146 //Датчик давления
;    1147 signed height_level_p;
_height_level_p:
	.BYTE 0x2
;    1148 
;    1149 
;    1150 //signed eeprom Kdi1[2],Kdi0[2];
;    1151 
;    1152 //***********************************************
;    1153 //Журнал аварий
;    1154 
;    1155 
;    1156 eeprom char av_hour[20],av_min[20],av_sec[20],av_day[20],av_month[20],av_year[20];

	.ESEG
_av_hour:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
_av_min:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
_av_sec:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
_av_day:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
_av_month:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
_av_year:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
;    1157 eeprom signed av_code[20],av_data0[20],av_data1[20];
_av_code:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
_av_data0:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
_av_data1:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;    1158 eeprom signed ptr_last_av;
_ptr_last_av:
	.DW  0x0
;    1159 //eeprom signed EE_LEVEL[5];
;    1160 
;    1161 char skb_cnt;

	.DSEG
_skb_cnt:
	.BYTE 0x1
;    1162 
;    1163 enum {lON=0x55,lOFF=0xAA}level_on[5];
_level_on:
	.BYTE 0x5
;    1164 char level_cnt[5];
_level_cnt:
	.BYTE 0x5
;    1165 char test_cnt;
_test_cnt:
	.BYTE 0x1
;    1166 signed temper_result;
_temper_result:
	.BYTE 0x2
;    1167 signed not_wrk_cnt;
_not_wrk_cnt:
	.BYTE 0x2
;    1168 char av_level_sensor_cnt;
_av_level_sensor_cnt:
	.BYTE 0x1
;    1169 enum{av_lsON=0x55,av_lsOFF=0xaa}av_ls_stat=av_lsOFF;
_av_ls_stat:
	.BYTE 0x1
;    1170 bit bLEVEL0;
;    1171 char not_wrk,not_wrk_old;
_not_wrk:
	.BYTE 0x1
_not_wrk_old:
	.BYTE 0x1
;    1172 char wrk_cnt;
_wrk_cnt:
	.BYTE 0x1
;    1173 //eeprom signed time_wrk_off;
;    1174 signed time_off;  
_time_off:
	.BYTE 0x2
;    1175 char plazma_i[6];
_plazma_i:
	.BYTE 0x6
;    1176 
;    1177 
;    1178 
;    1179 #define LCD_SIZE 40
;    1180 
;    1181 extern void can_out_adr(char adr0,char adr1,char* data_ptr);	    	
;    1182 extern void can_out_adr_len(char adr0,char adr1,char* data_ptr,char len);
;    1183 extern char read_ds14287(char adr);
;    1184 signed char p1,p2;
_p1:
	.BYTE 0x1
_p2:
	.BYTE 0x1
;    1185 bit zero_on;
;    1186 char dig[5];
_dig:
	.BYTE 0x5
;    1187 flash char ABC[16]={'0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'};

	.CSEG
;    1188 
;    1189 flash char sm_[]	={"                "}; 
;    1190 flash char sm_exit[]={" Выход          "}; 
;    1191 
;    1192 #pragma ruslcd+ 
;    1193 //char lcd_buffer[40]={"0123456789abcdefghijABCDEFGHIJ+-"};
;    1194 char lcd_buffer[40]={" "};

	.DSEG
_lcd_buffer:
	.BYTE 0x28
;    1195 
;    1196 //flash char sm300[]	={"     АВАРИИ     "};
;    1197 
;    1198 //flash char sm303[]	={" Аварий нет     "};
;    1199 
;    1200 //flash char sm400[]	={};
;    1201 
;    1202 
;    1203 
;    1204 
;    1205 
;    1206 /*flash char sm415[]	={" перекос токов  "};
;    1207 flash char sm416[]	={"  температура   "};
;    1208 flash char sm417[]	={"   влажность    "}; */
;    1209 
;    1210 #pragma ruslcd-
;    1211 
;    1212 flash char sm_mont[12][4]={"янв","фев","мар","апр","май","июн","июл","авг","сен","окт","ноя","дек"}; // 

	.CSEG
;    1213 flash char sm_av[224][3]={"00","01","02","03","04","05","06","07","08","09","0а","0б","0в","0г","0д","0е","00","01","02","03","04","05","06","07","08","09","0а","0б","0в","0г","0д","0е",
;    1214 					"10","11","12","13","14","15","16","17","18","19","1а","1б","1в","1г","1д","1е","10","11","12","13","14","15","16","17","18","19","1а","1б","1в","1г","1д","1е",
;    1215 				    	"20","21","22","23","24","25","26","27","28","29","2а","2б","2в","2г","2д","2е","20","21","22","23","24","25","26","27","28","29","2а","2б","2в","2г","2д","2е",
;    1216 				    	"30","31","32","33","34","35","36","37","38","39","3а","3б","3в","3г","3д","3е","30","31","32","33","34","35","36","37","38","39","3а","3б","3в","3г","3д","3е",
;    1217 				    	"40","41","42","43","44","45","46","47","48","49","4а","4б","4в","4г","4д","4е","40","41","42","43","44","45","46","47","48","49","4а","4б","4в","4г","4д","4е",
;    1218 				    	"50","51","52","53","54","55","56","57","58","59","5а","5б","5в","5г","5д","5е","50","51","52","53","54","55","56","57","58","59","5а","5б","5в","5г","5д","5е",
;    1219 				    	"60","61","62","63","64","65","66","67","68","69","6а","6б","6в","6г","6д","6е","60","61","62","63","64","65","66","67","68","69","6а","6б","6в","6г","6д","6е"}; //
;    1220 
;    1221 
;    1222 
;    1223 //char plazma;
;    1224 int plazma_int[8];

	.DSEG
_plazma_int:
	.BYTE 0x10
;    1225 enum {rON=0x55,rOFF=0xaa}rel_in_st[4],rel_in_st_old[4];
_rel_in_st:
	.BYTE 0x4
_rel_in_st_old:
	.BYTE 0x4
;    1226 
;    1227 eeprom signed pilot_dv;

	.ESEG
_pilot_dv:
	.DW  0x0
;    1228 char sub_ind,index_set,sub_ind1,sub_ind2;

	.DSEG
_sub_ind:
	.BYTE 0x1
_index_set:
	.BYTE 0x1
_sub_ind1:
	.BYTE 0x1
_sub_ind2:
	.BYTE 0x1
;    1229 #include "ret.c"
;    1230 char retind,retsub,retindsec;
_retind:
	.BYTE 0x1
_retsub:
	.BYTE 0x1
_retindsec:
	.BYTE 0x1
;    1231 int retcnt,retcntsec;
_retcnt:
	.BYTE 0x2
_retcntsec:
	.BYTE 0x2
;    1232 //-----------------------------------------------
;    1233 void ret_ind(char r_i,char r_s,int r_c)
;    1234 {

	.CSEG
_ret_ind:
;    1235 retcnt=r_c;
	LD   R30,Y
	LDD  R31,Y+1
	STS  _retcnt,R30
	STS  _retcnt+1,R31
;    1236 retind=r_i;
	LDD  R30,Y+3
	STS  _retind,R30
;    1237 retsub=r_s;
	LDD  R30,Y+2
	STS  _retsub,R30
;    1238 }    
_0xB47:
	ADIW R28,4
	RET
;    1239 
;    1240 //-----------------------------------------------
;    1241 void ret_ind_hndl(void)
;    1242 {
_ret_ind_hndl:
;    1243 if(retcnt)
	LDS  R30,_retcnt
	LDS  R31,_retcnt+1
	SBIW R30,0
	BREQ _0x1F
;    1244 	{
;    1245 	if((--retcnt)==0)
	SBIW R30,1
	STS  _retcnt,R30
	STS  _retcnt+1,R31
	SBIW R30,0
	BRNE _0x20
;    1246 		{
;    1247  		ind=retind;
	LDS  R13,_retind
;    1248    		sub_ind=retsub;
	LDS  R30,_retsub
	STS  _sub_ind,R30
;    1249    		index_set=sub_ind;
	STS  _index_set,R30
;    1250 	 	}
;    1251      }
_0x20:
;    1252 }  
_0x1F:
	RET
;    1253 
;    1254 
;    1255  
;    1256 //---------------------------------------------
;    1257 void ret_ind_sec(char r_i,int r_c)
;    1258 {
;    1259 retcntsec=r_c;
;    1260 retindsec=r_i;
;    1261 }
;    1262 
;    1263 //-----------------------------------------------
;    1264 void ret_ind_sec_hndl(void)
;    1265 {
;    1266 if(retcntsec)
;    1267  	{
;    1268 	if((--retcntsec)==0)
;    1269 	 	{
;    1270  		ind=retindsec;
;    1271  		sub_ind=0;
;    1272 		
;    1273 	 	}
;    1274    	}		
;    1275 }   
;    1276 #include "mcp2510.h"
_mcp_reset:
	cli
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x17,3
	SBI  0x17,4
	CALL SUBOPT_0x9
	SBI  0x17,4
	CBI  0x18,4
	LDI  R30,LOW(192)
	ST   -Y,R30
	CALL _spi
	SBI  0x18,4
	sei
	RET
_spi_read:
	ST   -Y,R16
;	addr -> Y+1
;	temp -> R16
	cli
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x17,3
	SBI  0x17,4
	CALL SUBOPT_0x9
	SBI  0x17,4
	CBI  0x18,4
	__DELAY_USB 27
	LDI  R30,LOW(3)
	CALL SUBOPT_0xA
	CALL SUBOPT_0xB
	SBI  0x18,4
	sei
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,2
	RET
_spi_bit_modify:
	cli
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x17,3
	SBI  0x17,4
	CALL SUBOPT_0x9
	SBI  0x17,4
	CBI  0x18,4
	LDI  R30,LOW(5)
	CALL SUBOPT_0xC
	CALL SUBOPT_0xD
	SBI  0x18,4
	sei
	ADIW R28,3
	RET
_spi_write:
	ST   -Y,R16
;	addr -> Y+2
;	in -> Y+1
;	temp -> R16
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x17,3
	SBI  0x17,4
	CALL SUBOPT_0x9
	SBI  0x17,4
	CBI  0x18,4
	LDI  R30,LOW(2)
	CALL SUBOPT_0xC
	SBI  0x18,4
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,3
	RET
_spi_read_status:
	ST   -Y,R16
;	temp -> R16
	cli
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x17,3
	SBI  0x17,4
	CALL SUBOPT_0x9
	SBI  0x17,4
	CBI  0x18,4
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	LDI  R30,LOW(160)
	ST   -Y,R30
	CALL _spi
	CALL SUBOPT_0xB
	SBI  0x18,4
	sei
	MOV  R30,R16
	LD   R16,Y+
	RET
_spi_rts:
	cli
	SBI  0x17,1
	SBI  0x17,2
	CBI  0x17,3
	SBI  0x17,4
	CALL SUBOPT_0x9
	SBI  0x17,4
	CBI  0x18,4
	LD   R30,Y
	CPI  R30,0
	BRNE _0x23
	LDI  R30,LOW(129)
	ST   Y,R30
	RJMP _0x24
_0x23:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x25
	LDI  R30,LOW(130)
	ST   Y,R30
	RJMP _0x26
_0x25:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x27
	LDI  R30,LOW(132)
	ST   Y,R30
_0x27:
_0x26:
_0x24:
	CALL SUBOPT_0xD
	SBI  0x18,4
	sei
	ADIW R28,1
	RET
;	in -> Y+1
;	temp -> R16
;	in -> Y+1
;	temp -> R16
;	in -> Y+1
;	temp -> R16
;	in -> Y+1
;	temp -> R16
;	sidh -> Y+7
;	sidl -> Y+6
;	eid8 -> Y+5
;	eid0 -> Y+4
;	temp -> Y+0
;    1277 #include "mcp_can.c"
;    1278 char can_st,can_st1;

	.DSEG
_can_st:
	.BYTE 0x1
_can_st1:
	.BYTE 0x1
;    1279 char ptr_tx_wr,ptr_tx_rd;
_ptr_tx_wr:
	.BYTE 0x1
_ptr_tx_rd:
	.BYTE 0x1
;    1280 char fifo_can_in[FIFO_CAN_IN_LEN,13];
_fifo_can_in:
	.BYTE 0x82
;    1281 char ptr_rx_wr,ptr_rx_rd;
_ptr_rx_wr:
	.BYTE 0x1
_ptr_rx_rd:
	.BYTE 0x1
;    1282 char rx_counter;
_rx_counter:
	.BYTE 0x1
;    1283 char fifo_can_out[FIFO_CAN_OUT_LEN,13];
_fifo_can_out:
	.BYTE 0x82
;    1284 
;    1285 char tx_counter;
_tx_counter:
	.BYTE 0x1
;    1286 char rts_delay;
_rts_delay:
	.BYTE 0x1
;    1287 bit bMCP_DRV;
;    1288 //-----------------------------------------------
;    1289 void mcp_drv(void)
;    1290 {

	.CSEG
_mcp_drv:
;    1291 char j; 
;    1292 char data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12;
;    1293 char ptr,*ptr_;
;    1294 if(bMCP_DRV) goto mcp_drv_end;		
	SBIW R28,11
	CALL __SAVELOCR6
;	j -> R16
;	data0 -> R17
;	data1 -> R18
;	data2 -> R19
;	data3 -> R20
;	data4 -> R21
;	data5 -> Y+16
;	data6 -> Y+15
;	data7 -> Y+14
;	data8 -> Y+13
;	data9 -> Y+12
;	data10 -> Y+11
;	data11 -> Y+10
;	data12 -> Y+9
;	ptr -> Y+8
;	*ptr_ -> Y+6
	SBRC R3,6
	RJMP _0x29
;    1295 bMCP_DRV=1;
	SET
	BLD  R3,6
;    1296 //		DDRA.1=1;
;    1297 //		PORTA.1=!PORTA.1;
;    1298 if(rts_delay)rts_delay--;
	LDS  R30,_rts_delay
	CPI  R30,0
	BREQ _0x2A
	SUBI R30,LOW(1)
	STS  _rts_delay,R30
;    1299 can_st=spi_read_status();
_0x2A:
	CALL _spi_read_status
	STS  _can_st,R30
;    1300 //plazma=can_st;
;    1301 if(can_st&0b10101000)
	ANDI R30,LOW(0xA8)
	BREQ _0x2B
;    1302 	{
;    1303    	spi_bit_modify(CANINTF,0b00011100,0x00);
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(28)
	CALL SUBOPT_0xE
;    1304 	}  
;    1305 	
;    1306 if(can_st&0b00000001)
_0x2B:
	LDS  R30,_can_st
	ANDI R30,LOW(0x1)
	BRNE PC+3
	JMP _0x2C
;    1307 	{
;    1308      spi_bit_modify(CANINTF,0b00000011,0x00);
	LDI  R30,LOW(44)
	ST   -Y,R30
	LDI  R30,LOW(3)
	CALL SUBOPT_0xE
;    1309 	
;    1310 	if(rx_counter<FIFO_CAN_IN_LEN)
	LDS  R26,_rx_counter
	CPI  R26,LOW(0xA)
	BRLO PC+3
	JMP _0x2D
;    1311 		{
;    1312 		//plazma++;
;    1313 		rx_counter++;
	LDS  R30,_rx_counter
	SUBI R30,-LOW(1)
	STS  _rx_counter,R30
;    1314 		ptr_=&fifo_can_in[ptr_rx_wr,0];
	CALL SUBOPT_0xF
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;    1315 		for(j=0;j<13;j++)
	LDI  R16,LOW(0)
_0x2F:
	CPI  R16,13
	BRSH _0x30
;    1316 	    		{
;    1317 	    		*ptr_++=spi_read(RXB0SIDH+j);
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	ADIW R30,1
	STD  Y+6,R30
	STD  Y+6+1,R31
	SBIW R30,1
	PUSH R31
	PUSH R30
	MOV  R30,R16
	SUBI R30,-LOW(97)
	ST   -Y,R30
	CALL _spi_read
	POP  R26
	POP  R27
	ST   X,R30
;    1318 			}
	SUBI R16,-1
	RJMP _0x2F
_0x30:
;    1319 		ptr_=&fifo_can_in[ptr_rx_wr,0];
	CALL SUBOPT_0xF
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x10
;    1320 		
;    1321 		j=ptr_[4];
	ADIW R26,4
	LD   R16,X
;    1322 		ptr_[4]=ptr_[3];
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,3
	LD   R30,X
	__PUTB1SNS 6,4
;    1323 		ptr_[3]=ptr_[2];
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,2
	LD   R30,X
	__PUTB1SNS 6,3
;    1324     		ptr_[2]=j;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,2
	ST   X,R16
;    1325     		
;    1326     	 	ptr_rx_wr++;
	LDS  R30,_ptr_rx_wr
	SUBI R30,-LOW(1)
	STS  _ptr_rx_wr,R30
;    1327 		if(ptr_rx_wr>=FIFO_CAN_IN_LEN)ptr_rx_wr=0; 	 			 
	LDS  R26,_ptr_rx_wr
	CPI  R26,LOW(0xA)
	BRLO _0x31
	LDI  R30,LOW(0)
	STS  _ptr_rx_wr,R30
;    1328 		}
_0x31:
;    1329 	}  
_0x2D:
;    1330 else if((!(can_st&0b01010100))&&(!rts_delay))
	RJMP _0x32
_0x2C:
	LDS  R30,_can_st
	ANDI R30,LOW(0x54)
	BRNE _0x34
	LDS  R30,_rts_delay
	CPI  R30,0
	BREQ _0x35
_0x34:
	RJMP _0x33
_0x35:
;    1331 	{
;    1332 	if(tx_counter)
	LDS  R30,_tx_counter
	CPI  R30,0
	BRNE PC+3
	JMP _0x36
;    1333 		{
;    1334 		#asm("cli")
	cli
;    1335 		ptr_=&(fifo_can_out[ptr_tx_rd,0]);
	CALL SUBOPT_0x11
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x10
;    1336 
;    1337  
;    1338 		
;    1339 	    	data0=*ptr_++;
	LD   R17,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
;    1340 		data1=*ptr_++;
	LD   R18,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
;    1341 		data2=*ptr_++;
	LD   R19,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
;    1342 		data3=*ptr_++;
	LD   R20,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
;    1343 		data4=*ptr_++;
	LD   R21,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
;    1344 		data5=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+16,R30
;    1345 		data6=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+15,R30
;    1346 		data7=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+14,R30
;    1347 		data8=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+13,R30
;    1348 		data9=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+12,R30
;    1349 		data10=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+11,R30
;    1350 		data11=*ptr_++;
	CALL SUBOPT_0x12
	STD  Y+10,R30
;    1351 		data12=*ptr_++; 
	CALL SUBOPT_0x12
	STD  Y+9,R30
;    1352 		
;    1353 
;    1354 				 
;    1355           ptr_=&(fifo_can_out[ptr_tx_rd,0]);
	CALL SUBOPT_0x11
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
;    1356 		tx_counter--;
	LDS  R30,_tx_counter
	SUBI R30,LOW(1)
	STS  _tx_counter,R30
;    1357 		ptr_tx_rd++;
	LDS  R30,_ptr_tx_rd
	SUBI R30,-LOW(1)
	STS  _ptr_tx_rd,R30
;    1358 		if(ptr_tx_rd>=FIFO_CAN_OUT_LEN) 
	LDS  R26,_ptr_tx_rd
	CPI  R26,LOW(0xA)
	BRLO _0x37
;    1359 			
;    1360 			{
;    1361 			ptr_tx_rd=0;
	LDI  R30,LOW(0)
	STS  _ptr_tx_rd,R30
;    1362 			}
;    1363           #asm("sei")
_0x37:
	sei
;    1364           
;    1365         	spi_write(TXB0SIDH,data0);
	LDI  R30,LOW(49)
	ST   -Y,R30
	ST   -Y,R17
	CALL _spi_write
;    1366   		spi_write(TXB0SIDL,data1);
	LDI  R30,LOW(50)
	ST   -Y,R30
	ST   -Y,R18
	CALL _spi_write
;    1367   		spi_write(TXB0DLC,data2&0b10111111);
	LDI  R30,LOW(53)
	ST   -Y,R30
	MOV  R30,R19
	ANDI R30,0xBF
	ST   -Y,R30
	CALL _spi_write
;    1368    	     spi_write(TXB0EID8,data3);
	LDI  R30,LOW(51)
	ST   -Y,R30
	ST   -Y,R20
	CALL _spi_write
;    1369     	     spi_write(TXB0EID0,data4);
	LDI  R30,LOW(52)
	ST   -Y,R30
	ST   -Y,R21
	CALL _spi_write
;    1370   		spi_write(TXB0D0,data5);
	LDI  R30,LOW(54)
	ST   -Y,R30
	LDD  R30,Y+17
	ST   -Y,R30
	CALL _spi_write
;    1371 		spi_write(TXB0D1,data6);
	LDI  R30,LOW(55)
	ST   -Y,R30
	LDD  R30,Y+16
	ST   -Y,R30
	CALL _spi_write
;    1372 		spi_write(TXB0D2,data7);
	LDI  R30,LOW(56)
	ST   -Y,R30
	LDD  R30,Y+15
	ST   -Y,R30
	CALL _spi_write
;    1373 		spi_write(TXB0D3,data8);
	LDI  R30,LOW(57)
	ST   -Y,R30
	LDD  R30,Y+14
	ST   -Y,R30
	CALL _spi_write
;    1374 		spi_write(TXB0D4,data9);
	LDI  R30,LOW(58)
	ST   -Y,R30
	LDD  R30,Y+13
	ST   -Y,R30
	CALL _spi_write
;    1375 		spi_write(TXB0D5,data10);
	LDI  R30,LOW(59)
	ST   -Y,R30
	LDD  R30,Y+12
	ST   -Y,R30
	CALL _spi_write
;    1376 		spi_write(TXB0D6,data11);
	LDI  R30,LOW(60)
	ST   -Y,R30
	LDD  R30,Y+11
	ST   -Y,R30
	CALL _spi_write
;    1377 		spi_write(TXB0D7,data12);
	LDI  R30,LOW(61)
	ST   -Y,R30
	LDD  R30,Y+10
	CALL SUBOPT_0x13
;    1378 																		
;    1379 		spi_rts(0);
	CALL _spi_rts
;    1380           
;    1381           rts_delay=5;
	LDI  R30,LOW(5)
	STS  _rts_delay,R30
;    1382 		}     
;    1383 	}  
_0x36:
;    1384 //		DDRA.1=1;
;    1385 //		PORTA.1=!PORTA.1; 
;    1386             
;    1387 bMCP_DRV=0;		
_0x33:
_0x32:
	CLT
	BLD  R3,6
;    1388 mcp_drv_end:		
_0x29:
;    1389 }
	CALL __LOADLOCR6
	ADIW R28,17
	RET
;    1390 
;    1391 //-----------------------------------------------
;    1392 void can_out_adr_len(char adr0,char adr1,char* data_ptr,char len)
;    1393 {
;    1394 char ptr,*ptr_;
;    1395 ptr=ptr_tx_wr;
;	adr0 -> Y+7
;	adr1 -> Y+6
;	*data_ptr -> Y+4
;	len -> Y+3
;	ptr -> Y+2
;	*ptr_ -> Y+0
;    1396 
;    1397 if(tx_counter<FIFO_CAN_OUT_LEN)
;    1398 	
;    1399 	{
;    1400 	tx_counter++; 
;    1401 	
;    1402 	ptr_tx_wr++;
;    1403 	if(ptr_tx_wr>=FIFO_CAN_OUT_LEN) ptr_tx_wr=0;
;    1404 
;    1405 	ptr_=&fifo_can_out[ptr,0];
;    1406 	
;    1407 	*ptr_++=adr0;
;    1408 	*ptr_++=adr1|0b00001000;
;    1409 	if(len>2)*ptr_++=len-2;
;    1410 	else *ptr_++=0;
;    1411 	*ptr_++=data_ptr[0];
;    1412 	*ptr_++=data_ptr[1];
;    1413 	*ptr_++=data_ptr[2];
;    1414 	*ptr_++=data_ptr[3];
;    1415 	*ptr_++=data_ptr[4];
;    1416 	*ptr_++=data_ptr[5];
;    1417 	*ptr_++=data_ptr[6];
;    1418 	*ptr_++=data_ptr[7];
;    1419 	*ptr_++=data_ptr[8];
;    1420 	*ptr_++=data_ptr[9];
;    1421 	} 
;    1422 
;    1423 
;    1424 } 
;    1425 
;    1426 //-----------------------------------------------
;    1427 void can_out_adr(char adr0,char adr1,char* data_ptr)
;    1428 {
_can_out_adr:
;    1429 char ptr,*ptr_;
;    1430 ptr=ptr_tx_wr;
	SBIW R28,3
;	adr0 -> Y+6
;	adr1 -> Y+5
;	*data_ptr -> Y+3
;	ptr -> Y+2
;	*ptr_ -> Y+0
	LDS  R30,_ptr_tx_wr
	STD  Y+2,R30
;    1431 #asm("cli")
	cli
;    1432 if(tx_counter<FIFO_CAN_OUT_LEN)
	LDS  R26,_tx_counter
	CPI  R26,LOW(0xA)
	BRLO PC+3
	JMP _0x3C
;    1433 	
;    1434 	{
;    1435 	tx_counter++; 
	LDS  R30,_tx_counter
	SUBI R30,-LOW(1)
	STS  _tx_counter,R30
;    1436 	
;    1437 	ptr_tx_wr++;
	LDS  R30,_ptr_tx_wr
	SUBI R30,-LOW(1)
	STS  _ptr_tx_wr,R30
;    1438 	if(ptr_tx_wr>=FIFO_CAN_OUT_LEN) ptr_tx_wr=0;
	LDS  R26,_ptr_tx_wr
	CPI  R26,LOW(0xA)
	BRLO _0x3D
	LDI  R30,LOW(0)
	STS  _ptr_tx_wr,R30
;    1439 
;    1440 	ptr_=&fifo_can_out[ptr,0];
_0x3D:
	LDD  R30,Y+2
	LDI  R26,LOW(_fifo_can_out)
	LDI  R27,HIGH(_fifo_can_out)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ST   Y,R30
	STD  Y+1,R31
;    1441 	
;    1442 	*ptr_++=adr0;
	CALL SUBOPT_0x14
	LDD  R30,Y+6
	CALL SUBOPT_0x15
;    1443 	*ptr_++=adr1|0b00001000;
	PUSH R31
	PUSH R30
	LDD  R30,Y+5
	ORI  R30,8
	POP  R26
	POP  R27
	ST   X,R30
;    1444 	*ptr_++=8;
	CALL SUBOPT_0x14
	LDI  R30,LOW(8)
	CALL SUBOPT_0x15
;    1445 	*ptr_++=data_ptr[0];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1446 	*ptr_++=data_ptr[1];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,1
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1447 	*ptr_++=data_ptr[2];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,2
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1448 	*ptr_++=data_ptr[3];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,3
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1449 	*ptr_++=data_ptr[4];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,4
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1450 	
;    1451 	*ptr_++=data_ptr[5];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,5
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1452 	*ptr_++=data_ptr[6];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,6
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1453 	*ptr_++=data_ptr[7];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,7
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1454 	*ptr_++=data_ptr[8];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,8
	LD   R30,X
	POP  R26
	POP  R27
	CALL SUBOPT_0x15
;    1455 	*ptr_++=data_ptr[9];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,9
	LD   R30,X
	POP  R26
	POP  R27
	ST   X,R30
;    1456 	
;    1457     //	*ptr_++=0x46;//data_ptr[5];
;    1458     //	*ptr_++=/*0x47;//*/data_ptr[6];
;    1459     //	*ptr_++=/*0x48;//*/data_ptr[7];
;    1460    //	*ptr_++=/*0x49;//*/data_ptr[8];
;    1461    //	*ptr_++=0x4a;//data_ptr[9];	
;    1462 	}
;    1463 #asm("sei")	 
_0x3C:
	sei
;    1464 /*fifo_can_out[ptr,0]=adr0;	
;    1465 fifo_can_out[ptr,1]=adr1|0b00001000;
;    1466 fifo_can_out[ptr,2]=8;
;    1467 fifo_can_out[ptr,3]=data_ptr[0];
;    1468 fifo_can_out[ptr,4]=data_ptr[1];
;    1469 fifo_can_out[ptr,5]=data_ptr[2];
;    1470 fifo_can_out[ptr,6]=data_ptr[3];
;    1471 fifo_can_out[ptr,7]=data_ptr[4];
;    1472 fifo_can_out[ptr,8]=data_ptr[5];
;    1473 fifo_can_out[ptr,9]=data_ptr[6];
;    1474 fifo_can_out[ptr,10]=data_ptr[7];
;    1475 fifo_can_out[ptr,11]=data_ptr[8];
;    1476 fifo_can_out[ptr,12]=data_ptr[9];
;    1477 
;    1478 
;    1479 
;    1480              
;    1481 tx_counter++; */
;    1482 
;    1483 //DDRA.0=1;
;    1484 //PORTA.0=!PORTA.0;
;    1485 }                 
	ADIW R28,7
	RET
;    1486 #include "ruslcd.c"
;    1487 #ifndef  _rus_lcd_INCLUDED_
;    1488 #define _rus_lcd_INCLUDED_ 
;    1489 /*  ТАБЛИЦА СООТВЕТСТВИЯ
;    1490 Число	Символ	Число	Символ	Число	Символ	Число	Символ	ЧислоСимвол
;    1491 33	!	34	"	35	#	36	$	37	%
;    1492 38	&	39	'	40	(	41	)	42	*
;    1493 43	+	44	,	45	-	46	.	47	/
;    1494 48	0	49	1	50	2	51	3	52	4
;    1495 53	5	54	6	55	7	56	8	57	9
;    1496 58	:	59	;	60	<	61	=	62	>
;    1497 63	?	64	@	65	A	66	B	67	C
;    1498 68	D	69	E	70	F	71	G	72	H
;    1499 73	I	74	J	75	K	76	L	77	M
;    1500 78	N	79	O	80	P	81	Q	82	R
;    1501 83	S	84	T	85	U	86	V	87	W
;    1502 88	X	89	Y	90	Z	91	[	92	\
;    1503 93	]	94	^	95	_	96	`	97	a
;    1504 98	b	99	c	100	d	101	e	102	f
;    1505 103	g	104	h	105	I	106	j	107	k
;    1506 108	l	109	m	110	n	111	o	112	p
;    1507 113	q	114	r	115	s	116	t	117	u
;    1508 118	v	119	w	120	x	121	y	122	z
;    1509 123	{	124	|	125	}	126	~	132	"
;    1510 133	…	145	'	146	'	147	"	148	"
;    1511 149	o	150	-	151	-	153	™	166	¦
;    1512 167	§	168	Ё	169	©	171	"	172	   
;    1513 174	®	176	°	177	±	178	І	179	і
;    1514 182		183	·	184	ё	185	№	187	"
;    1515 192	А	193	Б	194	В	195	Г	196	Д
;    1516 197	Е	198	Ж	199	З	200	И	201	Й
;    1517 202	К	203	Л	204	М	205	Н	206	О
;    1518 207	П	208	Р	209	С	210	Т	211	У
;    1519 212	Ф	213	Х	214	Ц	215	Ч	216	Ш
;    1520 217	Щ	218	Ъ	219	Ы	220	Ь	221	Э
;    1521 222	Ю	223	Я	224	а	225	б	226	в
;    1522 227	г	228	д	229	е	230	ж	231	з
;    1523 232	и	233	й	234	к	235	л	236	м
;    1524 237	н	238	о	239	п	240	р	241	с
;    1525 242	т	243	у	244	ф	245	х	246	ц
;    1526 247	ч	248	ш	249	щ	250	ъ	251	ы
;    1527 252	ь	253	э	254	ю	255	я	-	-
;    1528 */
;    1529 const unsigned char rus_buff[]={                             // код буквы 
;    1530 0xFD,0xa2,255 ,                                     //167-169
;    1531 170 ,0xc8,172 ,173 ,174 ,175 ,176 ,177 ,0xd7,0x69,  //170-179
;    1532 180 ,181 ,0xfe,0xdf,0xb5,0xcc,186 ,0xc9,188 ,189 ,  //180-189
;    1533 190 ,191 ,0x41,0xa0,0x42,0xa1,0xe0,0x45,0xa3,0xa4,  //190-199
;    1534 0xa5,0xa6,0x4b,0xa7,0x4d,0x48,0x4f,0xa8,0x50,0x43,  //200-209
;    1535 0x54,0xa9,0xaa,0x58,0xe1,0xab,0xac,0xe2,0xad,0xae,  //210-219
;    1536 0xc4,0xaf,0xb0,0xb1,0x61,0xb2,0xb3,0xb4,0xe3,0x65,  //220-229
;    1537 0xb6,0xb7,0xb8,0xb9,0xba,0xbb,0xbc,0xbd,0x6f,0xbe,  //230-239
;    1538 0x70,0x63,0xbf,0x79,0xaa,0x78,0xe5,0xc0,0xc1,0xe6,  //240-249
;    1539 0xc2,0xc3,0xc4,0xc5,0xc6,0xc7};                     //250-255
;    1540 //преобразование массива начинается с 167 символа
;    1541 //десятичные цифры в буфере-это те символы, которые невозможно отображать на ЖКИ. 
;    1542 //Их можно назначить по своему усмотрению.
;    1543 //Например, сейчас (см выше) набрав на клавиатуре @ (код 169) на ЖКИ будет отображаться 
;    1544 //чёрное знакоместо (код 0хFF (255десятичн.) )
;    1545 /*
;    1546 @- 0хFF
;    1547 
;    1548 */
;    1549 void ruslcd (unsigned char *buff){
_ruslcd:
;    1550 unsigned char i;
;    1551 i=0;
	CALL SUBOPT_0x16
;	*buff -> Y+1
;	i -> Y+0
;    1552 while ( buff[i]!=0 ) {
_0x3E:
	CALL SUBOPT_0x17
	LD   R30,X
	CPI  R30,0
	BREQ _0x40
;    1553 	if(buff[i]>166) buff[i]=rus_buff[buff[i]-167];
	CALL SUBOPT_0x17
	LD   R26,X
	LDI  R30,LOW(166)
	CP   R30,R26
	BRSH _0x41
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R30,LOW(_rus_buff*2)
	LDI  R31,HIGH(_rus_buff*2)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x17
	LD   R30,X
	SUBI R30,LOW(167)
	POP  R26
	POP  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    1554 	i=i+1;}
_0x41:
	CALL SUBOPT_0x18
	RJMP _0x3E
_0x40:
;    1555 	
;    1556 /*	buff[0]=0x61;
;    1557 	buff[1]=rus_buff[buff[1]-167];//0xb2;//rus_buff[buff[1]-167];
;    1558 	buff[2]=0xb3;
;    1559 	buff[3]=0xb4;*/
;    1560 
;    1561 }//end void  
	ADIW R28,3
	RET
;    1562 #endif
;    1563 
;    1564 char modbus_buffer[20];

	.DSEG
_modbus_buffer:
	.BYTE 0x14
;    1565 char modbus_cnt; 
_modbus_cnt:
	.BYTE 0x1
;    1566 unsigned __fp_fmin,__fp_fmax,__fp_fcurr; 
___fp_fmin:
	.BYTE 0x2
___fp_fmax:
	.BYTE 0x2
___fp_fcurr:
	.BYTE 0x2
;    1567 unsigned read_parametr;
_read_parametr:
	.BYTE 0x2
;    1568 #include "crc16.c"
;    1569 // Table of CRC values for high-order byte */
;    1570 
;    1571 const unsigned char auchCRCHi[] = {

	.CSEG
;    1572 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 
;    1573 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 
;    1574 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 
;    1575 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 
;    1576 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 
;    1577 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 
;    1578 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 
;    1579 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 
;    1580 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 
;    1581 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 
;    1582 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 
;    1583 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 
;    1584 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 
;    1585 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 
;    1586 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 
;    1587 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 
;    1588 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 
;    1589 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 
;    1590 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 
;    1591 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 
;    1592 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 
;    1593 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 
;    1594 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 0x80, 0x41, 0x00, 0xC1, 
;    1595 0x81, 0x40, 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 
;    1596 0x00, 0xC1, 0x81, 0x40, 0x01, 0xC0, 0x80, 0x41, 0x01, 0xC0, 
;    1597 0x80, 0x41, 0x00, 0xC1, 0x81, 0x40
;    1598 } ; 
;    1599 
;    1600 
;    1601 //Table of CRC values for low-order byte 
;    1602 
;    1603 const char auchCRCLo[] = {
;    1604 0x00, 0xC0, 0xC1, 0x01, 0xC3, 0x03, 0x02, 0xC2, 0xC6, 0x06, 
;    1605 0x07, 0xC7, 0x05, 0xC5, 0xC4, 0x04, 0xCC, 0x0C, 0x0D, 0xCD, 
;    1606 0x0F, 0xCF, 0xCE, 0x0E, 0x0A, 0xCA, 0xCB, 0x0B, 0xC9, 0x09, 
;    1607 0x08, 0xC8, 0xD8, 0x18, 0x19, 0xD9, 0x1B, 0xDB, 0xDA, 0x1A, 
;    1608 0x1E, 0xDE, 0xDF, 0x1F, 0xDD, 0x1D, 0x1C, 0xDC, 0x14, 0xD4, 
;    1609 0xD5, 0x15, 0xD7, 0x17, 0x16, 0xD6, 0xD2, 0x12, 0x13, 0xD3, 
;    1610 0x11, 0xD1, 0xD0, 0x10, 0xF0, 0x30, 0x31, 0xF1, 0x33, 0xF3, 
;    1611 0xF2, 0x32, 0x36, 0xF6, 0xF7, 0x37, 0xF5, 0x35, 0x34, 0xF4, 
;    1612 0x3C, 0xFC, 0xFD, 0x3D, 0xFF, 0x3F, 0x3E, 0xFE, 0xFA, 0x3A, 
;    1613 0x3B, 0xFB, 0x39, 0xF9, 0xF8, 0x38, 0x28, 0xE8, 0xE9, 0x29, 
;    1614 0xEB, 0x2B, 0x2A, 0xEA, 0xEE, 0x2E, 0x2F, 0xEF, 0x2D, 0xED, 
;    1615 0xEC, 0x2C, 0xE4, 0x24, 0x25, 0xE5, 0x27, 0xE7, 0xE6, 0x26, 
;    1616 0x22, 0xE2, 0xE3, 0x23, 0xE1, 0x21, 0x20, 0xE0, 0xA0, 0x60, 
;    1617 0x61, 0xA1, 0x63, 0xA3, 0xA2, 0x62, 0x66, 0xA6, 0xA7, 0x67, 
;    1618 0xA5, 0x65, 0x64, 0xA4, 0x6C, 0xAC, 0xAD, 0x6D, 0xAF, 0x6F, 
;    1619 0x6E, 0xAE, 0xAA, 0x6A, 0x6B, 0xAB, 0x69, 0xA9, 0xA8, 0x68, 
;    1620 0x78, 0xB8, 0xB9, 0x79, 0xBB, 0x7B, 0x7A, 0xBA, 0xBE, 0x7E, 
;    1621 0x7F, 0xBF, 0x7D, 0xBD, 0xBC, 0x7C, 0xB4, 0x74, 0x75, 0xB5, 
;    1622 0x77, 0xB7, 0xB6, 0x76, 0x72, 0xB2, 0xB3, 0x73, 0xB1, 0x71, 
;    1623 0x70, 0xB0, 0x50, 0x90, 0x91, 0x51, 0x93, 0x53, 0x52, 0x92, 
;    1624 0x96, 0x56, 0x57, 0x97, 0x55, 0x95, 0x94, 0x54, 0x9C, 0x5C, 
;    1625 0x5D, 0x9D, 0x5F, 0x9F, 0x9E, 0x5E, 0x5A, 0x9A, 0x9B, 0x5B, 
;    1626 0x99, 0x59, 0x58, 0x98, 0x88, 0x48, 0x49, 0x89, 0x4B, 0x8B, 
;    1627 0x8A, 0x4A, 0x4E, 0x8E, 0x8F, 0x4F, 0x8D, 0x4D, 0x4C, 0x8C, 
;    1628 0x44, 0x84, 0x85, 0x45, 0x87, 0x47, 0x46, 0x86, 0x82, 0x42, 
;    1629 0x43, 0x83, 0x41, 0x81, 0x80, 0x40
;    1630 } ;
;    1631 
;    1632 unsigned crc16(char* puchMsg, unsigned usDataLen)
;    1633 {
_crc16:
;    1634 
;    1635 unsigned char uchCRCHi;	
;    1636 unsigned char uchCRCLo;
;    1637 unsigned char temp_temp;
;    1638 
;    1639 unsigned uIndex ;				
;    1640 uchCRCHi = 0xFF;
	SBIW R28,5
;	*puchMsg -> Y+7
;	usDataLen -> Y+5
;	uchCRCHi -> Y+4
;	uchCRCLo -> Y+3
;	temp_temp -> Y+2
;	uIndex -> Y+0
	LDI  R30,LOW(255)
	STD  Y+4,R30
;    1641 uchCRCLo = 0xFF;
	STD  Y+3,R30
;    1642 while (usDataLen--)		
_0x42:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	SBIW R30,1
	STD  Y+5,R30
	STD  Y+5+1,R31
	ADIW R30,1
	BREQ _0x44
;    1643 	{
;    1644 	temp_temp = *puchMsg;
	LDD  R26,Y+7
	LDD  R27,Y+7+1
	LD   R30,X
	STD  Y+2,R30
;    1645 	puchMsg++ ;
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ADIW R30,1
	STD  Y+7,R30
	STD  Y+7+1,R31
;    1646 	uIndex = uchCRCHi ^ temp_temp;	
	LDD  R30,Y+2
	LDD  R26,Y+4
	EOR  R30,R26
	LDI  R31,0
	ST   Y,R30
	STD  Y+1,R31
;    1647 	uchCRCHi = uchCRCLo ^ auchCRCHi[uIndex] ;
	LDI  R30,LOW(_auchCRCHi*2)
	LDI  R31,HIGH(_auchCRCHi*2)
	LD   R26,Y
	LDD  R27,Y+1
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	LDD  R26,Y+3
	EOR  R30,R26
	STD  Y+4,R30
;    1648 	uchCRCLo = auchCRCLo[uIndex] ;
	LDI  R30,LOW(_auchCRCLo*2)
	LDI  R31,HIGH(_auchCRCLo*2)
	LD   R26,Y
	LDD  R27,Y+1
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	STD  Y+3,R30
;    1649 	}
	RJMP _0x42
_0x44:
;    1650 
;    1651 return ((((unsigned)uchCRCHi) << 8) | uchCRCLo) ;
	LDI  R30,0
	LDD  R31,Y+4
	MOVW R26,R30
	LDD  R30,Y+3
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	ADIW R28,9
	RET
;    1652 }
;    1653 #define _485_tx_en_		PORTB.5
;    1654 #define _485_tx_en_dd_	DDRB.5
;    1655 #define _485_rx_en_		PORTB.6
;    1656 #define _485_rx_en_dd_	DDRB.6
;    1657 #include "modbus.c" 
;    1658 #define TX_BUFFER_SIZE0 24
;    1659 char tx_buffer0[TX_BUFFER_SIZE0];

	.DSEG
_tx_buffer0:
	.BYTE 0x18
;    1660 unsigned char tx_wr_index0,tx_rd_index0,tx_counter0; 
_tx_wr_index0:
	.BYTE 0x1
_tx_rd_index0:
	.BYTE 0x1
_tx_counter0:
	.BYTE 0x1
;    1661 
;    1662 #define RXB8 1
;    1663 #define TXB8 0
;    1664 #define UPE 2
;    1665 #define OVR 3
;    1666 #define FE 4
;    1667 #define UDRE 5
;    1668 #define RXC 7
;    1669 #define vlt_adress 2
;    1670 #define FRAMING_ERROR (1<<FE)
;    1671 #define PARITY_ERROR (1<<UPE)
;    1672 #define DATA_OVERRUN (1<<OVR)
;    1673 #define DATA_REGISTER_EMPTY (1<<UDRE)
;    1674 #define RX_COMPLETE (1<<RXC)
;    1675 #define modbus_baud	2400
;    1676 #define modbus_simbol_time   10000/modbus_baud
;    1677 
;    1678 // USART0 Receiver buffer
;    1679 #define RX_BUFFER_SIZE0 32
;    1680 char rx_buffer0[RX_BUFFER_SIZE0];
_rx_buffer0:
	.BYTE 0x20
;    1681 unsigned char rx_wr_index0,rx_rd_index0,rx_counter0;
_rx_wr_index0:
	.BYTE 0x1
_rx_rd_index0:
	.BYTE 0x1
_rx_counter0:
	.BYTE 0x1
;    1682 // This flag is set on USART0 Receiver buffer overflow
;    1683 bit rx_buffer_overflow0;
;    1684 
;    1685 char cnt_of_not_recieve;			
_cnt_of_not_recieve:
	.BYTE 0x1
;    1686 char UIB0_CNT;					//количество байт в принятой посылке
_UIB0_CNT:
	.BYTE 0x1
;    1687 char UIB0[50];					//буфер приёма
_UIB0:
	.BYTE 0x32
;    1688 bit bModbus_in;				//принята посылка
;    1689 bit bMODBUS_FREE=1;                //мастер не ожидает ответа от VLT
;    1690 char modbus_out_buffer[10,20],modbus_in_buffer[20];
_modbus_out_buffer:
	.BYTE 0xC8
_modbus_in_buffer:
	.BYTE 0x14
;    1691 char modbus_out_len[10],modbus_in_len;
_modbus_out_len:
	.BYTE 0xA
_modbus_in_len:
	.BYTE 0x1
;    1692 char modbus_out_ptr_rd,modbus_out_ptr_rd_old,modbus_out_ptr_wr;
_modbus_out_ptr_rd:
	.BYTE 0x1
_modbus_out_ptr_rd_old:
	.BYTE 0x1
_modbus_out_ptr_wr:
	.BYTE 0x1
;    1693 //extern void usart_out_adr0 (char *ptr, char len);
;    1694 unsigned cnt_of_end_recieve;		//реверсивный счетчик миллисикунд после приема последнего символа
_cnt_of_end_recieve:
	.BYTE 0x2
;    1695 unsigned cnt_of_end_transmission;	//реверсивный счетчик миллисикунд после отправки последнего символа
_cnt_of_end_transmission:
	.BYTE 0x2
;    1696 char repeat_transmission_cnt;
_repeat_transmission_cnt:
	.BYTE 0x1
;    1697 extern unsigned plazma_plazma;  
;    1698 unsigned fp_error_code;
_fp_error_code:
	.BYTE 0x2
;    1699 //-----------------------------------------------
;    1700 void modbus_in_an(void)
;    1701 {

	.CSEG
_modbus_in_an:
;    1702 unsigned temp_U;
;    1703 unsigned long temp_UL;
;    1704 char i;
;    1705 //modbus_cnt++;
;    1706 temp_U=crc16(modbus_in_buffer,modbus_in_len-2);
	SBIW R28,4
	CALL __SAVELOCR3
;	temp_U -> R16,R17
;	temp_UL -> Y+3
;	i -> R18
	LDI  R30,LOW(_modbus_in_buffer)
	LDI  R31,HIGH(_modbus_in_buffer)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x19
	CALL SUBOPT_0x1A
;    1707 
;    1708 if((modbus_in_buffer[modbus_in_len-1]==*((char*)&temp_U))
;    1709  &&(modbus_in_buffer[modbus_in_len-2]==*(((char*)&temp_U)+1))
;    1710  &&(modbus_in_buffer[0]==vlt_adress))
	LDS  R30,_modbus_in_len
	SUBI R30,LOW(1)
	CALL SUBOPT_0x1B
	CP   R16,R30
	BRNE _0x46
	CALL SUBOPT_0x19
	SUBI R30,LOW(-_modbus_in_buffer)
	SBCI R31,HIGH(-_modbus_in_buffer)
	LD   R30,Z
	CP   R17,R30
	BRNE _0x46
	LDS  R26,_modbus_in_buffer
	CPI  R26,LOW(0x2)
	BREQ _0x47
_0x46:
	RJMP _0x45
_0x47:
;    1711 	{
;    1712 	modbus_cnt++;
	LDS  R30,_modbus_cnt
	SUBI R30,-LOW(1)
	STS  _modbus_cnt,R30
;    1713 	bMODBUS_FREE=1;
	SET
	BLD  R4,1
;    1714 	repeat_transmission_cnt=0;
	LDI  R30,LOW(0)
	STS  _repeat_transmission_cnt,R30
;    1715 	cnt_of_end_transmission=0;
	LDI  R30,0
	STS  _cnt_of_end_transmission,R30
	STS  _cnt_of_end_transmission+1,R30
;    1716 	modbus_out_ptr_rd_old=modbus_out_ptr_rd;
	LDS  R30,_modbus_out_ptr_rd
	STS  _modbus_out_ptr_rd_old,R30
;    1717 	modbus_out_ptr_rd++;
	CALL SUBOPT_0x1C
;    1718 	if(modbus_out_ptr_rd>=10)modbus_out_ptr_rd=0;
	BRLO _0x48
	LDI  R30,LOW(0)
	STS  _modbus_out_ptr_rd,R30
;    1719 
;    1720 	if(modbus_out_buffer[modbus_out_ptr_rd,0]==0x01)
_0x48:
	CALL SUBOPT_0x1D
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x1)
	BRNE _0x49
;    1721 		{
;    1722 		temp_U=0;
	__GETWRN 16,17,0
;    1723 		for(i=2;i<6;i++)
	LDI  R18,LOW(2)
_0x4B:
	CPI  R18,6
	BRSH _0x4C
;    1724 			{
;    1725 			if(modbus_out_buffer[modbus_out_ptr_rd,i]!=modbus_in_buffer[i])temp_U=1;
	CALL SUBOPT_0x1D
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1E
	PUSH R30
	MOV  R30,R18
	CALL SUBOPT_0x1B
	POP  R26
	CP   R30,R26
	BREQ _0x4D
	__GETWRN 16,17,1
;    1726 			}
_0x4D:
	SUBI R18,-1
	RJMP _0x4B
_0x4C:
;    1727 		if(temp_U==0)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x4E
;    1728 			{
;    1729 			
;    1730 
;    1731 			}
;    1732 		}
_0x4E:
;    1733 			
;    1734 //Чтение регистров
;    1735 	if((modbus_out_buffer[modbus_out_ptr_rd_old,1]==0x03)&&(modbus_in_buffer[1]==0x03))
_0x49:
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x20
	CPI  R30,LOW(0x3)
	BRNE _0x50
	__GETB1MN _modbus_in_buffer,1
	CPI  R30,LOW(0x3)
	BREQ _0x51
_0x50:
	RJMP _0x4F
_0x51:
;    1736 		{
;    1737 		
;    1738 		if((modbus_in_buffer[2]==0x04)&&
;    1739 		   (modbus_out_buffer[modbus_out_ptr_rd_old,4]==0x00)&&
;    1740 		   (modbus_out_buffer[modbus_out_ptr_rd_old,5]==0x02))
	__GETB1MN _modbus_in_buffer,2
	CPI  R30,LOW(0x4)
	BRNE _0x53
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x21
	BRNE _0x53
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x2)
	BREQ _0x54
_0x53:
	RJMP _0x52
_0x54:
;    1741 		   	{
;    1742 		   	if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x07)&&  ////204 параметр
;    1743 		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0xF7))
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x7)
	BRNE _0x56
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0xF7)
	BREQ _0x57
_0x56:
	RJMP _0x55
_0x57:
;    1744 		  		{
;    1745 		  		temp_UL=0UL;
	__CLRD1S 3
;    1746 			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
	__GETB1MN _modbus_in_buffer,3
	CALL SUBOPT_0x25
;    1747 				temp_UL<<=8;
;    1748 				temp_UL&=0xffffff00UL;
;    1749 			
;    1750 				temp_UL+=(unsigned long)modbus_in_buffer[4];
	__GETB1MN _modbus_in_buffer,4
	CALL SUBOPT_0x25
;    1751 		    		temp_UL<<=8;
;    1752 				temp_UL&=0xffffff00UL;
;    1753 			
;    1754 		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
	__GETB1MN _modbus_in_buffer,5
	CALL SUBOPT_0x25
;    1755 				temp_UL<<=8;
;    1756 		    		temp_UL&=0xffffff00UL;  
;    1757 			
;    1758 				temp_UL+=(unsigned long)modbus_in_buffer[6];
	__GETB1MN _modbus_in_buffer,6
	CALL SUBOPT_0x26
;    1759                
;    1760 				temp_UL/=1000UL;
;    1761 			
;    1762 				__fp_fmin=(unsigned int)temp_UL;
	STS  ___fp_fmin,R30
	STS  ___fp_fmin+1,R31
;    1763 				}
;    1764 			else if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x08)&&  ////205 параметр
	RJMP _0x58
_0x55:
;    1765 		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x01))
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x8)
	BRNE _0x5A
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x1)
	BREQ _0x5B
_0x5A:
	RJMP _0x59
_0x5B:
;    1766 		  		{
;    1767 		  		temp_UL=0UL;
	__CLRD1S 3
;    1768 			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
	__GETB1MN _modbus_in_buffer,3
	CALL SUBOPT_0x25
;    1769 				temp_UL<<=8;
;    1770 				temp_UL&=0xffffff00UL;
;    1771 			
;    1772 				temp_UL+=(unsigned long)modbus_in_buffer[4];
	__GETB1MN _modbus_in_buffer,4
	CALL SUBOPT_0x25
;    1773 		    		temp_UL<<=8;
;    1774 				temp_UL&=0xffffff00UL;
;    1775 			
;    1776 		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
	__GETB1MN _modbus_in_buffer,5
	CALL SUBOPT_0x25
;    1777 				temp_UL<<=8;
;    1778 		    		temp_UL&=0xffffff00UL;  
;    1779 			
;    1780 				temp_UL+=(unsigned long)modbus_in_buffer[6];
	__GETB1MN _modbus_in_buffer,6
	CALL SUBOPT_0x26
;    1781                
;    1782 				temp_UL/=1000UL;
;    1783 			
;    1784 				__fp_fmax=(unsigned int)temp_UL;
	STS  ___fp_fmax,R30
	STS  ___fp_fmax+1,R31
;    1785 				}
;    1786 
;    1787 			else if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x14)&&  ////520 параметр
	RJMP _0x5C
_0x59:
;    1788 		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x4f))
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x14)
	BRNE _0x5E
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x4F)
	BREQ _0x5F
_0x5E:
	RJMP _0x5D
_0x5F:
;    1789 		  		{
;    1790 		  		temp_UL=0UL;
	__CLRD1S 3
;    1791 			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
	__GETB1MN _modbus_in_buffer,3
	CALL SUBOPT_0x25
;    1792 				temp_UL<<=8;
;    1793 				temp_UL&=0xffffff00UL;
;    1794 			
;    1795 				temp_UL+=(unsigned long)modbus_in_buffer[4];
	__GETB1MN _modbus_in_buffer,4
	CALL SUBOPT_0x25
;    1796 		    		temp_UL<<=8;
;    1797 				temp_UL&=0xffffff00UL;
;    1798 			
;    1799 		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
	__GETB1MN _modbus_in_buffer,5
	CALL SUBOPT_0x25
;    1800 				temp_UL<<=8;
;    1801 		    		temp_UL&=0xffffff00UL;  
;    1802 			
;    1803 				temp_UL+=(unsigned long)modbus_in_buffer[6];
	__GETB1MN _modbus_in_buffer,6
	CALL SUBOPT_0x27
;    1804                
;    1805 				temp_UL/=10UL;
	__GETD2S 3
	__GETD1N 0xA
	CALL __DIVD21U
	__PUTD1S 3
;    1806 			
;    1807 				//fp_fmax=(unsigned int)temp_UL;
;    1808 			    	if(fp_stat==dvON)
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BRNE _0x60
;    1809 			    		{
;    1810 			    		Id[pilot_dv]=(unsigned int)temp_UL;
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	LDI  R26,LOW(_Id)
	LDI  R27,HIGH(_Id)
	CALL SUBOPT_0x28
;    1811 			    		Ida[pilot_dv]=(unsigned int)temp_UL;
	LDI  R26,LOW(_Ida)
	LDI  R27,HIGH(_Ida)
	CALL SUBOPT_0x28
;    1812 			    		Idc[pilot_dv]=(unsigned int)temp_UL;
	LDI  R26,LOW(_Idc)
	LDI  R27,HIGH(_Idc)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   X+,R30
	ST   X,R31
;    1813 			    		}
;    1814 			    	
;    1815 			    	plazma_plazma=(unsigned int)temp_UL;
_0x60:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	STS  _plazma_plazma,R30
	STS  _plazma_plazma+1,R31
;    1816 				}
;    1817 
;    1818 			else if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x15)&&  ////538 параметр
	RJMP _0x61
_0x5D:
;    1819 		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x03))
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x15)
	BRNE _0x63
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x3)
	BREQ _0x64
_0x63:
	RJMP _0x62
_0x64:
;    1820 		  		{
;    1821 		  		temp_UL=0UL;
	__CLRD1S 3
;    1822 			   	temp_UL+=(unsigned long)modbus_in_buffer[3];
	__GETB1MN _modbus_in_buffer,3
	CALL SUBOPT_0x25
;    1823 				temp_UL<<=8;
;    1824 				temp_UL&=0xffffff00UL;
;    1825 			
;    1826 				temp_UL+=(unsigned long)modbus_in_buffer[4];
	__GETB1MN _modbus_in_buffer,4
	CALL SUBOPT_0x25
;    1827 		    		temp_UL<<=8;
;    1828 				temp_UL&=0xffffff00UL;
;    1829 			
;    1830 		    		temp_UL+=(unsigned long)modbus_in_buffer[5];
	__GETB1MN _modbus_in_buffer,5
	CALL SUBOPT_0x25
;    1831 				temp_UL<<=8;
;    1832 		    		temp_UL&=0xffffff00UL;  
;    1833 			
;    1834 				temp_UL+=(unsigned long)modbus_in_buffer[6];
	__GETB1MN _modbus_in_buffer,6
	CALL SUBOPT_0x27
;    1835                
;    1836 				fp_error_code=temp_UL;
	__GETD1S 3
	STS  _fp_error_code,R30
	STS  _fp_error_code+1,R31
;    1837 			
;    1838 				}				
;    1839 			}
_0x62:
_0x61:
_0x5C:
_0x58:
;    1840 		if((modbus_in_buffer[2]==0x02)&&
_0x52:
;    1841 		   (modbus_out_buffer[modbus_out_ptr_rd_old,4]==0x00)&&
;    1842 		   (modbus_out_buffer[modbus_out_ptr_rd_old,5]==0x01))
	__GETB1MN _modbus_in_buffer,2
	CPI  R30,LOW(0x2)
	BRNE _0x66
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x21
	BRNE _0x66
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x1)
	BREQ _0x67
_0x66:
	RJMP _0x65
_0x67:
;    1843 		   	{plazma++;
	CALL SUBOPT_0x29
;    1844 		   	if((modbus_out_buffer[modbus_out_ptr_rd_old,2]==0x14)&&  ////518 параметр,частота
;    1845 		   	   (modbus_out_buffer[modbus_out_ptr_rd_old,3]==0x3b))
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x23
	CPI  R30,LOW(0x14)
	BRNE _0x69
	CALL SUBOPT_0x1F
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x3B)
	BREQ _0x6A
_0x69:
	RJMP _0x68
_0x6A:
;    1846 		  		{
;    1847 			 	temp_UL=0UL;
	__CLRD1S 3
;    1848 				temp_UL+=modbus_in_buffer[3];
	__GETB1MN _modbus_in_buffer,3
	CALL SUBOPT_0x2A
;    1849 				temp_UL<<=8;
	__GETD2S 3
	LDI  R30,LOW(8)
	CALL __LSLD12
	__PUTD1S 3
;    1850 				temp_UL&=0xffffff00;
	LDD  R30,Y+3
	ANDI R30,LOW(0xFFFFFF00)
	STD  Y+3,R30
;    1851 			
;    1852 				temp_UL+=modbus_in_buffer[4];
	__GETB1MN _modbus_in_buffer,4
	CALL SUBOPT_0x2A
;    1853 			
;    1854 				__fp_fcurr=(unsigned int)temp_UL;
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	STS  ___fp_fcurr,R30
	STS  ___fp_fcurr+1,R31
;    1855 				}
;    1856 		   	}			
_0x68:
;    1857 		}	
_0x65:
;    1858 	
;    1859 	
;    1860 	
;    1861 	
;    1862 				
;    1863 	if(modbus_out_buffer[modbus_out_ptr_rd,0]==0x06)
_0x4F:
	CALL SUBOPT_0x1D
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x6)
	BRNE _0x6B
;    1864 		{
;    1865 		temp_U=0;
	__GETWRN 16,17,0
;    1866 		for(i=2;i<6;i++)
	LDI  R18,LOW(2)
_0x6D:
	CPI  R18,6
	BRSH _0x6E
;    1867 			{
;    1868 			if(modbus_out_buffer[modbus_out_ptr_rd,i]!=modbus_in_buffer[i])temp_U=1;
	CALL SUBOPT_0x1D
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1E
	PUSH R30
	MOV  R30,R18
	CALL SUBOPT_0x1B
	POP  R26
	CP   R30,R26
	BREQ _0x6F
	__GETWRN 16,17,1
;    1869 			}
_0x6F:
	SUBI R18,-1
	RJMP _0x6D
_0x6E:
;    1870 		if(temp_U==0)
	MOV  R0,R16
	OR   R0,R17
	BRNE _0x70
;    1871 			{
;    1872 			
;    1873 
;    1874 			}
;    1875 		}
_0x70:
;    1876 	}
_0x6B:
;    1877 }
_0x45:
	CALL __LOADLOCR3
	ADIW R28,7
	RET
;    1878 
;    1879 //----------------------------------------------
;    1880 void putchar0(char c)
;    1881 {
_putchar0:
;    1882 while (tx_counter0 == TX_BUFFER_SIZE0);
_0x71:
	LDS  R26,_tx_counter0
	CPI  R26,LOW(0x18)
	BREQ _0x71
;    1883 #asm("cli")
	cli
;    1884 if (tx_counter0 || ((UCSR0A & DATA_REGISTER_EMPTY)==0))
	LDS  R30,_tx_counter0
	CPI  R30,0
	BRNE _0x75
	SBIC 0xB,5
	RJMP _0x74
_0x75:
;    1885    {
;    1886    tx_buffer0[tx_wr_index0]=c;
	LDS  R26,_tx_wr_index0
	LDI  R27,0
	SUBI R26,LOW(-_tx_buffer0)
	SBCI R27,HIGH(-_tx_buffer0)
	LD   R30,Y
	ST   X,R30
;    1887    if (++tx_wr_index0 == TX_BUFFER_SIZE0) tx_wr_index0=0;
	LDS  R26,_tx_wr_index0
	SUBI R26,-LOW(1)
	STS  _tx_wr_index0,R26
	CPI  R26,LOW(0x18)
	BRNE _0x77
	LDI  R30,LOW(0)
	STS  _tx_wr_index0,R30
;    1888    ++tx_counter0;
_0x77:
	LDS  R30,_tx_counter0
	SUBI R30,-LOW(1)
	STS  _tx_counter0,R30
;    1889    }
;    1890 else
	RJMP _0x78
_0x74:
;    1891 	{
;    1892 	_485_tx_en_dd_=1;
	SBI  0x17,5
;    1893 	_485_tx_en_=1;
	SBI  0x18,5
;    1894 	_485_rx_en_dd_=1;
	SBI  0x17,6
;    1895 	_485_rx_en_=1;  	
	SBI  0x18,6
;    1896 	UDR0=c;
	LD   R30,Y
	OUT  0xC,R30
;    1897 	bMODBUS_FREE=0;
	CLT
	BLD  R4,1
;    1898 	}
_0x78:
;    1899 #asm("sei")
	sei
;    1900 }
	ADIW R28,1
	RET
;    1901 
;    1902 //----------------------------------------------
;    1903 void read_vlt_coil(unsigned coil_adress)
;    1904 { 
_read_vlt_coil:
;    1905 unsigned int temp_U;
;    1906 temp_U=coil_adress-1;
	ST   -Y,R17
	ST   -Y,R16
;	coil_adress -> Y+2
;	temp_U -> R16,R17
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL SUBOPT_0x2B
;    1907 modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;    1908 modbus_out_buffer[modbus_out_ptr_wr,1]=0x01;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2D
	LDI  R30,LOW(1)
	CALL SUBOPT_0x2E
;    1909 modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2F
;    1910 modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x30
;    1911 modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x31
;    1912 modbus_out_buffer[modbus_out_ptr_wr,5]=0x20;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x32
;    1913 temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],6);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x33
;    1914 modbus_out_buffer[modbus_out_ptr_wr,6]=*(((char*)(&temp_U))+1);
	CALL SUBOPT_0x34
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x35
;    1915 modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x36
;    1916 modbus_out_len[modbus_out_ptr_wr]=8;
;    1917 modbus_out_ptr_wr++;
;    1918 if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
	BRLO _0x79
	LDI  R30,LOW(0)
	STS  _modbus_out_ptr_wr,R30
;    1919 }   
_0x79:
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0xB44
;    1920 
;    1921 //----------------------------------------------
;    1922 void write_vlt_coil(unsigned coil_adress,unsigned data1,unsigned data2)
;    1923 { 
_write_vlt_coil:
;    1924 unsigned int temp_U;
;    1925 temp_U=coil_adress-1;
	ST   -Y,R17
	ST   -Y,R16
;	coil_adress -> Y+6
;	data1 -> Y+4
;	data2 -> Y+2
;	temp_U -> R16,R17
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x2B
;    1926 modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;    1927 modbus_out_buffer[modbus_out_ptr_wr,1]=0x0f;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2D
	LDI  R30,LOW(15)
	CALL SUBOPT_0x2E
;    1928 modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2F
;    1929 modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x30
;    1930 modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x31
;    1931 modbus_out_buffer[modbus_out_ptr_wr,5]=0x20;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x32
;    1932 modbus_out_buffer[modbus_out_ptr_wr,6]=0x04;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x37
;    1933 modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&data1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,7
	CALL SUBOPT_0x38
;    1934 modbus_out_buffer[modbus_out_ptr_wr,8]=*(((char*)(&data1))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,8
	CALL SUBOPT_0x39
;    1935 modbus_out_buffer[modbus_out_ptr_wr,9]=*((char*)&data2);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,9
	CALL SUBOPT_0x3A
;    1936 modbus_out_buffer[modbus_out_ptr_wr,10]=*(((char*)(&data2))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,10
	CALL SUBOPT_0x3B
;    1937 temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],11);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x3C
;    1938 modbus_out_buffer[modbus_out_ptr_wr,11]=*(((char*)(&temp_U))+1);
	CALL SUBOPT_0x34
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x3D
;    1939 modbus_out_buffer[modbus_out_ptr_wr,12]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x3E
;    1940 modbus_out_len[modbus_out_ptr_wr]=13;
;    1941 modbus_out_ptr_wr++;
;    1942 if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
	BRLO _0x7A
	LDI  R30,LOW(0)
	STS  _modbus_out_ptr_wr,R30
;    1943 }
_0x7A:
	RJMP _0xB46
;    1944 
;    1945 
;    1946 
;    1947 //----------------------------------------------
;    1948 void write_vlt_register(unsigned reg_adress,unsigned data)
;    1949 { 
;    1950 unsigned int temp_U;
;    1951 temp_U=(reg_adress*10)-1;
;	reg_adress -> Y+4
;	data -> Y+2
;	temp_U -> R16,R17
;    1952 modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
;    1953 modbus_out_buffer[modbus_out_ptr_wr,1]=0x06;
;    1954 modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
;    1955 modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
;    1956 modbus_out_buffer[modbus_out_ptr_wr,4]=*(((char*)(&data))+1);
;    1957 modbus_out_buffer[modbus_out_ptr_wr,5]=*((char*)&data);
;    1958 temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],6);
;    1959 modbus_out_buffer[modbus_out_ptr_wr,6]=*(((char*)(&temp_U))+1);
;    1960 modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&temp_U);
;    1961 modbus_out_len[modbus_out_ptr_wr]=8;
;    1962 modbus_out_ptr_wr++;
;    1963 if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
;    1964 }
;    1965 
;    1966 //----------------------------------------------
;    1967 void write_vlt_registers(unsigned reg_adress,unsigned long data)
;    1968 { 
_write_vlt_registers:
;    1969 unsigned int temp_U;
;    1970 temp_U=(reg_adress*10)-1;
	ST   -Y,R17
	ST   -Y,R16
;	reg_adress -> Y+6
;	data -> Y+2
;	temp_U -> R16,R17
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	CALL SUBOPT_0x3F
;    1971 modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;    1972 modbus_out_buffer[modbus_out_ptr_wr,1]=0x10;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2D
	LDI  R30,LOW(16)
	CALL SUBOPT_0x2E
;    1973 modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2F
;    1974 modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x30
;    1975 modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x31
;    1976 modbus_out_buffer[modbus_out_ptr_wr,5]=0x02;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,5
	MOVW R26,R30
	LDI  R30,LOW(2)
	CALL SUBOPT_0x2E
;    1977 modbus_out_buffer[modbus_out_ptr_wr,6]=0x04;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x37
;    1978 modbus_out_buffer[modbus_out_ptr_wr,7]=*(((char*)(&data))+3);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,7
	CALL SUBOPT_0x39
;    1979 modbus_out_buffer[modbus_out_ptr_wr,8]=*(((char*)(&data))+2);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,8
	CALL SUBOPT_0x38
;    1980 modbus_out_buffer[modbus_out_ptr_wr,9]=*(((char*)(&data))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,9
	CALL SUBOPT_0x3B
;    1981 modbus_out_buffer[modbus_out_ptr_wr,10]=*((char*)&data);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,10
	CALL SUBOPT_0x3A
;    1982 temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],11);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x3C
;    1983 modbus_out_buffer[modbus_out_ptr_wr,11]=*(((char*)(&temp_U))+1);
	CALL SUBOPT_0x34
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x3D
;    1984 modbus_out_buffer[modbus_out_ptr_wr,12]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x3E
;    1985 modbus_out_len[modbus_out_ptr_wr]=13;
;    1986 modbus_out_ptr_wr++;
;    1987 if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
	BRLO _0x7C
	LDI  R30,LOW(0)
	STS  _modbus_out_ptr_wr,R30
;    1988 }
_0x7C:
_0xB46:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,8
	RET
;    1989 
;    1990 //----------------------------------------------
;    1991 void read_vlt_register(unsigned reg_adress,char numbers)
;    1992 { 
_read_vlt_register:
;    1993 unsigned int temp_U;
;    1994 temp_U=(reg_adress*10)-1;
	ST   -Y,R17
	ST   -Y,R16
;	reg_adress -> Y+3
;	numbers -> Y+2
;	temp_U -> R16,R17
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	CALL SUBOPT_0x3F
;    1995 modbus_out_buffer[modbus_out_ptr_wr,0]=vlt_adress;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2C
;    1996 modbus_out_buffer[modbus_out_ptr_wr,1]=0x03;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2D
	LDI  R30,LOW(3)
	CALL SUBOPT_0x2E
;    1997 modbus_out_buffer[modbus_out_ptr_wr,2]=*(((char*)(&temp_U))+1);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x2F
;    1998 modbus_out_buffer[modbus_out_ptr_wr,3]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x30
;    1999 modbus_out_buffer[modbus_out_ptr_wr,4]=0x00;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x31
;    2000 modbus_out_buffer[modbus_out_ptr_wr,5]=numbers;
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,5
	CALL SUBOPT_0x3A
;    2001 temp_U=crc16(&modbus_out_buffer[modbus_out_ptr_wr,0],6);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x33
;    2002 modbus_out_buffer[modbus_out_ptr_wr,6]=*(((char*)(&temp_U))+1);
	CALL SUBOPT_0x34
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x35
;    2003 modbus_out_buffer[modbus_out_ptr_wr,7]=*((char*)&temp_U);
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x36
;    2004 modbus_out_len[modbus_out_ptr_wr]=8;
;    2005 modbus_out_ptr_wr++;
;    2006 if(modbus_out_ptr_wr>=10)modbus_out_ptr_wr=0;     
	BRLO _0x7D
	LDI  R30,LOW(0)
	STS  _modbus_out_ptr_wr,R30
;    2007 }
_0x7D:
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0xB45
;    2008 
;    2009 
;    2010 //-----------------------------------------------
;    2011 void modbus_out (char *ptr, char len)
;    2012 {
_modbus_out:
;    2013 
;    2014 char i,t=0;
;    2015 
;    2016 for (i=0;i<len;i++)
	SBIW R28,2
	LDI  R24,1
	LDI  R26,LOW(0)
	LDI  R27,HIGH(0)
	LDI  R30,LOW(_0x7E*2)
	LDI  R31,HIGH(_0x7E*2)
	CALL __INITLOCB
;	*ptr -> Y+3
;	len -> Y+2
;	i -> Y+1
;	t -> Y+0
	LDI  R30,LOW(0)
	STD  Y+1,R30
_0x80:
	LDD  R30,Y+2
	LDD  R26,Y+1
	CP   R26,R30
	BRSH _0x81
;    2017 	{
;    2018 	putchar0(ptr[i]);
	LDD  R30,Y+1
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ST   -Y,R30
	CALL _putchar0
;    2019 	}  
	CALL SUBOPT_0x40
	RJMP _0x80
_0x81:
;    2020 }
	RJMP _0xB45
;    2021 
;    2022 //----------------------------------------------
;    2023 //Подпрограмма временнОго обслуживания modbus,
;    2024 //вызывается 1 раз в миллисикунду
;    2025 void modbus_drv(void)
;    2026 {
_modbus_drv:
;    2027 
;    2028 if(cnt_of_end_recieve)
	LDS  R30,_cnt_of_end_recieve
	LDS  R31,_cnt_of_end_recieve+1
	SBIW R30,0
	BREQ _0x82
;    2029 	{
;    2030 	cnt_of_end_recieve--;
	SBIW R30,1
	STS  _cnt_of_end_recieve,R30
	STS  _cnt_of_end_recieve+1,R31
;    2031 	if(cnt_of_end_recieve==0)
	SBIW R30,0
	BRNE _0x83
;    2032 		{
;    2033 		char i;
;    2034 		for(i=0;i<rx_wr_index0;i++)
	CALL SUBOPT_0x16
;	i -> Y+0
_0x85:
	LDS  R30,_rx_wr_index0
	LD   R26,Y
	CP   R26,R30
	BRSH _0x86
;    2035 			{
;    2036 			modbus_in_buffer[i]=rx_buffer0[i];
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-_modbus_in_buffer)
	SBCI R31,HIGH(-_modbus_in_buffer)
	PUSH R31
	PUSH R30
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	LD   R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    2037 			modbus_in_len=rx_wr_index0;
	LDS  R30,_rx_wr_index0
	STS  _modbus_in_len,R30
;    2038 			}
	CALL SUBOPT_0x18
	RJMP _0x85
_0x86:
;    2039 		rx_counter0=0;
	LDI  R30,LOW(0)
	STS  _rx_counter0,R30
;    2040 		rx_wr_index0=0;
	STS  _rx_wr_index0,R30
;    2041 		modbus_in_an();			
	CALL _modbus_in_an
;    2042 	   //	_485_rx_en_dd_=1;
;    2043 	   //	_485_rx_en_=0;
;    2044 		}
	ADIW R28,1
;    2045 	}
_0x83:
;    2046 
;    2047 if(!bMODBUS_FREE)
_0x82:
	SBRC R4,1
	RJMP _0x87
;    2048 	{
;    2049 	if(cnt_of_end_transmission)
	LDS  R30,_cnt_of_end_transmission
	LDS  R31,_cnt_of_end_transmission+1
	SBIW R30,0
	BREQ _0x88
;    2050 		{
;    2051 		cnt_of_end_transmission--;
	SBIW R30,1
	STS  _cnt_of_end_transmission,R30
	STS  _cnt_of_end_transmission+1,R31
;    2052 		if(!cnt_of_end_transmission)
	SBIW R30,0
	BRNE _0x89
;    2053 			{
;    2054 			if(repeat_transmission_cnt<10)
	LDS  R26,_repeat_transmission_cnt
	CPI  R26,LOW(0xA)
	BRSH _0x8A
;    2055 				{
;    2056 				modbus_out(&modbus_out_buffer[modbus_out_ptr_rd,0],modbus_out_len[modbus_out_ptr_rd]);
	CALL SUBOPT_0x1D
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x41
;    2057 				repeat_transmission_cnt++;
	LDS  R30,_repeat_transmission_cnt
	SUBI R30,-LOW(1)
	STS  _repeat_transmission_cnt,R30
;    2058 				}
;    2059 			else 
	RJMP _0x8B
_0x8A:
;    2060 				{
;    2061 				bMODBUS_FREE=1;
	SET
	BLD  R4,1
;    2062 				modbus_out_ptr_rd++;
	CALL SUBOPT_0x1C
;    2063 				if(modbus_out_ptr_rd>=10)modbus_out_ptr_rd=0;
	BRLO _0x8C
	LDI  R30,LOW(0)
	STS  _modbus_out_ptr_rd,R30
;    2064 				}
_0x8C:
_0x8B:
;    2065 			}
;    2066 		}
_0x89:
;    2067 	}  
_0x88:
;    2068 
;    2069 /*if(cnt_of_not_recieve<50)
;    2070 	{
;    2071 	cnt_of_not_recieve++;
;    2072 	if(cnt_of_not_recieve==16)
;    2073 		{
;    2074 		char i;
;    2075 		for(i=0;i<rx_wr_index0;i++)
;    2076 			{
;    2077 			UIB0[i]=rx_buffer0[i];
;    2078 			UIB0_CNT=rx_wr_index0;
;    2079 			}
;    2080 		rx_counter0=0;
;    2081 		rx_wr_index0=0;
;    2082 		bModbus_in=1;			
;    2083 		_485_rx_en_dd_=1;
;    2084 		_485_rx_en_=0;
;    2085 			
;    2086 		}
;    2087 	}*/
;    2088 if((modbus_out_ptr_wr!=modbus_out_ptr_rd)&&(bMODBUS_FREE))
_0x87:
	LDS  R30,_modbus_out_ptr_rd
	LDS  R26,_modbus_out_ptr_wr
	CP   R30,R26
	BREQ _0x8E
	SBRC R4,1
	RJMP _0x8F
_0x8E:
	RJMP _0x8D
_0x8F:
;    2089 	{
;    2090 	modbus_out(&modbus_out_buffer[modbus_out_ptr_rd,0],modbus_out_len[modbus_out_ptr_rd]);
	CALL SUBOPT_0x1D
	PUSH R27
	PUSH R26
	LDI  R26,LOW(20)
	LDI  R27,HIGH(20)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x41
;    2091 	repeat_transmission_cnt=0;
	LDI  R30,LOW(0)
	STS  _repeat_transmission_cnt,R30
;    2092 
;    2093 	}    
;    2094 }
_0x8D:
	RET
;    2095 
;    2096 
;    2097 
;    2098 //----------------------------------------------
;    2099 // USART0 Receiver interrupt service routine
;    2100 interrupt [USART0_RXC] void usart0_rx_isr(void)
;    2101 {
_usart0_rx_isr:
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    2102 char status,data;
;    2103 status=UCSR0A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R16
;	data -> R17
	IN   R16,11
;    2104 data=UDR0;
	IN   R17,12
;    2105 if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R16
	ANDI R30,LOW(0x1C)
	BRNE _0x90
;    2106    {
;    2107    rx_buffer0[rx_wr_index0]=data;
	LDS  R26,_rx_wr_index0
	LDI  R27,0
	SUBI R26,LOW(-_rx_buffer0)
	SBCI R27,HIGH(-_rx_buffer0)
	ST   X,R17
;    2108    if (++rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=RX_BUFFER_SIZE0;
	LDS  R26,_rx_wr_index0
	SUBI R26,-LOW(1)
	STS  _rx_wr_index0,R26
	CPI  R26,LOW(0x20)
	BRNE _0x91
	LDI  R30,LOW(32)
	STS  _rx_wr_index0,R30
;    2109    if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x91:
	LDS  R26,_rx_counter0
	SUBI R26,-LOW(1)
	STS  _rx_counter0,R26
	CPI  R26,LOW(0x20)
	BRNE _0x92
;    2110       {
;    2111       rx_counter0=0;
	LDI  R30,LOW(0)
	STS  _rx_counter0,R30
;    2112       rx_buffer_overflow0=1;
	SET
	BLD  R3,7
;    2113       };
_0x92:
;    2114    cnt_of_end_recieve=(modbus_simbol_time*3)+1;
	LDI  R30,LOW(13)
	LDI  R31,HIGH(13)
	STS  _cnt_of_end_recieve,R30
	STS  _cnt_of_end_recieve+1,R31
;    2115    };
_0x90:
;    2116 }
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
;    2117 
;    2118 #ifndef _DEBUG_TERMINAL_IO_
;    2119 // Get a character from the USART0 Receiver buffer
;    2120 #define _ALTERNATE_GETCHAR_
;    2121 #pragma used+
;    2122 char getchar(void)
;    2123 {
;    2124 char data;
;    2125 while (rx_counter0==0);
;	data -> R16
;    2126 data=rx_buffer0[rx_rd_index0];
;    2127 if (++rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
;    2128 #asm("cli")
	cli
;    2129 --rx_counter0;
;    2130 #asm("sei")
	sei
;    2131 return data;
;    2132 }
;    2133 #pragma used-
;    2134 #endif
;    2135 
;    2136 // USART0 Transmitter buffer
;    2137 
;    2138 
;    2139 //----------------------------------------------
;    2140 // USART0 Transmitter interrupt service routine
;    2141 interrupt [USART0_TXC] void usart0_tx_isr(void)
;    2142 {
_usart0_tx_isr:
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
;    2143 if (tx_counter0)
	LDS  R30,_tx_counter0
	CPI  R30,0
	BREQ _0x97
;    2144    	{
;    2145 	_485_tx_en_dd_=1;
	SBI  0x17,5
;    2146 	_485_tx_en_=1; 
	SBI  0x18,5
;    2147 	_485_rx_en_dd_=1;
	SBI  0x17,6
;    2148 	_485_rx_en_=1;  
	SBI  0x18,6
;    2149    	--tx_counter0;
	SUBI R30,LOW(1)
	STS  _tx_counter0,R30
;    2150    	UDR0=tx_buffer0[tx_rd_index0];
	LDS  R30,_tx_rd_index0
	LDI  R31,0
	SUBI R30,LOW(-_tx_buffer0)
	SBCI R31,HIGH(-_tx_buffer0)
	LD   R30,Z
	OUT  0xC,R30
;    2151    	if (++tx_rd_index0 == TX_BUFFER_SIZE0) tx_rd_index0=0;
	LDS  R26,_tx_rd_index0
	SUBI R26,-LOW(1)
	STS  _tx_rd_index0,R26
	CPI  R26,LOW(0x18)
	BRNE _0x98
	LDI  R30,LOW(0)
	STS  _tx_rd_index0,R30
;    2152    	}
_0x98:
;    2153 else 
	RJMP _0x99
_0x97:
;    2154 	{
;    2155 	_485_tx_en_dd_=1;
	SBI  0x17,5
;    2156 	_485_tx_en_=0;	 
	CBI  0x18,5
;    2157 	_485_rx_en_dd_=1;
	SBI  0x17,6
;    2158 	_485_rx_en_=0;
	CBI  0x18,6
;    2159 	cnt_of_end_transmission=150;	
	LDI  R30,LOW(150)
	LDI  R31,HIGH(150)
	STS  _cnt_of_end_transmission,R30
	STS  _cnt_of_end_transmission+1,R31
;    2160 	}   	
_0x99:
;    2161 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
;    2162 
;    2163 
;    2164 
;    2165 
;    2166 
;    2167 
;    2168 signed fr_stat=0;

	.DSEG
_fr_stat:
	.BYTE 0x2
;    2169 enum {mSTOP=0x00,mSTART=0x11,mREG=0x22,mTORM=0x88,mFPAV=0x99}mode=mSTOP;
_mode:
	.BYTE 0x1
;    2170 signed power_cnt;
_power_cnt:
	.BYTE 0x2
;    2171 signed hh_av_cnt; 
_hh_av_cnt:
	.BYTE 0x2
;    2172 signed p_old; 
_p_old:
	.BYTE 0x2
;    2173 signed pid_cnt;
_pid_cnt:
	.BYTE 0x2
;    2174 signed e[3];
_e:
	.BYTE 0x6
;    2175 signed long u;
_u:
	.BYTE 0x4
;    2176 signed bPOWER;
_bPOWER:
	.BYTE 0x2
;    2177 #define a0	245L 
;    2178 #define a1	-350L
;    2179 #define a2	125L
;    2180 eeprom signed PID_PERIOD; 

	.ESEG
_PID_PERIOD:
	.DW  0x0
;    2181 eeprom signed PID_K;
_PID_K:
	.DW  0x0
;    2182 eeprom signed PID_K_P;
_PID_K_P:
	.DW  0x0
;    2183 eeprom signed PID_K_D;
_PID_K_D:
	.DW  0x0
;    2184 eeprom signed PID_K_FP_DOWN;
_PID_K_FP_DOWN:
	.DW  0x0
;    2185 signed long p_bank[16];

	.DSEG
_p_bank:
	.BYTE 0x40
;    2186 char p_bank_cnt;  
_p_bank_cnt:
	.BYTE 0x1
;    2187 bit bPOTENZ_UP,bPOTENZ_DOWN;
;    2188 char net_motor_potenz,net_motor_wrk;
_net_motor_potenz:
	.BYTE 0x1
_net_motor_wrk:
	.BYTE 0x1
;    2189 char mode_ust;  
_mode_ust:
	.BYTE 0x1
;    2190 
;    2191 /*typedef eeprom struct
;    2192 	{  */
;    2193 eeprom unsigned timer_time1[7,5];

	.ESEG
_timer_time1:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;    2194 eeprom unsigned timer_time2[7,5];
_timer_time2:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;    2195 eeprom char timer_mode[7,5];
_timer_mode:
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
	.DB  0x0
;    2196 eeprom signed timer_data1[7,5];
_timer_data1:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;    2197 eeprom signed timer_data2[7,5];
_timer_data2:
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
	.DW  0x0
;    2198 /*	}
;    2199 	TIMER_STRUCT;
;    2200 
;    2201 TIMER_STRUCT eeprom timer_data[7][5]; */ 
;    2202 
;    2203 bit bDVCH;
;    2204 bit bPMIN; 
;    2205 signed p_max_cnt,p_min_cnt;	

	.DSEG
_p_max_cnt:
	.BYTE 0x2
_p_min_cnt:
	.BYTE 0x2
;    2206 enum {avpOFF=0x00,avpMIN=0x11,avpMAX=0x22}av_p_stat=avpOFF; 
_av_p_stat:
	.BYTE 0x1
;    2207 unsigned avp_day_cnt[4]={0,0,0,0};
_avp_day_cnt:
	.BYTE 0x8
;    2208 
;    2209 unsigned CURR_TIME;
_CURR_TIME:
	.BYTE 0x2
;    2210 char temp_DVCH;
_temp_DVCH:
	.BYTE 0x1
;    2211 unsigned plazma_plazma; 
_plazma_plazma:
	.BYTE 0x2
;    2212 
;    2213 //enum {fpavON=0x55,fpavOFF=0xAA} fp_av_st=fpavOFF;
;    2214 
;    2215 enum {aspOFF=0xaa,aspON=0x55}av_sens_p_stat=aspOFF;  
_av_sens_p_stat:
	.BYTE 0x1
;    2216 signed char av_sens_p_hndl_cnt;
_av_sens_p_hndl_cnt:
	.BYTE 0x1
;    2217 signed pid_poz;
_pid_poz:
	.BYTE 0x2
;    2218 signed av_fp_cnt;                                                      
_av_fp_cnt:
	.BYTE 0x2
;    2219 enum {afsON=0x55,afsOFF=0xAA}av_fp_stat=afsOFF;
_av_fp_stat:
	.BYTE 0x1
;    2220 enum {faOFF=0xaa,faON=0x55} fp_apv[6]={faOFF,faOFF,faOFF,faOFF,faOFF,faOFF};    
_fp_apv:
	.BYTE 0x6
;    2221 char temp_fp; 
_temp_fp:
	.BYTE 0x1
;    2222 signed p_ust_pl,p_ust_mi;
_p_ust_pl:
	.BYTE 0x2
_p_ust_mi:
	.BYTE 0x2
;    2223 char day_period;     
_day_period:
	.BYTE 0x1
;    2224 signed zl_cnt;
_zl_cnt:
	.BYTE 0x2
;    2225 
;    2226 char adc_cnt_main;
_adc_cnt_main:
	.BYTE 0x1
;    2227 signed self_min;
_self_min:
	.BYTE 0x2
;    2228 signed self_max;
_self_max:
	.BYTE 0x2
;    2229 char self_cnt;
_self_cnt:
	.BYTE 0x1
;    2230 signed curr_ch_buff[4,16];
_curr_ch_buff:
	.BYTE 0x80
;    2231 char adc_cnt_main1[4]; 
_adc_cnt_main1:
	.BYTE 0x4
;    2232 char adc_ch_cnt;
_adc_ch_cnt:
	.BYTE 0x1
;    2233 signed curr_ch_buff_[4];
_curr_ch_buff_:
	.BYTE 0x8
;    2234 char temp_m8[15];
_temp_m8:
	.BYTE 0xF
;    2235 bit bCAN_EX;
;    2236 char reset_fp_cnt;
_reset_fp_cnt:
	.BYTE 0x1
;    2237 unsigned off_fp_cnt; 
_off_fp_cnt:
	.BYTE 0x2
;    2238 eeprom char CH1N;  

	.ESEG
_CH1N:
	.DB  0x0
;    2239 
;    2240 bit bSTR_IN, bSTR_IN_OLD, bSTR;
;    2241 char m8_rx_cnt;

	.DSEG
_m8_rx_cnt:
	.BYTE 0x1
;    2242 char m8_rx_buffer[40];
_m8_rx_buffer:
	.BYTE 0x28
;    2243 char cnt_power_down; 
_cnt_power_down:
	.BYTE 0x1
;    2244 char m8_main_cnt;
_m8_main_cnt:
	.BYTE 0x1
;    2245 //-----------------------------------------------
;    2246 char crc_87(char* ptr,char num)
;    2247 {

	.CSEG
_crc_87:
;    2248 char r,j,lb;
;    2249 r=*ptr;
	SBIW R28,3
;	*ptr -> Y+4
;	num -> Y+3
;	r -> Y+2
;	j -> Y+1
;	lb -> Y+0
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X
	STD  Y+2,R30
;    2250 
;    2251 for(j=1;j<num;j++)
	LDI  R30,LOW(1)
	STD  Y+1,R30
_0x9E:
	LDD  R30,Y+3
	LDD  R26,Y+1
	CP   R26,R30
	BRSH _0x9F
;    2252 	{
;    2253      ptr++;
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ADIW R30,1
	STD  Y+4,R30
	STD  Y+4+1,R31
;    2254 	r=((*ptr)^Table87[r]);
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	LD   R30,X
	PUSH R30
	LDI  R26,LOW(_Table87*2)
	LDI  R27,HIGH(_Table87*2)
	LDD  R30,Y+2
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	POP  R26
	EOR  R30,R26
	STD  Y+2,R30
;    2255 	}
	CALL SUBOPT_0x40
	RJMP _0x9E
_0x9F:
;    2256 
;    2257 return r;	
	LDD  R30,Y+2
	ADIW R28,6
	RET
;    2258 } 
;    2259 
;    2260 //-----------------------------------------------
;    2261 char crc_95(char* ptr,char num)
;    2262 {
;    2263 char r,j,lb;
;    2264 r=*ptr;
;	*ptr -> Y+4
;	num -> Y+3
;	r -> Y+2
;	j -> Y+1
;	lb -> Y+0
;    2265 
;    2266 for(j=1;j<num;j++)
;    2267 	{
;    2268      ptr++;
;    2269 	r=((*ptr)^Table95[r]);
;    2270 	}
;    2271 
;    2272 return r;	
;    2273 }
;    2274 
;    2275 
;    2276 //-----------------------------------------------
;    2277 void power_start (void)
;    2278 {
_power_start:
;    2279 power=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _power,R30
	STS  _power+1,R31
;    2280 power_cnt=0;
	LDI  R30,0
	STS  _power_cnt,R30
	STS  _power_cnt+1,R30
;    2281 cnt_control_blok1=0;
	LDI  R30,0
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R30
;    2282 }
	RET
;    2283 
;    2284 //-----------------------------------------------
;    2285 void pid_start(void)
;    2286 {             
_pid_start:
;    2287 pid_cnt=0;
	CALL SUBOPT_0x42
;    2288 e[0]=0;
;    2289 e[1]=0;
	__PUTW1MN _e,2
;    2290 e[2]=0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _e,4
;    2291 
;    2292 u=fp_poz;
	LDS  R30,_fp_poz
	LDS  R31,_fp_poz+1
	CALL __CWD1
	STS  _u,R30
	STS  _u+1,R31
	STS  _u+2,R22
	STS  _u+3,R23
;    2293 }
	RET
;    2294  
;    2295 //
;    2296 #define AVAR_FP	0x00                 
;    2297 //
;    2298 #define AVAR_P_SENS	0x01
;    2299 //
;    2300 #define AVAR_UNET	0x04
;    2301 //
;    2302 #define AVAR_CHER	0x06
;    2303 //
;    2304 #define AVAR_HEAT	0x07
;    2305 //
;    2306 #define AVAR_COOL	0x08
;    2307 //
;    2308 #define AVAR_HH 	0x0A
;    2309 //
;    2310 #define AVAR_P_MIN 	0x0B
;    2311 //
;    2312 #define AVAR_P_MAX 	0x0C
;    2313 //
;    2314 #define AVAR_START	0x0e
;    2315 
;    2316 
;    2317 //
;    2318 #define AVAR_I_MIN	9
;    2319 //
;    2320 #define AVAR_I_MAX	2
;    2321 //
;    2322 #define AVAR_I_LOG	5
;    2323 
;    2324 
;    2325 
;    2326 
;    2327 
;    2328 //-----------------------------------------------
;    2329 void av_hndl(char in,signed in0,signed in1)
;    2330 {
_av_hndl:
;    2331 //granee(&ptr_last_av,0,19); 
;    2332 
;    2333 ptr_last_av++;
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    2334 if(ptr_last_av>=20)ptr_last_av=0; 
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x14)
	LDI  R26,HIGH(0x14)
	CPC  R31,R26
	BRLT _0xA3
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMWRW
;    2335 
;    2336 av_hour[ptr_last_av]=read_ds14287(HOURS)&0x1f;
_0xA3:
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_av_hour)
	SBCI R31,HIGH(-_av_hour)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x43
	ANDI R30,LOW(0x1F)
	POP  R26
	POP  R27
	CALL __EEPROMWRB
;    2337 av_min[ptr_last_av]=read_ds14287(MINUTES);
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_av_min)
	SBCI R31,HIGH(-_av_min)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x44
	POP  R26
	POP  R27
	CALL __EEPROMWRB
;    2338 av_sec[ptr_last_av]=read_ds14287(SECONDS);
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_av_sec)
	SBCI R31,HIGH(-_av_sec)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x45
	POP  R26
	POP  R27
	CALL __EEPROMWRB
;    2339 av_day[ptr_last_av]=read_ds14287(DAY_OF_THE_MONTH);
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_av_day)
	SBCI R31,HIGH(-_av_day)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x46
	POP  R26
	POP  R27
	CALL __EEPROMWRB
;    2340 av_month[ptr_last_av]=read_ds14287(MONTH);
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_av_month)
	SBCI R31,HIGH(-_av_month)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x47
	POP  R26
	POP  R27
	CALL __EEPROMWRB
;    2341 av_year[ptr_last_av]=read_ds14287(YEAR);
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_av_year)
	SBCI R31,HIGH(-_av_year)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x48
	POP  R26
	POP  R27
	CALL __EEPROMWRB
;    2342 av_code[ptr_last_av]=in;
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	LDI  R26,LOW(_av_code)
	LDI  R27,HIGH(_av_code)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+4
	LDI  R31,0
	CALL __EEPROMWRW
;    2343 av_data0[ptr_last_av]=in0;
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	LDI  R26,LOW(_av_data0)
	LDI  R27,HIGH(_av_data0)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL __EEPROMWRW
;    2344 av_data1[ptr_last_av]=in1;
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	LDI  R26,LOW(_av_data1)
	LDI  R27,HIGH(_av_data1)
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,Y
	LDD  R31,Y+1
	CALL __EEPROMWRW
;    2345 
;    2346 
;    2347 }
_0xB45:
	ADIW R28,5
	RET
;    2348  
;    2349 
;    2350 //-----------------------------------------------
;    2351 void zl_hndl(void)
;    2352 {
_zl_hndl:
;    2353 
;    2354 if((p_ust<=p)&&(mode==mREG)&&(num_wrks_new==0)&&(fp_poz<1000))
	LDS  R30,_p
	LDS  R31,_p+1
	CP   R30,R8
	CPC  R31,R9
	BRLT _0xA5
	LDS  R26,_mode
	CPI  R26,LOW(0x22)
	BRNE _0xA5
	LDS  R26,_num_wrks_new
	CPI  R26,LOW(0x0)
	BRNE _0xA5
	LDS  R26,_fp_poz
	LDS  R27,_fp_poz+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRLT _0xA6
_0xA5:
	RJMP _0xA4
_0xA6:
;    2355 	{
;    2356 	if(zl_cnt<ZL_TIME)
	CALL SUBOPT_0x49
	BRGE _0xA7
;    2357 		{
;    2358 		zl_cnt++;
	LDS  R30,_zl_cnt
	LDS  R31,_zl_cnt+1
	ADIW R30,1
	STS  _zl_cnt,R30
	STS  _zl_cnt+1,R31
;    2359 		if(zl_cnt>=ZL_TIME) 
	CALL SUBOPT_0x49
	BRLT _0xA8
;    2360 			{
;    2361 			mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    2362 			}
;    2363 		}
_0xA8:
;    2364 	}
_0xA7:
;    2365 else zl_cnt=0;
	RJMP _0xA9
_0xA4:
	LDI  R30,0
	STS  _zl_cnt,R30
	STS  _zl_cnt+1,R30
_0xA9:
;    2366 }
	RET
;    2367 
;    2368 //-----------------------------------------------
;    2369 void av_sens_p_hndl(void)
;    2370 {
_av_sens_p_hndl:
;    2371 signed long temp_SL;
;    2372 
;    2373 temp_SL=(signed long)adc_bank_[3];
	SBIW R28,4
;	temp_SL -> Y+0
	__GETW1MN _adc_bank_,6
	CALL SUBOPT_0x4A
;    2374 temp_SL*=500L;
	__GETD1N 0x1F4
	CALL SUBOPT_0x4B
;    2375 temp_SL/=1024;
	__GETD1N 0x400
	CALL __DIVD21
	__PUTD1S 0
;    2376 
;    2377 if((temp_SL<35)||(temp_SL>250))
	__GETD2S 0
	__CPD2N 0x23
	BRLT _0xAB
	__GETD1N 0xFA
	CALL __CPD12
	BRGE _0xAA
_0xAB:
;    2378 	{
;    2379 	if(av_sens_p_hndl_cnt<25)
	LDS  R26,_av_sens_p_hndl_cnt
	CPI  R26,LOW(0x19)
	BRGE _0xAD
;    2380 		{
;    2381 		av_sens_p_hndl_cnt++;
	LDS  R30,_av_sens_p_hndl_cnt
	SUBI R30,-LOW(1)
	STS  _av_sens_p_hndl_cnt,R30
;    2382 		if((av_sens_p_hndl_cnt>=25)&&(av_sens_p_stat!=aspON))
	LDS  R26,_av_sens_p_hndl_cnt
	CPI  R26,LOW(0x19)
	BRLT _0xAF
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0x55)
	BRNE _0xB0
_0xAF:
	RJMP _0xAE
_0xB0:
;    2383 			{
;    2384 			av_sens_p_stat=aspON;
	LDI  R30,LOW(85)
	STS  _av_sens_p_stat,R30
;    2385 			av_hndl(AVAR_P_SENS,temp_SL,0);
	LDI  R30,LOW(1)
	ST   -Y,R30
	__GETD1S 1
	CALL SUBOPT_0x4C
	CALL _av_hndl
;    2386 			}
;    2387 		}
_0xAE:
;    2388 	else if(av_sens_p_hndl_cnt>25)av_sens_p_hndl_cnt=20;	
	RJMP _0xB1
_0xAD:
	CALL SUBOPT_0x4D
	BRGE _0xB2
	LDI  R30,LOW(20)
	STS  _av_sens_p_hndl_cnt,R30
;    2389 	}
_0xB2:
_0xB1:
;    2390 
;    2391 else if((temp_SL>35)&&(temp_SL<250))
	RJMP _0xB3
_0xAA:
	__GETD2S 0
	__GETD1N 0x23
	CALL __CPD12
	BRGE _0xB5
	__CPD2N 0xFA
	BRLT _0xB6
_0xB5:
	RJMP _0xB4
_0xB6:
;    2392 	{
;    2393 	if(av_sens_p_hndl_cnt>0)
	CALL SUBOPT_0x4E
	BRGE _0xB7
;    2394 		{
;    2395 		av_sens_p_hndl_cnt--;
	LDS  R30,_av_sens_p_hndl_cnt
	SUBI R30,LOW(1)
	STS  _av_sens_p_hndl_cnt,R30
;    2396 		if((av_sens_p_hndl_cnt<=0)&&(av_sens_p_stat!=aspOFF))
	CALL SUBOPT_0x4E
	BRLT _0xB9
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0xAA)
	BRNE _0xBA
_0xB9:
	RJMP _0xB8
_0xBA:
;    2397 			{
;    2398 			av_sens_p_stat=aspOFF;
	LDI  R30,LOW(170)
	STS  _av_sens_p_stat,R30
;    2399 			}
;    2400 		}
_0xB8:
;    2401 	else if(av_sens_p_hndl_cnt>25)av_sens_p_hndl_cnt=20;	
	RJMP _0xBB
_0xB7:
	CALL SUBOPT_0x4D
	BRGE _0xBC
	LDI  R30,LOW(20)
	STS  _av_sens_p_hndl_cnt,R30
;    2402 	}
_0xBC:
_0xBB:
;    2403 
;    2404 }
_0xB4:
_0xB3:
_0xB44:
	ADIW R28,4
	RET
;    2405 
;    2406 //-----------------------------------------------
;    2407 void mode_hndl (void)
;    2408 { 
_mode_hndl:
;    2409 
;    2410 if(EE_MODE==emAVT)
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ PC+3
	JMP _0xBD
;    2411 	{
;    2412 	
;    2413 	if(mode==mSTOP)
	LDS  R30,_mode
	CPI  R30,0
	BRNE _0xBE
;    2414 		{
;    2415 		if((rel_in_st[0]==rON)&&(comm_av_st!=cast_ON2)&&(!off_fp_cnt)&&(!reset_fp_cnt)&&(!bDVCH)&&((p_ust>p)  ))
	LDS  R26,_rel_in_st
	CPI  R26,LOW(0x55)
	BRNE _0xC0
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0x69)
	BREQ _0xC0
	LDS  R30,_off_fp_cnt
	LDS  R31,_off_fp_cnt+1
	SBIW R30,0
	BRNE _0xC0
	LDS  R30,_reset_fp_cnt
	CPI  R30,0
	BRNE _0xC0
	SBRC R4,4
	RJMP _0xC0
	LDS  R30,_p
	LDS  R31,_p+1
	CP   R30,R8
	CPC  R31,R9
	BRLT _0xC1
_0xC0:
	RJMP _0xBF
_0xC1:
;    2416    			{ 
;    2417    			if(av_fp_stat!=afsON)
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BREQ _0xC2
;    2418    				{
;    2419    				if((p_ust-p)>(SS_LEVEL*10)) 
	CALL SUBOPT_0x4F
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x50
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xC3
;    2420    					{
;    2421    					mode=mSTART;
	LDI  R30,LOW(17)
	STS  _mode,R30
;    2422   					power_start();
	RJMP _0xB4A
;    2423   					}
;    2424   				else 
_0xC3:
;    2425   					{
;    2426   					mode=mREG;
	CALL SUBOPT_0x51
;    2427   					pid_start();
;    2428   					power_start();
_0xB4A:
	CALL _power_start
;    2429   					
;    2430   					}
;    2431   				}
;    2432   			else 
	RJMP _0xC5
_0xC2:
;    2433   				{
;    2434   				mode=mFPAV;
	LDI  R30,LOW(153)
	STS  _mode,R30
;    2435   				}	 
_0xC5:
;    2436   			
;    2437   			}
;    2438   		} 
_0xBF:
;    2439 	
;    2440 	else if(mode==mSTART)
	RJMP _0xC6
_0xBE:
	LDS  R26,_mode
	CPI  R26,LOW(0x11)
	BRNE _0xC7
;    2441    		{
;    2442   		if((rel_in_st[0]==rOFF)||(comm_av_st==cast_ON2))
	LDS  R26,_rel_in_st
	CPI  R26,LOW(0xAA)
	BREQ _0xC9
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0x69)
	BRNE _0xC8
_0xC9:
;    2443   			{
;    2444   			mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    2445   			}
;    2446   		}
_0xC8:
;    2447 	
;    2448 	else if(mode==mREG)
	RJMP _0xCB
_0xC7:
	LDS  R26,_mode
	CPI  R26,LOW(0x22)
	BRNE _0xCC
;    2449    		{
;    2450     		if((rel_in_st[0]==rOFF)||(comm_av_st==cast_ON2))
	LDS  R26,_rel_in_st
	CPI  R26,LOW(0xAA)
	BREQ _0xCE
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0x69)
	BRNE _0xCD
_0xCE:
;    2451     			{
;    2452     			mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    2453     			}
;    2454     		} 
_0xCD:
;    2455     		
;    2456 	else if(mode==mFPAV)
	RJMP _0xD0
_0xCC:
	LDS  R26,_mode
	CPI  R26,LOW(0x99)
	BRNE _0xD1
;    2457    		{
;    2458   		if((rel_in_st[0]==rOFF)||(comm_av_st==cast_ON2))
	LDS  R26,_rel_in_st
	CPI  R26,LOW(0xAA)
	BREQ _0xD3
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0x69)
	BRNE _0xD2
_0xD3:
;    2459   			{
;    2460   			mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    2461   			}
;    2462   		}
_0xD2:
;    2463   		    		
;    2464 	else if(mode==mTORM)
	RJMP _0xD5
_0xD1:
	LDS  R26,_mode
	CPI  R26,LOW(0x88)
	BRNE _0xD6
;    2465    		{             
;    2466    		if((!bPOTENZ_DOWN)&&(fp_stat==dvOFF))
	SBRC R4,3
	RJMP _0xD8
	LDS  R26,_fp_stat
	CPI  R26,LOW(0x81)
	BREQ _0xD9
_0xD8:
	RJMP _0xD7
_0xD9:
;    2467    			{
;    2468    			mode=mSTOP;
	LDI  R30,LOW(0)
	STS  _mode,R30
;    2469    			}
;    2470    		}    		
_0xD7:
;    2471     	}
_0xD6:
_0xD5:
_0xD0:
_0xCB:
_0xC6:
;    2472 }
_0xBD:
	RET
;    2473 
;    2474 //-----------------------------------------------
;    2475 void power_hndl (void)
;    2476 {
_power_hndl:
;    2477 if(EE_MODE==emAVT)
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ PC+3
	JMP _0xDA
;    2478 	{
;    2479 	if(mode==mSTOP)
	LDS  R30,_mode
	CPI  R30,0
	BRNE _0xDB
;    2480 		{
;    2481 		power=0;
	LDI  R30,0
	STS  _power,R30
	STS  _power+1,R30
;    2482 		}
;    2483 	else if(mode==mSTART)
	RJMP _0xDC
_0xDB:
	LDS  R26,_mode
	CPI  R26,LOW(0x11)
	BREQ PC+3
	JMP _0xDD
;    2484 		{
;    2485 		if((cnt_control_blok1)&&(p>=p_ust)) cnt_control_blok1=0;
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BREQ _0xDF
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R26,R8
	CPC  R27,R9
	BRGE _0xE0
_0xDF:
	RJMP _0xDE
_0xE0:
	LDI  R30,0
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R30
;    2486 		
;    2487 		if(cnt_control_blok1)
_0xDE:
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BREQ _0xE1
;    2488 			{
;    2489 			cnt_control_blok1--;
	CALL SUBOPT_0x52
;    2490 			if(cnt_control_blok1==0)
	BRNE _0xE2
;    2491 				{
;    2492 				if(bPOTENZ_UP)power=(((power/100)+1)*100)+1;
	SBRS R4,2
	RJMP _0xE3
	CALL SUBOPT_0x53
	ADIW R30,1
	LDI  R26,LOW(100)
	LDI  R27,HIGH(100)
	CALL __MULW12
	ADIW R30,1
	STS  _power,R30
	STS  _power+1,R31
;    2493 				else                                               
	RJMP _0xE4
_0xE3:
;    2494 					{
;    2495 					mode=mREG; 
	LDI  R30,LOW(34)
	STS  _mode,R30
;    2496 					cnt_control_blok=50;
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    2497     					pid_start();
	CALL _pid_start
;    2498 					}
_0xE4:
;    2499 				}
;    2500 			}
_0xE2:
;    2501 
;    2502 		
;    2503 		
;    2504 		if(++power_cnt>=(10*SS_TIME))
_0xE1:
	LDS  R30,_power_cnt
	LDS  R31,_power_cnt+1
	ADIW R30,1
	STS  _power_cnt,R30
	STS  _power_cnt+1,R31
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_SS_TIME)
	LDI  R27,HIGH(_SS_TIME)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRGE PC+3
	JMP _0xE5
;    2505 			{
;    2506 			power_cnt=0;
	LDI  R30,0
	STS  _power_cnt,R30
	STS  _power_cnt+1,R30
;    2507 		
;    2508 			if((p_ust>p) && ((p_ust-p)>(SS_LEVEL*10)))
	LDS  R30,_p
	LDS  R31,_p+1
	CP   R30,R8
	CPC  R31,R9
	BRGE _0xE7
	CALL SUBOPT_0x4F
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x50
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BRLT _0xE8
_0xE7:
	RJMP _0xE6
_0xE8:
;    2509 				{
;    2510 				if((p<=p_old) || ((p-p_old)<SS_STEP))
	LDS  R30,_p_old
	LDS  R31,_p_old+1
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0xEA
	LDS  R26,_p_old
	LDS  R27,_p_old+1
	LDS  R30,_p
	LDS  R31,_p+1
	SUB  R30,R26
	SBC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_SS_STEP)
	LDI  R27,HIGH(_SS_STEP)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRGE _0xE9
_0xEA:
;    2511 					{
;    2512 					if((power%100)<fp_step_num)power++;
	CALL SUBOPT_0x54
	MOVW R26,R30
	LDS  R30,_fp_step_num
	LDS  R31,_fp_step_num+1
	CP   R26,R30
	CPC  R27,R31
	BRGE _0xEC
	LDS  R30,_power
	LDS  R31,_power+1
	ADIW R30,1
	STS  _power,R30
	STS  _power+1,R31
;    2513 					else 
	RJMP _0xED
_0xEC:
;    2514 						{
;    2515 						if(!cnt_control_blok1)
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BRNE _0xEE
;    2516 							{
;    2517 							cnt_control_blok1=DVCH_T_UP*10;
	CALL SUBOPT_0x55
;    2518 							}                             
;    2519 						}
_0xEE:
_0xED:
;    2520 					} 
;    2521 				}
_0xE9:
;    2522 			else 
	RJMP _0xEF
_0xE6:
;    2523 				{
;    2524     				mode=mREG;
	CALL SUBOPT_0x51
;    2525     				pid_start();
;    2526     				cnt_control_blok=50;
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    2527     				cnt_control_blok1=0;
	LDI  R30,0
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R30
;    2528 	 			}	
_0xEF:
;    2529 	  		p_old=p;
	LDS  R30,_p
	LDS  R31,_p+1
	STS  _p_old,R30
	STS  _p_old+1,R31
;    2530 	   		}
;    2531 		
;    2532    		}
_0xE5:
;    2533 
;    2534 	else if(mode==mREG)
	RJMP _0xF0
_0xDD:
	LDS  R26,_mode
	CPI  R26,LOW(0x22)
	BREQ PC+3
	JMP _0xF1
;    2535     		{
;    2536     		if(cnt_control_blok1)
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BREQ _0xF2
;    2537     			{
;    2538     			if((u>=0x4000)&&(p>=p_ust))
	LDS  R26,_u
	LDS  R27,_u+1
	LDS  R24,_u+2
	LDS  R25,_u+3
	__CPD2N 0x4000
	BRLT _0xF4
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R26,R8
	CPC  R27,R9
	BRGE _0xF5
_0xF4:
	RJMP _0xF3
_0xF5:
;    2539     				{
;    2540     				cnt_control_blok1=0;
	LDI  R30,0
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R30
;    2541     				//pid_start();
;    2542     				}
;    2543     			if((u<=0)&&(p<=p_ust))
_0xF3:
	LDS  R26,_u
	LDS  R27,_u+1
	LDS  R24,_u+2
	LDS  R25,_u+3
	CALL __CPD02
	BRLT _0xF7
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R8,R26
	CPC  R9,R27
	BRGE _0xF8
_0xF7:
	RJMP _0xF6
_0xF8:
;    2544   				{
;    2545     				cnt_control_blok1=0;
	LDI  R30,0
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R30
;    2546     			     //pid_start();
;    2547     				}
;    2548     			}
_0xF6:
;    2549     		
;    2550    		if(bPOWER==1)
_0xF2:
	LDS  R26,_bPOWER
	LDS  R27,_bPOWER+1
	CPI  R26,LOW(0x1)
	LDI  R30,HIGH(0x1)
	CPC  R27,R30
	BRNE _0xF9
;    2551    			{   
;    2552    					bPOWER=0;
	LDI  R30,0
	STS  _bPOWER,R30
	STS  _bPOWER+1,R30
;    2553    			                power+=100;
	LDS  R30,_power
	LDS  R31,_power+1
	SUBI R30,LOW(-100)
	SBCI R31,HIGH(-100)
	STS  _power,R30
	STS  _power+1,R31
;    2554    			
;    2555    			} 
;    2556    		else if(bPOWER==-1)
	RJMP _0xFA
_0xF9:
	LDS  R26,_bPOWER
	LDS  R27,_bPOWER+1
	CPI  R26,LOW(0xFFFF)
	LDI  R30,HIGH(0xFFFF)
	CPC  R27,R30
	BRNE _0xFB
;    2557    			{ 
;    2558    					bPOWER=0;
	LDI  R30,0
	STS  _bPOWER,R30
	STS  _bPOWER+1,R30
;    2559    					cnt_power_down=40;
	LDI  R30,LOW(40)
	STS  _cnt_power_down,R30
;    2560    			                
;    2561    			}
;    2562    			
;    2563    		if(cnt_power_down)
_0xFB:
_0xFA:
	LDS  R30,_cnt_power_down
	CPI  R30,0
	BREQ _0xFC
;    2564    			{
;    2565    			cnt_power_down--;
	SUBI R30,LOW(1)
	STS  _cnt_power_down,R30
;    2566    			if(!cnt_power_down)power-=100;
	CPI  R30,0
	BRNE _0xFD
	LDS  R30,_power
	LDS  R31,_power+1
	SUBI R30,LOW(100)
	SBCI R31,HIGH(100)
	STS  _power,R30
	STS  _power+1,R31
;    2567    			}			
_0xFD:
;    2568    		}
_0xFC:
;    2569 
;    2570     	else if(mode==mTORM)
	RJMP _0xFE
_0xF1:
	LDS  R26,_mode
	CPI  R26,LOW(0x88)
	BRNE _0xFF
;    2571 		{
;    2572 		power=0;
	LDI  R30,0
	STS  _power,R30
	STS  _power+1,R30
;    2573 		}
;    2574 	
;    2575     	gran(&power,0,1000);
_0xFF:
_0xFE:
_0xF0:
_0xDC:
	LDI  R30,LOW(_power)
	LDI  R31,HIGH(_power)
	CALL SUBOPT_0x4C
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	ST   -Y,R31
	ST   -Y,R30
	CALL _gran
;    2576     	}	
;    2577      
;    2578 else if(EE_MODE==emMNL)
	RJMP _0x100
_0xDA:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x101
;    2579 	{
;    2580 	}
;    2581 }
_0x101:
_0x100:
	RET
;    2582 
;    2583 //-----------------------------------------------
;    2584 void fp_hndl (void)
;    2585 { 
_fp_hndl:
;    2586 if(off_fp_cnt)  
	LDS  R30,_off_fp_cnt
	LDS  R31,_off_fp_cnt+1
	SBIW R30,0
	BREQ _0x102
;    2587 	{
;    2588 	off_fp_cnt--;
	SBIW R30,1
	STS  _off_fp_cnt,R30
	STS  _off_fp_cnt+1,R31
;    2589 	if(!off_fp_cnt)reset_fp_cnt=23;
	SBIW R30,0
	BRNE _0x103
	LDI  R30,LOW(23)
	STS  _reset_fp_cnt,R30
;    2590      }
_0x103:
;    2591 if(main_cnt<10)
_0x102:
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRSH _0x104
;    2592 	{
;    2593 	fp_stat=dvOFF;
	LDI  R30,LOW(129)
	STS  _fp_stat,R30
;    2594 	}
;    2595 else if(EE_MODE==emMNL)
	RJMP _0x105
_0x104:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x106
;    2596 	{
;    2597 	
;    2598 	if(!power)
	LDS  R30,_power
	LDS  R31,_power+1
	SBIW R30,0
	BRNE _0x107
;    2599 		{
;    2600 		fp_stat=dvOFF;
	CALL SUBOPT_0x56
;    2601 		fp_poz=0;
;    2602 		}        
;    2603 	else 
	RJMP _0x108
_0x107:
;    2604 		{
;    2605 		if(!(power%100))
	CALL SUBOPT_0x54
	SBIW R30,0
	BRNE _0x109
;    2606 			{
;    2607 			fp_stat=dvOFF;
	LDI  R30,LOW(129)
	RJMP _0xB4B
;    2608 			}             
;    2609 		else fp_stat=dvON;	
_0x109:
	LDI  R30,LOW(170)
_0xB4B:
	STS  _fp_stat,R30
;    2610 		
;    2611 		fp_poz=(0x4000/100)*(power%100);
	CALL SUBOPT_0x54
	LDI  R26,LOW(163)
	LDI  R27,HIGH(163)
	CALL __MULW12
	STS  _fp_poz,R30
	STS  _fp_poz+1,R31
;    2612 		}	
_0x108:
;    2613 	
;    2614 	}
;    2615 else if(EE_MODE==emAVT)
	RJMP _0x10B
_0x106:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ PC+3
	JMP _0x10C
;    2616 	{
;    2617 	if(mode==mSTOP)
	LDS  R30,_mode
	CPI  R30,0
	BRNE _0x10D
;    2618 		{
;    2619 		fp_stat=dvOFF;
	CALL SUBOPT_0x56
;    2620 		fp_poz=0;
;    2621 		}
;    2622 	else if(mode==mSTART)
	RJMP _0x10E
_0x10D:
	LDS  R26,_mode
	CPI  R26,LOW(0x11)
	BREQ PC+3
	JMP _0x10F
;    2623 		{
;    2624 		fp_stat=dvON;
	LDI  R30,LOW(170)
	STS  _fp_stat,R30
;    2625 		fp_poz=(unsigned)((0x4000UL*(unsigned long)(((power%100)-1)*SS_FRIQ))/(FP_FMAX-FP_FMIN));
	CALL SUBOPT_0x54
	SBIW R30,1
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_SS_FRIQ)
	LDI  R27,HIGH(_SS_FRIQ)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL __MULW12
	CLR  R22
	CLR  R23
	__GETD2N 0x4000
	CALL __MULD12U
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CWD1
	CALL __DIVD21
	STS  _fp_poz,R30
	STS  _fp_poz+1,R31
;    2626 		
;    2627 		pid_poz=fp_poz;
	STS  _pid_poz,R30
	STS  _pid_poz+1,R31
;    2628 		} 
;    2629 
;    2630 	else if(mode==mREG)
	RJMP _0x110
_0x10F:
	LDS  R26,_mode
	CPI  R26,LOW(0x22)
	BRNE _0x111
;    2631 		{
;    2632 		fp_stat=dvON;
	LDI  R30,LOW(170)
	STS  _fp_stat,R30
;    2633 		fp_poz=pid_poz;
	LDS  R30,_pid_poz
	LDS  R31,_pid_poz+1
	STS  _fp_poz,R30
	STS  _fp_poz+1,R31
;    2634 		}
;    2635 
;    2636 	else if(mode==mTORM)
	RJMP _0x112
_0x111:
	LDS  R26,_mode
	CPI  R26,LOW(0x88)
	BRNE _0x113
;    2637 		{
;    2638 		if((bPOTENZ_DOWN)||(cnt_control_blok))fp_stat=dvON;
	SBRC R4,3
	RJMP _0x115
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x114
_0x115:
	LDI  R30,LOW(170)
	STS  _fp_stat,R30
;    2639 		else 
	RJMP _0x117
_0x114:
;    2640 			{
;    2641 			fp_stat=dvOFF;
	CALL SUBOPT_0x56
;    2642 			fp_poz=0;
;    2643 			}
_0x117:
;    2644 		}
;    2645 		
;    2646 	if((av_sens_p_stat==aspON)&&(EE_MODE==emAVT)&&(mode!=mSTOP)&&(mode!=mTORM))	
_0x113:
_0x112:
_0x110:
_0x10E:
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0x55)
	BRNE _0x119
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x119
	LDS  R26,_mode
	CPI  R26,LOW(0x0)
	BREQ _0x119
	CPI  R26,LOW(0x88)
	BRNE _0x11A
_0x119:
	RJMP _0x118
_0x11A:
;    2647 		{                
;    2648 		signed long temp_SL;
;    2649 		temp_SL=0x4000L*(signed long)FP_CH;
	SBIW R28,4
;	temp_SL -> Y+0
	LDI  R26,LOW(_FP_CH)
	LDI  R27,HIGH(_FP_CH)
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2N 0x4000
	CALL SUBOPT_0x4B
;    2650 		temp_SL/=100L;
	CALL SUBOPT_0x57
;    2651 		fp_poz=(signed)temp_SL;
	STS  _fp_poz,R30
	STS  _fp_poz+1,R31
;    2652 		gran(&fp_poz,0,16384);
	LDI  R30,LOW(_fp_poz)
	LDI  R31,HIGH(_fp_poz)
	CALL SUBOPT_0x4C
	LDI  R30,LOW(16384)
	LDI  R31,HIGH(16384)
	ST   -Y,R31
	ST   -Y,R30
	CALL _gran
;    2653 		
;    2654 		if(fp_poz)fp_stat=dvON;
	LDS  R30,_fp_poz
	LDS  R31,_fp_poz+1
	SBIW R30,0
	BREQ _0x11B
	LDI  R30,LOW(170)
	RJMP _0xB4C
;    2655 		else fp_stat=dvOFF;
_0x11B:
	LDI  R30,LOW(129)
_0xB4C:
	STS  _fp_stat,R30
;    2656 		} 
	ADIW R28,4
;    2657 		
;    2658 	if(av_fp_stat==afsON)fp_stat=dvOFF;			
_0x118:
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x11D
	LDI  R30,LOW(129)
	STS  _fp_stat,R30
;    2659 	}	
_0x11D:
;    2660 }
_0x10C:
_0x10B:
_0x105:
	RET
;    2661 
;    2662 //-----------------------------------------------
;    2663 void p_kr_drv(void)
;    2664 {
_p_kr_drv:
;    2665 if(/*cnt_control_blok&&*/((p>(p_ust+(DVCH_P_KR*10)))||(p<(p_ust-(DVCH_P_KR*10))))&&((mode=mREG)||(mode==mTORM)))
	CALL SUBOPT_0x58
	ADD  R30,R8
	ADC  R31,R9
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x11F
	CALL SUBOPT_0x58
	MOVW R26,R30
	__GETW1R 8,9
	SUB  R30,R26
	SBC  R31,R27
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x121
_0x11F:
	LDI  R30,LOW(34)
	STS  _mode,R30
	CPI  R30,0
	BRNE _0x122
	LDS  R26,_mode
	CPI  R26,LOW(0x88)
	BRNE _0x121
_0x122:
	RJMP _0x124
_0x121:
	RJMP _0x11E
_0x124:
;    2666 	{
;    2667 	if(cnt_control_blok)cnt_control_blok=1;
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x125
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    2668 	if(cnt_control_blok1)cnt_control_blok1=1;
_0x125:
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BREQ _0x126
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R31
;    2669 	}
_0x126:
;    2670 }
_0x11E:
	RET
;    2671 
;    2672 //-----------------------------------------------
;    2673 void av_hh_drv(void)
;    2674 {
_av_hh_drv:
;    2675 if(1)
;    2676 	{
;    2677 	if(rel_in_st[3]==rOFF)
	__GETB1MN _rel_in_st,3
	CPI  R30,LOW(0xAA)
	BRNE _0x128
;    2678 		{
;    2679 		if(hh_av_cnt<(HH_TIME*10))
	CALL SUBOPT_0x59
	BRGE _0x129
;    2680 			{
;    2681 			hh_av_cnt++;
	LDS  R30,_hh_av_cnt
	LDS  R31,_hh_av_cnt+1
	ADIW R30,1
	STS  _hh_av_cnt,R30
	STS  _hh_av_cnt+1,R31
;    2682 			if(hh_av_cnt>=(HH_TIME*10))
	CALL SUBOPT_0x59
	BRLT _0x12A
;    2683 				{
;    2684 				hh_av=avON;
	LDI  R30,LOW(85)
	STS  _hh_av,R30
;    2685 				av_hndl(AVAR_HH,0,0);
	LDI  R30,LOW(10)
	CALL SUBOPT_0x5A
	CALL _av_hndl
;    2686 				}
;    2687 			}               
_0x12A:
;    2688 		else hh_av_cnt=HH_TIME*10;	
	RJMP _0x12B
_0x129:
	LDI  R26,LOW(_HH_TIME)
	LDI  R27,HIGH(_HH_TIME)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	STS  _hh_av_cnt,R30
	STS  _hh_av_cnt+1,R31
_0x12B:
;    2689 		}                         
;    2690 	else if(rel_in_st[3]==rON)
	RJMP _0x12C
_0x128:
	__GETB1MN _rel_in_st,3
	CPI  R30,LOW(0x55)
	BRNE _0x12D
;    2691 		{
;    2692 		if(hh_av_cnt>0)
	LDS  R26,_hh_av_cnt
	LDS  R27,_hh_av_cnt+1
	CALL __CPW02
	BRGE _0x12E
;    2693 			{
;    2694 			hh_av_cnt--;
	LDS  R30,_hh_av_cnt
	LDS  R31,_hh_av_cnt+1
	SBIW R30,1
	STS  _hh_av_cnt,R30
	STS  _hh_av_cnt+1,R31
;    2695 			if(hh_av_cnt==0)
	SBIW R30,0
	BRNE _0x12F
;    2696 				{
;    2697 				hh_av=avOFF;
	LDI  R30,LOW(170)
	STS  _hh_av,R30
;    2698 				}
;    2699 			}               
_0x12F:
;    2700 		else hh_av_cnt=0;	
	RJMP _0x130
_0x12E:
	LDI  R30,0
	STS  _hh_av_cnt,R30
	STS  _hh_av_cnt+1,R30
_0x130:
;    2701 		}     	
;    2702 	}
_0x12D:
_0x12C:
;    2703 	
;    2704 }
	RET
;    2705 
;    2706 
;    2707 //-----------------------------------------------
;    2708 void av_fp_hndl(void)
;    2709 { 
_av_fp_hndl:
;    2710 
;    2711 if((dv_on[pilot_dv]==dvFR)&&(!off_fp_cnt))
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CALL SUBOPT_0x5B
	BRNE _0x132
	LDS  R30,_off_fp_cnt
	LDS  R31,_off_fp_cnt+1
	SBIW R30,0
	BREQ _0x133
_0x132:
	RJMP _0x131
_0x133:
;    2712 	{
;    2713 if(rel_in_st[1]==rOFF)
	__GETB1MN _rel_in_st,1
	CPI  R30,LOW(0xAA)
	BREQ PC+3
	JMP _0x134
;    2714 	{
;    2715 	if(av_fp_cnt<10)
	LDS  R26,_av_fp_cnt
	LDS  R27,_av_fp_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRLT PC+3
	JMP _0x135
;    2716 		{
;    2717 		av_fp_cnt++;
	LDS  R30,_av_fp_cnt
	LDS  R31,_av_fp_cnt+1
	ADIW R30,1
	STS  _av_fp_cnt,R30
	STS  _av_fp_cnt+1,R31
;    2718 		if(av_fp_cnt>=10)
	LDS  R26,_av_fp_cnt
	LDS  R27,_av_fp_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRGE PC+3
	JMP _0x136
;    2719 			{                        
;    2720 			char i;
;    2721 			fp_apv[pilot_dv]=faON;
	SBIW R28,1
;	i -> Y+0
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_fp_apv)
	SBCI R31,HIGH(-_fp_apv)
	MOVW R26,R30
	LDI  R30,LOW(85)
	ST   X,R30
;    2722 			
;    2723 			temp_fp=0;
	LDI  R30,LOW(0)
	STS  _temp_fp,R30
;    2724 			for(i=0;i<EE_DV_NUM;i++)
	ST   Y,R30
_0x138:
	MOVW R26,R28
	LD   R30,X
	PUSH R30
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	POP  R26
	CP   R26,R30
	BRSH _0x139
;    2725 				{
;    2726 				if(fp_apv[i]==faON)temp_fp++;
	LD   R30,Y
	LDI  R31,0
	SUBI R30,LOW(-_fp_apv)
	SBCI R31,HIGH(-_fp_apv)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	BRNE _0x13A
	LDS  R30,_temp_fp
	SUBI R30,-LOW(1)
	STS  _temp_fp,R30
;    2727 				}                            
_0x13A:
	CALL SUBOPT_0x18
	RJMP _0x138
_0x139:
;    2728 			
;    2729 			if(temp_fp<2)
	LDS  R26,_temp_fp
	CPI  R26,LOW(0x2)
	BRSH _0x13B
;    2730 				{
;    2731 				reset_fp_cnt=11;
	LDI  R30,LOW(11)
	STS  _reset_fp_cnt,R30
;    2732 				bDVCH=1;
	SET
	BLD  R4,4
;    2733 				mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    2734 				off_fp_cnt=FP_RESET_TIME*10;
	LDI  R26,LOW(_FP_RESET_TIME)
	LDI  R27,HIGH(_FP_RESET_TIME)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	STS  _off_fp_cnt,R30
	STS  _off_fp_cnt+1,R31
;    2735 				av_fp_cnt=0;
	RJMP _0xB4D
;    2736 				}	      
;    2737 			else 
_0x13B:
;    2738 				{
;    2739 				av_fp_stat=afsON; 
	LDI  R30,LOW(85)
	STS  _av_fp_stat,R30
;    2740 				av_hndl(AVAR_FP,*((signed*)&fp_error_code),*(((signed*)&fp_error_code))+1);
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,_fp_error_code
	LDS  R31,_fp_error_code+1
	ST   -Y,R31
	ST   -Y,R30
	ADIW R30,1
	ST   -Y,R31
	ST   -Y,R30
	CALL _av_hndl
;    2741 				mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    2742 				av_fp_cnt=0;
_0xB4D:
	LDI  R30,0
	STS  _av_fp_cnt,R30
	STS  _av_fp_cnt+1,R30
;    2743 				}	
;    2744 			} 
	ADIW R28,1
;    2745 		}	              
_0x136:
;    2746 	else av_fp_cnt=10;	
	RJMP _0x13D
_0x135:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	STS  _av_fp_cnt,R30
	STS  _av_fp_cnt+1,R31
_0x13D:
;    2747 	}                         
;    2748 else /*if(rel_in_st[1]==rON)*/
	RJMP _0x13E
_0x134:
;    2749 	{
;    2750 	av_fp_cnt=0;	
	LDI  R30,0
	STS  _av_fp_cnt,R30
	STS  _av_fp_cnt+1,R30
;    2751 	} 
_0x13E:
;    2752 	}
;    2753 	
;    2754 }
_0x131:
	RET
;    2755 //-----------------------------------------------
;    2756 void pid_drv(void)
;    2757 {
_pid_drv:
;    2758 signed long temp_SL;
;    2759 if(!((EE_MODE==emAVT) && (mode==mREG) /*&& (!cnt_control_blok1)*/)) goto pid_drv_end;
	SBIW R28,4
;	temp_SL -> Y+0
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x140
	LDS  R26,_mode
	CPI  R26,LOW(0x22)
	BREQ _0x13F
_0x140:
	RJMP _0x142
;    2760             
;    2761 if(++pid_cnt<PID_PERIOD)goto pid_drv_end;
_0x13F:
	LDS  R30,_pid_cnt
	LDS  R31,_pid_cnt+1
	ADIW R30,1
	STS  _pid_cnt,R30
	STS  _pid_cnt+1,R31
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_PID_PERIOD)
	LDI  R27,HIGH(_PID_PERIOD)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x143
	RJMP _0x142
;    2762 
;    2763 if(cnt_control_blok)goto pid_drv_end;
_0x143:
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x144
	RJMP _0x142
;    2764 
;    2765 pid_cnt=0;
_0x144:
	LDI  R30,0
	STS  _pid_cnt,R30
	STS  _pid_cnt+1,R30
;    2766 if(!cnt_control_blok1)
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BREQ PC+3
	JMP _0x145
;    2767 {
;    2768 e[2]=e[1];
	__GETW1MN _e,2
	__PUTW1MN _e,4
;    2769 e[1]=e[0];
	LDS  R30,_e
	LDS  R31,_e+1
	__PUTW1MN _e,2
;    2770 e[0]=p_ust-p;
	CALL SUBOPT_0x4F
	STS  _e,R30
	STS  _e+1,R31
;    2771 if(e[0]>50)e[0]=50;
	LDS  R26,_e
	LDS  R27,_e+1
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x146
	STS  _e,R30
	STS  _e+1,R31
;    2772 
;    2773 temp_SL=0;
_0x146:
	__CLRD1S 0
;    2774 temp_SL=(((signed long)e[0])*((signed long)a0));
	LDS  R30,_e
	LDS  R31,_e+1
	CALL __CWD1
	__GETD2N 0xF5
	CALL __MULD12
	__PUTD1S 0
;    2775 temp_SL+=(((signed long)e[1])*((signed long)a1)*((signed long)PID_K_P)/10L);
	__GETW1MN _e,2
	CALL __CWD1
	__GETD2N 0xFFFFFEA2
	CALL __MULD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_PID_K_P)
	LDI  R27,HIGH(_PID_K_P)
	CALL __EEPROMRDW
	CALL __CWD1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x5C
;    2776 temp_SL+=(((signed long)e[2])*((signed long)a2)*((signed long)PID_K_D)/10L);
	__GETW1MN _e,4
	CALL __CWD1
	__GETD2N 0x7D
	CALL __MULD12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_PID_K_D)
	LDI  R27,HIGH(_PID_K_D)
	CALL __EEPROMRDW
	CALL __CWD1
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x5C
;    2777 temp_SL*=((signed long)PID_K);
	LDI  R26,LOW(_PID_K)
	LDI  R27,HIGH(_PID_K)
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2S 0
	CALL SUBOPT_0x4B
;    2778 temp_SL/=5L;
	__GETD1N 0x5
	CALL __DIVD21
	__PUTD1S 0
;    2779 
;    2780 u+=temp_SL;
	LDS  R26,_u
	LDS  R27,_u+1
	LDS  R24,_u+2
	LDS  R25,_u+3
	CALL __ADDD12
	STS  _u,R30
	STS  _u+1,R31
	STS  _u+2,R22
	STS  _u+3,R23
;    2781 }
;    2782   
;    2783 pid_drv_end:
_0x145:
_0x142:
;    2784 
;    2785 if(u>=0x4000)
	LDS  R26,_u
	LDS  R27,_u+1
	LDS  R24,_u+2
	LDS  R25,_u+3
	__CPD2N 0x4000
	BRGE PC+3
	JMP _0x147
;    2786 	{
;    2787 	if(bPOTENZ_UP)
	SBRS R4,2
	RJMP _0x148
;    2788 		{  
;    2789 		if(!cnt_control_blok1) cnt_control_blok1=DVCH_T_UP*10;
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BRNE _0x149
	CALL SUBOPT_0x55
;    2790    		else
	RJMP _0x14A
_0x149:
;    2791    			{
;    2792    			cnt_control_blok1--; 
	CALL SUBOPT_0x52
;    2793    			if(!cnt_control_blok1) 
	BRNE _0x14B
;    2794    				{     
;    2795    				bPOWER=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _bPOWER,R30
	STS  _bPOWER+1,R31
;    2796 		//u-=0x4000;
;    2797 		u=0x2000;
	__GETD1N 0x2000
	STS  _u,R30
	STS  _u+1,R31
	STS  _u+2,R22
	STS  _u+3,R23
;    2798 		pid_cnt=0;
	CALL SUBOPT_0x42
;    2799 		e[0]=0;
;    2800 		e[1]=0;
	__PUTW1MN _e,2
;    2801 		e[2]=0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _e,4
;    2802 			}
;    2803 			}
_0x14B:
_0x14A:
;    2804 		}
;    2805 	else 
	RJMP _0x14C
_0x148:
;    2806 		{
;    2807 		bPOWER=0;
	LDI  R30,0
	STS  _bPOWER,R30
	STS  _bPOWER+1,R30
;    2808 		u=0x4000;
	__GETD1N 0x4000
	STS  _u,R30
	STS  _u+1,R31
	STS  _u+2,R22
	STS  _u+3,R23
;    2809 		}	
_0x14C:
;    2810 	} 
;    2811 	        
;    2812 else if(u<0)
	RJMP _0x14D
_0x147:
	LDS  R26,_u
	LDS  R27,_u+1
	LDS  R24,_u+2
	LDS  R25,_u+3
	CALL __CPD20
	BRLT PC+3
	JMP _0x14E
;    2813 	{
;    2814  	if(bPOTENZ_DOWN)
	SBRS R4,3
	RJMP _0x14F
;    2815 		{       
;    2816 		
;    2817 		if(!cnt_control_blok1) cnt_control_blok1=DVCH_T_DOWN*10;
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,0
	BRNE _0x150
	LDI  R26,LOW(_DVCH_T_DOWN)
	LDI  R27,HIGH(_DVCH_T_DOWN)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R31
;    2818   		else
	RJMP _0x151
_0x150:
;    2819    				{
;    2820    				cnt_control_blok1--; 
	CALL SUBOPT_0x52
;    2821    				if(!cnt_control_blok1) 
	BRNE _0x152
;    2822    					{     
;    2823    					bPOWER=-1;
	LDI  R30,LOW(65535)
	LDI  R31,HIGH(65535)
	STS  _bPOWER,R30
	STS  _bPOWER+1,R31
;    2824    			                
;    2825 		u=(0x4000/100)*PID_K_FP_DOWN;
	LDI  R26,LOW(_PID_K_FP_DOWN)
	LDI  R27,HIGH(_PID_K_FP_DOWN)
	CALL __EEPROMRDW
	LDI  R26,LOW(163)
	LDI  R27,HIGH(163)
	CALL __MULW12
	CALL __CWD1
	STS  _u,R30
	STS  _u+1,R31
	STS  _u+2,R22
	STS  _u+3,R23
;    2826 		pid_cnt=0;
	CALL SUBOPT_0x42
;    2827 		e[0]=0;
;    2828 		e[1]=0;
	__PUTW1MN _e,2
;    2829 		e[2]=0;                 
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _e,4
;    2830 			}
;    2831 			}
_0x152:
_0x151:
;    2832 		}
;    2833 	else 
	RJMP _0x153
_0x14F:
;    2834 		{
;    2835 		bPOWER=0;
	LDI  R30,0
	STS  _bPOWER,R30
	STS  _bPOWER+1,R30
;    2836 		u=0;
	LDI  R30,0
	STS  _u,R30
	STS  _u+1,R30
	STS  _u+2,R30
	STS  _u+3,R30
;    2837 		}	
_0x153:
;    2838 	}	  
;    2839 else bPOWER=0;	
	RJMP _0x154
_0x14E:
	LDI  R30,0
	STS  _bPOWER,R30
	STS  _bPOWER+1,R30
_0x154:
_0x14D:
;    2840 
;    2841 pid_poz=(signed int)u;
	LDS  R30,_u
	LDS  R31,_u+1
	STS  _pid_poz,R30
	STS  _pid_poz+1,R31
;    2842 
;    2843 
;    2844 }
	RJMP _0xB43
;    2845 
;    2846 //-----------------------------------------------
;    2847 void time_sezon_drv (void)
;    2848 {
_time_sezon_drv:
;    2849 char temp;
;    2850 if((time_sezon!=tsWINTER)&&
	ST   -Y,R16
;	temp -> R16
;    2851 	( 
;    2852 	((_month<3)||(_month>10))
;    2853 	||((_month==3) && (((_week_day==1)&&((_hour<1)||(_day<25))) || ((_week_day==2)&&(_day<26))  || ((_week_day==3)&&(_day<27)) || ((_week_day==4)&&(_day<28)) || ((_week_day==5)&&(_day<29)) || ((_week_day==6)&&(_day<30)) || ((_week_day==7)&&(_day<31))))
;    2854 	||((_month==10) && (((_week_day==1)&&((_hour>=2)&&(_day>=25))) || ((_week_day==2)&&(_day>=26))  || ((_week_day==3)&&(_day>=27)) || ((_week_day==4)&&(_day>=28)) || ((_week_day==5)&&(_day>=29)) || ((_week_day==6)&&(_day>=30)) || ((_week_day==7)&&(_day>=31))))
;    2855      ))                     
	LDI  R26,LOW(_time_sezon)
	LDI  R27,HIGH(_time_sezon)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE PC+3
	JMP _0x156
	LDS  R26,__month
	CPI  R26,LOW(0x3)
	BRLO _0x157
	LDI  R30,LOW(10)
	CP   R30,R26
	BRSH _0x158
_0x157:
	RJMP _0x159
_0x158:
	LDS  R26,__month
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x15A
	LDS  R26,__week_day
	CPI  R26,LOW(0x1)
	BRNE _0x15B
	LDS  R26,__hour
	CPI  R26,LOW(0x1)
	BRLO _0x15C
	LDS  R26,__day
	CPI  R26,LOW(0x19)
	BRSH _0x15B
_0x15C:
	RJMP _0x15F
_0x15B:
	LDS  R26,__week_day
	CPI  R26,LOW(0x2)
	BRNE _0x160
	LDS  R26,__day
	CPI  R26,LOW(0x1A)
	BRLO _0x15F
_0x160:
	LDS  R26,__week_day
	CPI  R26,LOW(0x3)
	BRNE _0x162
	LDS  R26,__day
	CPI  R26,LOW(0x1B)
	BRLO _0x15F
_0x162:
	LDS  R26,__week_day
	CPI  R26,LOW(0x4)
	BRNE _0x164
	LDS  R26,__day
	CPI  R26,LOW(0x1C)
	BRLO _0x15F
_0x164:
	LDS  R26,__week_day
	CPI  R26,LOW(0x5)
	BRNE _0x166
	LDS  R26,__day
	CPI  R26,LOW(0x1D)
	BRLO _0x15F
_0x166:
	LDS  R26,__week_day
	CPI  R26,LOW(0x6)
	BRNE _0x168
	LDS  R26,__day
	CPI  R26,LOW(0x1E)
	BRLO _0x15F
_0x168:
	LDS  R26,__week_day
	CPI  R26,LOW(0x7)
	BRNE _0x16A
	LDS  R26,__day
	CPI  R26,LOW(0x1F)
	BRLO _0x15F
_0x16A:
	RJMP _0x15A
_0x15F:
	RJMP _0x159
_0x15A:
	LDS  R26,__month
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0x16E
	LDS  R26,__week_day
	CPI  R26,LOW(0x1)
	BRNE _0x16F
	LDS  R26,__hour
	CPI  R26,LOW(0x2)
	BRLO _0x170
	LDS  R26,__day
	CPI  R26,LOW(0x19)
	BRSH _0x171
_0x170:
	RJMP _0x16F
_0x171:
	RJMP _0x173
_0x16F:
	LDS  R26,__week_day
	CPI  R26,LOW(0x2)
	BRNE _0x174
	LDS  R26,__day
	CPI  R26,LOW(0x1A)
	BRSH _0x173
_0x174:
	LDS  R26,__week_day
	CPI  R26,LOW(0x3)
	BRNE _0x176
	LDS  R26,__day
	CPI  R26,LOW(0x1B)
	BRSH _0x173
_0x176:
	LDS  R26,__week_day
	CPI  R26,LOW(0x4)
	BRNE _0x178
	LDS  R26,__day
	CPI  R26,LOW(0x1C)
	BRSH _0x173
_0x178:
	LDS  R26,__week_day
	CPI  R26,LOW(0x5)
	BRNE _0x17A
	LDS  R26,__day
	CPI  R26,LOW(0x1D)
	BRSH _0x173
_0x17A:
	LDS  R26,__week_day
	CPI  R26,LOW(0x6)
	BRNE _0x17C
	LDS  R26,__day
	CPI  R26,LOW(0x1E)
	BRSH _0x173
_0x17C:
	LDS  R26,__week_day
	CPI  R26,LOW(0x7)
	BRNE _0x17E
	LDS  R26,__day
	CPI  R26,LOW(0x1F)
	BRSH _0x173
_0x17E:
	RJMP _0x16E
_0x173:
	RJMP _0x159
_0x16E:
	RJMP _0x156
_0x159:
	RJMP _0x183
_0x156:
	RJMP _0x155
_0x183:
;    2856 	{
;    2857 	time_sezon=tsWINTER;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_time_sezon)
	LDI  R27,HIGH(_time_sezon)
	CALL __EEPROMWRB
;    2858 	temp=read_ds14287(HOURS);
	CALL SUBOPT_0x43
	MOV  R16,R30
;    2859 	if(!temp)
	CPI  R16,0
	BRNE _0x184
;    2860 		{
;    2861 		temp=23;
	LDI  R16,LOW(23)
;    2862 		write_ds14287(HOURS,temp); 
	CALL SUBOPT_0x5D
;    2863 		
;    2864 		temp=read_ds14287(DAY_OF_THE_MONTH);
	CALL SUBOPT_0x46
	MOV  R16,R30
;    2865 		if(temp==1)
	CPI  R16,1
	BRNE _0x185
;    2866 			{
;    2867 			temp=DAY_MONTHS[_month-2];
	LDI  R30,LOW(_DAY_MONTHS*2)
	LDI  R31,HIGH(_DAY_MONTHS*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(2)
	POP  R26
	POP  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R16,Z
;    2868 			write_ds14287(DAY_OF_THE_MONTH,temp);
	CALL SUBOPT_0x5E
;    2869 			
;    2870 			temp=read_ds14287(MONTH);
	CALL SUBOPT_0x47
	MOV  R16,R30
;    2871 			if(temp==1)
	CPI  R16,1
	BRNE _0x186
;    2872 				{
;    2873 				temp=12;
	LDI  R16,LOW(12)
;    2874 				write_ds14287(MONTH,temp);
	CALL SUBOPT_0x5F
;    2875 				
;    2876 				temp=read_ds14287(YEAR);
	MOV  R16,R30
;    2877 					{
;    2878 					temp--;
	SUBI R16,1
;    2879 					write_ds14287(YEAR,temp);
	LDI  R30,LOW(9)
	RJMP _0xB4E
;    2880 				     }
;    2881 				}
;    2882 			else 
_0x186:
;    2883 				{
;    2884 				temp--;
	SUBI R16,1
;    2885 				write_ds14287(MONTH,temp);
	LDI  R30,LOW(8)
_0xB4E:
	ST   -Y,R30
	ST   -Y,R16
	CALL _write_ds14287
;    2886 				}
;    2887 			}
;    2888 		else
	RJMP _0x188
_0x185:
;    2889 			{
;    2890 			temp--;
	SUBI R16,1
;    2891 			write_ds14287(DAY_OF_THE_MONTH,temp);
	CALL SUBOPT_0x5E
;    2892 		     } 
_0x188:
;    2893 		temp=read_ds14287(DAY_OF_THE_WEEK);
	CALL SUBOPT_0x60
;    2894 		if(temp==1)
	CPI  R16,1
	BRNE _0x189
;    2895 			{
;    2896 			temp=7;
	LDI  R16,LOW(7)
;    2897 			write_ds14287(DAY_OF_THE_WEEK,temp);
	RJMP _0xB4F
;    2898 			}
;    2899 		else
_0x189:
;    2900 			{
;    2901 			temp--;
	SUBI R16,1
;    2902 			write_ds14287(DAY_OF_THE_WEEK,temp);
_0xB4F:
	LDI  R30,LOW(6)
	CALL SUBOPT_0x61
;    2903 		     }		     
;    2904 		} 
;    2905 	else 
	RJMP _0x18B
_0x184:
;    2906 		{
;    2907 		temp--;
	SUBI R16,1
;    2908 		write_ds14287(HOURS,temp);
	CALL SUBOPT_0x5D
;    2909 		}
_0x18B:
;    2910 	}  
;    2911 
;    2912 if((time_sezon!=tsSUMMER)&&
_0x155:
;    2913 	( 
;    2914 	((_month>3)&&(_month<10))
;    2915 	||((_month==10) && (((_week_day==1)&&((_hour<1)||(_day<25))) || ((_week_day==2)&&(_day<26))  || ((_week_day==3)&&(_day<27)) || ((_week_day==4)&&(_day<28)) || ((_week_day==5)&&(_day<29)) || ((_week_day==6)&&(_day<30)) || ((_week_day==7)&&(_day<31))))
;    2916 	||((_month==3) && (((_week_day==1)&&((_hour>=2)&&(_day>=25))) || ((_week_day==2)&&(_day>=26))  || ((_week_day==3)&&(_day>=27)) || ((_week_day==4)&&(_day>=28)) || ((_week_day==5)&&(_day>=29)) || ((_week_day==6)&&(_day>=30)) || ((_week_day==7)&&(_day>=31))))
;    2917      ))                     
	LDI  R26,LOW(_time_sezon)
	LDI  R27,HIGH(_time_sezon)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE PC+3
	JMP _0x18D
	LDS  R26,__month
	LDI  R30,LOW(3)
	CP   R30,R26
	BRSH _0x18E
	CPI  R26,LOW(0xA)
	BRSH _0x18E
	RJMP _0x190
_0x18E:
	LDS  R26,__month
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0x191
	LDS  R26,__week_day
	CPI  R26,LOW(0x1)
	BRNE _0x192
	LDS  R26,__hour
	CPI  R26,LOW(0x1)
	BRLO _0x193
	LDS  R26,__day
	CPI  R26,LOW(0x19)
	BRSH _0x192
_0x193:
	RJMP _0x196
_0x192:
	LDS  R26,__week_day
	CPI  R26,LOW(0x2)
	BRNE _0x197
	LDS  R26,__day
	CPI  R26,LOW(0x1A)
	BRLO _0x196
_0x197:
	LDS  R26,__week_day
	CPI  R26,LOW(0x3)
	BRNE _0x199
	LDS  R26,__day
	CPI  R26,LOW(0x1B)
	BRLO _0x196
_0x199:
	LDS  R26,__week_day
	CPI  R26,LOW(0x4)
	BRNE _0x19B
	LDS  R26,__day
	CPI  R26,LOW(0x1C)
	BRLO _0x196
_0x19B:
	LDS  R26,__week_day
	CPI  R26,LOW(0x5)
	BRNE _0x19D
	LDS  R26,__day
	CPI  R26,LOW(0x1D)
	BRLO _0x196
_0x19D:
	LDS  R26,__week_day
	CPI  R26,LOW(0x6)
	BRNE _0x19F
	LDS  R26,__day
	CPI  R26,LOW(0x1E)
	BRLO _0x196
_0x19F:
	LDS  R26,__week_day
	CPI  R26,LOW(0x7)
	BRNE _0x1A1
	LDS  R26,__day
	CPI  R26,LOW(0x1F)
	BRLO _0x196
_0x1A1:
	RJMP _0x191
_0x196:
	RJMP _0x190
_0x191:
	LDS  R26,__month
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x1A5
	LDS  R26,__week_day
	CPI  R26,LOW(0x1)
	BRNE _0x1A6
	LDS  R26,__hour
	CPI  R26,LOW(0x2)
	BRLO _0x1A7
	LDS  R26,__day
	CPI  R26,LOW(0x19)
	BRSH _0x1A8
_0x1A7:
	RJMP _0x1A6
_0x1A8:
	RJMP _0x1AA
_0x1A6:
	LDS  R26,__week_day
	CPI  R26,LOW(0x2)
	BRNE _0x1AB
	LDS  R26,__day
	CPI  R26,LOW(0x1A)
	BRSH _0x1AA
_0x1AB:
	LDS  R26,__week_day
	CPI  R26,LOW(0x3)
	BRNE _0x1AD
	LDS  R26,__day
	CPI  R26,LOW(0x1B)
	BRSH _0x1AA
_0x1AD:
	LDS  R26,__week_day
	CPI  R26,LOW(0x4)
	BRNE _0x1AF
	LDS  R26,__day
	CPI  R26,LOW(0x1C)
	BRSH _0x1AA
_0x1AF:
	LDS  R26,__week_day
	CPI  R26,LOW(0x5)
	BRNE _0x1B1
	LDS  R26,__day
	CPI  R26,LOW(0x1D)
	BRSH _0x1AA
_0x1B1:
	LDS  R26,__week_day
	CPI  R26,LOW(0x6)
	BRNE _0x1B3
	LDS  R26,__day
	CPI  R26,LOW(0x1E)
	BRSH _0x1AA
_0x1B3:
	LDS  R26,__week_day
	CPI  R26,LOW(0x7)
	BRNE _0x1B5
	LDS  R26,__day
	CPI  R26,LOW(0x1F)
	BRSH _0x1AA
_0x1B5:
	RJMP _0x1A5
_0x1AA:
	RJMP _0x190
_0x1A5:
	RJMP _0x18D
_0x190:
	RJMP _0x1BA
_0x18D:
	RJMP _0x18C
_0x1BA:
;    2918 	{
;    2919 	time_sezon=tsSUMMER;
	LDI  R30,LOW(170)
	LDI  R26,LOW(_time_sezon)
	LDI  R27,HIGH(_time_sezon)
	CALL __EEPROMWRB
;    2920 /*	temp=read_ds14287(HOURS);
;    2921 	if(temp==23)temp=0;
;    2922 	else temp++;
;    2923 	write_ds14287(HOURS,temp);*/
;    2924 	
;    2925 	temp=read_ds14287(HOURS);
	CALL SUBOPT_0x43
	MOV  R16,R30
;    2926 	if(temp==23)
	CPI  R16,23
	BRNE _0x1BB
;    2927 		{
;    2928 		temp=0;
	LDI  R16,LOW(0)
;    2929 		write_ds14287(HOURS,temp); 
	CALL SUBOPT_0x5D
;    2930 		
;    2931 		temp=read_ds14287(DAY_OF_THE_MONTH);
	CALL SUBOPT_0x46
	MOV  R16,R30
;    2932 		if(temp==DAY_MONTHS[_month-1])
	LDI  R30,LOW(_DAY_MONTHS*2)
	LDI  R31,HIGH(_DAY_MONTHS*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x62
	CP   R30,R16
	BRNE _0x1BC
;    2933 			{
;    2934 			temp=1;
	LDI  R16,LOW(1)
;    2935 			write_ds14287(DAY_OF_THE_MONTH,temp);
	CALL SUBOPT_0x5E
;    2936 			
;    2937 			temp=read_ds14287(MONTH);
	CALL SUBOPT_0x47
	MOV  R16,R30
;    2938 			if(temp==12)
	CPI  R16,12
	BRNE _0x1BD
;    2939 				{
;    2940 				temp=1;
	LDI  R16,LOW(1)
;    2941 				write_ds14287(MONTH,temp);
	CALL SUBOPT_0x5F
;    2942 				
;    2943 				temp=read_ds14287(YEAR);
	MOV  R16,R30
;    2944 					{
;    2945 					temp++;
	SUBI R16,-1
;    2946 					write_ds14287(YEAR,temp);
	LDI  R30,LOW(9)
	RJMP _0xB50
;    2947 				     }
;    2948 				}
;    2949 			else 
_0x1BD:
;    2950 				{
;    2951 				temp++;
	SUBI R16,-1
;    2952 				write_ds14287(MONTH,temp);
	LDI  R30,LOW(8)
_0xB50:
	ST   -Y,R30
	ST   -Y,R16
	CALL _write_ds14287
;    2953 				}
;    2954 			}
;    2955 		else
	RJMP _0x1BF
_0x1BC:
;    2956 			{
;    2957 			temp++;
	SUBI R16,-1
;    2958 			write_ds14287(DAY_OF_THE_MONTH,temp);
	CALL SUBOPT_0x5E
;    2959 		     } 
_0x1BF:
;    2960 		temp=read_ds14287(DAY_OF_THE_WEEK);
	CALL SUBOPT_0x60
;    2961 		if(temp==7)
	CPI  R16,7
	BRNE _0x1C0
;    2962 			{
;    2963 			temp=1;
	LDI  R16,LOW(1)
;    2964 			write_ds14287(DAY_OF_THE_WEEK,temp);
	RJMP _0xB51
;    2965 			}
;    2966 		else
_0x1C0:
;    2967 			{
;    2968 			temp++;
	SUBI R16,-1
;    2969 			write_ds14287(DAY_OF_THE_WEEK,temp);
_0xB51:
	LDI  R30,LOW(6)
	CALL SUBOPT_0x61
;    2970 		     }		     
;    2971 		} 
;    2972 	else 
	RJMP _0x1C2
_0x1BB:
;    2973 		{
;    2974 		temp++;
	SUBI R16,-1
;    2975 		write_ds14287(HOURS,temp);
	CALL SUBOPT_0x5D
;    2976 		}	
_0x1C2:
;    2977 	
;    2978 	}	
;    2979 }
_0x18C:
	LD   R16,Y+
	RET
;    2980 
;    2981 //-----------------------------------------------
;    2982 void modbus_request_hndl (void)
;    2983 { 
_modbus_request_hndl:
;    2984 unsigned reset_mask;
;    2985 if(read_parametr==204)
	ST   -Y,R17
	ST   -Y,R16
;	reset_mask -> R16,R17
	LDS  R26,_read_parametr
	LDS  R27,_read_parametr+1
	CPI  R26,LOW(0xCC)
	LDI  R30,HIGH(0xCC)
	CPC  R27,R30
	BRNE _0x1C3
;    2986 	{
;    2987 	read_vlt_register(204,2);
	CALL SUBOPT_0x63
;    2988 	read_parametr=0;
	LDI  R30,0
	STS  _read_parametr,R30
	STS  _read_parametr+1,R30
;    2989 	}
;    2990 else if(read_parametr==205)
	RJMP _0x1C4
_0x1C3:
	LDS  R26,_read_parametr
	LDS  R27,_read_parametr+1
	CPI  R26,LOW(0xCD)
	LDI  R30,HIGH(0xCD)
	CPC  R27,R30
	BRNE _0x1C5
;    2991 	{
;    2992 	read_vlt_register(205,2);
	LDI  R30,LOW(205)
	LDI  R31,HIGH(205)
	CALL SUBOPT_0x64
;    2993 	read_parametr=0;
	LDI  R30,0
	STS  _read_parametr,R30
	STS  _read_parametr+1,R30
;    2994 	}
;    2995 read_vlt_coil(33); 
_0x1C5:
_0x1C4:
	LDI  R30,LOW(33)
	LDI  R31,HIGH(33)
	ST   -Y,R31
	ST   -Y,R30
	CALL _read_vlt_coil
;    2996 read_vlt_register(518,1); 
	LDI  R30,LOW(518)
	LDI  R31,HIGH(518)
	CALL SUBOPT_0x65
	CALL _read_vlt_register
;    2997 read_vlt_register(520,2);
	LDI  R30,LOW(520)
	LDI  R31,HIGH(520)
	CALL SUBOPT_0x64
;    2998 read_vlt_register(538,2);
	LDI  R30,LOW(538)
	LDI  R31,HIGH(538)
	CALL SUBOPT_0x64
;    2999 if(reset_fp_cnt&0x01) reset_mask=0x0080;
	LDS  R30,_reset_fp_cnt
	ANDI R30,LOW(0x1)
	BREQ _0x1C6
	__GETWRN 16,17,128
;    3000 else reset_mask=0x0000;
	RJMP _0x1C7
_0x1C6:
	__GETWRN 16,17,0
_0x1C7:
;    3001 if(reset_fp_cnt)reset_fp_cnt--;
	LDS  R30,_reset_fp_cnt
	CPI  R30,0
	BREQ _0x1C8
	SUBI R30,LOW(1)
	STS  _reset_fp_cnt,R30
;    3002 
;    3003 if(fp_stat!=dvON) write_vlt_coil(1,0x043c|reset_mask,0);
_0x1C8:
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BREQ _0x1C9
	CALL SUBOPT_0x66
	ORI  R30,LOW(0x43C)
	ORI  R31,HIGH(0x43C)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0xB52
;    3004 else write_vlt_coil(1,0x047c|reset_mask,fp_poz);
_0x1C9:
	CALL SUBOPT_0x66
	ORI  R30,LOW(0x47C)
	ORI  R31,HIGH(0x47C)
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_fp_poz
	LDS  R31,_fp_poz+1
_0xB52:
	ST   -Y,R31
	ST   -Y,R30
	CALL _write_vlt_coil
;    3005 }
	LD   R16,Y+
	LD   R17,Y+
	RET
;    3006 
;    3007 //-----------------------------------------------
;    3008 void out_usart0 (char num,char data0,char data1,char data2,char data3,char data4,char data5,char data6,char data7,char data8)
;    3009 {
;    3010 char i,t=0;
;    3011 
;    3012 char UOB0[12]; 
;    3013 UOB0[0]=data0;
;	num -> Y+23
;	data0 -> Y+22
;	data1 -> Y+21
;	data2 -> Y+20
;	data3 -> Y+19
;	data4 -> Y+18
;	data5 -> Y+17
;	data6 -> Y+16
;	data7 -> Y+15
;	data8 -> Y+14
;	i -> R16
;	t -> R17
;	UOB0 -> Y+2
;    3014 UOB0[1]=data1;
;    3015 UOB0[2]=data2;
;    3016 UOB0[3]=data3;
;    3017 UOB0[4]=data4;
;    3018 UOB0[5]=data5;
;    3019 UOB0[6]=data6;
;    3020 UOB0[7]=data7;
;    3021 UOB0[8]=data8;
;    3022 
;    3023 for (i=0;i<num;i++)
;    3024 	{
;    3025 	putchar0(UOB0[i]);
;    3026 	}   	
;    3027 }
;    3028 
;    3029 //-----------------------------------------------
;    3030 void usart_out_adr0 (char *ptr, char len)
;    3031 {
;    3032 
;    3033 char UOB0[100];
;    3034 char i,t=0;
;    3035 
;    3036 /*for(i=0;i<len;i++)
;    3037 	{
;    3038 	UOB0[i]=ptr[i];
;    3039 	}*/
;    3040 
;    3041 for (i=0;i<len;i++)
;	*ptr -> Y+103
;	len -> Y+102
;	UOB0 -> Y+2
;	i -> Y+1
;	t -> Y+0
;    3042 	{
;    3043 	putchar0(ptr[i]);
;    3044 	}  
;    3045 //	out_usart0(2,MEM_KF1,(char)TZAS,0,0,0,0,0,0,0);
;    3046 }
;    3047 
;    3048 //-----------------------------------------------
;    3049 void p_ust_hndl (void)
;    3050 {
_p_ust_hndl:
;    3051 signed long temp_SL;
;    3052 if(P_UST_EE)
	SBIW R28,4
;	temp_SL -> Y+0
	LDI  R26,LOW(_P_UST_EE)
	LDI  R27,HIGH(_P_UST_EE)
	CALL __EEPROMRDW
	SBIW R30,0
	BREQ _0x1D2
;    3053 	{
;    3054 	p_ust=P_UST_EE;
	LDI  R26,LOW(_P_UST_EE)
	LDI  R27,HIGH(_P_UST_EE)
	CALL __EEPROMRDW
	__PUTW1R 8,9
;    3055 	mode_ust=0xff;
	LDI  R30,LOW(255)
	STS  _mode_ust,R30
;    3056 	}
;    3057 else if(P_UST_EE==0)
	RJMP _0x1D3
_0x1D2:
	LDI  R26,LOW(_P_UST_EE)
	LDI  R27,HIGH(_P_UST_EE)
	CALL __EEPROMRDW
	SBIW R30,0
	BREQ PC+3
	JMP _0x1D4
;    3058 	{
;    3059 	char ___day;
;    3060 	if(_week_day==1)___day=7;
	SBIW R28,1
;	temp_SL -> Y+1
;	___day -> Y+0
	LDS  R26,__week_day
	CPI  R26,LOW(0x1)
	BRNE _0x1D5
	LDI  R30,LOW(7)
	RJMP _0xB53
;    3061 	else ___day=_week_day-2; 
_0x1D5:
	LDS  R30,__week_day
	SUBI R30,LOW(2)
_0xB53:
	ST   Y,R30
;    3062 	day_period=0; 
	LDI  R30,LOW(0)
	STS  _day_period,R30
;    3063 	if((CURR_TIME>=timer_time1[___day,0])&&(CURR_TIME<timer_time2[___day,0]))day_period=0;
	CALL SUBOPT_0x67
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	CALL SUBOPT_0x68
	BRLO _0x1D8
	CALL SUBOPT_0x69
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	CALL SUBOPT_0x6A
	BRLO _0x1D9
_0x1D8:
	RJMP _0x1D7
_0x1D9:
	LDI  R30,LOW(0)
	STS  _day_period,R30
;    3064 	else if((CURR_TIME>=timer_time1[___day,1])&&(CURR_TIME<timer_time2[___day,1]))day_period=1;
	RJMP _0x1DA
_0x1D7:
	CALL SUBOPT_0x67
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x68
	BRLO _0x1DC
	CALL SUBOPT_0x69
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6B
	CALL SUBOPT_0x6A
	BRLO _0x1DD
_0x1DC:
	RJMP _0x1DB
_0x1DD:
	LDI  R30,LOW(1)
	STS  _day_period,R30
;    3065 	else if((CURR_TIME>=timer_time1[___day,2])&&(CURR_TIME<timer_time2[___day,2]))day_period=2;
	RJMP _0x1DE
_0x1DB:
	CALL SUBOPT_0x67
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x68
	BRLO _0x1E0
	CALL SUBOPT_0x69
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6C
	CALL SUBOPT_0x6A
	BRLO _0x1E1
_0x1E0:
	RJMP _0x1DF
_0x1E1:
	LDI  R30,LOW(2)
	STS  _day_period,R30
;    3066 	else if((CURR_TIME>=timer_time1[___day,3])&&(CURR_TIME<timer_time2[___day,3]))day_period=3;
	RJMP _0x1E2
_0x1DF:
	CALL SUBOPT_0x67
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x68
	BRLO _0x1E4
	CALL SUBOPT_0x69
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6D
	CALL SUBOPT_0x6A
	BRLO _0x1E5
_0x1E4:
	RJMP _0x1E3
_0x1E5:
	LDI  R30,LOW(3)
	STS  _day_period,R30
;    3067 	else if((CURR_TIME>=timer_time1[___day,4])&&(CURR_TIME<timer_time2[___day,4]))day_period=4; 
	RJMP _0x1E6
_0x1E3:
	CALL SUBOPT_0x67
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6E
	CALL SUBOPT_0x68
	BRLO _0x1E8
	CALL SUBOPT_0x69
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6E
	CALL SUBOPT_0x6A
	BRLO _0x1E9
_0x1E8:
	RJMP _0x1E7
_0x1E9:
	LDI  R30,LOW(4)
	STS  _day_period,R30
;    3068 	
;    3069 	if(timer_mode[___day,day_period]==1)p_ust=timer_data1[___day,day_period];
_0x1E7:
_0x1E6:
_0x1E2:
_0x1DE:
_0x1DA:
	LD   R30,Y
	LDI  R26,LOW(_timer_mode)
	LDI  R27,HIGH(_timer_mode)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6F
	CALL SUBOPT_0x70
	BRNE _0x1EA
	LD   R30,Y
	LDI  R26,LOW(_timer_data1)
	LDI  R27,HIGH(_timer_data1)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x6F
	CALL SUBOPT_0x71
	__PUTW1R 8,9
;    3070 	}
_0x1EA:
	ADIW R28,1
;    3071 
;    3072 temp_SL=(signed long)p_ust;
_0x1D4:
_0x1D3:
	CALL SUBOPT_0x72
;    3073 temp_SL*=(100L+(signed long)FP_P_PL);
	LDI  R26,LOW(_FP_P_PL)
	LDI  R27,HIGH(_FP_P_PL)
	CALL __EEPROMRDW
	CALL __CWD1
	__ADDD1N 100
	__GETD2S 0
	CALL SUBOPT_0x4B
;    3074 temp_SL/=100L;
	CALL SUBOPT_0x57
;    3075 p_ust_pl=(unsigned)temp_SL;
	STS  _p_ust_pl,R30
	STS  _p_ust_pl+1,R31
;    3076 
;    3077 temp_SL=(signed long)p_ust;
	CALL SUBOPT_0x72
;    3078 temp_SL*=(100L-(signed long)FP_P_MI);
	LDI  R26,LOW(_FP_P_MI)
	LDI  R27,HIGH(_FP_P_MI)
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2N 0x64
	CALL __SWAPD12
	CALL __SUBD12
	__GETD2S 0
	CALL SUBOPT_0x4B
;    3079 temp_SL/=100L;
	CALL SUBOPT_0x57
;    3080 p_ust_mi=(unsigned)temp_SL;
	STS  _p_ust_mi,R30
	STS  _p_ust_mi+1,R31
;    3081 }
_0xB43:
	ADIW R28,4
	RET
;    3082 
;    3083 //-----------------------------------------------
;    3084 char find(char xy)
;    3085 {
_find:
;    3086 char i=0;
;    3087 do i++;
	ST   -Y,R16
;	xy -> Y+1
;	i -> R16
	LDI  R16,0
_0x1EC:
	SUBI R16,-1
;    3088 while ((lcd_buffer[i]!=xy)&&(i<LCD_SIZE));
	CALL SUBOPT_0x73
	LD   R30,Z
	MOV  R26,R30
	LDD  R30,Y+1
	CP   R30,R26
	BREQ _0x1EE
	CPI  R16,40
	BRLO _0x1EF
_0x1EE:
	RJMP _0x1ED
_0x1EF:
	RJMP _0x1EC
_0x1ED:
;    3089 if(i>(33)) i=255;
	LDI  R30,LOW(33)
	CP   R30,R16
	BRSH _0x1F0
	LDI  R16,LOW(255)
;    3090 return i;
_0x1F0:
	MOV  R30,R16
	RJMP _0xB42
;    3091 }
;    3092 
;    3093 //-----------------------------------------------
;    3094 void sub_bgnd(char flash *adr,char xy)
;    3095 {
_sub_bgnd:
;    3096 char temp;
;    3097 temp=find(xy);
	ST   -Y,R16
;	*adr -> Y+2
;	xy -> Y+1
;	temp -> R16
	LDD  R30,Y+1
	CALL SUBOPT_0x74
;    3098 
;    3099 //ptr_ram=&lcd_buffer[find(xy)];
;    3100 if(temp!=255)
	CPI  R16,255
	BREQ _0x1F1
;    3101 while (*adr)
_0x1F2:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0x1F4
;    3102 	{
;    3103 	lcd_buffer[temp]=*adr++;
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ADIW R30,1
	STD  Y+2,R30
	STD  Y+2+1,R31
	SBIW R30,1
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    3104 	temp++;
	SUBI R16,-1
;    3105     	}
	RJMP _0x1F2
_0x1F4:
;    3106 }
_0x1F1:
	LDD  R16,Y+0
	ADIW R28,4
	RET
;    3107 
;    3108 //-----------------------------------------------
;    3109 void bin2bcd_int(unsigned int in)
;    3110 {
_bin2bcd_int:
;    3111 char i=5;
;    3112 for(i=0;i<5;i++)
	ST   -Y,R16
;	in -> Y+1
;	i -> R16
	LDI  R16,5
	LDI  R16,LOW(0)
_0x1F6:
	CPI  R16,5
	BRSH _0x1F7
;    3113 	{
;    3114 	dig[i]=in%10;
	CALL SUBOPT_0x75
	PUSH R31
	PUSH R30
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MODW21U
	POP  R26
	POP  R27
	ST   X,R30
;    3115 	in/=10;
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	STD  Y+1,R30
	STD  Y+1+1,R31
;    3116 	}   
	SUBI R16,-1
	RJMP _0x1F6
_0x1F7:
;    3117 }
	LDD  R16,Y+0
	ADIW R28,3
	RET
;    3118 
;    3119 //-----------------------------------------------
;    3120 void bcd2lcd_zero(char sig)
;    3121 {
_bcd2lcd_zero:
;    3122 char i;
;    3123 zero_on=1;
	ST   -Y,R16
;	sig -> Y+1
;	i -> R16
	SET
	BLD  R3,5
;    3124 for (i=5;i>0;i--)
	LDI  R16,LOW(5)
_0x1F9:
	LDI  R30,LOW(0)
	CP   R30,R16
	BRSH _0x1FA
;    3125 	{
;    3126 	if(zero_on&&(!dig[i-1])&&(i>sig))
	SBRS R3,5
	RJMP _0x1FC
	CALL SUBOPT_0x76
	LD   R30,Z
	CPI  R30,0
	BRNE _0x1FC
	LDD  R30,Y+1
	CP   R30,R16
	BRLO _0x1FD
_0x1FC:
	RJMP _0x1FB
_0x1FD:
;    3127 		{
;    3128 		dig[i-1]=0x20;
	CALL SUBOPT_0x76
	MOVW R26,R30
	LDI  R30,LOW(32)
	ST   X,R30
;    3129 		}
;    3130 	else
	RJMP _0x1FE
_0x1FB:
;    3131 		{
;    3132 		dig[i-1]=dig[i-1]+0x30;
	CALL SUBOPT_0x76
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x76
	LD   R30,Z
	SUBI R30,-LOW(48)
	POP  R26
	POP  R27
	ST   X,R30
;    3133 		zero_on=0;
	CLT
	BLD  R3,5
;    3134 		}	
_0x1FE:
;    3135 	}
	SUBI R16,1
	RJMP _0x1F9
_0x1FA:
;    3136 }    
_0xB42:
	LDD  R16,Y+0
	ADIW R28,2
	RET
;    3137 
;    3138 //-----------------------------------------------
;    3139 void int2lcd_mm(signed int in,char xy,char des)
;    3140 {
_int2lcd_mm:
;    3141 char i;
;    3142 char n;
;    3143 char minus='+';
;    3144 if(in<0)
	CALL __SAVELOCR3
;	in -> Y+5
;	xy -> Y+4
;	des -> Y+3
;	i -> R16
;	n -> R17
;	minus -> R18
	LDI  R18,43
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	SBIW R26,0
	BRGE _0x1FF
;    3145 	{
;    3146 	in=abs(in);
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _abs
	STD  Y+5,R30
	STD  Y+5+1,R31
;    3147 	minus='-';
	LDI  R18,LOW(45)
;    3148 	}
;    3149 bin2bcd_int(in);
_0x1FF:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _bin2bcd_int
;    3150 bcd2lcd_zero(des+1);
	LDD  R30,Y+3
	CALL SUBOPT_0x77
;    3151 i=find(xy);
	LDD  R30,Y+4
	CALL SUBOPT_0x74
;    3152 for (n=0;n<5;n++)
	LDI  R17,LOW(0)
_0x201:
	CPI  R17,5
	BRLO PC+3
	JMP _0x202
;    3153 	{
;    3154    	if(!des&&(dig[n]!=' '))
	LDD  R30,Y+3
	CPI  R30,0
	BRNE _0x204
	CALL SUBOPT_0x78
	CPI  R30,LOW(0x20)
	BRNE _0x205
_0x204:
	RJMP _0x203
_0x205:
;    3155    		{
;    3156    		if((dig[n+1]==' ')&&(minus=='-'))lcd_buffer[i-1]='-';
	CALL SUBOPT_0x79
	BRNE _0x207
	CPI  R18,45
	BREQ _0x208
_0x207:
	RJMP _0x206
_0x208:
	CALL SUBOPT_0x7A
	MOVW R26,R30
	LDI  R30,LOW(45)
	ST   X,R30
;    3157    		lcd_buffer[i]=dig[n];	 
_0x206:
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3158    		}
;    3159    	else 
	RJMP _0x209
_0x203:
;    3160    		{
;    3161    		if(n<des)lcd_buffer[i]=dig[n];
	LDD  R30,Y+3
	CP   R17,R30
	BRSH _0x20A
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3162    		else if (n==des)
	RJMP _0x20B
_0x20A:
	LDD  R30,Y+3
	CP   R30,R17
	BRNE _0x20C
;    3163    			{
;    3164    			lcd_buffer[i]='.';
	CALL SUBOPT_0x7B
	CALL SUBOPT_0x7C
;    3165    			lcd_buffer[i-1]=dig[n];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3166    			} 
;    3167    		else if ((n>des)&&(dig[n]!=' ')) lcd_buffer[i-1]=dig[n]; 
	RJMP _0x20D
_0x20C:
	LDD  R30,Y+3
	CP   R30,R17
	BRSH _0x20F
	CALL SUBOPT_0x78
	CPI  R30,LOW(0x20)
	BRNE _0x210
_0x20F:
	RJMP _0x20E
_0x210:
	CALL SUBOPT_0x7A
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3168    		else if ((minus=='-')&&(n>des)&&(dig[n]!=' ')&&(dig[n+1]==' ')) lcd_buffer[i]='-';  		
	RJMP _0x211
_0x20E:
	CPI  R18,45
	BRNE _0x213
	LDD  R30,Y+3
	CP   R30,R17
	BRSH _0x213
	CALL SUBOPT_0x78
	CPI  R30,LOW(0x20)
	BREQ _0x213
	CALL SUBOPT_0x79
	BREQ _0x214
_0x213:
	RJMP _0x212
_0x214:
	CALL SUBOPT_0x7B
	LDI  R30,LOW(45)
	ST   X,R30
;    3169    		}  
_0x212:
_0x211:
_0x20D:
_0x20B:
_0x209:
;    3170 		
;    3171 	i--;	
	SUBI R16,1
;    3172 	}
	SUBI R17,-1
	RJMP _0x201
_0x202:
;    3173 }
	RJMP _0xB40
;    3174 
;    3175 //-----------------------------------------------
;    3176 void int2lcdxy(unsigned int in,char xy,char des)
;    3177 {
_int2lcdxy:
;    3178 char i;
;    3179 char n;
;    3180 bin2bcd_int(in);
	CALL SUBOPT_0x7D
;	in -> Y+4
;	xy -> Y+3
;	des -> Y+2
;	i -> R16
;	n -> R17
;    3181 bcd2lcd_zero(des+1);
;    3182 i=((xy&0b00000011)*16)+((xy&0b11110000)>>4);
	LDD  R30,Y+3
	CALL SUBOPT_0x7E
	PUSH R30
	LDD  R30,Y+3
	ANDI R30,LOW(0xF0)
	SWAP R30
	ANDI R30,0xF
	POP  R26
	ADD  R30,R26
	MOV  R16,R30
;    3183 if ((xy&0b00000011)>=2) i++;
	LDD  R30,Y+3
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x2)
	BRLO _0x215
	SUBI R16,-1
;    3184 if ((xy&0b00000011)==3) i++;
_0x215:
	LDD  R30,Y+3
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x3)
	BRNE _0x216
	SUBI R16,-1
;    3185 for (n=0;n<5;n++)
_0x216:
	LDI  R17,LOW(0)
_0x218:
	CPI  R17,5
	BRSH _0x219
;    3186 	{ 
;    3187 	if(n<des)
	LDD  R30,Y+2
	CP   R17,R30
	BRSH _0x21A
;    3188 		{
;    3189 		lcd_buffer[i]=dig[n];
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3190 		}   
;    3191 	if((n>=des)&&(dig[n]!=0x20))
_0x21A:
	LDD  R30,Y+2
	CP   R17,R30
	BRLO _0x21C
	CALL SUBOPT_0x78
	CPI  R30,LOW(0x20)
	BRNE _0x21D
_0x21C:
	RJMP _0x21B
_0x21D:
;    3192 		{
;    3193 		if(!des)lcd_buffer[i]=dig[n];	
	LDD  R30,Y+2
	CPI  R30,0
	BRNE _0x21E
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	RJMP _0xB54
;    3194 		else lcd_buffer[i-1]=dig[n];
_0x21E:
	CALL SUBOPT_0x7A
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
_0xB54:
	ST   X,R30
;    3195    		}   
;    3196 	i--;	
_0x21B:
	SUBI R16,1
;    3197 	}
	SUBI R17,-1
	RJMP _0x218
_0x219:
;    3198 }
	RJMP _0xB41
;    3199 
;    3200 //-----------------------------------------------
;    3201 void int2lcd(unsigned int in,char xy,char des)
;    3202 {
_int2lcd:
;    3203 char i;
;    3204 char n;
;    3205 
;    3206 bin2bcd_int(in);
	CALL SUBOPT_0x7D
;	in -> Y+4
;	xy -> Y+3
;	des -> Y+2
;	i -> R16
;	n -> R17
;    3207 bcd2lcd_zero(des+1);
;    3208 i=find(xy);
	LDD  R30,Y+3
	CALL SUBOPT_0x74
;    3209 for (n=0;n<5;n++)
	LDI  R17,LOW(0)
_0x221:
	CPI  R17,5
	BRLO PC+3
	JMP _0x222
;    3210 	{
;    3211    	if(!des&&(dig[n]!=' '))
	LDD  R30,Y+2
	CPI  R30,0
	BRNE _0x224
	CALL SUBOPT_0x78
	CPI  R30,LOW(0x20)
	BRNE _0x225
_0x224:
	RJMP _0x223
_0x225:
;    3212    		{
;    3213    		lcd_buffer[i]=dig[n];	 
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3214    		}
;    3215    	else 
	RJMP _0x226
_0x223:
;    3216    		{
;    3217    		if(n<des)lcd_buffer[i]=dig[n];
	LDD  R30,Y+2
	CP   R17,R30
	BRSH _0x227
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3218    		else if (n==des)
	RJMP _0x228
_0x227:
	LDD  R30,Y+2
	CP   R30,R17
	BRNE _0x229
;    3219    			{
;    3220    			lcd_buffer[i]='.';
	CALL SUBOPT_0x7B
	CALL SUBOPT_0x7C
;    3221    			lcd_buffer[i-1]=dig[n];
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3222    			} 
;    3223    		else if ((n>des)&&(dig[n]!=' ')) lcd_buffer[i-1]=dig[n];   		
	RJMP _0x22A
_0x229:
	LDD  R30,Y+2
	CP   R30,R17
	BRSH _0x22C
	CALL SUBOPT_0x78
	CPI  R30,LOW(0x20)
	BRNE _0x22D
_0x22C:
	RJMP _0x22B
_0x22D:
	CALL SUBOPT_0x7A
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3224    		}  
_0x22B:
_0x22A:
_0x228:
_0x226:
;    3225 		
;    3226 	i--;	
	SUBI R16,1
;    3227 	}
	SUBI R17,-1
	RJMP _0x221
_0x222:
;    3228 }
_0xB41:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,6
	RET
;    3229 
;    3230 //-----------------------------------------------
;    3231 void char2lcdhxy(unsigned char in,char xy)
;    3232 {
_char2lcdhxy:
;    3233 char i;
;    3234 char n;
;    3235 for(i=0;i<2;i++)
	ST   -Y,R17
	ST   -Y,R16
;	in -> Y+3
;	xy -> Y+2
;	i -> R16
;	n -> R17
	LDI  R16,LOW(0)
_0x22F:
	CPI  R16,2
	BRSH _0x230
;    3236 	{
;    3237 	dig[i]=ABC[in%16];
	CALL SUBOPT_0x75
	PUSH R31
	PUSH R30
	LDI  R30,LOW(_ABC*2)
	LDI  R31,HIGH(_ABC*2)
	PUSH R31
	PUSH R30
	LDD  R30,Y+3
	ANDI R30,LOW(0xF)
	POP  R26
	POP  R27
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    3238 	in/=16;
	LDD  R30,Y+3
	SWAP R30
	ANDI R30,0xF
	STD  Y+3,R30
;    3239 	}   
	SUBI R16,-1
	RJMP _0x22F
_0x230:
;    3240 i=((xy&0b00000011)*16)+((xy&0b11110000)>>4);
	LDD  R30,Y+2
	CALL SUBOPT_0x7E
	PUSH R30
	LDD  R30,Y+2
	ANDI R30,LOW(0xF0)
	SWAP R30
	ANDI R30,0xF
	POP  R26
	ADD  R30,R26
	MOV  R16,R30
;    3241 if ((xy&0b00000011)>=2) i++;
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x2)
	BRLO _0x231
	SUBI R16,-1
;    3242 if ((xy&0b00000011)==3) i++;
_0x231:
	LDD  R30,Y+2
	ANDI R30,LOW(0x3)
	CPI  R30,LOW(0x3)
	BRNE _0x232
	SUBI R16,-1
;    3243 for (n=0;n<2;n++)
_0x232:
	LDI  R17,LOW(0)
_0x234:
	CPI  R17,2
	BRSH _0x235
;    3244 	{ 
;    3245 	lcd_buffer[i]=dig[n];
	CALL SUBOPT_0x73
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x78
	POP  R26
	POP  R27
	ST   X,R30
;    3246 	i--;	
	SUBI R16,1
;    3247 	}
	SUBI R17,-1
	RJMP _0x234
_0x235:
;    3248 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
;    3249 //-----------------------------------------------
;    3250 void bgnd_par(char flash *ptr0,char flash *ptr1)
;    3251 {
_bgnd_par:
;    3252 char i,*ptr_ram;
;    3253 for (i=0;i<LCD_SIZE;i++)
	CALL __SAVELOCR3
;	*ptr0 -> Y+5
;	*ptr1 -> Y+3
;	i -> R16
;	*ptr_ram -> R17,R18
	LDI  R16,LOW(0)
_0x237:
	CPI  R16,40
	BRSH _0x238
;    3254 	{
;    3255 	lcd_buffer[i]=0x20;
	CALL SUBOPT_0x7B
	LDI  R30,LOW(32)
	ST   X,R30
;    3256 	}
	SUBI R16,-1
	RJMP _0x237
_0x238:
;    3257 ptr_ram=lcd_buffer;
	__POINTWRM 17,18,_lcd_buffer
;    3258 while (*ptr0)
_0x239:
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0x23B
;    3259 	{
;    3260 	*ptr_ram++=*ptr0++;
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	ADIW R30,1
	STD  Y+5,R30
	STD  Y+5+1,R31
	SBIW R30,1
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    3261    	}
	RJMP _0x239
_0x23B:
;    3262 while (*ptr1)
_0x23C:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	LPM  R30,Z
	CPI  R30,0
	BREQ _0x23E
;    3263 	{
;    3264 	*ptr_ram++=*ptr1++;
	PUSH R18
	PUSH R17
	__ADDWRN 17,18,1
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ADIW R30,1
	STD  Y+3,R30
	STD  Y+3+1,R31
	SBIW R30,1
	LPM  R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    3265    	}
	RJMP _0x23C
_0x23E:
;    3266 } 
_0xB40:
	CALL __LOADLOCR3
	ADIW R28,7
	RET
;    3267 
;    3268 
;    3269 //-----------------------------------------------
;    3270 void ind_transmit_hndl(void)
;    3271 {
;    3272 static char tr_ind_delay,tr_ind_cnt;

	.DSEG
_tr_ind_delay_S45:
	.BYTE 0x1
_tr_ind_cnt_S45:
	.BYTE 0x1

	.CSEG
;    3273             
;    3274 if(tr_ind_delay)tr_ind_delay--;
;    3275 if(!tr_ind_delay)
;    3276 	{
;    3277 	tr_ind_delay=10;
;    3278 	tr_ind_cnt++;                 
;    3279 	if(tr_ind_cnt>=4)tr_ind_cnt=0;
;    3280 	//can_out_adr(0b11110000+tr_ind_cnt,0b00000000,&data_for_ind[10*tr_ind_cnt]);
;    3281 	can_out_adr(0b11110000,0b00000000,&data_for_ind[0]);
;    3282 	}
;    3283 
;    3284 }
;    3285 
;    3286 //-----------------------------------------
;    3287 void t0_init(void)
;    3288 {
_t0_init:
;    3289 TCCR0=0x04;
	LDI  R30,LOW(4)
	OUT  0x33,R30
;    3290 TCNT0=-125;
	LDI  R30,LOW(131)
	OUT  0x32,R30
;    3291 TIMSK|=0x01;
	IN   R30,0x37
	ORI  R30,1
	OUT  0x37,R30
;    3292 }                                                
	RET
;    3293 
;    3294 //-----------------------------------------------
;    3295 void set_kalibr_blok_drv(void)
;    3296 {
;    3297 DDRC.0=0;
;    3298 PORTC.0=1;
;    3299 #asm("nop")
	nop
;    3300 #asm("nop")
	nop
;    3301 #asm("nop")
	nop
;    3302 if(PINC.0==1)
;    3303 	{
;    3304 	if(skb_cnt<10)skb_cnt++;
;    3305 	}                       
;    3306 else
;    3307 	{
;    3308 	if(skb_cnt)skb_cnt--;
;    3309 	}
;    3310 		
;    3311 }
;    3312 
;    3313 
;    3314 //-----------------------------------------------
;    3315 void dv_pusk(char in)
;    3316 {
;    3317 //dv_on[in]=dvON;
;    3318 }
;    3319 
;    3320 //-----------------------------------------------
;    3321 void dv_stop(char in)
;    3322 {
;    3323 //dv_on[in]=dvOFF;
;    3324 }
;    3325 
;    3326 //-----------------------------------------------
;    3327 void control(void)
;    3328 {
_control:
;    3329 
;    3330 granee(&pilot_dv,0,EE_DV_NUM);
	LDI  R30,LOW(_pilot_dv)
	LDI  R31,HIGH(_pilot_dv)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    3331 if(cnt_control_blok)cnt_control_blok--;
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x246
	SBIW R30,1
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    3332 
;    3333 
;    3334 
;    3335 num_wrks_old=0;
_0x246:
	LDI  R30,LOW(0)
	STS  _num_wrks_old,R30
;    3336 if((dv_on[0]==dvSTAR)||(dv_on[0]==dvTRIAN)||(dv_on[0]==dvFULL)/*||((dv_on[0]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
	LDS  R26,_dv_on
	CPI  R26,LOW(0x42)
	BREQ _0x248
	CPI  R26,LOW(0x24)
	BREQ _0x248
	CPI  R26,LOW(0x99)
	BRNE _0x247
_0x248:
	CALL SUBOPT_0x80
;    3337 if((dv_on[1]==dvSTAR)||(dv_on[1]==dvTRIAN)||(dv_on[1]==dvFULL)/*||((dv_on[1]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
_0x247:
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x42)
	BREQ _0x24B
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x24)
	BREQ _0x24B
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x99)
	BRNE _0x24A
_0x24B:
	CALL SUBOPT_0x80
;    3338 if((dv_on[2]==dvSTAR)||(dv_on[2]==dvTRIAN)||(dv_on[2]==dvFULL)/*||((dv_on[2]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
_0x24A:
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x42)
	BREQ _0x24E
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x24)
	BREQ _0x24E
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x99)
	BRNE _0x24D
_0x24E:
	CALL SUBOPT_0x80
;    3339 if((dv_on[3]==dvSTAR)||(dv_on[3]==dvTRIAN)||(dv_on[3]==dvFULL)/*||((dv_on[3]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
_0x24D:
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x42)
	BREQ _0x251
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x24)
	BREQ _0x251
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x99)
	BRNE _0x250
_0x251:
	CALL SUBOPT_0x80
;    3340 if((dv_on[4]==dvSTAR)||(dv_on[4]==dvTRIAN)||(dv_on[4]==dvFULL)/*||((dv_on[4]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
_0x250:
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x42)
	BREQ _0x254
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x24)
	BREQ _0x254
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x99)
	BRNE _0x253
_0x254:
	CALL SUBOPT_0x80
;    3341 if((dv_on[5]==dvSTAR)||(dv_on[5]==dvTRIAN)||(dv_on[5]==dvFULL)/*||((dv_on[5]==dvFR)&&(fp_stat==dvON))*/)num_wrks_old++;
_0x253:
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x42)
	BREQ _0x257
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x24)
	BREQ _0x257
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x99)
	BRNE _0x256
_0x257:
	CALL SUBOPT_0x80
;    3342 
;    3343 
;    3344 if((av_serv[0]==avsON)||//(av_temper[0]!=avtOFF)||
_0x256:
;    3345 	(av_i_dv_min[0]!=aviOFF)||(av_i_dv_max[0]!=aviOFF)||(apv_cnt[0])||(av_i_dv_log[0]!=aviOFF))
	LDS  R26,_av_serv
	CPI  R26,LOW(0x55)
	BREQ _0x25A
	LDS  R26,_av_i_dv_min
	CPI  R26,LOW(0xAA)
	BRNE _0x25A
	LDS  R26,_av_i_dv_max
	CPI  R26,LOW(0xAA)
	BRNE _0x25A
	LDS  R30,_apv_cnt
	CPI  R30,0
	BRNE _0x25A
	LDS  R26,_av_i_dv_log
	CPI  R26,LOW(0xAA)
	BREQ _0x259
_0x25A:
;    3346 	{
;    3347     	dv_on[0]=dvOFF;
	LDI  R30,LOW(129)
	STS  _dv_on,R30
;    3348 	}
;    3349 
;    3350 if((av_serv[1]==avsON)||//(av_temper[1]!=avtOFF)||
_0x259:
;    3351 	(av_i_dv_min[1]!=aviOFF)||(av_i_dv_max[1]!=aviOFF)||(apv_cnt[1])||(av_i_dv_log[1]!=aviOFF)||(EE_DV_NUM<2))
	__GETB1MN _av_serv,1
	CPI  R30,LOW(0x55)
	BREQ _0x25D
	__GETB1MN _av_i_dv_min,1
	CPI  R30,LOW(0xAA)
	BRNE _0x25D
	__GETB1MN _av_i_dv_max,1
	CPI  R30,LOW(0xAA)
	BRNE _0x25D
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0x25D
	__GETB1MN _av_i_dv_log,1
	CPI  R30,LOW(0xAA)
	BRNE _0x25D
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	BRSH _0x25C
_0x25D:
;    3352 	{
;    3353     	dv_on[1]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,1
;    3354 	}
;    3355 
;    3356 if((av_serv[2]==avsON)||//(av_temper[2]!=avtOFF)||
_0x25C:
;    3357 	(av_i_dv_min[2]!=aviOFF)||(av_i_dv_max[2]!=aviOFF)||(apv_cnt[2])||(av_i_dv_log[2]!=aviOFF)||(EE_DV_NUM<3))
	__GETB1MN _av_serv,2
	CPI  R30,LOW(0x55)
	BREQ _0x260
	__GETB1MN _av_i_dv_min,2
	CPI  R30,LOW(0xAA)
	BRNE _0x260
	__GETB1MN _av_i_dv_max,2
	CPI  R30,LOW(0xAA)
	BRNE _0x260
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0x260
	__GETB1MN _av_i_dv_log,2
	CPI  R30,LOW(0xAA)
	BRNE _0x260
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	BRSH _0x25F
_0x260:
;    3358 	{
;    3359    	dv_on[2]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,2
;    3360 	}
;    3361 
;    3362 if((av_serv[3]==avsON)||//(av_temper[3]!=avtOFF)||
_0x25F:
;    3363 	(av_i_dv_min[3]!=aviOFF)||(av_i_dv_max[3]!=aviOFF)||(apv_cnt[3])||(av_i_dv_log[3]!=aviOFF)||(EE_DV_NUM<4))
	__GETB1MN _av_serv,3
	CPI  R30,LOW(0x55)
	BREQ _0x263
	__GETB1MN _av_i_dv_min,3
	CPI  R30,LOW(0xAA)
	BRNE _0x263
	__GETB1MN _av_i_dv_max,3
	CPI  R30,LOW(0xAA)
	BRNE _0x263
	__GETB1MN _apv_cnt,3
	CPI  R30,0
	BRNE _0x263
	__GETB1MN _av_i_dv_log,3
	CPI  R30,LOW(0xAA)
	BRNE _0x263
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x4)
	BRSH _0x262
_0x263:
;    3364 	{
;    3365     	dv_on[3]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,3
;    3366 	}
;    3367 	
;    3368 if((av_serv[4]==avsON)||//(av_temper[4]!=avtOFF)||
_0x262:
;    3369 	(av_i_dv_min[4]!=aviOFF)||(av_i_dv_max[4]!=aviOFF)||(apv_cnt[4])||(av_i_dv_log[4]!=aviOFF)||(EE_DV_NUM<5))
	__GETB1MN _av_serv,4
	CPI  R30,LOW(0x55)
	BREQ _0x266
	__GETB1MN _av_i_dv_min,4
	CPI  R30,LOW(0xAA)
	BRNE _0x266
	__GETB1MN _av_i_dv_max,4
	CPI  R30,LOW(0xAA)
	BRNE _0x266
	__GETB1MN _apv_cnt,4
	CPI  R30,0
	BRNE _0x266
	__GETB1MN _av_i_dv_log,4
	CPI  R30,LOW(0xAA)
	BRNE _0x266
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x5)
	BRSH _0x265
_0x266:
;    3370 	{
;    3371     	dv_on[4]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,4
;    3372 	}
;    3373 
;    3374 if((av_serv[5]==avsON)||//(av_temper[5]!=avtOFF)||
_0x265:
;    3375 	(av_i_dv_min[5]!=aviOFF)||(av_i_dv_max[5]!=aviOFF)||(apv_cnt[5])||(av_i_dv_log[5]!=aviOFF)||(EE_DV_NUM<6))
	__GETB1MN _av_serv,5
	CPI  R30,LOW(0x55)
	BREQ _0x269
	__GETB1MN _av_i_dv_min,5
	CPI  R30,LOW(0xAA)
	BRNE _0x269
	__GETB1MN _av_i_dv_max,5
	CPI  R30,LOW(0xAA)
	BRNE _0x269
	__GETB1MN _apv_cnt,5
	CPI  R30,0
	BRNE _0x269
	__GETB1MN _av_i_dv_log,5
	CPI  R30,LOW(0xAA)
	BRNE _0x269
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x6)
	BRSH _0x268
_0x269:
;    3376 	{
;    3377     	dv_on[5]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,5
;    3378 	}
;    3379 
;    3380 
;    3381 num_wrks_new=0;
_0x268:
	LDI  R30,LOW(0)
	STS  _num_wrks_new,R30
;    3382 if((dv_on[0]==dvSTAR)||(dv_on[0]==dvTRIAN)||(dv_on[0]==dvFULL))num_wrks_new++;
	LDS  R26,_dv_on
	CPI  R26,LOW(0x42)
	BREQ _0x26C
	CPI  R26,LOW(0x24)
	BREQ _0x26C
	CPI  R26,LOW(0x99)
	BRNE _0x26B
_0x26C:
	CALL SUBOPT_0x81
;    3383 if((dv_on[1]==dvSTAR)||(dv_on[1]==dvTRIAN)||(dv_on[1]==dvFULL))num_wrks_new++;
_0x26B:
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x42)
	BREQ _0x26F
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x24)
	BREQ _0x26F
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x99)
	BRNE _0x26E
_0x26F:
	CALL SUBOPT_0x81
;    3384 if((dv_on[2]==dvSTAR)||(dv_on[2]==dvTRIAN)||(dv_on[2]==dvFULL))num_wrks_new++;
_0x26E:
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x42)
	BREQ _0x272
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x24)
	BREQ _0x272
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x99)
	BRNE _0x271
_0x272:
	CALL SUBOPT_0x81
;    3385 if((dv_on[3]==dvSTAR)||(dv_on[3]==dvTRIAN)||(dv_on[3]==dvFULL))num_wrks_new++;
_0x271:
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x42)
	BREQ _0x275
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x24)
	BREQ _0x275
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x99)
	BRNE _0x274
_0x275:
	CALL SUBOPT_0x81
;    3386 if((dv_on[4]==dvSTAR)||(dv_on[4]==dvTRIAN)||(dv_on[4]==dvFULL))num_wrks_new++;
_0x274:
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x42)
	BREQ _0x278
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x24)
	BREQ _0x278
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x99)
	BRNE _0x277
_0x278:
	CALL SUBOPT_0x81
;    3387 if((dv_on[5]==dvSTAR)||(dv_on[5]==dvTRIAN)||(dv_on[5]==dvFULL))num_wrks_new++;
_0x277:
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x42)
	BREQ _0x27B
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x24)
	BREQ _0x27B
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x99)
	BRNE _0x27A
_0x27B:
	CALL SUBOPT_0x81
;    3388 
;    3389 if((main_cnt<=10)/*||(comm_av_st==cast_ON2)*/)
_0x27A:
	CALL SUBOPT_0x82
	BRLO _0x27D
;    3390 	{
;    3391 	dv_on[0]=dvOFF;
	CALL SUBOPT_0x83
;    3392 	dv_on[1]=dvOFF;
	__PUTB1MN _dv_on,1
;    3393 	dv_on[2]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,2
;    3394 	dv_on[3]=dvOFF;
	__PUTB1MN _dv_on,3
;    3395 	dv_on[4]=dvOFF;
	__PUTB1MN _dv_on,4
;    3396 	dv_on[5]=dvOFF;
	__PUTB1MN _dv_on,5
;    3397 	}
;    3398 /*	
;    3399 num_wrks_new_new=0;
;    3400 if(dv_on[0]==dvON)num_wrks_new_new++;
;    3401 if(dv_on[1]==dvON)num_wrks_new_new++;
;    3402 if(dv_on[2]==dvON)num_wrks_new_new++;
;    3403 if(dv_on[3]==dvON)num_wrks_new_new++;
;    3404 if(dv_on[4]==dvON)num_wrks_new_new++;
;    3405 if(dv_on[5]==dvON)num_wrks_new_new++;
;    3406 */
;    3407 /*if((num_wrks_new_new==4)&&(num_wrks_old!=num_wrks_new_new))
;    3408 	{
;    3409 	if(EE_LOG==el_popl)
;    3410 		{
;    3411 		av_max_cnt=30;
;    3412 		}
;    3413 	else if(EE_LOG==el_420)
;    3414 		{
;    3415 		av_max_cnt=5;
;    3416 		av_max_level=I420;
;    3417 		}		
;    3418 	} */
;    3419 //	
;    3420 
;    3421 
;    3422 
;    3423 if(EE_MODE==emMNL)
_0x27D:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BREQ PC+3
	JMP _0x27E
;    3424 	{
;    3425 	
;    3426 	
;    3427 	
;    3428 	if((but_cnt[0]==100)&&(av_serv[0]!=avsON))
	LDS  R26,_but_cnt
	CPI  R26,LOW(0x64)
	BRNE _0x280
	LDS  R26,_av_serv
	CPI  R26,LOW(0x55)
	BRNE _0x281
_0x280:
	RJMP _0x27F
_0x281:
;    3429 		{
;    3430 		if(STAR_TRIAN==stON)dv_on[0]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x282
	LDI  R30,LOW(153)
	RJMP _0xB55
;    3431 		else dv_on[0]=dvTRIAN;
_0x282:
	LDI  R30,LOW(36)
_0xB55:
	STS  _dv_on,R30
;    3432 		}	
;    3433      else dv_on[0]=dvOFF; 
	RJMP _0x284
_0x27F:
	LDI  R30,LOW(129)
	STS  _dv_on,R30
_0x284:
;    3434      
;    3435 	if((but_cnt[1]==100)&&(EE_DV_NUM>=2)&&(av_serv[1]!=avsON))
	__GETB1MN _but_cnt,1
	CPI  R30,LOW(0x64)
	BRNE _0x286
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	BRLO _0x286
	__GETB1MN _av_serv,1
	CPI  R30,LOW(0x55)
	BRNE _0x287
_0x286:
	RJMP _0x285
_0x287:
;    3436 		{
;    3437 		if(STAR_TRIAN==stON)dv_on[1]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x288
	LDI  R30,LOW(153)
	__PUTB1MN _dv_on,1
;    3438 		else dv_on[1]=dvTRIAN;
	RJMP _0x289
_0x288:
	LDI  R30,LOW(36)
	__PUTB1MN _dv_on,1
_0x289:
;    3439 		}
;    3440 	else dv_on[1]=dvOFF; 
	RJMP _0x28A
_0x285:
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,1
_0x28A:
;    3441 		
;    3442 	if((but_cnt[2]==100)&&(EE_DV_NUM>=3)&&(av_serv[2]!=avsON))
	__GETB1MN _but_cnt,2
	CPI  R30,LOW(0x64)
	BRNE _0x28C
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	BRLO _0x28C
	__GETB1MN _av_serv,2
	CPI  R30,LOW(0x55)
	BRNE _0x28D
_0x28C:
	RJMP _0x28B
_0x28D:
;    3443 		{
;    3444 		if(STAR_TRIAN==stON)dv_on[2]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x28E
	LDI  R30,LOW(153)
	__PUTB1MN _dv_on,2
;    3445 		else dv_on[2]=dvTRIAN;
	RJMP _0x28F
_0x28E:
	LDI  R30,LOW(36)
	__PUTB1MN _dv_on,2
_0x28F:
;    3446 		}
;    3447 	else dv_on[2]=dvOFF; 
	RJMP _0x290
_0x28B:
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,2
_0x290:
;    3448 	
;    3449 	if((but_cnt[3]==100)&&(EE_DV_NUM>=4)&&(av_serv[3]!=avsON))
	__GETB1MN _but_cnt,3
	CPI  R30,LOW(0x64)
	BRNE _0x292
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x4)
	BRLO _0x292
	__GETB1MN _av_serv,3
	CPI  R30,LOW(0x55)
	BRNE _0x293
_0x292:
	RJMP _0x291
_0x293:
;    3450 		{
;    3451 		if(STAR_TRIAN==stON)dv_on[3]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x294
	LDI  R30,LOW(153)
	__PUTB1MN _dv_on,3
;    3452 		else dv_on[3]=dvTRIAN;
	RJMP _0x295
_0x294:
	LDI  R30,LOW(36)
	__PUTB1MN _dv_on,3
_0x295:
;    3453 		}
;    3454 	else dv_on[3]=dvOFF;
	RJMP _0x296
_0x291:
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,3
_0x296:
;    3455 	
;    3456 	
;    3457 
;    3458 /*	if(power)dv_on[pilot_dv]=dvFR;
;    3459 		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
;    3460 			{
;    3461 			if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
;    3462      		else dv_on[potenz]=dvTRIAN;
;    3463      		cnt_control_blok=50;
;    3464 			}
;    3465     		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
;    3466 			{
;    3467     	    		dv_on[potenz_off]=dvOFF;
;    3468 			cnt_control_blok=50;
;    3469 			}*/
;    3470 				   	
;    3471 	}
;    3472 else if(EE_MODE==emAVT)
	RJMP _0x297
_0x27E:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ PC+3
	JMP _0x298
;    3473 	{
;    3474 	if((mode==mSTOP)||(main_cnt<10))
	LDS  R26,_mode
	CPI  R26,LOW(0x0)
	BREQ _0x29A
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRSH _0x299
_0x29A:
;    3475 		{
;    3476 		fp_stat=dvOFF;
	LDI  R30,LOW(129)
	STS  _fp_stat,R30
;    3477 		dv_on[0]=dvOFF;
	CALL SUBOPT_0x83
;    3478 		dv_on[1]=dvOFF;
	__PUTB1MN _dv_on,1
;    3479 		dv_on[2]=dvOFF;
	LDI  R30,LOW(129)
	__PUTB1MN _dv_on,2
;    3480 		dv_on[3]=dvOFF;
	__PUTB1MN _dv_on,3
;    3481 		dv_on[4]=dvOFF;
	__PUTB1MN _dv_on,4
;    3482 		dv_on[5]=dvOFF;
	__PUTB1MN _dv_on,5
;    3483 		}
;    3484 	else if(mode==mSTART)
	RJMP _0x29C
_0x299:
	LDS  R26,_mode
	CPI  R26,LOW(0x11)
	BRNE _0x29D
;    3485 		{
;    3486 		
;    3487 		if((power)&&(av_fp_stat!=afsON))dv_on[pilot_dv]=dvFR;
	LDS  R30,_power
	LDS  R31,_power+1
	SBIW R30,0
	BREQ _0x29F
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x2A0
_0x29F:
	RJMP _0x29E
_0x2A0:
	CALL SUBOPT_0x84
;    3488 
;    3489 		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
_0x29E:
	CALL SUBOPT_0x85
	BRSH _0x2A2
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2A3
_0x2A2:
	RJMP _0x2A1
_0x2A3:
;    3490 			{
;    3491 		 	if(potenz<EE_DV_NUM)
	CALL SUBOPT_0x86
	BRSH _0x2A4
;    3492 				{
;    3493 				if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x2A5
	CALL SUBOPT_0x87
	LDI  R30,LOW(153)
	RJMP _0xB56
;    3494      				else dv_on[potenz]=dvTRIAN;
_0x2A5:
	CALL SUBOPT_0x87
	LDI  R30,LOW(36)
_0xB56:
	ST   X,R30
;    3495      				cnt_control_blok=50;
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    3496      				}
;    3497 			}
_0x2A4:
;    3498     		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
	RJMP _0x2A7
_0x2A1:
	CALL SUBOPT_0x88
	BRSH _0x2A9
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2AA
_0x2A9:
	RJMP _0x2A8
_0x2AA:
;    3499 			{
;    3500     	    		dv_on[potenz_off]=dvOFF;
	CALL SUBOPT_0x89
;    3501 			cnt_control_blok=50;
;    3502 			}  
;    3503 		
;    3504 		//dv_on[2]=dvTRIAN;
;    3505    		} 
_0x2A8:
_0x2A7:
;    3506  
;    3507 	else if(mode==mFPAV)
	RJMP _0x2AB
_0x29D:
	LDS  R26,_mode
	CPI  R26,LOW(0x99)
	BRNE _0x2AC
;    3508 		{
;    3509 		
;    3510 		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
	CALL SUBOPT_0x85
	BRSH _0x2AE
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2AF
_0x2AE:
	RJMP _0x2AD
_0x2AF:
;    3511 			{
;    3512 		 	if(potenz<EE_DV_NUM)
	CALL SUBOPT_0x86
	BRSH _0x2B0
;    3513 				{
;    3514 				if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x2B1
	CALL SUBOPT_0x87
	LDI  R30,LOW(153)
	RJMP _0xB57
;    3515      			else dv_on[potenz]=dvTRIAN;
_0x2B1:
	CALL SUBOPT_0x87
	LDI  R30,LOW(36)
_0xB57:
	ST   X,R30
;    3516      			cnt_control_blok=50;
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    3517      			}
;    3518 			}
_0x2B0:
;    3519     		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
	RJMP _0x2B3
_0x2AD:
	CALL SUBOPT_0x88
	BRSH _0x2B5
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2B6
_0x2B5:
	RJMP _0x2B4
_0x2B6:
;    3520 			{
;    3521     	    		dv_on[potenz_off]=dvOFF;
	CALL SUBOPT_0x89
;    3522 			cnt_control_blok=50;
;    3523 			}
;    3524    		}   		
_0x2B4:
_0x2B3:
;    3525    		
;    3526 	else if(mode==mREG)
	RJMP _0x2B7
_0x2AC:
	LDS  R26,_mode
	CPI  R26,LOW(0x22)
	BRNE _0x2B8
;    3527 		{
;    3528 		
;    3529 		if((power)&&(av_fp_stat!=afsON))dv_on[pilot_dv]=dvFR;
	LDS  R30,_power
	LDS  R31,_power+1
	SBIW R30,0
	BREQ _0x2BA
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x2BB
_0x2BA:
	RJMP _0x2B9
_0x2BB:
	CALL SUBOPT_0x84
;    3530 
;    3531 		if((num_necc>num_wrks_new)&&(!cnt_control_blok))
_0x2B9:
	CALL SUBOPT_0x85
	BRSH _0x2BD
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2BE
_0x2BD:
	RJMP _0x2BC
_0x2BE:
;    3532 			{
;    3533 			if(potenz<EE_DV_NUM)
	CALL SUBOPT_0x86
	BRSH _0x2BF
;    3534 				{
;    3535 				if(STAR_TRIAN==stON)dv_on[potenz]=dvFULL;
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x2C0
	CALL SUBOPT_0x87
	LDI  R30,LOW(153)
	RJMP _0xB58
;    3536      				else dv_on[potenz]=dvTRIAN;
_0x2C0:
	CALL SUBOPT_0x87
	LDI  R30,LOW(36)
_0xB58:
	ST   X,R30
;    3537      				cnt_control_blok=50;
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    3538      				}
;    3539 			}
_0x2BF:
;    3540     		else if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
	RJMP _0x2C2
_0x2BC:
	CALL SUBOPT_0x88
	BRSH _0x2C4
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2C5
_0x2C4:
	RJMP _0x2C3
_0x2C5:
;    3541 			{
;    3542     	    		dv_on[potenz_off]=dvOFF;
	CALL SUBOPT_0x89
;    3543 			cnt_control_blok=50;
;    3544 			}
;    3545    		}   	
_0x2C3:
_0x2C2:
;    3546    		
;    3547 	else if(mode==mTORM)
	RJMP _0x2C6
_0x2B8:
	LDS  R26,_mode
	CPI  R26,LOW(0x88)
	BRNE _0x2C7
;    3548 		{
;    3549 		
;    3550 		if(((power)&&(av_fp_stat!=afsON)))dv_on[pilot_dv]=dvFR;
	LDS  R30,_power
	LDS  R31,_power+1
	SBIW R30,0
	BREQ _0x2C9
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x2CA
_0x2C9:
	RJMP _0x2C8
_0x2CA:
	CALL SUBOPT_0x84
;    3551 
;    3552 		if((num_necc<num_wrks_new)&&(!cnt_control_blok)) 
_0x2C8:
	CALL SUBOPT_0x88
	BRSH _0x2CC
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2CD
_0x2CC:
	RJMP _0x2CB
_0x2CD:
;    3553 			{
;    3554     	    		dv_on[potenz_off]=dvOFF;
	LDS  R26,_potenz_off
	LDI  R27,0
	SUBI R26,LOW(-_dv_on)
	SBCI R27,HIGH(-_dv_on)
	LDI  R30,LOW(129)
	ST   X,R30
;    3555 			cnt_control_blok=20;
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
;    3556 			}
;    3557    		}   	   			
_0x2CB:
;    3558 	}
_0x2C7:
_0x2C6:
_0x2B7:
_0x2AB:
_0x29C:
;    3559 //else if(EE_MODE==emMNL)
;    3560 //dv_on[0]=dvTRIAN;
;    3561 
;    3562 
;    3563 }
_0x298:
_0x297:
	RET
;    3564 
;    3565 //-----------------------------------------------
;    3566 void plata_ex_hndl(void)
;    3567 {
_plata_ex_hndl:
;    3568 data_for_ex[0,2]=dv_on[0];
	LDS  R30,_dv_on
	__PUTB1MN _data_for_ex,2
;    3569 data_for_ex[0,3]=dv_on[0];
	__PUTB1MN _data_for_ex,3
;    3570 data_for_ex[0,4]=dv_on[0];
	__PUTB1MN _data_for_ex,4
;    3571 data_for_ex[0,5]=dv_on[0];
	__PUTB1MN _data_for_ex,5
;    3572 
;    3573 data_for_ex[0,6]=dv_on[1];
	__GETB1MN _dv_on,1
	__PUTB1MN _data_for_ex,6
;    3574 data_for_ex[0,7]=dv_on[1];
	__GETB1MN _dv_on,1
	__PUTB1MN _data_for_ex,7
;    3575 data_for_ex[0,8]=dv_on[1];
	__GETB1MN _dv_on,1
	__PUTB1MN _data_for_ex,8
;    3576 data_for_ex[0,9]=dv_on[1];
	__GETB1MN _dv_on,1
	__PUTB1MN _data_for_ex,9
;    3577 
;    3578 data_for_ex[1,2]=dv_on[2];
	__GETB1MN _dv_on,2
	__PUTB1MN _data_for_ex,12
;    3579 data_for_ex[1,3]=dv_on[2];
	__GETB1MN _dv_on,2
	__PUTB1MN _data_for_ex,13
;    3580 data_for_ex[1,4]=dv_on[2];
	__GETB1MN _dv_on,2
	__PUTB1MN _data_for_ex,14
;    3581 data_for_ex[1,5]=dv_on[2]; 
	__GETB1MN _dv_on,2
	__PUTB1MN _data_for_ex,15
;    3582 
;    3583 data_for_ex[1,6]=dv_on[3];
	__GETB1MN _dv_on,3
	__PUTB1MN _data_for_ex,16
;    3584 data_for_ex[1,7]=dv_on[3];
	__GETB1MN _dv_on,3
	__PUTB1MN _data_for_ex,17
;    3585 data_for_ex[1,8]=dv_on[3];
	__GETB1MN _dv_on,3
	__PUTB1MN _data_for_ex,18
;    3586 data_for_ex[1,9]=dv_on[3];
	__GETB1MN _dv_on,3
	__PUTB1MN _data_for_ex,19
;    3587 }
	RET
;    3588 
;    3589 //-----------------------------------------------
;    3590 void serv_drv(void)
;    3591 {         
_serv_drv:
;    3592 char i;
;    3593 for(i=0;i<EE_DV_NUM;i++)
	ST   -Y,R16
;	i -> R16
	LDI  R16,LOW(0)
_0x2CF:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRSH _0x2D0
;    3594 	{
;    3595 	if(av_serv[i]==avsON)
	CALL SUBOPT_0x8A
	BRNE _0x2D1
;    3596 		{
;    3597 		//av_vl[i]=avvOFF;
;    3598 		//av_temper[i]=avtOFF;
;    3599 	    //	av_upp[i]=avuOFF;
;    3600 		av_i_dv_min[i]=aviOFF;
	CALL SUBOPT_0x8B
	CALL SUBOPT_0x8C
;    3601 		av_i_dv_max[i]=aviOFF;
	SUBI R26,LOW(-_av_i_dv_max)
	SBCI R27,HIGH(-_av_i_dv_max)
	CALL SUBOPT_0x8C
;    3602 		//av_i_dv_per[i]=aviOFF; 
;    3603 		av_i_dv_not[i]=aviOFF;
	SUBI R26,LOW(-_av_i_dv_not)
	SBCI R27,HIGH(-_av_i_dv_not)
	CALL SUBOPT_0x8C
;    3604 		av_id_min_cnt[i]=0;
	CALL SUBOPT_0x8D
;    3605 		av_id_max_cnt[i]=0;
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x8F
;    3606 		//av_id_max_cnt[i]=0;
;    3607 		av_id_not_cnt[i]=0;
	SUBI R26,LOW(-_av_id_not_cnt)
	SBCI R27,HIGH(-_av_id_not_cnt)
	CALL SUBOPT_0x8F
;    3608 		apv_cnt[i]=0;
	SUBI R26,LOW(-_apv_cnt)
	SBCI R27,HIGH(-_apv_cnt)
	CALL SUBOPT_0x8F
;    3609 		apv[i]=apvOFF;
	SUBI R26,LOW(-_apv)
	SBCI R27,HIGH(-_apv)
	CALL SUBOPT_0x8C
;    3610 		fp_apv[i]=faOFF;
	SUBI R26,LOW(-_fp_apv)
	SBCI R27,HIGH(-_fp_apv)
	LDI  R30,LOW(170)
	ST   X,R30
;    3611 		if(i==pilot_dv) 
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	MOV  R26,R16
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x2D2
;    3612 			{
;    3613 			bDVCH=1;
	SET
	BLD  R4,4
;    3614 			mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    3615 			}
;    3616 		}
_0x2D2:
;    3617 	}
_0x2D1:
	SUBI R16,-1
	RJMP _0x2CF
_0x2D0:
;    3618 }
	LD   R16,Y+
	RET
;    3619 
;    3620 //-----------------------------------------------
;    3621 void num_necc_drv(void)
;    3622 {
_num_necc_drv:
;    3623 fp_step_num=(((FP_FMAX-FP_FMIN)-1)/SS_FRIQ)+2;
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	SUB  R26,R30
	SBC  R27,R31
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_SS_FRIQ)
	LDI  R27,HIGH(_SS_FRIQ)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL __DIVW21
	ADIW R30,2
	STS  _fp_step_num,R30
	STS  _fp_step_num+1,R31
;    3624 /*
;    3625 if(power==0)
;    3626 	{
;    3627 	fp_stat=dvOFF;
;    3628 	fp_power=0;
;    3629 	num_necc=0;
;    3630 	}
;    3631 else if(power<=fp_step_num)
;    3632 	{
;    3633 	fp_stat=dvON;
;    3634 	fp_power=power-1;
;    3635 	num_necc=0;
;    3636 	}          
;    3637 else if(power>fp_step_num) 
;    3638 	{
;    3639 	fp_stat=dvON;
;    3640 	fp_power=(power-1)%fp_step_num;
;    3641 	num_necc=(power-1)/fp_step_num;
;    3642 	} */  
;    3643 
;    3644 if((EE_MODE==emAVT)&&(mode!=mFPAV))
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x2D4
	LDS  R26,_mode
	CPI  R26,LOW(0x99)
	BRNE _0x2D5
_0x2D4:
	RJMP _0x2D3
_0x2D5:
;    3645 	{	
;    3646 	if(power<100)num_necc=0;
	LDS  R26,_power
	LDS  R27,_power+1
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRGE _0x2D6
	LDI  R30,LOW(0)
	RJMP _0xB59
;    3647 	else num_necc=power/100;	
_0x2D6:
	CALL SUBOPT_0x53
_0xB59:
	STS  _num_necc,R30
;    3648      }
;    3649 
;    3650 if((av_sens_p_stat==aspON)&&(EE_MODE==emAVT)&&(mode!=mSTOP)&&(mode!=mTORM))	num_necc=C1N;
_0x2D3:
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0x55)
	BRNE _0x2D9
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x2D9
	LDS  R26,_mode
	CPI  R26,LOW(0x0)
	BREQ _0x2D9
	CPI  R26,LOW(0x88)
	BRNE _0x2DA
_0x2D9:
	RJMP _0x2D8
_0x2DA:
	LDI  R26,LOW(_C1N)
	LDI  R27,HIGH(_C1N)
	CALL __EEPROMRDW
	STS  _num_necc,R30
;    3651 else if((av_fp_stat==afsON)&&(EE_MODE==emAVT)&&(mode==mFPAV))
	RJMP _0x2DB
_0x2D8:
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x2DD
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x2DD
	LDS  R26,_mode
	CPI  R26,LOW(0x99)
	BREQ _0x2DE
_0x2DD:
	RJMP _0x2DC
_0x2DE:
;    3652 	{  
;    3653 	if((p<p_ust_mi)&&(!cnt_control_blok)) num_necc=CH1N;
	LDS  R30,_p_ust_mi
	LDS  R31,_p_ust_mi+1
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x2E0
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2E1
_0x2E0:
	RJMP _0x2DF
_0x2E1:
	LDI  R26,LOW(_CH1N)
	LDI  R27,HIGH(_CH1N)
	CALL __EEPROMRDB
	STS  _num_necc,R30
;    3654 	else if((p>p_ust_pl)&&(!cnt_control_blok))num_necc=0;
	RJMP _0x2E2
_0x2DF:
	LDS  R30,_p_ust_pl
	LDS  R31,_p_ust_pl+1
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x2E4
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	SBIW R30,0
	BREQ _0x2E5
_0x2E4:
	RJMP _0x2E3
_0x2E5:
	LDI  R30,LOW(0)
	STS  _num_necc,R30
;    3655 	gran_char(&num_necc,0,EE_DV_NUM);
_0x2E3:
_0x2E2:
	LDI  R30,LOW(_num_necc)
	LDI  R31,HIGH(_num_necc)
	CALL SUBOPT_0x90
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	ST   -Y,R30
	CALL _gran_char
;    3656 	}	
;    3657 }
_0x2DC:
_0x2DB:
	RET
;    3658 
;    3659 //-----------------------------------------------
;    3660 void rel_in_drv(void)
;    3661 {                
_rel_in_drv:
;    3662 char i,temp;
;    3663 DDRA&=0b00001111; 
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16
;	temp -> R17
	IN   R30,0x1A
	ANDI R30,LOW(0xF)
	OUT  0x1A,R30
;    3664  
;    3665 for(i=0;i<4;i++)
	LDI  R16,LOW(0)
_0x2E7:
	CPI  R16,4
	BRLO PC+3
	JMP _0x2E8
;    3666 	{
;    3667 	temp=0;
	LDI  R17,LOW(0)
;    3668  	if((PINA&(1<<(7-i))))temp=1;
	IN   R30,0x19
	PUSH R30
	LDI  R30,LOW(7)
	SUB  R30,R16
	LDI  R26,LOW(1)
	CALL __LSLB12
	POP  R26
	AND  R30,R26
	BREQ _0x2E9
	LDI  R17,LOW(1)
;    3669 	if(((PORTG&0b00000100)&&(temp))||(!(PORTG&0b00000100)&&(!temp)))
_0x2E9:
	LDS  R30,101
	ANDI R30,LOW(0x4)
	BREQ _0x2EB
	CPI  R17,0
	BRNE _0x2ED
_0x2EB:
	LDS  R30,101
	ANDI R30,LOW(0x4)
	BRNE _0x2EE
	CPI  R17,0
	BREQ _0x2ED
_0x2EE:
	RJMP _0x2EA
_0x2ED:
;    3670 		{
;    3671 		popl_cnt_p[i]++;
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_popl_cnt_p)
	SBCI R27,HIGH(-_popl_cnt_p)
	CALL SUBOPT_0x91
;    3672 		popl_cnt_m[i]-=2; 
	SUBI R30,LOW(-_popl_cnt_m)
	SBCI R31,HIGH(-_popl_cnt_m)
	PUSH R31
	PUSH R30
	LD   R30,Z
	SUBI R30,LOW(2)
	POP  R26
	POP  R27
	ST   X,R30
;    3673 		}
;    3674 	else if((!(PORTG&0b00000100)&&(temp))||((PORTG&0b00000100)&&(!temp)))
	RJMP _0x2F1
_0x2EA:
	LDS  R30,101
	ANDI R30,LOW(0x4)
	BRNE _0x2F3
	CPI  R17,0
	BRNE _0x2F5
_0x2F3:
	LDS  R30,101
	ANDI R30,LOW(0x4)
	BREQ _0x2F6
	CPI  R17,0
	BREQ _0x2F5
_0x2F6:
	RJMP _0x2F2
_0x2F5:
;    3675 		{
;    3676 		popl_cnt_m[i]++;
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_popl_cnt_m)
	SBCI R27,HIGH(-_popl_cnt_m)
	CALL SUBOPT_0x91
;    3677 		popl_cnt_p[i]-=2; 
	SUBI R30,LOW(-_popl_cnt_p)
	SBCI R31,HIGH(-_popl_cnt_p)
	PUSH R31
	PUSH R30
	LD   R30,Z
	SUBI R30,LOW(2)
	POP  R26
	POP  R27
	ST   X,R30
;    3678 		}  
;    3679 	gran_char(&popl_cnt_p[i],0,10);
_0x2F2:
_0x2F1:
	CALL SUBOPT_0x92
	CALL SUBOPT_0x90
	CALL SUBOPT_0x93
;    3680 	gran_char(&popl_cnt_m[i],0,10);	
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_popl_cnt_m)
	SBCI R31,HIGH(-_popl_cnt_m)
	CALL SUBOPT_0x90
	CALL SUBOPT_0x93
;    3681 	
;    3682 	if(popl_cnt_p[i]>=10) rel_in_st[i]=rON;
	CALL SUBOPT_0x92
	LD   R30,Z
	CPI  R30,LOW(0xA)
	BRLT _0x2F9
	CALL SUBOPT_0x94
	LDI  R30,LOW(85)
	ST   X,R30
;    3683 	else if(popl_cnt_p[i]<=0) rel_in_st[i]=rOFF;
	RJMP _0x2FA
_0x2F9:
	CALL SUBOPT_0x92
	CALL SUBOPT_0x95
	BRLT _0x2FB
	CALL SUBOPT_0x94
	LDI  R30,LOW(170)
	ST   X,R30
;    3684 	}
_0x2FB:
_0x2FA:
	SUBI R16,-1
	RJMP _0x2E7
_0x2E8:
;    3685 
;    3686 if((rel_in_st[0]==rON)&&(rel_in_st_old[0]!=rON))av_hndl(AVAR_START,0,0);
	LDS  R26,_rel_in_st
	CPI  R26,LOW(0x55)
	BRNE _0x2FD
	LDS  R26,_rel_in_st_old
	CPI  R26,LOW(0x55)
	BRNE _0x2FE
_0x2FD:
	RJMP _0x2FC
_0x2FE:
	LDI  R30,LOW(14)
	CALL SUBOPT_0x5A
	CALL _av_hndl
;    3687 rel_in_st_old[0]=rel_in_st[0];
_0x2FC:
	LDS  R30,_rel_in_st
	STS  _rel_in_st_old,R30
;    3688 
;    3689 
;    3690 
;    3691 	 
;    3692 DDRG|=0b00000100;
	LDS  R30,100
	ORI  R30,4
	STS  100,R30
;    3693 if(PING&0b00000100)PORTG&=0b11111011;
	LDS  R30,99
	ANDI R30,LOW(0x4)
	BREQ _0x2FF
	LDS  R30,101
	ANDI R30,0xFB
	RJMP _0xB5A
;    3694 else PORTG|=0b00000100; 
_0x2FF:
	LDS  R30,101
	ORI  R30,4
_0xB5A:
	STS  101,R30
;    3695 
;    3696 DDRA|=0b11110000;
	IN   R30,0x1A
	ORI  R30,LOW(0xF0)
	OUT  0x1A,R30
;    3697 PORTA&=0b00001111;
	IN   R30,0x1B
	ANDI R30,LOW(0xF)
	OUT  0x1B,R30
;    3698 }
	LD   R16,Y+
	LD   R17,Y+
	RET
;    3699 
;    3700 //-----------------------------------------------
;    3701 void t2_init(void)
;    3702 {
_t2_init:
;    3703 // Timer/Counter 2 initialization
;    3704 // Clock source: System Clock
;    3705 // Clock value: 250,000 kHz
;    3706 // Mode: Normal top=FFh
;    3707 // OC2 output: Disconnected
;    3708 ASSR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;    3709 TCCR2=0x03;
	LDI  R30,LOW(3)
	OUT  0x25,R30
;    3710 TCNT2=-62;
	LDI  R30,LOW(194)
	OUT  0x24,R30
;    3711 OCR2=0x00;
	LDI  R30,LOW(0)
	OUT  0x23,R30
;    3712 TIMSK|=0x40;
	CALL SUBOPT_0x96
;    3713 }
	RET
;    3714 
;    3715 //-----------------------------------------------
;    3716 void out_hndl(void)
;    3717 {
_out_hndl:
;    3718 #define OUT_AV		4
;    3719 #define OUT_COOL	1
;    3720 #define OUT_WARM	0
;    3721 
;    3722 
;    3723 
;    3724 if(cool_st==cool_ON)out_stat|=(1<<OUT_COOL);
	LDS  R30,_cool_st
	CPI  R30,0
	BRNE _0x301
	MOV  R30,R14
	ORI  R30,2
	RJMP _0xB5B
;    3725 else out_stat&=~(1<<OUT_COOL);
_0x301:
	MOV  R30,R14
	ANDI R30,0xFD
_0xB5B:
	MOV  R14,R30
;    3726 
;    3727 if(warm_st==warm_ON)out_stat|=(1<<OUT_WARM);
	LDS  R26,_warm_st
	CPI  R26,LOW(0x55)
	BRNE _0x303
	MOV  R30,R14
	ORI  R30,1
	RJMP _0xB5C
;    3728 else out_stat&=~(1<<OUT_WARM);
_0x303:
	MOV  R30,R14
	ANDI R30,0xFE
_0xB5C:
	MOV  R14,R30
;    3729 
;    3730 if((comm_av_st==cast_ON1)||(comm_av_st==cast_ON2)||(main_cnt<10))out_stat&=~(1<<OUT_AV);
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0x55)
	BREQ _0x306
	CPI  R26,LOW(0x69)
	BREQ _0x306
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRSH _0x305
_0x306:
	MOV  R30,R14
	ANDI R30,0xEF
	RJMP _0xB5D
;    3731 else out_stat|=(1<<OUT_AV);
_0x305:
	MOV  R30,R14
	ORI  R30,0x10
_0xB5D:
	MOV  R14,R30
;    3732 }
	RET
;    3733 
;    3734 //-----------------------------------------------
;    3735 void out_drv(void)
;    3736 {
_out_drv:
;    3737 DDRD|=0b00010011;
	IN   R30,0x11
	ORI  R30,LOW(0x13)
	OUT  0x11,R30
;    3738 DDRG|=0b00001000;
	LDS  R30,100
	ORI  R30,8
	STS  100,R30
;    3739 
;    3740 if((comm_av_st==cast_ON1)||(comm_av_st==cast_ON2)||(main_cnt<10)) PORTD.4=0;
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0x55)
	BREQ _0x30A
	CPI  R26,LOW(0x69)
	BREQ _0x30A
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRSH _0x309
_0x30A:
	CBI  0x12,4
;    3741 else PORTD.4=1;
	RJMP _0x30C
_0x309:
	SBI  0x12,4
_0x30C:
;    3742 
;    3743 if((main_cnt<2)||(off_fp_cnt)) PORTD.1=0;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x2)
	LDI  R30,HIGH(0x2)
	CPC  R27,R30
	BRLO _0x30E
	LDS  R30,_off_fp_cnt
	LDS  R31,_off_fp_cnt+1
	SBIW R30,0
	BREQ _0x30D
_0x30E:
	CBI  0x12,1
;    3744 else PORTD.1=1;
	RJMP _0x310
_0x30D:
	SBI  0x12,1
_0x310:
;    3745  
;    3746 if(cool_st==cool_ON)PORTD.0=1;
	LDS  R30,_cool_st
	CPI  R30,0
	BRNE _0x311
	SBI  0x12,0
;    3747 else PORTD.0=0;
	RJMP _0x312
_0x311:
	CBI  0x12,0
_0x312:
;    3748 
;    3749 if(warm_st==warm_ON)PORTG|=(1<<3);
	LDS  R26,_warm_st
	CPI  R26,LOW(0x55)
	BRNE _0x313
	LDS  R30,101
	ORI  R30,8
	RJMP _0xB5E
;    3750 else PORTG&=~(1<<3);
_0x313:
	LDS  R30,101
	ANDI R30,0XF7
_0xB5E:
	STS  101,R30
;    3751                                       
;    3752 }
	RET
;    3753 
;    3754 
;    3755 
;    3756 //-----------------------------------------------
;    3757 void ds14287_drv(void)
;    3758 {
_ds14287_drv:
;    3759 _sec=read_ds14287(SECONDS); 
	CALL SUBOPT_0x45
	STS  __sec,R30
;    3760 _min=read_ds14287(MINUTES);
	CALL SUBOPT_0x44
	STS  __min,R30
;    3761 _hour=read_ds14287(HOURS);
	CALL SUBOPT_0x43
	STS  __hour,R30
;    3762 _day=read_ds14287(DAY_OF_THE_MONTH);
	CALL SUBOPT_0x46
	STS  __day,R30
;    3763 _month=read_ds14287(MONTH);
	CALL SUBOPT_0x47
	STS  __month,R30
;    3764 _year=read_ds14287(YEAR);
	CALL SUBOPT_0x48
	STS  __year,R30
;    3765 _week_day=read_ds14287(DAY_OF_THE_WEEK);
	CALL SUBOPT_0x97
;    3766 }
	RET
;    3767 
;    3768 
;    3769 
;    3770 //-----------------------------------------------
;    3771 void resurs_drv(void)
;    3772 {
_resurs_drv:
;    3773 char i;
;    3774 
;    3775 for(i=0;i<6;i++)
	ST   -Y,R16
;	i -> R16
	LDI  R16,LOW(0)
_0x316:
	CPI  R16,6
	BRSH _0x317
;    3776 	{
;    3777 	
;    3778 	if(dv_on[i]!=dvOFF)
	CALL SUBOPT_0x98
	BREQ _0x318
;    3779 		{
;    3780 		resurs_cnt_[i]++;
	CALL SUBOPT_0x99
	ADIW R30,1
	ST   X+,R30
	ST   X,R31
;    3781 		if(resurs_cnt_[i]>=RESURS_CNT_SEC_IN_HOUR)
	CALL SUBOPT_0x99
	CPI  R30,LOW(0xE10)
	LDI  R26,HIGH(0xE10)
	CPC  R31,R26
	BRLO _0x319
;    3782 			{
;    3783 			resurs_cnt_[i]=0;
	MOV  R30,R16
	CALL SUBOPT_0x9A
;    3784 		     RESURS_CNT[i]++;
	CALL SUBOPT_0x9B
	CALL SUBOPT_0x9C
;    3785 		    	}
;    3786 		}
_0x319:
;    3787 	resurs_cnt__[i]=((unsigned long)RESURS_CNT[i]*RESURS_CNT_SEC_IN_HOUR)+(unsigned long)resurs_cnt_[i];
_0x318:
	MOV  R30,R16
	CALL SUBOPT_0x9D
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x9B
	CLR  R22
	CLR  R23
	__GETD2N 0xE10
	CALL __MULD12U
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x99
	CLR  R22
	CLR  R23
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDD12
	POP  R26
	POP  R27
	CALL __PUTDP1
;    3788 	}
	SUBI R16,-1
	RJMP _0x316
_0x317:
;    3789 }
	RJMP _0xB3F
;    3790 
;    3791 //-----------------------------------------------
;    3792 void motor_potenz_hndl(void)
;    3793 {
_motor_potenz_hndl:
;    3794 char i,temp_potenz;
;    3795 i=0;
	ST   -Y,R17
	ST   -Y,R16
;	i -> R16
;	temp_potenz -> R17
	LDI  R16,LOW(0)
;    3796 potenz=0xff;
	LDI  R30,LOW(255)
	STS  _potenz,R30
;    3797 
;    3798 if((EE_DV_NUM>=1)&&((pilot_dv!=0)||(av_fp_stat==faON))&&(dv_on[0]==dvOFF)&&(av_serv[0]==avsOFF)&&(apv_cnt[0]==0)&&(dv_access[0]==dvON))
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x1)
	BRLO _0x31B
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	SBIW R30,0
	BRNE _0x31C
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x31B
_0x31C:
	LDS  R26,_dv_on
	CPI  R26,LOW(0x81)
	BRNE _0x31B
	LDS  R26,_av_serv
	CPI  R26,LOW(0xAA)
	BRNE _0x31B
	LDS  R26,_apv_cnt
	CPI  R26,LOW(0x0)
	BRNE _0x31B
	LDS  R26,_dv_access
	CPI  R26,LOW(0xAA)
	BREQ _0x31E
_0x31B:
	RJMP _0x31A
_0x31E:
;    3799 	{
;    3800 	potenz=0;
	LDI  R30,LOW(0)
	STS  _potenz,R30
;    3801 	}
;    3802 
;    3803 if((EE_DV_NUM>=2)&&((pilot_dv!=1)||(av_fp_stat==faON))&&(dv_on[1]==dvOFF)&&(av_serv[1]==avsOFF)&&(apv_cnt[1]==0)&&(dv_access[1]==dvON)) 
_0x31A:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	BRLO _0x320
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x321
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x320
_0x321:
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x81)
	BRNE _0x320
	__GETB1MN _av_serv,1
	CPI  R30,LOW(0xAA)
	BRNE _0x320
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BRNE _0x320
	__GETB1MN _dv_access,1
	CPI  R30,LOW(0xAA)
	BREQ _0x323
_0x320:
	RJMP _0x31F
_0x323:
;    3804 	{
;    3805 	if((potenz==0xff)||(resurs_cnt__[1]<resurs_cnt__[potenz]))potenz=1;
	LDS  R26,_potenz
	CPI  R26,LOW(0xFF)
	BREQ _0x325
	__GETD1MN _resurs_cnt__,4
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x324
_0x325:
	LDI  R30,LOW(1)
	STS  _potenz,R30
;    3806 	}
_0x324:
;    3807 
;    3808 if((EE_DV_NUM>=3)&&((pilot_dv!=2)||(av_fp_stat==faON))&&(dv_on[2]==dvOFF)&&(av_serv[2]==avsOFF)&&(apv_cnt[2]==0)&&(dv_access[2]==dvON))
_0x31F:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	BRLO _0x328
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x329
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x328
_0x329:
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x81)
	BRNE _0x328
	__GETB1MN _av_serv,2
	CPI  R30,LOW(0xAA)
	BRNE _0x328
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BRNE _0x328
	__GETB1MN _dv_access,2
	CPI  R30,LOW(0xAA)
	BREQ _0x32B
_0x328:
	RJMP _0x327
_0x32B:
;    3809 	{
;    3810 	if((potenz==0xff)||(resurs_cnt__[2]<resurs_cnt__[potenz]))potenz=2;
	LDS  R26,_potenz
	CPI  R26,LOW(0xFF)
	BREQ _0x32D
	__GETD1MN _resurs_cnt__,8
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x32C
_0x32D:
	LDI  R30,LOW(2)
	STS  _potenz,R30
;    3811 	}
_0x32C:
;    3812 
;    3813 if((EE_DV_NUM>=4)&&((pilot_dv!=3)||(av_fp_stat==faON))&&(dv_on[3]==dvOFF)&&(av_serv[3]==avsOFF)&&(apv_cnt[3]==0)&&(dv_access[3]==dvON))
_0x327:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x4)
	BRLO _0x330
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x331
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x330
_0x331:
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x81)
	BRNE _0x330
	__GETB1MN _av_serv,3
	CPI  R30,LOW(0xAA)
	BRNE _0x330
	__GETB1MN _apv_cnt,3
	CPI  R30,0
	BRNE _0x330
	__GETB1MN _dv_access,3
	CPI  R30,LOW(0xAA)
	BREQ _0x333
_0x330:
	RJMP _0x32F
_0x333:
;    3814 	{
;    3815 	if((potenz==0xff)||(resurs_cnt__[3]<resurs_cnt__[potenz]))potenz=3;
	LDS  R26,_potenz
	CPI  R26,LOW(0xFF)
	BREQ _0x335
	__GETD1MN _resurs_cnt__,12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x334
_0x335:
	LDI  R30,LOW(3)
	STS  _potenz,R30
;    3816 	}
_0x334:
;    3817 
;    3818 if((EE_DV_NUM>=5)&&((pilot_dv!=4)||(av_fp_stat==faON))&&(dv_on[4]==dvOFF)&&(av_serv[4]==avsOFF)&&(apv_cnt[4]==0)&&(dv_access[4]==dvON))
_0x32F:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x5)
	BRLO _0x338
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BRNE _0x339
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x338
_0x339:
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x81)
	BRNE _0x338
	__GETB1MN _av_serv,4
	CPI  R30,LOW(0xAA)
	BRNE _0x338
	__GETB1MN _apv_cnt,4
	CPI  R30,0
	BRNE _0x338
	__GETB1MN _dv_access,4
	CPI  R30,LOW(0xAA)
	BREQ _0x33B
_0x338:
	RJMP _0x337
_0x33B:
;    3819     	{
;    3820 	if((potenz==0xff)||(resurs_cnt__[4]<resurs_cnt__[potenz]))potenz=4;
	LDS  R26,_potenz
	CPI  R26,LOW(0xFF)
	BREQ _0x33D
	__GETD1MN _resurs_cnt__,16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x33C
_0x33D:
	LDI  R30,LOW(4)
	STS  _potenz,R30
;    3821 	}
_0x33C:
;    3822 	
;    3823 if((EE_DV_NUM>=6)&&((pilot_dv!=5)||(av_fp_stat==faON))&&(dv_on[5]==dvOFF)&&(av_serv[5]==avsOFF)&&(apv_cnt[5]==0)&&(dv_access[5]==dvON))
_0x337:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x6)
	BRLO _0x340
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x341
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x340
_0x341:
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x81)
	BRNE _0x340
	__GETB1MN _av_serv,5
	CPI  R30,LOW(0xAA)
	BRNE _0x340
	__GETB1MN _apv_cnt,5
	CPI  R30,0
	BRNE _0x340
	__GETB1MN _dv_access,5
	CPI  R30,LOW(0xAA)
	BREQ _0x343
_0x340:
	RJMP _0x33F
_0x343:
;    3824     	{
;    3825 	if((potenz==0xff)||(resurs_cnt__[4]<resurs_cnt__[potenz]))potenz=5;
	LDS  R26,_potenz
	CPI  R26,LOW(0xFF)
	BREQ _0x345
	__GETD1MN _resurs_cnt__,16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x344
_0x345:
	LDI  R30,LOW(5)
	STS  _potenz,R30
;    3826 	}
_0x344:
;    3827 
;    3828 
;    3829 potenz_off=0xff;
_0x33F:
	LDI  R30,LOW(255)
	STS  _potenz_off,R30
;    3830 
;    3831 if((dv_on[0]!=dvOFF)&&(dv_on[0]!=dvFR))
	LDS  R26,_dv_on
	CPI  R26,LOW(0x81)
	BREQ _0x348
	CPI  R26,LOW(0x66)
	BRNE _0x349
_0x348:
	RJMP _0x347
_0x349:
;    3832 	{
;    3833 	potenz_off=0;
	LDI  R30,LOW(0)
	STS  _potenz_off,R30
;    3834 	}
;    3835 
;    3836 if((dv_on[1]!=dvOFF)&&(dv_on[1]!=dvFR))
_0x347:
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x81)
	BREQ _0x34B
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x66)
	BRNE _0x34C
_0x34B:
	RJMP _0x34A
_0x34C:
;    3837 	{             
;    3838 	if((potenz_off==0xff)||(resurs_cnt__[1]>resurs_cnt__[potenz_off]))potenz_off=1;
	LDS  R26,_potenz_off
	CPI  R26,LOW(0xFF)
	BREQ _0x34E
	__GETD1MN _resurs_cnt__,4
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz_off
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD12
	BRSH _0x34D
_0x34E:
	LDI  R30,LOW(1)
	STS  _potenz_off,R30
;    3839 	}
_0x34D:
;    3840 
;    3841 if((dv_on[2]!=dvOFF)&&(dv_on[2]!=dvFR))
_0x34A:
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x81)
	BREQ _0x351
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x66)
	BRNE _0x352
_0x351:
	RJMP _0x350
_0x352:
;    3842 	{             
;    3843 	if((potenz_off==0xff)||(resurs_cnt__[2]>resurs_cnt__[potenz_off]))potenz_off=2;
	LDS  R26,_potenz_off
	CPI  R26,LOW(0xFF)
	BREQ _0x354
	__GETD1MN _resurs_cnt__,8
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz_off
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD12
	BRSH _0x353
_0x354:
	LDI  R30,LOW(2)
	STS  _potenz_off,R30
;    3844 	}
_0x353:
;    3845 
;    3846 if((dv_on[3]!=dvOFF)&&(dv_on[3]!=dvFR))
_0x350:
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x81)
	BREQ _0x357
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x66)
	BRNE _0x358
_0x357:
	RJMP _0x356
_0x358:
;    3847 	{             
;    3848 	if((potenz_off==0xff)||(resurs_cnt__[3]>resurs_cnt__[potenz_off]))potenz_off=3;
	LDS  R26,_potenz_off
	CPI  R26,LOW(0xFF)
	BREQ _0x35A
	__GETD1MN _resurs_cnt__,12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz_off
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD12
	BRSH _0x359
_0x35A:
	LDI  R30,LOW(3)
	STS  _potenz_off,R30
;    3849 	}
_0x359:
;    3850                                                                                    
;    3851 if((dv_on[4]!=dvOFF)&&(dv_on[4]!=dvFR))
_0x356:
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x81)
	BREQ _0x35D
	__GETB1MN _dv_on,4
	CPI  R30,LOW(0x66)
	BRNE _0x35E
_0x35D:
	RJMP _0x35C
_0x35E:
;    3852 	{             
;    3853 	if((potenz_off==0xff)||(resurs_cnt__[4]>resurs_cnt__[potenz_off]))potenz_off=4;
	LDS  R26,_potenz_off
	CPI  R26,LOW(0xFF)
	BREQ _0x360
	__GETD1MN _resurs_cnt__,16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz_off
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD12
	BRSH _0x35F
_0x360:
	LDI  R30,LOW(4)
	STS  _potenz_off,R30
;    3854 	}
_0x35F:
;    3855 	
;    3856 if((dv_on[5]!=dvOFF)&&(dv_on[5]!=dvFR))
_0x35C:
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x81)
	BREQ _0x363
	__GETB1MN _dv_on,5
	CPI  R30,LOW(0x66)
	BRNE _0x364
_0x363:
	RJMP _0x362
_0x364:
;    3857 	{             
;    3858 	if((potenz_off==0xff)||(resurs_cnt__[5]>resurs_cnt__[potenz_off]))potenz_off=5;
	LDS  R26,_potenz_off
	CPI  R26,LOW(0xFF)
	BREQ _0x366
	__GETD1MN _resurs_cnt__,20
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_potenz_off
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD12
	BRSH _0x365
_0x366:
	LDI  R30,LOW(5)
	STS  _potenz_off,R30
;    3859 	}
_0x365:
;    3860 	
;    3861 temp_potenz=0;	
_0x362:
	LDI  R17,LOW(0)
;    3862 for(i=0;i<EE_DV_NUM;i++)
	LDI  R16,LOW(0)
_0x369:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRSH _0x36A
;    3863 	{
;    3864 	if((i<EE_DV_NUM)&&(av_serv[i]!=avsON)&&
;    3865 	   (av_i_dv_min[i]!=aviON) && (av_i_dv_max[i]!=aviON) && (av_i_dv_log[i]!=aviON) && ((pilot_dv!=i) || (av_fp_stat==faON))) 
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRSH _0x36C
	CALL SUBOPT_0x8A
	BREQ _0x36C
	CALL SUBOPT_0x9E
	BREQ _0x36C
	CALL SUBOPT_0x9F
	BREQ _0x36C
	CALL SUBOPT_0xA0
	BREQ _0x36C
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	MOVW R26,R30
	MOV  R30,R16
	LDI  R31,0
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x36D
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x36C
_0x36D:
	RJMP _0x36F
_0x36C:
	RJMP _0x36B
_0x36F:
;    3866 		{          
;    3867 		temp_potenz++;
	SUBI R17,-1
;    3868 		}
;    3869 	}	             
_0x36B:
	SUBI R16,-1
	RJMP _0x369
_0x36A:
;    3870 net_motor_potenz=temp_potenz;
	STS  _net_motor_potenz,R17
;    3871 
;    3872 temp_potenz=0;
	LDI  R17,LOW(0)
;    3873 for(i=0;i<EE_DV_NUM;i++)
	LDI  R16,LOW(0)
_0x371:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRSH _0x372
;    3874 	{
;    3875 	if((av_serv[i]!=avsON) && (av_i_dv_min[i]!=aviON) && (av_i_dv_max[i]!=aviON) && (av_i_dv_log[i]!=aviON) 
;    3876 	 && (dv_on[i]!=dvOFF) && (dv_on[i]!=dvFR)) 
	CALL SUBOPT_0x8A
	BREQ _0x374
	CALL SUBOPT_0x9E
	BREQ _0x374
	CALL SUBOPT_0x9F
	BREQ _0x374
	CALL SUBOPT_0xA0
	BREQ _0x374
	CALL SUBOPT_0x98
	BREQ _0x374
	MOV  R30,R16
	LDI  R31,0
	CALL SUBOPT_0x5B
	BRNE _0x375
_0x374:
	RJMP _0x373
_0x375:
;    3877 		{          
;    3878 		temp_potenz++;
	SUBI R17,-1
;    3879 		}
;    3880 	} 
_0x373:
	SUBI R16,-1
	RJMP _0x371
_0x372:
;    3881 net_motor_wrk=temp_potenz;
	STS  _net_motor_wrk,R17
;    3882 
;    3883 if(net_motor_potenz>net_motor_wrk)bPOTENZ_UP=1;
	LDS  R30,_net_motor_wrk
	LDS  R26,_net_motor_potenz
	CP   R30,R26
	BRSH _0x376
	SET
	BLD  R4,2
;    3884 else bPOTENZ_UP=0;
	RJMP _0x377
_0x376:
	CLT
	BLD  R4,2
_0x377:
;    3885 
;    3886 if(net_motor_wrk)bPOTENZ_DOWN=1;
	LDS  R30,_net_motor_wrk
	CPI  R30,0
	BREQ _0x378
	SET
	BLD  R4,3
;    3887 else bPOTENZ_DOWN=0;		 
	RJMP _0x379
_0x378:
	CLT
	BLD  R4,3
_0x379:
;    3888 		
;    3889 }
	RJMP _0xB3E
;    3890 
;    3891 //-----------------------------------------------
;    3892 void dv_access_hndl(void)
;    3893 {
_dv_access_hndl:
;    3894 char i;
;    3895 for(i=0;i<6;i++)
	ST   -Y,R16
;	i -> R16
	LDI  R16,LOW(0)
_0x37B:
	CPI  R16,6
	BRSH _0x37C
;    3896 	{
;    3897 	if((i<EE_DV_NUM)&&(dv_on[i]==dvOFF)&&(av_serv[i]!=avsON)&&
;    3898 	   (av_i_dv_min[i]!=aviON) && (av_i_dv_max[i]!=aviON) && (av_i_dv_log[i]!=aviON)) 
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRSH _0x37E
	CALL SUBOPT_0x98
	BRNE _0x37E
	CALL SUBOPT_0x8A
	BREQ _0x37E
	CALL SUBOPT_0x9E
	BREQ _0x37E
	CALL SUBOPT_0x9F
	BREQ _0x37E
	CALL SUBOPT_0xA0
	BRNE _0x37F
_0x37E:
	RJMP _0x37D
_0x37F:
;    3899 	   	{
;    3900 	   	dv_access[i]=dvON;
	CALL SUBOPT_0xA1
	LDI  R30,LOW(170)
	RJMP _0xB5F
;    3901 	   	}
;    3902 	else dv_access[i]=dvOFF;
_0x37D:
	CALL SUBOPT_0xA1
	LDI  R30,LOW(129)
_0xB5F:
	ST   X,R30
;    3903 	}
	SUBI R16,-1
	RJMP _0x37B
_0x37C:
;    3904 }
	RJMP _0xB3F
;    3905 
;    3906 //-----------------------------------------------
;    3907 void pilot_ch_hndl(void)
;    3908 {
_pilot_ch_hndl:
;    3909 char i;
;    3910 
;    3911 CURR_TIME=((unsigned)_hour*60U)+(unsigned)_min;
	ST   -Y,R16
;	i -> R16
	LDS  R30,__hour
	LDI  R31,0
	LDI  R26,LOW(60)
	LDI  R27,HIGH(60)
	CALL __MULW12U
	PUSH R31
	PUSH R30
	LDS  R30,__min
	LDI  R31,0
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	STS  _CURR_TIME,R30
	STS  _CURR_TIME+1,R31
;    3912 if((CURR_TIME==DVCH_TIME)&&((_sec==0)||(_sec==1)||(_sec==2)))
	LDI  R26,LOW(_DVCH_TIME)
	LDI  R27,HIGH(_DVCH_TIME)
	CALL __EEPROMRDW
	LDS  R26,_CURR_TIME
	LDS  R27,_CURR_TIME+1
	CP   R30,R26
	CPC  R31,R27
	BRNE _0x382
	LDS  R26,__sec
	CPI  R26,LOW(0x0)
	BREQ _0x383
	CPI  R26,LOW(0x1)
	BREQ _0x383
	CPI  R26,LOW(0x2)
	BRNE _0x382
_0x383:
	RJMP _0x385
_0x382:
	RJMP _0x381
_0x385:
;    3913       	{
;    3914       	bDVCH=1;
	SET
	BLD  R4,4
;    3915       	mode=mTORM;
	LDI  R30,LOW(136)
	STS  _mode,R30
;    3916       	}
;    3917 	
;    3918 if(bDVCH&&(mode==mSTOP))
_0x381:
	SBRS R4,4
	RJMP _0x387
	LDS  R26,_mode
	CPI  R26,LOW(0x0)
	BREQ _0x388
_0x387:
	RJMP _0x386
_0x388:
;    3919 	{
;    3920 //char temp;
;    3921 	dv_access_hndl();
	CALL _dv_access_hndl
;    3922 	temp_DVCH=0xff;
	LDI  R30,LOW(255)
	STS  _temp_DVCH,R30
;    3923 	
;    3924 	if((dv_access[0]==dvON)&&(fp_apv[0]!=faON)&&(pilot_dv!=0))temp_DVCH=0;
	LDS  R26,_dv_access
	CPI  R26,LOW(0xAA)
	BRNE _0x38A
	LDS  R26,_fp_apv
	CPI  R26,LOW(0x55)
	BREQ _0x38A
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	SBIW R30,0
	BRNE _0x38B
_0x38A:
	RJMP _0x389
_0x38B:
	LDI  R30,LOW(0)
	STS  _temp_DVCH,R30
;    3925 	
;    3926 	if((dv_access[1]==dvON)&&(fp_apv[1]!=faON)&&(pilot_dv!=1)&&((temp_DVCH==0xff)||(resurs_cnt__[1]<resurs_cnt__[temp_DVCH])))temp_DVCH=1;
_0x389:
	__GETB1MN _dv_access,1
	CPI  R30,LOW(0xAA)
	BRNE _0x38D
	__GETB1MN _fp_apv,1
	CPI  R30,LOW(0x55)
	BREQ _0x38D
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ _0x38D
	LDS  R26,_temp_DVCH
	CPI  R26,LOW(0xFF)
	BREQ _0x38E
	__GETD1MN _resurs_cnt__,4
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_temp_DVCH
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x38D
_0x38E:
	RJMP _0x390
_0x38D:
	RJMP _0x38C
_0x390:
	LDI  R30,LOW(1)
	STS  _temp_DVCH,R30
;    3927 	if((dv_access[2]==dvON)&&(fp_apv[2]!=faON)&&(pilot_dv!=2)&&((temp_DVCH==0xff)||(resurs_cnt__[2]<resurs_cnt__[temp_DVCH])))temp_DVCH=2;
_0x38C:
	__GETB1MN _dv_access,2
	CPI  R30,LOW(0xAA)
	BRNE _0x392
	__GETB1MN _fp_apv,2
	CPI  R30,LOW(0x55)
	BREQ _0x392
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ _0x392
	LDS  R26,_temp_DVCH
	CPI  R26,LOW(0xFF)
	BREQ _0x393
	__GETD1MN _resurs_cnt__,8
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_temp_DVCH
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x392
_0x393:
	RJMP _0x395
_0x392:
	RJMP _0x391
_0x395:
	LDI  R30,LOW(2)
	STS  _temp_DVCH,R30
;    3928 	if((dv_access[3]==dvON)&&(fp_apv[3]!=faON)&&(pilot_dv!=3)&&((temp_DVCH==0xff)||(resurs_cnt__[3]<resurs_cnt__[temp_DVCH])))temp_DVCH=3;
_0x391:
	__GETB1MN _dv_access,3
	CPI  R30,LOW(0xAA)
	BRNE _0x397
	__GETB1MN _fp_apv,3
	CPI  R30,LOW(0x55)
	BREQ _0x397
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BREQ _0x397
	LDS  R26,_temp_DVCH
	CPI  R26,LOW(0xFF)
	BREQ _0x398
	__GETD1MN _resurs_cnt__,12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_temp_DVCH
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x397
_0x398:
	RJMP _0x39A
_0x397:
	RJMP _0x396
_0x39A:
	LDI  R30,LOW(3)
	STS  _temp_DVCH,R30
;    3929 	if((dv_access[4]==dvON)&&(fp_apv[4]!=faON)&&(pilot_dv!=4)&&((temp_DVCH==0xff)||(resurs_cnt__[4]<resurs_cnt__[temp_DVCH])))temp_DVCH=4;
_0x396:
	__GETB1MN _dv_access,4
	CPI  R30,LOW(0xAA)
	BRNE _0x39C
	__GETB1MN _fp_apv,4
	CPI  R30,LOW(0x55)
	BREQ _0x39C
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ _0x39C
	LDS  R26,_temp_DVCH
	CPI  R26,LOW(0xFF)
	BREQ _0x39D
	__GETD1MN _resurs_cnt__,16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_temp_DVCH
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x39C
_0x39D:
	RJMP _0x39F
_0x39C:
	RJMP _0x39B
_0x39F:
	LDI  R30,LOW(4)
	STS  _temp_DVCH,R30
;    3930 	if((dv_access[5]==dvON)&&(fp_apv[5]!=faON)&&(pilot_dv!=5)&&((temp_DVCH==0xff)||(resurs_cnt__[5]<resurs_cnt__[temp_DVCH])))temp_DVCH=5;
_0x39B:
	__GETB1MN _dv_access,5
	CPI  R30,LOW(0xAA)
	BRNE _0x3A1
	__GETB1MN _fp_apv,5
	CPI  R30,LOW(0x55)
	BREQ _0x3A1
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BREQ _0x3A1
	LDS  R26,_temp_DVCH
	CPI  R26,LOW(0xFF)
	BREQ _0x3A2
	__GETD1MN _resurs_cnt__,20
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	LDS  R30,_temp_DVCH
	CALL SUBOPT_0x9D
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CPD21
	BRSH _0x3A1
_0x3A2:
	RJMP _0x3A4
_0x3A1:
	RJMP _0x3A0
_0x3A4:
	LDI  R30,LOW(5)
	STS  _temp_DVCH,R30
;    3931 	
;    3932 	if(temp_DVCH<EE_DV_NUM)
_0x3A0:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	LDS  R26,_temp_DVCH
	CP   R26,R30
	BRSH _0x3A5
;    3933 		{
;    3934 		pilot_dv=temp_DVCH;
	LDS  R30,_temp_DVCH
	LDI  R31,0
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMWRW
;    3935 		av_fp_cnt=0;
	LDI  R30,0
	STS  _av_fp_cnt,R30
	STS  _av_fp_cnt+1,R30
;    3936 		}
;    3937 	bDVCH=0; 
_0x3A5:
	CLT
	BLD  R4,4
;    3938 	
;    3939     //	mode=mSTART;
;    3940 	
;    3941 	}	
;    3942 }
_0x386:
_0xB3F:
	LD   R16,Y+
	RET
;    3943 
;    3944 //-----------------------------------------------
;    3945 void p_max_min_hndl(void)
;    3946 {             
_p_max_min_hndl:
;    3947 static signed avp_sec_cnt;

	.DSEG
_avp_sec_cnt_S57:
	.BYTE 0x2

	.CSEG
;    3948 if((mode==mSTOP)||(mode==mTORM))bPMIN=0;
	LDS  R26,_mode
	CPI  R26,LOW(0x0)
	BREQ _0x3A7
	CPI  R26,LOW(0x88)
	BRNE _0x3A6
_0x3A7:
	CLT
	BLD  R4,5
;    3949 else if(p>((P_MIN+G_MAXMIN)*10))bPMIN=1;
	RJMP _0x3A9
_0x3A6:
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_G_MAXMIN)
	LDI  R27,HIGH(_G_MAXMIN)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL SUBOPT_0xA2
	BRGE _0x3AA
	SET
	BLD  R4,5
;    3950 
;    3951 if(p>(P_MAX*10))
_0x3AA:
_0x3A9:
	LDI  R26,LOW(_P_MAX)
	LDI  R27,HIGH(_P_MAX)
	CALL __EEPROMRDW
	CALL SUBOPT_0xA3
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x3AB
;    3952 	{         
;    3953 	if(p_max_cnt<(T_MAXMIN*10))
	CALL SUBOPT_0xA4
	BRGE _0x3AC
;    3954 		{
;    3955 		p_max_cnt++;
	LDS  R30,_p_max_cnt
	LDS  R31,_p_max_cnt+1
	ADIW R30,1
	STS  _p_max_cnt,R30
	STS  _p_max_cnt+1,R31
;    3956 		if(p_max_cnt>=(T_MAXMIN*10))
	CALL SUBOPT_0xA4
	BRLT _0x3AD
;    3957 			{
;    3958 			//av_hndl(AVAR_P_MAX,0,0);
;    3959 			av_p_stat=avpMAX;
	LDI  R30,LOW(34)
	STS  _av_p_stat,R30
;    3960 			avp_day_cnt[3]=avp_day_cnt[2];
	__GETW1MN _avp_day_cnt,4
	__PUTW1MN _avp_day_cnt,6
;    3961 			avp_day_cnt[2]=avp_day_cnt[1];
	__GETW1MN _avp_day_cnt,2
	__PUTW1MN _avp_day_cnt,4
;    3962 			avp_day_cnt[1]=avp_day_cnt[0];
	LDS  R30,_avp_day_cnt
	LDS  R31,_avp_day_cnt+1
	__PUTW1MN _avp_day_cnt,2
;    3963 			avp_day_cnt[0]=1440;
	LDI  R30,LOW(1440)
	LDI  R31,HIGH(1440)
	STS  _avp_day_cnt,R30
	STS  _avp_day_cnt+1,R31
;    3964 			
;    3965 			if(avp_day_cnt[3])av_hndl(AVAR_P_MAX,p/10,0);
	__GETW1MN _avp_day_cnt,6
	SBIW R30,0
	BREQ _0x3AE
	LDI  R30,LOW(12)
	CALL SUBOPT_0xA5
	CALL _av_hndl
;    3966 			}
_0x3AE:
;    3967 		}
_0x3AD:
;    3968 	}
_0x3AC:
;    3969 else if(p<((P_MAX-G_MAXMIN)*10))
	RJMP _0x3AF
_0x3AB:
	LDI  R26,LOW(_P_MAX)
	LDI  R27,HIGH(_P_MAX)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_G_MAXMIN)
	LDI  R27,HIGH(_G_MAXMIN)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	SUB  R26,R30
	SBC  R27,R31
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MULW12
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3B0
;    3970 	{
;    3971 	if(p_max_cnt)p_max_cnt--;
	LDS  R30,_p_max_cnt
	LDS  R31,_p_max_cnt+1
	SBIW R30,0
	BREQ _0x3B1
	SBIW R30,1
	STS  _p_max_cnt,R30
	STS  _p_max_cnt+1,R31
;    3972 	}	
_0x3B1:
;    3973 
;    3974 if((p<(P_MIN*10))&&bPMIN)
_0x3B0:
_0x3AF:
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0xA3
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3B3
	SBRC R4,5
	RJMP _0x3B4
_0x3B3:
	RJMP _0x3B2
_0x3B4:
;    3975 	{         
;    3976 	if(p_min_cnt<(T_MAXMIN*10))
	CALL SUBOPT_0xA6
	BRGE _0x3B5
;    3977 		{
;    3978 		p_min_cnt++;
	LDS  R30,_p_min_cnt
	LDS  R31,_p_min_cnt+1
	ADIW R30,1
	STS  _p_min_cnt,R30
	STS  _p_min_cnt+1,R31
;    3979 		if(p_min_cnt>=(T_MAXMIN*10))
	CALL SUBOPT_0xA6
	BRLT _0x3B6
;    3980 			{
;    3981 			av_hndl(AVAR_P_MIN,p/10,0);
	LDI  R30,LOW(11)
	CALL SUBOPT_0xA5
	CALL _av_hndl
;    3982 			av_p_stat=avpMIN;
	LDI  R30,LOW(17)
	STS  _av_p_stat,R30
;    3983 			
;    3984 			}
;    3985 		}
_0x3B6:
;    3986 	}                 
_0x3B5:
;    3987 	
;    3988 else if(p>((P_MIN+G_MAXMIN)*10))
	RJMP _0x3B7
_0x3B2:
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_G_MAXMIN)
	LDI  R27,HIGH(_G_MAXMIN)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL SUBOPT_0xA2
	BRGE _0x3B8
;    3989 	{
;    3990 	if(p_min_cnt)p_min_cnt--;
	LDS  R30,_p_min_cnt
	LDS  R31,_p_min_cnt+1
	SBIW R30,0
	BREQ _0x3B9
	SBIW R30,1
	STS  _p_min_cnt,R30
	STS  _p_min_cnt+1,R31
;    3991 	}
_0x3B9:
;    3992 	
;    3993 		                 
;    3994 if((!p_max_cnt)&&(!p_min_cnt))av_p_stat=avpOFF;		
_0x3B8:
_0x3B7:
	LDS  R30,_p_max_cnt
	LDS  R31,_p_max_cnt+1
	SBIW R30,0
	BRNE _0x3BB
	LDS  R30,_p_min_cnt
	LDS  R31,_p_min_cnt+1
	SBIW R30,0
	BREQ _0x3BC
_0x3BB:
	RJMP _0x3BA
_0x3BC:
	LDI  R30,LOW(0)
	STS  _av_p_stat,R30
;    3995 
;    3996 avp_sec_cnt++;
_0x3BA:
	LDS  R30,_avp_sec_cnt_S57
	LDS  R31,_avp_sec_cnt_S57+1
	ADIW R30,1
	STS  _avp_sec_cnt_S57,R30
	STS  _avp_sec_cnt_S57+1,R31
;    3997 if(avp_sec_cnt>=600)
	LDS  R26,_avp_sec_cnt_S57
	LDS  R27,_avp_sec_cnt_S57+1
	CPI  R26,LOW(0x258)
	LDI  R30,HIGH(0x258)
	CPC  R27,R30
	BRLT _0x3BD
;    3998 	{
;    3999 	avp_sec_cnt=0;
	LDI  R30,0
	STS  _avp_sec_cnt_S57,R30
	STS  _avp_sec_cnt_S57+1,R30
;    4000 
;    4001 	if(avp_day_cnt[3])
	__GETW1MN _avp_day_cnt,6
	SBIW R30,0
	BREQ _0x3BE
;    4002 		{
;    4003 		avp_day_cnt[3]--;
	__POINTW2MN _avp_day_cnt,6
	CALL SUBOPT_0xA7
;    4004 		}
;    4005 	if(avp_day_cnt[2])
_0x3BE:
	__GETW1MN _avp_day_cnt,4
	SBIW R30,0
	BREQ _0x3BF
;    4006 		{
;    4007 		avp_day_cnt[2]--;
	__POINTW2MN _avp_day_cnt,4
	CALL SUBOPT_0xA7
;    4008 		}
;    4009 	if(avp_day_cnt[1])
_0x3BF:
	__GETW1MN _avp_day_cnt,2
	SBIW R30,0
	BREQ _0x3C0
;    4010 		{
;    4011 		avp_day_cnt[1]--;
	__POINTW2MN _avp_day_cnt,2
	CALL SUBOPT_0xA7
;    4012 		}
;    4013 	if(avp_day_cnt[0])
_0x3C0:
	LDS  R30,_avp_day_cnt
	LDS  R31,_avp_day_cnt+1
	SBIW R30,0
	BREQ _0x3C1
;    4014 		{
;    4015 		avp_day_cnt[0]--;
	LDI  R26,LOW(_avp_day_cnt)
	LDI  R27,HIGH(_avp_day_cnt)
	CALL SUBOPT_0xA7
;    4016 		}				
;    4017 	}
_0x3C1:
;    4018 
;    4019 
;    4020 }
_0x3BD:
	RET
;    4021 
;    4022 //-----------------------------------------------
;    4023 void cool_warm_drv(void)
;    4024 { 
_cool_warm_drv:
;    4025 signed temper;
;    4026 
;    4027 if((((adc_bank_[2]<100)||(adc_bank_[2]>800))))
	ST   -Y,R17
	ST   -Y,R16
;	temper -> R16,R17
	__GETW2MN _adc_bank_,4
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRLO _0x3C3
	__GETW2MN _adc_bank_,4
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x3C2
_0x3C3:
;    4028 	{
;    4029 	warm_st=warm_AVSENS;
	LDI  R30,LOW(187)
	STS  _warm_st,R30
;    4030 	}
;    4031 else 
	RJMP _0x3C5
_0x3C2:
;    4032 	{
;    4033 	if(TEMPER_SIGN==0)temper=t[0];
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x3C6
	__GETWRMN _t,0,16,17
;    4034 	else temper=t[1];
	RJMP _0x3C7
_0x3C6:
	__GETWRMN _t,2,16,17
_0x3C7:
;    4035 
;    4036 	if(temper<T_ON_WARM)
	LDI  R26,LOW(_T_ON_WARM)
	LDI  R27,HIGH(_T_ON_WARM)
	CALL __EEPROMRDW
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x3C8
;    4037 		{
;    4038 		t_on_warm_cnt++;
	LDS  R30,_t_on_warm_cnt
	SUBI R30,-LOW(1)
	STS  _t_on_warm_cnt,R30
;    4039 		}               
;    4040 	else if(temper>(T_ON_WARM+TEMPER_GIST))
	RJMP _0x3C9
_0x3C8:
	LDI  R26,LOW(_T_ON_WARM)
	LDI  R27,HIGH(_T_ON_WARM)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	CP   R30,R16
	CPC  R31,R17
	BRGE _0x3CA
;    4041 		{
;    4042 		t_on_warm_cnt--;
	LDS  R30,_t_on_warm_cnt
	SUBI R30,LOW(1)
	STS  _t_on_warm_cnt,R30
;    4043 		}
;    4044 	gran_char(&t_on_warm_cnt,0,50);
_0x3CA:
_0x3C9:
	LDI  R30,LOW(_t_on_warm_cnt)
	LDI  R31,HIGH(_t_on_warm_cnt)
	CALL SUBOPT_0x90
	CALL SUBOPT_0xA8
;    4045 	if(t_on_warm_cnt>45) warm_st=warm_ON;
	LDS  R26,_t_on_warm_cnt
	LDI  R30,LOW(45)
	CP   R30,R26
	BRGE _0x3CB
	LDI  R30,LOW(85)
	STS  _warm_st,R30
;    4046 	else if(t_on_warm_cnt<5) warm_st=warm_OFF;	
	RJMP _0x3CC
_0x3CB:
	LDS  R26,_t_on_warm_cnt
	CPI  R26,LOW(0x5)
	BRGE _0x3CD
	LDI  R30,LOW(170)
	STS  _warm_st,R30
;    4047      }
_0x3CD:
_0x3CC:
_0x3C5:
;    4048      
;    4049 if((((adc_bank_[2]<100)||(adc_bank_[2]>800))))
	__GETW2MN _adc_bank_,4
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRLO _0x3CF
	__GETW2MN _adc_bank_,4
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x3CE
_0x3CF:
;    4050 	{
;    4051 	cool_st=cool_AVSENS;
	LDI  R30,LOW(2)
	STS  _cool_st,R30
;    4052 	}
;    4053 else 
	RJMP _0x3D1
_0x3CE:
;    4054 	{
;    4055      if(TEMPER_SIGN==0)temper=t[0];
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x3D2
	__GETWRMN _t,0,16,17
;    4056 	else temper=t[1];
	RJMP _0x3D3
_0x3D2:
	__GETWRMN _t,2,16,17
_0x3D3:
;    4057 
;    4058 	if(temper>T_ON_COOL)
	LDI  R26,LOW(_T_ON_COOL)
	LDI  R27,HIGH(_T_ON_COOL)
	CALL __EEPROMRDW
	CP   R30,R16
	CPC  R31,R17
	BRGE _0x3D4
;    4059 		{
;    4060 		t_on_cool_cnt++;
	LDS  R30,_t_on_cool_cnt
	SUBI R30,-LOW(1)
	STS  _t_on_cool_cnt,R30
;    4061 		}               
;    4062 	else if(temper<T_ON_COOL-TEMPER_GIST)
	RJMP _0x3D5
_0x3D4:
	LDI  R26,LOW(_T_ON_COOL)
	LDI  R27,HIGH(_T_ON_COOL)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x3D6
;    4063 		{
;    4064 		t_on_cool_cnt--;
	LDS  R30,_t_on_cool_cnt
	SUBI R30,LOW(1)
	STS  _t_on_cool_cnt,R30
;    4065 		}
;    4066 	gran_char(&t_on_cool_cnt,0,50);
_0x3D6:
_0x3D5:
	LDI  R30,LOW(_t_on_cool_cnt)
	LDI  R31,HIGH(_t_on_cool_cnt)
	CALL SUBOPT_0x90
	CALL SUBOPT_0xA8
;    4067 	if(t_on_cool_cnt>45) cool_st=cool_ON;
	LDS  R26,_t_on_cool_cnt
	LDI  R30,LOW(45)
	CP   R30,R26
	BRGE _0x3D7
	LDI  R30,LOW(0)
	STS  _cool_st,R30
;    4068 	else if(t_on_cool_cnt<5) cool_st=cool_OFF;
	RJMP _0x3D8
_0x3D7:
	LDS  R26,_t_on_cool_cnt
	CPI  R26,LOW(0x5)
	BRGE _0x3D9
	LDI  R30,LOW(1)
	STS  _cool_st,R30
;    4069 	}
_0x3D9:
_0x3D8:
_0x3D1:
;    4070 }	
_0xB3E:
	LD   R16,Y+
	LD   R17,Y+
	RET
;    4071 
;    4072 //-----------------------------------------------
;    4073 void apv_start(char in)
;    4074 {
;    4075 av_id_min_cnt[in]=0;
;    4076 av_i_dv_min[in]=aviOFF;
;    4077 av_id_max_cnt[in]=0;
;    4078 av_i_dv_max[in]=aviOFF;
;    4079 av_id_not_cnt[in]=0;
;    4080 av_i_dv_not[in]=aviOFF;
;    4081 }
;    4082 //-----------------------------------------------
;    4083 void avar_i_drv(void)
;    4084 {
_avar_i_drv:
;    4085 char i;
;    4086 signed temp_SI,temp_SI1;
;    4087 signed Ia,Ic;
;    4088 
;    4089 if(DV_AV_SET==dasLOG)
	SBIW R28,4
	CALL __SAVELOCR5
;	i -> R16
;	temp_SI -> R17,R18
;	temp_SI1 -> R19,R20
;	Ia -> Y+7
;	Ic -> Y+5
	LDI  R26,LOW(_DV_AV_SET)
	LDI  R27,HIGH(_DV_AV_SET)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x3DA
;    4090 	{
;    4091 	for(i=0;i<EE_DV_NUM;i++)
	LDI  R16,LOW(0)
_0x3DC:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRSH _0x3DD
;    4092 		{
;    4093 		if(av_upp[i]==avuON)av_i_dv_log[i]=aviON;
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_upp)
	SBCI R31,HIGH(-_av_upp)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	BRNE _0x3DE
	CALL SUBOPT_0xA9
	LDI  R30,LOW(85)
	RJMP _0xB60
;    4094 		else av_i_dv_log[i]=aviOFF;
_0x3DE:
	CALL SUBOPT_0xA9
	LDI  R30,LOW(170)
_0xB60:
	ST   X,R30
;    4095 		
;    4096 		if((av_i_dv_log[i]==aviON)&&(av_i_dv_log_old[i]!=aviON))av_hndl(AVAR_I_LOG+32+(32*i),temp_SI,temp_SI1);
	CALL SUBOPT_0xA0
	BRNE _0x3E1
	CALL SUBOPT_0xAA
	LD   R30,Z
	CPI  R30,LOW(0x55)
	BRNE _0x3E2
_0x3E1:
	RJMP _0x3E0
_0x3E2:
	CALL SUBOPT_0xAB
	SUBI R30,-LOW(37)
	CALL SUBOPT_0xAC
;    4097 		av_i_dv_log_old[i]=av_i_dv_log[i];
_0x3E0:
	CALL SUBOPT_0xAA
	PUSH R31
	PUSH R30
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_i_dv_log)
	SBCI R31,HIGH(-_av_i_dv_log)
	LD   R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    4098 		}   
	SUBI R16,-1
	RJMP _0x3DC
_0x3DD:
;    4099 	}
;    4100 else
	RJMP _0x3E3
_0x3DA:
;    4101 {
;    4102 av_i_dv_log[0]=aviOFF;
	LDI  R30,LOW(170)
	STS  _av_i_dv_log,R30
;    4103 av_i_dv_log[1]=aviOFF;
	__PUTB1MN _av_i_dv_log,1
;    4104 av_i_dv_log[2]=aviOFF;
	__PUTB1MN _av_i_dv_log,2
;    4105 av_i_dv_log[3]=aviOFF;
	__PUTB1MN _av_i_dv_log,3
;    4106 
;    4107 for(i=0;i<EE_DV_NUM;i++)
	LDI  R16,LOW(0)
_0x3E5:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R16,R30
	BRLO PC+3
	JMP _0x3E6
;    4108 	{   
;    4109 	if(apv_cnt[i])
	CALL SUBOPT_0xAD
	BREQ _0x3E7
;    4110 		{
;    4111 		apv_cnt[i]--; 
	CALL SUBOPT_0xAE
	CALL SUBOPT_0xAF
;    4112 		if(!apv_cnt[i])
	CALL SUBOPT_0xAD
	BRNE _0x3E8
;    4113 			{
;    4114 		       //	apv_start(i);
;    4115 		       //	av_id_not_cnt[i]=0;
;    4116 			}  
;    4117 	  	}
_0x3E8:
;    4118 	
;    4119 	if(dv_on[i]!=dvOFF)
_0x3E7:
	CALL SUBOPT_0x98
	BRNE PC+3
	JMP _0x3E9
;    4120 		{
;    4121 
;    4122 		Ia=Ida[i];
	MOV  R30,R16
	CALL SUBOPT_0xB0
	STD  Y+7,R30
	STD  Y+7+1,R31
;    4123 		Ic=Idc[i];
	MOV  R30,R16
	CALL SUBOPT_0xB1
	STD  Y+5,R30
	STD  Y+5+1,R31
;    4124 		//Аварии по занижению токов
;    4125 		if(((Ia<Idmin)||(Ic<Idmin))&&(!apv_cnt[i])&&(!cnt_av_i_not_wrk[i]))
	MOVW R26,R28
	ADIW R26,7
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x3EB
	MOVW R26,R28
	ADIW R26,5
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3ED
_0x3EB:
	CALL SUBOPT_0xAD
	BRNE _0x3ED
	CALL SUBOPT_0xB2
	BREQ _0x3EE
_0x3ED:
	RJMP _0x3EA
_0x3EE:
;    4126 			{
;    4127 			if(av_id_min_cnt[i]<10)                    
	CALL SUBOPT_0xB3
	CPI  R30,LOW(0xA)
	BRLT PC+3
	JMP _0x3EF
;    4128 				{
;    4129 				av_id_min_cnt[i]++;
	CALL SUBOPT_0xB4
	CALL SUBOPT_0x91
;    4130 				if((av_id_min_cnt[i]>=10)&&(av_serv[i]!=avsON)&&(main_cnt>10))
	SUBI R30,LOW(-_av_id_min_cnt)
	SBCI R31,HIGH(-_av_id_min_cnt)
	LD   R30,Z
	CPI  R30,LOW(0xA)
	BRLT _0x3F1
	CALL SUBOPT_0x8A
	BREQ _0x3F1
	CALL SUBOPT_0x82
	BRLO _0x3F2
_0x3F1:
	RJMP _0x3F0
_0x3F2:
;    4131 					{                                   
;    4132 				 	if(apv[i]==apvON)
	CALL SUBOPT_0xB5
	BRNE _0x3F3
;    4133 						{
;    4134 				       		av_i_dv_min[i]=aviON;
	CALL SUBOPT_0x8B
	LDI  R30,LOW(85)
	ST   X,R30
;    4135 						temp_SI=Ia;
	__GETWRS 17,18,7
;    4136 						temp_SI1=0;
	__GETWRN 19,20,0
;    4137 						if(Ic<Ia)
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3F4
;    4138 							{
;    4139 							temp_SI=Ic;
	__GETWRS 17,18,5
;    4140 							temp_SI1=1;
	__GETWRN 19,20,1
;    4141 							}
;    4142 						av_hndl(AVAR_I_MIN+32+(32*i),temp_SI,temp_SI1);
_0x3F4:
	CALL SUBOPT_0xAB
	SUBI R30,-LOW(41)
	CALL SUBOPT_0xAC
;    4143 
;    4144 
;    4145 						}
;    4146 					else
	RJMP _0x3F5
_0x3F3:
;    4147 						{
;    4148 						apv[i]=apvON;
	CALL SUBOPT_0xB6
;    4149 						apv_cnt[i]=50;
	CALL SUBOPT_0xB7
;    4150 						plazma_i[i]=11;
	LDI  R30,LOW(11)
	ST   X,R30
;    4151 						av_id_min_cnt[i]=0;
	MOV  R26,R16
	LDI  R27,0
	CALL SUBOPT_0x8D
;    4152 						av_i_dv_min[i]=aviOFF;
	CALL SUBOPT_0x8B
	CALL SUBOPT_0x8C
;    4153 						av_id_max_cnt[i]=0;
	SUBI R26,LOW(-_av_id_max_cnt)
	SBCI R27,HIGH(-_av_id_max_cnt)
	CALL SUBOPT_0x8F
;    4154 						av_i_dv_max[i]=aviOFF;
	SUBI R26,LOW(-_av_i_dv_max)
	SBCI R27,HIGH(-_av_i_dv_max)
	CALL SUBOPT_0x8C
;    4155 						av_id_not_cnt[i]=0;
	SUBI R26,LOW(-_av_id_not_cnt)
	SBCI R27,HIGH(-_av_id_not_cnt)
	CALL SUBOPT_0x8F
;    4156 						av_i_dv_not[i]=aviOFF;
	SUBI R26,LOW(-_av_i_dv_not)
	SBCI R27,HIGH(-_av_i_dv_not)
	LDI  R30,LOW(170)
	ST   X,R30
;    4157 						}	
_0x3F5:
;    4158 					}
;    4159 				}
_0x3F0:
;    4160 			}
_0x3EF:
;    4161 		else if((Ia>=Idmin)&&(Ic>=Idmin))
	RJMP _0x3F6
_0x3EA:
	MOVW R26,R28
	ADIW R26,7
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x3F8
	MOVW R26,R28
	ADIW R26,5
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x3F9
_0x3F8:
	RJMP _0x3F7
_0x3F9:
;    4162 			{
;    4163 			if(av_id_min_cnt[i])
	CALL SUBOPT_0xB3
	CPI  R30,0
	BREQ _0x3FA
;    4164 				{
;    4165 				av_id_min_cnt[i]--;
	CALL SUBOPT_0xB4
	CALL SUBOPT_0xAF
;    4166 				if(av_id_min_cnt[i]<=0)
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_id_min_cnt)
	SBCI R31,HIGH(-_av_id_min_cnt)
	CALL SUBOPT_0x95
	BRLT _0x3FB
;    4167 					{
;    4168 					av_i_dv_min[i]=aviOFF;
	CALL SUBOPT_0x8B
	LDI  R30,LOW(170)
	ST   X,R30
;    4169 					}
;    4170 				}			
_0x3FB:
;    4171 			} 	
_0x3FA:
;    4172 		//Аварии по превышению токов
;    4173 		if(((Ia>Idmax)||(Ic>Idmax))&&(!apv_cnt[i])&&(!cnt_av_i_not_wrk[i]))
_0x3F7:
_0x3F6:
	MOVW R26,R28
	ADIW R26,7
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BRLT _0x3FD
	MOVW R26,R28
	ADIW R26,5
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x3FF
_0x3FD:
	CALL SUBOPT_0xAD
	BRNE _0x3FF
	CALL SUBOPT_0xB2
	BREQ _0x400
_0x3FF:
	RJMP _0x3FC
_0x400:
;    4174 			{
;    4175 			if(av_id_max_cnt[i]<10)
	CALL SUBOPT_0xB8
	CPI  R30,LOW(0xA)
	BRGE _0x401
;    4176 				{
;    4177 				av_id_max_cnt[i]++;
	CALL SUBOPT_0x8E
	CALL SUBOPT_0x91
;    4178 				if((av_id_max_cnt[i]>=10)&&(av_serv[i]!=avsON)&&(main_cnt>10))
	SUBI R30,LOW(-_av_id_max_cnt)
	SBCI R31,HIGH(-_av_id_max_cnt)
	LD   R30,Z
	CPI  R30,LOW(0xA)
	BRLT _0x403
	CALL SUBOPT_0x8A
	BREQ _0x403
	CALL SUBOPT_0x82
	BRLO _0x404
_0x403:
	RJMP _0x402
_0x404:
;    4179 					{
;    4180 					if(apv[i]==apvON)
	CALL SUBOPT_0xB5
	BRNE _0x405
;    4181 						{
;    4182 						temp_SI=Ia;
	__GETWRS 17,18,7
;    4183 						temp_SI1=0;
	__GETWRN 19,20,0
;    4184 						if(Ic>Ia)
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	CP   R30,R26
	CPC  R31,R27
	BRGE _0x406
;    4185 							{
;    4186 							temp_SI=Ic;
	__GETWRS 17,18,5
;    4187 							temp_SI1=1;
	__GETWRN 19,20,1
;    4188 							}
;    4189 						av_i_dv_max[i]=aviON;
_0x406:
	CALL SUBOPT_0xB9
	LDI  R30,LOW(85)
	ST   X,R30
;    4190 						av_hndl(AVAR_I_MAX+32+(32*i),temp_SI,temp_SI1);
	CALL SUBOPT_0xAB
	SUBI R30,-LOW(34)
	CALL SUBOPT_0xAC
;    4191 						}
;    4192 					else
	RJMP _0x407
_0x405:
;    4193 						{
;    4194 						apv[i]=apvON;
	CALL SUBOPT_0xB6
;    4195 						apv_cnt[i]=50;
	CALL SUBOPT_0xB7
;    4196 						plazma_i[i]=22;
	LDI  R30,LOW(22)
	ST   X,R30
;    4197 						}						
_0x407:
;    4198 					}
;    4199 				}
_0x402:
;    4200 			}
_0x401:
;    4201 		else if((Ia<Idmax)&&(Ic<Idmax))
	RJMP _0x408
_0x3FC:
	MOVW R26,R28
	ADIW R26,7
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRGE _0x40A
	MOVW R26,R28
	ADIW R26,5
	CALL __GETW1P
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CP   R26,R30
	CPC  R27,R31
	BRLT _0x40B
_0x40A:
	RJMP _0x409
_0x40B:
;    4202 			{
;    4203 			if(av_id_max_cnt[i])
	CALL SUBOPT_0xB8
	CPI  R30,0
	BREQ _0x40C
;    4204 				{
;    4205 				av_id_max_cnt[i]--;
	CALL SUBOPT_0x8E
	CALL SUBOPT_0xAF
;    4206 				if(av_id_max_cnt[i]<=0)
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_id_max_cnt)
	SBCI R31,HIGH(-_av_id_max_cnt)
	CALL SUBOPT_0x95
	BRLT _0x40D
;    4207 					{
;    4208 					av_i_dv_max[i]=aviOFF;
	CALL SUBOPT_0xB9
	LDI  R30,LOW(170)
	ST   X,R30
;    4209 					}
;    4210 				}			
_0x40D:
;    4211 			} 	
_0x40C:
;    4212 		//Аварии по перкосу токов
;    4213 /*		temp_SI=Ia-Ic;
;    4214 		temp_SI=abs(temp_SI);
;    4215 		temp_SI1=Ia;
;    4216 		if(Ic>temp_SI1)temp_SI1=Ic;
;    4217 		temp_SI=(temp_SI*100)/temp_SI1;
;    4218 		if((temp_SI>20)&&(!apv_cnt[i])&&(!cnt_av_i_not_wrk[i]))
;    4219 			{
;    4220 			if(av_id_per_cnt[i]<10)
;    4221 				{
;    4222 				av_id_per_cnt[i]++;
;    4223 				if((av_id_per_cnt[i]>=10)&&(av_serv[i]!=avsON)&&(main_cnt>10))
;    4224 					{
;    4225 					if(apv[i]==apvON)
;    4226 						{
;    4227 						av_i_dv_per[i]=aviON;
;    4228 						if(i==0)av_hndl(AV_I_PER_0,0,0);
;    4229 						if(i==1)av_hndl(AV_I_PER_1,0,0);
;    4230 						if(i==2)av_hndl(AV_I_PER_2,0,0);
;    4231 						if(i==3)av_hndl(AV_I_PER_3,0,0);
;    4232 						if(i==4)av_hndl(AV_I_PER_4,0,0);
;    4233 						if(i==5)av_hndl(AV_I_PER_5,0,0);
;    4234 						}
;    4235 					else
;    4236 						{
;    4237 						apv[i]=apvON;
;    4238 						apv_cnt[i]=50;
;    4239 						plazma_i[i]=33;
;    4240 						}						
;    4241 					}
;    4242 				}
;    4243 			}
;    4244 		else if(temp_SI<20)
;    4245 			{
;    4246 			if(av_id_per_cnt[i])
;    4247 				{
;    4248 				av_id_per_cnt[i]--;
;    4249 				if(av_id_per_cnt[i]<=0)
;    4250 					{
;    4251 					av_i_dv_per[i]=aviOFF;
;    4252 					}
;    4253 				}			
;    4254 			} */				
;    4255 		}		
_0x409:
_0x408:
;    4256 	}
_0x3E9:
	SUBI R16,-1
	RJMP _0x3E5
_0x3E6:
;    4257 	
;    4258 
;    4259 for(i=0;i<6;i++)
	LDI  R16,LOW(0)
_0x40F:
	CPI  R16,6
	BRSH _0x410
;    4260 	{
;    4261 	if((dv_on[i]==dvOFF)||(apv_cnt[i]))cnt_av_i_not_wrk[i]=20;
	CALL SUBOPT_0x98
	BREQ _0x412
	CALL SUBOPT_0xAD
	BREQ _0x411
_0x412:
	CALL SUBOPT_0xBA
	LDI  R30,LOW(20)
	ST   X,R30
;    4262 	else if(cnt_av_i_not_wrk[i])cnt_av_i_not_wrk[i]--;
	RJMP _0x414
_0x411:
	CALL SUBOPT_0xB2
	BREQ _0x415
	CALL SUBOPT_0xBA
	CALL SUBOPT_0xAF
;    4263 	} 
_0x415:
_0x414:
	SUBI R16,-1
	RJMP _0x40F
_0x410:
;    4264 	
;    4265 for(i=0;i<6;i++)
	LDI  R16,LOW(0)
_0x417:
	CPI  R16,6
	BRSH _0x418
;    4266 	{
;    4267 	if((dv_on[i]!=dvOFF)&&(!apv_cnt[i])&&(av_id_min_cnt[i]<2)/*&&(av_id_per_cnt[i]<2)&&(av_id_per_cnt[i]<2)*/)
	CALL SUBOPT_0x98
	BREQ _0x41A
	CALL SUBOPT_0xAD
	BRNE _0x41A
	CALL SUBOPT_0xB3
	CPI  R30,LOW(0x2)
	BRLT _0x41B
_0x41A:
	RJMP _0x419
_0x41B:
;    4268 		{
;    4269 	     if(av_id_not_cnt[i]<50)
	MOV  R30,R16
	LDI  R31,0
	CALL SUBOPT_0xBB
	BRGE _0x41C
;    4270 	     	{
;    4271 	     	av_id_not_cnt[i]++;
	CALL SUBOPT_0xBC
	CALL SUBOPT_0x91
;    4272 	     	if(av_id_not_cnt[i]>=50)
	CALL SUBOPT_0xBB
	BRLT _0x41D
;    4273 	     		{
;    4274 	     		apv_cnt[i]=0;
	CALL SUBOPT_0xAE
	CALL SUBOPT_0x8F
;    4275 	     		apv[i]=apvOFF;
	SUBI R26,LOW(-_apv)
	SBCI R27,HIGH(-_apv)
	CALL SUBOPT_0x8C
;    4276 	     		plazma_i[i]=44;
	SUBI R26,LOW(-_plazma_i)
	SBCI R27,HIGH(-_plazma_i)
	LDI  R30,LOW(44)
	ST   X,R30
;    4277 	     		}
;    4278 	     	}
_0x41D:
;    4279 	     }    
_0x41C:
;    4280 	else av_id_not_cnt[i]=0;     
	RJMP _0x41E
_0x419:
	CALL SUBOPT_0xBC
	LDI  R30,LOW(0)
	ST   X,R30
_0x41E:
;    4281 	}  
	SUBI R16,-1
	RJMP _0x417
_0x418:
;    4282 
;    4283 }
_0x3E3:
;    4284 				
;    4285 }
	CALL __LOADLOCR5
	ADIW R28,9
	RET
;    4286 
;    4287 
;    4288 //-----------------------------------------------
;    4289 void avar_drv(void)
;    4290 {
_avar_drv:
;    4291 
;    4292 char i;
;    4293 signed temp_S,temp_S1;
;    4294 char temp;
;    4295 
;    4296 if((((adc_bank_[2]<100)||(adc_bank_[2]>800))))
	CALL __SAVELOCR6
;	i -> R16
;	temp_S -> R17,R18
;	temp_S1 -> R19,R20
;	temp -> R21
	__GETW2MN _adc_bank_,4
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRLO _0x420
	__GETW2MN _adc_bank_,4
	LDI  R30,LOW(800)
	LDI  R31,HIGH(800)
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x41F
_0x420:
;    4297 	{
;    4298 	av_temper_st=av_temper_AVSENS;
	LDI  R30,LOW(187)
	STS  _av_temper_st,R30
;    4299 	}
;    4300 else 
	RJMP _0x422
_0x41F:
;    4301 	{
;    4302 	if(TEMPER_SIGN==0)temp_S=t[0];
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x423
	__GETWRMN _t,0,17,18
;    4303 	else temp_S=t[1];
	RJMP _0x424
_0x423:
	__GETWRMN _t,2,17,18
_0x424:
;    4304 	}	
_0x422:
;    4305 
;    4306 if(temp_S<AV_TEMPER_COOL)
	LDI  R26,LOW(_AV_TEMPER_COOL)
	LDI  R27,HIGH(_AV_TEMPER_COOL)
	CALL __EEPROMRDW
	CP   R17,R30
	CPC  R18,R31
	BRGE _0x425
;    4307 	{
;    4308 	if(av_temper_cool_cnt<50)
	LDS  R26,_av_temper_cool_cnt
	CPI  R26,LOW(0x32)
	BRSH _0x426
;    4309 		{
;    4310 		av_temper_cool_cnt++;
	LDS  R30,_av_temper_cool_cnt
	SUBI R30,-LOW(1)
	STS  _av_temper_cool_cnt,R30
;    4311 		if((av_temper_cool_cnt==50)&&(main_cnt>10))
	LDS  R26,_av_temper_cool_cnt
	CPI  R26,LOW(0x32)
	BRNE _0x428
	CALL SUBOPT_0x82
	BRLO _0x429
_0x428:
	RJMP _0x427
_0x429:
;    4312 			{
;    4313 			av_temper_st=av_temper_COOL;
	LDI  R30,LOW(153)
	STS  _av_temper_st,R30
;    4314 			av_hndl(AVAR_COOL,0,temp_S);
	LDI  R30,LOW(8)
	CALL SUBOPT_0xBD
;    4315 			}
;    4316 		}
_0x427:
;    4317 	
;    4318 	}
_0x426:
;    4319 else if(temp_S>(AV_TEMPER_COOL+TEMPER_GIST))
	RJMP _0x42A
_0x425:
	LDI  R26,LOW(_AV_TEMPER_COOL)
	LDI  R27,HIGH(_AV_TEMPER_COOL)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x42B
;    4320 	{
;    4321 	if(av_temper_cool_cnt)
	LDS  R30,_av_temper_cool_cnt
	CPI  R30,0
	BREQ _0x42C
;    4322 		{
;    4323 		av_temper_cool_cnt--;
	SUBI R30,LOW(1)
	STS  _av_temper_cool_cnt,R30
;    4324 		if((av_temper_cool_cnt==0)&&(av_temper_heat_cnt==0))
	LDS  R26,_av_temper_cool_cnt
	CPI  R26,LOW(0x0)
	BRNE _0x42E
	LDS  R26,_av_temper_heat_cnt
	CPI  R26,LOW(0x0)
	BREQ _0x42F
_0x42E:
	RJMP _0x42D
_0x42F:
;    4325 			{
;    4326 			av_temper_st=av_temper_NORM;
	LDI  R30,LOW(170)
	STS  _av_temper_st,R30
;    4327 			}
;    4328 		}
_0x42D:
;    4329 	} 
_0x42C:
;    4330 
;    4331 if(temp_S>AV_TEMPER_HEAT)
_0x42B:
_0x42A:
	LDI  R26,LOW(_AV_TEMPER_HEAT)
	LDI  R27,HIGH(_AV_TEMPER_HEAT)
	CALL __EEPROMRDW
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x430
;    4332 	{
;    4333 	if(av_temper_heat_cnt<50)
	LDS  R26,_av_temper_heat_cnt
	CPI  R26,LOW(0x32)
	BRSH _0x431
;    4334 		{
;    4335 		av_temper_heat_cnt++;
	LDS  R30,_av_temper_heat_cnt
	SUBI R30,-LOW(1)
	STS  _av_temper_heat_cnt,R30
;    4336 		if((av_temper_heat_cnt==50)&&(main_cnt>10))
	LDS  R26,_av_temper_heat_cnt
	CPI  R26,LOW(0x32)
	BRNE _0x433
	CALL SUBOPT_0x82
	BRLO _0x434
_0x433:
	RJMP _0x432
_0x434:
;    4337 			{
;    4338 			av_temper_st=av_temper_HEAT;
	LDI  R30,LOW(136)
	STS  _av_temper_st,R30
;    4339 			av_hndl(AVAR_HEAT,0,temp_S);
	LDI  R30,LOW(7)
	CALL SUBOPT_0xBD
;    4340 			}
;    4341 		}
_0x432:
;    4342 	
;    4343 	}
_0x431:
;    4344 else if(temp_S<(AV_TEMPER_HEAT-TEMPER_GIST))
	RJMP _0x435
_0x430:
	LDI  R26,LOW(_AV_TEMPER_HEAT)
	LDI  R27,HIGH(_AV_TEMPER_HEAT)
	CALL __EEPROMRDW
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CP   R17,R30
	CPC  R18,R31
	BRGE _0x436
;    4345 	{
;    4346 	if(av_temper_heat_cnt)
	LDS  R30,_av_temper_heat_cnt
	CPI  R30,0
	BREQ _0x437
;    4347 		{
;    4348 		av_temper_heat_cnt--;
	SUBI R30,LOW(1)
	STS  _av_temper_heat_cnt,R30
;    4349 		if((av_temper_heat_cnt==0)&&(av_temper_cool_cnt==0))
	LDS  R26,_av_temper_heat_cnt
	CPI  R26,LOW(0x0)
	BRNE _0x439
	LDS  R26,_av_temper_cool_cnt
	CPI  R26,LOW(0x0)
	BREQ _0x43A
_0x439:
	RJMP _0x438
_0x43A:
;    4350 			{
;    4351 			av_temper_st=av_temper_NORM;
	LDI  R30,LOW(170)
	STS  _av_temper_st,R30
;    4352 			}
;    4353 		}
_0x438:
;    4354 	} 
_0x437:
;    4355 
;    4356 temp_S=220-((220*AV_NET_PERCENT)/100);
_0x436:
_0x435:
	CALL SUBOPT_0xBE
	LDI  R26,LOW(220)
	LDI  R27,HIGH(220)
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	__PUTW1R 17,18
;    4357 temp_S1=220+((220*AV_NET_PERCENT)/100);
	CALL SUBOPT_0xBE
	SUBI R30,LOW(-220)
	SBCI R31,HIGH(-220)
	__PUTW1R 19,20
;    4358 
;    4359 
;    4360 if(cher_cnt>45)
	LDS  R26,_cher_cnt
	LDI  R30,LOW(45)
	CP   R30,R26
	BRSH _0x43B
;    4361 	{
;    4362 	if(net_fase!=nfABC)net_fase=nfABC;
	LDS  R26,_net_fase
	CPI  R26,LOW(0x55)
	BREQ _0x43C
	LDI  R30,LOW(85)
	STS  _net_fase,R30
;    4363 	}
_0x43C:
;    4364 else if(cher_cnt<5)
	RJMP _0x43D
_0x43B:
	LDS  R26,_cher_cnt
	CPI  R26,LOW(0x5)
	BRSH _0x43E
;    4365 	{
;    4366 	if(net_fase!=nfACB)net_fase=nfACB;
	LDS  R26,_net_fase
	CPI  R26,LOW(0xAA)
	BREQ _0x43F
	LDI  R30,LOW(170)
	STS  _net_fase,R30
;    4367 	} 
_0x43F:
;    4368 	
;    4369 if((((fasing==f_ABC)&&(net_fase==nfACB))||((fasing==f_ACB)&&(net_fase==nfABC)))&&(m8_main_cnt>=30)&&(main_cnt<10))
_0x43E:
_0x43D:
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x441
	LDS  R26,_net_fase
	CPI  R26,LOW(0xAA)
	BREQ _0x443
_0x441:
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x444
	LDS  R26,_net_fase
	CPI  R26,LOW(0x55)
	BREQ _0x443
_0x444:
	RJMP _0x447
_0x443:
	LDS  R26,_m8_main_cnt
	CPI  R26,LOW(0x1E)
	BRLO _0x447
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRLO _0x448
_0x447:
	RJMP _0x440
_0x448:
;    4370 	{
;    4371 	if(av_st_unet_cher!=asuc_AV)
	LDS  R26,_av_st_unet_cher
	CPI  R26,LOW(0x55)
	BREQ _0x449
;    4372 		{
;    4373 		av_st_unet_cher=asuc_AV;
	LDI  R30,LOW(85)
	STS  _av_st_unet_cher,R30
;    4374 		av_hndl(AVAR_CHER,0,0);
	LDI  R30,LOW(6)
	CALL SUBOPT_0x5A
	CALL _av_hndl
;    4375 		}
;    4376 	}
_0x449:
;    4377 else if((((fasing==f_ABC)&&(net_fase==nfABC))||((fasing==f_ACB)&&(net_fase==nfACB)))&&(m8_main_cnt>=30))
	RJMP _0x44A
_0x440:
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x44C
	LDS  R26,_net_fase
	CPI  R26,LOW(0x55)
	BREQ _0x44E
_0x44C:
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x44F
	LDS  R26,_net_fase
	CPI  R26,LOW(0xAA)
	BREQ _0x44E
_0x44F:
	RJMP _0x452
_0x44E:
	LDS  R26,_m8_main_cnt
	CPI  R26,LOW(0x1E)
	BRSH _0x453
_0x452:
	RJMP _0x44B
_0x453:
;    4378 	{
;    4379 	av_st_unet_cher=asuc_NORM;
	LDI  R30,LOW(170)
	STS  _av_st_unet_cher,R30
;    4380 	}	
;    4381 
;    4382 for(i=0;i<3;i++)
_0x44B:
_0x44A:
	LDI  R16,LOW(0)
_0x455:
	CPI  R16,3
	BRLO PC+3
	JMP _0x456
;    4383 	{
;    4384 	if((unet[i]<temp_S)&&(main_cnt>10)&&(m8_main_cnt>=30))
	CALL SUBOPT_0xBF
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x458
	CALL SUBOPT_0x82
	BRSH _0x458
	LDS  R26,_m8_main_cnt
	CPI  R26,LOW(0x1E)
	BRSH _0x459
_0x458:
	RJMP _0x457
_0x459:
;    4385 		{
;    4386 		if(unet_min_cnt[i]<50)
	CALL SUBOPT_0xC0
	LD   R30,Z
	CPI  R30,LOW(0x32)
	BRSH _0x45A
;    4387 			{
;    4388 			unet_min_cnt[i]+=10;
	CALL SUBOPT_0xC0
	PUSH R31
	PUSH R30
	LD   R30,Z
	SUBI R30,-LOW(10)
	POP  R26
	POP  R27
	ST   X,R30
;    4389 			if((unet_min_cnt[i]>=50)&&(main_cnt>10))
	CALL SUBOPT_0xC0
	LD   R30,Z
	CPI  R30,LOW(0x32)
	BRLO _0x45C
	CALL SUBOPT_0x82
	BRLO _0x45D
_0x45C:
	RJMP _0x45B
_0x45D:
;    4390 				{
;    4391 				unet_st[i]=unet_st_MIN;
	CALL SUBOPT_0xC1
	LDI  R30,LOW(1)
	ST   X,R30
;    4392 				if(i==0)av_hndl(AVAR_UNET,0,0);
	CPI  R16,0
	BRNE _0x45E
	LDI  R30,LOW(4)
	CALL SUBOPT_0x5A
	CALL _av_hndl
;    4393 				else if(i==1)av_hndl(AVAR_UNET,1,0);
	RJMP _0x45F
_0x45E:
	CPI  R16,1
	BRNE _0x460
	CALL SUBOPT_0xC2
	CALL SUBOPT_0x4C
	CALL _av_hndl
;    4394 				else if(i==2)av_hndl(AVAR_UNET,2,0);
	RJMP _0x461
_0x460:
	CPI  R16,2
	BRNE _0x462
	CALL SUBOPT_0xC3
	CALL SUBOPT_0x4C
	CALL _av_hndl
;    4395 				}
_0x462:
_0x461:
_0x45F:
;    4396 		     }
_0x45B:
;    4397 		}
_0x45A:
;    4398 	else 
	RJMP _0x463
_0x457:
;    4399 		{
;    4400 		if(unet_min_cnt[i])
	CALL SUBOPT_0xC0
	LD   R30,Z
	CPI  R30,0
	BREQ _0x464
;    4401 			{
;    4402 			unet_min_cnt[i]--;
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_unet_min_cnt)
	SBCI R27,HIGH(-_unet_min_cnt)
	CALL SUBOPT_0xAF
;    4403 		     }
;    4404 		}     			
_0x464:
_0x463:
;    4405 
;    4406 	if((unet[i]>temp_S1)&&(main_cnt>10)&&(m8_main_cnt>=30))
	CALL SUBOPT_0xBF
	CP   R19,R30
	CPC  R20,R31
	BRGE _0x466
	CALL SUBOPT_0x82
	BRSH _0x466
	LDS  R26,_m8_main_cnt
	CPI  R26,LOW(0x1E)
	BRSH _0x467
_0x466:
	RJMP _0x465
_0x467:
;    4407 		{
;    4408 		if(unet_max_cnt[i]<50)
	CALL SUBOPT_0xC4
	LD   R30,Z
	CPI  R30,LOW(0x32)
	BRSH _0x468
;    4409 			{
;    4410 			unet_max_cnt[i]+=10;
	CALL SUBOPT_0xC4
	PUSH R31
	PUSH R30
	LD   R30,Z
	SUBI R30,-LOW(10)
	POP  R26
	POP  R27
	ST   X,R30
;    4411 			if((unet_max_cnt[i]>=50)&&(main_cnt>10))
	CALL SUBOPT_0xC4
	LD   R30,Z
	CPI  R30,LOW(0x32)
	BRLO _0x46A
	CALL SUBOPT_0x82
	BRLO _0x46B
_0x46A:
	RJMP _0x469
_0x46B:
;    4412 				{
;    4413 				unet_st[i]=unet_st_MAX;
	CALL SUBOPT_0xC1
	LDI  R30,LOW(2)
	ST   X,R30
;    4414 				if(i==0)av_hndl(AVAR_UNET,0,1);
	CPI  R16,0
	BRNE _0x46C
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL SUBOPT_0xC5
;    4415 				else if(i==1)av_hndl(AVAR_UNET,1,1);
	RJMP _0x46D
_0x46C:
	CPI  R16,1
	BRNE _0x46E
	CALL SUBOPT_0xC2
	CALL SUBOPT_0xC5
;    4416 				else if(i==2)av_hndl(AVAR_UNET,2,1);				
	RJMP _0x46F
_0x46E:
	CPI  R16,2
	BRNE _0x470
	CALL SUBOPT_0xC3
	CALL SUBOPT_0xC5
;    4417 				}
_0x470:
_0x46F:
_0x46D:
;    4418 		     }
_0x469:
;    4419 		}
_0x468:
;    4420 	else 
	RJMP _0x471
_0x465:
;    4421 		{
;    4422 		if(unet_max_cnt[i])
	CALL SUBOPT_0xC4
	LD   R30,Z
	CPI  R30,0
	BREQ _0x472
;    4423 			{
;    4424 			unet_max_cnt[i]--;
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_unet_max_cnt)
	SBCI R27,HIGH(-_unet_max_cnt)
	CALL SUBOPT_0xAF
;    4425 		     }
;    4426 		}
_0x472:
_0x471:
;    4427 	if((unet_max_cnt[i]==0)&&(unet_min_cnt[i]==0))unet_st[i]=unet_st_NORM;	  
	CALL SUBOPT_0xC4
	LD   R30,Z
	CPI  R30,0
	BRNE _0x474
	CALL SUBOPT_0xC0
	LD   R30,Z
	CPI  R30,0
	BREQ _0x475
_0x474:
	RJMP _0x473
_0x475:
	CALL SUBOPT_0xC1
	LDI  R30,LOW(0)
	ST   X,R30
;    4428      }
_0x473:
	SUBI R16,-1
	RJMP _0x455
_0x456:
;    4429 /*
;    4430 if((adc_bank_[13]<100)||(adc_bank_[13]>800))t_air_st[0]=tAVSENS;
;    4431 else if(t[0]<T_AV_MIN[0])t_air_st[0]=tCOOL;
;    4432 else if((t[0]>=(T_AV_MIN[0]+5))&&(t[0]<=(T_AV_MAX[0]-5)))t_air_st[0]=tNORM;
;    4433 else if(t[0]>T_AV_MAX[0])t_air_st[0]=tHEAT;
;    4434 
;    4435 if(t[0]>=T_ON_COOL[0])cool_st[0]=cool_ON;
;    4436 else if(t[0]<=(T_ON_COOL[0]-5))cool_st[0]=cool_OFF; 
;    4437                                                 
;    4438 if(t[0]<=T_ON_HEAT[0])heat_st[0]=heat_ON;
;    4439 else if(t[0]>(T_ON_HEAT[0]+5))heat_st[0]=heat_OFF;
;    4440 
;    4441 if(((unet[0]>UNET_MIN)&&(unet[0]<UNET_MAX))&&((unet[1]>UNET_MIN)&&(unet[1]<UNET_MAX))&&((unet[1]>UNET_MIN)&&(unet[1]<UNET_MAX)))
;    4442 	{
;    4443 	if(unet_avar_cnt)unet_avar_cnt--;
;    4444 	}
;    4445 else
;    4446 	{
;    4447 	if(unet_avar_cnt<10) unet_avar_cnt++;
;    4448 	}
;    4449 
;    4450 gran_char(&unet_avar_cnt,0,10);            
;    4451 
;    4452 if(unet_avar_cnt>=10)av_st_unet=asu_ON;
;    4453 else if(unet_avar_cnt<=0) av_st_unet=asu_OFF;
;    4454 
;    4455 for(i=0;i<4;i++)
;    4456 	{
;    4457 	if(log_in_ch_cnt[PTR_IN_UPP[i]]>=50) av_upp[i]=avuON;
;    4458 	else if(log_in_ch_cnt[PTR_IN_UPP[i]]<=0) av_upp[i]=avuOFF;
;    4459 
;    4460 	if(log_in_ch_cnt[PTR_IN_SERV[i]]>=20) av_serv[i]=avsON;
;    4461 	else if(log_in_ch_cnt[PTR_IN_SERV[i]]<=0) av_serv[i]=avsOFF;
;    4462 
;    4463 	temp_S=adc_bank_[PTR_IN_TEMPER[i]];
;    4464 	if(temp_S>680)
;    4465 		{
;    4466 		cnt_avtHH[i]++;
;    4467 		cnt_avtKZ[i]=0;
;    4468 		cnt_avtON[i]=0;
;    4469 		cnt_avtOFF[i]=0;
;    4470 		gran_char(&cnt_avtHH[i],0,50);
;    4471 		if(cnt_avtHH[i]>=50) av_temper[i]=avtHH;
;    4472 		}
;    4473 	else if(temp_S<15)
;    4474 		{
;    4475 		cnt_avtHH[i]=0;
;    4476 		cnt_avtKZ[i]++;
;    4477 		cnt_avtON[i]=0;
;    4478 		cnt_avtOFF[i]=0;
;    4479 		gran_char(&cnt_avtKZ[i],0,50);
;    4480 		if(cnt_avtKZ[i]>=50) av_temper[i]=avtKZ;
;    4481 		}
;    4482 	else if(temp_S>195)
;    4483 		{
;    4484 		cnt_avtHH[i]=0;
;    4485 		cnt_avtKZ[i]=0;
;    4486 		cnt_avtON[i]++;
;    4487 		cnt_avtOFF[i]=0;
;    4488 		gran_char(&cnt_avtON[i],0,50);
;    4489 		if(cnt_avtON[i]>=50) av_temper[i]=avtON;
;    4490 		}
;    4491 	else if(temp_S<145)
;    4492 		{
;    4493 		cnt_avtHH[i]=0;
;    4494 		cnt_avtKZ[i]=0;
;    4495 		cnt_avtON[i]=0;
;    4496 		cnt_avtOFF[i]++;
;    4497 		gran_char(&cnt_avtOFF[i],0,50);
;    4498 		if(cnt_avtOFF[i]>=50) av_temper[i]=avtOFF;
;    4499 		}
;    4500 	
;    4501 	temp_S=adc_bank_[PTR_IN_VL[i]];
;    4502 	if(temp_S>680)
;    4503 		{
;    4504 		cnt_avvHH[i]++;
;    4505 		cnt_avvKZ[i]=0;
;    4506 		cnt_avvON[i]=0;
;    4507 		cnt_avvOFF[i]=0;
;    4508 		gran_char(&cnt_avvHH[i],0,50);
;    4509 		if(cnt_avvHH[i]>=50) av_vl[i]=avvHH;
;    4510 		}
;    4511 	else if(temp_S<20)
;    4512 		{
;    4513 		cnt_avvHH[i]=0;
;    4514 		cnt_avvKZ[i]++;
;    4515 		cnt_avvON[i]=0;
;    4516 		cnt_avvOFF[i]=0;
;    4517 		gran_char(&cnt_avvKZ[i],0,50);
;    4518 		if(cnt_avvKZ[i]>=50) av_vl[i]=avvKZ;
;    4519 		}
;    4520 	else if(temp_S<510)
;    4521 		{
;    4522 		cnt_avvHH[i]=0;
;    4523 		cnt_avvKZ[i]=0;
;    4524 		cnt_avvON[i]++;
;    4525 		cnt_avvOFF[i]=0;
;    4526 		gran_char(&cnt_avvON[i],0,50);
;    4527 		if(cnt_avvON[i]>=50) av_vl[i]=avvON;
;    4528 		}
;    4529 	} 
;    4530 	 */
;    4531 
;    4532 if(main_cnt<10)comm_av_st=cast_OFF;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRSH _0x476
	LDI  R30,LOW(170)
	STS  _comm_av_st,R30
;    4533 else
	RJMP _0x477
_0x476:
;    4534 	{
;    4535 	if((unet_st[0]!=unet_st_NORM)||(unet_st[1]!=unet_st_NORM)||(unet_st[2]!=unet_st_NORM)||(av_st_unet_cher!=asuc_NORM)
;    4536 	||(av_temper_st!=av_temper_NORM)||(hh_av==avON) || ((av_p_stat==avpMAX)&&(av_sens_p_stat!=aspON)))
	LDS  R26,_unet_st
	CPI  R26,LOW(0x0)
	BRNE _0x479
	__GETB1MN _unet_st,1
	CPI  R30,0
	BRNE _0x479
	__GETB1MN _unet_st,2
	CPI  R30,0
	BRNE _0x479
	LDS  R26,_av_st_unet_cher
	CPI  R26,LOW(0xAA)
	BRNE _0x479
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0xAA)
	BRNE _0x479
	LDS  R26,_hh_av
	CPI  R26,LOW(0x55)
	BREQ _0x479
	LDS  R26,_av_p_stat
	CPI  R26,LOW(0x22)
	BRNE _0x47A
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0x55)
	BRNE _0x479
_0x47A:
	RJMP _0x478
_0x479:
;    4537 		{
;    4538 		comm_av_st=cast_ON2;
	LDI  R30,LOW(105)
	STS  _comm_av_st,R30
;    4539 		}
;    4540 	else if(((EE_DV_NUM>=1)&&(av_serv[0]==avsOFF)&&((av_i_dv_min[0]!=aviOFF)||(av_i_dv_max[0]!=aviOFF)||(av_i_dv_log[0]!=aviOFF))) 
	RJMP _0x47D
_0x478:
;    4541 		||((EE_DV_NUM>=2)&&(av_serv[1]==avsOFF)&&((av_i_dv_min[1]!=aviOFF)||(av_i_dv_max[1]!=aviOFF)||(av_i_dv_log[1]!=aviOFF)))
;    4542 		||((EE_DV_NUM>=3)&&(av_serv[2]==avsOFF)&&((av_i_dv_min[2]!=aviOFF)||(av_i_dv_max[2]!=aviOFF)||(av_i_dv_log[2]!=aviOFF)))
;    4543 		||((EE_DV_NUM>=4)&&(av_serv[3]==avsOFF)&&((av_i_dv_min[3]!=aviOFF)||(av_i_dv_max[3]!=aviOFF)||(av_i_dv_log[3]!=aviOFF)))
;    4544 		|| (av_p_stat==avpMIN)
;    4545 		|| (av_sens_p_stat==aspON)
;    4546 		)
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x1)
	BRLO _0x47F
	LDS  R26,_av_serv
	CPI  R26,LOW(0xAA)
	BRNE _0x47F
	LDS  R26,_av_i_dv_min
	CPI  R26,LOW(0xAA)
	BRNE _0x480
	LDS  R26,_av_i_dv_max
	CPI  R26,LOW(0xAA)
	BRNE _0x480
	LDS  R26,_av_i_dv_log
	CPI  R26,LOW(0xAA)
	BREQ _0x47F
_0x480:
	RJMP _0x483
_0x47F:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	BRLO _0x484
	__GETB1MN _av_serv,1
	CPI  R30,LOW(0xAA)
	BRNE _0x484
	__GETB1MN _av_i_dv_min,1
	CPI  R30,LOW(0xAA)
	BRNE _0x485
	__GETB1MN _av_i_dv_max,1
	CPI  R30,LOW(0xAA)
	BRNE _0x485
	__GETB1MN _av_i_dv_log,1
	CPI  R30,LOW(0xAA)
	BREQ _0x484
_0x485:
	RJMP _0x483
_0x484:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	BRLO _0x488
	__GETB1MN _av_serv,2
	CPI  R30,LOW(0xAA)
	BRNE _0x488
	__GETB1MN _av_i_dv_min,2
	CPI  R30,LOW(0xAA)
	BRNE _0x489
	__GETB1MN _av_i_dv_max,2
	CPI  R30,LOW(0xAA)
	BRNE _0x489
	__GETB1MN _av_i_dv_log,2
	CPI  R30,LOW(0xAA)
	BREQ _0x488
_0x489:
	RJMP _0x483
_0x488:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x4)
	BRLO _0x48C
	__GETB1MN _av_serv,3
	CPI  R30,LOW(0xAA)
	BRNE _0x48C
	__GETB1MN _av_i_dv_min,3
	CPI  R30,LOW(0xAA)
	BRNE _0x48D
	__GETB1MN _av_i_dv_max,3
	CPI  R30,LOW(0xAA)
	BRNE _0x48D
	__GETB1MN _av_i_dv_log,3
	CPI  R30,LOW(0xAA)
	BREQ _0x48C
_0x48D:
	RJMP _0x483
_0x48C:
	LDS  R26,_av_p_stat
	CPI  R26,LOW(0x11)
	BREQ _0x483
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0x55)
	BRNE _0x47E
_0x483:
;    4547 		{
;    4548 		comm_av_st=cast_ON1;
	LDI  R30,LOW(85)
	RJMP _0xB61
;    4549 		}	
;    4550 	else comm_av_st=cast_OFF;
_0x47E:
	LDI  R30,LOW(170)
_0xB61:
	STS  _comm_av_st,R30
_0x47D:
;    4551 	}	
_0x477:
;    4552 
;    4553 }
	CALL __LOADLOCR6
	ADIW R28,6
	RET
;    4554 
;    4555 //-----------------------------------------------
;    4556 void matemat(void)
;    4557 {
_matemat:
;    4558 signed long temp_SL;
;    4559 signed temp_s;
;    4560 char j,i;
;    4561 
;    4562 
;    4563 
;    4564 //adc_bank_[12] - датчик 4-20
;    4565 //adc_bank_[13] - датчик т-ры воздуха(внешний)
;    4566 //adc_bank_[14] - датчик т-ры воздуха(внутренний) 
;    4567 
;    4568 
;    4569 granee(&Kun[0],300,500);
	SBIW R28,4
	CALL __SAVELOCR4
;	temp_SL -> Y+4
;	temp_s -> R16,R17
;	j -> R18
;	i -> R19
	CALL SUBOPT_0xC6
;    4570 granee(&Kun[1],300,500);
	__POINTW1MN _Kun,2
	CALL SUBOPT_0xC7
;    4571 granee(&Kun[2],300,500);
	__POINTW1MN _Kun,4
	CALL SUBOPT_0xC7
;    4572 
;    4573 temp_SL=unet_bank_[0]*200L;
	LDS  R26,_unet_bank_
	LDS  R27,_unet_bank_+1
	CALL SUBOPT_0xC8
;    4574 temp_SL/=(signed long)Kun[0];
	LDI  R26,LOW(_Kun)
	LDI  R27,HIGH(_Kun)
	CALL SUBOPT_0xC9
;    4575 unet[0]=(unsigned)temp_SL;
	STS  _unet,R30
	STS  _unet+1,R31
;    4576 temp_SL=unet_bank_[1]*200L;
	__GETW2MN _unet_bank_,2
	CALL SUBOPT_0xC8
;    4577 temp_SL/=(signed long)Kun[1];
	__POINTW2MN _Kun,2
	CALL SUBOPT_0xC9
;    4578 unet[1]=(unsigned)temp_SL;
	__PUTW1MN _unet,2
;    4579 temp_SL=unet_bank_[2]*200L;
	__GETW2MN _unet_bank_,4
	CALL SUBOPT_0xC8
;    4580 temp_SL/=(signed long)Kun[2];
	__POINTW2MN _Kun,4
	CALL SUBOPT_0xC9
;    4581 unet[2]=(unsigned)temp_SL;
	__PUTW1MN _unet,4
;    4582 
;    4583 temp_SL=adc_bank_[0];
	LDS  R30,_adc_bank_
	LDS  R31,_adc_bank_+1
	CLR  R22
	CLR  R23
	__PUTD1S 4
;    4584 height_level_p=(signed)temp_SL;
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	STS  _height_level_p,R30
	STS  _height_level_p+1,R31
;    4585 
;    4586 temp_SL=((adc_bank_[2]*(unsigned long)Kt[0])/1024UL)-273UL;
	__GETW1MN _adc_bank_,4
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Kt)
	LDI  R27,HIGH(_Kt)
	CALL __EEPROMRDW
	CALL __CWD1
	POP  R26
	POP  R27
	CLR  R24
	CLR  R25
	CALL __MULD12U
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x400
	CALL __DIVD21U
	__SUBD1N 273
	__PUTD1S 4
;    4587 t[0]=(signed)temp_SL;
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	STS  _t,R30
	STS  _t+1,R31
;    4588 temper_result=t[0];
	STS  _temper_result,R30
	STS  _temper_result+1,R31
;    4589 
;    4590 
;    4591 temp_SL=adc_bank_[3]-Kp0;
	__GETW1MN _adc_bank_,6
	PUSH R31
	PUSH R30
	LDI  R26,LOW(_Kp0)
	LDI  R27,HIGH(_Kp0)
	CALL __EEPROMRDW
	POP  R26
	POP  R27
	CALL __SWAPW12
	SUB  R30,R26
	SBC  R31,R27
	CALL SUBOPT_0xCA
;    4592 if(temp_SL<0)temp_SL=0;
	CALL __CPD20
	BRGE _0x492
	__CLRD1S 4
;    4593 temp_SL*=(unsigned long)Kp1;
_0x492:
	LDI  R26,LOW(_Kp1)
	LDI  R27,HIGH(_Kp1)
	CALL __EEPROMRDW
	CALL SUBOPT_0xCB
	__PUTD1S 4
;    4594 p_bank[p_bank_cnt]=temp_SL;
	LDS  R30,_p_bank_cnt
	CALL SUBOPT_0xCC
	ADD  R26,R30
	ADC  R27,R31
	__GETD1S 4
	CALL __PUTDP1
;    4595 
;    4596 if(++p_bank_cnt>=16)p_bank_cnt=0;
	LDS  R26,_p_bank_cnt
	SUBI R26,-LOW(1)
	STS  _p_bank_cnt,R26
	CPI  R26,LOW(0x10)
	BRLO _0x493
	LDI  R30,LOW(0)
	STS  _p_bank_cnt,R30
;    4597 temp_SL=0;
_0x493:
	__CLRD1S 4
;    4598 for(i=0;i<16;i++)
	LDI  R19,LOW(0)
_0x495:
	CPI  R19,16
	BRSH _0x496
;    4599 	{
;    4600 	temp_SL+=p_bank[i];
	MOV  R30,R19
	CALL SUBOPT_0xCC
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETD1P
	__GETD2S 4
	CALL __ADDD12
	__PUTD1S 4
;    4601 	}                  
	SUBI R19,-1
	RJMP _0x495
_0x496:
;    4602 p=(signed)(temp_SL/1600);	
	__GETD2S 4
	__GETD1N 0x640
	CALL __DIVD21
	STS  _p,R30
	STS  _p+1,R31
;    4603 
;    4604 if(dv_on[2]!=dvFR)
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x66)
	BRNE PC+3
	JMP _0x497
;    4605 	{ 
;    4606 	temp_SL=curr_ch_buff_[0];
	LDS  R30,_curr_ch_buff_
	LDS  R31,_curr_ch_buff_+1
	CALL SUBOPT_0xCA
;    4607 	if(temp_SL<10)temp_SL=0;
	__CPD2N 0xA
	BRGE _0x498
	__CLRD1S 4
;    4608 	Ida[2]=(temp_SL*(signed long)Kida[2])/10000; 
_0x498:
	__POINTW2MN _Kida,4
	CALL __EEPROMRDW
	CALL SUBOPT_0xCB
	CALL SUBOPT_0xCD
	__PUTW1MN _Ida,4
;    4609 	
;    4610  	temp_SL=curr_ch_buff_[1];
	__GETW1MN _curr_ch_buff_,2
	CALL SUBOPT_0xCA
;    4611 	if(temp_SL<10)temp_SL=0;		
	__CPD2N 0xA
	BRGE _0x499
	__CLRD1S 4
;    4612 	Idc[2]=(temp_SL*(signed long)Kidc[2])/10000;
_0x499:
	__POINTW2MN _Kidc,4
	CALL __EEPROMRDW
	CALL SUBOPT_0xCB
	CALL SUBOPT_0xCD
	__PUTW1MN _Idc,4
;    4613 	  		
;    4614 	Id[2]=(Ida[2]+Idc[2])/2;
	__GETW1MN _Ida,4
	PUSH R31
	PUSH R30
	__GETW1MN _Idc,4
	POP  R26
	POP  R27
	CALL SUBOPT_0xCE
	__PUTW1MN _Id,4
;    4615 	}	
;    4616 
;    4617 if(dv_on[3]!=dvFR)
_0x497:
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x66)
	BRNE PC+3
	JMP _0x49A
;    4618 	{    
;    4619 	temp_SL=curr_ch_buff_[2];
	__GETW1MN _curr_ch_buff_,4
	CALL SUBOPT_0xCA
;    4620 	if(temp_SL<10)temp_SL=0;
	__CPD2N 0xA
	BRGE _0x49B
	__CLRD1S 4
;    4621 	Ida[3]=(temp_SL*(signed long)Kida[3])/10000;
_0x49B:
	__POINTW2MN _Kida,6
	CALL __EEPROMRDW
	CALL SUBOPT_0xCB
	CALL SUBOPT_0xCD
	__PUTW1MN _Ida,6
;    4622 	
;    4623 	temp_SL=curr_ch_buff_[3];
	__GETW1MN _curr_ch_buff_,6
	CALL SUBOPT_0xCA
;    4624 	if(temp_SL<10)temp_SL=0;
	__CPD2N 0xA
	BRGE _0x49C
	__CLRD1S 4
;    4625 	Idc[3]=(temp_SL*(signed long)Kidc[3])/10000;
_0x49C:
	__POINTW2MN _Kidc,6
	CALL __EEPROMRDW
	CALL SUBOPT_0xCB
	CALL SUBOPT_0xCD
	__PUTW1MN _Idc,6
;    4626                  
;    4627      Id[3]=(Ida[3]+Idc[3])/2;
	__GETW1MN _Ida,6
	PUSH R31
	PUSH R30
	__GETW1MN _Idc,6
	POP  R26
	POP  R27
	CALL SUBOPT_0xCE
	__PUTW1MN _Id,6
;    4628      } 
;    4629 
;    4630 temp_SL=0;
_0x49A:
	__CLRD1S 4
;    4631 for(j=0;j<EE_DV_NUM;j++)
	LDI  R18,LOW(0)
_0x49E:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CP   R18,R30
	BRSH _0x49F
;    4632 	{
;    4633 	temp_SL+=Id[j];
	MOV  R30,R18
	LDI  R26,LOW(_Id)
	LDI  R27,HIGH(_Id)
	CALL SUBOPT_0xCF
	__GETD2S 4
	CLR  R22
	CLR  R23
	CALL __ADDD12
	__PUTD1S 4
;    4634 	}
	SUBI R18,-1
	RJMP _0x49E
_0x49F:
;    4635 comm_curr=(unsigned)temp_SL;
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	STS  _comm_curr,R30
	STS  _comm_curr+1,R31
;    4636 }
	CALL __LOADLOCR4
	ADIW R28,8
	RET
;    4637 
;    4638 //-----------------------------------------------
;    4639 char ind_fl(char in1,char in2)
;    4640 {
_ind_fl:
;    4641 lcd_buffer[32]=in1;
	LDD  R30,Y+1
	__PUTB1MN _lcd_buffer,32
;    4642 lcd_buffer[33]=in2;
	LD   R30,Y
	__PUTB1MN _lcd_buffer,33
;    4643 } 
	ADIW R28,2
	RET
;    4644 //-----------------------------------------------
;    4645 char spi_p(char in)
;    4646 {
;    4647 char temp,i;
;    4648 temp=in;
;	in -> Y+2
;	temp -> R16
;	i -> R17
;    4649 for(i=0;i<8;i++)
;    4650 	{
;    4651 	if(temp&0x80)
;    4652 		{
;    4653 		PORTB.2=1;
;    4654 		}      
;    4655 	else PORTB.2=0;
;    4656 	temp<<=1;
;    4657 	PORTB.1=1;
;    4658 	//delay_us(1);
;    4659 	if(PINB.3) temp|=0x01;
;    4660 	else temp&=0xFE;
;    4661 	PORTB.1=0;
;    4662 	//delay_us(1);
;    4663 
;    4664 	}
;    4665 //delay_us(1);
;    4666 
;    4667 return temp;
;    4668 }
;    4669 
;    4670 
;    4671 //-----------------------------------------------
;    4672 void adc_drv(void)
;    4673 { 
_adc_drv:
;    4674 unsigned self_adcw,temp_UI;
;    4675 char temp;
;    4676 
;    4677 
;    4678              
;    4679 self_adcw=ADCW;
	CALL __SAVELOCR5
;	self_adcw -> R16,R17
;	temp_UI -> R18,R19
;	temp -> R20
	__INWR 16,17,4
;    4680 
;    4681 if(adc_cnt_main<4)
	LDS  R26,_adc_cnt_main
	CPI  R26,LOW(0x4)
	BRLO PC+3
	JMP _0x4A7
;    4682 	{
;    4683 	if(self_adcw<self_min)self_min=self_adcw; 
	LDS  R30,_self_min
	LDS  R31,_self_min+1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x4A8
	__PUTWMRN _self_min,0,16,17
;    4684 	if(self_adcw>self_max)self_max=self_adcw;
_0x4A8:
	LDS  R30,_self_max
	LDS  R31,_self_max+1
	CP   R30,R16
	CPC  R31,R17
	BRGE _0x4A9
	__PUTWMRN _self_max,0,16,17
;    4685 	
;    4686 	self_cnt++;
_0x4A9:
	LDS  R30,_self_cnt
	SUBI R30,-LOW(1)
	STS  _self_cnt,R30
;    4687 	if(self_cnt>=30)
	LDS  R26,_self_cnt
	CPI  R26,LOW(0x1E)
	BRLO _0x4AA
;    4688 		{
;    4689 		curr_ch_buff[adc_cnt_main,adc_cnt_main1[adc_cnt_main]]=self_max-self_min;
	LDS  R30,_adc_cnt_main
	LDI  R26,LOW(_curr_ch_buff)
	LDI  R27,HIGH(_curr_ch_buff)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LSL  R30
	ROL  R31
	CALL __LSLW4
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xD0
	POP  R26
	POP  R27
	CALL SUBOPT_0xD1
	PUSH R31
	PUSH R30
	LDS  R26,_self_min
	LDS  R27,_self_min+1
	LDS  R30,_self_max
	LDS  R31,_self_max+1
	SUB  R30,R26
	SBC  R31,R27
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;    4690 /*		if(adc_cnt_main==0)
;    4691 			{
;    4692 			plazma_int[0]=self_max;
;    4693 			plazma_int[1]=self_min;
;    4694 			}*/
;    4695 		
;    4696 		adc_cnt_main1[adc_cnt_main]++;
	CALL SUBOPT_0xD2
	CALL SUBOPT_0xD3
;    4697 		if(adc_cnt_main1[adc_cnt_main]>=16)adc_cnt_main1[adc_cnt_main]=0;
	CALL SUBOPT_0xD0
	CPI  R30,LOW(0x10)
	BRLO _0x4AB
	CALL SUBOPT_0xD2
	LDI  R30,LOW(0)
	ST   X,R30
;    4698 		adc_cnt_main++;
_0x4AB:
	CALL SUBOPT_0xD4
;    4699 		if(adc_cnt_main<4)
	CPI  R26,LOW(0x4)
	BRSH _0x4AC
;    4700 			{
;    4701 			//curr_buff=0;
;    4702 			self_cnt=0;
	CALL SUBOPT_0xD5
;    4703 		    //	self_cnt_zero_for=0;
;    4704 			//self_cnt_not_zero=0;
;    4705 			//self_cnt_zero_after=0;
;    4706 			self_min=1023;
;    4707 			self_max=0;			
;    4708 			} 			
;    4709  
;    4710 						
;    4711 	 	}
_0x4AC:
;    4712 	}
_0x4AA:
;    4713 else if((adc_cnt_main>=4)&&(adc_cnt_main<=7))
	RJMP _0x4AD
_0x4A7:
	LDS  R26,_adc_cnt_main
	CPI  R26,LOW(0x4)
	BRLO _0x4AF
	CALL SUBOPT_0xD6
	BRSH _0x4B0
_0x4AF:
	RJMP _0x4AE
_0x4B0:
;    4714 	{
;    4715 	adc_bank[adc_cnt_main-4,adc_ch_cnt]=self_adcw;
	LDS  R30,_adc_cnt_main
	SUBI R30,LOW(4)
	LDI  R26,LOW(_adc_bank)
	LDI  R27,HIGH(_adc_bank)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LSL  R30
	ROL  R31
	CALL __LSLW4
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_adc_ch_cnt
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	ST   X+,R16
	ST   X,R17
;    4716 	
;    4717 	adc_cnt_main++;
	CALL SUBOPT_0xD4
;    4718 	if(adc_cnt_main==8)
	CPI  R26,LOW(0x8)
	BRNE _0x4B1
;    4719 		{
;    4720 		adc_ch_cnt++;
	LDS  R30,_adc_ch_cnt
	SUBI R30,-LOW(1)
	STS  _adc_ch_cnt,R30
;    4721 		if(adc_ch_cnt>=16)
	LDS  R26,_adc_ch_cnt
	CPI  R26,LOW(0x10)
	BRLO _0x4B2
;    4722 			{
;    4723 			adc_ch_cnt=0;
	LDI  R30,LOW(0)
	STS  _adc_ch_cnt,R30
;    4724 			}
;    4725 		}
_0x4B2:
;    4726 	
;    4727 	}
_0x4B1:
;    4728 
;    4729 else if(adc_cnt_main==8)
	RJMP _0x4B3
_0x4AE:
	LDS  R26,_adc_cnt_main
	CPI  R26,LOW(0x8)
	BRNE _0x4B4
;    4730 	{
;    4731 	adc_cnt_main=9;
	LDI  R30,LOW(9)
	STS  _adc_cnt_main,R30
;    4732 	self_cnt=0;
	CALL SUBOPT_0xD5
;    4733 	self_min=1023;
;    4734 	self_max=0;
;    4735 	}
;    4736 else if(adc_cnt_main==9)
	RJMP _0x4B5
_0x4B4:
	LDS  R26,_adc_cnt_main
	CPI  R26,LOW(0x9)
	BRNE _0x4B6
;    4737 	{
;    4738 	adc_cnt_main=0;
	LDI  R30,LOW(0)
	STS  _adc_cnt_main,R30
;    4739 	self_cnt=0;
	CALL SUBOPT_0xD5
;    4740 	self_min=1023;
;    4741 	self_max=0;
;    4742 	}
;    4743 	
;    4744 if(adc_cnt_main<4)
_0x4B6:
_0x4B5:
_0x4B3:
_0x4AD:
	LDS  R26,_adc_cnt_main
	CPI  R26,LOW(0x4)
	BRSH _0x4B7
;    4745 	{	
;    4746 	ADCSRA=0x86;
	CALL SUBOPT_0xD7
;    4747 	SFIOR&=0x0F;
;    4748 	SFIOR|=0x10;
;    4749 	ADMUX=0b01000100+adc_cnt_main;
	SUBI R30,-LOW(68)
	OUT  0x7,R30
;    4750 	ADCSRA|=0x40;		 	  		
	SBI  0x6,6
;    4751 	}
;    4752 else if((adc_cnt_main>=4)&&(adc_cnt_main<=7))
	RJMP _0x4B8
_0x4B7:
	LDS  R26,_adc_cnt_main
	CPI  R26,LOW(0x4)
	BRLO _0x4BA
	CALL SUBOPT_0xD6
	BRSH _0x4BB
_0x4BA:
	RJMP _0x4B9
_0x4BB:
;    4753 	{		
;    4754 	ADCSRA=0x86;
	CALL SUBOPT_0xD7
;    4755 	SFIOR&=0x0F;
;    4756 	SFIOR|=0x10;
;    4757 	ADMUX=0b01000000+(adc_cnt_main&0b11111011);
	ANDI R30,0xFB
	SUBI R30,-LOW(64)
	OUT  0x7,R30
;    4758 	ADCSRA|=0x40;	
	SBI  0x6,6
;    4759      }
;    4760 		     
;    4761 
;    4762 } 
_0x4B9:
_0x4B8:
	CALL __LOADLOCR5
	ADIW R28,5
	RET
;    4763 
;    4764 //-----------------------------------------------
;    4765 void adc_mat_hndl(void)
;    4766 {
_adc_mat_hndl:
;    4767 char i1,i2;
;    4768 unsigned int temp;
;    4769 
;    4770 for(i1=0;i1<4;i1++)
	CALL __SAVELOCR4
;	i1 -> R16
;	i2 -> R17
;	temp -> R18,R19
	LDI  R16,LOW(0)
_0x4BD:
	CPI  R16,4
	BRSH _0x4BE
;    4771 	{  
;    4772 	temp=0;
	__GETWRN 18,19,0
;    4773 	for(i2=0;i2<16;i2++)
	LDI  R17,LOW(0)
_0x4C0:
	CPI  R17,16
	BRSH _0x4C1
;    4774 		{
;    4775 		temp+=curr_ch_buff[i1,i2];
	MOV  R30,R16
	LDI  R26,LOW(_curr_ch_buff)
	LDI  R27,HIGH(_curr_ch_buff)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LSL  R30
	ROL  R31
	CALL __LSLW4
	POP  R26
	POP  R27
	CALL SUBOPT_0xD8
	__ADDWRR 18,19,30,31
;    4776 		}
	SUBI R17,-1
	RJMP _0x4C0
_0x4C1:
;    4777 	curr_ch_buff_[i1]=temp>>1;
	MOV  R30,R16
	LDI  R26,LOW(_curr_ch_buff_)
	LDI  R27,HIGH(_curr_ch_buff_)
	CALL SUBOPT_0xD1
	PUSH R31
	PUSH R30
	__GETW1R 18,19
	LSR  R31
	ROR  R30
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;    4778 	
;    4779 	}	
	SUBI R16,-1
	RJMP _0x4BD
_0x4BE:
;    4780 
;    4781 for(i1=0;i1<4;i1++)
	LDI  R16,LOW(0)
_0x4C3:
	CPI  R16,4
	BRSH _0x4C4
;    4782 	{
;    4783 	temp=0;
	__GETWRN 18,19,0
;    4784 	for(i2=0;i2<16;i2++)
	LDI  R17,LOW(0)
_0x4C6:
	CPI  R17,16
	BRSH _0x4C7
;    4785 		{
;    4786 		temp+=adc_bank[i1][i2];
	MOV  R30,R16
	LDI  R26,LOW(_adc_bank)
	LDI  R27,HIGH(_adc_bank)
	LDI  R31,0
	PUSH R27
	PUSH R26
	LSL  R30
	ROL  R31
	CALL __LSLW4
	POP  R26
	POP  R27
	CALL SUBOPT_0xD8
	__ADDWRR 18,19,30,31
;    4787 		}
	SUBI R17,-1
	RJMP _0x4C6
_0x4C7:
;    4788 	adc_bank_[i1]=temp>>4;
	MOV  R30,R16
	LDI  R26,LOW(_adc_bank_)
	LDI  R27,HIGH(_adc_bank_)
	CALL SUBOPT_0xD1
	PUSH R31
	PUSH R30
	__GETW1R 18,19
	CALL __LSRW4
	POP  R26
	POP  R27
	ST   X+,R30
	ST   X,R31
;    4789 	} 
	SUBI R16,-1
	RJMP _0x4C3
_0x4C4:
;    4790 
;    4791 }
	CALL __LOADLOCR4
	ADIW R28,4
	RET
;    4792 
;    4793 //-----------------------------------------------
;    4794 void ind_hndl(void)
;    4795 {
_ind_hndl:
;    4796 #define speed	lcd_buffer[34]
;    4797 signed int temp;
;    4798 flash char* ptrs[11];
;    4799 char temp_;
;    4800 
;    4801 speed=0;
	SBIW R28,22
	CALL __SAVELOCR3
;	temp -> R16,R17
;	*ptrs -> Y+3
;	temp_ -> R18
	LDI  R30,LOW(0)
	__PUTB1MN _lcd_buffer,34
;    4802 
;    4803 ind_fl(0xff,0xff);
	LDI  R30,LOW(255)
	CALL SUBOPT_0xD9
	CALL _ind_fl
;    4804 
;    4805 if(ind==iAv_sel)
	LDI  R30,LOW(168)
	CP   R30,R13
	BREQ PC+3
	JMP _0x4C8
;    4806      {
;    4807      p1=ptr_last_av;
	LDI  R26,LOW(_ptr_last_av)
	LDI  R27,HIGH(_ptr_last_av)
	CALL __EEPROMRDW
	STS  _p1,R30
;    4808      p1-=index_set;
	LDS  R26,_index_set
	SUB  R30,R26
	STS  _p1,R30
;    4809      p1--;
	SUBI R30,LOW(1)
	STS  _p1,R30
;    4810      if(p1<0)p1+=20;
	LDS  R26,_p1
	CPI  R26,0
	BRGE _0x4C9
	SUBI R30,-LOW(20)
	STS  _p1,R30
;    4811      p2=p1+1;
_0x4C9:
	LDS  R30,_p1
	SUBI R30,-LOW(1)
	STS  _p2,R30
;    4812      if(p2>19)p2-=20; 
	LDS  R26,_p2
	LDI  R30,LOW(19)
	CP   R30,R26
	BRGE _0x4CA
	LDS  R30,_p2
	SUBI R30,LOW(20)
	STS  _p2,R30
;    4813      
;    4814      ptrs[0]=" !  0@:0# 0$0%0<";
_0x4CA:
	__POINTW1FN _0,2
	STD  Y+3,R30
	STD  Y+3+1,R31
;    4815      if(av_code[p2]==0xff)ptrs[0]=" Аварий нет     "; 
	CALL SUBOPT_0xDA
	CPI  R30,LOW(0xFF)
	LDI  R26,HIGH(0xFF)
	CPC  R31,R26
	BRNE _0x4CB
	__POINTW1FN _0,19
	STD  Y+3,R30
	STD  Y+3+1,R31
;    4816      
;    4817      ptrs[1]=" ^  0&:0* 0(0)0>";
_0x4CB:
	__POINTW1FN _0,36
	STD  Y+5,R30
	STD  Y+5+1,R31
;    4818      if(av_code[p1]==0xff)ptrs[1]=" Аварий нет     ";     
	CALL SUBOPT_0xDB
	CPI  R30,LOW(0xFF)
	LDI  R26,HIGH(0xFF)
	CPC  R31,R26
	BRNE _0x4CC
	__POINTW1FN _0,19
	STD  Y+5,R30
	STD  Y+5+1,R31
;    4819      
;    4820 	if(sub_ind<index_set) index_set=sub_ind;
_0x4CC:
	CALL SUBOPT_0xDC
	BRSH _0x4CD
	LDS  R30,_sub_ind
	STS  _index_set,R30
;    4821 	else if((sub_ind-index_set)>1) index_set=sub_ind-1;
	RJMP _0x4CE
_0x4CD:
	CALL SUBOPT_0xDD
	CALL SUBOPT_0xDE
	BRSH _0x4CF
	CALL SUBOPT_0xDF
;    4822 	
;    4823  	bgnd_par(ptrs[0],ptrs[1]);
_0x4CF:
_0x4CE:
	CALL SUBOPT_0xE0
;    4824     	
;    4825 	if((sub_ind-index_set)==0) lcd_buffer[0]=1; 
	CALL SUBOPT_0xDD
	BRNE _0x4D0
	LDI  R30,LOW(1)
	STS  _lcd_buffer,R30
;    4826 	else if((sub_ind-index_set)==1) lcd_buffer[16]=1; 
	RJMP _0x4D1
_0x4D0:
	CALL SUBOPT_0xDD
	CPI  R30,LOW(0x1)
	BRNE _0x4D2
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,16
;    4827   
;    4828      sub_bgnd(sm_av[av_code[p2]],'!');
_0x4D2:
_0x4D1:
	LDI  R30,LOW(_sm_av*2)
	LDI  R31,HIGH(_sm_av*2)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xDA
	POP  R26
	POP  R27
	PUSH R27
	PUSH R26
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0xE1
;    4829      int2lcd(av_hour[p2]&0x1f,'@',0);
	LDS  R26,_p2
	CALL SUBOPT_0xE2
	CALL SUBOPT_0xE3
	CALL SUBOPT_0xE4
;    4830     	int2lcd(av_min[p2],'#',0);
	CALL SUBOPT_0xE5
	CALL SUBOPT_0xE6
	CALL SUBOPT_0xE4
;    4831      int2lcd(av_day[p2],'$',0);
	CALL SUBOPT_0xE7
	CALL SUBOPT_0xE8
	CALL SUBOPT_0xE4
;    4832      int2lcd(av_month[p2],'%',0);
	CALL SUBOPT_0xE9
	CALL SUBOPT_0xEA
	CALL SUBOPT_0xE4
;    4833      int2lcd(av_year[p2],'<',0);
	CALL SUBOPT_0xEB
	LDI  R30,LOW(60)
	CALL SUBOPT_0xEC
;    4834         	
;    4835      sub_bgnd(sm_av[av_code[p1]],'^');
	LDI  R30,LOW(_sm_av*2)
	LDI  R31,HIGH(_sm_av*2)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0xDB
	POP  R26
	POP  R27
	PUSH R27
	PUSH R26
	LDI  R26,LOW(3)
	LDI  R27,HIGH(3)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(94)
	ST   -Y,R30
	CALL _sub_bgnd
;    4836      int2lcd(av_hour[p1]&0x1f,'&',0);
	LDS  R26,_p1
	CALL SUBOPT_0xE2
	LDI  R30,LOW(38)
	CALL SUBOPT_0xEC
;    4837 	int2lcd(av_min[p1],'*',0);
	LDS  R26,_p1
	LDI  R27,0
	CALL SUBOPT_0xE5
	LDI  R30,LOW(42)
	CALL SUBOPT_0xEC
;    4838      int2lcd(av_day[p1],'(',0);
	LDS  R26,_p1
	LDI  R27,0
	CALL SUBOPT_0xE7
	LDI  R30,LOW(40)
	CALL SUBOPT_0xEC
;    4839      int2lcd(av_month[p1],')',0);
	LDS  R26,_p1
	LDI  R27,0
	CALL SUBOPT_0xE9
	LDI  R30,LOW(41)
	CALL SUBOPT_0xEC
;    4840      int2lcd(av_year[p1],'>',0);
	LDS  R26,_p1
	LDI  R27,0
	CALL SUBOPT_0xEB
	LDI  R30,LOW(62)
	CALL SUBOPT_0xEC
;    4841 
;    4842 //int2lcdxy(ptr_last_av,0x21,0);
;    4843 //int2lcdxy(level,0x01,0);	     
;    4844      }	
;    4845 
;    4846 else if(ind==iDeb)
	JMP  _0x4D3
_0x4C8:
	LDI  R30,LOW(180)
	CP   R30,R13
	BREQ PC+3
	JMP _0x4D4
;    4847 	{
;    4848 	if(sub_ind==0)  
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x4D5
;    4849 	{
;    4850 	bgnd_par(sm_,sm_); 
	CALL SUBOPT_0xED
;    4851 	//int2lcdxy(cher_cnt,0x30,0);
;    4852 //	int2lcdxy(plazma,0x30,0);
;    4853 //	int2lcdxy(plazma_int[0],0x31,0);
;    4854 //	int2lcdxy(plazma_int[1],0x81,0); 
;    4855 	//int2lcdxy(av_level_sensor_cnt,0x30,0);
;    4856 	//char2lcdhxy(av_ls_stat,0x31);
;    4857  //    int2lcdxy(not_wrk_cnt,0xf0,0);
;    4858  //    int2lcdxy(bLEVEL0,0xf1,0);
;    4859  //    int2lcdxy(not_wrk,0xc0,0);
;    4860  //    int2lcdxy(not_wrk_old,0xc1,0);
;    4861  //    int2lcdxy(wrk_cnt,0x80,0);
;    4862      //int2lcdxy(adc_bank_[6],0xc1,0);
;    4863       //    int2lcdxy(adc_bank_[7],0xc0,0);
;    4864      //int2lcdxy(adc_bank_[6],0xc1,0);
;    4865      /*char2lcdhxy(level_on[0],0x10);
;    4866      char2lcdhxy(level_on[1],0x40);
;    4867      char2lcdhxy(level_on[2],0x70);
;    4868      char2lcdhxy(level_on[3],0xa0);
;    4869      char2lcdhxy(level_on[4],0xd0); 
;    4870      char2lcdhxy(level_cnt[0],0x11);
;    4871      char2lcdhxy(level_cnt[1],0x41);
;    4872      char2lcdhxy(level_cnt[2],0x71);*/
;    4873      	//char2lcdhxy(apv[0],0x10);
;    4874      	//char2lcdhxy(apv[1],0x11);
;    4875      	 
;    4876     /* 	int2lcdxy(popl_cnt_p[0],0x20,0);
;    4877  	int2lcdxy(popl_cnt_m[0],0x21,0);
;    4878  	int2lcdxy(popl_cnt_p[1],0x50,0);
;    4879  	int2lcdxy(popl_cnt_m[1],0x51,0);
;    4880  	int2lcdxy(popl_cnt_p[2],0x80,0);
;    4881  	int2lcdxy(popl_cnt_m[2],0x81,0);
;    4882  	int2lcdxy(popl_cnt_p[3],0xb0,0);
;    4883  	int2lcdxy(popl_cnt_m[3],0xb1,0);  */
;    4884  	
;    4885        //	int2lcdxy(Idc[0],0x80,0);
;    4886  	//int2lcdxy(Idc[1],0x81,0); 	     	
;    4887     // 	int2lcdxy(apv_cnt[0],0xc0,0);
;    4888     //	int2lcdxy(apv_cnt[1],0xc1,0);
;    4889         /* 	char2lcdhxy(rel_in_st[0],0x20);
;    4890          	char2lcdhxy(rel_in_st[1],0x60);
;    4891          	char2lcdhxy(rel_in_st[2],0xa0);
;    4892          	char2lcdhxy(rel_in_st[3],0xe0);
;    4893        	char2lcdhxy(hh_av,0xe1);*/ 
;    4894        
;    4895  /*    char2lcdhxy(UIB0[0],0x10); 
;    4896      char2lcdhxy(UIB0[1],0x30);
;    4897      char2lcdhxy(UIB0[2],0x50);
;    4898      char2lcdhxy(UIB0[3],0x70);
;    4899      char2lcdhxy(UIB0[4],0x90);
;    4900      char2lcdhxy(UIB0[5],0xb0);
;    4901      char2lcdhxy(UIB0[6],0xd0);
;    4902      char2lcdhxy(UIB0[7],0xf0);
;    4903      char2lcdhxy(UIB0[8],0x11);
;    4904      char2lcdhxy(UIB0[9],0x31);
;    4905      char2lcdhxy(UIB0[10],0x51);
;    4906      char2lcdhxy(UIB0[11],0x71);
;    4907      char2lcdhxy(UIB0[12],0x91);
;    4908      char2lcdhxy(UIB0[13],0xb1);
;    4909      //char2lcdhxy(UIB0[14],0xd1); 
;    4910      int2lcdxy(UIB0_CNT,0xd1,0);*/
;    4911 /*     int2lcdxy(bMODBUS_FREE,0xf0,0);
;    4912      int2lcdxy(modbus_cnt,0xf1,0);
;    4913      int2lcdxy(repeat_transmission_cnt,0x51,0);	 
;    4914      int2lcdxy(modbus_out_ptr_wr,0x20,0);
;    4915      int2lcdxy(modbus_out_ptr_rd,0x21,0);*/
;    4916      
;    4917     //
;    4918     //int2lcdxy(but_cnt[3],0x21,0);
;    4919     /*	char2lcdhxy(av_upp[0],0x50);
;    4920      char2lcdhxy(av_upp[1],0x80);
;    4921      char2lcdhxy(av_upp[2],0xb0);
;    4922      char2lcdhxy(av_upp[3],0xe0);*/
;    4923      
;    4924      
;    4925     /*char2lcdhxy(dv_on[0],0x20);
;    4926      char2lcdhxy(dv_on[1],0x50);
;    4927      char2lcdhxy(dv_on[2],0x80); 
;    4928      char2lcdhxy(dv_on[3],0xc0);
;    4929      /* char2lcdhxy(av_fp_stat,0xb0);
;    4930      char2lcdhxy(pilot_dv,0xc0);*/
;    4931      
;    4932     /* char2lcdhxy(dv_on[3],0xb0);
;    4933      char2lcdhxy(dv_on[4],0xe0); */ 
;    4934      
;    4935      int2lcdxy(fr_stat,0x40,0);   
	LDS  R30,_fr_stat
	LDS  R31,_fr_stat+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcdxy
;    4936      int2lcdxy(reset_fp_cnt,0x51,0);
	LDS  R30,_reset_fp_cnt
	LDI  R31,0
	CALL SUBOPT_0xEE
;    4937      int2lcdxy(off_fp_cnt,0x21,0);
	LDS  R30,_off_fp_cnt
	LDS  R31,_off_fp_cnt+1
	CALL SUBOPT_0xEF
;    4938       //int2lcdxy(plazma,0xf1,0);
;    4939      
;    4940      //char2lcdhxy(warm_st,0x20);
;    4941      //char2lcdhxy(av_temper_st,0x21);
;    4942      //
;    4943      /*
;    4944      int2lcdxy(fp_power,0x61,0);
;    4945      
;    4946      int2lcdxy(potenz,0xe0,0);
;    4947      int2lcdxy(potenz_off,0xe1,0);*/
;    4948 
;    4949     /* int2lcdxy(FP_FMAX,0x60,0);
;    4950      int2lcdxy(FP_FMIN,0x61,0);*/ 
;    4951    //  int2lcdxy(bPOTENZ_UP,0x50,0); 
;    4952    //  int2lcdxy(bPOTENZ_DOWN,0x70,0);
;    4953    //  int2lcdxy(p,0x30,0);
;    4954      //int2lcdxy(p_ust,0x31,0);
;    4955      //int2lcdxy(potenz,0x31,0);
;    4956    /*  char2lcdhxy(dv_on[0],0x60);
;    4957      char2lcdhxy(dv_on[1],0x80);
;    4958       */
;    4959      //char2lcdhxy(comm_av_st,0x31);   
;    4960    //  int2lcdxy(num_necc,0x51,0);
;    4961     // int2lcdxy(net_motor_potenz,0x71,0);
;    4962     // int2lcdxy(net_motor_wrk,0x91,0);
;    4963    //  int2lcdxy(cnt_control_blok,0xa0,0);
;    4964     // char2lcdhxy(mode,0xf1);
;    4965     
;    4966     // int2lcdxy(power,0xc1,0);
;    4967     // int2lcdxy(fp_poz,0xf0,0);
;    4968      //int2lcdxy(__fp_fcurr,0xa1,1);  
;    4969      }           
;    4970      
;    4971 	else if(sub_ind==1)  
	RJMP _0x4D6
_0x4D5:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x4D7
;    4972 	{
;    4973 	bgnd_par(sm_,sm_); 
	CALL SUBOPT_0xED
;    4974 
;    4975 /*     char2lcdhxy(data_for_ex[0,2],0x10);
;    4976     char2lcdhxy(data_for_ex[0,3],0x30);
;    4977      char2lcdhxy(data_for_ex[0,4],0x50);
;    4978      char2lcdhxy(data_for_ex[0,5],0x70);
;    4979      
;    4980      char2lcdhxy(data_for_ex[0,6],0x90);
;    4981      char2lcdhxy(data_for_ex[0,7],0xb0);
;    4982      char2lcdhxy(data_for_ex[0,8],0xd0);
;    4983       char2lcdhxy(data_for_ex[0,9],0xf0);
;    4984 
;    4985     char2lcdhxy(data_for_ex[1,2],0x11);
;    4986      char2lcdhxy(data_for_ex[1,3],0x31);
;    4987      char2lcdhxy(data_for_ex[1,4],0x51);
;    4988      char2lcdhxy(data_for_ex[1,5],0x71);
;    4989      
;    4990      char2lcdhxy(data_for_ex[1,6],0x91);
;    4991      char2lcdhxy(data_for_ex[1,7],0xb1);
;    4992      char2lcdhxy(data_for_ex[1,8],0xd1);
;    4993        
;    4994   /*                                        
;    4995      char2lcdhxy(temp_DVCH,0x80);
;    4996      char2lcdhxy(mode,0x81);                                     
;    4997      int2lcdxy(CURR_TIME,0xf0,0);
;    4998      int2lcdxy(DVCH_TIME,0xf1,0);
;    4999      int2lcdxy(bDVCH,0x20,0); 
;    5000      int2lcdxy(pilot_dv,0x21,0);  
;    5001      */
;    5002     
;    5003     //char2lcdhxy(av_p_stat,0x81); 
;    5004  /*   int2lcdxy(p_max_cnt,0xf0,0); 
;    5005     int2lcdxy(p_min_cnt,0xf1,0);
;    5006     int2lcdxy(bPMIN,0x20,0); 
;    5007     int2lcdxy(plazma_plazma,0x71,0); 
;    5008     
;    5009     int2lcdxy(Id[0],0x40,0); 
;    5010     int2lcdxy(Id[1],0x70,0);
;    5011     int2lcdxy(Id[2],0xa0,0);*/
;    5012     
;    5013     int2lcdxy(av_id_min_cnt[0],0x20,0); 
	LDS  R30,_av_id_min_cnt
	LDI  R31,0
	CALL SUBOPT_0xF0
;    5014     // int2lcdxy(av_id_min_cnt[1],0x50,0);
;    5015      // int2lcdxy(av_id_min_cnt[2],0x80,0);
;    5016      
;    5017      int2lcdxy(Idmin,0x21,0); 
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	CALL SUBOPT_0xEF
;    5018      int2lcdxy(Ida[0],0x51,0); 
	LDS  R30,_Ida
	LDS  R31,_Ida+1
	CALL SUBOPT_0xEE
;    5019      int2lcdxy(Idc[0],0x81,0);
	LDS  R30,_Idc
	LDS  R31,_Idc+1
	CALL SUBOPT_0xF1
;    5020      int2lcdxy(apv_cnt[0],0x50,0);
	LDS  R30,_apv_cnt
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(80)
	CALL SUBOPT_0xF2
;    5021      int2lcdxy(cnt_av_i_not_wrk[0],0x80,0); 
	LDS  R30,_cnt_av_i_not_wrk
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(128)
	CALL SUBOPT_0xF2
;    5022      int2lcdxy(num_necc,0xf0,0); 
	LDS  R30,_num_necc
	LDI  R31,0
	CALL SUBOPT_0xF3
;    5023      int2lcdxy(potenz,0xf1,0); 
	LDS  R30,_potenz
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(241)
	CALL SUBOPT_0xF2
;    5024      
;    5025       char2lcdhxy(apv[0],0xd0);                           
	LDS  R30,_apv
	ST   -Y,R30
	LDI  R30,LOW(208)
	ST   -Y,R30
	CALL _char2lcdhxy
;    5026      }     
;    5027 
;    5028 	
;    5029 		else if(sub_ind==2)  
	RJMP _0x4D8
_0x4D7:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x4D9
;    5030 	{
;    5031 	bgnd_par(sm_,sm_); 
	CALL SUBOPT_0xED
;    5032 
;    5033 
;    5034     
;    5035 /*    int2lcdxy(av_id_min_cnt[2],0x20,0); 
;    5036     // int2lcdxy(av_id_min_cnt[1],0x50,0);
;    5037      // int2lcdxy(av_id_min_cnt[2],0x80,0);
;    5038      
;    5039      int2lcdxy(Idmin,0x21,0); 
;    5040      int2lcdxy(Ida[2],0x51,0); 
;    5041      int2lcdxy(Idc[2],0x81,0);
;    5042      int2lcdxy(apv_cnt[2],0x50,0);
;    5043      int2lcdxy(cnt_av_i_not_wrk[2],0x80,0); 
;    5044      int2lcdxy(num_necc,0xf0,0); 
;    5045      int2lcdxy(potenz,0xf1,0);
;    5046 	char2lcdhxy(apv[2],0xd0);  */   
;    5047 	
;    5048 /*	char2lcdhxy(dv_access[0],0x20);
;    5049 	char2lcdhxy(dv_access[1],0x50);
;    5050 	char2lcdhxy(dv_access[2],0x80);	 */
;    5051 	                          
;    5052      /*char2lcdhxy(rel_in_st[1],0x30);
;    5053      int2lcdxy(av_fp_cnt,0x31,0);
;    5054      int2lcdxy(temp_fp,0x61,0);*/
;    5055      
;    5056      //int2lcdxy(bDVCH,0x81,0);	   
;    5057      
;    5058  //    char2lcdhxy(fp_apv[0],0x60);   
;    5059  //     char2lcdhxy(fp_apv[1],0x90); 
;    5060   //     char2lcdhxy(fp_apv[2],0xc0); 
;    5061      
;    5062   /*	int2lcdxy(p,0x20,0);
;    5063   	int2lcdxy(p_ust,0x60,0); 
;    5064   	int2lcdxy(day_period,0xa0,0); 
;    5065   	int2lcdxy(p_ust_pl,0xf0,0);
;    5066   	
;    5067   	int2lcdxy(num_necc,0x21,0);
;    5068   	int2lcdxy(num_wrks_new,0x51,0);
;    5069   	int2lcdxy(cnt_control_blok,0x81,0);
;    5070   	int2lcdxy(potenz,0xf1,0); 
;    5071   	int2lcdxy(pilot_dv,0xa1,0); */
;    5072  	
;    5073   	int2lcdxy(123,0x20,0)  ;   
	LDI  R30,LOW(123)
	LDI  R31,HIGH(123)
	CALL SUBOPT_0xF0
;    5074   	
;    5075   	int2lcdxy(cnt_control_blok,0x21,0)  ; 
	LDS  R30,_cnt_control_blok
	LDS  R31,_cnt_control_blok+1
	CALL SUBOPT_0xEF
;    5076   	int2lcdxy(p,0xf0,0);
	LDS  R30,_p
	LDS  R31,_p+1
	CALL SUBOPT_0xF3
;    5077   	int2lcdxy(p_ust,0xf1,0); 
	ST   -Y,R9
	ST   -Y,R8
	LDI  R30,LOW(241)
	CALL SUBOPT_0xF2
;    5078   	int2lcdxy(DVCH_P_KR,0x81,0); 
	LDI  R26,LOW(_DVCH_P_KR)
	LDI  R27,HIGH(_DVCH_P_KR)
	CALL __EEPROMRDW
	CALL SUBOPT_0xF1
;    5079           
;    5080      }     
;    5081 	
;    5082 	}    
_0x4D9:
_0x4D8:
_0x4D6:
;    5083 	
;    5084 /*
;    5085 *#define AVAR_LEVEL	0x01
;    5086 #define AVAR_UNET	0x04
;    5087 #define AVAR_CHER	0x06
;    5088 #define AVAR_HEAT	0x07
;    5089 #define AVAR_COOL	0x08
;    5090 #define AVAR_PERELIV 0x05
;    5091 #define AVAR_POPL 	0x0b
;    5092 
;    5093 #define AV_I_MIN_0	0x19
;    5094 #define AV_I_MAX_0	0x12
;    5095 #define AV_I_PER_0	0x1c
;    5096 #define AV_HIDRO_0 	0x1a
;    5097 #define AV_TERMO_0 	0x13
;    5098 #define AV_PP_0	0x10
;    5099 
;    5100 #define AV_I_MIN_1	0x29
;    5101 #define AV_I_MAX_1	0x22
;    5102 #define AV_I_PER_1	0x2c
;    5103 #define AV_HIDRO_1 	0x2a
;    5104 #define AV_TERMO_1 	0x23
;    5105 #define AV_PP_1	0x20
;    5106 
;    5107 #define AV_I_MIN_2	0x39
;    5108 #define AV_I_MAX_2	0x32
;    5109 #define AV_I_PER_2	0x3c 
;    5110 #define AV_HIDRO_2 	0x3a
;    5111 #define AV_TERMO_2 	0x33
;    5112 #define AV_PP_2	0x30
;    5113 
;    5114 #define AV_I_MIN_3	0x49
;    5115 #define AV_I_MAX_3	0x42
;    5116 #define AV_I_PER_3	0x4c
;    5117 #define AV_HIDRO_3 	0x4a
;    5118 #define AV_TERMO_3 	0x43
;    5119 #define AV_PP_3	0x40
;    5120 
;    5121 #define AV_I_MIN_4	0x59
;    5122 #define AV_I_MAX_4	0x52
;    5123 #define AV_I_PER_4	0x5c 
;    5124 #define AV_HIDRO_4 	0x5a
;    5125 #define AV_TERMO_4 	0x53
;    5126 #define AV_PP_4	0x50
;    5127 
;    5128 #define AV_I_MIN_5	0x69 
;    5129 #define AV_I_MAX_5	0x62 
;    5130 #define AV_I_PER_5	0x6c 
;    5131 #define AV_HIDRO_5 	0x6a
;    5132 #define AV_TERMO_5 	0x63
;    5133 #define AV_PP_5	0x60
;    5134 */
;    5135 
;    5136 
;    5137 else if(ind==iAv)
	JMP  _0x4DA
_0x4D4:
	LDI  R30,LOW(169)
	CP   R30,R13
	BREQ PC+3
	JMP _0x4DB
;    5138 	{
;    5139 	ptrs[0]=sm_;
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5140 	ptrs[1]=sm_;
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5141 	ptrs[2]="0@:0#:0$ 0%  &0^";
	__POINTW1FN _0,53
	STD  Y+7,R30
	STD  Y+7+1,R31
;    5142 	
;    5143 	if(av_code[sub_ind1]==AVAR_START)
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0xE)
	LDI  R26,HIGH(0xE)
	CPC  R31,R26
	BRNE _0x4DC
;    5144 		{
;    5145 		ptrs[0]="     Станция    ";
	__POINTW1FN _0,70
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5146 		ptrs[1]="    включена    ";
	__POINTW1FN _0,87
	CALL SUBOPT_0xF5
;    5147 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5148 		}
;    5149 	else if(av_code[sub_ind1]==AVAR_FP)
	RJMP _0x4DD
_0x4DC:
	CALL SUBOPT_0xF4
	SBIW R30,0
	BREQ PC+3
	JMP _0x4DE
;    5150 		{
;    5151 		unsigned long temp___;
;    5152 		*((signed*)&temp___)=av_data1[sub_ind1];
	SBIW R28,4
;	*ptrs -> Y+7
;	temp___ -> Y+0
	CALL SUBOPT_0xF6
	ST   Y,R30
	STD  Y+1,R31
;    5153 		*(((signed*)&temp___)+1)=av_data0[sub_ind1];
	CALL SUBOPT_0xF7
	STD  Y+2,R30
	STD  Y+2+1,R31
;    5154 		ptrs[0]="   Авария ЧП    ";
	__POINTW1FN _0,104
	STD  Y+7,R30
	STD  Y+7+1,R31
;    5155 		if(temp___==0x00000100)ptrs[1]="короткое замыкан";
	__GETD2S 0
	__CPD2N 0x100
	BRNE _0x4DF
	__POINTW1FN _0,121
	STD  Y+9,R30
	STD  Y+9+1,R31
;    5156 		else if(temp___==0x00000800)ptrs[1]="перегр. по току ";
	RJMP _0x4E0
_0x4DF:
	__GETD2S 0
	__CPD2N 0x800
	BRNE _0x4E1
	__POINTW1FN _0,138
	STD  Y+9,R30
	STD  Y+9+1,R31
;    5157 		else if(temp___==0x00010000)ptrs[1]="низкое напряжен.";
	RJMP _0x4E2
_0x4E1:
	__GETD2S 0
	__CPD2N 0x10000
	BRNE _0x4E3
	__POINTW1FN _0,155
	STD  Y+9,R30
	STD  Y+9+1,R31
;    5158 		else if(temp___==0x00020000)ptrs[1]="высокое напряж. ";
	RJMP _0x4E4
_0x4E3:
	__GETD2S 0
	__CPD2N 0x20000
	BRNE _0x4E5
	__POINTW1FN _0,172
	STD  Y+9,R30
	STD  Y+9+1,R31
;    5159 		else if(temp___==0x00040800)ptrs[1]="  обрыв фазы    ";
	RJMP _0x4E6
_0x4E5:
	__GETD2S 0
	__CPD2N 0x40800
	BRNE _0x4E7
	__POINTW1FN _0,189
	STD  Y+9,R30
	STD  Y+9+1,R31
;    5160 		else if(temp___==0x00100000)ptrs[1]="  перегрев      ";
	RJMP _0x4E8
_0x4E7:
	__GETD2S 0
	__CPD2N 0x100000
	BRNE _0x4E9
	__POINTW1FN _0,206
	RJMP _0xB62
;    5161 	     else ptrs[1]="                ";
_0x4E9:
	__POINTW1FN _0,223
_0xB62:
	STD  Y+9,R30
	STD  Y+9+1,R31
_0x4E8:
_0x4E6:
_0x4E4:
_0x4E2:
_0x4E0:
;    5162 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
	LDS  R30,_index_set
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,7
	CALL SUBOPT_0xF8
	CALL SUBOPT_0xF9
	MOVW R26,R28
	ADIW R26,9
	CALL SUBOPT_0xF8
	CALL _bgnd_par
;    5163 		}
	ADIW R28,4
;    5164 		
;    5165 
;    5166 	else if(av_code[sub_ind1]==AVAR_UNET)
	RJMP _0x4EB
_0x4DE:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0x4)
	LDI  R26,HIGH(0x4)
	CPC  R31,R26
	BREQ PC+3
	JMP _0x4EC
;    5167 		{
;    5168 		ptrs[0]="   Напряжение   ";
	__POINTW1FN _0,240
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5169 		if(av_data0[sub_ind1]==0x00)
	CALL SUBOPT_0xF7
	SBIW R30,0
	BRNE _0x4ED
;    5170 			{
;    5171 			if(av_data1[sub_ind1]==0x00)ptrs[1]=" фазы A занижено";
	CALL SUBOPT_0xF6
	SBIW R30,0
	BRNE _0x4EE
	__POINTW1FN _0,257
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5172 			if(av_data1[sub_ind1]==0x01)ptrs[1]=" фазы A завышено";
_0x4EE:
	CALL SUBOPT_0xF6
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4EF
	__POINTW1FN _0,274
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5173 			}
_0x4EF:
;    5174 		else if(av_data0[sub_ind1]==0x01)
	RJMP _0x4F0
_0x4ED:
	CALL SUBOPT_0xF7
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4F1
;    5175 			{
;    5176 			if(av_data1[sub_ind1]==0x00)ptrs[1]=" фазы B занижено";
	CALL SUBOPT_0xF6
	SBIW R30,0
	BRNE _0x4F2
	__POINTW1FN _0,291
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5177 			if(av_data1[sub_ind1]==0x01)ptrs[1]=" фазы B завышено";
_0x4F2:
	CALL SUBOPT_0xF6
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4F3
	__POINTW1FN _0,308
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5178 			}
_0x4F3:
;    5179 		else if(av_data0[sub_ind1]==0x02)
	RJMP _0x4F4
_0x4F1:
	CALL SUBOPT_0xF7
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x4F5
;    5180 			{
;    5181 			if(av_data1[sub_ind1]==0x00)ptrs[1]=" фазы C занижено";
	CALL SUBOPT_0xF6
	SBIW R30,0
	BRNE _0x4F6
	__POINTW1FN _0,325
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5182 			if(av_data1[sub_ind1]==0x01)ptrs[1]=" фазы C завышено";
_0x4F6:
	CALL SUBOPT_0xF6
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x4F7
	__POINTW1FN _0,342
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5183 			} 
_0x4F7:
;    5184 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);		
_0x4F5:
_0x4F4:
_0x4F0:
	CALL SUBOPT_0xFA
	CALL SUBOPT_0xF9
	MOVW R26,R28
	ADIW R26,5
	CALL SUBOPT_0xF8
	CALL _bgnd_par
;    5185 		} 
;    5186 
;    5187 	else if(av_code[sub_ind1]==AVAR_CHER) //чередование
	RJMP _0x4F8
_0x4EC:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0x6)
	LDI  R26,HIGH(0x6)
	CPC  R31,R26
	BRNE _0x4F9
;    5188 		{
;    5189 		ptrs[0]="  Неправильное  ";
	__POINTW1FN _0,359
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5190 		ptrs[1]=" чередование фаз";
	__POINTW1FN _0,376
	CALL SUBOPT_0xF5
;    5191 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5192 		} 
;    5193 
;    5194 	else if(av_code[sub_ind1]==AVAR_HEAT) //горячо
	RJMP _0x4FA
_0x4F9:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0x7)
	LDI  R26,HIGH(0x7)
	CPC  R31,R26
	BRNE _0x4FB
;    5195 		{
;    5196 		ptrs[0]="  Температура   ";
	__POINTW1FN _0,393
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5197 		ptrs[1]=" завышена    gC ";
	__POINTW1FN _0,410
	CALL SUBOPT_0xF5
;    5198 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5199 		int2lcd(av_data1[sub_ind1],'@',0);
	CALL SUBOPT_0xF6
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL SUBOPT_0xFB
;    5200 		lcd_buffer[find('g')]=2;
;    5201 		} 
;    5202 		
;    5203 	else if(av_code[sub_ind1]==AVAR_COOL) //холодно
	RJMP _0x4FC
_0x4FB:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0x8)
	LDI  R26,HIGH(0x8)
	CPC  R31,R26
	BRNE _0x4FD
;    5204 		{
;    5205 		ptrs[0]="  Температура   ";
	__POINTW1FN _0,393
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5206 		ptrs[1]=" занижена    gC ";
	__POINTW1FN _0,427
	CALL SUBOPT_0xF5
;    5207 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5208 		int2lcd(av_data1[sub_ind1],'@',0);
	CALL SUBOPT_0xF6
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL SUBOPT_0xFB
;    5209 		lcd_buffer[find('g')]=2;
;    5210 		}	
;    5211 		
;    5212 
;    5213 	else if(av_code[sub_ind1]==0x0a) //сухой ход
	RJMP _0x4FE
_0x4FD:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x4FF
;    5214 		{
;    5215 		
;    5216 		ptrs[0]="    Авария!!!   ";
	__POINTW1FN _0,444
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5217 		ptrs[1]="    Сухой ход   ";
	__POINTW1FN _0,461
	CALL SUBOPT_0xF5
;    5218 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5219 		} 
;    5220 	
;    5221   	else if(av_code[sub_ind1]==AVAR_P_SENS)
	RJMP _0x500
_0x4FF:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x501
;    5222 		{
;    5223 		ptrs[0]=" Авария датчика ";
	__POINTW1FN _0,478
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5224 		ptrs[1]="давления     @мА";
	__POINTW1FN _0,495
	CALL SUBOPT_0xF5
;    5225 		bgnd_par(ptrs[index_set],ptrs[index_set+1]); 
;    5226 		int2lcd(av_data0[sub_ind1],'@',1);
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xFC
;    5227 		}       
;    5228 		
;    5229   	else if(av_code[sub_ind1]==AVAR_P_MIN)
	RJMP _0x502
_0x501:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0xB)
	LDI  R26,HIGH(0xB)
	CPC  R31,R26
	BRNE _0x503
;    5230 		{
;    5231 		ptrs[0]="    Давление    ";
	__POINTW1FN _0,512
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5232 		ptrs[1]="занижено   @атм.";
	__POINTW1FN _0,529
	CALL SUBOPT_0xF5
;    5233 		bgnd_par(ptrs[index_set],ptrs[index_set+1]); 
;    5234 		int2lcd(av_data0[sub_ind1],'@',1);
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xFC
;    5235 		}    
;    5236 		
;    5237   	else if(av_code[sub_ind1]==AVAR_P_MAX)
	RJMP _0x504
_0x503:
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0xC)
	LDI  R26,HIGH(0xC)
	CPC  R31,R26
	BRNE _0x505
;    5238 		{
;    5239 		ptrs[0]="    Давление    ";
	__POINTW1FN _0,512
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5240 		ptrs[1]="завышено   @атм.";
	__POINTW1FN _0,546
	CALL SUBOPT_0xF5
;    5241 		bgnd_par(ptrs[index_set],ptrs[index_set+1]); 
;    5242 		int2lcd(av_data0[sub_ind1],'@',1);
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xFC
;    5243 		}    				
;    5244 
;    5245 	else if((av_code[sub_ind1]&0x1f)==AVAR_I_MIN)//недогруз насоса
	RJMP _0x506
_0x505:
	CALL SUBOPT_0xF4
	ANDI R30,LOW(0x1F)
	ANDI R31,HIGH(0x1F)
	CPI  R30,LOW(0x9)
	LDI  R26,HIGH(0x9)
	CPC  R31,R26
	BRNE _0x507
;    5246 		{
;    5247 		ptrs[0]=" Двигатель N&   ";
	__POINTW1FN _0,563
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5248 		ptrs[1]="ток занижен   @А";
	__POINTW1FN _0,580
	CALL SUBOPT_0xF5
;    5249 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5250 		int2lcd(av_data0[sub_ind1],'@',1);
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xFC
;    5251 		}  
;    5252 
;    5253 	else if((av_code[sub_ind1]&0x1f)==AVAR_I_MAX)//превышение тока
	RJMP _0x508
_0x507:
	CALL SUBOPT_0xF4
	ANDI R30,LOW(0x1F)
	ANDI R31,HIGH(0x1F)
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x509
;    5254 		{
;    5255 		ptrs[0]=" Двигатель N&   ";
	__POINTW1FN _0,563
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5256 		ptrs[1]="ток завышен   @А";
	__POINTW1FN _0,597
	CALL SUBOPT_0xF5
;    5257 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5258 		int2lcd(av_data0[sub_ind1],'@',1);
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xFC
;    5259 		}  
;    5260 
;    5261 	else if((av_code[sub_ind1]&0x1f)==AVAR_I_LOG)//тепловушка
	RJMP _0x50A
_0x509:
	CALL SUBOPT_0xF4
	ANDI R30,LOW(0x1F)
	ANDI R31,HIGH(0x1F)
	CPI  R30,LOW(0x5)
	LDI  R26,HIGH(0x5)
	CPC  R31,R26
	BRNE _0x50B
;    5262 		{
;    5263 		ptrs[0]=" Двигатель N&   ";
	__POINTW1FN _0,563
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5264 		ptrs[1]="сработала защита";
	__POINTW1FN _0,614
	CALL SUBOPT_0xF5
;    5265 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5266 		int2lcd(av_data0[sub_ind1],'@',1);
	CALL SUBOPT_0xF7
	CALL SUBOPT_0xFC
;    5267 		}  
;    5268 		
;    5269 /*	else if((av_code[sub_ind1]==0x13)||(av_code[sub_ind1]==0x23))//перегрев
;    5270 		{
;    5271 		ptrs[0]=" Двигатель N!   ";
;    5272 		ptrs[1]=sm416;
;    5273 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5274 		}   */
;    5275 /*	else if((av_code[sub_ind1]==0x1c)||(av_code[sub_ind1]==0x2c))//перекос токов
;    5276 		{
;    5277 		ptrs[0]=" Двигатель N!   ";
;    5278 		ptrs[1]=sm415;
;    5279 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5280 		}*/ 						
;    5281 
;    5282 	   /*		else if((av_code[sub_ind1]==0x1a)||(av_code[sub_ind1]==0x2a))//влажность
;    5283 		{
;    5284 		ptrs[0]=" Двигатель N!   ";
;    5285 		ptrs[1]=sm417;
;    5286 		bgnd_par(ptrs[index_set],ptrs[index_set+1]);
;    5287 		} */
;    5288 	
;    5289 
;    5290 		       
;    5291 		
;    5292 				
;    5293 	int2lcd(av_code[sub_ind1]>>5,'&',0);
_0x50B:
_0x50A:
_0x508:
_0x506:
_0x504:
_0x502:
_0x500:
_0x4FE:
_0x4FC:
_0x4FA:
_0x4F8:
_0x4EB:
_0x4DD:
	CALL SUBOPT_0xF4
	ASR  R31
	ROR  R30
	CALL __ASRW4
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(38)
	CALL SUBOPT_0xEC
;    5294 	if(index_set==1)
	LDS  R26,_index_set
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x50C
;    5295 		{
;    5296 		int2lcd(av_hour[sub_ind1],'@',0);
	LDS  R26,_sub_ind1
	LDI  R27,0
	SUBI R26,LOW(-_av_hour)
	SBCI R27,HIGH(-_av_hour)
	CALL __EEPROMRDB
	CALL SUBOPT_0xFD
	CALL SUBOPT_0xFE
;    5297 		int2lcd(av_min[sub_ind1],'#',0);
	CALL SUBOPT_0xE5
	CALL SUBOPT_0xE6
	CALL SUBOPT_0xFE
;    5298 		int2lcd(av_sec[sub_ind1],'$',0);
	SUBI R26,LOW(-_av_sec)
	SBCI R27,HIGH(-_av_sec)
	CALL __EEPROMRDB
	CALL SUBOPT_0xFF
	CALL SUBOPT_0xFE
;    5299 		int2lcd(av_day[sub_ind1],'%',0);
	CALL SUBOPT_0xE7
	CALL SUBOPT_0xEA
	CALL SUBOPT_0xFE
;    5300 		int2lcd(av_year[sub_ind1],'^',0);
	CALL SUBOPT_0xEB
	LDI  R30,LOW(94)
	CALL SUBOPT_0xEC
;    5301 		 	
;    5302 		lcd_buffer[27]=sm_mont[av_month[sub_ind1]-1,0];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x100
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,27
;    5303 		lcd_buffer[28]=sm_mont[av_month[sub_ind1]-1,1];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x100
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,1
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,28
;    5304 		lcd_buffer[29]=sm_mont[av_month[sub_ind1]-1,2];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x100
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,2
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,29
;    5305 	     }
;    5306 	}
_0x50C:
;    5307 
;    5308 else if(ind==iSet)
	JMP  _0x50D
_0x4DB:
	LDI  R30,LOW(34)
	CP   R30,R13
	BREQ PC+3
	JMP _0x50E
;    5309      {
;    5310      if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x50F
;    5311      	{  
;    5312      	if(EE_MODE==emAVT)ptrs[0]=" Режим   автомат";
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x510
	__POINTW1FN _0,631
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5313      	else if(EE_MODE==emMNL)ptrs[0]=" Режим   ручной ";
	RJMP _0x511
_0x510:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x512
	__POINTW1FN _0,648
	RJMP _0xB63
;    5314 		else ptrs[0]=" Режим      тест";
_0x512:
	__POINTW1FN _0,665
_0xB63:
	STD  Y+3,R30
	STD  Y+3+1,R31
_0x511:
;    5315 		ptrs[1]="                ";
	__POINTW1FN _0,223
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5316 		bgnd_par(ptrs[0],ptrs[1]);
	CALL SUBOPT_0xE0
;    5317      	}
;    5318      else if(sub_ind==1)
	RJMP _0x514
_0x50F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x515
;    5319      	{ 
;    5320      	ptrs[0]=" Время и дата   ";
	__POINTW1FN _0,682
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5321 		ptrs[1]="0@:0#:0$ 0%  &0^";
	__POINTW1FN _0,53
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5322 		bgnd_par(ptrs[0],ptrs[1]);
	CALL SUBOPT_0xE0
;    5323 		
;    5324 		int2lcd(_hour,'@',0);
	LDS  R30,__hour
	CALL SUBOPT_0xFD
	CALL SUBOPT_0x102
;    5325 		int2lcd(_min,'#',0);
	CALL SUBOPT_0x103
;    5326 		int2lcd(_sec,'$',0);
	CALL SUBOPT_0x104
;    5327 		int2lcd(_day,'%',0);
	CALL SUBOPT_0x105
;    5328 		int2lcd(_year,'^',0);
;    5329 	
;    5330  		lcd_buffer[27]=sm_mont[_month-1,0];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,27
;    5331 		lcd_buffer[28]=sm_mont[_month-1,1];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,1
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,28
;    5332 		lcd_buffer[29]=sm_mont[_month-1,2];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,2
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,29
;    5333      	}	
;    5334      else if(sub_ind==2)
	RJMP _0x516
_0x515:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0x517
;    5335      	{
;    5336    	
;    5337      	if(TEMPER_SIGN==0)ptrs[0]="Климат   внутр. ";
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x518
	__POINTW1FN _0,699
	RJMP _0xB64
;    5338  		else ptrs[0]="Климат   внешн. ";     	
_0x518:
	__POINTW1FN _0,716
_0xB64:
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5339      	ptrs[1]="0!.0@(0#.$)0%.0^";
	__POINTW1FN _0,733
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5340 		bgnd_par(ptrs[0],ptrs[1]);
	CALL SUBOPT_0xE0
;    5341 		int2lcd(AV_TEMPER_COOL,'!',0);
	LDI  R26,LOW(_AV_TEMPER_COOL)
	LDI  R27,HIGH(_AV_TEMPER_COOL)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5342 		int2lcd(T_ON_WARM,'@',0);
	CALL SUBOPT_0x107
	CALL _int2lcd
;    5343 		int2lcd(temper_result,'#',0);
	LDS  R30,_temper_result
	LDS  R31,_temper_result+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5344 		int2lcd(TEMPER_GIST,'$',0);
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5345 		int2lcd(T_ON_COOL,'%',0);
	LDI  R26,LOW(_T_ON_COOL)
	LDI  R27,HIGH(_T_ON_COOL)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xEA
	CALL _int2lcd
;    5346 		int2lcd(AV_TEMPER_HEAT,'^',0);
	LDI  R26,LOW(_AV_TEMPER_HEAT)
	LDI  R27,HIGH(_AV_TEMPER_HEAT)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(94)
	CALL SUBOPT_0xEC
;    5347      	}
;    5348      	
;    5349      else if(sub_ind==3)
	RJMP _0x51A
_0x517:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x51B
;    5350      	{     
;    5351      	if(fasing==f_ABC)ptrs[0]=" Cеть   ABC     "; 
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x51C
	__POINTW1FN _0,750
	RJMP _0xB65
;    5352 		else ptrs[0]=" Cеть   ACB     ";
_0x51C:
	__POINTW1FN _0,767
_0xB65:
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5353 		ptrs[1]="  !   @   #   $%";
	__POINTW1FN _0,784
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5354 		bgnd_par(ptrs[0],ptrs[1]);
	CALL SUBOPT_0xE0
;    5355 		int2lcd(unet[0],'!',0);
	LDS  R30,_unet
	LDS  R31,_unet+1
	CALL SUBOPT_0x106
;    5356 		int2lcd(unet[1],'@',0);
	__GETW1MN _unet,2
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5357 		int2lcd(unet[2],'#',0);
	__GETW1MN _unet,4
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5358 		int2lcd(AV_NET_PERCENT,'$',0);
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5359 		}
;    5360 		
;    5361      else if(sub_ind==4)
	RJMP _0x51E
_0x51B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x51F
;    5362      	{     
;    5363 		bgnd_par(" Давление  !    ","@/  #(  $)/%    ");
	__POINTW1FN _0,801
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,818
	CALL SUBOPT_0x108
;    5364      	int2lcd(P_SENS,'!',0);
;    5365 		int2lcd(P_MIN/10,'@',0);
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5366 		int2lcd(P_MAX/10,'%',0);
	LDI  R26,LOW(_P_MAX)
	LDI  R27,HIGH(_P_MAX)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	CALL SUBOPT_0xEA
	CALL _int2lcd
;    5367 		int2lcd(p/10,'$',1);
	CALL SUBOPT_0x10A
	LDI  R30,LOW(36)
	CALL SUBOPT_0x10B
;    5368 		}		
;    5369 
;    5370      else if(sub_ind==5)
	RJMP _0x520
_0x51F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BREQ PC+3
	JMP _0x521
;    5371      	{ 
;    5372      	bgnd_par(" Насосов !  @  #","$(  %)(  &) >   ");  
	__POINTW1FN _0,835
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,852
	CALL SUBOPT_0x10C
;    5373           int2lcd(EE_DV_NUM,'!',0);
	LDI  R30,LOW(33)
	CALL SUBOPT_0xEC
;    5374           if(RESURS_CNT[0]>=10)int2lcd(RESURS_CNT[0]/10,'@',0);
	CALL SUBOPT_0x10D
	BRLO _0x522
	CALL SUBOPT_0x10E
	CALL SUBOPT_0x10F
	LDI  R30,LOW(0)
	RJMP _0xB66
;    5375           else int2lcd(RESURS_CNT[0],'@',1);
_0x522:
	LDI  R26,LOW(_RESURS_CNT)
	LDI  R27,HIGH(_RESURS_CNT)
	CALL __EEPROMRDW
	CALL SUBOPT_0x10F
	LDI  R30,LOW(1)
_0xB66:
	ST   -Y,R30
	CALL _int2lcd
;    5376           if(RESURS_CNT[1]>=10)int2lcd(RESURS_CNT[1]/10,'#',0);
	__POINTW2MN _RESURS_CNT,2
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRLO _0x524
	__POINTW2MN _RESURS_CNT,2
	CALL SUBOPT_0x110
	CALL SUBOPT_0x111
	LDI  R30,LOW(0)
	RJMP _0xB67
;    5377           else int2lcd(RESURS_CNT[1],'#',1);
_0x524:
	__POINTW2MN _RESURS_CNT,2
	CALL __EEPROMRDW
	CALL SUBOPT_0x111
	LDI  R30,LOW(1)
_0xB67:
	ST   -Y,R30
	CALL _int2lcd
;    5378       	int2lcd(Idmin/10,'$',0);
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5379       	int2lcd(Id[0],'%',1);
	LDS  R30,_Id
	LDS  R31,_Id+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(37)
	CALL SUBOPT_0x10B
;    5380       	int2lcd(Id[1],'&',1);
	__GETW1MN _Id,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(38)
	CALL SUBOPT_0x10B
;    5381       	int2lcd(Idmax/10,'>',0);      	
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	LDI  R30,LOW(62)
	CALL SUBOPT_0xEC
;    5382 		}
;    5383 			
;    5384      else if(sub_ind==6)
	RJMP _0x526
_0x521:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x527
;    5385      	{ 
;    5386      	bgnd_par(" Ступ.пуск   !а.","  @а  #сек  $Гц ");  
	__POINTW1FN _0,869
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,886
	CALL SUBOPT_0x112
;    5387           int2lcd(SS_LEVEL,'!',1); 
;    5388           int2lcd(SS_STEP,'@',1);
	LDI  R26,LOW(_SS_STEP)
	LDI  R27,HIGH(_SS_STEP)
	CALL __EEPROMRDW
	CALL SUBOPT_0xFC
;    5389           int2lcd(SS_TIME,'#',0);
	LDI  R26,LOW(_SS_TIME)
	LDI  R27,HIGH(_SS_TIME)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5390           int2lcd(SS_FRIQ,'$',0);    	
	LDI  R26,LOW(_SS_FRIQ)
	LDI  R27,HIGH(_SS_FRIQ)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5391 		}	
;    5392 
;    5393      else if(sub_ind==7)
	RJMP _0x528
_0x527:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x529
;    5394      	{ 
;    5395      	bgnd_par(" Переключение   ","  насосов       ");  
	__POINTW1FN _0,903
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,920
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5396   	
;    5397 		}
;    5398 
;    5399      else if(sub_ind==8)
	RJMP _0x52A
_0x529:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x8)
	BRNE _0x52B
;    5400      	{
;    5401      	if(DVCH==dvch_ON)ptrs[0]=" Вкл.    0!.0@  "; 
	LDI  R26,LOW(_DVCH)
	LDI  R27,HIGH(_DVCH)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x52C
	__POINTW1FN _0,937
	RJMP _0xB68
;    5402      	else ptrs[0]=" Выкл.   0!.0@  ";
_0x52C:
	__POINTW1FN _0,954
_0xB68:
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5403      	bgnd_par(" Смена насосов  ",ptrs[0]);
	__POINTW1FN _0,971
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+5
	LDD  R31,Y+5+1
	CALL SUBOPT_0x113
;    5404      	int2lcd(DVCH_TIME/60,'!',0);
;    5405      	int2lcd(DVCH_TIME%60,'@',0);  
	CALL SUBOPT_0x114
	CALL _int2lcd
;    5406   	
;    5407 		}		 
;    5408      else if(sub_ind==9)
	RJMP _0x52E
_0x52B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x9)
	BRNE _0x52F
;    5409      	{
;    5410      	bgnd_par(" Частотник      ","  !/0@/#/$/0%   ");
	__POINTW1FN _0,988
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1005
	CALL SUBOPT_0x115
;    5411      	int2lcd(FP_FMIN,'!',0);
	CALL SUBOPT_0x106
;    5412      	int2lcd(FP_FMAX,'@',0);  
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5413      	int2lcd(FP_TPAD,'#',0);
	LDI  R26,LOW(_FP_TPAD)
	LDI  R27,HIGH(_FP_TPAD)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5414      	int2lcd(FP_TVOZVR,'$',0); 
	LDI  R26,LOW(_FP_TVOZVR)
	LDI  R27,HIGH(_FP_TVOZVR)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5415      	int2lcd(FP_CH,'%',0); 
	LDI  R26,LOW(_FP_CH)
	LDI  R27,HIGH(_FP_CH)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xEA
	CALL _int2lcd
;    5416      	//int2lcdxy(fp_step_num,0xf0,0);
;    5417      	}
;    5418 
;    5419      else if(sub_ind==10)
	RJMP _0x530
_0x52F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xA)
	BRNE _0x531
;    5420      	{
;    5421      	bgnd_par(" Задвижка  !    "," @       $  %   ");
	__POINTW1FN _0,1022
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1039
	CALL SUBOPT_0x116
;    5422           if(DOOR==dON)sub_bgnd("вкл",'!');
	BRNE _0x532
	__POINTW1FN _0,1056
	RJMP _0xB69
;    5423           else sub_bgnd("выкл",'!'); 
_0x532:
	__POINTW1FN _0,1060
_0xB69:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5424           if(DOOR_MODE==dmS)sub_bgnd("Синх.",'@');
	LDI  R26,LOW(_DOOR_MODE)
	LDI  R27,HIGH(_DOOR_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x534
	__POINTW1FN _0,1065
	RJMP _0xB6A
;    5425           else sub_bgnd("Асинх.",'@');
_0x534:
	__POINTW1FN _0,1071
_0xB6A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	CALL _sub_bgnd
;    5426      	int2lcd(DOOR_IMIN/10,'$',0);
	LDI  R26,LOW(_DOOR_IMIN)
	LDI  R27,HIGH(_DOOR_IMIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5427      	int2lcd(DOOR_IMAX/10,'%',0);  
	LDI  R26,LOW(_DOOR_IMAX)
	LDI  R27,HIGH(_DOOR_IMAX)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	CALL SUBOPT_0xEA
	CALL _int2lcd
;    5428      	}
;    5429      	
;    5430      else if(sub_ind==11)
	RJMP _0x536
_0x531:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xB)
	BRNE _0x537
;    5431      	{
;    5432      	bgnd_par(" Пр.пуск   !    ","  @ч.   0$.0%   ");
	__POINTW1FN _0,1078
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1095
	CALL SUBOPT_0x118
;    5433           if(PROBE==pON)sub_bgnd("вкл",'!');
	BRNE _0x538
	__POINTW1FN _0,1056
	RJMP _0xB6B
;    5434           else sub_bgnd("выкл",'!');
_0x538:
	__POINTW1FN _0,1060
_0xB6B:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5435           int2lcd(PROBE_DUTY,'@',0); 
	LDI  R26,LOW(_PROBE_DUTY)
	LDI  R27,HIGH(_PROBE_DUTY)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL SUBOPT_0x119
;    5436      	int2lcd(PROBE_TIME/60,'$',0);
	CALL SUBOPT_0x11A
	CALL SUBOPT_0x119
;    5437      	int2lcd(PROBE_TIME%60,'%',0);  
	CALL SUBOPT_0x11B
	CALL _int2lcd
;    5438      	}    
;    5439      else if(sub_ind==12)
	RJMP _0x53A
_0x537:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xC)
	BRNE _0x53B
;    5440      	{
;    5441      	bgnd_par(" Сухой ход  !   ","  @атм.  $сек.  ");
	__POINTW1FN _0,1112
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1129
	CALL SUBOPT_0x11C
;    5442         if(HH_SENS==hhWMS)sub_bgnd("wms",'!');
	BRNE _0x53C
	__POINTW1FN _0,1146
	RJMP _0xB6C
;    5443         else sub_bgnd("    ",'!');
_0x53C:
	__POINTW1FN _0,31
_0xB6C:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5444         int2lcd(HH_P,'@',1); 
	LDI  R26,LOW(_HH_P)
	LDI  R27,HIGH(_HH_P)
	CALL __EEPROMRDW
	CALL SUBOPT_0xFC
;    5445      	int2lcd(HH_TIME,'$',0);
	LDI  R26,LOW(_HH_TIME)
	LDI  R27,HIGH(_HH_TIME)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    5446   
;    5447      	}        	
;    5448 
;    5449      else if(sub_ind==13)
	RJMP _0x53E
_0x53B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xD)
	BRNE _0x53F
;    5450      	{
;    5451      	bgnd_par(" Таймер         ","                ");
	__POINTW1FN _0,1150
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,223
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5452      	} 
;    5453      else if(sub_ind==14)
	RJMP _0x540
_0x53F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xE)
	BRNE _0x541
;    5454      	{
;    5455      	bgnd_par(" Нулевая нагруз.","                ");
	__POINTW1FN _0,1167
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,223
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5456      	}   
;    5457      else if(sub_ind==15)
	RJMP _0x542
_0x541:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xF)
	BRNE _0x543
;    5458      	{
;    5459      	bgnd_par(" ПИД            ","                ");
	__POINTW1FN _0,1184
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,223
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5460      	}      	  	     	
;    5461      else if(sub_ind==16)
	RJMP _0x544
_0x543:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x10)
	BRNE _0x545
;    5462      	{     
;    5463      	bgnd_par(sm_exit,sm_);  
	CALL SUBOPT_0x11D
;    5464 		} 
;    5465 	}
_0x545:
_0x544:
_0x542:
_0x540:
_0x53E:
_0x53A:
_0x536:
_0x530:
_0x52E:
_0x52A:
_0x528:
_0x526:
_0x520:
_0x51E:
_0x51A:
_0x516:
_0x514:
;    5466 
;    5467 else if(ind==iMode_set)
	JMP  _0x546
_0x50E:
	LDI  R30,LOW(179)
	CP   R30,R13
	BRNE _0x547
;    5468 	{
;    5469 	if(EE_MODE==emAVT)ptrs[0]=" Автомат        ";
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x548
	__POINTW1FN _0,1201
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5470 	else if(EE_MODE==emMNL)ptrs[0]=" Ручной         ";
	RJMP _0x549
_0x548:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x54A
	__POINTW1FN _0,1218
	RJMP _0xB6D
;    5471 	else ptrs[0]=" Тест           ";
_0x54A:
	__POINTW1FN _0,1235
_0xB6D:
	STD  Y+3,R30
	STD  Y+3+1,R31
_0x549:
;    5472 	bgnd_par(ptrs[0],sm_);
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	CALL SUBOPT_0x11E
;    5473 	}	
;    5474 	
;    5475 else if(ind==iSetT)
	JMP  _0x54C
_0x547:
	LDI  R30,LOW(155)
	CP   R30,R13
	BREQ PC+3
	JMP _0x54D
;    5476 	{
;    5477 	
;    5478 	if(index_set==0)
	LDS  R30,_index_set
	CPI  R30,0
	BREQ PC+3
	JMP _0x54E
;    5479 		{
;    5480 		bgnd_par("0@:0#:0$ 0%  &0^",sm_);	
	__POINTW1FN _0,53
	CALL SUBOPT_0x11E
;    5481 		lcd_buffer[11]=sm_mont[_month-1,0];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,11
;    5482 		lcd_buffer[12]=sm_mont[_month-1,1];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,1
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,12
;    5483 		lcd_buffer[13]=sm_mont[_month-1,2];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,2
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,13
;    5484 		
;    5485 		if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x54F
;    5486 			{
;    5487 			lcd_buffer[17]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,17
;    5488 			}
;    5489 		else if(sub_ind==1)
	RJMP _0x550
_0x54F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x551
;    5490 			{
;    5491 			lcd_buffer[20]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,20
;    5492 			} 
;    5493 		else if(sub_ind==2)
	RJMP _0x552
_0x551:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x553
;    5494 			{
;    5495 			lcd_buffer[23]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,23
;    5496 			}
;    5497 		else if(sub_ind==3)
	RJMP _0x554
_0x553:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x555
;    5498 			{
;    5499 			lcd_buffer[26]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,26
;    5500 			}
;    5501 		else if(sub_ind==4)
	RJMP _0x556
_0x555:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x557
;    5502 			{
;    5503 			lcd_buffer[28]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,28
;    5504 			}
;    5505 		else if(sub_ind==5)
	RJMP _0x558
_0x557:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x559
;    5506 			{
;    5507 			lcd_buffer[31]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,31
;    5508 			} 
;    5509 		}	
_0x559:
_0x558:
_0x556:
_0x554:
_0x552:
_0x550:
;    5510 
;    5511 	else if(index_set==1)
	RJMP _0x55A
_0x54E:
	LDS  R26,_index_set
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0x55B
;    5512 		{
;    5513 		bgnd_par("0%  &0^ !       ",sm_);	
	__POINTW1FN _0,1252
	CALL SUBOPT_0x11E
;    5514 		lcd_buffer[2]=sm_mont[_month-1,0];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,2
;    5515 		lcd_buffer[3]=sm_mont[_month-1,1];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,1
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,3
;    5516 		lcd_buffer[4]=sm_mont[_month-1,2];
	LDI  R30,LOW(_sm_mont*2)
	LDI  R31,HIGH(_sm_mont*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x101
	ADIW R30,2
	LPM  R30,Z
	__PUTB1MN _lcd_buffer,4
;    5517 		
;    5518 		sub_bgnd(&__weeks_days_[_week_day,0],'!');
	LDI  R26,LOW(___weeks_days_*2)
	LDI  R27,HIGH(___weeks_days_*2)
	LDS  R30,__week_day
	LDI  R31,0
	PUSH R27
	PUSH R26
	LDI  R26,LOW(15)
	LDI  R27,HIGH(15)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0xE1
;    5519 
;    5520 		if(sub_ind==3)
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x55C
;    5521 			{
;    5522 			lcd_buffer[17]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,17
;    5523 			}
;    5524 		else if(sub_ind==4)
	RJMP _0x55D
_0x55C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x55E
;    5525 			{
;    5526 			lcd_buffer[19]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,19
;    5527 			}
;    5528 		else if(sub_ind==5)
	RJMP _0x55F
_0x55E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x560
;    5529 			{
;    5530 			lcd_buffer[22]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,22
;    5531 			}     
;    5532 		else if(sub_ind==6)
	RJMP _0x561
_0x560:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x562
;    5533 			{
;    5534 			lcd_buffer[26]=4;
	LDI  R30,LOW(4)
	__PUTB1MN _lcd_buffer,26
;    5535 			} 			
;    5536 		}			
_0x562:
_0x561:
_0x55F:
_0x55D:
;    5537 
;    5538 
;    5539 
;    5540 	int2lcd(_hour,'@',0);
_0x55B:
_0x55A:
	LDS  R30,__hour
	CALL SUBOPT_0xFD
	CALL SUBOPT_0x102
;    5541 	int2lcd(_min,'#',0);
	CALL SUBOPT_0x103
;    5542 	int2lcd(_sec,'$',0);
	CALL SUBOPT_0x104
;    5543 	int2lcd(_day,'%',0);
	CALL SUBOPT_0x105
;    5544 	int2lcd(_year,'^',0);
;    5545 	
;    5546 	//int2lcdxy(_week_day,0x31,0);
;    5547 	
;    5548      //char2lcdhxy(time_sezon,0xc1);
;    5549 	
;    5550  
;    5551 	}	
;    5552 
;    5553 else if(ind==iTemper_set)
	RJMP _0x563
_0x54D:
	LDI  R30,LOW(178)
	CP   R30,R13
	BREQ PC+3
	JMP _0x564
;    5554 	{
;    5555 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x565
;    5556 		{
;    5557      	if(TEMPER_SIGN==0)bgnd_par(" Датчик - внутр.",sm_);
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x566
	__POINTW1FN _0,1269
	RJMP _0xB6E
;    5558  		else bgnd_par(" Датчик - внешн.",sm_);   
_0x566:
	__POINTW1FN _0,1286
_0xB6E:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x11F
;    5559 		} 
;    5560 	else if(sub_ind==1)
	RJMP _0x568
_0x565:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x569
;    5561     		{
;    5562 		bgnd_par("  Авария холод  ","            @gC ");
	__POINTW1FN _0,1303
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1320
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5563 		int2lcd(AV_TEMPER_COOL,'@',0);
	LDI  R26,LOW(_AV_TEMPER_COOL)
	LDI  R27,HIGH(_AV_TEMPER_COOL)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5564 		} 
;    5565     	else if(sub_ind==2)
	RJMP _0x56A
_0x569:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x56B
;    5566     		{
;    5567 		bgnd_par(" Вкл. отопителя ","            @gC ");
	__POINTW1FN _0,1337
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1320
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5568 		int2lcd(T_ON_WARM,'@',0);
	CALL SUBOPT_0x107
	CALL _int2lcd
;    5569 		}	  
;    5570 	else if(sub_ind==3)
	RJMP _0x56C
_0x56B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x56D
;    5571     		{
;    5572 		bgnd_par(" Калибр.датчика ","            @gC ");
	__POINTW1FN _0,1354
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1320
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5573 		int2lcd_mm(temper_result,'@',0);
	LDS  R30,_temper_result
	LDS  R31,_temper_result+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd_mm
;    5574     		}
;    5575     	else if(sub_ind==4)
	RJMP _0x56E
_0x56D:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x56F
;    5576     		{
;    5577 		bgnd_par("Вкл. вентилятора","            @gC ");
	__POINTW1FN _0,1371
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1320
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5578 		int2lcd(T_ON_COOL,'@',0);
	LDI  R26,LOW(_T_ON_COOL)
	LDI  R27,HIGH(_T_ON_COOL)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5579 		}  
;    5580 	else if(sub_ind==5)
	RJMP _0x570
_0x56F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x571
;    5581 		{
;    5582   		bgnd_par(" Авария перегрев","            @gC ");
	__POINTW1FN _0,1388
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1320
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5583 		int2lcd(AV_TEMPER_HEAT,'@',0);
	LDI  R26,LOW(_AV_TEMPER_HEAT)
	LDI  R27,HIGH(_AV_TEMPER_HEAT)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5584     		}
;    5585 	else if(sub_ind==6)
	RJMP _0x572
_0x571:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x573
;    5586 		{
;    5587   		bgnd_par(" Гистерезис     ","            @gC ");
	__POINTW1FN _0,1405
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1320
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5588 		int2lcd(TEMPER_GIST,'@',0);
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    5589     		}        
;    5590 	else if(sub_ind==7)
	RJMP _0x574
_0x573:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x575
;    5591 		{
;    5592   		bgnd_par(" Выход          ",sm_);
	__POINTW1FN _0,1422
	CALL SUBOPT_0x11E
;    5593     		} 
;    5594     	lcd_buffer[find('g')]=2;	   				
_0x575:
_0x574:
_0x572:
_0x570:
_0x56E:
_0x56C:
_0x56A:
_0x568:
	LDI  R30,LOW(103)
	ST   -Y,R30
	CALL _find
	LDI  R31,0
	SUBI R30,LOW(-_lcd_buffer)
	SBCI R31,HIGH(-_lcd_buffer)
	MOVW R26,R30
	LDI  R30,LOW(2)
	ST   X,R30
;    5595    	}
;    5596 
;    5597 else if(ind==iNet_set)
	RJMP _0x576
_0x564:
	LDI  R30,LOW(158)
	CP   R30,R13
	BREQ PC+3
	JMP _0x577
;    5598 	{
;    5599 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x578
;    5600 		{
;    5601 		bgnd_par(" Допуск    !%   ",sm_);
	__POINTW1FN _0,1439
	CALL SUBOPT_0x11E
;    5602 		int2lcd(AV_NET_PERCENT,'!',0);
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5603 		} 
;    5604 	else if(sub_ind==1)
	RJMP _0x579
_0x578:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x57A
;    5605     		{
;    5606     		if(fasing==f_ABC) bgnd_par(" Фазировка  ABC ",sm_);
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x57B
	__POINTW1FN _0,1456
	RJMP _0xB6F
;    5607     		else bgnd_par(" Фазировка  ACB ",sm_);
_0x57B:
	__POINTW1FN _0,1473
_0xB6F:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x11F
;    5608    		} 
;    5609     	else if(sub_ind==2)
	RJMP _0x57D
_0x57A:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x57E
;    5610     		{
;    5611 		bgnd_par("Калибр.фазаA  !В",sm_);
	__POINTW1FN _0,1490
	CALL SUBOPT_0x11E
;    5612 		int2lcd(unet[0],'!',0);
	LDS  R30,_unet
	LDS  R31,_unet+1
	CALL SUBOPT_0x106
;    5613 		}	  
;    5614 	else if(sub_ind==3)
	RJMP _0x57F
_0x57E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x580
;    5615     		{
;    5616 		bgnd_par("Калибр.фазаB  !В",sm_);
	__POINTW1FN _0,1507
	CALL SUBOPT_0x11E
;    5617 		int2lcd(unet[1],'!',0);
	__GETW1MN _unet,2
	CALL SUBOPT_0x106
;    5618     		}
;    5619     	else if(sub_ind==4)
	RJMP _0x581
_0x580:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x582
;    5620     		{
;    5621 		bgnd_par("Калибр.фазаC  !В",sm_);
	__POINTW1FN _0,1524
	CALL SUBOPT_0x11E
;    5622 		int2lcd(unet[2],'!',0);
	__GETW1MN _unet,4
	CALL SUBOPT_0x106
;    5623 		}  
;    5624 	else if(sub_ind==5)
	RJMP _0x583
_0x582:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x584
;    5625 		{
;    5626     		bgnd_par(" Выход          ",sm_);
	__POINTW1FN _0,1422
	CALL SUBOPT_0x11E
;    5627     		}
;    5628    	}	
_0x584:
_0x583:
_0x581:
_0x57F:
_0x57D:
_0x579:
;    5629 
;    5630 else if(ind==iDavl)
	RJMP _0x585
_0x577:
	LDI  R30,LOW(117)
	CP   R30,R13
	BREQ PC+3
	JMP _0x586
;    5631 	{
;    5632 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x587
;    5633 		{
;    5634 		bgnd_par("Тип датчиков  ! ",sm_);
	__POINTW1FN _0,1541
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x108
;    5635 		int2lcd(P_SENS,'!',0);
;    5636 		} 
;    5637 	else if(sub_ind==1)
	RJMP _0x588
_0x587:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x589
;    5638     		{
;    5639     		bgnd_par("Pmin        !атм",sm_);
	__POINTW1FN _0,1558
	CALL SUBOPT_0x11E
;    5640 		int2lcd(P_MIN,'!',1);
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5641    		} 
;    5642     	else if(sub_ind==2)
	RJMP _0x58A
_0x589:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x58B
;    5643     		{
;    5644 		bgnd_par("Калибр. насухую ",sm_); 
	__POINTW1FN _0,1575
	CALL SUBOPT_0x11E
;    5645 		int2lcdxy(adc_bank_[7],0xf0,0);
	__GETW1MN _adc_bank_,14
	CALL SUBOPT_0xF3
;    5646 	       //	int2lcdxy(Kp0,0xa0,0);
;    5647 	       //	int2lcdxy(Kp1,0x50,0);
;    5648 		}
;    5649     	else if(sub_ind==3)
	RJMP _0x58C
_0x58B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x58D
;    5650     		{
;    5651 		bgnd_par("Калибровка      ","   P =     !атм."); 
	__POINTW1FN _0,1592
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1609
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5652 		int2lcd(p/10,'!',1);
	CALL SUBOPT_0x10A
	LDI  R30,LOW(33)
	CALL SUBOPT_0x10B
;    5653 		int2lcdxy(adc_bank_[7],0xf0,0);
	__GETW1MN _adc_bank_,14
	CALL SUBOPT_0xF3
;    5654 		//int2lcdxy(Kp0,0xa0,0);
;    5655 		//int2lcdxy(Kp1,0x50,0);
;    5656 		}			  
;    5657 	else if(sub_ind==4)
	RJMP _0x58E
_0x58D:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x58F
;    5658     		{
;    5659     		bgnd_par("Pmax        !атм",sm_);
	__POINTW1FN _0,1626
	CALL SUBOPT_0x11E
;    5660 		int2lcd(P_MAX,'!',1);
	LDI  R26,LOW(_P_MAX)
	LDI  R27,HIGH(_P_MAX)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5661     		}
;    5662     	else if(sub_ind==5)
	RJMP _0x590
_0x58F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x591
;    5663     		{
;    5664     		bgnd_par("Tmax_min    !сек",sm_);
	__POINTW1FN _0,1643
	CALL SUBOPT_0x11E
;    5665 		int2lcd(T_MAXMIN,'!',0);
	LDI  R26,LOW(_T_MAXMIN)
	LDI  R27,HIGH(_T_MAXMIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5666 		}  
;    5667 	else if(sub_ind==6)
	RJMP _0x592
_0x591:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x593
;    5668 		{
;    5669     		bgnd_par("Gmax_min    !атм",sm_);
	__POINTW1FN _0,1660
	CALL SUBOPT_0x11E
;    5670 		int2lcd(G_MAXMIN,'!',1);
	LDI  R26,LOW(_G_MAXMIN)
	LDI  R27,HIGH(_G_MAXMIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5671     		}
;    5672     	else if(sub_ind==7)
	RJMP _0x594
_0x593:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x595
;    5673     		{
;    5674     		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5675 		} 
;    5676   	}
_0x595:
_0x594:
_0x592:
_0x590:
_0x58E:
_0x58C:
_0x58A:
_0x588:
;    5677 
;    5678 else if(ind==iDv_num_set)
	RJMP _0x596
_0x586:
	LDI  R30,LOW(188)
	CP   R30,R13
	BRNE _0x597
;    5679 	{
;    5680 	bgnd_par("Насосов    !    ",sm_);
	__POINTW1FN _0,1677
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x10C
;    5681 	int2lcd(EE_DV_NUM,'!',0);
	LDI  R30,LOW(33)
	CALL SUBOPT_0xEC
;    5682 	} 
;    5683 else if(ind==iDv_start_set)
	RJMP _0x598
_0x597:
	LDI  R30,LOW(189)
	CP   R30,R13
	BRNE _0x599
;    5684 	{
;    5685 	bgnd_par("Звезда-треугольн","         !      ");
	__POINTW1FN _0,1694
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1711
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5686 	if(STAR_TRIAN==stON)sub_bgnd("вкл.",'!');
	LDI  R26,LOW(_STAR_TRIAN)
	LDI  R27,HIGH(_STAR_TRIAN)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x59A
	__POINTW1FN _0,1728
	RJMP _0xB70
;    5687 	else sub_bgnd("выкл.",'!');
_0x59A:
	__POINTW1FN _0,1733
_0xB70:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5688 	} 
;    5689 else if(ind==iDv_av_log)
	RJMP _0x59C
_0x599:
	LDI  R30,LOW(187)
	CP   R30,R13
	BRNE _0x59D
;    5690 	{
;    5691 	bgnd_par(" Аварии по току "," !              ");
	__POINTW1FN _0,1739
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1756
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5692 	if(DV_AV_SET==dasLOG)sub_bgnd("логические",'!');
	LDI  R26,LOW(_DV_AV_SET)
	LDI  R27,HIGH(_DV_AV_SET)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x59E
	__POINTW1FN _0,1773
	RJMP _0xB71
;    5693 	else sub_bgnd("по датчикам",'!');
_0x59E:
	__POINTW1FN _0,1784
_0xB71:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5694 	}
;    5695 else if(ind==iDv_imin_set)
	RJMP _0x5A0
_0x59D:
	LDI  R30,LOW(190)
	CP   R30,R13
	BRNE _0x5A1
;    5696 	{ 
;    5697 	bgnd_par(" Iнмin.       #A",sm_);
	__POINTW1FN _0,1796
	CALL SUBOPT_0x11E
;    5698 	int2lcd(Idmin,'#',1);
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	CALL SUBOPT_0x121
;    5699 	}
;    5700 else if(ind==iDv_imax_set)
	RJMP _0x5A2
_0x5A1:
	LDI  R30,LOW(191)
	CP   R30,R13
	BRNE _0x5A3
;    5701 	{  
;    5702  	bgnd_par(" Iнмax.       #A",sm_);
	__POINTW1FN _0,1813
	CALL SUBOPT_0x11E
;    5703  	int2lcd(Idmax,'#',1);	
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	CALL SUBOPT_0x121
;    5704 	} 
;    5705 else if(ind==iDv_mode_set)
	RJMP _0x5A4
_0x5A3:
	LDI  R30,LOW(192)
	CP   R30,R13
	BRNE _0x5A5
;    5706 	{
;    5707 	bgnd_par("Реж.насос# !    ",sm_);
	__POINTW1FN _0,1830
	CALL SUBOPT_0x11E
;    5708 	if(DV_MODE[sub_ind]==dm_AVT)sub_bgnd("авт.",'!');
	CALL SUBOPT_0x122
	CPI  R30,LOW(0x55)
	BRNE _0x5A6
	__POINTW1FN _0,1847
	RJMP _0xB72
;    5709 	else sub_bgnd("ручн.",'!');
_0x5A6:
	__POINTW1FN _0,1852
_0xB72:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5710 	int2lcd(sub_ind+1,'#',0);
	CALL SUBOPT_0x123
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5711 	}
;    5712 else if(ind==iDv_resurs_set)
	RJMP _0x5A8
_0x5A5:
	LDI  R30,LOW(193)
	CP   R30,R13
	BRNE _0x5A9
;    5713 	{
;    5714 	if(index_set==0)bgnd_par(" Сброс наработки"," насоса!    нет ");
	LDS  R30,_index_set
	CPI  R30,0
	BRNE _0x5AA
	__POINTW1FN _0,1858
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1875
	RJMP _0xB73
;    5715  	else bgnd_par(" Сброс наработки"," насоса!    да  ");
_0x5AA:
	__POINTW1FN _0,1858
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1892
_0xB73:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5716  	int2lcd(sub_ind+1,'!',0); 
	CALL SUBOPT_0x123
	CALL SUBOPT_0x106
;    5717 	}
;    5718 else if(ind==iDv_i_kalibr)
	RJMP _0x5AC
_0x5A9:
	LDI  R30,LOW(194)
	CP   R30,R13
	BRNE _0x5AD
;    5719 	{
;    5720 	if(index_set==0)bgnd_par(" Калибровка I#A ","     ! A        ");
	LDS  R30,_index_set
	CPI  R30,0
	BRNE _0x5AE
	__POINTW1FN _0,1909
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1926
	RJMP _0xB74
;    5721 	else bgnd_par(" Калибровка I#C ","     @ A        ");
_0x5AE:
	__POINTW1FN _0,1943
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,1960
_0xB74:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5722 	int2lcd(Ida[sub_ind],'!',1);
	LDS  R30,_sub_ind
	CALL SUBOPT_0xB0
	CALL SUBOPT_0x120
;    5723 	int2lcd(Idc[sub_ind],'@',1);
	LDS  R30,_sub_ind
	CALL SUBOPT_0xB1
	CALL SUBOPT_0xFC
;    5724 	int2lcd(sub_ind+1,'#',0); 
	CALL SUBOPT_0x123
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5725 	//int2lcdxy(Kida[sub_ind],0x30,0);
;    5726 	//int2lcdxy(Kidc[sub_ind],0x70,0);
;    5727 	}
;    5728 else if(ind==iDv_c_set)
	RJMP _0x5B0
_0x5AD:
	LDI  R30,LOW(195)
	CP   R30,R13
	BRNE _0x5B1
;    5729 	{
;    5730 	bgnd_par(" С!Н            ","                ");
	__POINTW1FN _0,1977
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,223
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5731  	int2lcd(C1N,'!',0);
	LDI  R26,LOW(_C1N)
	LDI  R27,HIGH(_C1N)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5732 	}
;    5733 else if(ind==iDv_ch_set)
	RJMP _0x5B2
_0x5B1:
	LDI  R30,LOW(196)
	CP   R30,R13
	BRNE _0x5B3
;    5734 	{
;    5735 	bgnd_par(" Ч!Н            ","                ");
	__POINTW1FN _0,1994
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,223
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5736  	int2lcd(CH1N,'!',0);
	LDI  R26,LOW(_CH1N)
	LDI  R27,HIGH(_CH1N)
	CALL __EEPROMRDB
	LDI  R31,0
	CALL SUBOPT_0x106
;    5737 	}	
;    5738 else if(ind==iDv_out)
	RJMP _0x5B4
_0x5B3:
	LDI  R30,LOW(197)
	CP   R30,R13
	BRNE _0x5B5
;    5739     	{
;    5740     	bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5741 	} 
;    5742 								
;    5743 
;    5744 					
;    5745 else if(ind==iStep_start)
	RJMP _0x5B6
_0x5B5:
	LDI  R30,LOW(170)
	CP   R30,R13
	BREQ PC+3
	JMP _0x5B7
;    5746 	{
;    5747 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x5B8
;    5748 		{
;    5749 		bgnd_par(" Уровень        ","   Pп =    !атм.");
	__POINTW1FN _0,2011
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,2028
	CALL SUBOPT_0x112
;    5750 		int2lcd(SS_LEVEL,'!',1);
;    5751 		}  
;    5752 	else if(sub_ind==1)
	RJMP _0x5B9
_0x5B8:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x5BA
;    5753 		{
;    5754 		bgnd_par(" Прирост        ","   Pпр =   !атм.");
	__POINTW1FN _0,2045
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,2062
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5755 		int2lcd(SS_STEP,'!',1);
	LDI  R26,LOW(_SS_STEP)
	LDI  R27,HIGH(_SS_STEP)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5756 		}       
;    5757 	else if(sub_ind==2)
	RJMP _0x5BB
_0x5BA:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x5BC
;    5758 		{
;    5759 		bgnd_par(" Время          ","   Тпр =   !сек.");
	__POINTW1FN _0,2079
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,2096
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5760 		int2lcd(SS_TIME,'!',0);
	LDI  R26,LOW(_SS_TIME)
	LDI  R27,HIGH(_SS_TIME)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5761 		} 
;    5762 	else if(sub_ind==3)
	RJMP _0x5BD
_0x5BC:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x5BE
;    5763 		{
;    5764 		bgnd_par(" Частота        ","   Fпр =   !Гц  ");
	__POINTW1FN _0,2113
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,2130
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5765 		int2lcd(SS_FRIQ,'!',0);
	LDI  R26,LOW(_SS_FRIQ)
	LDI  R27,HIGH(_SS_FRIQ)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5766 		}     		    		
;    5767 	else if(sub_ind==4)
	RJMP _0x5BF
_0x5BE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x5C0
;    5768 		{
;    5769 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5770 		}
;    5771     	}
_0x5C0:
_0x5BF:
_0x5BD:
_0x5BB:
_0x5B9:
;    5772 
;    5773 else if(ind==iDv_change)
	RJMP _0x5C1
_0x5B7:
	LDI  R30,LOW(176)
	CP   R30,R13
	BREQ PC+3
	JMP _0x5C2
;    5774 	{
;    5775 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x5C3
;    5776 		{
;    5777 		bgnd_par(" Tверх   !м.0@с.",sm_);
	__POINTW1FN _0,2147
	CALL SUBOPT_0x11E
;    5778 		int2lcd(DVCH_T_UP/60,'!',0);
	CALL SUBOPT_0x124
	CALL __DIVW21
	CALL SUBOPT_0x106
;    5779 		int2lcd(DVCH_T_UP%60,'@',0);
	CALL SUBOPT_0x124
	CALL SUBOPT_0x125
	CALL _int2lcd
;    5780 		}  
;    5781 	else if(sub_ind==1)
	RJMP _0x5C4
_0x5C3:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x5C5
;    5782 		{
;    5783 		bgnd_par(" Tниз    !м.0@с.",sm_);
	__POINTW1FN _0,2164
	CALL SUBOPT_0x11E
;    5784 		int2lcd(DVCH_T_DOWN/60,'!',0);
	CALL SUBOPT_0x126
	CALL __DIVW21
	CALL SUBOPT_0x106
;    5785 		int2lcd(DVCH_T_DOWN%60,'@',0);
	CALL SUBOPT_0x126
	CALL SUBOPT_0x125
	CALL _int2lcd
;    5786 		}       
;    5787 	else if(sub_ind==2)
	RJMP _0x5C6
_0x5C5:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x5C7
;    5788 		{
;    5789 		bgnd_par(" Pкр.      !атм.",sm_);
	__POINTW1FN _0,2181
	CALL SUBOPT_0x11E
;    5790 		int2lcd(DVCH_P_KR,'!',1);
	LDI  R26,LOW(_DVCH_P_KR)
	LDI  R27,HIGH(_DVCH_P_KR)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5791 		} 
;    5792 	else if(sub_ind==3)
	RJMP _0x5C8
_0x5C7:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x5C9
;    5793 		{
;    5794 		bgnd_par(" Kp        !    ",sm_);
	__POINTW1FN _0,2198
	CALL SUBOPT_0x11E
;    5795 		int2lcd(DVCH_KP,'!',1);
	LDI  R26,LOW(_DVCH_KP)
	LDI  R27,HIGH(_DVCH_KP)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5796 		}     		    		
;    5797 	else if(sub_ind==4)
	RJMP _0x5CA
_0x5C9:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x5CB
;    5798 		{
;    5799 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5800 		}
;    5801     	}	
_0x5CB:
_0x5CA:
_0x5C8:
_0x5C6:
_0x5C4:
;    5802 
;    5803 else if(ind==iDv_change1)
	RJMP _0x5CC
_0x5C2:
	LDI  R30,LOW(177)
	CP   R30,R13
	BRNE _0x5CD
;    5804 	{
;    5805 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x5CE
;    5806 		{
;    5807 		bgnd_par(" Tсм   0!ч.0@мин",sm_);
	__POINTW1FN _0,2215
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x113
;    5808 		int2lcd(DVCH_TIME/60,'!',0);
;    5809      	int2lcd(DVCH_TIME%60,'@',0); 
	CALL SUBOPT_0x114
	CALL _int2lcd
;    5810 		}  
;    5811 	else if(sub_ind==1)
	RJMP _0x5CF
_0x5CE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x5D0
;    5812 		{
;    5813 		if(DVCH==dvch_ON)bgnd_par("Разрешение  вкл.",sm_);
	LDI  R26,LOW(_DVCH)
	LDI  R27,HIGH(_DVCH)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x5D1
	__POINTW1FN _0,2232
	RJMP _0xB75
;    5814 		else bgnd_par("Разрешение выкл.",sm_);
_0x5D1:
	__POINTW1FN _0,2249
_0xB75:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x11F
;    5815 		}       
;    5816 	else if(sub_ind==2)
	RJMP _0x5D3
_0x5D0:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x5D4
;    5817 		{
;    5818 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5819 		}
;    5820     	}	
_0x5D4:
_0x5D3:
_0x5CF:
;    5821 
;    5822 else if(ind==iFp_set)
	RJMP _0x5D5
_0x5CD:
	LDI  R30,LOW(181)
	CP   R30,R13
	BREQ PC+3
	JMP _0x5D6
;    5823 	{
;    5824 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x5D7
;    5825 		{
;    5826 		bgnd_par("Fmin    #(  !)Гц",sm_);
	__POINTW1FN _0,2266
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x115
;    5827 		int2lcd(FP_FMIN,'#',0);
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5828 		int2lcd(__fp_fmin,'!',0);
	LDS  R30,___fp_fmin
	LDS  R31,___fp_fmin+1
	CALL SUBOPT_0x106
;    5829 		read_parametr=204;
	LDI  R30,LOW(204)
	LDI  R31,HIGH(204)
	STS  _read_parametr,R30
	STS  _read_parametr+1,R31
;    5830 		}  
;    5831 	else if(sub_ind==1)
	RJMP _0x5D8
_0x5D7:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x5D9
;    5832 		{
;    5833 		bgnd_par("Fmax    #(  !)Гц",sm_);
	__POINTW1FN _0,2283
	CALL SUBOPT_0x11E
;    5834 		int2lcd(FP_FMAX,'#',0);
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    5835 		int2lcd(__fp_fmax,'!',0);
	LDS  R30,___fp_fmax
	LDS  R31,___fp_fmax+1
	CALL SUBOPT_0x106
;    5836 		read_parametr=205;
	LDI  R30,LOW(205)
	LDI  R31,HIGH(205)
	STS  _read_parametr,R30
	STS  _read_parametr+1,R31
;    5837 		}       
;    5838 	else if(sub_ind==2)
	RJMP _0x5DA
_0x5D9:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x5DB
;    5839 		{
;    5840 		bgnd_par(" Tпад      !сек.",sm_);
	__POINTW1FN _0,2300
	CALL SUBOPT_0x11E
;    5841 		int2lcd(FP_TPAD,'!',0);
	LDI  R26,LOW(_FP_TPAD)
	LDI  R27,HIGH(_FP_TPAD)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5842 		} 
;    5843 	else if(sub_ind==3)
	RJMP _0x5DC
_0x5DB:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x5DD
;    5844 		{
;    5845 		bgnd_par(" Tвозвр    !сек.",sm_);
	__POINTW1FN _0,2317
	CALL SUBOPT_0x11E
;    5846 		int2lcd(FP_TVOZVR,'!',0);
	LDI  R26,LOW(_FP_TVOZVR)
	LDI  R27,HIGH(_FP_TVOZVR)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5847 		}     		    	
;    5848 	else if(sub_ind==4)
	RJMP _0x5DE
_0x5DD:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x5DF
;    5849 		{
;    5850 		bgnd_par(" Ч         !%   ",sm_);
	__POINTW1FN _0,2334
	CALL SUBOPT_0x11E
;    5851 		int2lcd(FP_CH,'!',0);
	LDI  R26,LOW(_FP_CH)
	LDI  R27,HIGH(_FP_CH)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5852 		}       
;    5853 	else if(sub_ind==5)
	RJMP _0x5E0
_0x5DF:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x5E1
;    5854 		{
;    5855 		bgnd_par(" П+        !%   ",sm_);
	__POINTW1FN _0,2351
	CALL SUBOPT_0x11E
;    5856 		int2lcd(FP_P_PL,'!',0);
	LDI  R26,LOW(_FP_P_PL)
	LDI  R27,HIGH(_FP_P_PL)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5857 		} 
;    5858 	else if(sub_ind==6)
	RJMP _0x5E2
_0x5E1:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x5E3
;    5859 		{
;    5860 		bgnd_par(" П-        !%   ",sm_);
	__POINTW1FN _0,2368
	CALL SUBOPT_0x11E
;    5861 		int2lcd(FP_P_MI,'!',0);
	LDI  R26,LOW(_FP_P_MI)
	LDI  R27,HIGH(_FP_P_MI)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5862 		}   
;    5863 	else if(sub_ind==7)
	RJMP _0x5E4
_0x5E3:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x5E5
;    5864 		{
;    5865 		bgnd_par(" Задержка       ","  сброса   !сек.");
	__POINTW1FN _0,2385
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,2402
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    5866 		int2lcd(FP_RESET_TIME,'!',0);
	LDI  R26,LOW(_FP_RESET_TIME)
	LDI  R27,HIGH(_FP_RESET_TIME)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5867 		}   		  		    			
;    5868 	else if(sub_ind==8)
	RJMP _0x5E6
_0x5E5:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x8)
	BRNE _0x5E7
;    5869 		{
;    5870 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5871 		}
;    5872     	}	
_0x5E7:
_0x5E6:
_0x5E4:
_0x5E2:
_0x5E0:
_0x5DE:
_0x5DC:
_0x5DA:
_0x5D8:
;    5873 else if(ind==iDoor_set)
	RJMP _0x5E8
_0x5D6:
	LDI  R30,LOW(182)
	CP   R30,R13
	BREQ PC+3
	JMP _0x5E9
;    5874 	{
;    5875 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x5EA
;    5876 		{
;    5877 		bgnd_par(" Состояние !    ",sm_);
	__POINTW1FN _0,2419
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x116
;    5878           if(DOOR==dON)sub_bgnd("вкл",'!');
	BRNE _0x5EB
	__POINTW1FN _0,1056
	RJMP _0xB76
;    5879           else sub_bgnd("выкл",'!');		
_0x5EB:
	__POINTW1FN _0,1060
_0xB76:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5880 		}  
;    5881 	else if(sub_ind==1)
	RJMP _0x5ED
_0x5EA:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x5EE
;    5882 		{
;    5883 		bgnd_par(" Iзmin     !A   ",sm_);
	__POINTW1FN _0,2436
	CALL SUBOPT_0x11E
;    5884 		int2lcd(DOOR_IMIN,'!',1);
	LDI  R26,LOW(_DOOR_IMIN)
	LDI  R27,HIGH(_DOOR_IMIN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5885 		}       
;    5886 	else if(sub_ind==2)
	RJMP _0x5EF
_0x5EE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x5F0
;    5887 		{
;    5888 		bgnd_par(" Iзmax     !A   ",sm_);
	__POINTW1FN _0,2453
	CALL SUBOPT_0x11E
;    5889 		int2lcd(DOOR_IMAX,'!',1);
	LDI  R26,LOW(_DOOR_IMAX)
	LDI  R27,HIGH(_DOOR_IMAX)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5890 		} 
;    5891 	else if(sub_ind==3)
	RJMP _0x5F1
_0x5F0:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x5F2
;    5892 		{
;    5893 		bgnd_par("Режим !         ",sm_);
	__POINTW1FN _0,2470
	CALL SUBOPT_0x11E
;    5894           if(DOOR_MODE==dmS)sub_bgnd("cинхронно",'!');
	LDI  R26,LOW(_DOOR_MODE)
	LDI  R27,HIGH(_DOOR_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x5F3
	__POINTW1FN _0,2487
	RJMP _0xB77
;    5895           else sub_bgnd("асинхронно",'!');
_0x5F3:
	__POINTW1FN _0,2497
_0xB77:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5896 		}     		    	
;    5897 	else if(sub_ind==4)
	RJMP _0x5F5
_0x5F2:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x5F6
;    5898 		{
;    5899 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5900 		}
;    5901     	}	  
_0x5F6:
_0x5F5:
_0x5F1:
_0x5EF:
_0x5ED:
;    5902 else if(ind==iProbe_set)
	RJMP _0x5F7
_0x5E9:
	LDI  R30,LOW(183)
	CP   R30,R13
	BREQ PC+3
	JMP _0x5F8
;    5903 	{
;    5904 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x5F9
;    5905 		{
;    5906 		bgnd_par(" Состояние !    ",sm_);
	__POINTW1FN _0,2419
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x118
;    5907           if(PROBE==pON)sub_bgnd("вкл",'!');
	BRNE _0x5FA
	__POINTW1FN _0,1056
	RJMP _0xB78
;    5908           else sub_bgnd("выкл",'!');		
_0x5FA:
	__POINTW1FN _0,1060
_0xB78:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5909 		}  
;    5910 	else if(sub_ind==1)
	RJMP _0x5FC
_0x5F9:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x5FD
;    5911 		{
;    5912 		bgnd_par(" Tисп.     !ч.  ",sm_);
	__POINTW1FN _0,2508
	CALL SUBOPT_0x11E
;    5913 		int2lcd(PROBE_DUTY,'!',0);
	LDI  R26,LOW(_PROBE_DUTY)
	LDI  R27,HIGH(_PROBE_DUTY)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5914 		}       
;    5915 	else if(sub_ind==2)
	RJMP _0x5FE
_0x5FD:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x5FF
;    5916 		{
;    5917 		bgnd_par(" Tп.п.   0$.0%  ",sm_);
	__POINTW1FN _0,2525
	CALL SUBOPT_0x11E
;    5918      	int2lcd(PROBE_TIME/60,'$',0);
	LDI  R26,LOW(_PROBE_TIME)
	LDI  R27,HIGH(_PROBE_TIME)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CALL SUBOPT_0x11A
	CALL SUBOPT_0x119
;    5919      	int2lcd(PROBE_TIME%60,'%',0);
	CALL SUBOPT_0x11B
	CALL _int2lcd
;    5920 		} 
;    5921 	else if(sub_ind==3)
	RJMP _0x600
_0x5FF:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x601
;    5922 		{
;    5923 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5924 		}
;    5925     	}	     	
_0x601:
_0x600:
_0x5FE:
_0x5FC:
;    5926 
;    5927 else if(ind==iHh_set)
	RJMP _0x602
_0x5F8:
	LDI  R30,LOW(184)
	CP   R30,R13
	BRNE _0x603
;    5928 	{
;    5929 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x604
;    5930 		{
;    5931 		bgnd_par(" Датчик   !     ",sm_);
	__POINTW1FN _0,2542
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	CALL SUBOPT_0x11C
;    5932           if(HH_SENS==hhWMS)sub_bgnd("wms",'!');
	BRNE _0x605
	__POINTW1FN _0,1146
	RJMP _0xB79
;    5933           else sub_bgnd("    ",'!');	
_0x605:
	__POINTW1FN _0,31
_0xB79:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x117
;    5934 		}  
;    5935 	else if(sub_ind==1)
	RJMP _0x607
_0x604:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x608
;    5936 		{
;    5937 		bgnd_par(" Tсх.    !сек.  ",sm_);
	__POINTW1FN _0,2559
	CALL SUBOPT_0x11E
;    5938 		int2lcd(HH_TIME,'!',0);
	LDI  R26,LOW(_HH_TIME)
	LDI  R27,HIGH(_HH_TIME)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    5939 		}       
;    5940 	else if(sub_ind==2)
	RJMP _0x609
_0x608:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x60A
;    5941 		{
;    5942 		bgnd_par(" Pвх.    !атм.  ",sm_);
	__POINTW1FN _0,2576
	CALL SUBOPT_0x11E
;    5943 		int2lcd(HH_P,'!',1);
	LDI  R26,LOW(_HH_P)
	LDI  R27,HIGH(_HH_P)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    5944 		} 
;    5945 	else if(sub_ind==3)
	RJMP _0x60B
_0x60A:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x60C
;    5946 		{
;    5947 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    5948 		}
;    5949     	}	     	  
_0x60C:
_0x60B:
_0x609:
_0x607:
;    5950 
;    5951 else if(ind==iTimer_sel)
	RJMP _0x60D
_0x603:
	LDI  R30,LOW(160)
	CP   R30,R13
	BREQ PC+3
	JMP _0x60E
;    5952 	{
;    5953 	ptrs[0]=" Pуст      !атм.";
	__POINTW1FN _0,2593
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5954 	ptrs[1]=" Понедельник    ";
	__POINTW1FN _0,2610
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5955 	ptrs[2]=" Вторник        ";
	__POINTW1FN _0,2627
	STD  Y+7,R30
	STD  Y+7+1,R31
;    5956 	ptrs[3]=" Среда          ";
	__POINTW1FN _0,2644
	STD  Y+9,R30
	STD  Y+9+1,R31
;    5957 	ptrs[4]=" Четверг        ";
	__POINTW1FN _0,2661
	STD  Y+11,R30
	STD  Y+11+1,R31
;    5958 	ptrs[5]=" Пятница        ";
	__POINTW1FN _0,2678
	STD  Y+13,R30
	STD  Y+13+1,R31
;    5959 	ptrs[6]=" Суббота        ";
	__POINTW1FN _0,2695
	STD  Y+15,R30
	STD  Y+15+1,R31
;    5960 	ptrs[7]=" Воскресенье    ";
	__POINTW1FN _0,2712
	STD  Y+17,R30
	STD  Y+17+1,R31
;    5961 	ptrs[8]=sm_exit; 
	LDI  R30,LOW(_sm_exit*2)
	LDI  R31,HIGH(_sm_exit*2)
	STD  Y+19,R30
	STD  Y+19+1,R31
;    5962 	
;    5963 	if((sub_ind-index_set)>1)index_set=sub_ind-1;
	CALL SUBOPT_0xDD
	CALL SUBOPT_0xDE
	BRSH _0x60F
	CALL SUBOPT_0xDF
;    5964 	else if(sub_ind<index_set)index_set=sub_ind;
	RJMP _0x610
_0x60F:
	CALL SUBOPT_0xDC
	BRSH _0x611
	LDS  R30,_sub_ind
	STS  _index_set,R30
;    5965 	bgnd_par(ptrs[index_set],ptrs[index_set+1]);
_0x611:
_0x610:
	CALL SUBOPT_0xFA
	CALL SUBOPT_0xF9
	MOVW R26,R28
	ADIW R26,5
	CALL SUBOPT_0xF8
	CALL _bgnd_par
;    5966 	if(index_set==sub_ind)lcd_buffer[0]=1;
	LDS  R30,_sub_ind
	LDS  R26,_index_set
	CP   R30,R26
	BRNE _0x612
	LDI  R30,LOW(1)
	STS  _lcd_buffer,R30
;    5967 	else lcd_buffer[16]=1;
	RJMP _0x613
_0x612:
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,16
_0x613:
;    5968 	
;    5969     	int2lcd(P_UST_EE/10,'!',1);
	LDI  R26,LOW(_P_UST_EE)
	LDI  R27,HIGH(_P_UST_EE)
	CALL __EEPROMRDW
	CALL SUBOPT_0x109
	LDI  R30,LOW(33)
	CALL SUBOPT_0x10B
;    5970     //	int2lcdxy(sub_ind,0x30,0);
;    5971 	}
;    5972 
;    5973 else if(ind==iTimer_set)
	RJMP _0x614
_0x60E:
	LDI  R30,LOW(185)
	CP   R30,R13
	BREQ PC+3
	JMP _0x615
;    5974 	{ 
;    5975 	if(sub_ind<5)
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRLO PC+3
	JMP _0x616
;    5976 		{
;    5977 	if(sub_ind1==0)	ptrs[0]=" Пн! 0@:0#-0$:0%";
	LDS  R30,_sub_ind1
	CPI  R30,0
	BRNE _0x617
	__POINTW1FN _0,2729
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5978 	else if(sub_ind1==1)ptrs[0]=" Вт! 0@:0#-0$:0%";
	RJMP _0x618
_0x617:
	LDS  R26,_sub_ind1
	CPI  R26,LOW(0x1)
	BRNE _0x619
	__POINTW1FN _0,2746
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5979 	else if(sub_ind1==2)ptrs[0]=" Ср! 0@:0#-0$:0%";
	RJMP _0x61A
_0x619:
	LDS  R26,_sub_ind1
	CPI  R26,LOW(0x2)
	BRNE _0x61B
	__POINTW1FN _0,2763
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5980 	else if(sub_ind1==3)ptrs[0]=" Чт! 0@:0#-0$:0%";
	RJMP _0x61C
_0x61B:
	LDS  R26,_sub_ind1
	CPI  R26,LOW(0x3)
	BRNE _0x61D
	__POINTW1FN _0,2780
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5981 	else if(sub_ind1==4)ptrs[0]=" Пт! 0@:0#-0$:0%";
	RJMP _0x61E
_0x61D:
	LDS  R26,_sub_ind1
	CPI  R26,LOW(0x4)
	BRNE _0x61F
	__POINTW1FN _0,2797
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5982 	else if(sub_ind1==5)ptrs[0]=" Сб! 0@:0#-0$:0%";
	RJMP _0x620
_0x61F:
	LDS  R26,_sub_ind1
	CPI  R26,LOW(0x5)
	BRNE _0x621
	__POINTW1FN _0,2814
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5983 	else if(sub_ind1==6)ptrs[0]=" Вс! 0@:0#-0$:0%";
	RJMP _0x622
_0x621:
	LDS  R26,_sub_ind1
	CPI  R26,LOW(0x6)
	BRNE _0x623
	__POINTW1FN _0,2831
	STD  Y+3,R30
	STD  Y+3+1,R31
;    5984 	
;    5985 	ptrs[1]=" Реж (   )      "; 
_0x623:
_0x622:
_0x620:
_0x61E:
_0x61C:
_0x61A:
_0x618:
	__POINTW1FN _0,2848
	STD  Y+5,R30
	STD  Y+5+1,R31
;    5986 	
;    5987    	bgnd_par(ptrs[0],ptrs[1]); 
	CALL SUBOPT_0xE0
;    5988 	
;    5989 	if(timer_mode[sub_ind1,sub_ind]==1)
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x70
	BRNE _0x624
;    5990 		{
;    5991 		sub_bgnd("1     )атм.",'(');
	__POINTW1FN _0,2865
	CALL SUBOPT_0x129
;    5992 		} 
;    5993 	else if(timer_mode[sub_ind1,sub_ind]==2)
	RJMP _0x625
_0x624:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12A
	BRNE _0x626
;    5994 		{
;    5995 		sub_bgnd("2     )Гц. ",'(');
	__POINTW1FN _0,2877
	CALL SUBOPT_0x129
;    5996 		} 	
;    5997 	else if(timer_mode[sub_ind1,sub_ind]==3)
	RJMP _0x627
_0x626:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12B
	BRNE _0x628
;    5998 		{
;    5999 		sub_bgnd("3     )нас.",'(');
	__POINTW1FN _0,2889
	RJMP _0xB7A
;    6000 		}
;    6001 	else 
_0x628:
;    6002 		{
;    6003 		sub_bgnd(" не устан. ",'(');
	__POINTW1FN _0,2901
_0xB7A:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(40)
	ST   -Y,R30
	CALL _sub_bgnd
;    6004 		}		   
_0x627:
_0x625:
;    6005 	int2lcd(sub_ind+1,'!',0);
	CALL SUBOPT_0x123
	CALL SUBOPT_0x106
;    6006 	if(timer_time1[sub_ind1,sub_ind]<1440)
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12D
	CPI  R30,LOW(0x5A0)
	LDI  R26,HIGH(0x5A0)
	CPC  R31,R26
	BRSH _0x62A
;    6007 		{
;    6008 		int2lcd(timer_time1[sub_ind1,sub_ind]/60,'@',0);
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12D
	CALL SUBOPT_0x12E
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    6009 		int2lcd(timer_time1[sub_ind1,sub_ind]%60,'#',0); 
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12D
	CALL SUBOPT_0x12F
	RJMP _0xB7B
;    6010 		}
;    6011 	else 
_0x62A:
;    6012 		{
;    6013 		int2lcd(33,'@',0);
	LDI  R30,LOW(33)
	LDI  R31,HIGH(33)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE3
	CALL _int2lcd
;    6014 		int2lcd(33,'#',0); 
	LDI  R30,LOW(33)
	LDI  R31,HIGH(33)
_0xB7B:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE6
	CALL _int2lcd
;    6015 		}
;    6016 	if(timer_time2[sub_ind1,sub_ind]<1440)
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x131
	CPI  R30,LOW(0x5A0)
	LDI  R26,HIGH(0x5A0)
	CPC  R31,R26
	BRSH _0x62C
;    6017 		{
;    6018 		int2lcd(timer_time2[sub_ind1,sub_ind]/60,'$',0);
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x131
	CALL SUBOPT_0x12E
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    6019 		int2lcd(timer_time2[sub_ind1,sub_ind]%60,'%',0);
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x131
	CALL SUBOPT_0x12F
	RJMP _0xB7C
;    6020 		}
;    6021 	else 
_0x62C:
;    6022 		{
;    6023 		int2lcd(33,'$',0);
	LDI  R30,LOW(33)
	LDI  R31,HIGH(33)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xE8
	CALL _int2lcd
;    6024 		int2lcd(33,'%',0); 
	LDI  R30,LOW(33)
	LDI  R31,HIGH(33)
_0xB7C:
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0xEA
	CALL _int2lcd
;    6025 		}	
;    6026 	
;    6027 	if(timer_mode[sub_ind1,sub_ind]==1)int2lcd(timer_data1[sub_ind1,sub_ind]/10,')',1);
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x70
	BRNE _0x62E
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x109
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP _0xB7D
;    6028 	else int2lcd(timer_data1[sub_ind1,sub_ind],')',0);
_0x62E:
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(0)
_0xB7D:
	ST   -Y,R30
	CALL _int2lcd
;    6029 	
;    6030 	     if(sub_ind2==0)ind_fl(5,2);
	LDS  R30,_sub_ind2
	CPI  R30,0
	BRNE _0x630
	LDI  R30,LOW(5)
	CALL SUBOPT_0x133
;    6031 		else if(sub_ind2==1)ind_fl(8,2);
	RJMP _0x631
_0x630:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x1)
	BRNE _0x632
	LDI  R30,LOW(8)
	CALL SUBOPT_0x133
;    6032 		else if(sub_ind2==2)ind_fl(11,2);
	RJMP _0x633
_0x632:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x2)
	BRNE _0x634
	LDI  R30,LOW(11)
	CALL SUBOPT_0x133
;    6033 		else if(sub_ind2==3)ind_fl(14,2);
	RJMP _0x635
_0x634:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x3)
	BRNE _0x636
	LDI  R30,LOW(14)
	CALL SUBOPT_0x133
;    6034 		else if(sub_ind2==4)ind_fl(17,5);
	RJMP _0x637
_0x636:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x4)
	BRNE _0x638
	LDI  R30,LOW(17)
	CALL SUBOPT_0x134
	CALL _ind_fl
;    6035 		else if(sub_ind2==5)ind_fl(22,10);
	RJMP _0x639
_0x638:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x5)
	BRNE _0x63A
	LDI  R30,LOW(22)
	ST   -Y,R30
	LDI  R30,LOW(10)
	ST   -Y,R30
	CALL _ind_fl
;    6036 		}
_0x63A:
_0x639:
_0x637:
_0x635:
_0x633:
_0x631:
;    6037 	else bgnd_par(sm_exit,sm_);
	RJMP _0x63B
_0x616:
	CALL SUBOPT_0x11D
_0x63B:
;    6038 	
;    6039 
;    6040 	}
;    6041 	
;    6042     	
;    6043 else if(ind==iZero_load_set)
	RJMP _0x63C
_0x615:
	LDI  R30,LOW(186)
	CP   R30,R13
	BRNE _0x63D
;    6044 	{
;    6045 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x63E
;    6046 		{
;    6047 		bgnd_par(" Tzero    !сек. ",sm_);
	__POINTW1FN _0,2913
	CALL SUBOPT_0x11E
;    6048           int2lcd(ZL_TIME,'!',0);	
	LDI  R26,LOW(_ZL_TIME)
	LDI  R27,HIGH(_ZL_TIME)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    6049 		}  
;    6050 	else if(sub_ind==1)
	RJMP _0x63F
_0x63E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x640
;    6051 		{
;    6052 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    6053 		}
;    6054     	}	     	     	  	
_0x640:
_0x63F:
;    6055 
;    6056 else if(ind==iPid_set)
	RJMP _0x641
_0x63D:
	LDI  R30,LOW(159)
	CP   R30,R13
	BREQ PC+3
	JMP _0x642
;    6057 	{
;    6058 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x643
;    6059 		{
;    6060 		bgnd_par(" Период    !сек.",sm_);
	__POINTW1FN _0,2930
	CALL SUBOPT_0x11E
;    6061           int2lcd(PID_PERIOD,'!',1);	
	LDI  R26,LOW(_PID_PERIOD)
	LDI  R27,HIGH(_PID_PERIOD)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    6062 		}  
;    6063 	else if(sub_ind==1)
	RJMP _0x644
_0x643:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x645
;    6064 		{
;    6065 		bgnd_par(" Усиление     ! ",sm_);
	__POINTW1FN _0,2947
	CALL SUBOPT_0x11E
;    6066           int2lcd(PID_K,'!',1);	
	LDI  R26,LOW(_PID_K)
	LDI  R27,HIGH(_PID_K)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    6067 		}		
;    6068 	else if(sub_ind==2)
	RJMP _0x646
_0x645:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x647
;    6069 		{
;    6070 		bgnd_par(" Усиление И   ! ",sm_);
	__POINTW1FN _0,2964
	CALL SUBOPT_0x11E
;    6071           int2lcd(PID_K_P,'!',1);	
	LDI  R26,LOW(_PID_K_P)
	LDI  R27,HIGH(_PID_K_P)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    6072 		}			
;    6073 	else if(sub_ind==3)
	RJMP _0x648
_0x647:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x649
;    6074 		{
;    6075 		bgnd_par(" Усиление Д   ! ",sm_);
	__POINTW1FN _0,2981
	CALL SUBOPT_0x11E
;    6076           int2lcd(PID_K_D,'!',1);	
	LDI  R26,LOW(_PID_K_D)
	LDI  R27,HIGH(_PID_K_D)
	CALL __EEPROMRDW
	CALL SUBOPT_0x120
;    6077 		}			
;    6078 	else if(sub_ind==4)
	RJMP _0x64A
_0x649:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x64B
;    6079 		{
;    6080 		bgnd_par(" Обороты частон."," перекл вниз  !%");
	__POINTW1FN _0,2998
	ST   -Y,R31
	ST   -Y,R30
	__POINTW1FN _0,3015
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
;    6081           int2lcd(PID_K_FP_DOWN,'!',0);	
	LDI  R26,LOW(_PID_K_FP_DOWN)
	LDI  R27,HIGH(_PID_K_FP_DOWN)
	CALL __EEPROMRDW
	CALL SUBOPT_0x106
;    6082 		}			
;    6083 	else if(sub_ind==5)
	RJMP _0x64C
_0x64B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x64D
;    6084 		{
;    6085 		bgnd_par(sm_exit,sm_);
	CALL SUBOPT_0x11D
;    6086 		}	
;    6087 	}
_0x64D:
_0x64C:
_0x64A:
_0x648:
_0x646:
_0x644:
;    6088 
;    6089 ruslcd(lcd_buffer); 
_0x642:
_0x641:
_0x63C:
_0x614:
_0x60D:
_0x602:
_0x5F7:
_0x5E8:
_0x5D5:
_0x5CC:
_0x5C1:
_0x5B6:
_0x5B4:
_0x5B2:
_0x5B0:
_0x5AC:
_0x5A8:
_0x5A4:
_0x5A2:
_0x5A0:
_0x59C:
_0x598:
_0x596:
_0x585:
_0x576:
_0x563:
_0x54C:
_0x546:
_0x50D:
_0x4DA:
_0x4D3:
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	CALL _ruslcd
;    6090 
;    6091 /*lcd_buffer[32]=5; 
;    6092 lcd_buffer[33]=5;*/
;    6093 } 
	CALL __LOADLOCR3
	ADIW R28,25
	RET
;    6094 
;    6095 //----------------------------------------------
;    6096 void plata_ind_hndl(void) 
;    6097 {
_plata_ind_hndl:
;    6098 #define LED_COMM_AV	7 
;    6099 #define LED_HH_AV	6
;    6100 #define LED_NET_COND	4
;    6101 #define LED_NET_CHER	5
;    6102 #define LED_NET_NORM	3
;    6103 
;    6104 #define LED_DV_ON	5
;    6105 #define LED_AV_IDV	6
;    6106 #define LED_AV_TEMPER	4
;    6107 #define LED_AV_VL	7
;    6108 
;    6109 #define LED_POPL1	4
;    6110 #define LED_POPL2	5
;    6111 #define LED_POPL3	2
;    6112 #define LED_POPL4	3
;    6113 
;    6114 data_for_ind[0]=/*cnt_control_blok;//*/read_ds14287(HOURS);
	CALL SUBOPT_0x43
	STS  _data_for_ind,R30
;    6115 
;    6116 data_for_ind[1]=/*cnt_control_blok1;//*/read_ds14287(MINUTES);
	CALL SUBOPT_0x44
	__PUTB1MN _data_for_ind,1
;    6117 
;    6118 if(comm_curr<100) data_for_ind[2]=128+(char)comm_curr;
	LDS  R26,_comm_curr
	LDS  R27,_comm_curr+1
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0x64E
	LDS  R30,_comm_curr
	SUBI R30,-LOW(128)
	__PUTB1MN _data_for_ind,2
;    6119 else data_for_ind[2]=(char)(comm_curr/10);
	RJMP _0x64F
_0x64E:
	LDS  R26,_comm_curr
	LDS  R27,_comm_curr+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	__PUTB1MN _data_for_ind,2
_0x64F:
;    6120 //data_for_ind[2]=mode;
;    6121 ///data_for_ind[2]=plazma;
;    6122 /*if((EE_LOG==el_popl)||(EE_MODE==emTST))data_for_ind[3]=0xff;
;    6123 else 
;    6124 	{
;    6125 	if(height_level<100)data_for_ind[3]=height_level;
;    6126 	else if(height_level>=100)data_for_ind[3]=128+(height_level/10);
;    6127 	} */
;    6128 
;    6129 if(p_ind_cnt)
	TST  R12
	BREQ _0x650
;    6130 	{
;    6131 	p_ind_cnt--;
	DEC  R12
;    6132 	if(p_ust<1000)data_for_ind[3]=p_ust/10+128;
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CP   R8,R30
	CPC  R9,R31
	BRGE _0x651
	__GETW2R 8,9
	CALL SUBOPT_0x135
	__PUTB1MN _data_for_ind,3
;    6133 	else if(p_ust>=1000)data_for_ind[3]=(p_ust/100);
	RJMP _0x652
_0x651:
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CP   R8,R30
	CPC  R9,R31
	BRLT _0x653
	__GETW2R 8,9
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	__PUTB1MN _data_for_ind,3
;    6134 	} 
_0x653:
_0x652:
;    6135 else
	RJMP _0x654
_0x650:
;    6136 	{
;    6137 	if(p<1000)data_for_ind[3]=p/10+128;
	LDS  R26,_p
	LDS  R27,_p+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0x655
	CALL SUBOPT_0x135
	__PUTB1MN _data_for_ind,3
;    6138 	else if(p>=1000)data_for_ind[3]=(p/100);
	RJMP _0x656
_0x655:
	LDS  R26,_p
	LDS  R27,_p+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRLT _0x657
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	__PUTB1MN _data_for_ind,3
;    6139      }
_0x657:
_0x656:
_0x654:
;    6140      
;    6141 data_for_ind[4]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,4
;    6142 data_for_ind[5]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,5
;    6143 
;    6144 if(comm_av_st!=cast_OFF)
	LDS  R26,_comm_av_st
	CPI  R26,LOW(0xAA)
	BREQ _0x658
;    6145 	{
;    6146 	data_for_ind[4]&=~(1<<LED_COMM_AV);
	__POINTW1MN _data_for_ind,4
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0x7F
	POP  R26
	POP  R27
	ST   X,R30
;    6147 	data_for_ind[5]|=(1<<LED_COMM_AV);
	__POINTW1MN _data_for_ind,5
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x80
	POP  R26
	POP  R27
	ST   X,R30
;    6148 	}
;    6149 
;    6150 
;    6151 
;    6152 
;    6153 if(hh_av==avON)
_0x658:
	LDS  R26,_hh_av
	CPI  R26,LOW(0x55)
	BRNE _0x659
;    6154 	{
;    6155 	data_for_ind[4]&=~(1<<LED_HH_AV);
	__POINTW1MN _data_for_ind,4
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6156 	}
;    6157 
;    6158 if((unet_st[0]!=unet_st_NORM)||(unet_st[1]!=unet_st_NORM)||(unet_st[2]!=unet_st_NORM)) 
_0x659:
	LDS  R26,_unet_st
	CPI  R26,LOW(0x0)
	BRNE _0x65B
	__GETB1MN _unet_st,1
	CPI  R30,0
	BRNE _0x65B
	__GETB1MN _unet_st,2
	CPI  R30,0
	BREQ _0x65A
_0x65B:
;    6159 	{
;    6160 	data_for_ind[4]&=~(1<<LED_NET_COND);
	__POINTW1MN _data_for_ind,4
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xEF
	POP  R26
	POP  R27
	ST   X,R30
;    6161 	}
;    6162 if(av_st_unet_cher==asuc_AV)
_0x65A:
	LDS  R26,_av_st_unet_cher
	CPI  R26,LOW(0x55)
	BRNE _0x65D
;    6163 	{
;    6164 	data_for_ind[4]&=~(1<<LED_NET_CHER);
	__POINTW1MN _data_for_ind,4
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6165 	}
;    6166 if((unet_st[0]==unet_st_NORM)&&(unet_st[1]==unet_st_NORM)&&(unet_st[2]==unet_st_NORM)&&(av_st_unet_cher==asuc_NORM))
_0x65D:
	LDS  R26,_unet_st
	CPI  R26,LOW(0x0)
	BRNE _0x65F
	__GETB1MN _unet_st,1
	CPI  R30,0
	BRNE _0x65F
	__GETB1MN _unet_st,2
	CPI  R30,0
	BRNE _0x65F
	LDS  R26,_av_st_unet_cher
	CPI  R26,LOW(0xAA)
	BREQ _0x660
_0x65F:
	RJMP _0x65E
_0x660:
;    6167 	{
;    6168 	data_for_ind[4]&=~(1<<LED_NET_NORM);
	__POINTW1MN _data_for_ind,4
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0XF7
	POP  R26
	POP  R27
	ST   X,R30
;    6169 	}		
;    6170 data_for_ind[6]=0xFF;
_0x65E:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,6
;    6171 data_for_ind[7]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,7
;    6172 data_for_ind[8]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,8
;    6173 data_for_ind[9]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,9
;    6174 
;    6175 
;    6176 if(av_temper_st==av_temper_AVSENS)
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0xBB)
	BRNE _0x661
;    6177 	{
;    6178 	data_for_ind[6]&=0b00111111;
	__POINTW1MN _data_for_ind,6
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0x3F)
	POP  R26
	POP  R27
	ST   X,R30
;    6179 	data_for_ind[7]|=0b11000000;
	__POINTW1MN _data_for_ind,7
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,LOW(0xC0)
	POP  R26
	POP  R27
	ST   X,R30
;    6180 	}
;    6181 else if (av_temper_st==av_temper_NORM)
	RJMP _0x662
_0x661:
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0xAA)
	BRNE _0x663
;    6182 	{
;    6183 	data_for_ind[6]|=0b11000000;
	__POINTW1MN _data_for_ind,6
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,LOW(0xC0)
	POP  R26
	POP  R27
	ST   X,R30
;    6184 	data_for_ind[7]&=0b00111111;
	__POINTW1MN _data_for_ind,7
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0x3F)
	POP  R26
	POP  R27
	ST   X,R30
;    6185 	}		
;    6186 else if (av_temper_st==av_temper_COOL)
	RJMP _0x664
_0x663:
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0x99)
	BRNE _0x665
;    6187 	{
;    6188 	data_for_ind[6]&=0b01111111;
	__POINTW1MN _data_for_ind,6
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0x7F
	POP  R26
	POP  R27
	ST   X,R30
;    6189 	data_for_ind[7]|=0b00000000;
	__POINTW1MN _data_for_ind,7
	PUSH R31
	PUSH R30
	LD   R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    6190 	}
;    6191 else if (av_temper_st==av_temper_HEAT)
	RJMP _0x666
_0x665:
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0x88)
	BRNE _0x667
;    6192 	{
;    6193 	data_for_ind[6]&=0b10111111;
	__POINTW1MN _data_for_ind,6
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6194 	data_for_ind[7]|=0b00000000;
	__POINTW1MN _data_for_ind,7
	PUSH R31
	PUSH R30
	LD   R30,Z
	POP  R26
	POP  R27
	ST   X,R30
;    6195 	} 
;    6196 
;    6197 if(av_fp_stat==afsON)
_0x667:
_0x666:
_0x664:
_0x662:
	LDS  R26,_av_fp_stat
	CPI  R26,LOW(0x55)
	BRNE _0x668
;    6198 	{
;    6199 	data_for_ind[6]&=~(1<<LED_POPL3);
	__POINTW1MN _data_for_ind,6
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xFB
	POP  R26
	POP  R27
	ST   X,R30
;    6200 	data_for_ind[7]|=(1<<LED_POPL3);
	__POINTW1MN _data_for_ind,7
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,4
	POP  R26
	POP  R27
	ST   X,R30
;    6201 	}
;    6202 
;    6203 
;    6204 if(av_sens_p_stat==aspON)
_0x668:
	LDS  R26,_av_sens_p_stat
	CPI  R26,LOW(0x55)
	BRNE _0x669
;    6205 	{
;    6206 	data_for_ind[6]&=~(1<<LED_POPL4);
	__POINTW1MN _data_for_ind,6
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0XF7
	POP  R26
	POP  R27
	ST   X,R30
;    6207 	data_for_ind[7]|=(1<<LED_POPL4);
	__POINTW1MN _data_for_ind,7
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,8
	POP  R26
	POP  R27
	ST   X,R30
;    6208 	}
;    6209 	
;    6210 if(warm_st==warm_AVSENS)
_0x669:
	LDS  R26,_warm_st
	CPI  R26,LOW(0xBB)
	BRNE _0x66A
;    6211 	{
;    6212 	data_for_ind[8]&=0b01111111;
	__POINTW1MN _data_for_ind,8
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0x7F
	POP  R26
	POP  R27
	ST   X,R30
;    6213 	data_for_ind[9]|=0b10000000;
	__POINTW1MN _data_for_ind,9
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x80
	POP  R26
	POP  R27
	ST   X,R30
;    6214 	}
;    6215 else if((warm_st==warm_ON)&&(av_temper_st==av_temper_NORM))data_for_ind[8]&=0b01111111;
	RJMP _0x66B
_0x66A:
	LDS  R26,_warm_st
	CPI  R26,LOW(0x55)
	BRNE _0x66D
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0xAA)
	BREQ _0x66E
_0x66D:
	RJMP _0x66C
_0x66E:
	__POINTW1MN _data_for_ind,8
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0x7F
	POP  R26
	POP  R27
	ST   X,R30
;    6216 
;    6217 
;    6218 if(cool_st==cool_AVSENS)
_0x66C:
_0x66B:
	LDS  R26,_cool_st
	CPI  R26,LOW(0x2)
	BRNE _0x66F
;    6219 	{
;    6220 	data_for_ind[8]&=0b10111111;
	__POINTW1MN _data_for_ind,8
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6221 	data_for_ind[9]|=0b01000000;
	__POINTW1MN _data_for_ind,9
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x40
	POP  R26
	POP  R27
	ST   X,R30
;    6222 	}
;    6223 else if((cool_st==cool_ON)&&(av_temper_st==av_temper_NORM))data_for_ind[8]&=0b10111111; 
	RJMP _0x670
_0x66F:
	LDS  R26,_cool_st
	CPI  R26,LOW(0x0)
	BRNE _0x672
	LDS  R26,_av_temper_st
	CPI  R26,LOW(0xAA)
	BREQ _0x673
_0x672:
	RJMP _0x671
_0x673:
	__POINTW1MN _data_for_ind,8
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6224 
;    6225 if((pilot_dv==0)&&(fp_stat==dvON))data_for_ind[10]=(char)(__fp_fcurr/10);
_0x671:
_0x670:
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	SBIW R30,0
	BRNE _0x675
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BREQ _0x676
_0x675:
	RJMP _0x674
_0x676:
	CALL SUBOPT_0x136
	__PUTB1MN _data_for_ind,10
;    6226 else if(RESURS_CNT[0]>=10)data_for_ind[10]=RESURS_CNT[0]/10;
	RJMP _0x677
_0x674:
	CALL SUBOPT_0x10D
	BRLO _0x678
	CALL SUBOPT_0x10E
	__PUTB1MN _data_for_ind,10
;    6227 else data_for_ind[10]=128+RESURS_CNT[0];
	RJMP _0x679
_0x678:
	LDI  R26,LOW(_RESURS_CNT)
	LDI  R27,HIGH(_RESURS_CNT)
	CALL __EEPROMRDW
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	__PUTB1MN _data_for_ind,10
_0x679:
_0x677:
;    6228 if(av_serv[0]==avsON)data_for_ind[10]=0xff; 
	LDS  R26,_av_serv
	CPI  R26,LOW(0x55)
	BRNE _0x67A
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,10
;    6229 data_for_ind[11]=0xff;
_0x67A:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,11
;    6230 data_for_ind[12]=0x00; 
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,12
;    6231 
;    6232 if(av_serv[0]==avsON)
	LDS  R26,_av_serv
	CPI  R26,LOW(0x55)
	BRNE _0x67B
;    6233 	{
;    6234 	data_for_ind[11]|=0b11111111;
	__POINTW1MN _data_for_ind,11
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,LOW(0xFF)
	POP  R26
	POP  R27
	ST   X,R30
;    6235 	data_for_ind[12]&=0b00000000;
	__POINTW1MN _data_for_ind,12
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0x0)
	POP  R26
	POP  R27
	ST   X,R30
;    6236 	}
;    6237 else 
	RJMP _0x67C
_0x67B:
;    6238 	{
;    6239 	if((av_i_dv_min[0]!=aviOFF)||(av_i_dv_max[0]!=aviOFF)||(av_i_dv_log[0]!=aviOFF))
	LDS  R26,_av_i_dv_min
	CPI  R26,LOW(0xAA)
	BRNE _0x67E
	LDS  R26,_av_i_dv_max
	CPI  R26,LOW(0xAA)
	BRNE _0x67E
	LDS  R26,_av_i_dv_log
	CPI  R26,LOW(0xAA)
	BREQ _0x67D
_0x67E:
;    6240 		{
;    6241 		data_for_ind[11]&=~(1<<LED_AV_IDV);
	__POINTW1MN _data_for_ind,11
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6242 		}
;    6243 		
;    6244 	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
_0x67D:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ _0x681
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xCC)
	BREQ _0x681
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x680
_0x681:
;    6245 		{
;    6246 		if(dv_on[0]!=dvOFF)data_for_ind[11]&=~(1<<LED_DV_ON);
	LDS  R26,_dv_on
	CPI  R26,LOW(0x81)
	BREQ _0x683
	__POINTW1MN _data_for_ind,11
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6247 		else if(apv_cnt[0])
	RJMP _0x684
_0x683:
	LDS  R30,_apv_cnt
	CPI  R30,0
	BREQ _0x685
;    6248 			{
;    6249 			data_for_ind[11]&=~(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,11
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6250 			data_for_ind[12]|=(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,12
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x20
	POP  R26
	POP  R27
	ST   X,R30
;    6251 			}
;    6252 		}				
_0x685:
_0x684:
;    6253 	}	
_0x680:
_0x67C:
;    6254 
;    6255 
;    6256 if((pilot_dv==1)&&(fp_stat==dvON))data_for_ind[13]=(char)(__fp_fcurr/10);
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0x687
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BREQ _0x688
_0x687:
	RJMP _0x686
_0x688:
	CALL SUBOPT_0x136
	__PUTB1MN _data_for_ind,13
;    6257 else if(RESURS_CNT[1]>=10)data_for_ind[13]=RESURS_CNT[1]/10;
	RJMP _0x689
_0x686:
	__POINTW2MN _RESURS_CNT,2
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRLO _0x68A
	__POINTW2MN _RESURS_CNT,2
	CALL SUBOPT_0x110
	__PUTB1MN _data_for_ind,13
;    6258 else data_for_ind[13]=128+RESURS_CNT[1];
	RJMP _0x68B
_0x68A:
	__POINTW2MN _RESURS_CNT,2
	CALL __EEPROMRDW
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	__PUTB1MN _data_for_ind,13
_0x68B:
_0x689:
;    6259 if((av_serv[1]==avsON)||(EE_DV_NUM<2))data_for_ind[13]=0xff;
	__GETB1MN _av_serv,1
	CPI  R30,LOW(0x55)
	BREQ _0x68D
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	BRSH _0x68C
_0x68D:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,13
;    6260 
;    6261 
;    6262 data_for_ind[14]=0xff;
_0x68C:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,14
;    6263 data_for_ind[15]=0x00;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,15
;    6264 if((av_serv[1]==avsON)||(EE_DV_NUM<2))
	__GETB1MN _av_serv,1
	CPI  R30,LOW(0x55)
	BREQ _0x690
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	BRSH _0x68F
_0x690:
;    6265 	{
;    6266 	data_for_ind[14]|=0b11111111;
	__POINTW1MN _data_for_ind,14
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,LOW(0xFF)
	POP  R26
	POP  R27
	ST   X,R30
;    6267 	data_for_ind[15]&=0b11111111;
	__POINTW2MN _data_for_ind,15
	LD   R30,Z
	ST   X,R30
;    6268 	}
;    6269 else 
	RJMP _0x692
_0x68F:
;    6270 	{
;    6271 	if((av_i_dv_min[1]!=aviOFF)||(av_i_dv_max[1]!=aviOFF)||(av_i_dv_log[1]!=aviOFF))
	__GETB1MN _av_i_dv_min,1
	CPI  R30,LOW(0xAA)
	BRNE _0x694
	__GETB1MN _av_i_dv_max,1
	CPI  R30,LOW(0xAA)
	BRNE _0x694
	__GETB1MN _av_i_dv_log,1
	CPI  R30,LOW(0xAA)
	BREQ _0x693
_0x694:
;    6272 		{
;    6273 		data_for_ind[14]&=~(1<<LED_AV_IDV);
	__POINTW1MN _data_for_ind,14
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6274 		}
;    6275 	
;    6276 	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
_0x693:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ _0x697
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xCC)
	BREQ _0x697
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x696
_0x697:
;    6277 		{
;    6278 		if(dv_on[1]!=dvOFF)data_for_ind[14]&=~(1<<LED_DV_ON);
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x81)
	BREQ _0x699
	__POINTW1MN _data_for_ind,14
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6279 		else if(apv_cnt[1])
	RJMP _0x69A
_0x699:
	__GETB1MN _apv_cnt,1
	CPI  R30,0
	BREQ _0x69B
;    6280 			{
;    6281 			data_for_ind[14]&=~(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,14
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6282 			data_for_ind[15]|=(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,15
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x20
	POP  R26
	POP  R27
	ST   X,R30
;    6283 			}
;    6284 		}						
_0x69B:
_0x69A:
;    6285 	}
_0x696:
_0x692:
;    6286 
;    6287 
;    6288 if((pilot_dv==2)&&(fp_stat==dvON))data_for_ind[16]=(char)(__fp_fcurr/10);
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0x69D
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BREQ _0x69E
_0x69D:
	RJMP _0x69C
_0x69E:
	CALL SUBOPT_0x136
	__PUTB1MN _data_for_ind,16
;    6289 else if(RESURS_CNT[2]>=10)data_for_ind[16]=RESURS_CNT[2]/10;
	RJMP _0x69F
_0x69C:
	__POINTW2MN _RESURS_CNT,4
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRLO _0x6A0
	__POINTW2MN _RESURS_CNT,4
	CALL SUBOPT_0x110
	__PUTB1MN _data_for_ind,16
;    6290 else data_for_ind[16]=128+RESURS_CNT[2];
	RJMP _0x6A1
_0x6A0:
	__POINTW2MN _RESURS_CNT,4
	CALL __EEPROMRDW
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	__PUTB1MN _data_for_ind,16
_0x6A1:
_0x69F:
;    6291 if((av_serv[2]==avsON)||(EE_DV_NUM<3))data_for_ind[16]=0xff; 
	__GETB1MN _av_serv,2
	CPI  R30,LOW(0x55)
	BREQ _0x6A3
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	BRSH _0x6A2
_0x6A3:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,16
;    6292 
;    6293 
;    6294 data_for_ind[17]=0xff;
_0x6A2:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,17
;    6295 data_for_ind[18]=0x00; 
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,18
;    6296 if((av_serv[2]==avsON)||(EE_DV_NUM<3))
	__GETB1MN _av_serv,2
	CPI  R30,LOW(0x55)
	BREQ _0x6A6
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	BRSH _0x6A5
_0x6A6:
;    6297 	{
;    6298 	data_for_ind[17]|=0b11111111;
	__POINTW1MN _data_for_ind,17
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,LOW(0xFF)
	POP  R26
	POP  R27
	ST   X,R30
;    6299 	data_for_ind[18]&=0b00000000;
	__POINTW1MN _data_for_ind,18
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0x0)
	POP  R26
	POP  R27
	ST   X,R30
;    6300 	}
;    6301 else 
	RJMP _0x6A8
_0x6A5:
;    6302 	{
;    6303 	if((av_i_dv_min[2]!=aviOFF)||(av_i_dv_max[2]!=aviOFF)||(av_i_dv_log[2]!=aviOFF))
	__GETB1MN _av_i_dv_min,2
	CPI  R30,LOW(0xAA)
	BRNE _0x6AA
	__GETB1MN _av_i_dv_max,2
	CPI  R30,LOW(0xAA)
	BRNE _0x6AA
	__GETB1MN _av_i_dv_log,2
	CPI  R30,LOW(0xAA)
	BREQ _0x6A9
_0x6AA:
;    6304 		{
;    6305 		data_for_ind[17]&=~(1<<LED_AV_IDV);
	__POINTW1MN _data_for_ind,17
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6306 		}
;    6307  	
;    6308 	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
_0x6A9:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ _0x6AD
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xCC)
	BREQ _0x6AD
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x6AC
_0x6AD:
;    6309 		{
;    6310 		if(dv_on[2]!=dvOFF)data_for_ind[17]&=~(1<<LED_DV_ON);
	__GETB1MN _dv_on,2
	CPI  R30,LOW(0x81)
	BREQ _0x6AF
	__POINTW1MN _data_for_ind,17
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6311 		else if(apv_cnt[2])
	RJMP _0x6B0
_0x6AF:
	__GETB1MN _apv_cnt,2
	CPI  R30,0
	BREQ _0x6B1
;    6312 			{
;    6313 			data_for_ind[17]&=~(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,17
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6314 			data_for_ind[18]|=(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,18
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x20
	POP  R26
	POP  R27
	ST   X,R30
;    6315 			}
;    6316 		}				
_0x6B1:
_0x6B0:
;    6317 	}
_0x6AC:
_0x6A8:
;    6318 
;    6319 
;    6320 if((pilot_dv==3)&&(fp_stat==dvON))data_for_ind[20]=(char)(__fp_fcurr/10);
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x3)
	LDI  R26,HIGH(0x3)
	CPC  R31,R26
	BRNE _0x6B3
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BREQ _0x6B4
_0x6B3:
	RJMP _0x6B2
_0x6B4:
	CALL SUBOPT_0x136
	__PUTB1MN _data_for_ind,20
;    6321 else if(RESURS_CNT[3]>=10)data_for_ind[20]=RESURS_CNT[3]/10;
	RJMP _0x6B5
_0x6B2:
	__POINTW2MN _RESURS_CNT,6
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRLO _0x6B6
	__POINTW2MN _RESURS_CNT,6
	CALL SUBOPT_0x110
	__PUTB1MN _data_for_ind,20
;    6322 else data_for_ind[20]=128+RESURS_CNT[3];
	RJMP _0x6B7
_0x6B6:
	__POINTW2MN _RESURS_CNT,6
	CALL __EEPROMRDW
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	__PUTB1MN _data_for_ind,20
_0x6B7:
_0x6B5:
;    6323 if((av_serv[3]==avsON)||(EE_DV_NUM<4))data_for_ind[20]=0xff;
	__GETB1MN _av_serv,3
	CPI  R30,LOW(0x55)
	BREQ _0x6B9
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x4)
	BRSH _0x6B8
_0x6B9:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,20
;    6324 
;    6325  
;    6326 data_for_ind[21]=0xff;
_0x6B8:
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,21
;    6327 data_for_ind[22]=0x00; 
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,22
;    6328 if((av_serv[3]==avsON)||(EE_DV_NUM<4))
	__GETB1MN _av_serv,3
	CPI  R30,LOW(0x55)
	BREQ _0x6BC
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x4)
	BRSH _0x6BB
_0x6BC:
;    6329 	{
;    6330 	data_for_ind[21]|=0b11111111;
	__POINTW1MN _data_for_ind,21
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,LOW(0xFF)
	POP  R26
	POP  R27
	ST   X,R30
;    6331 	data_for_ind[22]&=0b00000000;
	__POINTW1MN _data_for_ind,22
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0x0)
	POP  R26
	POP  R27
	ST   X,R30
;    6332 	}
;    6333 else 
	RJMP _0x6BE
_0x6BB:
;    6334 	{
;    6335 	if((av_i_dv_min[3]!=aviOFF)||(av_i_dv_max[3]!=aviOFF)||(av_i_dv_log[3]!=aviOFF))
	__GETB1MN _av_i_dv_min,3
	CPI  R30,LOW(0xAA)
	BRNE _0x6C0
	__GETB1MN _av_i_dv_max,3
	CPI  R30,LOW(0xAA)
	BRNE _0x6C0
	__GETB1MN _av_i_dv_log,3
	CPI  R30,LOW(0xAA)
	BREQ _0x6BF
_0x6C0:
;    6336 		{
;    6337 		data_for_ind[21]&=~(1<<LED_AV_IDV);
	__POINTW1MN _data_for_ind,21
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xBF
	POP  R26
	POP  R27
	ST   X,R30
;    6338 		}
;    6339 		
;    6340 	if((EE_MODE==emAVT)||(EE_MODE==emTST)||(EE_MODE==emMNL))
_0x6BF:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BREQ _0x6C3
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xCC)
	BREQ _0x6C3
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x6C2
_0x6C3:
;    6341 		{
;    6342 		if(dv_on[3]!=dvOFF)data_for_ind[21]&=~(1<<LED_DV_ON);
	__GETB1MN _dv_on,3
	CPI  R30,LOW(0x81)
	BREQ _0x6C5
	__POINTW1MN _data_for_ind,21
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6343 		else if(apv_cnt[4])
	RJMP _0x6C6
_0x6C5:
	__GETB1MN _apv_cnt,4
	CPI  R30,0
	BREQ _0x6C7
;    6344 			{
;    6345 			data_for_ind[21]&=~(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,21
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,0xDF
	POP  R26
	POP  R27
	ST   X,R30
;    6346 			data_for_ind[22]|=(1<<LED_DV_ON);
	__POINTW1MN _data_for_ind,22
	PUSH R31
	PUSH R30
	LD   R30,Z
	ORI  R30,0x20
	POP  R26
	POP  R27
	ST   X,R30
;    6347 			}
;    6348 		}				
_0x6C7:
_0x6C6:
;    6349 	}
_0x6C2:
_0x6BE:
;    6350 
;    6351 
;    6352 if(main_cnt<10)
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0xA)
	LDI  R30,HIGH(0xA)
	CPC  R27,R30
	BRSH _0x6C8
;    6353 	{
;    6354 	data_for_ind[2]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,2
;    6355 	data_for_ind[3]=0xff;
	__PUTB1MN _data_for_ind,3
;    6356 	data_for_ind[4]=0xff;
	__PUTB1MN _data_for_ind,4
;    6357 	data_for_ind[5]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,5
;    6358 	data_for_ind[6]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,6
;    6359 	data_for_ind[7]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,7
;    6360 	data_for_ind[8]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,8
;    6361 	data_for_ind[9]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,9
;    6362 	data_for_ind[10]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,10
;    6363 	data_for_ind[11]=0xff;
	__PUTB1MN _data_for_ind,11
;    6364 	data_for_ind[12]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,12
;    6365 	data_for_ind[13]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,13
;    6366 	data_for_ind[14]=0xff;
	__PUTB1MN _data_for_ind,14
;    6367 	data_for_ind[15]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,15
;    6368 	data_for_ind[16]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,16
;    6369 	data_for_ind[17]=0xff;
	__PUTB1MN _data_for_ind,17
;    6370 	data_for_ind[18]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,18
;    6371 	data_for_ind[20]=0xff;
	LDI  R30,LOW(255)
	__PUTB1MN _data_for_ind,20
;    6372 	data_for_ind[21]=0xff;
	__PUTB1MN _data_for_ind,21
;    6373 	data_for_ind[22]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _data_for_ind,22
;    6374 	}
;    6375 
;    6376 
;    6377 }
_0x6C8:
	RET
;    6378 
;    6379 
;    6380 //-----------------------------------------------
;    6381 void but_drv(void)
;    6382 {
_but_drv:
;    6383 DDRC&=0b00000000;
	IN   R30,0x14
	ANDI R30,LOW(0x0)
	OUT  0x14,R30
;    6384 PORTC|=0b11111111;
	IN   R30,0x15
	ORI  R30,LOW(0xFF)
	OUT  0x15,R30
;    6385 
;    6386 DDRG|=0b00010000;
	LDS  R30,100
	ORI  R30,0x10
	STS  100,R30
;    6387 PORTG&=0b11101111;
	LDS  R30,101
	ANDI R30,0xEF
	STS  101,R30
;    6388 
;    6389 if(!PINC.4)but_cnt[0]++;
	SBIC 0x13,4
	RJMP _0x6C9
	LDI  R26,LOW(_but_cnt)
	LDI  R27,HIGH(_but_cnt)
	CALL SUBOPT_0xD3
;    6390 else but_cnt[0]=0;
	RJMP _0x6CA
_0x6C9:
	LDI  R30,LOW(0)
	STS  _but_cnt,R30
_0x6CA:
;    6391 gran_char(&but_cnt[0],0,100);
	LDI  R30,LOW(_but_cnt)
	LDI  R31,HIGH(_but_cnt)
	CALL SUBOPT_0x90
	CALL SUBOPT_0x137
;    6392 
;    6393 if(!PINC.5)but_cnt[1]++;
	SBIC 0x13,5
	RJMP _0x6CB
	__POINTW2MN _but_cnt,1
	CALL SUBOPT_0xD3
;    6394 else but_cnt[1]=0;
	RJMP _0x6CC
_0x6CB:
	LDI  R30,LOW(0)
	__PUTB1MN _but_cnt,1
_0x6CC:
;    6395 gran_char(&but_cnt[1],0,100);
	__POINTW1MN _but_cnt,1
	CALL SUBOPT_0x90
	CALL SUBOPT_0x137
;    6396 
;    6397 if(!PINC.6)but_cnt[2]++;
	SBIC 0x13,6
	RJMP _0x6CD
	__POINTW2MN _but_cnt,2
	CALL SUBOPT_0xD3
;    6398 else but_cnt[2]=0;
	RJMP _0x6CE
_0x6CD:
	LDI  R30,LOW(0)
	__PUTB1MN _but_cnt,2
_0x6CE:
;    6399 gran_char(&but_cnt[2],0,100);
	__POINTW1MN _but_cnt,2
	CALL SUBOPT_0x90
	CALL SUBOPT_0x137
;    6400 
;    6401 if(!PINC.7)but_cnt[3]++;
	SBIC 0x13,7
	RJMP _0x6CF
	__POINTW2MN _but_cnt,3
	LD   R30,X
	SUBI R30,-LOW(1)
	RJMP _0xB7E
;    6402 else but_cnt[3]--;
_0x6CF:
	__POINTW2MN _but_cnt,3
	LD   R30,X
	SUBI R30,LOW(1)
_0xB7E:
	ST   X,R30
;    6403 gran_char(&but_cnt[3],0,100);  
	__POINTW1MN _but_cnt,3
	CALL SUBOPT_0x90
	CALL SUBOPT_0x137
;    6404 
;    6405 
;    6406 
;    6407 }
	RET
;    6408 
;    6409 #define butE	0b11110111
;    6410 #define butE_	0b11110110
;    6411 #define butU_	0b11101110
;    6412 #define butU	0b11101111
;    6413 #define butD	0b11011111
;    6414 #define butD_	0b11011110
;    6415 #define butL	0b10111111
;    6416 #define butL_	0b10111110
;    6417 #define butR	0b01111111 
;    6418 #define butR_	0b01111110
;    6419 #define butLER	0b00110111
;    6420 #define butUD	0b11001111
;    6421 //#define butD	0b11011111
;    6422 //-----------------------------------------------
;    6423 void but_an_pult(void)
;    6424 {
_but_an_pult:
;    6425 //plazma=but_pult; 
;    6426 if(but_pult==butUD)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xCF)
	BRNE _0x6D1
;    6427 	{
;    6428 	if(ind!=iDeb)
	LDI  R30,LOW(180)
	CP   R30,R13
	BREQ _0x6D2
;    6429 		{
;    6430 		//ret_ind(ind,sub_ind,30);
;    6431 		ind=iDeb;
	MOV  R13,R30
;    6432 		}
;    6433 	else
	RJMP _0x6D3
_0x6D2:
;    6434 		{
;    6435 		ind=iAv_sel;
	CALL SUBOPT_0x138
;    6436 		sub_ind=0;
;    6437 		}	
_0x6D3:
;    6438     	}
;    6439 if(ind==iDeb)
_0x6D1:
	LDI  R30,LOW(180)
	CP   R30,R13
	BREQ PC+3
	JMP _0x6D4
;    6440 	{
;    6441  	if(but_pult==butR)
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BRNE _0x6D5
;    6442     		{
;    6443     		    		unsigned temp_U;
;    6444                 //if(sub_ind!=0)sub_ind=0;
;    6445 		sub_ind++;
	SBIW R28,2
;	temp_U -> Y+0
	CALL SUBOPT_0x139
;    6446 		gran_ring_char(&sub_ind,0,2);
	LDI  R30,LOW(2)
	ST   -Y,R30
	CALL _gran_ring_char
;    6447 		//write_vlt_registers(204,15000);
;    6448     		}    				  
	ADIW R28,2
;    6449  	else if(but_pult==butL)
	RJMP _0x6D6
_0x6D5:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BRNE _0x6D7
;    6450     		{
;    6451     		
;    6452     		
;    6453     		unsigned temp_U;
;    6454 if(sub_ind!=1)sub_ind=1;
	SBIW R28,2
;	temp_U -> Y+0
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BREQ _0x6D8
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    6455 		
;    6456           }
_0x6D8:
	ADIW R28,2
;    6457           
;    6458 	else if(but_pult==butU)
	RJMP _0x6D9
_0x6D7:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BRNE _0x6DA
;    6459     		{
;    6460     	    /*	fr_stat++;
;    6461     		gran(&fr_stat,0,100);
;    6462     		write_vlt_coil(1,0x047c,0x2000); */
;    6463  /*   		unsigned temp_U;		
;    6464 		
;    6465 		temp_U=2050-1;	
;    6466 		modbus_buffer[0]=0x02;
;    6467 		modbus_buffer[1]=0x03;
;    6468 		modbus_buffer[2]=*(((char*)(&temp_U))+1);
;    6469 		modbus_buffer[3]=*((char*)&temp_U);
;    6470 		modbus_buffer[4]=0x00;
;    6471 		modbus_buffer[5]=0x02;
;    6472 	    //	modbus_buffer[6]=0x02;
;    6473 		//modbus_buffer[7]=0x02;
;    6474 		temp_U=crc16(modbus_buffer,6);
;    6475 		modbus_buffer[6]=*(((char*)(&temp_U))+1);
;    6476 		modbus_buffer[7]=*((char*)&temp_U);
;    6477 		usart_out_adr0(modbus_buffer,8);	*/
;    6478 		
;    6479 		if(EE_MODE==emMNL)power=((power/10)+1)*10;   		
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x6DB
	CALL SUBOPT_0x13A
	CALL SUBOPT_0x13B
	STS  _power,R30
	STS  _power+1,R31
;    6480     		} 
_0x6DB:
;    6481 	else if(but_pult==butD)
	RJMP _0x6DC
_0x6DA:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BRNE _0x6DD
;    6482     		{
;    6483     		/*fr_stat--;
;    6484     		gran(&fr_stat,0,100);
;    6485     		write_vlt_coil(1,0x043c,0x2000);*/
;    6486     		if(EE_MODE==emMNL)power=((power/10)-1)*10;
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x6DE
	CALL SUBOPT_0x13A
	CALL SUBOPT_0x13C
	STS  _power,R30
	STS  _power+1,R31
;    6487     		}    		   	
_0x6DE:
;    6488 	}
_0x6DD:
_0x6DC:
_0x6D9:
_0x6D6:
;    6489     	
;    6490 else if(ind==iAv_sel)
	JMP  _0x6DF
_0x6D4:
	LDI  R30,LOW(168)
	CP   R30,R13
	BREQ PC+3
	JMP _0x6E0
;    6491 	{
;    6492 	if(but_pult==butD)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BRNE _0x6E1
;    6493 		{
;    6494 		sub_ind++;
	CALL SUBOPT_0x139
;    6495 		gran_char(&sub_ind,0,19);
	CALL SUBOPT_0x13D
;    6496 		}
;    6497 	else if(but_pult==butU)
	RJMP _0x6E2
_0x6E1:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BRNE _0x6E3
;    6498 		{         
;    6499  		sub_ind--; 
	CALL SUBOPT_0x13E
;    6500 		gran_char(&sub_ind,0,19);
	CALL SUBOPT_0x13D
;    6501 		}
;    6502 
;    6503 	else if(but_pult==butLER)
	RJMP _0x6E4
_0x6E3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0x37)
	BREQ PC+3
	JMP _0x6E5
;    6504 		{
;    6505 		av_code[0]=0xff;
	LDI  R26,LOW(_av_code)
	LDI  R27,HIGH(_av_code)
	LDI  R30,LOW(255)
	LDI  R31,HIGH(255)
	CALL __EEPROMWRW
;    6506 		av_code[1]=0xff;
	__POINTW2MN _av_code,2
	CALL __EEPROMWRW
;    6507 		av_code[2]=0xff;
	__POINTW2MN _av_code,4
	CALL __EEPROMWRW
;    6508 		av_code[3]=0xff;
	__POINTW2MN _av_code,6
	CALL __EEPROMWRW
;    6509 		av_code[4]=0xff;
	__POINTW2MN _av_code,8
	CALL __EEPROMWRW
;    6510 		av_code[5]=0xff;
	__POINTW2MN _av_code,10
	CALL __EEPROMWRW
;    6511 		av_code[6]=0xff;
	__POINTW2MN _av_code,12
	CALL __EEPROMWRW
;    6512 		av_code[7]=0xff;
	__POINTW2MN _av_code,14
	CALL __EEPROMWRW
;    6513 		av_code[8]=0xff;
	__POINTW2MN _av_code,16
	CALL __EEPROMWRW
;    6514 		av_code[9]=0xff;
	__POINTW2MN _av_code,18
	CALL __EEPROMWRW
;    6515 		av_code[10]=0xff;
	__POINTW2MN _av_code,20
	CALL __EEPROMWRW
;    6516 		av_code[11]=0xff;
	__POINTW2MN _av_code,22
	CALL __EEPROMWRW
;    6517 		av_code[12]=0xff;
	__POINTW2MN _av_code,24
	CALL __EEPROMWRW
;    6518 		av_code[13]=0xff;
	__POINTW2MN _av_code,26
	CALL __EEPROMWRW
;    6519 		av_code[14]=0xff;
	__POINTW2MN _av_code,28
	CALL __EEPROMWRW
;    6520 		av_code[15]=0xff;
	__POINTW2MN _av_code,30
	CALL __EEPROMWRW
;    6521 		av_code[16]=0xff;
	__POINTW2MN _av_code,32
	CALL __EEPROMWRW
;    6522 		av_code[17]=0xff;
	__POINTW2MN _av_code,34
	CALL __EEPROMWRW
;    6523 		av_code[18]=0xff;
	__POINTW2MN _av_code,36
	CALL __EEPROMWRW
;    6524 		av_code[19]=0xff;
	__POINTW2MN _av_code,38
	CALL __EEPROMWRW
;    6525 		}
;    6526     	else if(but_pult==butE)
	RJMP _0x6E6
_0x6E5:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x6E7
;    6527     		{
;    6528     		if((sub_ind>=0)&&(sub_ind<=19))
	LDS  R26,_sub_ind
	CPI  R26,0
	BRLO _0x6E9
	LDI  R30,LOW(19)
	CP   R30,R26
	BRSH _0x6EA
_0x6E9:
	RJMP _0x6E8
_0x6EA:
;    6529     			{
;    6530     			if(sub_ind>index_set)sub_ind1=p1;
	LDS  R30,_index_set
	LDS  R26,_sub_ind
	CP   R30,R26
	BRSH _0x6EB
	LDS  R30,_p1
	RJMP _0xB7F
;    6531     			else sub_ind1=p2;
_0x6EB:
	LDS  R30,_p2
_0xB7F:
	STS  _sub_ind1,R30
;    6532     			if(av_code[sub_ind1]!=0xff)
	CALL SUBOPT_0xF4
	CPI  R30,LOW(0xFF)
	LDI  R26,HIGH(0xFF)
	CPC  R31,R26
	BREQ _0x6ED
;    6533     				{
;    6534     				ind=iAv;
	LDI  R30,LOW(169)
	MOV  R13,R30
;    6535     			     index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6536     				ret_ind(iAv_sel,sub_ind,20);
	LDI  R30,LOW(168)
	ST   -Y,R30
	LDS  R30,_sub_ind
	ST   -Y,R30
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	ST   -Y,R31
	ST   -Y,R30
	CALL _ret_ind
;    6537     				}
;    6538     			}
_0x6ED:
;    6539     		}
_0x6E8:
;    6540     	else if((but_pult==butE_)&&(but_cnt[4]==0))
	RJMP _0x6EE
_0x6E7:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF6)
	BRNE _0x6F0
	__GETB1MN _but_cnt,4
	CPI  R30,0
	BREQ _0x6F1
_0x6F0:
	RJMP _0x6EF
_0x6F1:
;    6541     			{
;    6542     			ind=iSet;   
	CALL SUBOPT_0x13F
;    6543     			sub_ind=0;  
;    6544     			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6545     			}    				
;    6546 	}	  
_0x6EF:
_0x6EE:
_0x6E6:
_0x6E4:
_0x6E2:
;    6547 
;    6548 else if(ind==iAv)
	JMP  _0x6F2
_0x6E0:
	LDI  R30,LOW(169)
	CP   R30,R13
	BRNE _0x6F3
;    6549 	{
;    6550 	if(but_pult==butD)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BRNE _0x6F4
;    6551 		{
;    6552 		index_set=1;
	LDI  R30,LOW(1)
	STS  _index_set,R30
;    6553 		}
;    6554 	else if(but_pult==butU)
	RJMP _0x6F5
_0x6F4:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BRNE _0x6F6
;    6555 		{         
;    6556 		index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6557 		}
;    6558     	else if(but_pult==butE)
	RJMP _0x6F7
_0x6F6:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x6F8
;    6559     		{
;    6560 		ind=iAv_sel;
	LDI  R30,LOW(168)
	MOV  R13,R30
;    6561     		} 
;    6562     		
;    6563  
;    6564     		
;    6565     				
;    6566 	}
_0x6F8:
_0x6F7:
_0x6F5:
;    6567 
;    6568 else if(ind==iSet)
	JMP  _0x6F9
_0x6F3:
	LDI  R30,LOW(34)
	CP   R30,R13
	BREQ PC+3
	JMP _0x6FA
;    6569 	{
;    6570 	if(but_pult==butD)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BRNE _0x6FB
;    6571 		{
;    6572 		sub_ind++;
	CALL SUBOPT_0x139
;    6573 		gran_char(&sub_ind,0,16);
	CALL SUBOPT_0x140
;    6574 		}
;    6575 	else if(but_pult==butU)
	RJMP _0x6FC
_0x6FB:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BRNE _0x6FD
;    6576 		{         
;    6577 		sub_ind--; 
	CALL SUBOPT_0x13E
;    6578 		gran_char(&sub_ind,0,16);
	CALL SUBOPT_0x140
;    6579 		}
;    6580     	else if(but_pult==butE)
	RJMP _0x6FE
_0x6FD:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BREQ PC+3
	JMP _0x6FF
;    6581     		{
;    6582     		if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x700
;    6583     			{
;    6584     			ind=iMode_set;
	LDI  R30,LOW(179)
	MOV  R13,R30
;    6585     			}
;    6586     		else if(sub_ind==1)
	RJMP _0x701
_0x700:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x702
;    6587     			{
;    6588     			ind=iSetT;
	LDI  R30,LOW(155)
	CALL SUBOPT_0x141
;    6589     			sub_ind=0;
;    6590     			}           
;    6591     		else if(sub_ind==2)
	RJMP _0x703
_0x702:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x704
;    6592     			{
;    6593     			ind=iTemper_set;
	LDI  R30,LOW(178)
	CALL SUBOPT_0x141
;    6594     			sub_ind=0;
;    6595     			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6596     			}  
;    6597     		else if(sub_ind==3)
	RJMP _0x705
_0x704:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x706
;    6598     			{
;    6599     			ind=iNet_set;
	LDI  R30,LOW(158)
	CALL SUBOPT_0x141
;    6600     			sub_ind=0;
;    6601     			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6602     			}  
;    6603     		else if(sub_ind==4)
	RJMP _0x707
_0x706:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x708
;    6604     			{
;    6605     			ind=iDavl;
	LDI  R30,LOW(117)
	CALL SUBOPT_0x141
;    6606     			sub_ind=0;
;    6607     			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6608     			}  
;    6609    		else if(sub_ind==5)
	RJMP _0x709
_0x708:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x70A
;    6610     			{
;    6611     			ind=iDv_num_set;
	LDI  R30,LOW(188)
	CALL SUBOPT_0x141
;    6612     			sub_ind=0;
;    6613     			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6614     			}      			      			  
;    6615     		else if(sub_ind==6)
	RJMP _0x70B
_0x70A:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x70C
;    6616     			{
;    6617     			ind=iStep_start;
	LDI  R30,LOW(170)
	CALL SUBOPT_0x141
;    6618     			sub_ind=0;
;    6619     			}    
;    6620     		else if(sub_ind==7)
	RJMP _0x70D
_0x70C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x70E
;    6621     			{
;    6622     			ind=iDv_change;
	LDI  R30,LOW(176)
	CALL SUBOPT_0x141
;    6623     			sub_ind=0;
;    6624     			}   
;    6625     		else if(sub_ind==8)
	RJMP _0x70F
_0x70E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x8)
	BRNE _0x710
;    6626     			{
;    6627     			ind=iDv_change1;
	LDI  R30,LOW(177)
	CALL SUBOPT_0x141
;    6628     			sub_ind=0;
;    6629     			}      
;    6630     		else if(sub_ind==9)
	RJMP _0x711
_0x710:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x9)
	BRNE _0x712
;    6631     			{
;    6632     			ind=iFp_set;
	LDI  R30,LOW(181)
	CALL SUBOPT_0x141
;    6633     			sub_ind=0;
;    6634     			read_vlt_register(204,2);
	CALL SUBOPT_0x63
;    6635     			}        
;    6636     		else if(sub_ind==10)
	RJMP _0x713
_0x712:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xA)
	BRNE _0x714
;    6637     			{
;    6638     			ind=iDoor_set;
	LDI  R30,LOW(182)
	CALL SUBOPT_0x141
;    6639     			sub_ind=0;
;    6640     			}        
;    6641     		else if(sub_ind==11)
	RJMP _0x715
_0x714:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xB)
	BRNE _0x716
;    6642     			{
;    6643     			ind=iProbe_set;
	LDI  R30,LOW(183)
	CALL SUBOPT_0x141
;    6644     			sub_ind=0;
;    6645     			} 
;    6646     		else if(sub_ind==12)
	RJMP _0x717
_0x716:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xC)
	BRNE _0x718
;    6647     			{
;    6648     			ind=iHh_set;
	LDI  R30,LOW(184)
	CALL SUBOPT_0x141
;    6649     			sub_ind=0;
;    6650     			}  
;    6651     		else if(sub_ind==13)
	RJMP _0x719
_0x718:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xD)
	BRNE _0x71A
;    6652     			{
;    6653     			ind=iTimer_sel;
	LDI  R30,LOW(160)
	CALL SUBOPT_0x141
;    6654     			sub_ind=0;
;    6655     			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6656     			} 
;    6657     		else if(sub_ind==14)
	RJMP _0x71B
_0x71A:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xE)
	BRNE _0x71C
;    6658     			{
;    6659     			ind=iZero_load_set;
	LDI  R30,LOW(186)
	CALL SUBOPT_0x141
;    6660     			sub_ind=0;
;    6661     			} 
;    6662     		else if(sub_ind==15)
	RJMP _0x71D
_0x71C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0xF)
	BRNE _0x71E
;    6663     			{
;    6664     			ind=iPid_set;
	LDI  R30,LOW(159)
	CALL SUBOPT_0x141
;    6665     			sub_ind=0;
;    6666     			}    			
;    6667     		else if(sub_ind==16)
	RJMP _0x71F
_0x71E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x10)
	BRNE _0x720
;    6668     			{
;    6669     			ind=iAv_sel;
	CALL SUBOPT_0x138
;    6670     			sub_ind=0;
;    6671     			}     			     			    			   			        			 			  			     			 						    			
;    6672     		}
_0x720:
_0x71F:
_0x71D:
_0x71B:
_0x719:
_0x717:
_0x715:
_0x713:
_0x711:
_0x70F:
_0x70D:
_0x70B:
_0x709:
_0x707:
_0x705:
_0x703:
_0x701:
;    6673 
;    6674 		
;    6675 	}
_0x6FF:
_0x6FE:
_0x6FC:
;    6676 else if(ind==iSetT)
	JMP  _0x721
_0x6FA:
	LDI  R30,LOW(155)
	CP   R30,R13
	BREQ PC+3
	JMP _0x722
;    6677 	{     
;    6678 	char temp;
;    6679 	if(but_pult==butR)
	SBIW R28,1
;	temp -> Y+0
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BRNE _0x723
;    6680 		{
;    6681 		sub_ind++;
	CALL SUBOPT_0x139
;    6682 		gran_ring_char(&sub_ind,0,6);
	CALL SUBOPT_0x142
;    6683 		if(sub_ind>5)index_set=1;
	LDI  R30,LOW(5)
	CP   R30,R26
	BRSH _0x724
	LDI  R30,LOW(1)
	STS  _index_set,R30
;    6684 		else if(sub_ind==0)index_set=0;
	RJMP _0x725
_0x724:
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x726
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6685 		}
_0x726:
_0x725:
;    6686 	else if(but_pult==butL)
	RJMP _0x727
_0x723:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BRNE _0x728
;    6687 		{         
;    6688 		sub_ind--;
	CALL SUBOPT_0x13E
;    6689 		gran_ring_char(&sub_ind,0,6);
	CALL SUBOPT_0x142
;    6690 		if(sub_ind<3)index_set=0;
	CPI  R26,LOW(0x3)
	BRSH _0x729
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    6691 		else if(sub_ind==6)index_set=1;
	RJMP _0x72A
_0x729:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x72B
	LDI  R30,LOW(1)
	STS  _index_set,R30
;    6692 		}
_0x72B:
_0x72A:
;    6693     	else if(but_pult==butE)
	RJMP _0x72C
_0x728:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x72D
;    6694     		{
;    6695 		ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    6696   		sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    6697     		}
;    6698     	else if(sub_ind==0)
	RJMP _0x72E
_0x72D:
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x72F
;    6699     		{    
;    6700     		temp=_hour;
	LDS  R30,__hour
	CALL SUBOPT_0x143
;    6701     		if((but_pult==butU)||(but_pult==butU_))
	BREQ _0x731
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEE)
	BRNE _0x730
_0x731:
;    6702     			{
;    6703     			temp++;
	CALL SUBOPT_0x18
;    6704     			gran_ring_char(&temp,0,23);
	MOVW R30,R28
	CALL SUBOPT_0x90
	CALL SUBOPT_0x144
;    6705     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6706     			} 
;    6707    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0x733
_0x730:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0x735
	CPI  R26,LOW(0xDE)
	BRNE _0x734
_0x735:
;    6708     			{
;    6709     			temp--;
	CALL SUBOPT_0x145
;    6710     			gran_ring_char(&temp,0,23);
	CALL SUBOPT_0x144
;    6711     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6712     			}       			                         
;    6713     		write_ds14287(HOURS,temp);
_0x734:
_0x733:
	CALL SUBOPT_0x146
;    6714     		_hour=read_ds14287(HOURS);	
	CALL SUBOPT_0x43
	STS  __hour,R30
;    6715     		}
;    6716     	else if(sub_ind==1)
	RJMP _0x737
_0x72F:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x738
;    6717     		{    
;    6718     		temp=_min;
	LDS  R30,__min
	CALL SUBOPT_0x143
;    6719     		if((but_pult==butU)||(but_pult==butU_))
	BREQ _0x73A
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEE)
	BRNE _0x739
_0x73A:
;    6720     			{
;    6721     			temp++;
	CALL SUBOPT_0x18
;    6722     			gran_ring_char(&temp,0,59);
	MOVW R30,R28
	CALL SUBOPT_0x90
	CALL SUBOPT_0x147
;    6723     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6724     			} 
;    6725    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0x73C
_0x739:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0x73E
	CPI  R26,LOW(0xDE)
	BRNE _0x73D
_0x73E:
;    6726     			{
;    6727     			temp--;
	CALL SUBOPT_0x145
;    6728     			gran_ring_char(&temp,0,59);
	CALL SUBOPT_0x147
;    6729     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6730     			}       			                         
;    6731     		write_ds14287(MINUTES,temp);
_0x73D:
_0x73C:
	CALL SUBOPT_0x148
;    6732     		_min=read_ds14287(MINUTES);	
	CALL SUBOPT_0x44
	STS  __min,R30
;    6733     		}
;    6734     	else if(sub_ind==2)
	RJMP _0x740
_0x738:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x741
;    6735     		{    
;    6736  		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x742
;    6737  			{
;    6738  			write_ds14287(SECONDS,0);
	CALL SUBOPT_0x149
	CALL _write_ds14287
;    6739  			_sec=read_ds14287(SECONDS);
	CALL SUBOPT_0x45
	STS  __sec,R30
;    6740  			}	
;    6741     		}
_0x742:
;    6742     	else if(sub_ind==3)
	RJMP _0x743
_0x741:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0x744
;    6743     		{    
;    6744     		temp=_day;
	LDS  R30,__day
	CALL SUBOPT_0x143
;    6745     		if((but_pult==butU)||(but_pult==butU_))
	BREQ _0x746
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEE)
	BRNE _0x745
_0x746:
;    6746     			{
;    6747     			temp++;
	CALL SUBOPT_0x18
;    6748     			gran_ring_char(&temp,1,DAY_MONTHS[_month-1]);
	MOVW R30,R28
	CALL SUBOPT_0x65
	LDI  R30,LOW(_DAY_MONTHS*2)
	LDI  R31,HIGH(_DAY_MONTHS*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x62
	CALL SUBOPT_0x14A
;    6749     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6750     			} 
;    6751    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0x748
_0x745:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0x74A
	CPI  R26,LOW(0xDE)
	BRNE _0x749
_0x74A:
;    6752     			{
;    6753     			temp--;
	CALL SUBOPT_0x14B
;    6754     			gran_ring_char(&temp,1,DAY_MONTHS[_month-1]);
	LDI  R30,LOW(_DAY_MONTHS*2)
	LDI  R31,HIGH(_DAY_MONTHS*2)
	PUSH R31
	PUSH R30
	LDS  R30,__month
	SUBI R30,LOW(1)
	POP  R26
	POP  R27
	CALL SUBOPT_0x62
	CALL SUBOPT_0x14A
;    6755     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6756     			}       			                         
;    6757     		write_ds14287(DAY_OF_THE_MONTH,temp);
_0x749:
_0x748:
	LDI  R30,LOW(7)
	CALL SUBOPT_0x14C
;    6758     		_day=read_ds14287(DAY_OF_THE_MONTH);	
	CALL SUBOPT_0x46
	STS  __day,R30
;    6759     		} 
;    6760     	else if(sub_ind==4)
	RJMP _0x74C
_0x744:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x74D
;    6761     		{    
;    6762     		temp=_month;
	LDS  R30,__month
	CALL SUBOPT_0x143
;    6763     		if((but_pult==butU)||(but_pult==butU_))
	BREQ _0x74F
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEE)
	BRNE _0x74E
_0x74F:
;    6764     			{
;    6765     			temp++;
	CALL SUBOPT_0x18
;    6766     			gran_ring_char(&temp,1,12);
	MOVW R30,R28
	CALL SUBOPT_0x65
	LDI  R30,LOW(12)
	CALL SUBOPT_0x14A
;    6767     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6768     			} 
;    6769    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0x751
_0x74E:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0x753
	CPI  R26,LOW(0xDE)
	BRNE _0x752
_0x753:
;    6770     			{
;    6771     			temp--;
	CALL SUBOPT_0x14B
;    6772     			gran_ring_char(&temp,1,12);
	LDI  R30,LOW(12)
	CALL SUBOPT_0x14A
;    6773     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6774     			}       			                         
;    6775     		write_ds14287(MONTH,temp);
_0x752:
_0x751:
	LDI  R30,LOW(8)
	CALL SUBOPT_0x14C
;    6776     		_month=read_ds14287(MONTH);	
	CALL SUBOPT_0x47
	STS  __month,R30
;    6777     		} 
;    6778     	else if(sub_ind==5)
	RJMP _0x755
_0x74D:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x756
;    6779     		{    
;    6780     		temp=_year;
	LDS  R30,__year
	CALL SUBOPT_0x143
;    6781     		if((but_pult==butU)||(but_pult==butU_))
	BREQ _0x758
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEE)
	BRNE _0x757
_0x758:
;    6782     			{
;    6783     			temp++;
	CALL SUBOPT_0x18
;    6784     			gran_ring_char(&temp,0,99);
	MOVW R30,R28
	CALL SUBOPT_0x90
	LDI  R30,LOW(99)
	CALL SUBOPT_0x14A
;    6785     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6786     			} 
;    6787    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0x75A
_0x757:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0x75C
	CPI  R26,LOW(0xDE)
	BRNE _0x75B
_0x75C:
;    6788     			{
;    6789     			temp--;
	CALL SUBOPT_0x145
;    6790     			gran_ring_char(&temp,0,99);
	LDI  R30,LOW(99)
	CALL SUBOPT_0x14A
;    6791     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6792     			}       			                         
;    6793     		write_ds14287(YEAR,temp);
_0x75B:
_0x75A:
	LDI  R30,LOW(9)
	CALL SUBOPT_0x14C
;    6794     		_year=read_ds14287(YEAR);	
	CALL SUBOPT_0x48
	STS  __year,R30
;    6795     		}      
;    6796     	else if(sub_ind==6)
	RJMP _0x75E
_0x756:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x75F
;    6797     		{    
;    6798     		temp=_week_day;
	LDS  R30,__week_day
	CALL SUBOPT_0x143
;    6799     		if((but_pult==butU)||(but_pult==butU_))
	BREQ _0x761
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEE)
	BRNE _0x760
_0x761:
;    6800     			{
;    6801     			temp++;
	CALL SUBOPT_0x18
;    6802     			gran_ring_char(&temp,1,7);
	MOVW R30,R28
	CALL SUBOPT_0x65
	LDI  R30,LOW(7)
	CALL SUBOPT_0x14A
;    6803     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6804     			} 
;    6805    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0x763
_0x760:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0x765
	CPI  R26,LOW(0xDE)
	BRNE _0x764
_0x765:
;    6806     			{
;    6807     			temp--;
	CALL SUBOPT_0x14B
;    6808     			gran_ring_char(&temp,1,7);
	LDI  R30,LOW(7)
	CALL SUBOPT_0x14A
;    6809     			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6810     			}       			                         
;    6811     		write_ds14287(DAY_OF_THE_WEEK,temp);
_0x764:
_0x763:
	LDI  R30,LOW(6)
	CALL SUBOPT_0x14C
;    6812     		_week_day=read_ds14287(DAY_OF_THE_WEEK);	
	CALL SUBOPT_0x97
;    6813     		}         				    		   		    		
;    6814 		
;    6815 	}    
_0x75F:
_0x75E:
_0x755:
_0x74C:
_0x743:
_0x740:
_0x737:
_0x72E:
_0x72C:
_0x727:
	ADIW R28,1
;    6816 	
;    6817 else if(ind==iMode_set)
	JMP  _0x767
_0x722:
	LDI  R30,LOW(179)
	CP   R30,R13
	BREQ PC+3
	JMP _0x768
;    6818 	{
;    6819 	if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x76A
	CPI  R26,LOW(0x7E)
	BRNE _0x769
_0x76A:
;    6820 		{
;    6821 		if(EE_MODE==emAVT)EE_MODE=emTST;
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x76C
	LDI  R30,LOW(204)
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMWRB
;    6822 		else if(EE_MODE==emTST)EE_MODE=emMNL;
	RJMP _0x76D
_0x76C:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xCC)
	BRNE _0x76E
	LDI  R30,LOW(170)
	RJMP _0xB80
;    6823 		else EE_MODE=emAVT; 
_0x76E:
	LDI  R30,LOW(85)
_0xB80:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMWRB
_0x76D:
;    6824 		} 
;    6825 
;    6826 	else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x770
_0x769:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x772
	CPI  R26,LOW(0xBE)
	BRNE _0x771
_0x772:
;    6827 		{
;    6828 		if(EE_MODE==emAVT)EE_MODE=emMNL;
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x774
	LDI  R30,LOW(170)
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMWRB
;    6829 		else if(EE_MODE==emMNL)EE_MODE=emTST;
	RJMP _0x775
_0x774:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xAA)
	BRNE _0x776
	LDI  R30,LOW(204)
	RJMP _0xB81
;    6830 		else EE_MODE=emAVT; 
_0x776:
	LDI  R30,LOW(85)
_0xB81:
	LDI  R26,LOW(_EE_MODE)
	LDI  R27,HIGH(_EE_MODE)
	CALL __EEPROMWRB
_0x775:
;    6831 		}		
;    6832 	else if(but_pult==butE)
	RJMP _0x778
_0x771:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x779
;    6833 		{
;    6834 		ind=iSet;
	CALL SUBOPT_0x13F
;    6835 		sub_ind=0;
;    6836 		}				
;    6837 	}		
_0x779:
_0x778:
_0x770:
;    6838 	
;    6839 else if(ind==iTemper_set)
	JMP  _0x77A
_0x768:
	LDI  R30,LOW(178)
	CP   R30,R13
	BREQ PC+3
	JMP _0x77B
;    6840 	{
;    6841  	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x77C
;    6842 		{
;    6843 		if((but_pult==butR)||(but_pult==butR_)||(but_pult==butL)||(but_pult==butL_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x77E
	CPI  R26,LOW(0x7E)
	BREQ _0x77E
	CPI  R26,LOW(0xBF)
	BREQ _0x77E
	CPI  R26,LOW(0xBE)
	BRNE _0x77D
_0x77E:
;    6844 			{
;    6845 			if(TEMPER_SIGN==0)TEMPER_SIGN=1;
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	CPI  R30,0
	BRNE _0x780
	LDI  R30,LOW(1)
	RJMP _0xB82
;    6846 			else TEMPER_SIGN=0;
_0x780:
	LDI  R30,LOW(0)
_0xB82:
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMWRB
;    6847 			}
;    6848 		else if(but_pult==butE)
	RJMP _0x782
_0x77D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x783
;    6849 			{
;    6850 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    6851 			}	 		 
;    6852 		}	
_0x783:
_0x782:
;    6853 	else if(sub_ind==1)
	RJMP _0x784
_0x77C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x785
;    6854 		{
;    6855 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x787
	CPI  R26,LOW(0x7E)
	BRNE _0x786
_0x787:
;    6856 			{
;    6857 			AV_TEMPER_COOL++;
	LDI  R26,LOW(_AV_TEMPER_COOL)
	LDI  R27,HIGH(_AV_TEMPER_COOL)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    6858 			granee(&AV_TEMPER_COOL,0,50);
	LDI  R30,LOW(_AV_TEMPER_COOL)
	LDI  R31,HIGH(_AV_TEMPER_COOL)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x14D
;    6859 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6860 			}
;    6861 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x789
_0x786:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x78B
	CPI  R26,LOW(0xBE)
	BRNE _0x78A
_0x78B:
;    6862 			{
;    6863 			AV_TEMPER_COOL--;
	LDI  R26,LOW(_AV_TEMPER_COOL)
	LDI  R27,HIGH(_AV_TEMPER_COOL)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    6864 			granee(&AV_TEMPER_COOL,0,50);
	LDI  R30,LOW(_AV_TEMPER_COOL)
	LDI  R31,HIGH(_AV_TEMPER_COOL)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x14D
;    6865 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6866 			} 
;    6867 		else if(but_pult==butE)
	RJMP _0x78D
_0x78A:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x78E
;    6868 			{
;    6869 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    6870 			}		
;    6871 		}
_0x78E:
_0x78D:
_0x789:
;    6872 	else if(sub_ind==2)
	RJMP _0x78F
_0x785:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x790
;    6873 		{		
;    6874 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x792
	CPI  R26,LOW(0x7E)
	BRNE _0x791
_0x792:
;    6875 			{
;    6876 			T_ON_WARM++;
	LDI  R26,LOW(_T_ON_WARM)
	LDI  R27,HIGH(_T_ON_WARM)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    6877 			granee(&T_ON_WARM,0,50);
	LDI  R30,LOW(_T_ON_WARM)
	LDI  R31,HIGH(_T_ON_WARM)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x14D
;    6878 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6879 			}
;    6880 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x794
_0x791:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x796
	CPI  R26,LOW(0xBE)
	BRNE _0x795
_0x796:
;    6881 			{
;    6882 			T_ON_WARM--;
	LDI  R26,LOW(_T_ON_WARM)
	LDI  R27,HIGH(_T_ON_WARM)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    6883 			granee(&T_ON_WARM,0,50);
	LDI  R30,LOW(_T_ON_WARM)
	LDI  R31,HIGH(_T_ON_WARM)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x14D
;    6884 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6885 			} 
;    6886 		else if(but_pult==butE)
	RJMP _0x798
_0x795:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x799
;    6887 			{
;    6888 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    6889 			}		
;    6890 		}							
_0x799:
_0x798:
_0x794:
;    6891 
;    6892 	else if(sub_ind==3)
	RJMP _0x79A
_0x790:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x79B
;    6893 		{
;    6894 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x79D
	CPI  R26,LOW(0x7E)
	BRNE _0x79C
_0x79D:
;    6895 			{
;    6896 			Kt[TEMPER_SIGN]++;
	CALL SUBOPT_0x14E
	CALL SUBOPT_0x9C
;    6897 			granee(&Kt[TEMPER_SIGN],400,550);
	CALL SUBOPT_0x14F
	CALL SUBOPT_0x150
;    6898 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6899 			}
;    6900 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x79F
_0x79C:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7A1
	CPI  R26,LOW(0xBE)
	BRNE _0x7A0
_0x7A1:
;    6901 			{
;    6902 			Kt[TEMPER_SIGN]--;
	CALL SUBOPT_0x14E
	CALL SUBOPT_0x151
;    6903 			granee(&Kt[TEMPER_SIGN],400,550);
	CALL SUBOPT_0x14F
	CALL SUBOPT_0x150
;    6904 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6905 			} 
;    6906 		else if(but_pult==butE)
	RJMP _0x7A3
_0x7A0:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7A4
;    6907 			{
;    6908 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    6909 			}
;    6910 		}
_0x7A4:
_0x7A3:
_0x79F:
;    6911 	else if(sub_ind==4)
	RJMP _0x7A5
_0x79B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x7A6
;    6912 		{		
;    6913 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7A8
	CPI  R26,LOW(0x7E)
	BRNE _0x7A7
_0x7A8:
;    6914 			{
;    6915 			T_ON_COOL++;
	LDI  R26,LOW(_T_ON_COOL)
	LDI  R27,HIGH(_T_ON_COOL)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    6916 			granee(&T_ON_COOL,0,100);
	LDI  R30,LOW(_T_ON_COOL)
	LDI  R31,HIGH(_T_ON_COOL)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x152
;    6917 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6918 			}
;    6919 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x7AA
_0x7A7:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7AC
	CPI  R26,LOW(0xBE)
	BRNE _0x7AB
_0x7AC:
;    6920 			{
;    6921 			T_ON_COOL--;
	LDI  R26,LOW(_T_ON_COOL)
	LDI  R27,HIGH(_T_ON_COOL)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    6922 			granee(&T_ON_COOL,0,100);
	LDI  R30,LOW(_T_ON_COOL)
	LDI  R31,HIGH(_T_ON_COOL)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x152
;    6923 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6924 			} 
;    6925 		else if(but_pult==butE)
	RJMP _0x7AE
_0x7AB:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7AF
;    6926 			{
;    6927 			sub_ind=5;
	LDI  R30,LOW(5)
	STS  _sub_ind,R30
;    6928 			}
;    6929 		}		 
_0x7AF:
_0x7AE:
_0x7AA:
;    6930 	else if(sub_ind==5)
	RJMP _0x7B0
_0x7A6:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x7B1
;    6931 		{		
;    6932 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7B3
	CPI  R26,LOW(0x7E)
	BRNE _0x7B2
_0x7B3:
;    6933 			{
;    6934 			AV_TEMPER_HEAT++;
	LDI  R26,LOW(_AV_TEMPER_HEAT)
	LDI  R27,HIGH(_AV_TEMPER_HEAT)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    6935 			granee(&AV_TEMPER_HEAT,0,100);
	LDI  R30,LOW(_AV_TEMPER_HEAT)
	LDI  R31,HIGH(_AV_TEMPER_HEAT)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x152
;    6936 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6937 			}
;    6938 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x7B5
_0x7B2:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7B7
	CPI  R26,LOW(0xBE)
	BRNE _0x7B6
_0x7B7:
;    6939 			{
;    6940 			AV_TEMPER_HEAT--;
	LDI  R26,LOW(_AV_TEMPER_HEAT)
	LDI  R27,HIGH(_AV_TEMPER_HEAT)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    6941 			granee(&AV_TEMPER_HEAT,0,100);
	LDI  R30,LOW(_AV_TEMPER_HEAT)
	LDI  R31,HIGH(_AV_TEMPER_HEAT)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x152
;    6942 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6943 			} 
;    6944 		else if(but_pult==butE)
	RJMP _0x7B9
_0x7B6:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7BA
;    6945 			{
;    6946 			sub_ind=6;
	LDI  R30,LOW(6)
	STS  _sub_ind,R30
;    6947 			}
;    6948 		}		  
_0x7BA:
_0x7B9:
_0x7B5:
;    6949 	else if(sub_ind==6)
	RJMP _0x7BB
_0x7B1:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x7BC
;    6950 		{		
;    6951 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7BE
	CPI  R26,LOW(0x7E)
	BRNE _0x7BD
_0x7BE:
;    6952 			{
;    6953 			TEMPER_GIST++;
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    6954 			granee(&TEMPER_GIST,0,10);
	LDI  R30,LOW(_TEMPER_GIST)
	LDI  R31,HIGH(_TEMPER_GIST)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x153
;    6955 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6956 			}
;    6957 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x7C0
_0x7BD:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7C2
	CPI  R26,LOW(0xBE)
	BRNE _0x7C1
_0x7C2:
;    6958 			{
;    6959 			TEMPER_GIST--;
	LDI  R26,LOW(_TEMPER_GIST)
	LDI  R27,HIGH(_TEMPER_GIST)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    6960 			granee(&TEMPER_GIST,0,10);
	LDI  R30,LOW(_TEMPER_GIST)
	LDI  R31,HIGH(_TEMPER_GIST)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x153
;    6961 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    6962 			} 
;    6963 		else if(but_pult==butE)
	RJMP _0x7C4
_0x7C1:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7C5
;    6964 			{
;    6965 			sub_ind=7;
	LDI  R30,LOW(7)
	STS  _sub_ind,R30
;    6966 			}
;    6967 		}														
_0x7C5:
_0x7C4:
_0x7C0:
;    6968 	else if(sub_ind==7)
	RJMP _0x7C6
_0x7BC:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x7C7
;    6969 		{
;    6970 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7C8
;    6971     			{
;    6972     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    6973     			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    6974     			}		
;    6975 		}			
_0x7C8:
;    6976 	} 
_0x7C7:
_0x7C6:
_0x7BB:
_0x7B0:
_0x7A5:
_0x79A:
_0x78F:
_0x784:
;    6977 	 		 
;    6978 else if(ind==iNet_set)
	JMP  _0x7C9
_0x77B:
	LDI  R30,LOW(158)
	CP   R30,R13
	BREQ PC+3
	JMP _0x7CA
;    6979 	{
;    6980  	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BREQ PC+3
	JMP _0x7CB
;    6981 		{
;    6982 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7CD
	CPI  R26,LOW(0x7E)
	BRNE _0x7CC
_0x7CD:
;    6983 			{
;    6984 			if(AV_NET_PERCENT==10)AV_NET_PERCENT=15;
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x7CF
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMWRW
;    6985 			else if(AV_NET_PERCENT==15)AV_NET_PERCENT=20;
	RJMP _0x7D0
_0x7CF:
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x7D1
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	RJMP _0xB83
;    6986 			else AV_NET_PERCENT=10;
_0x7D1:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
_0xB83:
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMWRW
_0x7D0:
;    6987 			}       
;    6988 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x7D3
_0x7CC:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7D5
	CPI  R26,LOW(0xBE)
	BRNE _0x7D4
_0x7D5:
;    6989 			{
;    6990 			if(AV_NET_PERCENT==10)AV_NET_PERCENT=20;
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	BRNE _0x7D7
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMWRW
;    6991 			else if(AV_NET_PERCENT==15)AV_NET_PERCENT=10;
	RJMP _0x7D8
_0x7D7:
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	CPI  R30,LOW(0xF)
	LDI  R26,HIGH(0xF)
	CPC  R31,R26
	BRNE _0x7D9
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RJMP _0xB84
;    6992 			else AV_NET_PERCENT=15;
_0x7D9:
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
_0xB84:
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMWRW
_0x7D8:
;    6993 			}			
;    6994 		else if(but_pult==butE)
	RJMP _0x7DB
_0x7D4:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7DC
;    6995 			{
;    6996 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    6997 			}	 		 
;    6998 		}	
_0x7DC:
_0x7DB:
_0x7D3:
;    6999 	else if(sub_ind==1)
	RJMP _0x7DD
_0x7CB:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x7DE
;    7000 		{
;    7001 		if((but_pult==butR)||(but_pult==butR_)||(but_pult==butL)||(but_pult==butL_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7E0
	CPI  R26,LOW(0x7E)
	BREQ _0x7E0
	CPI  R26,LOW(0xBF)
	BREQ _0x7E0
	CPI  R26,LOW(0xBE)
	BRNE _0x7DF
_0x7E0:
;    7002 			{
;    7003 			if(fasing==f_ABC)fasing=f_ACB;
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x7E2
	LDI  R30,LOW(170)
	RJMP _0xB85
;    7004 			else fasing=f_ABC;
_0x7E2:
	LDI  R30,LOW(85)
_0xB85:
	LDI  R26,LOW(_fasing)
	LDI  R27,HIGH(_fasing)
	CALL __EEPROMWRB
;    7005 			}
;    7006 		else if(but_pult==butE)
	RJMP _0x7E4
_0x7DF:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7E5
;    7007 			{
;    7008 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7009 			}	 			
;    7010 		}
_0x7E5:
_0x7E4:
;    7011 	else if(sub_ind==2)
	RJMP _0x7E6
_0x7DE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x7E7
;    7012 		{		
;    7013 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7E9
	CPI  R26,LOW(0x7E)
	BRNE _0x7E8
_0x7E9:
;    7014 			{
;    7015 			Kun[0]--;
	LDI  R26,LOW(_Kun)
	LDI  R27,HIGH(_Kun)
	CALL __EEPROMRDW
	CALL SUBOPT_0x151
;    7016 			granee(&Kun[0],300,500);
	CALL SUBOPT_0xC6
;    7017 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7018 			}
;    7019 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x7EB
_0x7E8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7ED
	CPI  R26,LOW(0xBE)
	BRNE _0x7EC
_0x7ED:
;    7020 			{
;    7021 			Kun[0]++;
	LDI  R26,LOW(_Kun)
	LDI  R27,HIGH(_Kun)
	CALL __EEPROMRDW
	CALL SUBOPT_0x9C
;    7022 			granee(&Kun[0],300,500);
	CALL SUBOPT_0xC6
;    7023 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7024 			} 
;    7025 		else if(but_pult==butE)
	RJMP _0x7EF
_0x7EC:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7F0
;    7026 			{
;    7027 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7028 			}
;    7029 		}							
_0x7F0:
_0x7EF:
_0x7EB:
;    7030 
;    7031 	else if(sub_ind==3)
	RJMP _0x7F1
_0x7E7:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x7F2
;    7032 		{		
;    7033 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7F4
	CPI  R26,LOW(0x7E)
	BRNE _0x7F3
_0x7F4:
;    7034 			{
;    7035 			Kun[1]--;
	__POINTW2MN _Kun,2
	CALL __EEPROMRDW
	CALL SUBOPT_0x151
;    7036 			granee(&Kun[1],300,500);
	__POINTW1MN _Kun,2
	CALL SUBOPT_0xC7
;    7037 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7038 			}
;    7039 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x7F6
_0x7F3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x7F8
	CPI  R26,LOW(0xBE)
	BRNE _0x7F7
_0x7F8:
;    7040 			{
;    7041 			Kun[1]++;
	__POINTW2MN _Kun,2
	CALL __EEPROMRDW
	CALL SUBOPT_0x9C
;    7042 			granee(&Kun[1],300,500);
	__POINTW1MN _Kun,2
	CALL SUBOPT_0xC7
;    7043 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7044 			} 
;    7045 		else if(but_pult==butE)
	RJMP _0x7FA
_0x7F7:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x7FB
;    7046 			{
;    7047 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7048 			}
;    7049 		}
_0x7FB:
_0x7FA:
_0x7F6:
;    7050 	else if(sub_ind==4)
	RJMP _0x7FC
_0x7F2:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x7FD
;    7051 		{		
;    7052 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x7FF
	CPI  R26,LOW(0x7E)
	BRNE _0x7FE
_0x7FF:
;    7053 			{
;    7054 			Kun[2]--;
	__POINTW2MN _Kun,4
	CALL __EEPROMRDW
	CALL SUBOPT_0x151
;    7055 			granee(&Kun[2],300,500);
	__POINTW1MN _Kun,4
	CALL SUBOPT_0xC7
;    7056 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7057 			}
;    7058 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x801
_0x7FE:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x803
	CPI  R26,LOW(0xBE)
	BRNE _0x802
_0x803:
;    7059 			{
;    7060 			Kun[2]++;
	__POINTW2MN _Kun,4
	CALL __EEPROMRDW
	CALL SUBOPT_0x9C
;    7061 			granee(&Kun[2],300,500);
	__POINTW1MN _Kun,4
	CALL SUBOPT_0xC7
;    7062 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7063 			} 
;    7064 		else if(but_pult==butE)
	RJMP _0x805
_0x802:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x806
;    7065 			{
;    7066 			sub_ind=5;
	LDI  R30,LOW(5)
	STS  _sub_ind,R30
;    7067 			}
;    7068 		}										
_0x806:
_0x805:
_0x801:
;    7069 	else if(sub_ind==5)
	RJMP _0x807
_0x7FD:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x808
;    7070 		{
;    7071 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x809
;    7072     			{
;    7073     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7074     			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7075     			}		
;    7076 		}			
_0x809:
;    7077 
;    7078 	}  	          	
_0x808:
_0x807:
_0x7FC:
_0x7F1:
_0x7E6:
_0x7DD:
;    7079 else if(ind==iDavl)
	JMP  _0x80A
_0x7CA:
	LDI  R30,LOW(117)
	CP   R30,R13
	BREQ PC+3
	JMP _0x80B
;    7080 	{
;    7081 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7082 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BREQ PC+3
	JMP _0x80C
;    7083 		{
;    7084 		if(but_pult==butR)
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BRNE _0x80D
;    7085 			{
;    7086 			if(P_SENS==6)P_SENS=10;
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x6)
	BRNE _0x80E
	LDI  R30,LOW(10)
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMWRB
;    7087 			else if(P_SENS==10)P_SENS=16;
	RJMP _0x80F
_0x80E:
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xA)
	BRNE _0x810
	LDI  R30,LOW(16)
	RJMP _0xB86
;    7088 			else P_SENS=6;
_0x810:
	LDI  R30,LOW(6)
_0xB86:
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMWRB
_0x80F:
;    7089 			}           
;    7090 		else if(but_pult==butL)
	RJMP _0x812
_0x80D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BRNE _0x813
;    7091 			{
;    7092 			if(P_SENS==6)P_SENS=16;
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x6)
	BRNE _0x814
	LDI  R30,LOW(16)
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMWRB
;    7093 			else if(P_SENS==10)P_SENS=6;
	RJMP _0x815
_0x814:
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMRDB
	CPI  R30,LOW(0xA)
	BRNE _0x816
	LDI  R30,LOW(6)
	RJMP _0xB87
;    7094 			else P_SENS=10;
_0x816:
	LDI  R30,LOW(10)
_0xB87:
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMWRB
_0x815:
;    7095 			} 
;    7096 		else if(but_pult==butE)
	RJMP _0x818
_0x813:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x819
;    7097 			{
;    7098 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7099 			}			 		 
;    7100 		}
_0x819:
_0x818:
_0x812:
;    7101 	else if(sub_ind==1)
	RJMP _0x81A
_0x80C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x81B
;    7102 		{
;    7103 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x81D
	CPI  R26,LOW(0x7E)
	BRNE _0x81C
_0x81D:
;    7104 			{
;    7105 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7106 			P_MIN++;
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7107 			granee(&P_MIN,1,80);
	CALL SUBOPT_0x154
;    7108 			}           
;    7109 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x81F
_0x81C:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x821
	CPI  R26,LOW(0xBE)
	BRNE _0x820
_0x821:
;    7110 			{
;    7111 			speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7112 			P_MIN--;
	LDI  R26,LOW(_P_MIN)
	LDI  R27,HIGH(_P_MIN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7113 			granee(&P_MIN,1,80);
	CALL SUBOPT_0x154
;    7114 			}       
;    7115 		else if(but_pult==butE)
	RJMP _0x823
_0x820:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x824
;    7116 			{
;    7117 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7118 			}			 		 
;    7119 		}
_0x824:
_0x823:
_0x81F:
;    7120 	else if(sub_ind==2)
	RJMP _0x825
_0x81B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x826
;    7121 		{
;    7122 		if(but_pult==butE_)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF6)
	BRNE _0x827
;    7123 			{
;    7124 			Kp0=adc_bank_[3];
	__GETW1MN _adc_bank_,6
	LDI  R26,LOW(_Kp0)
	LDI  R27,HIGH(_Kp0)
	CALL __EEPROMWRW
;    7125 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7126 			}
;    7127 		else if(but_pult==butE)
	RJMP _0x828
_0x827:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x829
;    7128 			{
;    7129 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7130 			}						 		 
;    7131 		}		
_0x829:
_0x828:
;    7132 	else if(sub_ind==3)
	RJMP _0x82A
_0x826:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x82B
;    7133 		{
;    7134 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x82D
	CPI  R26,LOW(0x7E)
	BRNE _0x82C
_0x82D:
;    7135 			{
;    7136 			Kp1++;
	LDI  R26,LOW(_Kp1)
	LDI  R27,HIGH(_Kp1)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7137 			granee(&Kp1,100,10000);
	CALL SUBOPT_0x155
;    7138 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    7139 			}
;    7140 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x82F
_0x82C:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x831
	CPI  R26,LOW(0xBE)
	BRNE _0x830
_0x831:
;    7141 			{
;    7142 			Kp1--;
	LDI  R26,LOW(_Kp1)
	LDI  R27,HIGH(_Kp1)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7143 			granee(&Kp1,100,10000);
	CALL SUBOPT_0x155
;    7144 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    7145 			}
;    7146 		else if(but_pult==butE)
	RJMP _0x833
_0x830:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x834
;    7147 			{
;    7148 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7149 			}			 		 
;    7150 		}
_0x834:
_0x833:
_0x82F:
;    7151 	else if(sub_ind==4)
	RJMP _0x835
_0x82B:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x836
;    7152 		{ 
;    7153 		speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7154 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x838
	CPI  R26,LOW(0x7E)
	BRNE _0x837
_0x838:
;    7155 			{
;    7156 			P_MAX++;
	LDI  R26,LOW(_P_MAX)
	LDI  R27,HIGH(_P_MAX)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7157 			granee(&P_MAX,1,100);
	CALL SUBOPT_0x156
;    7158 			}           
;    7159 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x83A
_0x837:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x83C
	CPI  R26,LOW(0xBE)
	BRNE _0x83B
_0x83C:
;    7160 			{
;    7161 			P_MAX--;
	LDI  R26,LOW(_P_MAX)
	LDI  R27,HIGH(_P_MAX)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7162 			granee(&P_MAX,1,100);
	CALL SUBOPT_0x156
;    7163 			}       
;    7164 		else if(but_pult==butE)
	RJMP _0x83E
_0x83B:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x83F
;    7165 			{
;    7166 			sub_ind=5;
	LDI  R30,LOW(5)
	STS  _sub_ind,R30
;    7167 			}			 		 
;    7168 		}		
_0x83F:
_0x83E:
_0x83A:
;    7169 	else if(sub_ind==5)
	RJMP _0x840
_0x836:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x841
;    7170 		{ 
;    7171 		speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7172 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x843
	CPI  R26,LOW(0x7E)
	BRNE _0x842
_0x843:
;    7173 			{
;    7174 			T_MAXMIN++;
	LDI  R26,LOW(_T_MAXMIN)
	LDI  R27,HIGH(_T_MAXMIN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7175 			granee(&T_MAXMIN,1,100);
	CALL SUBOPT_0x157
;    7176 			}           
;    7177 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x845
_0x842:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x847
	CPI  R26,LOW(0xBE)
	BRNE _0x846
_0x847:
;    7178 			{
;    7179 			T_MAXMIN--;
	LDI  R26,LOW(_T_MAXMIN)
	LDI  R27,HIGH(_T_MAXMIN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7180 			granee(&T_MAXMIN,1,100);
	CALL SUBOPT_0x157
;    7181 			}       
;    7182 		else if(but_pult==butE)
	RJMP _0x849
_0x846:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x84A
;    7183 			{
;    7184 			sub_ind=6;
	LDI  R30,LOW(6)
	STS  _sub_ind,R30
;    7185 			}			 		 
;    7186 		}		
_0x84A:
_0x849:
_0x845:
;    7187 	else if(sub_ind==6)
	RJMP _0x84B
_0x841:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x84C
;    7188 		{ 
;    7189 		speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7190 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x84E
	CPI  R26,LOW(0x7E)
	BRNE _0x84D
_0x84E:
;    7191 			{
;    7192 			G_MAXMIN++;
	LDI  R26,LOW(_G_MAXMIN)
	LDI  R27,HIGH(_G_MAXMIN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7193 			granee(&G_MAXMIN,1,100);
	CALL SUBOPT_0x158
;    7194 			}           
;    7195 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x850
_0x84D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x852
	CPI  R26,LOW(0xBE)
	BRNE _0x851
_0x852:
;    7196 			{
;    7197 			G_MAXMIN--;
	LDI  R26,LOW(_G_MAXMIN)
	LDI  R27,HIGH(_G_MAXMIN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7198 			granee(&G_MAXMIN,1,100);
	CALL SUBOPT_0x158
;    7199 			}       
;    7200 		else if(but_pult==butE)
	RJMP _0x854
_0x851:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x855
;    7201 			{
;    7202 			sub_ind=7;
	LDI  R30,LOW(7)
	STS  _sub_ind,R30
;    7203 			}			 		 
;    7204 		}	 
_0x855:
_0x854:
_0x850:
;    7205 	
;    7206 	else if(sub_ind==7)
	RJMP _0x856
_0x84C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x857
;    7207 		{ 
;    7208 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x858
;    7209     			{
;    7210     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7211     			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7212     			}
;    7213     		}																	
_0x858:
;    7214 	}
_0x857:
_0x856:
_0x84B:
_0x840:
_0x835:
_0x82A:
_0x825:
_0x81A:
;    7215 
;    7216 else if(ind==iDv_num_set)
	JMP  _0x859
_0x80B:
	LDI  R30,LOW(188)
	CP   R30,R13
	BRNE _0x85A
;    7217 	{
;    7218 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7219 	if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x85C
	CPI  R26,LOW(0x7E)
	BRNE _0x85B
_0x85C:
;    7220 		{
;    7221 		EE_DV_NUM++;
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	SUBI R30,-LOW(1)
	CALL __EEPROMWRB
	SUBI R30,LOW(1)
;    7222 		granee(&EE_DV_NUM,1,6);
	CALL SUBOPT_0x159
;    7223 		}           
;    7224 	else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x85E
_0x85B:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x860
	CPI  R26,LOW(0xBE)
	BRNE _0x85F
_0x860:
;    7225 		{
;    7226 		EE_DV_NUM--;
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	SUBI R30,LOW(1)
	CALL __EEPROMWRB
	SUBI R30,-LOW(1)
;    7227 		granee(&EE_DV_NUM,1,6);
	CALL SUBOPT_0x159
;    7228 		}
;    7229 	else if(but_pult==butE)
	RJMP _0x862
_0x85F:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x863
;    7230     		{
;    7231     		ind=iDv_av_log; 
	LDI  R30,LOW(187)
	CALL SUBOPT_0x141
;    7232     		sub_ind=0;
;    7233     		index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    7234     		}			           
;    7235 	}
_0x863:
_0x862:
_0x85E:
;    7236 /*else if(ind==iDv_start_set)
;    7237 	{
;    7238 	if((but_pult==butR)||(but_pult==butL))
;    7239     		{
;    7240     		if(STAR_TRIAN==stON)STAR_TRIAN=stOFF;
;    7241     		else STAR_TRIAN=stON;
;    7242     		}           
;    7243     	else if(but_pult==butE)
;    7244     		{
;    7245     		ind=iDv_av_set; 
;    7246     		sub_ind=0;
;    7247     		index_set=0;
;    7248     		} 	
;    7249 	}  */
;    7250 	
;    7251 else if(ind==iDv_av_log)
	JMP  _0x864
_0x85A:
	LDI  R30,LOW(187)
	CP   R30,R13
	BRNE _0x865
;    7252 	{
;    7253 	if((but_pult==butR)||(but_pult==butL))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x867
	CPI  R26,LOW(0xBF)
	BRNE _0x866
_0x867:
;    7254     		{
;    7255     		if(DV_AV_SET==dasLOG)DV_AV_SET=dasDAT;
	LDI  R26,LOW(_DV_AV_SET)
	LDI  R27,HIGH(_DV_AV_SET)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x869
	LDI  R30,LOW(170)
	RJMP _0xB88
;    7256     		else DV_AV_SET=dasLOG;
_0x869:
	LDI  R30,LOW(85)
_0xB88:
	LDI  R26,LOW(_DV_AV_SET)
	LDI  R27,HIGH(_DV_AV_SET)
	CALL __EEPROMWRB
;    7257     		}           
;    7258     	else if(but_pult==butE)
	RJMP _0x86B
_0x866:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x86C
;    7259     		{
;    7260     		if(DV_AV_SET==dasLOG)
	LDI  R26,LOW(_DV_AV_SET)
	LDI  R27,HIGH(_DV_AV_SET)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	BRNE _0x86D
;    7261     			{
;    7262     			ind=iDv_resurs_set;
	LDI  R30,LOW(193)
	RJMP _0xB89
;    7263     			sub_ind=0;
;    7264     			index_set=0;
;    7265     			}
;    7266     		else
_0x86D:
;    7267     			{
;    7268     			ind=iDv_imin_set; 
	LDI  R30,LOW(190)
_0xB89:
	MOV  R13,R30
;    7269     			sub_ind=0;
	CALL SUBOPT_0x15A
;    7270     			index_set=0;
	STS  _index_set,R30
;    7271     			}
;    7272 
;    7273     		} 	
;    7274 	}
_0x86C:
_0x86B:
;    7275 		
;    7276 else if(ind==iDv_imin_set)
	JMP  _0x86F
_0x865:
	LDI  R30,LOW(190)
	CP   R30,R13
	BRNE _0x870
;    7277 	{ 
;    7278 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7279 	if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x872
	CPI  R26,LOW(0x7E)
	BRNE _0x871
_0x872:
;    7280 		{
;    7281 		Idmin++;
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7282 		granee(&Idmin,1,100);
	CALL SUBOPT_0x15B
;    7283 		}           
;    7284 	else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x874
_0x871:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x876
	CPI  R26,LOW(0xBE)
	BRNE _0x875
_0x876:
;    7285 		{
;    7286 		Idmin--;
	LDI  R26,LOW(_Idmin)
	LDI  R27,HIGH(_Idmin)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7287 		granee(&Idmin,1,100);
	CALL SUBOPT_0x15B
;    7288 	    	}
;    7289  	else if(but_pult==butE)
	RJMP _0x878
_0x875:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x879
;    7290 		{
;    7291     		ind=iDv_imax_set; 
	LDI  R30,LOW(191)
	CALL SUBOPT_0x141
;    7292     		sub_ind=0;
;    7293     		index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    7294 		}			  
;    7295 	}		 
_0x879:
_0x878:
_0x874:
;    7296 else if(ind==iDv_imax_set)
	JMP  _0x87A
_0x870:
	LDI  R30,LOW(191)
	CP   R30,R13
	BRNE _0x87B
;    7297 	{ 
;    7298 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7299 	if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x87D
	CPI  R26,LOW(0x7E)
	BRNE _0x87C
_0x87D:
;    7300 		{
;    7301 		Idmax++;
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7302 		granee(&Idmax,1,300);
	CALL SUBOPT_0x15C
;    7303 	    	}           
;    7304 	else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x87F
_0x87C:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x881
	CPI  R26,LOW(0xBE)
	BRNE _0x880
_0x881:
;    7305 		{
;    7306     		Idmax--;
	LDI  R26,LOW(_Idmax)
	LDI  R27,HIGH(_Idmax)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7307 		granee(&Idmax,1,300);
	CALL SUBOPT_0x15C
;    7308 		}
;    7309  	else if(but_pult==butE)
	RJMP _0x883
_0x880:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x884
;    7310 		{
;    7311     		ind=iDv_resurs_set; 
	LDI  R30,LOW(193)
	CALL SUBOPT_0x141
;    7312     		sub_ind=0;
;    7313     		index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    7314 		}			  
;    7315 	} 
_0x884:
_0x883:
_0x87F:
;    7316 else if(ind==iDv_mode_set)
	JMP  _0x885
_0x87B:
	LDI  R30,LOW(192)
	CP   R30,R13
	BRNE _0x886
;    7317 	{
;    7318 	if((but_pult==butR)||(but_pult==butL))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x888
	CPI  R26,LOW(0xBF)
	BRNE _0x887
_0x888:
;    7319 		{
;    7320 		if(DV_MODE[sub_ind]==dm_MNL)DV_MODE[sub_ind]=dm_AVT;
	CALL SUBOPT_0x122
	CPI  R30,LOW(0xAA)
	BRNE _0x88A
	CALL SUBOPT_0x15D
	LDI  R30,LOW(85)
	RJMP _0xB8A
;    7321 		else DV_MODE[sub_ind]=dm_MNL;
_0x88A:
	CALL SUBOPT_0x15D
	LDI  R30,LOW(170)
_0xB8A:
	CALL __EEPROMWRB
;    7322 	   	} 
;    7323 	 else if(but_pult==butE)
	RJMP _0x88C
_0x887:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x88D
;    7324 		{
;    7325 		sub_ind++;
	CALL SUBOPT_0x15E
;    7326 		if(sub_ind>=EE_DV_NUM)
	CALL SUBOPT_0x15F
	BRLO _0x88E
;    7327 			{
;    7328 			ind=iDv_resurs_set;
	LDI  R30,LOW(193)
	CALL SUBOPT_0x141
;    7329 			sub_ind=0;
;    7330 			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    7331 			}
;    7332 		}	     
_0x88E:
;    7333 	}
_0x88D:
_0x88C:
;    7334 else if(ind==iDv_resurs_set)
	JMP  _0x88F
_0x886:
	LDI  R30,LOW(193)
	CP   R30,R13
	BRNE _0x890
;    7335 	{
;    7336 	if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x891
;    7337 		{
;    7338 		if(index_set)
	LDS  R30,_index_set
	CPI  R30,0
	BREQ _0x892
;    7339 			{
;    7340 			RESURS_CNT[sub_ind]=0; 
	LDS  R30,_sub_ind
	LDI  R26,LOW(_RESURS_CNT)
	LDI  R27,HIGH(_RESURS_CNT)
	CALL SUBOPT_0x160
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	CALL __EEPROMWRW
;    7341 			resurs_cnt_[sub_ind]=0; 
	LDS  R30,_sub_ind
	CALL SUBOPT_0x9A
;    7342 			}
;    7343 		sub_ind++;
_0x892:
	CALL SUBOPT_0x15E
;    7344 		index_set=0;
	CALL SUBOPT_0x161
;    7345 		if(sub_ind>=EE_DV_NUM)
	BRLO _0x893
;    7346 			{
;    7347 			ind=iDv_i_kalibr;
	LDI  R30,LOW(194)
	CALL SUBOPT_0x141
;    7348 			sub_ind=0;
;    7349 			index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    7350 			}
;    7351 		}
_0x893:
;    7352 	else if((but_pult==butL)||(but_pult==butR))
	RJMP _0x894
_0x891:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x896
	CPI  R26,LOW(0x7F)
	BRNE _0x895
_0x896:
;    7353 		{
;    7354 		if(index_set==0)index_set=1;
	LDS  R30,_index_set
	CPI  R30,0
	BRNE _0x898
	LDI  R30,LOW(1)
	RJMP _0xB8B
;    7355 		else index_set=0;
_0x898:
	LDI  R30,LOW(0)
_0xB8B:
	STS  _index_set,R30
;    7356 		}		  
;    7357 	}
_0x895:
_0x894:
;    7358 else if(ind==iDv_i_kalibr)
	JMP  _0x89A
_0x890:
	LDI  R30,LOW(194)
	CP   R30,R13
	BREQ PC+3
	JMP _0x89B
;    7359 	{
;    7360 	if(!index_set)
	LDS  R30,_index_set
	CPI  R30,0
	BRNE _0x89C
;    7361 		{
;    7362 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x89E
	CPI  R26,LOW(0x7E)
	BRNE _0x89D
_0x89E:
;    7363 			{
;    7364 			Kida[sub_ind]+=2;
	CALL SUBOPT_0x162
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __EEPROMRDW
	ADIW R30,2
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    7365 			granee(&Kida[sub_ind],150,500);
	CALL SUBOPT_0x162
	CALL SUBOPT_0x163
;    7366 			speed=1; 
	__PUTB1MN _lcd_buffer,34
;    7367 			}
;    7368 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8A0
_0x89D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8A2
	CPI  R26,LOW(0xBE)
	BRNE _0x8A1
_0x8A2:
;    7369 			{
;    7370 			Kida[sub_ind]--;
	LDS  R30,_sub_ind
	LDI  R26,LOW(_Kida)
	LDI  R27,HIGH(_Kida)
	CALL SUBOPT_0x160
	CALL __EEPROMRDW
	CALL SUBOPT_0x151
;    7371 			granee(&Kida[sub_ind],150,500);
	CALL SUBOPT_0x162
	CALL SUBOPT_0x163
;    7372 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    7373 			}
;    7374 		else if(but_pult==butE)
	RJMP _0x8A4
_0x8A1:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8A5
;    7375 			{
;    7376 			index_set=1;
	LDI  R30,LOW(1)
	STS  _index_set,R30
;    7377 			}		
;    7378 		}
_0x8A5:
_0x8A4:
_0x8A0:
;    7379 	else if(index_set)
	RJMP _0x8A6
_0x89C:
	LDS  R30,_index_set
	CPI  R30,0
	BRNE PC+3
	JMP _0x8A7
;    7380 		{
;    7381 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8A9
	CPI  R26,LOW(0x7E)
	BRNE _0x8A8
_0x8A9:
;    7382 			{
;    7383 			Kidc[sub_ind]+=2;
	CALL SUBOPT_0x164
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __EEPROMRDW
	ADIW R30,2
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    7384 			granee(&Kidc[sub_ind],150,500);
	CALL SUBOPT_0x164
	CALL SUBOPT_0x163
;    7385 			speed=1;
	__PUTB1MN _lcd_buffer,34
;    7386 			}
;    7387 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8AB
_0x8A8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8AD
	CPI  R26,LOW(0xBE)
	BRNE _0x8AC
_0x8AD:
;    7388 		   	{
;    7389 		    	Kidc[sub_ind]--;
	LDS  R30,_sub_ind
	LDI  R26,LOW(_Kidc)
	LDI  R27,HIGH(_Kidc)
	CALL SUBOPT_0x160
	CALL __EEPROMRDW
	CALL SUBOPT_0x151
;    7390 		    	granee(&Kidc[sub_ind],150,500);
	CALL SUBOPT_0x164
	CALL SUBOPT_0x163
;    7391 		    	speed=1;
	__PUTB1MN _lcd_buffer,34
;    7392 			}	
;    7393 		else if(but_pult==butE)
	RJMP _0x8AF
_0x8AC:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8B0
;    7394 			{
;    7395 			sub_ind++;
	CALL SUBOPT_0x15E
;    7396 			index_set=0;
	CALL SUBOPT_0x161
;    7397 			if(sub_ind>=EE_DV_NUM)
	BRLO _0x8B1
;    7398 				{
;    7399 				ind=iDv_c_set;
	LDI  R30,LOW(195)
	CALL SUBOPT_0x141
;    7400 				sub_ind=0;
;    7401 				index_set=0;
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    7402 				}
;    7403 			} 	 
_0x8B1:
;    7404 		}		 
_0x8B0:
_0x8AF:
_0x8AB:
;    7405 	}
_0x8A7:
_0x8A6:
;    7406 else if(ind==iDv_c_set)
	JMP  _0x8B2
_0x89B:
	LDI  R30,LOW(195)
	CP   R30,R13
	BRNE _0x8B3
;    7407 	{
;    7408 	if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8B5
	CPI  R26,LOW(0x7E)
	BRNE _0x8B4
_0x8B5:
;    7409 		{
;    7410 		C1N++;
	LDI  R26,LOW(_C1N)
	LDI  R27,HIGH(_C1N)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7411 		granee(&C1N,0,EE_DV_NUM);
	LDI  R30,LOW(_C1N)
	LDI  R31,HIGH(_C1N)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    7412 		} 
;    7413 	else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8B7
_0x8B4:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8B9
	CPI  R26,LOW(0xBE)
	BRNE _0x8B8
_0x8B9:
;    7414 		{
;    7415 		C1N--;
	LDI  R26,LOW(_C1N)
	LDI  R27,HIGH(_C1N)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7416 		granee(&C1N,0,EE_DV_NUM);
	LDI  R30,LOW(_C1N)
	LDI  R31,HIGH(_C1N)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    7417 		}			
;    7418 	else if(but_pult==butE)
	RJMP _0x8BB
_0x8B8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8BC
;    7419 		{
;    7420 		ind=iDv_ch_set;
	LDI  R30,LOW(196)
	MOV  R13,R30
;    7421 		} 	 
;    7422 	}					
_0x8BC:
_0x8BB:
_0x8B7:
;    7423 else if(ind==iDv_ch_set)
	JMP  _0x8BD
_0x8B3:
	LDI  R30,LOW(196)
	CP   R30,R13
	BRNE _0x8BE
;    7424 	{
;    7425 	if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8C0
	CPI  R26,LOW(0x7E)
	BRNE _0x8BF
_0x8C0:
;    7426 		{
;    7427 		CH1N++;
	LDI  R26,LOW(_CH1N)
	LDI  R27,HIGH(_CH1N)
	CALL __EEPROMRDB
	SUBI R30,-LOW(1)
	CALL __EEPROMWRB
	SUBI R30,LOW(1)
;    7428 		granee(&CH1N,0,EE_DV_NUM);
	LDI  R30,LOW(_CH1N)
	LDI  R31,HIGH(_CH1N)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    7429 		} 
;    7430 	else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8C2
_0x8BF:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8C4
	CPI  R26,LOW(0xBE)
	BRNE _0x8C3
_0x8C4:
;    7431 		{
;    7432 		CH1N--;
	LDI  R26,LOW(_CH1N)
	LDI  R27,HIGH(_CH1N)
	CALL __EEPROMRDB
	SUBI R30,LOW(1)
	CALL __EEPROMWRB
	SUBI R30,-LOW(1)
;    7433 		granee(&CH1N,0,EE_DV_NUM);
	LDI  R30,LOW(_CH1N)
	LDI  R31,HIGH(_CH1N)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    7434 		}			
;    7435 	else if(but_pult==butE)
	RJMP _0x8C6
_0x8C3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8C7
;    7436 		{
;    7437 		ind=iDv_out;
	LDI  R30,LOW(197)
	MOV  R13,R30
;    7438 		} 	 
;    7439 	}															 
_0x8C7:
_0x8C6:
_0x8C2:
;    7440 else if(ind==iDv_out)
	JMP  _0x8C8
_0x8BE:
	LDI  R30,LOW(197)
	CP   R30,R13
	BRNE _0x8C9
;    7441 	{
;    7442 	if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8CA
;    7443     		{
;    7444     		ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7445     		sub_ind=5;
	LDI  R30,LOW(5)
	STS  _sub_ind,R30
;    7446     		}		
;    7447 	}								
_0x8CA:
;    7448 
;    7449 
;    7450 else if(ind==iStep_start)
	JMP  _0x8CB
_0x8C9:
	LDI  R30,LOW(170)
	CP   R30,R13
	BREQ PC+3
	JMP _0x8CC
;    7451 	{
;    7452 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7453 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x8CD
;    7454 		{
;    7455 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8CF
	CPI  R26,LOW(0x7E)
	BRNE _0x8CE
_0x8CF:
;    7456 			{
;    7457 			SS_LEVEL++;
	LDI  R26,LOW(_SS_LEVEL)
	LDI  R27,HIGH(_SS_LEVEL)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7458 			granee(&SS_LEVEL,1,100);
	CALL SUBOPT_0x165
;    7459 			}           
;    7460 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8D1
_0x8CE:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8D3
	CPI  R26,LOW(0xBE)
	BRNE _0x8D2
_0x8D3:
;    7461 			{
;    7462 			SS_LEVEL--;
	LDI  R26,LOW(_SS_LEVEL)
	LDI  R27,HIGH(_SS_LEVEL)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7463 			granee(&SS_LEVEL,1,100);
	CALL SUBOPT_0x165
;    7464 			}   
;    7465 		else if(but_pult==butE)
	RJMP _0x8D5
_0x8D2:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8D6
;    7466 			{
;    7467 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7468 			}			 		 
;    7469 		} 
_0x8D6:
_0x8D5:
_0x8D1:
;    7470 		
;    7471 	else if(sub_ind==1)
	RJMP _0x8D7
_0x8CD:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x8D8
;    7472 		{
;    7473 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8DA
	CPI  R26,LOW(0x7E)
	BRNE _0x8D9
_0x8DA:
;    7474 			{
;    7475 			SS_STEP++;
	LDI  R26,LOW(_SS_STEP)
	LDI  R27,HIGH(_SS_STEP)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7476 			granee(&SS_STEP,1,50);
	CALL SUBOPT_0x166
;    7477 			}           
;    7478 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8DC
_0x8D9:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8DE
	CPI  R26,LOW(0xBE)
	BRNE _0x8DD
_0x8DE:
;    7479 			{
;    7480 			SS_STEP--;
	LDI  R26,LOW(_SS_STEP)
	LDI  R27,HIGH(_SS_STEP)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7481 			granee(&SS_STEP,1,50);
	CALL SUBOPT_0x166
;    7482 			}          
;    7483 		else if(but_pult==butE)
	RJMP _0x8E0
_0x8DD:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8E1
;    7484 			{
;    7485 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7486 			}			 		 
;    7487 		}  
_0x8E1:
_0x8E0:
_0x8DC:
;    7488 		
;    7489 	else if(sub_ind==2)
	RJMP _0x8E2
_0x8D8:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x8E3
;    7490 		{
;    7491 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8E5
	CPI  R26,LOW(0x7E)
	BRNE _0x8E4
_0x8E5:
;    7492 			{
;    7493 			SS_TIME++;
	LDI  R26,LOW(_SS_TIME)
	LDI  R27,HIGH(_SS_TIME)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7494 			granee(&SS_TIME,1,60);
	CALL SUBOPT_0x167
;    7495 			}           
;    7496 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8E7
_0x8E4:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8E9
	CPI  R26,LOW(0xBE)
	BRNE _0x8E8
_0x8E9:
;    7497 			{
;    7498 			SS_TIME--;
	LDI  R26,LOW(_SS_TIME)
	LDI  R27,HIGH(_SS_TIME)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7499 			granee(&SS_TIME,1,60);
	CALL SUBOPT_0x167
;    7500 			}
;    7501 		else if(but_pult==butE)
	RJMP _0x8EB
_0x8E8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8EC
;    7502 			{
;    7503 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7504 			}			 		 
;    7505 		}
_0x8EC:
_0x8EB:
_0x8E7:
;    7506 	else if(sub_ind==3)
	RJMP _0x8ED
_0x8E3:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x8EE
;    7507 		{
;    7508 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8F0
	CPI  R26,LOW(0x7E)
	BRNE _0x8EF
_0x8F0:
;    7509 			{
;    7510 			SS_FRIQ++;
	LDI  R26,LOW(_SS_FRIQ)
	LDI  R27,HIGH(_SS_FRIQ)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7511 			granee(&SS_FRIQ,1,70);
	CALL SUBOPT_0x168
;    7512 			}           
;    7513 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x8F2
_0x8EF:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x8F4
	CPI  R26,LOW(0xBE)
	BRNE _0x8F3
_0x8F4:
;    7514 			{
;    7515 			SS_FRIQ--;
	LDI  R26,LOW(_SS_FRIQ)
	LDI  R27,HIGH(_SS_FRIQ)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7516 			granee(&SS_FRIQ,1,70);
	CALL SUBOPT_0x168
;    7517 			}
;    7518 		else if(but_pult==butE)
	RJMP _0x8F6
_0x8F3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8F7
;    7519 			{
;    7520 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7521 			}				 		 
;    7522 		} 
_0x8F7:
_0x8F6:
_0x8F2:
;    7523 		
;    7524 	else if(sub_ind==4)
	RJMP _0x8F8
_0x8EE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x8F9
;    7525 		{
;    7526 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x8FA
;    7527     			{
;    7528     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7529     			sub_ind=6;
	LDI  R30,LOW(6)
	STS  _sub_ind,R30
;    7530     			}		
;    7531 		}		
_0x8FA:
;    7532 	}  	      	
_0x8F9:
_0x8F8:
_0x8ED:
_0x8E2:
_0x8D7:
;    7533 
;    7534 else if(ind==iDv_change)
	JMP  _0x8FB
_0x8CC:
	LDI  R30,LOW(176)
	CP   R30,R13
	BREQ PC+3
	JMP _0x8FC
;    7535 	{
;    7536 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7537 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x8FD
;    7538 		{
;    7539 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x8FF
	CPI  R26,LOW(0x7E)
	BRNE _0x8FE
_0x8FF:
;    7540 			{
;    7541 			DVCH_T_UP++;
	LDI  R26,LOW(_DVCH_T_UP)
	LDI  R27,HIGH(_DVCH_T_UP)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7542 			granee(&DVCH_T_UP,1,600);
	CALL SUBOPT_0x169
;    7543 			}           
;    7544 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x901
_0x8FE:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x903
	CPI  R26,LOW(0xBE)
	BRNE _0x902
_0x903:
;    7545 			{
;    7546 			DVCH_T_UP--;
	LDI  R26,LOW(_DVCH_T_UP)
	LDI  R27,HIGH(_DVCH_T_UP)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7547 			granee(&DVCH_T_UP,1,600);
	CALL SUBOPT_0x169
;    7548 			}   
;    7549 		else if(but_pult==butE)
	RJMP _0x905
_0x902:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x906
;    7550 			{
;    7551 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7552 			}			 		 
;    7553 		} 
_0x906:
_0x905:
_0x901:
;    7554 		
;    7555 	else if(sub_ind==1)
	RJMP _0x907
_0x8FD:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x908
;    7556 		{
;    7557 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x90A
	CPI  R26,LOW(0x7E)
	BRNE _0x909
_0x90A:
;    7558 			{
;    7559 			DVCH_T_DOWN++;
	LDI  R26,LOW(_DVCH_T_DOWN)
	LDI  R27,HIGH(_DVCH_T_DOWN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7560 			granee(&DVCH_T_DOWN,1,60);
	CALL SUBOPT_0x16A
;    7561 			}           
;    7562 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x90C
_0x909:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x90E
	CPI  R26,LOW(0xBE)
	BRNE _0x90D
_0x90E:
;    7563 			{
;    7564 			DVCH_T_DOWN--;
	LDI  R26,LOW(_DVCH_T_DOWN)
	LDI  R27,HIGH(_DVCH_T_DOWN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7565 			granee(&DVCH_T_DOWN,1,60);
	CALL SUBOPT_0x16A
;    7566 			}          
;    7567 		else if(but_pult==butE)
	RJMP _0x910
_0x90D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x911
;    7568 			{
;    7569 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7570 			}			 		 
;    7571 		}  
_0x911:
_0x910:
_0x90C:
;    7572 		
;    7573 	else if(sub_ind==2)
	RJMP _0x912
_0x908:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x913
;    7574 		{
;    7575 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x915
	CPI  R26,LOW(0x7E)
	BRNE _0x914
_0x915:
;    7576 			{
;    7577 			DVCH_P_KR++;
	LDI  R26,LOW(_DVCH_P_KR)
	LDI  R27,HIGH(_DVCH_P_KR)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7578 			granee(&DVCH_P_KR,1,50);
	CALL SUBOPT_0x16B
;    7579 			}           
;    7580 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x917
_0x914:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x919
	CPI  R26,LOW(0xBE)
	BRNE _0x918
_0x919:
;    7581 			{
;    7582 			DVCH_P_KR--;
	LDI  R26,LOW(_DVCH_P_KR)
	LDI  R27,HIGH(_DVCH_P_KR)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7583 			granee(&DVCH_P_KR,1,50);
	CALL SUBOPT_0x16B
;    7584 			}
;    7585 		else if(but_pult==butE)
	RJMP _0x91B
_0x918:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x91C
;    7586 			{
;    7587 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7588 			}			 		 
;    7589 		}
_0x91C:
_0x91B:
_0x917:
;    7590 	else if(sub_ind==3)
	RJMP _0x91D
_0x913:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x91E
;    7591 		{
;    7592 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x920
	CPI  R26,LOW(0x7E)
	BRNE _0x91F
_0x920:
;    7593 			{
;    7594 			DVCH_KP++;
	LDI  R26,LOW(_DVCH_KP)
	LDI  R27,HIGH(_DVCH_KP)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7595 			granee(&DVCH_KP,1,100);
	CALL SUBOPT_0x16C
;    7596 			}           
;    7597 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x922
_0x91F:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x924
	CPI  R26,LOW(0xBE)
	BRNE _0x923
_0x924:
;    7598 			{
;    7599 			DVCH_KP--;
	LDI  R26,LOW(_DVCH_KP)
	LDI  R27,HIGH(_DVCH_KP)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7600 			granee(&DVCH_KP,1,100);
	CALL SUBOPT_0x16C
;    7601 			}
;    7602 		else if(but_pult==butE)
	RJMP _0x926
_0x923:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x927
;    7603 			{
;    7604 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7605 			}				 		 
;    7606 		} 
_0x927:
_0x926:
_0x922:
;    7607 		
;    7608 	else if(sub_ind==4)
	RJMP _0x928
_0x91E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x929
;    7609 		{
;    7610 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x92A
;    7611     			{
;    7612     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7613     			sub_ind=7;
	LDI  R30,LOW(7)
	STS  _sub_ind,R30
;    7614     			}		
;    7615 		}		
_0x92A:
;    7616 	}  
_0x929:
_0x928:
_0x91D:
_0x912:
_0x907:
;    7617 	
;    7618 else if(ind==iDv_change1)
	JMP  _0x92B
_0x8FC:
	LDI  R30,LOW(177)
	CP   R30,R13
	BREQ PC+3
	JMP _0x92C
;    7619 	{
;    7620 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7621 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x92D
;    7622 		{
;    7623 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x92F
	CPI  R26,LOW(0x7E)
	BRNE _0x92E
_0x92F:
;    7624 			{
;    7625 			DVCH_TIME=((DVCH_TIME/15)+1)*15;
	CALL SUBOPT_0x16D
	CALL SUBOPT_0x16E
	CALL SUBOPT_0x16F
;    7626 			granee(&DVCH_TIME,15,1440);
;    7627 			}           
;    7628 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x931
_0x92E:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x933
	CPI  R26,LOW(0xBE)
	BRNE _0x932
_0x933:
;    7629 			{
;    7630 			DVCH_TIME=((DVCH_TIME/15)-1)*15;
	CALL SUBOPT_0x16D
	CALL SUBOPT_0x170
	CALL SUBOPT_0x16F
;    7631 			granee(&DVCH_TIME,15,1440);
;    7632 			}   
;    7633 		else if(but_pult==butE)
	RJMP _0x935
_0x932:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x936
;    7634 			{
;    7635 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7636 			}			 		 
;    7637 		} 
_0x936:
_0x935:
_0x931:
;    7638 		
;    7639 	else if(sub_ind==1)
	RJMP _0x937
_0x92D:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x938
;    7640 		{
;    7641 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x93A
	CPI  R26,LOW(0x7E)
	BRNE _0x939
_0x93A:
;    7642 			{
;    7643 			DVCH=dvch_ON;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_DVCH)
	LDI  R27,HIGH(_DVCH)
	CALL __EEPROMWRB
;    7644 			}           
;    7645 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x93C
_0x939:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x93E
	CPI  R26,LOW(0xBE)
	BRNE _0x93D
_0x93E:
;    7646 			{
;    7647 			DVCH=dvch_OFF;
	LDI  R30,LOW(170)
	LDI  R26,LOW(_DVCH)
	LDI  R27,HIGH(_DVCH)
	CALL __EEPROMWRB
;    7648 			}          
;    7649 		else if(but_pult==butE)
	RJMP _0x940
_0x93D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x941
;    7650 			{
;    7651 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7652 			}			 		 
;    7653 		}  
_0x941:
_0x940:
_0x93C:
;    7654 		
;    7655 	else if(sub_ind==2)
	RJMP _0x942
_0x938:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x943
;    7656 		{
;    7657 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x944
;    7658     			{
;    7659     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7660     			sub_ind=8;
	LDI  R30,LOW(8)
	STS  _sub_ind,R30
;    7661     			}		
;    7662 		}			
_0x944:
;    7663 	}
_0x943:
_0x942:
_0x937:
;    7664 
;    7665 else if(ind==iFp_set)
	JMP  _0x945
_0x92C:
	LDI  R30,LOW(181)
	CP   R30,R13
	BREQ PC+3
	JMP _0x946
;    7666 	{
;    7667 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7668 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x947
;    7669 		{
;    7670 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x949
	CPI  R26,LOW(0x7E)
	BRNE _0x948
_0x949:
;    7671 			{
;    7672 			FP_FMIN++;
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7673 			granee(&FP_FMIN,10,70);
	CALL SUBOPT_0x171
;    7674 			write_vlt_registers(204,(unsigned long)FP_FMIN*1000UL);
;    7675 			}           
;    7676 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x94B
_0x948:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x94D
	CPI  R26,LOW(0xBE)
	BRNE _0x94C
_0x94D:
;    7677 			{
;    7678 			FP_FMIN--;
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7679 			granee(&FP_FMIN,10,70);
	CALL SUBOPT_0x171
;    7680 			write_vlt_registers(204,(unsigned long)FP_FMIN*1000UL);
;    7681 			}   
;    7682 		else if(but_pult==butE)
	RJMP _0x94F
_0x94C:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x950
;    7683 			{
;    7684 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7685 			}			 		 
;    7686 		} 
_0x950:
_0x94F:
_0x94B:
;    7687 		
;    7688 	else if(sub_ind==1)
	RJMP _0x951
_0x947:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x952
;    7689 		{
;    7690 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x954
	CPI  R26,LOW(0x7E)
	BRNE _0x953
_0x954:
;    7691 			{
;    7692 			FP_FMAX++;
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7693 			granee(&FP_FMAX,10,70);
	CALL SUBOPT_0x172
;    7694 			write_vlt_registers(205,(unsigned long)FP_FMAX*1000UL);
;    7695 			}           
;    7696 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x956
_0x953:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x958
	CPI  R26,LOW(0xBE)
	BRNE _0x957
_0x958:
;    7697 			{
;    7698 			FP_FMAX--;
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7699 			granee(&FP_FMAX,10,70);
	CALL SUBOPT_0x172
;    7700 			write_vlt_registers(205,(unsigned long)FP_FMAX*1000UL);
;    7701 			}   
;    7702 		else if(but_pult==butE)
	RJMP _0x95A
_0x957:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x95B
;    7703 			{
;    7704 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7705 			}			 		 
;    7706 		}  
_0x95B:
_0x95A:
_0x956:
;    7707 		 
;    7708 	else if(sub_ind==2)
	RJMP _0x95C
_0x952:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x95D
;    7709 		{
;    7710 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x95F
	CPI  R26,LOW(0x7E)
	BRNE _0x95E
_0x95F:
;    7711 			{
;    7712 			FP_TPAD++;
	LDI  R26,LOW(_FP_TPAD)
	LDI  R27,HIGH(_FP_TPAD)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7713 			granee(&FP_TPAD,1,10);
	CALL SUBOPT_0x173
;    7714 			}           
;    7715 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x961
_0x95E:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x963
	CPI  R26,LOW(0xBE)
	BRNE _0x962
_0x963:
;    7716 			{
;    7717 			FP_TPAD--;
	LDI  R26,LOW(_FP_TPAD)
	LDI  R27,HIGH(_FP_TPAD)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7718 			granee(&FP_TPAD,1,10);
	CALL SUBOPT_0x173
;    7719 			}   
;    7720 		else if(but_pult==butE)
	RJMP _0x965
_0x962:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x966
;    7721 			{
;    7722 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7723 			}			 		 
;    7724 		}  
_0x966:
_0x965:
_0x961:
;    7725 	else if(sub_ind==3)
	RJMP _0x967
_0x95D:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x968
;    7726 		{
;    7727 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x96A
	CPI  R26,LOW(0x7E)
	BRNE _0x969
_0x96A:
;    7728 			{
;    7729 			FP_TVOZVR++;
	LDI  R26,LOW(_FP_TVOZVR)
	LDI  R27,HIGH(_FP_TVOZVR)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7730 			granee(&FP_TVOZVR,1,10);
	CALL SUBOPT_0x174
;    7731 			}           
;    7732 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x96C
_0x969:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x96E
	CPI  R26,LOW(0xBE)
	BRNE _0x96D
_0x96E:
;    7733 			{
;    7734 			FP_TVOZVR--;
	LDI  R26,LOW(_FP_TVOZVR)
	LDI  R27,HIGH(_FP_TVOZVR)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7735 			granee(&FP_TVOZVR,1,10);
	CALL SUBOPT_0x174
;    7736 			}   
;    7737 		else if(but_pult==butE)
	RJMP _0x970
_0x96D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x971
;    7738 			{
;    7739 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7740 			}			 		 
;    7741 		} 
_0x971:
_0x970:
_0x96C:
;    7742 	else if(sub_ind==4)
	RJMP _0x972
_0x968:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x973
;    7743 		{
;    7744 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x975
	CPI  R26,LOW(0x7E)
	BRNE _0x974
_0x975:
;    7745 			{
;    7746 			FP_CH++;
	LDI  R26,LOW(_FP_CH)
	LDI  R27,HIGH(_FP_CH)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7747 			granee(&FP_CH,0,100);
	LDI  R30,LOW(_FP_CH)
	LDI  R31,HIGH(_FP_CH)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x175
;    7748 			}           
;    7749 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x977
_0x974:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x979
	CPI  R26,LOW(0xBE)
	BRNE _0x978
_0x979:
;    7750 			{
;    7751 			FP_CH--;
	LDI  R26,LOW(_FP_CH)
	LDI  R27,HIGH(_FP_CH)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7752 			granee(&FP_CH,0,100);
	LDI  R30,LOW(_FP_CH)
	LDI  R31,HIGH(_FP_CH)
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x175
;    7753 			}   
;    7754 		else if(but_pult==butE)
	RJMP _0x97B
_0x978:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x97C
;    7755 			{
;    7756 			sub_ind=5;
	LDI  R30,LOW(5)
	STS  _sub_ind,R30
;    7757 			}			 		 
;    7758 		} 		  
_0x97C:
_0x97B:
_0x977:
;    7759 	else if(sub_ind==5)
	RJMP _0x97D
_0x973:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0x97E
;    7760 		{
;    7761 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x980
	CPI  R26,LOW(0x7E)
	BRNE _0x97F
_0x980:
;    7762 			{
;    7763 			FP_P_PL++;
	LDI  R26,LOW(_FP_P_PL)
	LDI  R27,HIGH(_FP_P_PL)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7764 			granee(&FP_P_PL,1,100);
	CALL SUBOPT_0x176
;    7765 			}           
;    7766 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x982
_0x97F:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x984
	CPI  R26,LOW(0xBE)
	BRNE _0x983
_0x984:
;    7767 			{
;    7768 			FP_P_PL--;
	LDI  R26,LOW(_FP_P_PL)
	LDI  R27,HIGH(_FP_P_PL)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7769 			granee(&FP_P_PL,1,100);
	CALL SUBOPT_0x176
;    7770 			}   
;    7771 		else if(but_pult==butE)
	RJMP _0x986
_0x983:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x987
;    7772 			{
;    7773 			sub_ind=6;
	LDI  R30,LOW(6)
	STS  _sub_ind,R30
;    7774 			}			 		 
;    7775 		} 
_0x987:
_0x986:
_0x982:
;    7776 	else if(sub_ind==6)
	RJMP _0x988
_0x97E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x6)
	BRNE _0x989
;    7777 		{
;    7778 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x98B
	CPI  R26,LOW(0x7E)
	BRNE _0x98A
_0x98B:
;    7779 			{
;    7780 			FP_P_MI++;
	LDI  R26,LOW(_FP_P_MI)
	LDI  R27,HIGH(_FP_P_MI)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7781 			granee(&FP_P_MI,1,100);
	CALL SUBOPT_0x177
;    7782 			}           
;    7783 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x98D
_0x98A:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x98F
	CPI  R26,LOW(0xBE)
	BRNE _0x98E
_0x98F:
;    7784 			{
;    7785 			FP_P_MI--;
	LDI  R26,LOW(_FP_P_MI)
	LDI  R27,HIGH(_FP_P_MI)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7786 			granee(&FP_P_MI,1,100);
	CALL SUBOPT_0x177
;    7787 			}   
;    7788 		else if(but_pult==butE)
	RJMP _0x991
_0x98E:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x992
;    7789 			{
;    7790 			sub_ind=7;
	LDI  R30,LOW(7)
	STS  _sub_ind,R30
;    7791 			}			 		 
;    7792 		} 		
_0x992:
_0x991:
_0x98D:
;    7793 	else if(sub_ind==7)
	RJMP _0x993
_0x989:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x7)
	BRNE _0x994
;    7794 		{
;    7795 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x996
	CPI  R26,LOW(0x7E)
	BRNE _0x995
_0x996:
;    7796 			{
;    7797 			FP_RESET_TIME++;
	LDI  R26,LOW(_FP_RESET_TIME)
	LDI  R27,HIGH(_FP_RESET_TIME)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7798 			granee(&FP_RESET_TIME,10,100);
	CALL SUBOPT_0x178
;    7799 			}           
;    7800 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x998
_0x995:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x99A
	CPI  R26,LOW(0xBE)
	BRNE _0x999
_0x99A:
;    7801 			{
;    7802 			FP_RESET_TIME--;
	LDI  R26,LOW(_FP_RESET_TIME)
	LDI  R27,HIGH(_FP_RESET_TIME)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7803 			granee(&FP_RESET_TIME,10,100);
	CALL SUBOPT_0x178
;    7804 			}   
;    7805 		else if(but_pult==butE)
	RJMP _0x99C
_0x999:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x99D
;    7806 			{
;    7807 			sub_ind=8;
	LDI  R30,LOW(8)
	STS  _sub_ind,R30
;    7808 			}			 		 
;    7809 		} 												
_0x99D:
_0x99C:
_0x998:
;    7810 	else if(sub_ind==8)
	RJMP _0x99E
_0x994:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x8)
	BRNE _0x99F
;    7811 		{
;    7812 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9A0
;    7813     			{
;    7814     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7815     			sub_ind=9;
	LDI  R30,LOW(9)
	STS  _sub_ind,R30
;    7816     			}		
;    7817 		}			
_0x9A0:
;    7818 	}	
_0x99F:
_0x99E:
_0x993:
_0x988:
_0x97D:
_0x972:
_0x967:
_0x95C:
_0x951:
;    7819 
;    7820 else if(ind==iDoor_set)
	RJMP _0x9A1
_0x946:
	LDI  R30,LOW(182)
	CP   R30,R13
	BREQ PC+3
	JMP _0x9A2
;    7821 	{
;    7822 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7823 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x9A3
;    7824 		{
;    7825 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9A5
	CPI  R26,LOW(0x7E)
	BRNE _0x9A4
_0x9A5:
;    7826 			{
;    7827 			DOOR=dON;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_DOOR)
	LDI  R27,HIGH(_DOOR)
	CALL __EEPROMWRB
;    7828 			}           
;    7829 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9A7
_0x9A4:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9A9
	CPI  R26,LOW(0xBE)
	BRNE _0x9A8
_0x9A9:
;    7830 			{
;    7831 			DOOR=dOFF;
	LDI  R30,LOW(170)
	LDI  R26,LOW(_DOOR)
	LDI  R27,HIGH(_DOOR)
	CALL __EEPROMWRB
;    7832 			}   
;    7833 		else if(but_pult==butE)
	RJMP _0x9AB
_0x9A8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9AC
;    7834 			{
;    7835 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7836 			}			 		 
;    7837 		} 
_0x9AC:
_0x9AB:
_0x9A7:
;    7838 		
;    7839 	else if(sub_ind==1)
	RJMP _0x9AD
_0x9A3:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x9AE
;    7840 		{
;    7841 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9B0
	CPI  R26,LOW(0x7E)
	BRNE _0x9AF
_0x9B0:
;    7842 			{
;    7843 			DOOR_IMIN++;
	LDI  R26,LOW(_DOOR_IMIN)
	LDI  R27,HIGH(_DOOR_IMIN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7844 			granee(&DOOR_IMIN,1,100);
	CALL SUBOPT_0x179
;    7845 			}           
;    7846 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9B2
_0x9AF:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9B4
	CPI  R26,LOW(0xBE)
	BRNE _0x9B3
_0x9B4:
;    7847 			{
;    7848 			DOOR_IMIN--;
	LDI  R26,LOW(_DOOR_IMIN)
	LDI  R27,HIGH(_DOOR_IMIN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7849 			granee(&DOOR_IMIN,1,100);
	CALL SUBOPT_0x179
;    7850 			}   
;    7851 		else if(but_pult==butE)
	RJMP _0x9B6
_0x9B3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9B7
;    7852 			{
;    7853 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7854 			}			 		 
;    7855 		}  
_0x9B7:
_0x9B6:
_0x9B2:
;    7856 		 
;    7857 	else if(sub_ind==2)
	RJMP _0x9B8
_0x9AE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x9B9
;    7858 		{
;    7859 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9BB
	CPI  R26,LOW(0x7E)
	BRNE _0x9BA
_0x9BB:
;    7860 			{
;    7861 			DOOR_IMAX++;
	LDI  R26,LOW(_DOOR_IMAX)
	LDI  R27,HIGH(_DOOR_IMAX)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7862 			granee(&DOOR_IMAX,1,100);
	CALL SUBOPT_0x17A
;    7863 			}           
;    7864 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9BD
_0x9BA:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9BF
	CPI  R26,LOW(0xBE)
	BRNE _0x9BE
_0x9BF:
;    7865 			{
;    7866 			DOOR_IMAX--;
	LDI  R26,LOW(_DOOR_IMAX)
	LDI  R27,HIGH(_DOOR_IMAX)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7867 			granee(&DOOR_IMAX,1,100);
	CALL SUBOPT_0x17A
;    7868 			}   
;    7869 		else if(but_pult==butE)
	RJMP _0x9C1
_0x9BE:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9C2
;    7870 			{
;    7871 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7872 			}			 		 
;    7873 		}  
_0x9C2:
_0x9C1:
_0x9BD:
;    7874 	else if(sub_ind==3)
	RJMP _0x9C3
_0x9B9:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x9C4
;    7875 		{
;    7876 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9C6
	CPI  R26,LOW(0x7E)
	BRNE _0x9C5
_0x9C6:
;    7877 			{
;    7878 			DOOR_MODE=dmS;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_DOOR_MODE)
	LDI  R27,HIGH(_DOOR_MODE)
	CALL __EEPROMWRB
;    7879 			}           
;    7880 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9C8
_0x9C5:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9CA
	CPI  R26,LOW(0xBE)
	BRNE _0x9C9
_0x9CA:
;    7881 			{
;    7882 			DOOR_MODE=dmA;
	LDI  R30,LOW(170)
	LDI  R26,LOW(_DOOR_MODE)
	LDI  R27,HIGH(_DOOR_MODE)
	CALL __EEPROMWRB
;    7883 			}   
;    7884 		else if(but_pult==butE)
	RJMP _0x9CC
_0x9C9:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9CD
;    7885 			{
;    7886 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    7887 			}			 		 
;    7888 		} 
_0x9CD:
_0x9CC:
_0x9C8:
;    7889 	else if(sub_ind==4)
	RJMP _0x9CE
_0x9C4:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0x9CF
;    7890 		{
;    7891 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9D0
;    7892     			{
;    7893     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7894     			sub_ind=10;
	LDI  R30,LOW(10)
	STS  _sub_ind,R30
;    7895     			}		
;    7896 		}			
_0x9D0:
;    7897 	}	 
_0x9CF:
_0x9CE:
_0x9C3:
_0x9B8:
_0x9AD:
;    7898 	
;    7899 else if(ind==iProbe_set)
	RJMP _0x9D1
_0x9A2:
	LDI  R30,LOW(183)
	CP   R30,R13
	BREQ PC+3
	JMP _0x9D2
;    7900 	{
;    7901 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7902 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x9D3
;    7903 		{
;    7904 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9D5
	CPI  R26,LOW(0x7E)
	BRNE _0x9D4
_0x9D5:
;    7905 			{
;    7906 			PROBE=pON;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_PROBE)
	LDI  R27,HIGH(_PROBE)
	CALL __EEPROMWRB
;    7907 			}           
;    7908 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9D7
_0x9D4:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9D9
	CPI  R26,LOW(0xBE)
	BRNE _0x9D8
_0x9D9:
;    7909 			{
;    7910 			PROBE=pOFF;
	LDI  R30,LOW(170)
	LDI  R26,LOW(_PROBE)
	LDI  R27,HIGH(_PROBE)
	CALL __EEPROMWRB
;    7911 			}   
;    7912 		else if(but_pult==butE)
	RJMP _0x9DB
_0x9D8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9DC
;    7913 			{
;    7914 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7915 			}			 		 
;    7916 		} 
_0x9DC:
_0x9DB:
_0x9D7:
;    7917 		
;    7918 	else if(sub_ind==1)
	RJMP _0x9DD
_0x9D3:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0x9DE
;    7919 		{
;    7920 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9E0
	CPI  R26,LOW(0x7E)
	BRNE _0x9DF
_0x9E0:
;    7921 			{
;    7922 			PROBE_DUTY=((PROBE_DUTY/24)+1)*24;
	CALL SUBOPT_0x17B
	ADIW R30,1
	CALL SUBOPT_0x17C
;    7923 			granee(&PROBE_DUTY,24,96);
;    7924 			}           
;    7925 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9E2
_0x9DF:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9E4
	CPI  R26,LOW(0xBE)
	BRNE _0x9E3
_0x9E4:
;    7926 			{
;    7927 			PROBE_DUTY=((PROBE_DUTY/24)-1)*24;
	CALL SUBOPT_0x17B
	SBIW R30,1
	CALL SUBOPT_0x17C
;    7928 			granee(&PROBE_DUTY,24,96);
;    7929 			}   
;    7930 		else if(but_pult==butE)
	RJMP _0x9E6
_0x9E3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9E7
;    7931 			{
;    7932 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7933 			}			 		 
;    7934 		}  
_0x9E7:
_0x9E6:
_0x9E2:
;    7935 		 
;    7936 	else if(sub_ind==2)
	RJMP _0x9E8
_0x9DE:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0x9E9
;    7937 		{
;    7938 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9EB
	CPI  R26,LOW(0x7E)
	BRNE _0x9EA
_0x9EB:
;    7939 			{
;    7940 			PROBE_TIME=((PROBE_TIME/15)+1)*15;
	CALL SUBOPT_0x17D
	CALL SUBOPT_0x16E
	CALL SUBOPT_0x17E
;    7941 			granee(&PROBE_TIME,0,1425);
	CALL SUBOPT_0x17F
;    7942 			}           
;    7943 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9ED
_0x9EA:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9EF
	CPI  R26,LOW(0xBE)
	BRNE _0x9EE
_0x9EF:
;    7944 			{
;    7945 			PROBE_TIME=((PROBE_TIME/15)-1)*15;
	CALL SUBOPT_0x17D
	CALL SUBOPT_0x170
	CALL SUBOPT_0x17E
;    7946 			granee(&PROBE_TIME,0,1425);
	CALL SUBOPT_0x17F
;    7947 			}   
;    7948 		else if(but_pult==butE)
	RJMP _0x9F1
_0x9EE:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9F2
;    7949 			{
;    7950 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    7951 			}			 		 
;    7952 		}  
_0x9F2:
_0x9F1:
_0x9ED:
;    7953 	else if(sub_ind==3)
	RJMP _0x9F3
_0x9E9:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0x9F4
;    7954 		{
;    7955 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0x9F5
;    7956     			{
;    7957     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    7958     			sub_ind=11;
	LDI  R30,LOW(11)
	STS  _sub_ind,R30
;    7959     			}		
;    7960 		}			
_0x9F5:
;    7961 	}	    
_0x9F4:
_0x9F3:
_0x9E8:
_0x9DD:
;    7962 	
;    7963 else if(ind==iHh_set)
	RJMP _0x9F6
_0x9D2:
	LDI  R30,LOW(184)
	CP   R30,R13
	BREQ PC+3
	JMP _0x9F7
;    7964 	{
;    7965 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    7966 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0x9F8
;    7967 		{
;    7968 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0x9FA
	CPI  R26,LOW(0x7E)
	BRNE _0x9F9
_0x9FA:
;    7969 			{
;    7970 			HH_SENS=hhWMS;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_HH_SENS)
	LDI  R27,HIGH(_HH_SENS)
	CALL __EEPROMWRB
;    7971 			}           
;    7972 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0x9FC
_0x9F9:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0x9FE
	CPI  R26,LOW(0xBE)
	BRNE _0x9FD
_0x9FE:
;    7973 			{
;    7974 			HH_SENS=hhWMS;
	LDI  R30,LOW(85)
	LDI  R26,LOW(_HH_SENS)
	LDI  R27,HIGH(_HH_SENS)
	CALL __EEPROMWRB
;    7975 			}   
;    7976 		else if(but_pult==butE)
	RJMP _0xA00
_0x9FD:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA01
;    7977 			{
;    7978 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    7979 			}			 		 
;    7980 		} 
_0xA01:
_0xA00:
_0x9FC:
;    7981 		
;    7982 	else if(sub_ind==1)
	RJMP _0xA02
_0x9F8:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0xA03
;    7983 		{
;    7984 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xA05
	CPI  R26,LOW(0x7E)
	BRNE _0xA04
_0xA05:
;    7985 			{
;    7986 			HH_TIME++;
	LDI  R26,LOW(_HH_TIME)
	LDI  R27,HIGH(_HH_TIME)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    7987 			granee(&HH_TIME,1,60);
	CALL SUBOPT_0x180
;    7988 			}           
;    7989 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xA07
_0xA04:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xA09
	CPI  R26,LOW(0xBE)
	BRNE _0xA08
_0xA09:
;    7990 			{
;    7991 			HH_TIME--;
	LDI  R26,LOW(_HH_TIME)
	LDI  R27,HIGH(_HH_TIME)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    7992 			granee(&HH_TIME,1,60);
	CALL SUBOPT_0x180
;    7993 			}   		
;    7994 		else if(but_pult==butE)
	RJMP _0xA0B
_0xA08:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA0C
;    7995 			{
;    7996 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    7997 			}			 		 
;    7998 		}  
_0xA0C:
_0xA0B:
_0xA07:
;    7999 		 
;    8000 	else if(sub_ind==2)
	RJMP _0xA0D
_0xA03:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0xA0E
;    8001 		{
;    8002 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xA10
	CPI  R26,LOW(0x7E)
	BRNE _0xA0F
_0xA10:
;    8003 			{
;    8004 			HH_P++;
	LDI  R26,LOW(_HH_P)
	LDI  R27,HIGH(_HH_P)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8005 			granee(&HH_P,1,100);
	CALL SUBOPT_0x181
;    8006 			}           
;    8007 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xA12
_0xA0F:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xA14
	CPI  R26,LOW(0xBE)
	BRNE _0xA13
_0xA14:
;    8008 			{
;    8009 			HH_P--;
	LDI  R26,LOW(_HH_P)
	LDI  R27,HIGH(_HH_P)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8010 			granee(&HH_P,1,100);
	CALL SUBOPT_0x181
;    8011 			}   		
;    8012 		else if(but_pult==butE)
	RJMP _0xA16
_0xA13:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA17
;    8013 			{
;    8014 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    8015 			}			 		 
;    8016 		}  
_0xA17:
_0xA16:
_0xA12:
;    8017 	else if(sub_ind==3)
	RJMP _0xA18
_0xA0E:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0xA19
;    8018 		{
;    8019 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA1A
;    8020     			{
;    8021     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    8022     			sub_ind=12;
	LDI  R30,LOW(12)
	STS  _sub_ind,R30
;    8023     			}		
;    8024 		}			
_0xA1A:
;    8025 	}
_0xA19:
_0xA18:
_0xA0D:
_0xA02:
;    8026 
;    8027 else if(ind==iTimer_sel)
	RJMP _0xA1B
_0x9F7:
	LDI  R30,LOW(160)
	CP   R30,R13
	BREQ PC+3
	JMP _0xA1C
;    8028 	{
;    8029 	if(but_pult==butU)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BRNE _0xA1D
;    8030 		{
;    8031 		sub_ind--;
	CALL SUBOPT_0x13E
;    8032 		gran_char(&sub_ind,0,8);
	CALL SUBOPT_0x182
;    8033 		}
;    8034     	else	if(but_pult==butD)
	RJMP _0xA1E
_0xA1D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BRNE _0xA1F
;    8035 		{
;    8036 		sub_ind++;
	CALL SUBOPT_0x139
;    8037 		gran_char(&sub_ind,0,8);
	CALL SUBOPT_0x182
;    8038 		}
;    8039 	else if(sub_ind==0)
	RJMP _0xA20
_0xA1F:
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0xA21
;    8040 		{
;    8041 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xA23
	CPI  R26,LOW(0x7E)
	BRNE _0xA22
_0xA23:
;    8042 			{
;    8043 			P_UST_EE=((P_UST_EE/10)+1)*10;
	CALL SUBOPT_0x183
	CALL SUBOPT_0x13B
	CALL SUBOPT_0x184
;    8044 			granee(&P_UST_EE,0,300);
	CALL SUBOPT_0x185
;    8045 			}           
;    8046 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xA25
_0xA22:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xA27
	CPI  R26,LOW(0xBE)
	BRNE _0xA26
_0xA27:
;    8047 			{
;    8048 			P_UST_EE=((P_UST_EE/10)-1)*10;
	CALL SUBOPT_0x183
	CALL SUBOPT_0x13C
	CALL SUBOPT_0x184
;    8049 			granee(&P_UST_EE,0,300);
	CALL SUBOPT_0x185
;    8050 			}
;    8051 		}   	 
_0xA26:
_0xA25:
;    8052 	else if((sub_ind>=1)&&(sub_ind<=7))
	RJMP _0xA29
_0xA21:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRLO _0xA2B
	LDI  R30,LOW(7)
	CP   R30,R26
	BRSH _0xA2C
_0xA2B:
	RJMP _0xA2A
_0xA2C:
;    8053 		{
;    8054 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA2D
;    8055 			{
;    8056 			ind=iTimer_set;
	LDI  R30,LOW(185)
	MOV  R13,R30
;    8057 			sub_ind1=sub_ind-1;
	LDS  R30,_sub_ind
	SUBI R30,LOW(1)
	STS  _sub_ind1,R30
;    8058 			sub_ind=0;
	CALL SUBOPT_0x15A
;    8059 			sub_ind2=0;
	STS  _sub_ind2,R30
;    8060 			}
;    8061 		}
_0xA2D:
;    8062 	else if(sub_ind==8)
	RJMP _0xA2E
_0xA2A:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x8)
	BRNE _0xA2F
;    8063 		{
;    8064 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA30
;    8065 			{	
;    8066 			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    8067 			sub_ind=13;
	LDI  R30,LOW(13)
	STS  _sub_ind,R30
;    8068 			}
;    8069 		}   						
_0xA30:
;    8070 	}
_0xA2F:
_0xA2E:
_0xA29:
_0xA20:
_0xA1E:
;    8071 
;    8072 else if(ind==iTimer_set)
	RJMP _0xA31
_0xA1C:
	LDI  R30,LOW(185)
	CP   R30,R13
	BREQ PC+3
	JMP _0xA32
;    8073 	{ 
;    8074 	if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA33
;    8075 		{
;    8076 		if(sub_ind<5)sub_ind++;
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRSH _0xA34
	LDS  R30,_sub_ind
	RJMP _0xB8C
;    8077 		else 
_0xA34:
;    8078 			{
;    8079 			ind=iTimer_sel;
	LDI  R30,LOW(160)
	MOV  R13,R30
;    8080 			sub_ind=sub_ind1+1;
	LDS  R30,_sub_ind1
_0xB8C:
	SUBI R30,-LOW(1)
	STS  _sub_ind,R30
;    8081 			}
;    8082 		}
;    8083 	else if(but_pult==butR)
	RJMP _0xA36
_0xA33:
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BRNE _0xA37
;    8084 		{
;    8085 		sub_ind2++;
	LDS  R30,_sub_ind2
	SUBI R30,-LOW(1)
	CALL SUBOPT_0x186
;    8086 		gran_ring_char(&sub_ind2,0,5);
	CALL SUBOPT_0x187
;    8087 		}   
;    8088 	else if(but_pult==butL)
	RJMP _0xA38
_0xA37:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BRNE _0xA39
;    8089 		{
;    8090 		sub_ind2--;
	LDS  R30,_sub_ind2
	SUBI R30,LOW(1)
	CALL SUBOPT_0x186
;    8091 		gran_ring_char(&sub_ind2,0,5);
	CALL SUBOPT_0x187
;    8092 		}
;    8093 	else if(sub_ind2==0)
	RJMP _0xA3A
_0xA39:
	LDS  R30,_sub_ind2
	CPI  R30,0
	BREQ PC+3
	JMP _0xA3B
;    8094 		{
;    8095 		if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA3D
	CPI  R26,LOW(0xEE)
	BRNE _0xA3C
_0xA3D:
;    8096 			{
;    8097 			timer_time1[sub_ind1,sub_ind]+=60;
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __EEPROMRDW
	ADIW R30,60
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8098 			granee(&timer_time1[sub_ind1,sub_ind],0,1439);
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x189
;    8099 			}
;    8100 		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA3F
_0xA3C:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA41
	CPI  R26,LOW(0xDE)
	BRNE _0xA40
_0xA41:
;    8101 			{
;    8102 			timer_time1[sub_ind1,sub_ind]-=60;
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __EEPROMRDW
	SBIW R30,60
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8103 			granee(&timer_time1[sub_ind1,sub_ind],0,1439);
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x189
;    8104 			}			
;    8105 		}	  	
_0xA40:
_0xA3F:
;    8106 	else if(sub_ind2==1)
	RJMP _0xA43
_0xA3B:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x1)
	BREQ PC+3
	JMP _0xA44
;    8107 		{
;    8108 		if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA46
	CPI  R26,LOW(0xEE)
	BRNE _0xA45
_0xA46:
;    8109 			{
;    8110 			timer_time1[sub_ind1,sub_ind]=((timer_time1[sub_ind1,sub_ind]/5)+1)*5;
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12D
	CALL SUBOPT_0x18A
	CALL SUBOPT_0x18B
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8111 			granee(&timer_time1[sub_ind1,sub_ind],0,1435);
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x18C
;    8112 			}
;    8113 		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA48
_0xA45:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA4A
	CPI  R26,LOW(0xDE)
	BRNE _0xA49
_0xA4A:
;    8114 			{
;    8115 			timer_time1[sub_ind1,sub_ind]=((timer_time1[sub_ind1,sub_ind]/5)-1)*5;
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12D
	CALL SUBOPT_0x18A
	CALL SUBOPT_0x18D
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8116 			granee(&timer_time1[sub_ind1,sub_ind],0,1435);
	CALL SUBOPT_0x12C
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x18C
;    8117 			}			
;    8118 		}	  				 
_0xA49:
_0xA48:
;    8119 	else if(sub_ind2==2)
	RJMP _0xA4C
_0xA44:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x2)
	BREQ PC+3
	JMP _0xA4D
;    8120 		{
;    8121 		if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA4F
	CPI  R26,LOW(0xEE)
	BRNE _0xA4E
_0xA4F:
;    8122 			{
;    8123 			timer_time2[sub_ind1,sub_ind]+=60;
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __EEPROMRDW
	ADIW R30,60
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8124 			granee(&timer_time2[sub_ind1,sub_ind],0,1439);
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x189
;    8125 			}
;    8126 		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA51
_0xA4E:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA53
	CPI  R26,LOW(0xDE)
	BRNE _0xA52
_0xA53:
;    8127 			{
;    8128 			timer_time2[sub_ind1,sub_ind]-=60;
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	MOVW R26,R30
	CALL __EEPROMRDW
	SBIW R30,60
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8129 			granee(&timer_time2[sub_ind1,sub_ind],0,1439);
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x189
;    8130 			}			
;    8131 		}	  	
_0xA52:
_0xA51:
;    8132 	else if(sub_ind2==3)
	RJMP _0xA55
_0xA4D:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x3)
	BREQ PC+3
	JMP _0xA56
;    8133 		{
;    8134 		if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA58
	CPI  R26,LOW(0xEE)
	BRNE _0xA57
_0xA58:
;    8135 			{
;    8136 			timer_time2[sub_ind1,sub_ind]=((timer_time2[sub_ind1,sub_ind]/5)+1)*5;
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x131
	CALL SUBOPT_0x18A
	CALL SUBOPT_0x18B
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8137 			granee(&timer_time2[sub_ind1,sub_ind],0,1435);
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x18C
;    8138 			}
;    8139 		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA5A
_0xA57:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA5C
	CPI  R26,LOW(0xDE)
	BRNE _0xA5B
_0xA5C:
;    8140 			{
;    8141 			timer_time2[sub_ind1,sub_ind]=((timer_time2[sub_ind1,sub_ind]/5)-1)*5;
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x131
	CALL SUBOPT_0x18A
	CALL SUBOPT_0x18D
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8142 			granee(&timer_time2[sub_ind1,sub_ind],0,1435);
	CALL SUBOPT_0x130
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x18C
;    8143 			}			
;    8144 		} 
_0xA5B:
_0xA5A:
;    8145 		
;    8146 	else if(sub_ind2==4)
	RJMP _0xA5E
_0xA56:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x4)
	BREQ PC+3
	JMP _0xA5F
;    8147 		{
;    8148 		if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA61
	CPI  R26,LOW(0xEE)
	BREQ _0xA61
	RJMP _0xA60
_0xA61:
;    8149 			{
;    8150 			if(timer_mode[sub_ind1,sub_ind]==1)timer_mode[sub_ind1,sub_ind]=2;
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x70
	BRNE _0xA63
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(2)
	CALL __EEPROMWRB
;    8151 			else if(timer_mode[sub_ind1,sub_ind]==2)timer_mode[sub_ind1,sub_ind]=3; 
	RJMP _0xA64
_0xA63:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12A
	BRNE _0xA65
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(3)
	RJMP _0xB8D
;    8152 			else timer_mode[sub_ind1,sub_ind]=1;
_0xA65:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(1)
_0xB8D:
	CALL __EEPROMWRB
_0xA64:
;    8153 			}
;    8154 		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA67
_0xA60:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA69
	CPI  R26,LOW(0xDE)
	BREQ _0xA69
	RJMP _0xA68
_0xA69:
;    8155 			{
;    8156 			if(timer_mode[sub_ind1,sub_ind]==1)timer_mode[sub_ind1,sub_ind]=3;
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x70
	BRNE _0xA6B
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(3)
	CALL __EEPROMWRB
;    8157 			else if(timer_mode[sub_ind1,sub_ind]==2)timer_mode[sub_ind1,sub_ind]=1; 
	RJMP _0xA6C
_0xA6B:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12A
	BRNE _0xA6D
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(1)
	RJMP _0xB8E
;    8158 			else timer_mode[sub_ind1,sub_ind]=2;
_0xA6D:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(2)
_0xB8E:
	CALL __EEPROMWRB
_0xA6C:
;    8159 			}			
;    8160 		}		
_0xA68:
_0xA67:
;    8161 		
;    8162 	else if(sub_ind2==5)
	RJMP _0xA6F
_0xA5F:
	LDS  R26,_sub_ind2
	CPI  R26,LOW(0x5)
	BREQ PC+3
	JMP _0xA70
;    8163 		{
;    8164 		if(timer_mode[sub_ind1,sub_ind]==1)
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x70
	BREQ PC+3
	JMP _0xA71
;    8165 			{
;    8166 			if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA73
	CPI  R26,LOW(0xEE)
	BRNE _0xA72
_0xA73:
;    8167 		    		{
;    8168 				timer_data1[sub_ind1,sub_ind]=((timer_data1[sub_ind1,sub_ind]/10)+1)*10;
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x18E
	CALL SUBOPT_0x13B
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8169 				granee(&timer_data1[sub_ind1,sub_ind],0,3000);
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x18F
;    8170 				}	
;    8171 	    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA75
_0xA72:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA77
	CPI  R26,LOW(0xDE)
	BRNE _0xA76
_0xA77:
;    8172 				{
;    8173 				timer_data1[sub_ind1,sub_ind]=((timer_data1[sub_ind1,sub_ind]/10)-1)*10;
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x18E
	CALL SUBOPT_0x13C
	POP  R26
	POP  R27
	CALL __EEPROMWRW
;    8174 				granee(&timer_data1[sub_ind1,sub_ind],0,3000);
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x18F
;    8175 		    		}
;    8176 		    	}	
_0xA76:
_0xA75:
;    8177 		else if(timer_mode[sub_ind1,sub_ind]==2)
	RJMP _0xA79
_0xA71:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12A
	BREQ PC+3
	JMP _0xA7A
;    8178 			{
;    8179 			if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA7C
	CPI  R26,LOW(0xEE)
	BRNE _0xA7B
_0xA7C:
;    8180 		    		{
;    8181 				timer_data1[sub_ind1,sub_ind]++;
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x9C
;    8182 				granee(&timer_data1[sub_ind1,sub_ind],FP_FMIN,FP_FMAX);
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x190
;    8183 				}	
;    8184 	    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA7E
_0xA7B:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA80
	CPI  R26,LOW(0xDE)
	BRNE _0xA7F
_0xA80:
;    8185 				{
;    8186 				timer_data1[sub_ind1,sub_ind]--;
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x151
;    8187 				granee(&timer_data1[sub_ind1,sub_ind],FP_FMIN,FP_FMAX);
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x190
;    8188 				}
;    8189 		    	}	 
_0xA7F:
_0xA7E:
;    8190 		else if(timer_mode[sub_ind1,sub_ind]==3)
	RJMP _0xA82
_0xA7A:
	CALL SUBOPT_0x127
	PUSH R27
	PUSH R26
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x12B
	BREQ PC+3
	JMP _0xA83
;    8191 			{
;    8192 			if((but_pult==butU)||(but_pult==butU_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	BREQ _0xA85
	CPI  R26,LOW(0xEE)
	BRNE _0xA84
_0xA85:
;    8193 		    		{
;    8194 				timer_data1[sub_ind1,sub_ind]++;
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x9C
;    8195 				granee(&timer_data1[sub_ind1,sub_ind],0,EE_DV_NUM);
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    8196 				}	
;    8197 	    		else if((but_pult==butD)||(but_pult==butD_))
	RJMP _0xA87
_0xA84:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xDF)
	BREQ _0xA89
	CPI  R26,LOW(0xDE)
	BRNE _0xA88
_0xA89:
;    8198 				{
;    8199 				timer_data1[sub_ind1,sub_ind]--;
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x128
	CALL SUBOPT_0x71
	CALL SUBOPT_0x151
;    8200 				granee(&timer_data1[sub_ind1,sub_ind],0,EE_DV_NUM);
	CALL SUBOPT_0x132
	PUSH R27
	PUSH R26
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x188
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x7F
	CALL _granee
;    8201 				}
;    8202 		    	}			    			
_0xA88:
_0xA87:
;    8203 		}					  						
_0xA83:
_0xA82:
_0xA79:
;    8204 	}
_0xA70:
_0xA6F:
_0xA5E:
_0xA55:
_0xA4C:
_0xA43:
_0xA3A:
_0xA38:
_0xA36:
;    8205 		
;    8206 else if(ind==iZero_load_set)
	RJMP _0xA8B
_0xA32:
	LDI  R30,LOW(186)
	CP   R30,R13
	BREQ PC+3
	JMP _0xA8C
;    8207 	{
;    8208 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    8209 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0xA8D
;    8210 		{
;    8211 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xA8F
	CPI  R26,LOW(0x7E)
	BRNE _0xA8E
_0xA8F:
;    8212 			{
;    8213 			ZL_TIME++;
	LDI  R26,LOW(_ZL_TIME)
	LDI  R27,HIGH(_ZL_TIME)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8214 			granee(&ZL_TIME,1,300);
	CALL SUBOPT_0x191
;    8215 			}           
;    8216 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xA91
_0xA8E:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xA93
	CPI  R26,LOW(0xBE)
	BRNE _0xA92
_0xA93:
;    8217 			{
;    8218 			ZL_TIME--;
	LDI  R26,LOW(_ZL_TIME)
	LDI  R27,HIGH(_ZL_TIME)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8219 			granee(&ZL_TIME,1,300);
	CALL SUBOPT_0x191
;    8220 			}   
;    8221 		else if(but_pult==butE)
	RJMP _0xA95
_0xA92:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA96
;    8222 			{
;    8223 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    8224 			}			 		 
;    8225 		} 
_0xA96:
_0xA95:
_0xA91:
;    8226 		
;    8227 	else if(sub_ind==1)
	RJMP _0xA97
_0xA8D:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0xA98
;    8228 		{
;    8229 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xA99
;    8230     			{
;    8231     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    8232     			sub_ind=14;
	LDI  R30,LOW(14)
	STS  _sub_ind,R30
;    8233     			}		
;    8234 		}			
_0xA99:
;    8235 	}		 
_0xA98:
_0xA97:
;    8236 	
;    8237 else if(ind==iPid_set)
	RJMP _0xA9A
_0xA8C:
	LDI  R30,LOW(159)
	CP   R30,R13
	BREQ PC+3
	JMP _0xA9B
;    8238 	{
;    8239 	speed=1;
	LDI  R30,LOW(1)
	__PUTB1MN _lcd_buffer,34
;    8240 	if(sub_ind==0)
	LDS  R30,_sub_ind
	CPI  R30,0
	BRNE _0xA9C
;    8241 		{
;    8242 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xA9E
	CPI  R26,LOW(0x7E)
	BRNE _0xA9D
_0xA9E:
;    8243 			{
;    8244 			PID_PERIOD++;
	LDI  R26,LOW(_PID_PERIOD)
	LDI  R27,HIGH(_PID_PERIOD)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8245 			granee(&PID_PERIOD,1,100);
	CALL SUBOPT_0x192
;    8246 			}           
;    8247 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xAA0
_0xA9D:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xAA2
	CPI  R26,LOW(0xBE)
	BRNE _0xAA1
_0xAA2:
;    8248 			{
;    8249 			PID_PERIOD--;
	LDI  R26,LOW(_PID_PERIOD)
	LDI  R27,HIGH(_PID_PERIOD)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8250 			granee(&PID_PERIOD,1,100);
	CALL SUBOPT_0x192
;    8251 			}   
;    8252 		else if(but_pult==butE)
	RJMP _0xAA4
_0xAA1:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xAA5
;    8253 			{
;    8254 			sub_ind=1;
	LDI  R30,LOW(1)
	STS  _sub_ind,R30
;    8255 			}			 		 
;    8256 		} 
_0xAA5:
_0xAA4:
_0xAA0:
;    8257 	else if(sub_ind==1)
	RJMP _0xAA6
_0xA9C:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x1)
	BRNE _0xAA7
;    8258 		{
;    8259 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xAA9
	CPI  R26,LOW(0x7E)
	BRNE _0xAA8
_0xAA9:
;    8260 			{
;    8261 			PID_K++;
	LDI  R26,LOW(_PID_K)
	LDI  R27,HIGH(_PID_K)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8262 			granee(&PID_K,1,10);
	CALL SUBOPT_0x193
;    8263 			}           
;    8264 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xAAB
_0xAA8:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xAAD
	CPI  R26,LOW(0xBE)
	BRNE _0xAAC
_0xAAD:
;    8265 			{
;    8266 			PID_K--;
	LDI  R26,LOW(_PID_K)
	LDI  R27,HIGH(_PID_K)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8267 			granee(&PID_K,1,10);
	CALL SUBOPT_0x193
;    8268 			}   
;    8269 		else if(but_pult==butE)
	RJMP _0xAAF
_0xAAC:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xAB0
;    8270 			{
;    8271 			sub_ind=2;
	LDI  R30,LOW(2)
	STS  _sub_ind,R30
;    8272 			}			 		 
;    8273 		} 		   
_0xAB0:
_0xAAF:
_0xAAB:
;    8274 	else if(sub_ind==2)
	RJMP _0xAB1
_0xAA7:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x2)
	BRNE _0xAB2
;    8275 		{
;    8276 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xAB4
	CPI  R26,LOW(0x7E)
	BRNE _0xAB3
_0xAB4:
;    8277 			{
;    8278 			PID_K_P++;
	LDI  R26,LOW(_PID_K_P)
	LDI  R27,HIGH(_PID_K_P)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8279 			granee(&PID_K_P,1,10);
	CALL SUBOPT_0x194
;    8280 			}           
;    8281 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xAB6
_0xAB3:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xAB8
	CPI  R26,LOW(0xBE)
	BRNE _0xAB7
_0xAB8:
;    8282 			{
;    8283 			PID_K_P--;
	LDI  R26,LOW(_PID_K_P)
	LDI  R27,HIGH(_PID_K_P)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8284 			granee(&PID_K_P,1,10);
	CALL SUBOPT_0x194
;    8285 			}   
;    8286 		else if(but_pult==butE)
	RJMP _0xABA
_0xAB7:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xABB
;    8287 			{
;    8288 			sub_ind=3;
	LDI  R30,LOW(3)
	STS  _sub_ind,R30
;    8289 			}			 		 
;    8290 		}  
_0xABB:
_0xABA:
_0xAB6:
;    8291 	else if(sub_ind==3)
	RJMP _0xABC
_0xAB2:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x3)
	BRNE _0xABD
;    8292 		{
;    8293 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xABF
	CPI  R26,LOW(0x7E)
	BRNE _0xABE
_0xABF:
;    8294 			{
;    8295 			PID_K_D++;
	LDI  R26,LOW(_PID_K_D)
	LDI  R27,HIGH(_PID_K_D)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8296 			granee(&PID_K_D,1,10);
	CALL SUBOPT_0x195
;    8297 			}           
;    8298 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xAC1
_0xABE:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xAC3
	CPI  R26,LOW(0xBE)
	BRNE _0xAC2
_0xAC3:
;    8299 			{
;    8300 			PID_K_D--;
	LDI  R26,LOW(_PID_K_D)
	LDI  R27,HIGH(_PID_K_D)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8301 			granee(&PID_K_D,1,10);
	CALL SUBOPT_0x195
;    8302 			}   
;    8303 		else if(but_pult==butE)
	RJMP _0xAC5
_0xAC2:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xAC6
;    8304 			{
;    8305 			sub_ind=4;
	LDI  R30,LOW(4)
	STS  _sub_ind,R30
;    8306 			}			 		 
;    8307 		} 	
_0xAC6:
_0xAC5:
_0xAC1:
;    8308 	else if(sub_ind==4)
	RJMP _0xAC7
_0xABD:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x4)
	BRNE _0xAC8
;    8309 		{
;    8310 		if((but_pult==butR)||(but_pult==butR_))
	LDS  R26,_but_pult
	CPI  R26,LOW(0x7F)
	BREQ _0xACA
	CPI  R26,LOW(0x7E)
	BRNE _0xAC9
_0xACA:
;    8311 			{
;    8312 			PID_K_FP_DOWN++;
	LDI  R26,LOW(_PID_K_FP_DOWN)
	LDI  R27,HIGH(_PID_K_FP_DOWN)
	CALL __EEPROMRDW
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
;    8313 			granee(&PID_K_FP_DOWN,1,100);
	CALL SUBOPT_0x196
;    8314 			}           
;    8315 		else if((but_pult==butL)||(but_pult==butL_))
	RJMP _0xACC
_0xAC9:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xBF)
	BREQ _0xACE
	CPI  R26,LOW(0xBE)
	BRNE _0xACD
_0xACE:
;    8316 			{
;    8317 			PID_K_FP_DOWN--;
	LDI  R26,LOW(_PID_K_FP_DOWN)
	LDI  R27,HIGH(_PID_K_FP_DOWN)
	CALL __EEPROMRDW
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
;    8318 			granee(&PID_K_FP_DOWN,1,100);
	CALL SUBOPT_0x196
;    8319 			}   
;    8320 		else if(but_pult==butE)
	RJMP _0xAD0
_0xACD:
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xAD1
;    8321 			{
;    8322 			sub_ind=5;
	LDI  R30,LOW(5)
	STS  _sub_ind,R30
;    8323 			}			 		 
;    8324 		} 											
_0xAD1:
_0xAD0:
_0xACC:
;    8325 	else if(sub_ind==5)
	RJMP _0xAD2
_0xAC8:
	LDS  R26,_sub_ind
	CPI  R26,LOW(0x5)
	BRNE _0xAD3
;    8326 		{
;    8327 		if(but_pult==butE)
	LDS  R26,_but_pult
	CPI  R26,LOW(0xF7)
	BRNE _0xAD4
;    8328     			{
;    8329     			ind=iSet;
	LDI  R30,LOW(34)
	MOV  R13,R30
;    8330     			sub_ind=15;
	LDI  R30,LOW(15)
	STS  _sub_ind,R30
;    8331     			}		
;    8332 		}			
_0xAD4:
;    8333 	}					
_0xAD3:
_0xAD2:
_0xAC7:
_0xABC:
_0xAB1:
_0xAA6:
;    8334 
;    8335 but_pult=0;
_0xA9B:
_0xA9A:
_0xA8B:
_0xA31:
_0xA1B:
_0x9F6:
_0x9D1:
_0x9A1:
_0x945:
_0x92B:
_0x8FB:
_0x8CB:
_0x8C8:
_0x8BD:
_0x8B2:
_0x89A:
_0x88F:
_0x885:
_0x87A:
_0x86F:
_0x864:
_0x859:
_0x80A:
_0x7C9:
_0x77A:
_0x767:
_0x721:
_0x6F9:
_0x6F2:
_0x6DF:
	LDI  R30,LOW(0)
	STS  _but_pult,R30
;    8336 }
	RET
;    8337 
;    8338 //-----------------------------------------------
;    8339 void can_in_an(void)
;    8340 { 
_can_in_an:
;    8341 if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00000011)       //плата индикации
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x20
	ANDI R30,LOW(0xE3)
	CPI  R30,LOW(0x3)
	BREQ PC+3
	JMP _0xAD5
;    8342 	{ 
;    8343 	if(fifo_can_in[ptr_rx_rd,0]==0xff)
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x198
	BREQ PC+3
	JMP _0xAD6
;    8344 		{
;    8345 		char temp;
;    8346 		if((fifo_can_in[ptr_rx_rd,3]==0x55)&&(fifo_can_in[ptr_rx_rd,4]==0x55)&&(fifo_can_in[ptr_rx_rd,5]==0x55)&&(fifo_can_in[ptr_rx_rd,6]==0x55))
	SBIW R28,1
;	temp -> Y+0
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x55)
	BRNE _0xAD8
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CPI  R30,LOW(0x55)
	BRNE _0xAD8
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x55)
	BRNE _0xAD8
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CPI  R30,LOW(0x55)
	BREQ _0xAD9
_0xAD8:
	RJMP _0xAD7
_0xAD9:
;    8347 			{
;    8348 		    //	plazma++;
;    8349 			temp=read_ds14287(HOURS);
	CALL SUBOPT_0x43
	ST   Y,R30
;    8350 			temp++;
	CALL SUBOPT_0x18
;    8351 			gran_ring_char(&temp,0,23);
	MOVW R30,R28
	CALL SUBOPT_0x90
	LDI  R30,LOW(23)
	ST   -Y,R30
	CALL _gran_ring_char
;    8352 			write_ds14287(HOURS,temp);
	CALL SUBOPT_0x146
;    8353 			}
;    8354    /*		else if((fifo_can_in[ptr_rx_rd,3]==0xaa)&&(fifo_can_in[ptr_rx_rd,4]==0xaa)&&(fifo_can_in[ptr_rx_rd,5]==0xaa)&&(fifo_can_in[ptr_rx_rd,6]==0xaa))
;    8355 			{
;    8356 			temp=read_ds14287(HOURS);
;    8357 			temp--;
;    8358 			gran_ring_char(&temp,0,23);
;    8359 			write_ds14287(HOURS,temp);
;    8360 			}*/ 
;    8361 		else if((fifo_can_in[ptr_rx_rd,3]==0x99)&&(fifo_can_in[ptr_rx_rd,4]==0x99)&&(fifo_can_in[ptr_rx_rd,5]==0x99)&&(fifo_can_in[ptr_rx_rd,6]==0x99))
	RJMP _0xADA
_0xAD7:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x99)
	BRNE _0xADC
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CPI  R30,LOW(0x99)
	BRNE _0xADC
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x99)
	BRNE _0xADC
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CPI  R30,LOW(0x99)
	BREQ _0xADD
_0xADC:
	RJMP _0xADB
_0xADD:
;    8362 			{
;    8363 			temp=read_ds14287(MINUTES);
	CALL SUBOPT_0x44
	ST   Y,R30
;    8364 			temp++;
	CALL SUBOPT_0x18
;    8365 			gran_ring_char(&temp,0,59);
	MOVW R30,R28
	CALL SUBOPT_0x90
	LDI  R30,LOW(59)
	ST   -Y,R30
	CALL _gran_ring_char
;    8366 			write_ds14287(MINUTES,temp);
	CALL SUBOPT_0x148
;    8367 			}
;    8368  /*		else if((fifo_can_in[ptr_rx_rd,3]==0x66)&&(fifo_can_in[ptr_rx_rd,4]==0x66)&&(fifo_can_in[ptr_rx_rd,5]==0x66)&&(fifo_can_in[ptr_rx_rd,6]==0x66))
;    8369 			{
;    8370 			temp=read_ds14287(MINUTES);
;    8371 			temp--;
;    8372 			gran_ring_char(&temp,0,59);
;    8373 			write_ds14287(MINUTES,temp);
;    8374 			}  */
;    8375 		else if((fifo_can_in[ptr_rx_rd,3]==0x66)&&(fifo_can_in[ptr_rx_rd,4]==0x66)&&(fifo_can_in[ptr_rx_rd,5]==0x66)&&(fifo_can_in[ptr_rx_rd,6]==0x66))
	RJMP _0xADE
_0xADB:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x66)
	BRNE _0xAE0
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CPI  R30,LOW(0x66)
	BRNE _0xAE0
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x66)
	BRNE _0xAE0
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CPI  R30,LOW(0x66)
	BREQ _0xAE1
_0xAE0:
	RJMP _0xADF
_0xAE1:
;    8376 			{
;    8377 		    //	plazma++;
;    8378 			p_ind_cnt=20;
	CALL SUBOPT_0x19B
;    8379 			P_UST_EE=((P_UST_EE/10)+1)*10;
	CALL SUBOPT_0x13B
	CALL SUBOPT_0x184
;    8380 			granee(&P_UST_EE,0,3000);
	CALL SUBOPT_0x18F
;    8381 			}
;    8382 
;    8383 		else if((fifo_can_in[ptr_rx_rd,3]==0x67)&&(fifo_can_in[ptr_rx_rd,4]==0x67)&&(fifo_can_in[ptr_rx_rd,5]==0x67)&&(fifo_can_in[ptr_rx_rd,6]==0x67))
	RJMP _0xAE2
_0xADF:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x67)
	BRNE _0xAE4
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CPI  R30,LOW(0x67)
	BRNE _0xAE4
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x67)
	BRNE _0xAE4
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CPI  R30,LOW(0x67)
	BREQ _0xAE5
_0xAE4:
	RJMP _0xAE3
_0xAE5:
;    8384 			{
;    8385 			p_ind_cnt=20;
	CALL SUBOPT_0x19B
;    8386 			P_UST_EE=((P_UST_EE/10)+10)*10;
	ADIW R30,10
	CALL SUBOPT_0x19C
;    8387 			granee(&P_UST_EE,0,3000);
	CALL SUBOPT_0x18F
;    8388 			}												
;    8389 		
;    8390 		else if((fifo_can_in[ptr_rx_rd,3]==0x77)&&(fifo_can_in[ptr_rx_rd,4]==0x77)&&(fifo_can_in[ptr_rx_rd,5]==0x77)&&(fifo_can_in[ptr_rx_rd,6]==0x77))
	RJMP _0xAE6
_0xAE3:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x77)
	BRNE _0xAE8
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CPI  R30,LOW(0x77)
	BRNE _0xAE8
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x77)
	BRNE _0xAE8
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CPI  R30,LOW(0x77)
	BREQ _0xAE9
_0xAE8:
	RJMP _0xAE7
_0xAE9:
;    8391 			{
;    8392 			p_ind_cnt=20;
	CALL SUBOPT_0x19B
;    8393 			P_UST_EE=((P_UST_EE/10)-1)*10;
	CALL SUBOPT_0x13C
	CALL SUBOPT_0x184
;    8394 			granee(&P_UST_EE,0,3000);
	CALL SUBOPT_0x18F
;    8395 			}
;    8396 
;    8397 		else if((fifo_can_in[ptr_rx_rd,3]==0x76)&&(fifo_can_in[ptr_rx_rd,4]==0x76)&&(fifo_can_in[ptr_rx_rd,5]==0x76)&&(fifo_can_in[ptr_rx_rd,6]==0x76))
	RJMP _0xAEA
_0xAE7:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	CPI  R30,LOW(0x76)
	BRNE _0xAEC
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CPI  R30,LOW(0x76)
	BRNE _0xAEC
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	CPI  R30,LOW(0x76)
	BRNE _0xAEC
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CPI  R30,LOW(0x76)
	BREQ _0xAED
_0xAEC:
	RJMP _0xAEB
_0xAED:
;    8398 			{
;    8399 			p_ind_cnt=20;
	CALL SUBOPT_0x19B
;    8400 			P_UST_EE=((P_UST_EE/10)-10)*10;
	SBIW R30,10
	CALL SUBOPT_0x19C
;    8401 			granee(&P_UST_EE,0,3000);
	CALL SUBOPT_0x18F
;    8402 			}												
;    8403 		}		
_0xAEB:
_0xAEA:
_0xAE6:
_0xAE2:
_0xADE:
_0xADA:
	ADIW R28,1
;    8404 	}
_0xAD6:
;    8405 
;    8406 else if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00100011)       //пульт
	RJMP _0xAEE
_0xAD5:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x20
	ANDI R30,LOW(0xE3)
	CPI  R30,LOW(0x23)
	BRNE _0xAEF
;    8407 	{   
;    8408 	if(fifo_can_in[ptr_rx_rd,0]==0xff)
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x198
	BRNE _0xAF0
;    8409 		{
;    8410 		if(fifo_can_in[ptr_rx_rd,3]==fifo_can_in[ptr_rx_rd,4])
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	POP  R26
	CP   R30,R26
	BRNE _0xAF1
;    8411 			{
;    8412 			but_pult=fifo_can_in[ptr_rx_rd,3];
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	STS  _but_pult,R30
;    8413 			but_an_pult();
	CALL _but_an_pult
;    8414 			}
;    8415 		}         
_0xAF1:
;    8416 	}
_0xAF0:
;    8417 
;    8418 else if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00000001)
	RJMP _0xAF2
_0xAEF:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x20
	ANDI R30,LOW(0xE3)
	CPI  R30,LOW(0x1)
	BREQ PC+3
	JMP _0xAF3
;    8419 	{
;    8420     	//plazma++;
;    8421 	if(fifo_can_in[ptr_rx_rd,0]==0x08)
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x8)
	BREQ PC+3
	JMP _0xAF4
;    8422 		{
;    8423 		signed long temp_SL;
;    8424 	    	granee(&Kida[0],150,500);
	SBIW R28,4
;	temp_SL -> Y+0
	LDI  R30,LOW(_Kida)
	LDI  R31,HIGH(_Kida)
	CALL SUBOPT_0x19D
;    8425 		granee(&Kidc[0],150,500);
	LDI  R30,LOW(_Kidc)
	LDI  R31,HIGH(_Kidc)
	CALL SUBOPT_0x19D
;    8426 		granee(&Kida[1],150,500);
	__POINTW1MN _Kida,2
	CALL SUBOPT_0x19D
;    8427 		granee(&Kidc[1],150,500); 
	__POINTW1MN _Kidc,2
	CALL SUBOPT_0x19D
;    8428 		
;    8429 		
;    8430 		
;    8431 		if(dv_on[0]!=dvFR)
	LDS  R26,_dv_on
	CPI  R26,LOW(0x66)
	BRNE PC+3
	JMP _0xAF5
;    8432 			{
;    8433 			temp_SL=fifo_can_in[ptr_rx_rd,5]+(fifo_can_in[ptr_rx_rd,6]*256);
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	CALL SUBOPT_0x19E
	POP  R26
	CALL SUBOPT_0x19F
;    8434 			//plazma=(int)temp_SL;
;    8435 			if(temp_SL<10)temp_SL=0;
	__CPD2N 0xA
	BRGE _0xAF6
	__CLRD1S 0
;    8436 			Ida[0]=(temp_SL*(signed long)Kida[0])/10000; 
_0xAF6:
	LDI  R26,LOW(_Kida)
	LDI  R27,HIGH(_Kida)
	CALL SUBOPT_0x1A0
	STS  _Ida,R30
	STS  _Ida+1,R31
;    8437 			//Ida[0]=50;
;    8438 		
;    8439 			temp_SL=fifo_can_in[ptr_rx_rd,7]+(fifo_can_in[ptr_rx_rd,8]*256);
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A1
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A2
	CALL SUBOPT_0x19E
	POP  R26
	CALL SUBOPT_0x19F
;    8440 			if(temp_SL<10)temp_SL=0;		
	__CPD2N 0xA
	BRGE _0xAF7
	__CLRD1S 0
;    8441 	    		Idc[0]=(temp_SL*(signed long)Kidc[0])/10000;
_0xAF7:
	LDI  R26,LOW(_Kidc)
	LDI  R27,HIGH(_Kidc)
	CALL SUBOPT_0x1A3
	STS  _Idc,R30
	STS  _Idc+1,R31
;    8442 			//Idc[0]=50;   
;    8443 			
;    8444 			Id[0]=(Ida[0]+Idc[0])/2;
	LDS  R26,_Ida
	LDS  R27,_Ida+1
	CALL SUBOPT_0xCE
	STS  _Id,R30
	STS  _Id+1,R31
;    8445 		     }
;    8446 		//if(!((pilot_dv==0)&&(fp_stat==dvON)))Id[0]=(Ida[0]+Idc[0])/2;
;    8447 		
;    8448 		if(dv_on[1]!=dvFR)
_0xAF5:
	__GETB1MN _dv_on,1
	CPI  R30,LOW(0x66)
	BRNE PC+3
	JMP _0xAF8
;    8449 			{    
;    8450 			temp_SL=fifo_can_in[ptr_rx_rd,9]+(fifo_can_in[ptr_rx_rd,10]*256);
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A4
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A5
	CALL SUBOPT_0x19E
	POP  R26
	CALL SUBOPT_0x19F
;    8451 			if(temp_SL<10)temp_SL=0;
	__CPD2N 0xA
	BRGE _0xAF9
	__CLRD1S 0
;    8452 			Ida[1]=(temp_SL*(signed long)Kida[1])/10000;
_0xAF9:
	__POINTW2MN _Kida,2
	CALL SUBOPT_0x1A0
	__PUTW1MN _Ida,2
;    8453 	     	//Ida[1]=50;
;    8454 	 	
;    8455 	 		temp_SL=fifo_can_in[ptr_rx_rd,11]+(fifo_can_in[ptr_rx_rd,12]*256);
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A6
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A7
	CALL SUBOPT_0x19E
	POP  R26
	CALL SUBOPT_0x19F
;    8456 			if(temp_SL<10)temp_SL=0;
	__CPD2N 0xA
	BRGE _0xAFA
	__CLRD1S 0
;    8457 	    		Idc[1]=(temp_SL*(signed long)Kidc[1])/10000;
_0xAFA:
	__POINTW2MN _Kidc,2
	CALL SUBOPT_0x1A3
	__PUTW1MN _Idc,2
;    8458           	//Idc[1]=50;   
;    8459           	
;    8460           	Id[1]=(Ida[1]+Idc[1])/2;
	__GETW1MN _Ida,2
	PUSH R31
	PUSH R30
	__GETW1MN _Idc,2
	POP  R26
	POP  R27
	CALL SUBOPT_0xCE
	__PUTW1MN _Id,2
;    8461           	}
;    8462        	
;    8463        	if(!((pilot_dv==1)&&(fp_stat==dvON)))Id[1]=(Ida[1]+Idc[1])/2;
_0xAF8:
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xAFC
	LDS  R26,_fp_stat
	CPI  R26,LOW(0xAA)
	BREQ _0xAFB
_0xAFC:
	__GETW1MN _Ida,2
	PUSH R31
	PUSH R30
	__GETW1MN _Idc,2
	POP  R26
	POP  R27
	CALL SUBOPT_0xCE
	__PUTW1MN _Id,2
;    8464 		}
_0xAFB:
	ADIW R28,4
;    8465 	else if(fifo_can_in[ptr_rx_rd,0]==0x09)
	RJMP _0xAFE
_0xAF4:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x9)
	BREQ PC+3
	JMP _0xAFF
;    8466 		{
;    8467 			plazma++;
	CALL SUBOPT_0x29
;    8468 		plazma_int[0]=fifo_can_in[ptr_rx_rd,3]+(fifo_can_in[ptr_rx_rd,4]*256);
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CALL SUBOPT_0x19E
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	STS  _plazma_int,R30
	STS  _plazma_int+1,R31
;    8469 	    	if(fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])av_serv[0]=fifo_can_in[ptr_rx_rd,6];
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	POP  R26
	CP   R30,R26
	BRNE _0xB00
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	STS  _av_serv,R30
;    8470 	    	if(fifo_can_in[ptr_rx_rd,7]==fifo_can_in[ptr_rx_rd,7])av_serv[1]=fifo_can_in[ptr_rx_rd,8];
_0xB00:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A1
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A1
	POP  R26
	CP   R30,R26
	BRNE _0xB01
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A2
	__PUTB1MN _av_serv,1
;    8471 	    	if(fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])av_serv[2]=fifo_can_in[ptr_rx_rd,10];
_0xB01:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A4
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A5
	POP  R26
	CP   R30,R26
	BRNE _0xB02
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A5
	__PUTB1MN _av_serv,2
;    8472 	    	if(fifo_can_in[ptr_rx_rd,11]==fifo_can_in[ptr_rx_rd,12])av_serv[3]=fifo_can_in[ptr_rx_rd,12];		
_0xB02:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A6
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A7
	POP  R26
	CP   R30,R26
	BRNE _0xB03
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A7
	__PUTB1MN _av_serv,3
;    8473 	    	}	
_0xB03:
;    8474 	else if(fifo_can_in[ptr_rx_rd,0]==0x0a)
	RJMP _0xB04
_0xAFF:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0xA)
	BREQ PC+3
	JMP _0xB05
;    8475 		{
;    8476 		plazma_int[1]=fifo_can_in[ptr_rx_rd,3]+(fifo_can_in[ptr_rx_rd,4]*256);
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x24
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x199
	CALL SUBOPT_0x19E
	POP  R26
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	__PUTW1MN _plazma_int,2
;    8477 		if(fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])av_upp[0]=fifo_can_in[ptr_rx_rd,6];
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x22
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	POP  R26
	CP   R30,R26
	BRNE _0xB06
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x19A
	STS  _av_upp,R30
;    8478 	    	if(fifo_can_in[ptr_rx_rd,7]==fifo_can_in[ptr_rx_rd,7])av_upp[1]=fifo_can_in[ptr_rx_rd,8];
_0xB06:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A1
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A1
	POP  R26
	CP   R30,R26
	BRNE _0xB07
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A2
	__PUTB1MN _av_upp,1
;    8479 		if(fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])av_upp[2]=fifo_can_in[ptr_rx_rd,10];
_0xB07:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A4
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A5
	POP  R26
	CP   R30,R26
	BRNE _0xB08
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A5
	__PUTB1MN _av_upp,2
;    8480 	   	if(fifo_can_in[ptr_rx_rd,11]==fifo_can_in[ptr_rx_rd,12])av_upp[3]=fifo_can_in[ptr_rx_rd,12];
_0xB08:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A6
	PUSH R30
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A7
	POP  R26
	CP   R30,R26
	BRNE _0xB09
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x1A7
	__PUTB1MN _av_upp,3
;    8481 		}			
_0xB09:
;    8482      } 
_0xB05:
_0xB04:
_0xAFE:
;    8483      
;    8484 else if((fifo_can_in[ptr_rx_rd,0]==0xff)&&((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00100011))
	RJMP _0xB0A
_0xAF3:
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x198
	BRNE _0xB0C
	CALL SUBOPT_0x197
	PUSH R27
	PUSH R26
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	CALL __MULW12U
	POP  R26
	POP  R27
	CALL SUBOPT_0x20
	ANDI R30,LOW(0xE3)
	CPI  R30,LOW(0x23)
	BREQ _0xB0D
_0xB0C:
_0xB0D:
;    8485 	{
;    8486     //	plazma--;
;    8487 	} 
;    8488 }
_0xB0A:
_0xAF2:
_0xAEE:
	RET
;    8489 
;    8490 //-----------------------------------------------
;    8491 void can_hndl(void)
;    8492 {            
_can_hndl:
;    8493 while(rx_counter)
_0xB0E:
	LDS  R30,_rx_counter
	CPI  R30,0
	BREQ _0xB10
;    8494 	{
;    8495 	can_in_an();
	CALL _can_in_an
;    8496 	rx_counter--;
	LDS  R30,_rx_counter
	SUBI R30,LOW(1)
	STS  _rx_counter,R30
;    8497 	ptr_rx_rd++;
	LDS  R30,_ptr_rx_rd
	SUBI R30,-LOW(1)
	STS  _ptr_rx_rd,R30
;    8498 	if(ptr_rx_rd>=FIFO_CAN_IN_LEN)ptr_rx_rd=0;
	LDS  R26,_ptr_rx_rd
	CPI  R26,LOW(0xA)
	BRLO _0xB11
	LDI  R30,LOW(0)
	STS  _ptr_rx_rd,R30
;    8499 	
;    8500 	}
_0xB11:
	RJMP _0xB0E
_0xB10:
;    8501 }
	RET
;    8502 
;    8503 //-----------------------------------------------
;    8504 void can_init(void)
;    8505 {
_can_init:
;    8506 char spi_temp;
;    8507 mcp_reset();
	ST   -Y,R16
;	spi_temp -> R16
	CALL _mcp_reset
;    8508 spi_temp=spi_read(CANSTAT);
	LDI  R30,LOW(14)
	ST   -Y,R30
	CALL _spi_read
	MOV  R16,R30
;    8509 if((spi_temp&0xe0)!=0x80)
	MOV  R30,R16
	ANDI R30,LOW(0xE0)
	CPI  R30,LOW(0x80)
	BREQ _0xB12
;    8510 	{
;    8511 	spi_bit_modify(CANCTRL,0xe0,0x80);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(224)
	ST   -Y,R30
	LDI  R30,LOW(128)
	ST   -Y,R30
	CALL _spi_bit_modify
;    8512 	}
;    8513 delay_us(10);	
_0xB12:
	__DELAY_USB 27
;    8514 spi_write(CNF1,CNF1_INIT);
	LDI  R30,LOW(42)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	CALL _spi_write
;    8515 spi_write(CNF2,CNF2_INIT);
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(177)
	ST   -Y,R30
	CALL _spi_write
;    8516 spi_write(CNF3,CNF3_INIT);
	LDI  R30,LOW(40)
	CALL SUBOPT_0x134
	CALL _spi_write
;    8517 
;    8518 spi_write(RXB0CTRL,0b01000000);	// Расширенный идентификатор
	LDI  R30,LOW(96)
	CALL SUBOPT_0x1A8
;    8519 spi_write(RXB1CTRL,0b01000000);	// Расширенный идентификатор
	LDI  R30,LOW(112)
	CALL SUBOPT_0x1A8
;    8520 
;    8521 spi_write(RXM0SIDH, 0x00); 
	LDI  R30,LOW(32)
	CALL SUBOPT_0x1A9
;    8522 spi_write(RXM0SIDL, 0x00); 
	LDI  R30,LOW(33)
	CALL SUBOPT_0x1A9
;    8523 spi_write(RXM0EID8, 0x00); 
	LDI  R30,LOW(34)
	CALL SUBOPT_0x1A9
;    8524 spi_write(RXM0EID0, 0x00); 
	LDI  R30,LOW(35)
	ST   -Y,R30
	LDI  R30,LOW(0)
	CALL SUBOPT_0x13
;    8525 
;    8526 
;    8527 spi_write(RXF0SIDH, 0b00000000); 
	LDI  R30,LOW(0)
	ST   -Y,R30
	CALL _spi_write
;    8528 spi_write(RXF0SIDL, 0b00001000);
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R30,LOW(8)
	ST   -Y,R30
	CALL _spi_write
;    8529 spi_write(RXF0EID8, 0x00000000); 
	LDI  R30,LOW(2)
	CALL SUBOPT_0x1A9
;    8530 spi_write(RXF0EID0, 0b00000100);
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R30,LOW(4)
	ST   -Y,R30
	CALL _spi_write
;    8531 
;    8532 
;    8533 spi_write(RXM1SIDH, 0xff); 
	LDI  R30,LOW(36)
	CALL SUBOPT_0xD9
	CALL _spi_write
;    8534 spi_write(RXM1SIDL, 0xff); 
	LDI  R30,LOW(37)
	CALL SUBOPT_0xD9
	CALL _spi_write
;    8535 spi_write(RXM1EID8, 0xff); 
	LDI  R30,LOW(38)
	CALL SUBOPT_0xD9
	CALL _spi_write
;    8536 spi_write(RXM1EID0, 0xff);
	LDI  R30,LOW(39)
	CALL SUBOPT_0xD9
	CALL _spi_write
;    8537 
;    8538 delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    8539 
;    8540 
;    8541 
;    8542 spi_bit_modify(CANCTRL,0xe7,0b00000111);
	LDI  R30,LOW(15)
	ST   -Y,R30
	LDI  R30,LOW(231)
	ST   -Y,R30
	LDI  R30,LOW(7)
	ST   -Y,R30
	CALL _spi_bit_modify
;    8543 
;    8544 spi_write(CANINTE,0b00011111);
	LDI  R30,LOW(43)
	ST   -Y,R30
	LDI  R30,LOW(31)
	ST   -Y,R30
	CALL _spi_write
;    8545 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _delay_ms
;    8546 spi_write(BFPCTRL,0b00000000);  
	LDI  R30,LOW(12)
	CALL SUBOPT_0x1A9
;    8547 
;    8548 }       
	LD   R16,Y+
	RET
;    8549 
;    8550 
;    8551 //-----------------------------------------------
;    8552 void read_m8(void)
;    8553 {
;    8554 char i,temp_D,temp_P;
;    8555 DDRE|=0b11000000;
;	i -> R16
;	temp_D -> R17
;	temp_P -> R18
;    8556 temp_P=PORTA;
;    8557 temp_D=DDRA;
;    8558 
;    8559 DDRA=0;
;    8560 
;    8561 PORTE&=~(1<<6);
;    8562 delay_us(5);
;    8563 
;    8564 for(i=0;i<12;i++)
;    8565 	{
;    8566 	PORTE&=~(1<<7);
;    8567 	delay_us(25);
;    8568 	temp_m8[i]=PINA;
;    8569 	PORTE|=(1<<7);
;    8570 	delay_us(25);
;    8571 	}
;    8572 PORTE|=(1<<6);	
;    8573 
;    8574 if((temp_m8[7]==crc_87(temp_m8,7))&&(temp_m8[8]==crc_95(temp_m8,8)))
;    8575 	{
;    8576     //	plazma++;
;    8577 	*((char*)&unet_bank_[0])=temp_m8[0];
;    8578 	*(((char*)&unet_bank_[0])+1)=temp_m8[1];
;    8579 	*((char*)&unet_bank_[1])=temp_m8[2];
;    8580 	*(((char*)&unet_bank_[1])+1)=temp_m8[3];
;    8581 	*((char*)&unet_bank_[2])=temp_m8[4];
;    8582 	*(((char*)&unet_bank_[2])+1)=temp_m8[5];
;    8583 	cher_cnt=temp_m8[6];
;    8584 	} 
;    8585 
;    8586 DDRA=temp_D;
;    8587 PORTA=temp_P;	
;    8588 
;    8589 } 
;    8590 
;    8591 //-----------------------------------------------
;    8592 void m8_recive(void)
;    8593 {
_m8_recive:
;    8594 DDRE.7=1;
	SBI  0x2,7
;    8595 DDRE.6=0;
	CBI  0x2,6
;    8596 DDRA&=0b11110000;
	IN   R30,0x1A
	ANDI R30,LOW(0xF0)
	OUT  0x1A,R30
;    8597 
;    8598 
;    8599 bSTR_IN=PINE.6;
	CLT
	SBIC 0x1,6
	SET
	BLD  R4,7
;    8600 
;    8601 if(bSTR_IN!=bSTR_IN_OLD)
	LDI  R30,0
	SBRC R4,7
	LDI  R30,1
	PUSH R30
	LDI  R30,0
	SBRC R5,0
	LDI  R30,1
	POP  R26
	CP   R30,R26
	BRNE PC+3
	JMP _0xB19
;    8602 	{
;    8603 	if(!bSTR_IN)
	SBRC R4,7
	RJMP _0xB1A
;    8604 		{
;    8605 		m8_rx_buffer[m8_rx_cnt]&=0xf0;
	CALL SUBOPT_0x1AA
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0xF0)
	POP  R26
	POP  R27
	ST   X,R30
;    8606 		m8_rx_buffer[m8_rx_cnt]|=(PINA&0x0f);
	CALL SUBOPT_0x1AA
	PUSH R31
	PUSH R30
	LD   R30,Z
	PUSH R30
	IN   R30,0x19
	ANDI R30,LOW(0xF)
	POP  R26
	OR   R30,R26
	POP  R26
	POP  R27
	ST   X,R30
;    8607 		bSTR=bSTR_IN;
	BST  R4,7
	BLD  R5,1
;    8608 		}
;    8609 	else 
	RJMP _0xB1B
_0xB1A:
;    8610 		{
;    8611 		m8_rx_buffer[m8_rx_cnt]&=0x0f;
	CALL SUBOPT_0x1AA
	PUSH R31
	PUSH R30
	LD   R30,Z
	ANDI R30,LOW(0xF)
	POP  R26
	POP  R27
	ST   X,R30
;    8612 		m8_rx_buffer[m8_rx_cnt]|=((PINA&0x0f)<<4)&0xf0;
	CALL SUBOPT_0x1AA
	PUSH R31
	PUSH R30
	LD   R30,Z
	PUSH R30
	IN   R30,0x19
	ANDI R30,LOW(0xF)
	SWAP R30
	ANDI R30,0xF0
	ANDI R30,LOW(0xF0)
	POP  R26
	OR   R30,R26
	POP  R26
	POP  R27
	ST   X,R30
;    8613 		bSTR=bSTR_IN;
	BST  R4,7
	BLD  R5,1
;    8614 				
;    8615 		if((m8_rx_buffer[m8_rx_cnt]==0x0a)&&(m8_rx_cnt>=10)&&(crc_87(&m8_rx_buffer[m8_rx_cnt-10],8)==m8_rx_buffer[m8_rx_cnt-2])/*&&(crc_95(&m8_rx_buffer[m8_rx_cnt-9],8)==m8_rx_buffer[m8_rx_cnt-1])*/)
	CALL SUBOPT_0x1AA
	LD   R30,Z
	CPI  R30,LOW(0xA)
	BRNE _0xB1D
	LDS  R26,_m8_rx_cnt
	CPI  R26,LOW(0xA)
	BRLO _0xB1D
	CALL SUBOPT_0x1AB
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(8)
	ST   -Y,R30
	CALL _crc_87
	PUSH R30
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(2)
	CALL SUBOPT_0x1AC
	POP  R26
	CP   R30,R26
	BREQ _0xB1E
_0xB1D:
	RJMP _0xB1C
_0xB1E:
;    8616 			{ 
;    8617 			plazma_i[0]++;
	LDI  R26,LOW(_plazma_i)
	LDI  R27,HIGH(_plazma_i)
	CALL SUBOPT_0xD3
;    8618 			*((char*)&unet_bank_[0])=m8_rx_buffer[m8_rx_cnt-10];
	CALL SUBOPT_0x1AB
	LD   R30,Z
	STS  _unet_bank_,R30
;    8619 			*(((char*)&unet_bank_[0])+1)=m8_rx_buffer[m8_rx_cnt-9];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(9)
	CALL SUBOPT_0x1AC
	__PUTB1MN _unet_bank_,1
;    8620 			*((char*)&unet_bank_[1])=m8_rx_buffer[m8_rx_cnt-8];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(8)
	CALL SUBOPT_0x1AC
	__PUTB1MN _unet_bank_,2
;    8621 			*(((char*)&unet_bank_[1])+1)=m8_rx_buffer[m8_rx_cnt-7];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(7)
	CALL SUBOPT_0x1AC
	__PUTB1MN _unet_bank_,3
;    8622     			*((char*)&unet_bank_[2])=m8_rx_buffer[m8_rx_cnt-6];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(6)
	CALL SUBOPT_0x1AC
	__PUTB1MN _unet_bank_,4
;    8623     			*(((char*)&unet_bank_[2])+1)=m8_rx_buffer[m8_rx_cnt-5];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(5)
	CALL SUBOPT_0x1AC
	__PUTB1MN _unet_bank_,5
;    8624 			cher_cnt=m8_rx_buffer[m8_rx_cnt-4];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(4)
	CALL SUBOPT_0x1AC
	STS  _cher_cnt,R30
;    8625 			m8_main_cnt=m8_rx_buffer[m8_rx_cnt-3];
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(3)
	CALL SUBOPT_0x1AC
	STS  _m8_main_cnt,R30
;    8626 			m8_rx_cnt=0;
	LDI  R30,LOW(0)
	STS  _m8_rx_cnt,R30
;    8627 			}
;    8628 		else 
_0xB1C:
;    8629 			{
;    8630 
;    8631 			}
;    8632 		m8_rx_cnt++;
	LDS  R30,_m8_rx_cnt
	SUBI R30,-LOW(1)
	STS  _m8_rx_cnt,R30
;    8633 		if(m8_rx_cnt>=40)m8_rx_cnt=0;
	LDS  R26,_m8_rx_cnt
	CPI  R26,LOW(0x28)
	BRLO _0xB20
	LDI  R30,LOW(0)
	STS  _m8_rx_cnt,R30
;    8634 		}
_0xB20:
_0xB1B:
;    8635 		
;    8636 	}
;    8637 bSTR_IN_OLD=bSTR_IN;
_0xB19:
	BST  R4,7
	BLD  R5,0
;    8638 PORTE.7=bSTR;
	BST  R5,1
	IN   R30,0x3
	BLD  R30,7
	OUT  0x3,R30
;    8639 /*
;    8640 DDRA=0;
;    8641 
;    8642 PORTE&=~(1<<6);
;    8643 delay_us(5);
;    8644 
;    8645 for(i=0;i<12;i++)
;    8646 	{
;    8647 	PORTE&=~(1<<7);
;    8648 	delay_us(25);
;    8649 	temp_m8[i]=PINA;
;    8650 	PORTE|=(1<<7);
;    8651 	delay_us(25);
;    8652 	}
;    8653 PORTE|=(1<<6);	
;    8654 
;    8655 if((temp_m8[7]==crc_87(temp_m8,7))&&(temp_m8[8]==crc_95(temp_m8,8)))
;    8656 	{
;    8657 	plazma++;
;    8658 	*((char*)&unet_bank_[0])=temp_m8[0];
;    8659 	*(((char*)&unet_bank_[0])+1)=temp_m8[1];
;    8660 	*((char*)&unet_bank_[1])=temp_m8[2];
;    8661 	*(((char*)&unet_bank_[1])+1)=temp_m8[3];
;    8662 	*((char*)&unet_bank_[2])=temp_m8[4];
;    8663 	*(((char*)&unet_bank_[2])+1)=temp_m8[5];
;    8664 	cher_cnt=temp_m8[6];
;    8665 	} 
;    8666 
;    8667 DDRA=temp_D;
;    8668 PORTA=temp_P;*/	
;    8669 
;    8670 }
	RET
;    8671 
;    8672 //***********************************************
;    8673 //***********************************************
;    8674 //***********************************************
;    8675 // Timer 2 overflow interrupt service routine
;    8676 interrupt [TIM2_OVF] void timer2_ovf_isr(void)
;    8677 { 
_timer2_ovf_isr:
	CALL SUBOPT_0x1AD
;    8678 #asm("cli")
	cli
;    8679 TCCR2=0x03;
	LDI  R30,LOW(3)
	OUT  0x25,R30
;    8680 TCNT2=-122;
	LDI  R30,LOW(134)
	OUT  0x24,R30
;    8681 TIMSK|=0x40;
	CALL SUBOPT_0x96
;    8682 
;    8683 adc_drv();
	CALL _adc_drv
;    8684 
;    8685 #asm("sei")	
	sei
;    8686 
;    8687 }
	CALL SUBOPT_0x1AE
	RETI
;    8688 
;    8689 //***********************************************
;    8690 // Timer 0 overflow interrupt service routine
;    8691 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;    8692 {        
_timer0_ovf_isr:
	CALL SUBOPT_0x1AD
;    8693 t0_init();
	CALL _t0_init
;    8694 #asm("cli")
	cli
;    8695 if(++t0cnt000>=2)
	LDS  R26,_t0cnt000_G1
	SUBI R26,-LOW(1)
	STS  _t0cnt000_G1,R26
	CPI  R26,LOW(0x2)
	BRLO _0xB21
;    8696 	{
;    8697 	t0cnt000=0;
	LDI  R30,LOW(0)
	STS  _t0cnt000_G1,R30
;    8698 	mcp_drv();
	CALL _mcp_drv
;    8699 	}	
;    8700 #asm("sei") 
_0xB21:
	sei
;    8701 
;    8702 modbus_drv();
	CALL _modbus_drv
;    8703 
;    8704 m8_recive();
	CALL _m8_recive
;    8705 
;    8706 if(++t0cnt0_>=10)
	LDS  R26,_t0cnt0__G1
	SUBI R26,-LOW(1)
	STS  _t0cnt0__G1,R26
	CPI  R26,LOW(0xA)
	BRLO _0xB22
;    8707 	{
;    8708 	t0cnt0_=0;
	LDI  R30,LOW(0)
	STS  _t0cnt0__G1,R30
;    8709 	b100Hz=1;
	SET
	BLD  R2,3
;    8710 	
;    8711 	
;    8712 	if(++t0cnt0>=10)
	LDS  R26,_t0cnt0_G1
	SUBI R26,-LOW(1)
	STS  _t0cnt0_G1,R26
	CPI  R26,LOW(0xA)
	BRLO _0xB23
;    8713 		{
;    8714     		t0cnt0=0;
	STS  _t0cnt0_G1,R30
;    8715 		b10Hz=1;
	SET
	BLD  R2,4
;    8716 		if(++t0cnt1>=2)
	LDS  R26,_t0cnt1_G1
	SUBI R26,-LOW(1)
	STS  _t0cnt1_G1,R26
	CPI  R26,LOW(0x2)
	BRLO _0xB24
;    8717 	    		{
;    8718 	    		t0cnt1=0;
	STS  _t0cnt1_G1,R30
;    8719 			b5Hz=1;
	SET
	BLD  R2,5
;    8720 		
;    8721 			}
;    8722     		if(++t0cnt2>=5)
_0xB24:
	LDS  R26,_t0cnt2_G1
	SUBI R26,-LOW(1)
	STS  _t0cnt2_G1,R26
	CPI  R26,LOW(0x5)
	BRLO _0xB25
;    8723 			{
;    8724 			t0cnt2=0;
	LDI  R30,LOW(0)
	STS  _t0cnt2_G1,R30
;    8725 			b2Hz=1;
	SET
	BLD  R2,6
;    8726 			} 
;    8727 		if(++t0cnt3>=10)
_0xB25:
	LDS  R26,_t0cnt3_G1
	SUBI R26,-LOW(1)
	STS  _t0cnt3_G1,R26
	CPI  R26,LOW(0xA)
	BRLO _0xB26
;    8728 			{
;    8729 	    		t0cnt3=0;
	LDI  R30,LOW(0)
	STS  _t0cnt3_G1,R30
;    8730 			b1Hz=1;
	SET
	BLD  R2,7
;    8731   
;    8732 			}				
;    8733 		}	
_0xB26:
;    8734 	}
_0xB23:
;    8735 }
_0xB22:
	CALL SUBOPT_0x1AE
	RETI
;    8736 
;    8737 
;    8738 
;    8739 
;    8740 
;    8741 
;    8742 //===============================================
;    8743 //===============================================
;    8744 //===============================================
;    8745 //===============================================
;    8746 
;    8747 void main(void)
;    8748 {
_main:
;    8749 // Declare your local variables here
;    8750 char temp;
;    8751 unsigned temp_U; 
;    8752 /*
;    8753 modbus_buffer[0]=0x01;
;    8754 modbus_buffer[1]=0x0f;
;    8755 modbus_buffer[2]=0x00;
;    8756 modbus_buffer[3]=0x00;
;    8757 modbus_buffer[4]=0x00;
;    8758 modbus_buffer[5]=0x20;
;    8759 modbus_buffer[6]=0x04;
;    8760 modbus_buffer[7]=0x3c;
;    8761 modbus_buffer[8]=0x04;
;    8762 modbus_buffer[9]=0x00;
;    8763 modbus_buffer[10]=0x00;
;    8764 modbus_buffer[11]=0x00;
;    8765 modbus_buffer[12]=0x00;
;    8766 temp_U=crc16(modbus_buffer,11);
;    8767 modbus_buffer[11]=*(((char*)(&temp_U))+1);
;    8768 modbus_buffer[12]=*((char*)&temp_U);
;    8769 */
;    8770 
;    8771 // Reset Source checking
;    8772 if (MCUCSR & 1)
;	temp -> R16
;	temp_U -> R17,R18
	IN   R30,0x34
	ANDI R30,LOW(0x1)
	BREQ _0xB27
;    8773    {
;    8774    // Power-on Reset
;    8775    MCUCSR&=0xE0;
	CALL SUBOPT_0x1AF
;    8776    // Place your code here
;    8777 
;    8778    }
;    8779 else if (MCUCSR & 2)
	RJMP _0xB28
_0xB27:
	IN   R30,0x34
	ANDI R30,LOW(0x2)
	BREQ _0xB29
;    8780    {
;    8781    // External Reset
;    8782    MCUCSR&=0xE0;
	CALL SUBOPT_0x1AF
;    8783    // Place your code here
;    8784 
;    8785    }
;    8786 else if (MCUCSR & 4)
	RJMP _0xB2A
_0xB29:
	IN   R30,0x34
	ANDI R30,LOW(0x4)
	BREQ _0xB2B
;    8787    {
;    8788    // Brown-Out Reset
;    8789    MCUCSR&=0xE0;
	CALL SUBOPT_0x1AF
;    8790    // Place your code here
;    8791 
;    8792    }
;    8793 else if (MCUCSR & 8)
	RJMP _0xB2C
_0xB2B:
	IN   R30,0x34
	ANDI R30,LOW(0x8)
	BREQ _0xB2D
;    8794    {
;    8795    // Watchdog Reset
;    8796    MCUCSR&=0xE0;
	CALL SUBOPT_0x1AF
;    8797    // Place your code here
;    8798 
;    8799    }
;    8800 else if (MCUCSR & 0x10)
	RJMP _0xB2E
_0xB2D:
	IN   R30,0x34
	ANDI R30,LOW(0x10)
	BREQ _0xB2F
;    8801    {
;    8802    // JTAG Reset
;    8803    MCUCSR&=0xE0;
	CALL SUBOPT_0x1AF
;    8804    // Place your code here
;    8805 
;    8806    };
_0xB2F:
_0xB2E:
_0xB2C:
_0xB2A:
_0xB28:
;    8807 
;    8808  
;    8809 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;    8810 DDRA=0x00;
	OUT  0x1A,R30
;    8811 
;    8812 PORTB=0x01;
	LDI  R30,LOW(1)
	OUT  0x18,R30
;    8813 DDRB=0x00;
	LDI  R30,LOW(0)
	OUT  0x17,R30
;    8814 
;    8815 PORTC=0x00;
	OUT  0x15,R30
;    8816 DDRC=0x00;
	OUT  0x14,R30
;    8817 
;    8818 PORTD=0x00;
	OUT  0x12,R30
;    8819 DDRD=0x00;
	OUT  0x11,R30
;    8820 
;    8821 PORTE=0x01;
	LDI  R30,LOW(1)
	OUT  0x3,R30
;    8822 DDRE=0x00;
	LDI  R30,LOW(0)
	OUT  0x2,R30
;    8823 
;    8824 PORTF=0x00;
	STS  0x62,R30
;    8825 DDRF=0x00;
	STS  0x61,R30
;    8826 
;    8827 PORTG=0x00;
	STS  0x65,R30
;    8828 DDRG=0x00;
	STS  0x64,R30
;    8829 
;    8830 t0_init();
	CALL _t0_init
;    8831 // Timer/Counter 1 initialization
;    8832 // Clock source: System Clock
;    8833 // Clock value: Timer 1 Stopped
;    8834 // Mode: Normal top=FFFFh
;    8835 // OC1A output: Discon.
;    8836 // OC1B output: Discon.
;    8837 // OC1C output: Discon.
;    8838 // Noise Canceler: Off
;    8839 // Input Capture on Falling Edge
;    8840 TCCR1A=0x00;
	LDI  R30,LOW(0)
	OUT  0x2F,R30
;    8841 TCCR1B=0x00;
	OUT  0x2E,R30
;    8842 TCNT1H=0x00;
	OUT  0x2D,R30
;    8843 TCNT1L=0x00;
	OUT  0x2C,R30
;    8844 OCR1AH=0x00;
	OUT  0x2B,R30
;    8845 OCR1AL=0x00;
	OUT  0x2A,R30
;    8846 OCR1BH=0x00;
	OUT  0x29,R30
;    8847 OCR1BL=0x00;
	OUT  0x28,R30
;    8848 OCR1CH=0x00;
	STS  0x79,R30
;    8849 OCR1CL=0x00;
	STS  0x78,R30
;    8850 
;    8851 t2_init(); 
	CALL _t2_init
;    8852 	WDTCR=0x1F;
	LDI  R30,LOW(31)
	OUT  0x21,R30
;    8853 	WDTCR=0x0F;
	LDI  R30,LOW(15)
	OUT  0x21,R30
;    8854 #asm("wdr")
	wdr
;    8855 // Timer/Counter 3 initialization
;    8856 // Clock source: System Clock
;    8857 // Clock value: Timer 3 Stopped
;    8858 // Mode: Normal top=FFFFh
;    8859 // OC3A output: Discon.
;    8860 // OC3B output: Discon.
;    8861 // OC3C output: Discon.
;    8862 TCCR3A=0x00;
	LDI  R30,LOW(0)
	STS  0x8B,R30
;    8863 TCCR3B=0x00;
	STS  0x8A,R30
;    8864 TCNT3H=0x00;
	STS  0x89,R30
;    8865 TCNT3L=0x00;
	STS  0x88,R30
;    8866 OCR3AH=0x00;
	STS  0x87,R30
;    8867 OCR3AL=0x00;
	STS  0x86,R30
;    8868 OCR3BH=0x00;
	STS  0x85,R30
;    8869 OCR3BL=0x00;
	STS  0x84,R30
;    8870 OCR3CH=0x00;
	STS  0x83,R30
;    8871 OCR3CL=0x00;
	STS  0x82,R30
;    8872 
;    8873 // External Interrupt(s) initialization
;    8874 // INT0: Off
;    8875 // INT1: Off
;    8876 // INT2: Off
;    8877 // INT3: Off
;    8878 // INT4: Off
;    8879 // INT5: Off
;    8880 // INT6: Off
;    8881 // INT7: Off
;    8882 EICRA=0x00;
	STS  0x6A,R30
;    8883 EICRB=0x00;
	OUT  0x3A,R30
;    8884 EIMSK=0x00;
	OUT  0x39,R30
;    8885 
;    8886 // Timer(s)/Counter(s) Interrupt(s) initialization
;    8887 TIMSK=0x41;
	LDI  R30,LOW(65)
	OUT  0x37,R30
;    8888 ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  0x7D,R30
;    8889 
;    8890 // Analog Comparator initialization
;    8891 // Analog Comparator: Off
;    8892 // Analog Comparator Input Capture by Timer/Counter 1: Off
;    8893 // Analog Comparator Output: Off
;    8894 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;    8895 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x20,R30
;    8896 
;    8897 
;    8898 
;    8899 // USART0 initialization
;    8900 // Communication Parameters: 8 Data, 2 Stop, No Parity
;    8901 // USART0 Receiver: On
;    8902 // USART0 Transmitter: On
;    8903 // USART0 Mode: Asynchronous
;    8904 // USART0 Baud rate: 9600
;    8905 UCSR0A=0x00;
	OUT  0xB,R30
;    8906 UCSR0B=0xD8;
	LDI  R30,LOW(216)
	OUT  0xA,R30
;    8907 UCSR0C=0x0E;
	LDI  R30,LOW(14)
	STS  0x95,R30
;    8908 /*UBRR0H=0x06;
;    8909 UBRR0L=0x82; //300*/
;    8910 /*UBRR0H=0x03;
;    8911 UBRR0L=0x40;//600*/
;    8912 /*UBRR0H=0x01;
;    8913 UBRR0L=0xA0;//1200*/
;    8914 /*UBRR0H=0x00;
;    8915 UBRR0L=0xCF;//2400 */
;    8916 UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  0x90,R30
;    8917 UBRR0L=0x67;//4800 
	LDI  R30,LOW(103)
	OUT  0x9,R30
;    8918 
;    8919 #asm("sei")  
	sei
;    8920 #asm("wdr")
	wdr
;    8921 can_init();
	CALL _can_init
;    8922 write_ds14287(REGISTER_A,0x20);
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R30,LOW(32)
	ST   -Y,R30
	CALL _write_ds14287
;    8923 write_ds14287(REGISTER_B,read_ds14287(REGISTER_B)|0x06);
	LDI  R30,LOW(11)
	ST   -Y,R30
	ST   -Y,R30
	CALL _read_ds14287
	ORI  R30,LOW(0x6)
	ST   -Y,R30
	CALL _write_ds14287
;    8924 ind=iAv_sel; 
	CALL SUBOPT_0x138
;    8925 //ind=iDeb;
;    8926 sub_ind=0;
;    8927 index_set=0; 
	LDI  R30,LOW(0)
	STS  _index_set,R30
;    8928 #asm("wdr")
	wdr
;    8929 /*EE_LEVEL[3]=75;
;    8930 EE_LEVEL[2]=60;
;    8931 EE_LEVEL[1]=50;
;    8932 EE_LEVEL[0]=20;*/
;    8933 
;    8934 //av_hndl(0x2a,0,0);
;    8935 
;    8936 //RESURS_CNT[0]=6;
;    8937 //RESURS_CNT[1]=8;
;    8938 //pilot_dv=0;
;    8939 
;    8940 
;    8941 /*
;    8942 EE_MODE=emMNL;
;    8943 TEMPER_SIGN=0;
;    8944 AV_TEMPER_COOL=10;
;    8945 T_ON_WARM=15;
;    8946 T_ON_COOL=40;
;    8947 AV_TEMPER_HEAT=50;
;    8948 TEMPER_GIST=5;
;    8949 AV_NET_PERCENT=10;
;    8950 fasing=f_ABC;
;    8951 P_SENS=6;
;    8952 P_MIN=10;
;    8953 P_MAX=20;
;    8954 T_MAXMIN=5;
;    8955 G_MAXMIN=5;
;    8956 EE_DV_NUM=3;
;    8957 STAR_TRIAN=stON;
;    8958 DV_MODE[0]=dm_AVT;
;    8959 DV_MODE[1]=dm_AVT;
;    8960 DV_MODE[2]=dm_AVT;
;    8961 RESURS_CNT[0]=0;
;    8962 RESURS_CNT[1]=0;
;    8963 RESURS_CNT[2]=0;
;    8964 */
;    8965 
;    8966 
;    8967 /*
;    8968 //Переменные в EEPROM 
;    8969 eeprom enum {dm_AVT=0x55,dm_MNL=0xAA};		//режимы работы насосов
;    8970 eeprom unsigned int RESURS_CNT[6];					//Счетчики моторесурса насосов
;    8971 eeprom signed Idmin;							//Ток насоса минимальный 
;    8972 eeprom signed Idmax;							//Ток насоса максимальный 
;    8973 eeprom signed Kida[6],Kidc[6]; 					//Калибровка токов двигателей
;    8974 eeprom signed C1N;								//_____________________
;    8975 eeprom signed DV_DUMM[10];
;    8976 
;    8977 eeprom signed SS_LEVEL;							//Ступенчатый пуск - 
;    8978 eeprom signed SS_STEP;							//Ступенчатый пуск -
;    8979 eeprom signed SS_TIME;							//Ступенчатый пуск -
;    8980 eeprom signed SS_FRIQ;							//Ступенчатый пуск -
;    8981 eeprom signed SS_DUMM[10];
;    8982 
;    8983 eeprom signed DVCH_T_UP;							//Переключение насосов - 
;    8984 eeprom signed DVCH_T_DOWN;						//Переключение насосов -
;    8985 eeprom signed DVCH_P_KR;							//Переключение насосов -
;    8986 eeprom signed DVCH_KP;							//Переключение насосов -
;    8987 eeprom signed DVCH_TIME;							//Переключение насосов - 
;    8988 eeprom enum {dvch_ON=0x55,dvch_OFF=0xAA}DVCH;		//Переключение насосов - 
;    8989 eeprom signed DVCH_DUMM[10];
;    8990 
;    8991 eeprom signed FP_FMIN;							//Частотный преобразователь - минимальная частота
;    8992 eeprom signed FP_FMAX;							//Частотный преобразователь - максимальная частота  
;    8993 eeprom signed FP_TPAD;							//Частотный преобразователь - 
;    8994 eeprom signed FP_TVOZVR;							//Частотный преобразователь -  
;    8995 eeprom signed FP_CH; 							//Частотный преобразователь - 
;    8996 eeprom signed FP_P_PL;							//Частотный преобразователь - 
;    8997 eeprom signed FP_P_MI;							//Частотный преобразователь - 
;    8998 eeprom signed FP_DUMM[10];
;    8999 
;    9000 eeprom enum {dON=0x55,dOFF=0xAA}DOOR;				//Задвижка - 
;    9001 eeprom signed DOOR_IMIN;							//Задвижка - 
;    9002 eeprom signed DOOR_IMAX;							//Задвижка -
;    9003 eeprom enum {dmS=0x55,dmA=0xAA}DOOR_MODE;			//Задвижка -
;    9004 eeprom signed DOOR_DUMM[10];
;    9005 
;    9006 eeprom enum {pON=0x55,pOFF=0xAA}PROBE;				//Пробный пуск - 
;    9007 eeprom signed PROBE_DUTY;						//Пробный пуск -
;    9008 eeprom signed PROBE_TIME;						//Пробный пуск -
;    9009 eeprom signed PROBE_DUMM[10];
;    9010 
;    9011 eeprom enum {hhWMS=0x55}HH_SENS;					//Сухой ход - 
;    9012 eeprom signed HH_P;								//Сухой ход - 
;    9013 eeprom signed HH_TIME;					    		//Сухой ход - 
;    9014 eeprom signed HH_DUMM[10];
;    9015 
;    9016 eeprom signed ZL_TIME;					    		//Нулевая нагрузка - 
;    9017 eeprom signed ZL_DUMM[10];       
;    9018 
;    9019 eeprom signed  ;
;    9020 */
;    9021 //p_ust=200;
;    9022 
;    9023 
;    9024 while (1)
_0xB30:
;    9025 	{
;    9026 	static char tr_ind_cnt;

	.DSEG
_tr_ind_cnt_S6C:
	.BYTE 0x1

	.CSEG
;    9027 	#asm("wdr")
	wdr
;    9028 	if(bModbus_in)
	SBRS R4,0
	RJMP _0xB33
;    9029 		{
;    9030 		
;    9031 		bModbus_in=0;
	CLT
	BLD  R4,0
;    9032 		modbus_in_an();
	CALL _modbus_in_an
;    9033 		}
;    9034 	if(b100Hz)
_0xB33:
	SBRS R2,3
	RJMP _0xB34
;    9035 		{
;    9036 		b100Hz=0;
	CLT
	BLD  R2,3
;    9037 		can_hndl();
	CALL _can_hndl
;    9038 		//ind_transmit_hndl();
;    9039 		but_drv();
	CALL _but_drv
;    9040 
;    9041 		}	   
;    9042 	if(b10Hz)
_0xB34:
	SBRS R2,4
	RJMP _0xB35
;    9043 		{
;    9044 		
;    9045 		b10Hz=0;
	CLT
	BLD  R2,4
;    9046 		
;    9047 		//Подпрограммы исполняемые 10 раз в секунду 
;    9048 		rel_in_drv();  
	CALL _rel_in_drv
;    9049 		
;    9050 	          if(++tr_ind_cnt>=4)tr_ind_cnt=0;
	LDS  R26,_tr_ind_cnt_S6C
	SUBI R26,-LOW(1)
	STS  _tr_ind_cnt_S6C,R26
	CPI  R26,LOW(0x4)
	BRLO _0xB36
	LDI  R30,LOW(0)
	STS  _tr_ind_cnt_S6C,R30
;    9051 		can_out_adr(0b11110000+tr_ind_cnt,0b00000000,&data_for_ind[10*tr_ind_cnt]); 
_0xB36:
	LDS  R30,_tr_ind_cnt_S6C
	SUBI R30,-LOW(240)
	CALL SUBOPT_0x1B0
	LDS  R30,_tr_ind_cnt_S6C
	LDI  R26,LOW(10)
	MUL  R30,R26
	MOV  R30,R0
	LDI  R31,0
	SUBI R30,LOW(-_data_for_ind)
	SBCI R31,HIGH(-_data_for_ind)
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9052           
;    9053 		mode_hndl();
	CALL _mode_hndl
;    9054 		power_hndl(); 
	CALL _power_hndl
;    9055 		fp_hndl();
	CALL _fp_hndl
;    9056 		av_hh_drv();
	CALL _av_hh_drv
;    9057 		pid_drv();
	CALL _pid_drv
;    9058 		
;    9059 		p_max_min_hndl();
	CALL _p_max_min_hndl
;    9060 		p_kr_drv();
	CALL _p_kr_drv
;    9061 		
;    9062 		if(bCAN_EX)
	SBRS R4,6
	RJMP _0xB37
;    9063           	{
;    9064           	can_out_adr(0b00000000,0b00000000,&data_for_ex[0,0]); 
	CALL SUBOPT_0x149
	LDI  R30,LOW(_data_for_ex)
	LDI  R31,HIGH(_data_for_ex)
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9065           	bCAN_EX=0;
	CLT
	BLD  R4,6
;    9066           	}
;    9067 	    else 
	RJMP _0xB38
_0xB37:
;    9068 	    		{
;    9069 	    		can_out_adr(0b00000001,0b00000000,&data_for_ex[1,0]);
	LDI  R30,LOW(1)
	CALL SUBOPT_0x1B0
	__POINTW1MN _data_for_ex,10
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9070                bCAN_EX=1;
	SET
	BLD  R4,6
;    9071                }
_0xB38:
;    9072 		} 
;    9073 		#asm("wdr")	
_0xB35:
	wdr
;    9074 	if(b5Hz)
	SBRS R2,5
	RJMP _0xB39
;    9075 		{
;    9076 		b5Hz=0;
	CLT
	BLD  R2,5
;    9077           
;    9078           //Подпрограммы исполняемые 5 раз в секунду
;    9079           out_drv();                    //Вывод на реле
	CALL _out_drv
;    9080           adc_mat_hndl();               //Драйвер АЦП, цифровая фильтрация измеренных величин
	CALL _adc_mat_hndl
;    9081          	matemat();				//Математическая обработка измеренных АЦП величин
	CALL _matemat
;    9082 		cool_warm_drv();			//управление отопителем и охладителем
	CALL _cool_warm_drv
;    9083 		avar_i_drv();                 //драйвер аварий по току
	CALL _avar_i_drv
;    9084 		avar_drv();                   //драйвер аварий
	CALL _avar_drv
;    9085 		serv_drv();				//действия в режиме сервиса(сброс аварий)
	CALL _serv_drv
;    9086 		//can_init();
;    9087 		
;    9088 		motor_potenz_hndl();		//Определение насоса, выключаемого или(и) включаемого 
	CALL _motor_potenz_hndl
;    9089 		control();				//Включение и выключение насосов  
	CALL _control
;    9090 		plata_ex_hndl();
	CALL _plata_ex_hndl
;    9091 	    	
;    9092 		
;    9093 	    
;    9094 		dv_access_hndl();
	CALL _dv_access_hndl
;    9095 		//ptr_tx_rd=0;
;    9096 	    	//can_out_adr(0b11110000,0b00000000,&data_for_ind[0]);
;    9097 	    	/*can_out_adr(0b11110001,0b00000000,&data_for_ind[10]);
;    9098 	    	can_out_adr(0b11110010,0b00000000,&data_for_ind[20]);*/
;    9099 	    	//can_out_adr(0b11110011,0b00000000,&data_for_ind[30]);
;    9100 
;    9101 		ind_hndl();    			//обработка индикации для пульта
	CALL _ind_hndl
;    9102           plata_ind_hndl();             //обработка индикации для платы индикации 
	CALL _plata_ind_hndl
;    9103 	    	
;    9104 	    	can_out_adr(0xfc,0x00,lcd_buffer);
	LDI  R30,LOW(252)
	CALL SUBOPT_0x1B0
	LDI  R30,LOW(_lcd_buffer)
	LDI  R31,HIGH(_lcd_buffer)
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9105 	    	can_out_adr(0xfd,0x00,lcd_buffer+10);
	LDI  R30,LOW(253)
	CALL SUBOPT_0x1B0
	__POINTW1MN _lcd_buffer,10
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9106 	    	can_out_adr(0xfe,0x00,lcd_buffer+20);
	LDI  R30,LOW(254)
	CALL SUBOPT_0x1B0
	__POINTW1MN _lcd_buffer,20
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9107 	    	can_out_adr(0xff,0x00,lcd_buffer+30); 
	LDI  R30,LOW(255)
	CALL SUBOPT_0x1B0
	__POINTW1MN _lcd_buffer,30
	ST   -Y,R31
	ST   -Y,R30
	CALL _can_out_adr
;    9108 	    	
;    9109 
;    9110 	   //	set_kalibr_blok_drv();		//обработка джампера, непускающего в установки и калибровки
;    9111           ret_ind_hndl();
	CALL _ret_ind_hndl
;    9112           
;    9113           av_sens_p_hndl();
	CALL _av_sens_p_hndl
;    9114           av_fp_hndl();
	CALL _av_fp_hndl
;    9115           //read_m8();
;    9116           
;    9117 		}
;    9118 		#asm("wdr")
_0xB39:
	wdr
;    9119 	if(b2Hz)
	SBRS R2,6
	RJMP _0xB3A
;    9120 		{
;    9121 		b2Hz=0;
	CLT
	BLD  R2,6
;    9122 		ds14287_drv();
	CALL _ds14287_drv
;    9123                                                        
;    9124 		}  
;    9125 		#asm("wdr")								
_0xB3A:
	wdr
;    9126 	if(b1Hz)
	SBRS R2,7
	RJMP _0xB3B
;    9127 		{
;    9128 		b1Hz=0;
	CLT
	BLD  R2,7
;    9129           
;    9130 		//Подпрограммы исполняемые 1 раз в секунду
;    9131 		if(main_cnt<100)main_cnt++;   //Счетчик секунд от начала работы, досчитывает до 100
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x64)
	LDI  R30,HIGH(0x64)
	CPC  R27,R30
	BRSH _0xB3C
	LDS  R30,_main_cnt
	LDS  R31,_main_cnt+1
	ADIW R30,1
	STS  _main_cnt,R30
	STS  _main_cnt+1,R31
;    9132 		out_hndl();				//Включение и выключение насосов, реле аварии, вентилятора и отопителя
_0xB3C:
	CALL _out_hndl
;    9133 
;    9134 		resurs_drv();				//Подсчёт ресурса(наработки) насосов
	CALL _resurs_drv
;    9135           
;    9136           
;    9137           
;    9138           
;    9139           //out_usart0(9,1,2,3,4,5,6,7,8,9);
;    9140           
;    9141           num_necc_drv();     		//Расчёт количества необходимых насосов
	CALL _num_necc_drv
;    9142           modbus_request_hndl();
	CALL _modbus_request_hndl
;    9143           
;    9144           time_sezon_drv(); 
	CALL _time_sezon_drv
;    9145           p_ust_hndl();
	CALL _p_ust_hndl
;    9146           
;    9147           pilot_ch_hndl();
	CALL _pilot_ch_hndl
;    9148           zl_hndl();
	CALL _zl_hndl
;    9149 		} 
;    9150 		#asm("wdr")
_0xB3B:
	wdr
;    9151 	}
	RJMP _0xB30
;    9152 }
_0xB3D:
	RJMP _0xB3D
;    9153 
;    9154 /*		tr_ind_cnt++;
;    9155 		if(tr_ind_cnt==25)tr_ind_cnt=0;
;    9156 		
;    9157 		if(tr_ind_cnt==0)can_out_adr(0b00000000,0b00000000,&data_for_ex[0,0]);
;    9158           else if(tr_ind_cnt==3)can_out_adr(0xfc,0x00,lcd_buffer);
;    9159           else if(tr_ind_cnt==6)can_out_adr(0b11110000,0b00000000,&data_for_ind[0]);
;    9160           else if(tr_ind_cnt==9)can_out_adr(0xfc,0x00,lcd_buffer+10);
;    9161           else if(tr_ind_cnt==12)can_out_adr(0b11110001,0b00000000,&data_for_ind[10]);
;    9162           else if(tr_ind_cnt==15)can_out_adr(0xfc,0x00,lcd_buffer+20);
;    9163           else if(tr_ind_cnt==18)can_out_adr(0b11110010,0b00000000,&data_for_ind[20]);
;    9164           else if(tr_ind_cnt==21)can_out_adr(0xfc,0x00,lcd_buffer+30);
;    9165 
;    9166  */
;    9167 
;    9168 
_putchar:
     sbis usr,udre
     rjmp _putchar
     ld   r30,y
     out  udr,r30
	ADIW R28,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x0:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R26,X
	LDD  R30,Y+1
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1:
	LD   R30,Y
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R26,X
	LD   R30,Y
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3:
	LDD  R30,Y+1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4:
	MOVW R26,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5:
	MOVW R26,R30
	LD   R30,Y
	LDD  R31,Y+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6:
	LDS  R30,100
	ORI  R30,2
	STS  100,R30
	LDS  R30,101
	ORI  R30,2
	STS  101,R30
	LDS  R30,100
	ORI  R30,1
	STS  100,R30
	LDS  R30,101
	ORI  R30,1
	STS  101,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7:
	LDI  R30,LOW(255)
	OUT  0x14,R30
	LDD  R30,Y+1
	OUT  0x15,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x8:
	LDS  R30,100
	ORI  R30,1
	STS  100,R30
	LDS  R30,101
	ANDI R30,0xFE
	STS  101,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x9:
	LDI  R30,LOW(80)
	OUT  0xD,R30
	LDI  R30,LOW(0)
	OUT  0xE,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xA:
	ST   -Y,R30
	CALL _spi
	LDD  R30,Y+1
	ST   -Y,R30
	JMP  _spi

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB:
	LDI  R30,LOW(85)
	ST   -Y,R30
	CALL _spi
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xC:
	ST   -Y,R30
	CALL _spi
	LDD  R30,Y+2
	RJMP SUBOPT_0xA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD:
	LD   R30,Y
	ST   -Y,R30
	JMP  _spi

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _spi_bit_modify

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xF:
	LDS  R30,_ptr_rx_wr
	LDI  R26,LOW(_fifo_can_in)
	LDI  R27,HIGH(_fifo_can_in)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10:
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x11:
	LDS  R30,_ptr_tx_rd
	LDI  R26,LOW(_fifo_can_out)
	LDI  R27,HIGH(_fifo_can_out)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x12:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x13:
	ST   -Y,R30
	CALL _spi_write
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x14:
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,1
	ST   Y,R26
	STD  Y+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0x15:
	ST   X,R30
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16:
	SBIW R28,1
	LDI  R30,LOW(0)
	ST   Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x17:
	LD   R30,Y
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0x18:
	LD   R30,Y
	SUBI R30,-LOW(1)
	ST   Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x19:
	LDS  R30,_modbus_in_len
	SUBI R30,LOW(2)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1A:
	ST   -Y,R31
	ST   -Y,R30
	CALL _crc16
	__PUTW1R 16,17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1B:
	LDI  R31,0
	SUBI R30,LOW(-_modbus_in_buffer)
	SBCI R31,HIGH(-_modbus_in_buffer)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1C:
	LDS  R30,_modbus_out_ptr_rd
	SUBI R30,-LOW(1)
	STS  _modbus_out_ptr_rd,R30
	LDS  R26,_modbus_out_ptr_rd
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x1D:
	LDS  R30,_modbus_out_ptr_rd
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1E:
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R18
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES
SUBOPT_0x1F:
	LDS  R30,_modbus_out_ptr_rd_old
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x20:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x21:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,4
	LD   R30,Z
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0x22:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,5
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x23:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,2
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES
SUBOPT_0x24:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,3
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES
SUBOPT_0x25:
	CLR  R31
	CLR  R22
	CLR  R23
	__GETD2S 3
	CALL __ADDD12
	__PUTD1S 3
	__GETD2S 3
	LDI  R30,LOW(8)
	CALL __LSLD12
	__PUTD1S 3
	LDD  R30,Y+3
	ANDI R30,LOW(0xFFFFFF00)
	STD  Y+3,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x26:
	CLR  R31
	CLR  R22
	CLR  R23
	__GETD2S 3
	CALL __ADDD12
	__PUTD1S 3
	__GETD2S 3
	__GETD1N 0x3E8
	CALL __DIVD21U
	__PUTD1S 3
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x27:
	CLR  R31
	CLR  R22
	CLR  R23
	__GETD2S 3
	CALL __ADDD12
	__PUTD1S 3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x28:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   X+,R30
	ST   X,R31
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x29:
	__GETW1R 10,11
	ADIW R30,1
	__PUTW1R 10,11
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x2A:
	__GETD2S 3
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ADDD12
	__PUTD1S 3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x2B:
	SBIW R30,1
	__PUTW1R 16,17
	LDS  R30,_modbus_out_ptr_wr
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x2C:
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(2)
	ST   X,R30
	LDS  R30,_modbus_out_ptr_wr
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x2D:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 22 TIMES
SUBOPT_0x2E:
	ST   X,R30
	LDS  R30,_modbus_out_ptr_wr
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x2F:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,2
	MOVW R26,R30
	ST   X,R17
	LDS  R30,_modbus_out_ptr_wr
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x30:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,3
	MOVW R26,R30
	ST   X,R16
	LDS  R30,_modbus_out_ptr_wr
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x31:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,4
	MOVW R26,R30
	LDI  R30,LOW(0)
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x32:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,5
	MOVW R26,R30
	LDI  R30,LOW(32)
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x33:
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	RJMP SUBOPT_0x1A

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x34:
	LDS  R30,_modbus_out_ptr_wr
	LDI  R26,LOW(_modbus_out_buffer)
	LDI  R27,HIGH(_modbus_out_buffer)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x35:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,6
	MOVW R26,R30
	ST   X,R17
	RJMP SUBOPT_0x34

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x36:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,7
	MOVW R26,R30
	ST   X,R16
	LDS  R26,_modbus_out_ptr_wr
	LDI  R27,0
	SUBI R26,LOW(-_modbus_out_len)
	SBCI R27,HIGH(-_modbus_out_len)
	LDI  R30,LOW(8)
	ST   X,R30
	LDS  R30,_modbus_out_ptr_wr
	SUBI R30,-LOW(1)
	STS  _modbus_out_ptr_wr,R30
	LDS  R26,_modbus_out_ptr_wr
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x37:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,6
	MOVW R26,R30
	LDI  R30,LOW(4)
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x38:
	MOVW R26,R30
	LDD  R30,Y+4
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x39:
	MOVW R26,R30
	LDD  R30,Y+5
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3A:
	MOVW R26,R30
	LDD  R30,Y+2
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3B:
	MOVW R26,R30
	LDD  R30,Y+3
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3C:
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	RJMP SUBOPT_0x1A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3D:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,11
	MOVW R26,R30
	ST   X,R17
	RJMP SUBOPT_0x34

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3E:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,12
	MOVW R26,R30
	ST   X,R16
	LDS  R26,_modbus_out_ptr_wr
	LDI  R27,0
	SUBI R26,LOW(-_modbus_out_len)
	SBCI R27,HIGH(-_modbus_out_len)
	LDI  R30,LOW(13)
	ST   X,R30
	LDS  R30,_modbus_out_ptr_wr
	SUBI R30,-LOW(1)
	STS  _modbus_out_ptr_wr,R30
	LDS  R26,_modbus_out_ptr_wr
	CPI  R26,LOW(0xA)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3F:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MULW12U
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x40:
	LDD  R30,Y+1
	SUBI R30,-LOW(1)
	STD  Y+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x41:
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_modbus_out_ptr_rd
	LDI  R31,0
	SUBI R30,LOW(-_modbus_out_len)
	SBCI R31,HIGH(-_modbus_out_len)
	LD   R30,Z
	ST   -Y,R30
	JMP  _modbus_out

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x42:
	LDI  R30,0
	STS  _pid_cnt,R30
	STS  _pid_cnt+1,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	STS  _e,R30
	STS  _e+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0x43:
	LDI  R30,LOW(4)
	ST   -Y,R30
	JMP  _read_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x44:
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _read_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x45:
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _read_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x46:
	LDI  R30,LOW(7)
	ST   -Y,R30
	JMP  _read_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x47:
	LDI  R30,LOW(8)
	ST   -Y,R30
	JMP  _read_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x48:
	LDI  R30,LOW(9)
	ST   -Y,R30
	JMP  _read_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x49:
	LDI  R26,LOW(_ZL_TIME)
	LDI  R27,HIGH(_ZL_TIME)
	CALL __EEPROMRDW
	LDS  R26,_zl_cnt
	LDS  R27,_zl_cnt+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x4A:
	CLR  R22
	CLR  R23
	__PUTD1S 0
	__GETD2S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x4B:
	CALL __MULD12
	__PUTD1S 0
	__GETD2S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 48 TIMES
SUBOPT_0x4C:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4D:
	LDS  R26,_av_sens_p_hndl_cnt
	LDI  R30,LOW(25)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4E:
	LDS  R26,_av_sens_p_hndl_cnt
	LDI  R30,LOW(0)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x4F:
	LDS  R26,_p
	LDS  R27,_p+1
	__GETW1R 8,9
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x50:
	LDI  R26,LOW(_SS_LEVEL)
	LDI  R27,HIGH(_SS_LEVEL)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x51:
	LDI  R30,LOW(34)
	STS  _mode,R30
	JMP  _pid_start

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x52:
	LDS  R30,_cnt_control_blok1
	LDS  R31,_cnt_control_blok1+1
	SBIW R30,1
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R31
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x53:
	LDS  R26,_power
	LDS  R27,_power+1
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x54:
	LDS  R26,_power
	LDS  R27,_power+1
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __MODW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x55:
	LDI  R26,LOW(_DVCH_T_UP)
	LDI  R27,HIGH(_DVCH_T_UP)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	STS  _cnt_control_blok1,R30
	STS  _cnt_control_blok1+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x56:
	LDI  R30,LOW(129)
	STS  _fp_stat,R30
	LDI  R30,0
	STS  _fp_poz,R30
	STS  _fp_poz+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x57:
	__GETD1N 0x64
	CALL __DIVD21
	__PUTD1S 0
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x58:
	LDI  R26,LOW(_DVCH_P_KR)
	LDI  R27,HIGH(_DVCH_P_KR)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x59:
	LDI  R26,LOW(_HH_TIME)
	LDI  R27,HIGH(_HH_TIME)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	LDS  R26,_hh_av_cnt
	LDS  R27,_hh_av_cnt+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x5A:
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP SUBOPT_0x4C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5B:
	SUBI R30,LOW(-_dv_on)
	SBCI R31,HIGH(-_dv_on)
	LD   R30,Z
	CPI  R30,LOW(0x66)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5C:
	CALL __MULD12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0xA
	CALL __DIVD21
	__GETD2S 0
	CALL __ADDD12
	__PUTD1S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x5D:
	LDI  R30,LOW(4)
	ST   -Y,R30
	ST   -Y,R16
	JMP  _write_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x5E:
	LDI  R30,LOW(7)
	ST   -Y,R30
	ST   -Y,R16
	JMP  _write_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5F:
	LDI  R30,LOW(8)
	ST   -Y,R30
	ST   -Y,R16
	CALL _write_ds14287
	RJMP SUBOPT_0x48

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x60:
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL _read_ds14287
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x61:
	ST   -Y,R30
	ST   -Y,R16
	JMP  _write_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x62:
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x63:
	LDI  R30,LOW(204)
	LDI  R31,HIGH(204)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _read_vlt_register

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x64:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _read_vlt_register

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0x65:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x66:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	__GETW1R 16,17
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x67:
	LD   R30,Y
	LDI  R26,LOW(_timer_time1)
	LDI  R27,HIGH(_timer_time1)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x68:
	CALL __EEPROMRDW
	LDS  R26,_CURR_TIME
	LDS  R27,_CURR_TIME+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x69:
	LD   R30,Y
	LDI  R26,LOW(_timer_time2)
	LDI  R27,HIGH(_timer_time2)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x6A:
	CALL __EEPROMRDW
	LDS  R26,_CURR_TIME
	LDS  R27,_CURR_TIME+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6B:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,2
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6C:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,4
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6D:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,6
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6E:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,8
	MOVW R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6F:
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_day_period
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x70:
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDB
	CPI  R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x71:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x72:
	__GETW1R 8,9
	CALL __CWD1
	__PUTD1S 0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x73:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_lcd_buffer)
	SBCI R31,HIGH(-_lcd_buffer)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x74:
	ST   -Y,R30
	CALL _find
	MOV  R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x75:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x76:
	MOV  R30,R16
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x77:
	SUBI R30,-LOW(1)
	ST   -Y,R30
	JMP  _bcd2lcd_zero

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES
SUBOPT_0x78:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x79:
	MOV  R30,R17
	SUBI R30,-LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_dig)
	SBCI R31,HIGH(-_dig)
	LD   R30,Z
	CPI  R30,LOW(0x20)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x7A:
	MOV  R30,R16
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_lcd_buffer)
	SBCI R31,HIGH(-_lcd_buffer)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x7B:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_lcd_buffer)
	SBCI R27,HIGH(-_lcd_buffer)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7C:
	LDI  R30,LOW(46)
	ST   X,R30
	RJMP SUBOPT_0x7A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7D:
	ST   -Y,R17
	ST   -Y,R16
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	ST   -Y,R31
	ST   -Y,R30
	CALL _bin2bcd_int
	LDD  R30,Y+2
	RJMP SUBOPT_0x77

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7E:
	ANDI R30,LOW(0x3)
	MOV  R26,R30
	LDI  R30,LOW(16)
	MUL  R30,R26
	MOV  R30,R0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x7F:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x80:
	LDS  R30,_num_wrks_old
	SUBI R30,-LOW(1)
	STS  _num_wrks_old,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x81:
	LDS  R30,_num_wrks_new
	SUBI R30,-LOW(1)
	STS  _num_wrks_new,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x82:
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x83:
	LDI  R30,LOW(129)
	STS  _dv_on,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x84:
	LDI  R26,LOW(_pilot_dv)
	LDI  R27,HIGH(_pilot_dv)
	CALL __EEPROMRDW
	SUBI R30,LOW(-_dv_on)
	SBCI R31,HIGH(-_dv_on)
	MOVW R26,R30
	LDI  R30,LOW(102)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x85:
	LDS  R30,_num_wrks_new
	LDS  R26,_num_necc
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x86:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	LDS  R26,_potenz
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x87:
	LDS  R26,_potenz
	LDI  R27,0
	SUBI R26,LOW(-_dv_on)
	SBCI R27,HIGH(-_dv_on)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x88:
	LDS  R30,_num_wrks_new
	LDS  R26,_num_necc
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x89:
	LDS  R26,_potenz_off
	LDI  R27,0
	SUBI R26,LOW(-_dv_on)
	SBCI R27,HIGH(-_dv_on)
	LDI  R30,LOW(129)
	ST   X,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	STS  _cnt_control_blok,R30
	STS  _cnt_control_blok+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x8A:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_serv)
	SBCI R31,HIGH(-_av_serv)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x8B:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_av_i_dv_min)
	SBCI R27,HIGH(-_av_i_dv_min)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0x8C:
	LDI  R30,LOW(170)
	ST   X,R30
	MOV  R26,R16
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x8D:
	SUBI R26,LOW(-_av_id_min_cnt)
	SBCI R27,HIGH(-_av_id_min_cnt)
	LDI  R30,LOW(0)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x8E:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_av_id_max_cnt)
	SBCI R27,HIGH(-_av_id_max_cnt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x8F:
	LDI  R30,LOW(0)
	ST   X,R30
	MOV  R26,R16
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 28 TIMES
SUBOPT_0x90:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x91:
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
	MOV  R30,R16
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x92:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_popl_cnt_p)
	SBCI R31,HIGH(-_popl_cnt_p)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x93:
	LDI  R30,LOW(10)
	ST   -Y,R30
	JMP  _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x94:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_rel_in_st)
	SBCI R27,HIGH(-_rel_in_st)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x95:
	LD   R30,Z
	MOV  R26,R30
	LDI  R30,LOW(0)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x96:
	IN   R30,0x37
	ORI  R30,0x40
	OUT  0x37,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x97:
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL _read_ds14287
	STS  __week_day,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x98:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_dv_on)
	SBCI R31,HIGH(-_dv_on)
	LD   R30,Z
	CPI  R30,LOW(0x81)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x99:
	MOV  R30,R16
	LDI  R26,LOW(_resurs_cnt_)
	LDI  R27,HIGH(_resurs_cnt_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x9A:
	LDI  R26,LOW(_resurs_cnt_)
	LDI  R27,HIGH(_resurs_cnt_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x9B:
	MOV  R30,R16
	LDI  R26,LOW(_RESURS_CNT)
	LDI  R27,HIGH(_RESURS_CNT)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0x9C:
	ADIW R30,1
	CALL __EEPROMWRW
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES
SUBOPT_0x9D:
	LDI  R26,LOW(_resurs_cnt__)
	LDI  R27,HIGH(_resurs_cnt__)
	LDI  R31,0
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x9E:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_i_dv_min)
	SBCI R31,HIGH(-_av_i_dv_min)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x9F:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_i_dv_max)
	SBCI R31,HIGH(-_av_i_dv_max)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xA0:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_i_dv_log)
	SBCI R31,HIGH(-_av_i_dv_log)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA1:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_dv_access)
	SBCI R27,HIGH(-_dv_access)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA2:
	ADD  R26,R30
	ADC  R27,R31
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __MULW12
	LDS  R26,_p
	LDS  R27,_p+1
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA3:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	LDS  R26,_p
	LDS  R27,_p+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA4:
	LDI  R26,LOW(_T_MAXMIN)
	LDI  R27,HIGH(_T_MAXMIN)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	LDS  R26,_p_max_cnt
	LDS  R27,_p_max_cnt+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA5:
	ST   -Y,R30
	LDS  R26,_p
	LDS  R27,_p+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	RJMP SUBOPT_0x4C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA6:
	LDI  R26,LOW(_T_MAXMIN)
	LDI  R27,HIGH(_T_MAXMIN)
	CALL __EEPROMRDW
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	LDS  R26,_p_min_cnt
	LDS  R27,_p_min_cnt+1
	CP   R26,R30
	CPC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xA7:
	CALL __GETW1P
	SBIW R30,1
	ST   X+,R30
	ST   X,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA8:
	LDI  R30,LOW(50)
	ST   -Y,R30
	JMP  _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xA9:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_av_i_dv_log)
	SBCI R27,HIGH(-_av_i_dv_log)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xAA:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_i_dv_log_old)
	SBCI R31,HIGH(-_av_i_dv_log_old)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xAB:
	MOV  R30,R16
	LSL  R30
	SWAP R30
	ANDI R30,0xF0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xAC:
	ST   -Y,R30
	ST   -Y,R18
	ST   -Y,R17
	ST   -Y,R20
	ST   -Y,R19
	JMP  _av_hndl

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0xAD:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_apv_cnt)
	SBCI R31,HIGH(-_apv_cnt)
	LD   R30,Z
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xAE:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_apv_cnt)
	SBCI R27,HIGH(-_apv_cnt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0xAF:
	LD   R30,X
	SUBI R30,LOW(1)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB0:
	LDI  R26,LOW(_Ida)
	LDI  R27,HIGH(_Ida)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB1:
	LDI  R26,LOW(_Idc)
	LDI  R27,HIGH(_Idc)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xB2:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_cnt_av_i_not_wrk)
	SBCI R31,HIGH(-_cnt_av_i_not_wrk)
	LD   R30,Z
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xB3:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_id_min_cnt)
	SBCI R31,HIGH(-_av_id_min_cnt)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB4:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_av_id_min_cnt)
	SBCI R27,HIGH(-_av_id_min_cnt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB5:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_apv)
	SBCI R31,HIGH(-_apv)
	LD   R30,Z
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB6:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_apv)
	SBCI R27,HIGH(-_apv)
	LDI  R30,LOW(85)
	ST   X,R30
	RJMP SUBOPT_0xAE

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB7:
	LDI  R30,LOW(50)
	ST   X,R30
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_plazma_i)
	SBCI R27,HIGH(-_plazma_i)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB8:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_av_id_max_cnt)
	SBCI R31,HIGH(-_av_id_max_cnt)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xB9:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_av_i_dv_max)
	SBCI R27,HIGH(-_av_i_dv_max)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xBA:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_cnt_av_i_not_wrk)
	SBCI R27,HIGH(-_cnt_av_i_not_wrk)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xBB:
	SUBI R30,LOW(-_av_id_not_cnt)
	SBCI R31,HIGH(-_av_id_not_cnt)
	LD   R30,Z
	CPI  R30,LOW(0x32)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xBC:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_av_id_not_cnt)
	SBCI R27,HIGH(-_av_id_not_cnt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xBD:
	ST   -Y,R30
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	ST   -Y,R31
	ST   -Y,R30
	ST   -Y,R18
	ST   -Y,R17
	JMP  _av_hndl

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xBE:
	LDI  R26,LOW(_AV_NET_PERCENT)
	LDI  R27,HIGH(_AV_NET_PERCENT)
	CALL __EEPROMRDW
	LDI  R26,LOW(220)
	LDI  R27,HIGH(220)
	CALL __MULW12
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xBF:
	MOV  R30,R16
	LDI  R26,LOW(_unet)
	LDI  R27,HIGH(_unet)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xC0:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_unet_min_cnt)
	SBCI R31,HIGH(-_unet_min_cnt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xC1:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_unet_st)
	SBCI R27,HIGH(-_unet_st)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xC2:
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xC3:
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xC4:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_unet_max_cnt)
	SBCI R31,HIGH(-_unet_max_cnt)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xC5:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _av_hndl

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xC6:
	LDI  R30,LOW(_Kun)
	LDI  R31,HIGH(_Kun)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0xC7:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xC8:
	CLR  R24
	CLR  R25
	__GETD1N 0xC8
	CALL __MULD12U
	__PUTD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xC9:
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2S 4
	CALL __DIVD21
	__PUTD1S 4
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xCA:
	CALL __CWD1
	__PUTD1S 4
	__GETD2S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xCB:
	CALL __CWD1
	__GETD2S 4
	CALL __MULD12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xCC:
	LDI  R26,LOW(_p_bank)
	LDI  R27,HIGH(_p_bank)
	LDI  R31,0
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0xCD:
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x2710
	CALL __DIVD21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xCE:
	ADD  R26,R30
	ADC  R27,R31
	MOVW R30,R26
	LSR  R31
	ROR  R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xCF:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD0:
	LDS  R30,_adc_cnt_main
	LDI  R31,0
	SUBI R30,LOW(-_adc_cnt_main1)
	SBCI R31,HIGH(-_adc_cnt_main1)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 35 TIMES
SUBOPT_0xD1:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD2:
	LDS  R26,_adc_cnt_main
	LDI  R27,0
	SUBI R26,LOW(-_adc_cnt_main1)
	SBCI R27,HIGH(-_adc_cnt_main1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xD3:
	LD   R30,X
	SUBI R30,-LOW(1)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD4:
	LDS  R30,_adc_cnt_main
	SUBI R30,-LOW(1)
	STS  _adc_cnt_main,R30
	LDS  R26,_adc_cnt_main
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xD5:
	LDI  R30,LOW(0)
	STS  _self_cnt,R30
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	STS  _self_min,R30
	STS  _self_min+1,R31
	LDI  R30,0
	STS  _self_max,R30
	STS  _self_max+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD6:
	LDS  R26,_adc_cnt_main
	LDI  R30,LOW(7)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD7:
	LDI  R30,LOW(134)
	OUT  0x6,R30
	IN   R30,0x20
	ANDI R30,LOW(0xF)
	OUT  0x20,R30
	IN   R30,0x20
	ORI  R30,0x10
	OUT  0x20,R30
	LDS  R30,_adc_cnt_main
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD8:
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R17
	RJMP SUBOPT_0xCF

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0xD9:
	ST   -Y,R30
	LDI  R30,LOW(255)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xDA:
	LDS  R30,_p2
	LDI  R26,LOW(_av_code)
	LDI  R27,HIGH(_av_code)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xDB:
	LDS  R30,_p1
	LDI  R26,LOW(_av_code)
	LDI  R27,HIGH(_av_code)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xDC:
	LDS  R30,_index_set
	LDS  R26,_sub_ind
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xDD:
	LDS  R26,_index_set
	LDS  R30,_sub_ind
	SUB  R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xDE:
	MOV  R26,R30
	LDI  R30,LOW(1)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xDF:
	LDS  R30,_sub_ind
	SUBI R30,LOW(1)
	STS  _index_set,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0xE0:
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   -Y,R31
	ST   -Y,R30
	LDD  R30,Y+7
	LDD  R31,Y+7+1
	ST   -Y,R31
	ST   -Y,R30
	JMP  _bgnd_par

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE1:
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(33)
	ST   -Y,R30
	JMP  _sub_bgnd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE2:
	LDI  R27,0
	SUBI R26,LOW(-_av_hour)
	SBCI R27,HIGH(-_av_hour)
	CALL __EEPROMRDB
	ANDI R30,LOW(0x1F)
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES
SUBOPT_0xE3:
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xE4:
	CALL _int2lcd
	LDS  R26,_p2
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xE5:
	SUBI R26,LOW(-_av_min)
	SBCI R27,HIGH(-_av_min)
	CALL __EEPROMRDB
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0xE6:
	LDI  R30,LOW(35)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xE7:
	SUBI R26,LOW(-_av_day)
	SBCI R27,HIGH(-_av_day)
	CALL __EEPROMRDB
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES
SUBOPT_0xE8:
	LDI  R30,LOW(36)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE9:
	SUBI R26,LOW(-_av_month)
	SBCI R27,HIGH(-_av_month)
	CALL __EEPROMRDB
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0xEA:
	LDI  R30,LOW(37)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xEB:
	SUBI R26,LOW(-_av_year)
	SBCI R27,HIGH(-_av_year)
	CALL __EEPROMRDB
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 46 TIMES
SUBOPT_0xEC:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _int2lcd

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xED:
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _bgnd_par

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xEE:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(81)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _int2lcdxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xEF:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(33)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _int2lcdxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xF0:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _int2lcdxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xF1:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(129)
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _int2lcdxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0xF2:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _int2lcdxy

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xF3:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(240)
	RJMP SUBOPT_0xF2

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES
SUBOPT_0xF4:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_av_code)
	LDI  R27,HIGH(_av_code)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0xF5:
	STD  Y+5,R30
	STD  Y+5+1,R31
	LDS  R30,_index_set
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,3
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	LDS  R30,_index_set
	SUBI R30,-LOW(1)
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,5
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	JMP  _bgnd_par

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0xF6:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_av_data1)
	LDI  R27,HIGH(_av_data1)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES
SUBOPT_0xF7:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_av_data0)
	LDI  R27,HIGH(_av_data0)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0xF8:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xF9:
	LDS  R30,_index_set
	SUBI R30,-LOW(1)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xFA:
	LDS  R30,_index_set
	LDI  R31,0
	MOVW R26,R28
	ADIW R26,3
	RJMP SUBOPT_0xF8

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xFB:
	CALL _int2lcd
	LDI  R30,LOW(103)
	ST   -Y,R30
	CALL _find
	LDI  R31,0
	SUBI R30,LOW(-_lcd_buffer)
	SBCI R31,HIGH(-_lcd_buffer)
	MOVW R26,R30
	LDI  R30,LOW(2)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0xFC:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	JMP  _int2lcd

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xFD:
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE3

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xFE:
	CALL _int2lcd
	LDS  R26,_sub_ind1
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0xFF:
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE8

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x100:
	LDS  R26,_sub_ind1
	LDI  R27,0
	SUBI R26,LOW(-_av_month)
	SBCI R27,HIGH(-_av_month)
	CALL __EEPROMRDB
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES
SUBOPT_0x101:
	LDI  R31,0
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x102:
	CALL _int2lcd
	LDS  R30,__min
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE6

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x103:
	CALL _int2lcd
	LDS  R30,__sec
	RJMP SUBOPT_0xFF

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x104:
	CALL _int2lcd
	LDS  R30,__day
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xEA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x105:
	CALL _int2lcd
	LDS  R30,__year
	LDI  R31,0
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(94)
	RJMP SUBOPT_0xEC

;OPTIMIZER ADDED SUBROUTINE, CALLED 32 TIMES
SUBOPT_0x106:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(33)
	RJMP SUBOPT_0xEC

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x107:
	LDI  R26,LOW(_T_ON_WARM)
	LDI  R27,HIGH(_T_ON_WARM)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x108:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_P_SENS)
	LDI  R27,HIGH(_P_SENS)
	CALL __EEPROMRDB
	LDI  R31,0
	RJMP SUBOPT_0x106

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x109:
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10A:
	LDS  R26,_p
	LDS  R27,_p+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 23 TIMES
SUBOPT_0x10B:
	ST   -Y,R30
	LDI  R30,LOW(1)
	ST   -Y,R30
	JMP  _int2lcd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10C:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	RJMP SUBOPT_0x7F

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10D:
	LDI  R26,LOW(_RESURS_CNT)
	LDI  R27,HIGH(_RESURS_CNT)
	CALL __EEPROMRDW
	CPI  R30,LOW(0xA)
	LDI  R26,HIGH(0xA)
	CPC  R31,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10E:
	LDI  R26,LOW(_RESURS_CNT)
	LDI  R27,HIGH(_RESURS_CNT)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x10F:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x110:
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x111:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(35)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x112:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_SS_LEVEL)
	LDI  R27,HIGH(_SS_LEVEL)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(33)
	RJMP SUBOPT_0x10B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x113:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_DVCH_TIME)
	LDI  R27,HIGH(_DVCH_TIME)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CALL __DIVW21
	RJMP SUBOPT_0x106

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x114:
	LDI  R26,LOW(_DVCH_TIME)
	LDI  R27,HIGH(_DVCH_TIME)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CALL __MODW21
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x115:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x116:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_DOOR)
	LDI  R27,HIGH(_DOOR)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES
SUBOPT_0x117:
	LDI  R30,LOW(33)
	ST   -Y,R30
	JMP  _sub_bgnd

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x118:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_PROBE)
	LDI  R27,HIGH(_PROBE)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x119:
	CALL _int2lcd
	LDI  R26,LOW(_PROBE_TIME)
	LDI  R27,HIGH(_PROBE_TIME)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x11A:
	CALL __DIVW21
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE8

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x11B:
	CALL __MODW21
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xEA

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x11C:
	ST   -Y,R31
	ST   -Y,R30
	CALL _bgnd_par
	LDI  R26,LOW(_HH_SENS)
	LDI  R27,HIGH(_HH_SENS)
	CALL __EEPROMRDB
	CPI  R30,LOW(0x55)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0x11D:
	LDI  R30,LOW(_sm_exit*2)
	LDI  R31,HIGH(_sm_exit*2)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _bgnd_par

;OPTIMIZER ADDED SUBROUTINE, CALLED 39 TIMES
SUBOPT_0x11E:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _bgnd_par

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x11F:
	LDI  R30,LOW(_sm_*2)
	LDI  R31,HIGH(_sm_*2)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _bgnd_par

;OPTIMIZER ADDED SUBROUTINE, CALLED 14 TIMES
SUBOPT_0x120:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(33)
	RJMP SUBOPT_0x10B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x121:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(35)
	RJMP SUBOPT_0x10B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x122:
	LDS  R26,_sub_ind
	LDI  R27,0
	SUBI R26,LOW(-_DV_MODE)
	SBCI R27,HIGH(-_DV_MODE)
	CALL __EEPROMRDB
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x123:
	LDS  R30,_sub_ind
	SUBI R30,-LOW(1)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x124:
	LDI  R26,LOW(_DVCH_T_UP)
	LDI  R27,HIGH(_DVCH_T_UP)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x125:
	CALL __MODW21
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0xE3

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x126:
	LDI  R26,LOW(_DVCH_T_DOWN)
	LDI  R27,HIGH(_DVCH_T_DOWN)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES
SUBOPT_0x127:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_timer_mode)
	LDI  R27,HIGH(_timer_mode)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 35 TIMES
SUBOPT_0x128:
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_sub_ind
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x129:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(40)
	ST   -Y,R30
	JMP  _sub_bgnd

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x12A:
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDB
	CPI  R30,LOW(0x2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x12B:
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDB
	CPI  R30,LOW(0x3)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0x12C:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_timer_time1)
	LDI  R27,HIGH(_timer_time1)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x12D:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x12E:
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CALL __DIVW21U
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x12F:
	MOVW R26,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	CALL __MODW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0x130:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_timer_time2)
	LDI  R27,HIGH(_timer_time2)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x131:
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES
SUBOPT_0x132:
	LDS  R30,_sub_ind1
	LDI  R26,LOW(_timer_data1)
	LDI  R27,HIGH(_timer_data1)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x133:
	ST   -Y,R30
	LDI  R30,LOW(2)
	ST   -Y,R30
	JMP  _ind_fl

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x134:
	ST   -Y,R30
	LDI  R30,LOW(5)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x135:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	SUBI R30,LOW(-128)
	SBCI R31,HIGH(-128)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x136:
	LDS  R26,___fp_fcurr
	LDS  R27,___fp_fcurr+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x137:
	LDI  R30,LOW(100)
	ST   -Y,R30
	JMP  _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x138:
	LDI  R30,LOW(168)
	MOV  R13,R30
	LDI  R30,LOW(0)
	STS  _sub_ind,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x139:
	LDS  R30,_sub_ind
	SUBI R30,-LOW(1)
	STS  _sub_ind,R30
	LDI  R30,LOW(_sub_ind)
	LDI  R31,HIGH(_sub_ind)
	RJMP SUBOPT_0x90

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x13A:
	LDS  R26,_power
	LDS  R27,_power+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x13B:
	ADIW R30,1
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x13C:
	SBIW R30,1
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x13D:
	LDI  R30,LOW(19)
	ST   -Y,R30
	JMP  _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x13E:
	LDS  R30,_sub_ind
	SUBI R30,LOW(1)
	STS  _sub_ind,R30
	LDI  R30,LOW(_sub_ind)
	LDI  R31,HIGH(_sub_ind)
	RJMP SUBOPT_0x90

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x13F:
	LDI  R30,LOW(34)
	MOV  R13,R30
	LDI  R30,LOW(0)
	STS  _sub_ind,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x140:
	LDI  R30,LOW(16)
	ST   -Y,R30
	JMP  _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 21 TIMES
SUBOPT_0x141:
	MOV  R13,R30
	LDI  R30,LOW(0)
	STS  _sub_ind,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x142:
	LDI  R30,LOW(6)
	ST   -Y,R30
	CALL _gran_ring_char
	LDS  R26,_sub_ind
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x143:
	ST   Y,R30
	LDS  R26,_but_pult
	CPI  R26,LOW(0xEF)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x144:
	LDI  R30,LOW(23)
	ST   -Y,R30
	CALL _gran_ring_char
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x145:
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	MOVW R30,R28
	RJMP SUBOPT_0x90

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x146:
	LDI  R30,LOW(4)
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	JMP  _write_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x147:
	LDI  R30,LOW(59)
	ST   -Y,R30
	CALL _gran_ring_char
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x148:
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	JMP  _write_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x149:
	LDI  R30,LOW(0)
	ST   -Y,R30
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x14A:
	ST   -Y,R30
	CALL _gran_ring_char
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x14B:
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	MOVW R30,R28
	RJMP SUBOPT_0x65

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x14C:
	ST   -Y,R30
	LDD  R30,Y+1
	ST   -Y,R30
	JMP  _write_ds14287

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x14D:
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x14E:
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	LDI  R26,LOW(_Kt)
	LDI  R27,HIGH(_Kt)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __EEPROMRDW
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x14F:
	LDI  R26,LOW(_TEMPER_SIGN)
	LDI  R27,HIGH(_TEMPER_SIGN)
	CALL __EEPROMRDB
	LDI  R26,LOW(_Kt)
	LDI  R27,HIGH(_Kt)
	RJMP SUBOPT_0xD1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x150:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(550)
	LDI  R31,HIGH(550)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x151:
	SBIW R30,1
	CALL __EEPROMWRW
	ADIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x152:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x153:
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x154:
	LDI  R30,LOW(_P_MIN)
	LDI  R31,HIGH(_P_MIN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(80)
	LDI  R31,HIGH(80)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x155:
	LDI  R30,LOW(_Kp1)
	LDI  R31,HIGH(_Kp1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10000)
	LDI  R31,HIGH(10000)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x156:
	LDI  R30,LOW(_P_MAX)
	LDI  R31,HIGH(_P_MAX)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x157:
	LDI  R30,LOW(_T_MAXMIN)
	LDI  R31,HIGH(_T_MAXMIN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x158:
	LDI  R30,LOW(_G_MAXMIN)
	LDI  R31,HIGH(_G_MAXMIN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x159:
	LDI  R30,LOW(_EE_DV_NUM)
	LDI  R31,HIGH(_EE_DV_NUM)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x15A:
	LDI  R30,LOW(0)
	STS  _sub_ind,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x15B:
	LDI  R30,LOW(_Idmin)
	LDI  R31,HIGH(_Idmin)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x15C:
	LDI  R30,LOW(_Idmax)
	LDI  R31,HIGH(_Idmax)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x15D:
	LDS  R26,_sub_ind
	LDI  R27,0
	SUBI R26,LOW(-_DV_MODE)
	SBCI R27,HIGH(-_DV_MODE)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x15E:
	LDS  R30,_sub_ind
	SUBI R30,-LOW(1)
	STS  _sub_ind,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x15F:
	LDI  R26,LOW(_EE_DV_NUM)
	LDI  R27,HIGH(_EE_DV_NUM)
	CALL __EEPROMRDB
	LDS  R26,_sub_ind
	CP   R26,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x160:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x161:
	LDI  R30,LOW(0)
	STS  _index_set,R30
	RJMP SUBOPT_0x15F

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x162:
	LDS  R30,_sub_ind
	LDI  R26,LOW(_Kida)
	LDI  R27,HIGH(_Kida)
	RJMP SUBOPT_0xD1

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x163:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(150)
	LDI  R31,HIGH(150)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x164:
	LDS  R30,_sub_ind
	LDI  R26,LOW(_Kidc)
	LDI  R27,HIGH(_Kidc)
	RJMP SUBOPT_0xD1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x165:
	LDI  R30,LOW(_SS_LEVEL)
	LDI  R31,HIGH(_SS_LEVEL)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x166:
	LDI  R30,LOW(_SS_STEP)
	LDI  R31,HIGH(_SS_STEP)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x167:
	LDI  R30,LOW(_SS_TIME)
	LDI  R31,HIGH(_SS_TIME)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x168:
	LDI  R30,LOW(_SS_FRIQ)
	LDI  R31,HIGH(_SS_FRIQ)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(70)
	LDI  R31,HIGH(70)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x169:
	LDI  R30,LOW(_DVCH_T_UP)
	LDI  R31,HIGH(_DVCH_T_UP)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(600)
	LDI  R31,HIGH(600)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16A:
	LDI  R30,LOW(_DVCH_T_DOWN)
	LDI  R31,HIGH(_DVCH_T_DOWN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16B:
	LDI  R30,LOW(_DVCH_P_KR)
	LDI  R31,HIGH(_DVCH_P_KR)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(50)
	LDI  R31,HIGH(50)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16C:
	LDI  R30,LOW(_DVCH_KP)
	LDI  R31,HIGH(_DVCH_KP)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16D:
	LDI  R26,LOW(_DVCH_TIME)
	LDI  R27,HIGH(_DVCH_TIME)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16E:
	ADIW R30,1
	LDI  R26,LOW(15)
	LDI  R27,HIGH(15)
	CALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16F:
	LDI  R26,LOW(_DVCH_TIME)
	LDI  R27,HIGH(_DVCH_TIME)
	CALL __EEPROMWRW
	LDI  R30,LOW(_DVCH_TIME)
	LDI  R31,HIGH(_DVCH_TIME)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1440)
	LDI  R31,HIGH(1440)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x170:
	SBIW R30,1
	LDI  R26,LOW(15)
	LDI  R27,HIGH(15)
	CALL __MULW12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x171:
	LDI  R30,LOW(_FP_FMIN)
	LDI  R31,HIGH(_FP_FMIN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(70)
	LDI  R31,HIGH(70)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(204)
	LDI  R31,HIGH(204)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2N 0x3E8
	CALL __MULD12U
	CALL __PUTPARD1
	JMP  _write_vlt_registers

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x172:
	LDI  R30,LOW(_FP_FMAX)
	LDI  R31,HIGH(_FP_FMAX)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(70)
	LDI  R31,HIGH(70)
	ST   -Y,R31
	ST   -Y,R30
	CALL _granee
	LDI  R30,LOW(205)
	LDI  R31,HIGH(205)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2N 0x3E8
	CALL __MULD12U
	CALL __PUTPARD1
	JMP  _write_vlt_registers

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x173:
	LDI  R30,LOW(_FP_TPAD)
	LDI  R31,HIGH(_FP_TPAD)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x174:
	LDI  R30,LOW(_FP_TVOZVR)
	LDI  R31,HIGH(_FP_TVOZVR)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES
SUBOPT_0x175:
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x176:
	LDI  R30,LOW(_FP_P_PL)
	LDI  R31,HIGH(_FP_P_PL)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x177:
	LDI  R30,LOW(_FP_P_MI)
	LDI  R31,HIGH(_FP_P_MI)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x178:
	LDI  R30,LOW(_FP_RESET_TIME)
	LDI  R31,HIGH(_FP_RESET_TIME)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x179:
	LDI  R30,LOW(_DOOR_IMIN)
	LDI  R31,HIGH(_DOOR_IMIN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17A:
	LDI  R30,LOW(_DOOR_IMAX)
	LDI  R31,HIGH(_DOOR_IMAX)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17B:
	LDI  R26,LOW(_PROBE_DUTY)
	LDI  R27,HIGH(_PROBE_DUTY)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17C:
	LDI  R26,LOW(24)
	LDI  R27,HIGH(24)
	CALL __MULW12
	LDI  R26,LOW(_PROBE_DUTY)
	LDI  R27,HIGH(_PROBE_DUTY)
	CALL __EEPROMWRW
	LDI  R30,LOW(_PROBE_DUTY)
	LDI  R31,HIGH(_PROBE_DUTY)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(24)
	LDI  R31,HIGH(24)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(96)
	LDI  R31,HIGH(96)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17D:
	LDI  R26,LOW(_PROBE_TIME)
	LDI  R27,HIGH(_PROBE_TIME)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17E:
	LDI  R26,LOW(_PROBE_TIME)
	LDI  R27,HIGH(_PROBE_TIME)
	CALL __EEPROMWRW
	LDI  R30,LOW(_PROBE_TIME)
	LDI  R31,HIGH(_PROBE_TIME)
	JMP SUBOPT_0x4C

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x17F:
	LDI  R30,LOW(1425)
	LDI  R31,HIGH(1425)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x180:
	LDI  R30,LOW(_HH_TIME)
	LDI  R31,HIGH(_HH_TIME)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x181:
	LDI  R30,LOW(_HH_P)
	LDI  R31,HIGH(_HH_P)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x182:
	LDI  R30,LOW(8)
	ST   -Y,R30
	JMP  _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x183:
	LDI  R26,LOW(_P_UST_EE)
	LDI  R27,HIGH(_P_UST_EE)
	CALL __EEPROMRDW
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x184:
	LDI  R26,LOW(_P_UST_EE)
	LDI  R27,HIGH(_P_UST_EE)
	CALL __EEPROMWRW
	LDI  R30,LOW(_P_UST_EE)
	LDI  R31,HIGH(_P_UST_EE)
	JMP SUBOPT_0x4C

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x185:
	LDI  R30,LOW(300)
	LDI  R31,HIGH(300)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x186:
	STS  _sub_ind2,R30
	LDI  R30,LOW(_sub_ind2)
	LDI  R31,HIGH(_sub_ind2)
	JMP SUBOPT_0x90

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x187:
	LDI  R30,LOW(5)
	ST   -Y,R30
	JMP  _gran_ring_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES
SUBOPT_0x188:
	ADD  R26,R30
	ADC  R27,R31
	LDS  R30,_sub_ind
	RJMP SUBOPT_0xD1

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x189:
	LDI  R30,LOW(1439)
	LDI  R31,HIGH(1439)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x18A:
	MOVW R26,R30
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	CALL __DIVW21U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x18B:
	ADIW R30,1
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x18C:
	LDI  R30,LOW(1435)
	LDI  R31,HIGH(1435)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x18D:
	SBIW R30,1
	LDI  R26,LOW(5)
	LDI  R27,HIGH(5)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x18E:
	MOVW R26,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x18F:
	LDI  R30,LOW(3000)
	LDI  R31,HIGH(3000)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x190:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_FP_FMIN)
	LDI  R27,HIGH(_FP_FMIN)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(_FP_FMAX)
	LDI  R27,HIGH(_FP_FMAX)
	CALL __EEPROMRDW
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x191:
	LDI  R30,LOW(_ZL_TIME)
	LDI  R31,HIGH(_ZL_TIME)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x185

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x192:
	LDI  R30,LOW(_PID_PERIOD)
	LDI  R31,HIGH(_PID_PERIOD)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x193:
	LDI  R30,LOW(_PID_K)
	LDI  R31,HIGH(_PID_K)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x194:
	LDI  R30,LOW(_PID_K_P)
	LDI  R31,HIGH(_PID_K_P)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x195:
	LDI  R30,LOW(_PID_K_D)
	LDI  R31,HIGH(_PID_K_D)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x196:
	LDI  R30,LOW(_PID_K_FP_DOWN)
	LDI  R31,HIGH(_PID_K_FP_DOWN)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x175

;OPTIMIZER ADDED SUBROUTINE, CALLED 73 TIMES
SUBOPT_0x197:
	LDS  R30,_ptr_rx_rd
	LDI  R26,LOW(_fifo_can_in)
	LDI  R27,HIGH(_fifo_can_in)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x198:
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0xFF)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x199:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,4
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0x19A:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,6
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x19B:
	LDI  R30,LOW(20)
	MOV  R12,R30
	RJMP SUBOPT_0x183

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x19C:
	LDI  R26,LOW(10)
	LDI  R27,HIGH(10)
	CALL __MULW12
	RJMP SUBOPT_0x184

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x19D:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(150)
	LDI  R31,HIGH(150)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(500)
	LDI  R31,HIGH(500)
	ST   -Y,R31
	ST   -Y,R30
	JMP  _granee

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x19E:
	MOVW R26,R30
	LDI  R27,0
	LDI  R30,LOW(256)
	LDI  R31,HIGH(256)
	CALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x19F:
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	JMP SUBOPT_0x4A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1A0:
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2S 0
	CALL __MULD12
	RJMP SUBOPT_0xCD

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1A1:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,7
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1A2:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,8
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1A3:
	CALL __EEPROMRDW
	CALL __CWD1
	__GETD2S 0
	CALL __MULD12
	RJMP SUBOPT_0xCD

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1A4:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,9
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1A5:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,10
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x1A6:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,11
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1A7:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,12
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1A8:
	ST   -Y,R30
	LDI  R30,LOW(64)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1A9:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	JMP  _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1AA:
	LDS  R30,_m8_rx_cnt
	LDI  R31,0
	SUBI R30,LOW(-_m8_rx_buffer)
	SBCI R31,HIGH(-_m8_rx_buffer)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1AB:
	LDS  R30,_m8_rx_cnt
	SUBI R30,LOW(10)
	LDI  R31,0
	SUBI R30,LOW(-_m8_rx_buffer)
	SBCI R31,HIGH(-_m8_rx_buffer)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x1AC:
	LDI  R31,0
	SUBI R30,LOW(-_m8_rx_buffer)
	SBCI R31,HIGH(-_m8_rx_buffer)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1AD:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1AE:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1AF:
	IN   R30,0x34
	ANDI R30,LOW(0xE0)
	OUT  0x34,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x1B0:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

_abs:
	ld   r30,y+
	ld   r31,y+
	sbiw r30,0
	brpl __abs0
	com  r30
	com  r31
	adiw r30,1
__abs0:
	ret

_delay_ms:
	ld   r30,y+
	ld   r31,y+
	adiw r30,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0x7D0
	wdr
	sbiw r30,1
	brne __delay_ms0
__delay_ms1:
	ret

_spi:
	ld   r30,y+
	out  spdr,r30
__spi0:
	sbis spsr,7
	rjmp __spi0
	in   r30,spdr
	ret

__ADDD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	ADC  R23,R25
	RET

__SUBD12:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	SBC  R23,R25
	RET

__ANEGW1:
	COM  R30
	COM  R31
	ADIW R30,1
	RET

__ANEGD1:
	COM  R30
	COM  R31
	COM  R22
	COM  R23
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__LSLW4:
	LSL  R30
	ROL  R31
__LSLW3:
	LSL  R30
	ROL  R31
__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRW4:
	ASR  R31
	ROR  R30
__ASRW3:
	ASR  R31
	ROR  R30
__ASRW2:
	ASR  R31
	ROR  R30
	ASR  R31
	ROR  R30
	RET

__LSRW4:
	LSR  R31
	ROR  R30
__LSRW3:
	LSR  R31
	ROR  R30
__LSRW2:
	LSR  R31
	ROR  R30
	LSR  R31
	ROR  R30
	RET

__CWD1:
	LDI  R22,0
	LDI  R23,0
	SBRS R31,7
	RET
	SER  R22
	SER  R23
	RET

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__MULD12U:
	MUL  R23,R26
	MOV  R23,R0
	MUL  R22,R27
	ADD  R23,R0
	MUL  R31,R24
	ADD  R23,R0
	MUL  R30,R25
	ADD  R23,R0
	MUL  R22,R26
	MOV  R22,R0
	ADD  R23,R1
	MUL  R31,R27
	ADD  R22,R0
	ADC  R23,R1
	MUL  R30,R24
	ADD  R22,R0
	ADC  R23,R1
	CLR  R24
	MUL  R31,R26
	MOV  R31,R0
	ADD  R22,R1
	ADC  R23,R24
	MUL  R30,R27
	ADD  R31,R0
	ADC  R22,R1
	ADC  R23,R24
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	ADC  R22,R24
	ADC  R23,R24
	RET

__MULW12:
	RCALL __CHKSIGNW
	RCALL __MULW12U
	BRTC __MULW121
	RCALL __ANEGW1
__MULW121:
	RET

__MULD12:
	RCALL __CHKSIGND
	RCALL __MULD12U
	BRTC __MULD121
	RCALL __ANEGD1
__MULD121:
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__DIVD21U:
	PUSH R19
	PUSH R20
	PUSH R21
	CLR  R0
	CLR  R1
	CLR  R19
	CLR  R20
	LDI  R21,32
__DIVD21U1:
	LSL  R26
	ROL  R27
	ROL  R24
	ROL  R25
	ROL  R0
	ROL  R1
	ROL  R19
	ROL  R20
	SUB  R0,R30
	SBC  R1,R31
	SBC  R19,R22
	SBC  R20,R23
	BRCC __DIVD21U2
	ADD  R0,R30
	ADC  R1,R31
	ADC  R19,R22
	ADC  R20,R23
	RJMP __DIVD21U3
__DIVD21U2:
	SBR  R26,1
__DIVD21U3:
	DEC  R21
	BRNE __DIVD21U1
	MOVW R30,R26
	MOVW R22,R24
	MOVW R26,R0
	MOV  R24,R19
	MOV  R25,R20
	POP  R21
	POP  R20
	POP  R19
	RET

__DIVD21:
	RCALL __CHKSIGND
	RCALL __DIVD21U
	BRTC __DIVD211
	RCALL __ANEGD1
__DIVD211:
	RET

__MODW21U:
	RCALL __DIVW21U
	MOVW R30,R26
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__CHKSIGND:
	CLT
	SBRS R23,7
	RJMP __CHKSD1
	RCALL __ANEGD1
	SET
__CHKSD1:
	SBRS R25,7
	RJMP __CHKSD2
	CLR  R0
	COM  R26
	COM  R27
	COM  R24
	COM  R25
	ADIW R26,1
	ADC  R24,R0
	ADC  R25,R0
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSD2:
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1P:
	LD   R30,X+
	LD   R31,X+
	LD   R22,X+
	LD   R23,X
	SBIW R26,3
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__EEPROMRDW:
	ADIW R26,1
	RCALL __EEPROMRDB
	MOV  R31,R30
	SBIW R26,1

__EEPROMRDB:
	SBIC EECR,EEWE
	RJMP __EEPROMRDB
	PUSH R31
	IN   R31,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R30,EEDR
	OUT  SREG,R31
	POP  R31
	RET

__EEPROMWRW:
	RCALL __EEPROMWRB
	ADIW R26,1
	PUSH R30
	MOV  R30,R31
	RCALL __EEPROMWRB
	POP  R30
	SBIW R26,1
	RET

__EEPROMWRB:
	SBIC EECR,EEWE
	RJMP __EEPROMWRB
	IN   R25,SREG
	CLI
	OUT  EEARL,R26
	OUT  EEARH,R27
	SBI  EECR,EERE
	IN   R24,EEDR
	CP   R30,R24
	BREQ __EEPROMWRB0
	OUT  EEDR,R30
	SBI  EECR,EEMWE
	SBI  EECR,EEWE
__EEPROMWRB0:
	OUT  SREG,R25
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__CPD20:
	SBIW R26,0
	SBCI R24,0
	SBCI R25,0
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
	RET

__CPD21:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R25,R23
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

__INITLOCB:
__INITLOCW:
	ADD R26,R28
	ADC R27,R29
__INITLOC0:
	LPM  R0,Z+
	ST   X+,R0
	DEC  R24
	BRNE __INITLOC0
	RET

