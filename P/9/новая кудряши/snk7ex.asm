;CodeVisionAVR C Compiler V1.24.1d Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.ro
;e-mail:office@hpinfotech.ro

;Chip type           : ATmega8
;Program type        : Application
;Clock frequency     : 8,000000 MHz
;Memory model        : Small
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : long, width
;External SRAM size  : 0
;Data Stack size     : 128 byte(s)
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
	.EQU GICR=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F

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

	.EQU __se_bit=0x80
	.EQU __sm_mask=0x70
	.EQU __sm_adc_noise_red=0x10
	.EQU __sm_powerdown=0x20
	.EQU __sm_powersave=0x30
	.EQU __sm_standby=0x60
	.EQU __sm_ext_standby=0x70

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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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
	RCALL __PUTDP1
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

	.INCLUDE "snk7ex.vec"
	.INCLUDE "snk7ex.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  GICR,R31
	OUT  GICR,R30
	OUT  MCUCR,R30

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
	LDI  R24,LOW(0x400)
	LDI  R25,HIGH(0x400)
	LDI  R26,0x60
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
	LDI  R30,LOW(0x45F)
	OUT  SPL,R30
	LDI  R30,HIGH(0x45F)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0xE0)
	LDI  R29,HIGH(0xE0)

	RJMP _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0xE0
;       1 #define FIFO_CAN_IN_LEN	10
;       2 #define FIFO_CAN_OUT_LEN	10
;       3 #define adres	0
;       4 
;       5 #define CS_DDR	DDRB.0
;       6 #define CS	PORTB.0 
;       7 #define SPI_PORT_INIT  DDRB.5=1;DDRB.3=1;DDRB.4=0;DDRB.0=1;DDRB.2=1;SPCR=0x50;SPSR=0x01;
;       8 
;       9 #define CNF1_INIT	0b00000001  //tq=500ns   //8MHz
;      10 //#define CNF2_INIT	0b10110001  //Ps1=7tq,Pr=2tq 
;      11 //#define CNF3_INIT	0b00000101  //Ps2=6tq
;      12 
;      13 #define CNF2_INIT	0b11111100  //Ps1=8tq,Pr=5tq 
;      14 #define CNF3_INIT	0b00000001  //Ps2=2tq
;      15 
;      16 #define RELE1	0
;      17 #define RELE2	1
;      18 
;      19 
;      20 #include <mega8.h>
;      21 
;      22 char t0_cnt0,t0_cnt1,t0_cnt2,t0_cnt3,t0_cnt4;
;      23 bit b100Hz,b10Hz,b5Hz,b2Hz,b1Hz,b_mcp;
;      24 
;      25 char data_out[30];
_data_out:
	.BYTE 0x1E
;      26 char plazma,plazma1;
;      27 char adc_cnt_main;
;      28 unsigned self_max,self_min;
_self_min:
	.BYTE 0x2
;      29 char adc_ch;
;      30 flash char ADMUX_CONST[7]={0xC2,0xC3,0xC4,0xC5,0x46,0xC2,0xC2};

	.CSEG
;      31 char adc_buff_zero_curr_cnt[4];

	.DSEG
_adc_buff_zero_curr_cnt:
	.BYTE 0x4
;      32 unsigned adc_buff_zero_curr[4,4];
_adc_buff_zero_curr:
	.BYTE 0x20
;      33 unsigned adc_buff_zero_curr_[4];
_adc_buff_zero_curr_:
	.BYTE 0x8
;      34 //char self_cnt_zero_for;
;      35 char self_cnt_zero_after;
_self_cnt_zero_after:
	.BYTE 0x1
;      36 char self_cnt_not_zero;
_self_cnt_not_zero:
	.BYTE 0x1
;      37 unsigned curr_buff;
_curr_buff:
	.BYTE 0x2
;      38 unsigned curr_ch_buff[4,16];
_curr_ch_buff:
	.BYTE 0x80
;      39 unsigned curr_ch_buff_[4];
_curr_ch_buff_:
	.BYTE 0x8
;      40 char adc_cnt_main1[4];
_adc_cnt_main1:
	.BYTE 0x4
;      41 char self_cnt;
_self_cnt:
	.BYTE 0x1
;      42 unsigned adc_buff[8,16]; 
_adc_buff:
	.BYTE 0x100
;      43 unsigned adc_buff_[8];
_adc_buff_:
	.BYTE 0x10
;      44 char adc_ch_cnt;
_adc_ch_cnt:
	.BYTE 0x1
;      45 char flags[2];
_flags:
	.BYTE 0x2
;      46 //flash char adres=0;
;      47 flash char PTR_IN_TEMPER[2]={5,3};

	.CSEG
;      48 flash char PTR_IN_VL[2]={7,0};
;      49 flash char PTR_IN_UPP[4]={5,7,3,0};
;      50 signed char cnt_avtHH[2],cnt_avtKZ[2],cnt_avtON[2],cnt_avtOFF[2],cnt_avvHH[2],cnt_avvKZ[2],cnt_avvON[2],cnt_avvOFF[2];

	.DSEG
_cnt_avtHH:
	.BYTE 0x2
_cnt_avtKZ:
	.BYTE 0x2
_cnt_avtON:
	.BYTE 0x2
_cnt_avtOFF:
	.BYTE 0x2
_cnt_avvHH:
	.BYTE 0x2
_cnt_avvKZ:
	.BYTE 0x2
_cnt_avvON:
	.BYTE 0x2
_cnt_avvOFF:
	.BYTE 0x2
;      51 //signed char cnt_av_upp[2];
;      52 enum {avvON=0x55,avvOFF=0xaa,avvKZ=0x69,avvHH=0x66} av_vl[2];
_av_vl:
	.BYTE 0x2
;      53 enum {avtON=0x55,avtOFF=0xaa,avtKZ=0x69,avtHH=0x66} av_temper[2];
_av_temper:
	.BYTE 0x2
;      54 
;      55 bit bon0,bon1;
;      56 
;      57 
;      58 
;      59 //***********************************************
;      60 //Работа с логическими входами (сервис и УПП)
;      61 signed char log_in_cnt;
_log_in_cnt:
	.BYTE 0x1
;      62 signed char upp_cnt[4];
_upp_cnt:
	.BYTE 0x4
;      63 signed char serv_cnt[4];
_serv_cnt:
	.BYTE 0x4
;      64 enum {avuON=0x55,avuOFF=0xAA}av_upp[4];
_av_upp:
	.BYTE 0x4
;      65 enum {avsON=0x55,avsOFF=0xAA}av_serv[4];
_av_serv:
	.BYTE 0x4
;      66 
;      67 
;      68 enum {dvOFF=0x81,dvSTAR=0x42,dvTRIAN=0x24,dvFR=0x66,dvFULL=0x99} dv_on[4]={dvOFF,dvOFF,dvOFF,dvOFF},dv_on_old[4]={dvOFF,dvOFF,dvOFF,dvOFF},dv_stat[4]={dvOFF,dvOFF,dvOFF,dvOFF};
_dv_on:
	.BYTE 0x4
_dv_on_old:
	.BYTE 0x4
_dv_stat:
	.BYTE 0x4
;      69 char dv_cnt[4];
_dv_cnt:
	.BYTE 0x4
;      70 
;      71 unsigned plazma_int[4];
_plazma_int:
	.BYTE 0x8
;      72 signed main_cnt;
_main_cnt:
	.BYTE 0x2
;      73 char out_word;
_out_word:
	.BYTE 0x1
;      74 
;      75 char out_stat[4]; //побитовое состояние реле для двух моторов
_out_stat:
	.BYTE 0x4
;      76 
;      77 
;      78 #include "mcp2510.h"

	.CSEG
_mcp_reset:
	cli
	SBI  0x17,5
	SBI  0x17,3
	CBI  0x17,4
	SBI  0x17,0
	SBI  0x17,2
	RCALL SUBOPT_0x0
	SBI  0x17,0
	CBI  0x18,0
	LDI  R30,LOW(192)
	RCALL SUBOPT_0x1
	SBI  0x18,0
	sei
	RET
_spi_read:
	ST   -Y,R16
;	addr -> Y+1
;	temp -> R16
	cli
	SBI  0x17,5
	SBI  0x17,3
	CBI  0x17,4
	SBI  0x17,0
	SBI  0x17,2
	RCALL SUBOPT_0x0
	SBI  0x17,0
	CBI  0x18,0
	__DELAY_USB 27
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x3
	MOV  R16,R30
	SBI  0x18,0
	sei
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,2
	RET
_spi_bit_modify:
	cli
	SBI  0x17,5
	SBI  0x17,3
	CBI  0x17,4
	SBI  0x17,0
	SBI  0x17,2
	RCALL SUBOPT_0x0
	SBI  0x17,0
	CBI  0x18,0
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x2
	RCALL SUBOPT_0x5
	SBI  0x18,0
	sei
	ADIW R28,3
	RET
_spi_write:
	ST   -Y,R16
;	addr -> Y+2
;	in -> Y+1
;	temp -> R16
	SBI  0x17,5
	SBI  0x17,3
	CBI  0x17,4
	SBI  0x17,0
	SBI  0x17,2
	RCALL SUBOPT_0x0
	SBI  0x17,0
	CBI  0x18,0
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x4
	RCALL SUBOPT_0x2
	SBI  0x18,0
	MOV  R30,R16
	LDD  R16,Y+0
	ADIW R28,3
	RET
_spi_read_status:
	ST   -Y,R16
;	temp -> R16
	cli
	SBI  0x17,5
	SBI  0x17,3
	CBI  0x17,4
	SBI  0x17,0
	SBI  0x17,2
	RCALL SUBOPT_0x0
	SBI  0x17,0
	CBI  0x18,0
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	LDI  R30,LOW(160)
	RCALL SUBOPT_0x1
	RCALL SUBOPT_0x3
	MOV  R16,R30
	SBI  0x18,0
	sei
	MOV  R30,R16
	LD   R16,Y+
	RET
_spi_rts:
	cli
	SBI  0x17,5
	SBI  0x17,3
	CBI  0x17,4
	SBI  0x17,0
	SBI  0x17,2
	RCALL SUBOPT_0x0
	SBI  0x17,0
	CBI  0x18,0
	LD   R30,Y
	CPI  R30,0
	BRNE _0x6
	LDI  R30,LOW(129)
	ST   Y,R30
	RJMP _0x7
_0x6:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x8
	LDI  R30,LOW(130)
	ST   Y,R30
	RJMP _0x9
_0x8:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0xA
	LDI  R30,LOW(132)
	ST   Y,R30
_0xA:
_0x9:
_0x7:
	RCALL SUBOPT_0x5
	SBI  0x18,0
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
;      79 #include "mcp_can.c"   
;      80 char can_st,can_st1;

	.DSEG
_can_st:
	.BYTE 0x1
_can_st1:
	.BYTE 0x1
;      81 char ptr_tx_wr,ptr_tx_rd;
_ptr_tx_wr:
	.BYTE 0x1
_ptr_tx_rd:
	.BYTE 0x1
;      82 char fifo_can_in[FIFO_CAN_IN_LEN,13];
_fifo_can_in:
	.BYTE 0x82
;      83 char ptr_rx_wr,ptr_rx_rd;
_ptr_rx_wr:
	.BYTE 0x1
_ptr_rx_rd:
	.BYTE 0x1
;      84 char rx_counter;
_rx_counter:
	.BYTE 0x1
;      85 char fifo_can_out[FIFO_CAN_OUT_LEN,13];
_fifo_can_out:
	.BYTE 0x82
;      86 
;      87 char tx_counter;
_tx_counter:
	.BYTE 0x1
;      88 char rts_delay;
_rts_delay:
	.BYTE 0x1
;      89 bit bMCP_DRV;
;      90 //-----------------------------------------------
;      91 void mcp_drv(void)
;      92 {

	.CSEG
_mcp_drv:
;      93 char j; 
;      94 char data0,data1,data2,data3,data4,data5,data6,data7,data8,data9,data10,data11,data12;
;      95 char ptr,*ptr_;
;      96 if(bMCP_DRV) goto mcp_drv_end;		
	SBIW R28,11
	RCALL __SAVELOCR6
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
	SBRC R3,0
	RJMP _0xC
;      97 bMCP_DRV=1;
	SET
	BLD  R3,0
;      98 //		DDRA.1=1;
;      99 //		PORTA.1=!PORTA.1;
;     100 if(rts_delay)rts_delay--;
	RCALL SUBOPT_0x6
	BREQ _0xD
	LDS  R30,_rts_delay
	SUBI R30,LOW(1)
	STS  _rts_delay,R30
;     101 can_st=spi_read_status();
_0xD:
	RCALL _spi_read_status
	STS  _can_st,R30
;     102 //plazma=can_st;
;     103 if(can_st&0b10101000)
	ANDI R30,LOW(0xA8)
	BREQ _0xE
;     104 	{
;     105    	spi_bit_modify(CANINTF,0b00011100,0x00);
	RCALL SUBOPT_0x7
	LDI  R30,LOW(28)
	RCALL SUBOPT_0x8
;     106 	}  
;     107 	
;     108 if(can_st&0b00000001)
_0xE:
	LDS  R30,_can_st
	ANDI R30,LOW(0x1)
	BRNE PC+2
	RJMP _0xF
;     109 	{
;     110      spi_bit_modify(CANINTF,0b00000011,0x00);
	RCALL SUBOPT_0x7
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x8
;     111 	
;     112 	if(rx_counter<FIFO_CAN_IN_LEN)
	LDS  R26,_rx_counter
	CPI  R26,LOW(0xA)
	BRLO PC+2
	RJMP _0x10
;     113 		{
;     114 		//plazma++;
;     115 		rx_counter++;
	LDS  R30,_rx_counter
	SUBI R30,-LOW(1)
	STS  _rx_counter,R30
;     116 		ptr_=&fifo_can_in[ptr_rx_wr,0];
	RCALL SUBOPT_0x9
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0xB
;     117 		for(j=0;j<13;j++)
	LDI  R16,LOW(0)
_0x12:
	CPI  R16,13
	BRSH _0x13
;     118 	    		{
;     119 	    		*ptr_++=spi_read(RXB0SIDH+j);
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
	RCALL SUBOPT_0xC
	POP  R26
	POP  R27
	ST   X,R30
;     120 			}
	SUBI R16,-1
	RJMP _0x12
_0x13:
;     121 		ptr_=&fifo_can_in[ptr_rx_wr,0];
	RCALL SUBOPT_0x9
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0xB
;     122 		
;     123 		j=ptr_[4];
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,4
	LD   R16,X
;     124 		ptr_[4]=ptr_[3];
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RCALL SUBOPT_0xD
	__PUTB1SNS 6,4
;     125 		ptr_[3]=ptr_[2];
	RCALL SUBOPT_0xE
	LD   R30,X
	__PUTB1SNS 6,3
;     126     		ptr_[2]=j;
	RCALL SUBOPT_0xE
	ST   X,R16
;     127     		
;     128     	 	ptr_rx_wr++;
	LDS  R30,_ptr_rx_wr
	SUBI R30,-LOW(1)
	STS  _ptr_rx_wr,R30
;     129 		if(ptr_rx_wr>=FIFO_CAN_IN_LEN)ptr_rx_wr=0; 	 			 
	LDS  R26,_ptr_rx_wr
	CPI  R26,LOW(0xA)
	BRLO _0x14
	LDI  R30,LOW(0)
	STS  _ptr_rx_wr,R30
;     130 		}
_0x14:
;     131 	}  
_0x10:
;     132 else if((!(can_st&0b01010100))&&(!rts_delay))
	RJMP _0x15
_0xF:
	LDS  R30,_can_st
	ANDI R30,LOW(0x54)
	BRNE _0x17
	RCALL SUBOPT_0x6
	BREQ _0x18
_0x17:
	RJMP _0x16
_0x18:
;     133 	{
;     134 	if(tx_counter)
	LDS  R30,_tx_counter
	CPI  R30,0
	BRNE PC+2
	RJMP _0x19
;     135 		{
;     136 		#asm("cli")
	cli
;     137 		ptr_=&(fifo_can_out[ptr_tx_rd,0]);
	RCALL SUBOPT_0xF
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0xB
;     138 
;     139  
;     140 		
;     141 	    	data0=*ptr_++;
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	LD   R17,X+
	RCALL SUBOPT_0x10
;     142 		data1=*ptr_++;
	LD   R18,X+
	RCALL SUBOPT_0x10
;     143 		data2=*ptr_++;
	LD   R19,X+
	RCALL SUBOPT_0x10
;     144 		data3=*ptr_++;
	LD   R20,X+
	RCALL SUBOPT_0x10
;     145 		data4=*ptr_++;
	LD   R21,X+
	RCALL SUBOPT_0x10
;     146 		data5=*ptr_++;
	RCALL SUBOPT_0x11
	STD  Y+16,R30
;     147 		data6=*ptr_++;
	RCALL SUBOPT_0x12
	STD  Y+15,R30
;     148 		data7=*ptr_++;
	RCALL SUBOPT_0x12
	STD  Y+14,R30
;     149 		data8=*ptr_++;
	RCALL SUBOPT_0x12
	STD  Y+13,R30
;     150 		data9=*ptr_++;
	RCALL SUBOPT_0x12
	STD  Y+12,R30
;     151 		data10=*ptr_++;
	RCALL SUBOPT_0x12
	STD  Y+11,R30
;     152 		data11=*ptr_++;
	RCALL SUBOPT_0x12
	STD  Y+10,R30
;     153 		data12=*ptr_++; 
	RCALL SUBOPT_0x12
	STD  Y+9,R30
;     154 		
;     155 
;     156 				 
;     157           ptr_=&(fifo_can_out[ptr_tx_rd,0]);
	RCALL SUBOPT_0xF
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0xB
;     158 		tx_counter--;
	LDS  R30,_tx_counter
	SUBI R30,LOW(1)
	STS  _tx_counter,R30
;     159 		ptr_tx_rd++;
	LDS  R30,_ptr_tx_rd
	SUBI R30,-LOW(1)
	STS  _ptr_tx_rd,R30
;     160 		if(ptr_tx_rd>=FIFO_CAN_OUT_LEN) 
	LDS  R26,_ptr_tx_rd
	CPI  R26,LOW(0xA)
	BRLO _0x1A
;     161 			
;     162 			{
;     163 			ptr_tx_rd=0;
	LDI  R30,LOW(0)
	STS  _ptr_tx_rd,R30
;     164 			}
;     165           #asm("sei")
_0x1A:
	sei
;     166           
;     167         	spi_write(TXB0SIDH,data0);
	LDI  R30,LOW(49)
	ST   -Y,R30
	ST   -Y,R17
	RCALL _spi_write
;     168   		spi_write(TXB0SIDL,data1);
	RCALL SUBOPT_0x13
	ST   -Y,R18
	RCALL _spi_write
;     169   		spi_write(TXB0DLC,data2&0b10111111);
	LDI  R30,LOW(53)
	ST   -Y,R30
	MOV  R30,R19
	ANDI R30,0xBF
	RCALL SUBOPT_0x14
;     170    	     spi_write(TXB0EID8,data3);
	LDI  R30,LOW(51)
	ST   -Y,R30
	ST   -Y,R20
	RCALL _spi_write
;     171     	     spi_write(TXB0EID0,data4);
	LDI  R30,LOW(52)
	ST   -Y,R30
	ST   -Y,R21
	RCALL _spi_write
;     172   		spi_write(TXB0D0,data5);
	LDI  R30,LOW(54)
	ST   -Y,R30
	LDD  R30,Y+17
	RCALL SUBOPT_0x14
;     173 		spi_write(TXB0D1,data6);
	LDI  R30,LOW(55)
	ST   -Y,R30
	LDD  R30,Y+16
	RCALL SUBOPT_0x14
;     174 		spi_write(TXB0D2,data7);
	LDI  R30,LOW(56)
	ST   -Y,R30
	LDD  R30,Y+15
	RCALL SUBOPT_0x14
;     175 		spi_write(TXB0D3,data8);
	LDI  R30,LOW(57)
	ST   -Y,R30
	LDD  R30,Y+14
	RCALL SUBOPT_0x14
;     176 		spi_write(TXB0D4,data9);
	LDI  R30,LOW(58)
	ST   -Y,R30
	LDD  R30,Y+13
	RCALL SUBOPT_0x14
;     177 		spi_write(TXB0D5,data10);
	LDI  R30,LOW(59)
	ST   -Y,R30
	LDD  R30,Y+12
	RCALL SUBOPT_0x14
;     178 		spi_write(TXB0D6,data11);
	LDI  R30,LOW(60)
	ST   -Y,R30
	LDD  R30,Y+11
	RCALL SUBOPT_0x14
;     179 		spi_write(TXB0D7,data12);
	LDI  R30,LOW(61)
	ST   -Y,R30
	LDD  R30,Y+10
	RCALL SUBOPT_0x14
;     180 																		
;     181 		spi_rts(0);
	RCALL SUBOPT_0x15
	RCALL _spi_rts
;     182           
;     183           rts_delay=5;
	LDI  R30,LOW(5)
	STS  _rts_delay,R30
;     184 		}     
;     185 	}  
_0x19:
;     186 //		DDRA.1=1;
;     187 //		PORTA.1=!PORTA.1; 
;     188             
;     189 bMCP_DRV=0;		
_0x16:
_0x15:
	CLT
	BLD  R3,0
;     190 mcp_drv_end:		
_0xC:
;     191 }
	RCALL __LOADLOCR6
	ADIW R28,17
	RET
;     192 
;     193 //-----------------------------------------------
;     194 void can_out_adr_len(char adr0,char adr1,char* data_ptr,char len)
;     195 {
;     196 char ptr,*ptr_;
;     197 ptr=ptr_tx_wr;
;	adr0 -> Y+7
;	adr1 -> Y+6
;	*data_ptr -> Y+4
;	len -> Y+3
;	ptr -> Y+2
;	*ptr_ -> Y+0
;     198 
;     199 if(tx_counter<FIFO_CAN_OUT_LEN)
;     200 	
;     201 	{
;     202 	tx_counter++; 
;     203 	
;     204 	ptr_tx_wr++;
;     205 	if(ptr_tx_wr>=FIFO_CAN_OUT_LEN) ptr_tx_wr=0;
;     206 
;     207 	ptr_=&fifo_can_out[ptr,0];
;     208 	
;     209 	*ptr_++=adr0;
;     210 	*ptr_++=adr1|0b00001000;
;     211 	if(len>2)*ptr_++=len-2;
;     212 	else *ptr_++=0;
;     213 	*ptr_++=data_ptr[0];
;     214 	*ptr_++=data_ptr[1];
;     215 	*ptr_++=data_ptr[2];
;     216 	*ptr_++=data_ptr[3];
;     217 	*ptr_++=data_ptr[4];
;     218 	*ptr_++=data_ptr[5];
;     219 	*ptr_++=data_ptr[6];
;     220 	*ptr_++=data_ptr[7];
;     221 	*ptr_++=data_ptr[8];
;     222 	*ptr_++=data_ptr[9];
;     223 	} 
;     224 
;     225 
;     226 } 
;     227 
;     228 //-----------------------------------------------
;     229 void can_out_adr(char adr0,char adr1,char* data_ptr)
;     230 {
_can_out_adr:
;     231 char ptr,*ptr_;
;     232 ptr=ptr_tx_wr;
	SBIW R28,3
;	adr0 -> Y+6
;	adr1 -> Y+5
;	*data_ptr -> Y+3
;	ptr -> Y+2
;	*ptr_ -> Y+0
	LDS  R30,_ptr_tx_wr
	STD  Y+2,R30
;     233 #asm("cli")
	cli
;     234 if(tx_counter<FIFO_CAN_OUT_LEN)
	LDS  R26,_tx_counter
	CPI  R26,LOW(0xA)
	BRLO PC+2
	RJMP _0x1F
;     235 	
;     236 	{
;     237 	tx_counter++; 
	LDS  R30,_tx_counter
	SUBI R30,-LOW(1)
	STS  _tx_counter,R30
;     238 	
;     239 	ptr_tx_wr++;
	LDS  R30,_ptr_tx_wr
	SUBI R30,-LOW(1)
	STS  _ptr_tx_wr,R30
;     240 	if(ptr_tx_wr>=FIFO_CAN_OUT_LEN) ptr_tx_wr=0;
	LDS  R26,_ptr_tx_wr
	CPI  R26,LOW(0xA)
	BRLO _0x20
	LDI  R30,LOW(0)
	STS  _ptr_tx_wr,R30
;     241 
;     242 	ptr_=&fifo_can_out[ptr,0];
_0x20:
	LDD  R30,Y+2
	LDI  R26,LOW(_fifo_can_out)
	LDI  R27,HIGH(_fifo_can_out)
	LDI  R31,0
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ST   Y,R30
	STD  Y+1,R31
;     243 	
;     244 	*ptr_++=adr0;
	RCALL SUBOPT_0x16
	LDD  R30,Y+6
	RCALL SUBOPT_0x17
;     245 	*ptr_++=adr1|0b00001000;
	PUSH R31
	PUSH R30
	LDD  R30,Y+5
	ORI  R30,8
	POP  R26
	POP  R27
	ST   X,R30
;     246 	*ptr_++=8;
	RCALL SUBOPT_0x16
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x17
;     247 	*ptr_++=data_ptr[0];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     248 	*ptr_++=data_ptr[1];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,1
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     249 	*ptr_++=data_ptr[2];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,2
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     250 	*ptr_++=data_ptr[3];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	RCALL SUBOPT_0xD
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     251 	*ptr_++=data_ptr[4];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,4
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     252 	
;     253 	*ptr_++=data_ptr[5];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,5
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     254 	*ptr_++=data_ptr[6];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,6
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     255 	*ptr_++=data_ptr[7];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,7
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     256 	*ptr_++=data_ptr[8];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,8
	LD   R30,X
	POP  R26
	POP  R27
	RCALL SUBOPT_0x17
;     257 	*ptr_++=data_ptr[9];
	PUSH R31
	PUSH R30
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	ADIW R26,9
	LD   R30,X
	POP  R26
	POP  R27
	ST   X,R30
;     258 	
;     259     //	*ptr_++=0x46;//data_ptr[5];
;     260     //	*ptr_++=/*0x47;//*/data_ptr[6];
;     261     //	*ptr_++=/*0x48;//*/data_ptr[7];
;     262    //	*ptr_++=/*0x49;//*/data_ptr[8];
;     263    //	*ptr_++=0x4a;//data_ptr[9];	
;     264 	}
;     265 #asm("sei")	 
_0x1F:
	sei
;     266 /*fifo_can_out[ptr,0]=adr0;	
;     267 fifo_can_out[ptr,1]=adr1|0b00001000;
;     268 fifo_can_out[ptr,2]=8;
;     269 fifo_can_out[ptr,3]=data_ptr[0];
;     270 fifo_can_out[ptr,4]=data_ptr[1];
;     271 fifo_can_out[ptr,5]=data_ptr[2];
;     272 fifo_can_out[ptr,6]=data_ptr[3];
;     273 fifo_can_out[ptr,7]=data_ptr[4];
;     274 fifo_can_out[ptr,8]=data_ptr[5];
;     275 fifo_can_out[ptr,9]=data_ptr[6];
;     276 fifo_can_out[ptr,10]=data_ptr[7];
;     277 fifo_can_out[ptr,11]=data_ptr[8];
;     278 fifo_can_out[ptr,12]=data_ptr[9];
;     279 
;     280 
;     281 
;     282              
;     283 tx_counter++; */
;     284 
;     285 //DDRA.0=1;
;     286 //PORTA.0=!PORTA.0;
;     287 }                 
	ADIW R28,7
	RET
;     288 
;     289 //-----------------------------------------------
;     290 void gran_ring_char(signed char *adr, signed char min, signed char max)
;     291 {
;     292 if (*adr<min) *adr=max;
;     293 if (*adr>max) *adr=min; 
;     294 } 
;     295  
;     296 //-----------------------------------------------
;     297 void gran_char(signed char *adr, signed char min, signed char max)
;     298 {
_gran_char:
;     299 if (*adr<min) *adr=min;
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R26,X
	LDD  R30,Y+1
	CP   R26,R30
	BRGE _0x23
	RCALL SUBOPT_0x18
;     300 if (*adr>max) *adr=max; 
_0x23:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LD   R26,X
	LD   R30,Y
	CP   R30,R26
	BRGE _0x24
	RCALL SUBOPT_0x18
;     301 } 
_0x24:
	ADIW R28,4
	RET
;     302 
;     303 //-----------------------------------------------
;     304 void gran(signed int *adr, signed int min, signed int max)
;     305 {
;     306 if (*adr<min) *adr=min;
;     307 if (*adr>max) *adr=max; 
;     308 } 
;     309 
;     310 //-----------------------------------------------
;     311 void gran_ring(signed int *adr, signed int min, signed int max)
;     312 {
;     313 if (*adr<min) *adr=max;
;     314 if (*adr>max) *adr=min; 
;     315 } 
;     316 
;     317 //-----------------------------------------------
;     318 void granee_ee(eeprom signed int *adr, signed int min, eeprom signed int* adr_max)
;     319 {
;     320 if (*adr<min) *adr=min;
;     321 if (*adr>*adr_max) *adr=*adr_max; 
;     322 } 
;     323 
;     324 //-----------------------------------------------
;     325 void granee(eeprom signed int *adr, signed int min, signed int max)
;     326 {
;     327 if (*adr<min) *adr=min;
;     328 if (*adr>max) *adr=max; 
;     329 } 
;     330 
;     331 //-----------------------------------------------
;     332 void gran_ring_ee(eeprom signed int *adr, signed int min, signed int max)
;     333 {
;     334 if (*adr<min) *adr=min;
;     335 if (*adr>max) *adr=max; 
;     336 } 
;     337 
;     338 //-----------------------------------------------
;     339 void can_init(void)
;     340 {
_can_init:
;     341 char spi_temp;
;     342 mcp_reset();
	ST   -Y,R16
;	spi_temp -> R16
	RCALL _mcp_reset
;     343 spi_temp=spi_read(CANSTAT);
	LDI  R30,LOW(14)
	RCALL SUBOPT_0xC
	MOV  R16,R30
;     344 if((spi_temp&0xe0)!=0x80)
	MOV  R30,R16
	ANDI R30,LOW(0xE0)
	CPI  R30,LOW(0x80)
	BREQ _0x2F
;     345 	{
;     346 	spi_bit_modify(CANCTRL,0xe0,0x80);
	RCALL SUBOPT_0x19
	LDI  R30,LOW(224)
	ST   -Y,R30
	LDI  R30,LOW(128)
	RCALL SUBOPT_0x1A
;     347 	}
;     348 delay_us(10);	
_0x2F:
	__DELAY_USB 27
;     349 spi_write(CNF1,CNF1_INIT);
	LDI  R30,LOW(42)
	RCALL SUBOPT_0x1B
;     350 spi_write(CNF2,CNF2_INIT);
	LDI  R30,LOW(41)
	ST   -Y,R30
	LDI  R30,LOW(252)
	RCALL SUBOPT_0x14
;     351 spi_write(CNF3,CNF3_INIT);
	LDI  R30,LOW(40)
	RCALL SUBOPT_0x1B
;     352 
;     353 spi_write(RXB0CTRL,0b01000000);	// Расширенный идентификатор
	LDI  R30,LOW(96)
	RCALL SUBOPT_0x1C
;     354 spi_write(RXB1CTRL,0b01000000);	// Расширенный идентификатор
	LDI  R30,LOW(112)
	RCALL SUBOPT_0x1C
;     355 
;     356 spi_write(RXM0SIDH, 0xf8); 
	LDI  R30,LOW(32)
	ST   -Y,R30
	LDI  R30,LOW(248)
	RCALL SUBOPT_0x14
;     357 spi_write(RXM0SIDL, 0xe3); 
	LDI  R30,LOW(33)
	ST   -Y,R30
	LDI  R30,LOW(227)
	RCALL SUBOPT_0x14
;     358 spi_write(RXM0EID8, 0x00); 
	LDI  R30,LOW(34)
	RCALL SUBOPT_0x1D
;     359 spi_write(RXM0EID0, 0x00); 
	LDI  R30,LOW(35)
	RCALL SUBOPT_0x1D
;     360 
;     361 
;     362 spi_write(RXF0SIDH, 0b00000000+((adres<<5)&0xe0)); 
	RCALL SUBOPT_0x15
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x14
;     363 spi_write(RXF0SIDL, 0b00001000);
	RCALL SUBOPT_0x1E
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x14
;     364 spi_write(RXF0EID8, 0x00000000); 
	LDI  R30,LOW(2)
	RCALL SUBOPT_0x1D
;     365 spi_write(RXF0EID0, 0b00000000);
	LDI  R30,LOW(3)
	RCALL SUBOPT_0x1D
;     366 
;     367 
;     368 spi_write(RXM1SIDH, 0xff); 
	LDI  R30,LOW(36)
	RCALL SUBOPT_0x1F
;     369 spi_write(RXM1SIDL, 0xff); 
	LDI  R30,LOW(37)
	RCALL SUBOPT_0x1F
;     370 spi_write(RXM1EID8, 0xff); 
	LDI  R30,LOW(38)
	RCALL SUBOPT_0x1F
;     371 spi_write(RXM1EID0, 0xff);
	LDI  R30,LOW(39)
	RCALL SUBOPT_0x1F
;     372 
;     373 delay_ms(10);
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	RCALL SUBOPT_0x20
;     374 
;     375 
;     376 
;     377 spi_bit_modify(CANCTRL,0xe7,0b00000110);
	RCALL SUBOPT_0x19
	LDI  R30,LOW(231)
	ST   -Y,R30
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x1A
;     378 
;     379 spi_write(CANINTE,0b00011111);
	LDI  R30,LOW(43)
	ST   -Y,R30
	LDI  R30,LOW(31)
	RCALL SUBOPT_0x14
;     380 delay_ms(100);
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RCALL SUBOPT_0x20
;     381 spi_write(BFPCTRL,0b00000000);  
	LDI  R30,LOW(12)
	RCALL SUBOPT_0x1D
;     382 
;     383 }             
	LD   R16,Y+
	RET
;     384 
;     385 //-----------------------------------------------
;     386 void transmit_hndl(void)
;     387 {
_transmit_hndl:
;     388 data_out[0]=flags[0];    
	LDS  R30,_flags
	STS  _data_out,R30
;     389 data_out[1]=flags[1];
	__GETB1MN _flags,1
	__PUTB1MN _data_out,1
;     390 data_out[2]=*((char*)&curr_ch_buff_[0]);
	LDS  R30,_curr_ch_buff_
	__PUTB1MN _data_out,2
;     391 data_out[3]=*(((char*)&curr_ch_buff_[0])+1); 
	__GETB1MN _curr_ch_buff_,1
	__PUTB1MN _data_out,3
;     392 data_out[4]=*((char*)&curr_ch_buff_[1]);
	__GETB1MN _curr_ch_buff_,2
	__PUTB1MN _data_out,4
;     393 data_out[5]=*(((char*)&curr_ch_buff_[1])+1);
	__GETB1MN _curr_ch_buff_,3
	__PUTB1MN _data_out,5
;     394 data_out[6]=*((char*)&curr_ch_buff_[2]);
	__GETB1MN _curr_ch_buff_,4
	__PUTB1MN _data_out,6
;     395 data_out[7]=*(((char*)&curr_ch_buff_[2])+1);
	__GETB1MN _curr_ch_buff_,5
	__PUTB1MN _data_out,7
;     396 data_out[8]=*((char*)&curr_ch_buff_[3]);
	__GETB1MN _curr_ch_buff_,6
	__PUTB1MN _data_out,8
;     397 data_out[9]=*(((char*)&curr_ch_buff_[3])+1);
	__GETB1MN _curr_ch_buff_,7
	__PUTB1MN _data_out,9
;     398 
;     399 
;     400 /*
;     401 data_out[2]=*((char*)&adc_buff_zero_curr_[0]);
;     402 data_out[3]=*(((char*)&adc_buff_zero_curr_[0])+1); 
;     403 data_out[4]=*((char*)&adc_buff_zero_curr_[1]);
;     404 data_out[5]=*(((char*)&adc_buff_zero_curr_[1])+1);
;     405 data_out[6]=*((char*)&adc_buff_zero_curr_[2]);
;     406 data_out[7]=*(((char*)&adc_buff_zero_curr_[2])+1);
;     407 data_out[8]=*((char*)&adc_buff_zero_curr_[3]);
;     408 data_out[9]=*(((char*)&adc_buff_zero_curr_[3])+1);
;     409 */
;     410 
;     411 data_out[10]=*((char*)&plazma_int[0]);
	LDS  R30,_plazma_int
	__PUTB1MN _data_out,10
;     412 data_out[11]=*(((char*)&plazma_int[0])+1);
	__GETB1MN _plazma_int,1
	__PUTB1MN _data_out,11
;     413 data_out[12]=av_serv[0];
	LDS  R30,_av_serv
	__PUTB1MN _data_out,12
;     414 data_out[13]=av_serv[0]; 
	__PUTB1MN _data_out,13
;     415 data_out[14]=av_serv[1];
	__GETB1MN _av_serv,1
	__PUTB1MN _data_out,14
;     416 data_out[15]=av_serv[1];
	__GETB1MN _av_serv,1
	__PUTB1MN _data_out,15
;     417 data_out[16]=av_serv[2];
	__GETB1MN _av_serv,2
	__PUTB1MN _data_out,16
;     418 data_out[17]=av_serv[2];
	__GETB1MN _av_serv,2
	__PUTB1MN _data_out,17
;     419 data_out[18]=av_serv[3];
	__GETB1MN _av_serv,3
	__PUTB1MN _data_out,18
;     420 data_out[19]=av_serv[3];
	__GETB1MN _av_serv,3
	__PUTB1MN _data_out,19
;     421 
;     422 data_out[20]=*((char*)&plazma_int[1]);
	__GETB1MN _plazma_int,2
	__PUTB1MN _data_out,20
;     423 data_out[21]=*(((char*)&plazma_int[1])+1);
	__GETB1MN _plazma_int,3
	__PUTB1MN _data_out,21
;     424 data_out[22]=av_upp[0];
	LDS  R30,_av_upp
	__PUTB1MN _data_out,22
;     425 data_out[23]=av_upp[0]; 
	__PUTB1MN _data_out,23
;     426 data_out[24]=av_upp[1];
	__GETB1MN _av_upp,1
	__PUTB1MN _data_out,24
;     427 data_out[25]=av_upp[1];
	__GETB1MN _av_upp,1
	__PUTB1MN _data_out,25
;     428 data_out[26]=av_upp[2];
	__GETB1MN _av_upp,2
	__PUTB1MN _data_out,26
;     429 data_out[27]=av_upp[2];
	__GETB1MN _av_upp,2
	__PUTB1MN _data_out,27
;     430 data_out[28]=av_upp[3];
	__GETB1MN _av_upp,3
	__PUTB1MN _data_out,28
;     431 data_out[29]=av_upp[3];
	__GETB1MN _av_upp,3
	__PUTB1MN _data_out,29
;     432 
;     433 can_out_adr(0b00001000,0b00000001+((adres<<5)&0xe0),&data_out[0]);
	LDI  R30,LOW(8)
	RCALL SUBOPT_0x21
	LDI  R30,LOW(_data_out)
	LDI  R31,HIGH(_data_out)
	RCALL SUBOPT_0x22
;     434 can_out_adr(0b00001001,0b00000001+((adres<<5)&0xe0),&data_out[10]);
	LDI  R30,LOW(9)
	RCALL SUBOPT_0x21
	__POINTW1MN _data_out,10
	RCALL SUBOPT_0x22
;     435 can_out_adr(0b00001010,0b00000001+((adres<<5)&0xe0),&data_out[20]);
	LDI  R30,LOW(10)
	RCALL SUBOPT_0x21
	__POINTW1MN _data_out,20
	RCALL SUBOPT_0x22
;     436 }
	RET
;     437 
;     438 //-----------------------------------------------
;     439 void log_in_drv(void)
;     440 {
_log_in_drv:
;     441 if(PINC.0)serv_cnt[0]++;
	SBIS 0x13,0
	RJMP _0x30
	RCALL SUBOPT_0x23
	SUBI R30,-LOW(1)
	RJMP _0xED
;     442 else serv_cnt[0]--;
_0x30:
	RCALL SUBOPT_0x23
	SUBI R30,LOW(1)
_0xED:
	ST   X,R30
;     443 gran_char(&serv_cnt[0],0,100); 
	LDI  R30,LOW(_serv_cnt)
	LDI  R31,HIGH(_serv_cnt)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x25
;     444 if(serv_cnt[0]>=90)av_serv[0]=avsON;
	LDS  R26,_serv_cnt
	CPI  R26,LOW(0x5A)
	BRLT _0x32
	LDI  R30,LOW(85)
	STS  _av_serv,R30
;     445 else if(serv_cnt[0]<=10)av_serv[0]=avsOFF;
	RJMP _0x33
_0x32:
	LDS  R26,_serv_cnt
	RCALL SUBOPT_0x26
	BRLT _0x34
	LDI  R30,LOW(170)
	STS  _av_serv,R30
;     446 
;     447 if(PINC.1)serv_cnt[1]++;
_0x34:
_0x33:
	SBIS 0x13,1
	RJMP _0x35
	__POINTW2MN _serv_cnt,1
	RCALL SUBOPT_0x27
	RJMP _0xEE
;     448 else serv_cnt[1]--;
_0x35:
	__POINTW2MN _serv_cnt,1
	RCALL SUBOPT_0x28
_0xEE:
	ST   X,R30
;     449 gran_char(&serv_cnt[1],0,100); 
	__POINTW1MN _serv_cnt,1
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x25
;     450 if(serv_cnt[1]>=90)av_serv[1]=avsON;
	__GETB2MN _serv_cnt,1
	CPI  R26,LOW(0x5A)
	BRLT _0x37
	LDI  R30,LOW(85)
	__PUTB1MN _av_serv,1
;     451 else if(serv_cnt[1]<=10)av_serv[1]=avsOFF;
	RJMP _0x38
_0x37:
	__GETB2MN _serv_cnt,1
	RCALL SUBOPT_0x26
	BRLT _0x39
	LDI  R30,LOW(170)
	__PUTB1MN _av_serv,1
;     452 
;     453 if(PIND.0)serv_cnt[2]++;
_0x39:
_0x38:
	SBIS 0x10,0
	RJMP _0x3A
	__POINTW2MN _serv_cnt,2
	RCALL SUBOPT_0x27
	RJMP _0xEF
;     454 else serv_cnt[2]--;
_0x3A:
	__POINTW2MN _serv_cnt,2
	RCALL SUBOPT_0x28
_0xEF:
	ST   X,R30
;     455 gran_char(&serv_cnt[2],0,100); 
	__POINTW1MN _serv_cnt,2
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x25
;     456 if(serv_cnt[2]>=90)av_serv[2]=avsON;
	__GETB2MN _serv_cnt,2
	CPI  R26,LOW(0x5A)
	BRLT _0x3C
	LDI  R30,LOW(85)
	__PUTB1MN _av_serv,2
;     457 else if(serv_cnt[2]<=10)av_serv[2]=avsOFF;
	RJMP _0x3D
_0x3C:
	__GETB2MN _serv_cnt,2
	RCALL SUBOPT_0x26
	BRLT _0x3E
	LDI  R30,LOW(170)
	__PUTB1MN _av_serv,2
;     458 
;     459 if(PIND.6)serv_cnt[3]++;
_0x3E:
_0x3D:
	SBIS 0x10,6
	RJMP _0x3F
	__POINTW2MN _serv_cnt,3
	RCALL SUBOPT_0x27
	RJMP _0xF0
;     460 else serv_cnt[3]--;
_0x3F:
	__POINTW2MN _serv_cnt,3
	RCALL SUBOPT_0x28
_0xF0:
	ST   X,R30
;     461 gran_char(&serv_cnt[3],0,100); 
	__POINTW1MN _serv_cnt,3
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x25
;     462 if(serv_cnt[3]>=90)av_serv[3]=avsON;
	__GETB2MN _serv_cnt,3
	CPI  R26,LOW(0x5A)
	BRLT _0x41
	LDI  R30,LOW(85)
	__PUTB1MN _av_serv,3
;     463 else if(serv_cnt[3]<=10)av_serv[3]=avsOFF;
	RJMP _0x42
_0x41:
	__GETB2MN _serv_cnt,3
	RCALL SUBOPT_0x26
	BRLT _0x43
	LDI  R30,LOW(170)
	__PUTB1MN _av_serv,3
;     464 
;     465 
;     466 DDRC&=0xfc;
_0x43:
_0x42:
	IN   R30,0x14
	ANDI R30,LOW(0xFC)
	OUT  0x14,R30
;     467 PORTC|=0x03; 
	IN   R30,0x15
	ORI  R30,LOW(0x3)
	OUT  0x15,R30
;     468 DDRD&=0xbe;
	IN   R30,0x11
	ANDI R30,LOW(0xBE)
	OUT  0x11,R30
;     469 PORTD|=0x41;
	IN   R30,0x12
	ORI  R30,LOW(0x41)
	OUT  0x12,R30
;     470 }
	RET
;     471 
;     472 
;     473 //-----------------------------------------------
;     474 void out_hndl(void)
;     475 {  
_out_hndl:
;     476 char i;
;     477 for(i=0;i<4;i++)
	ST   -Y,R16
;	i -> R16
	LDI  R16,LOW(0)
_0x45:
	CPI  R16,4
	BRSH _0x46
;     478 	{
;     479 	if(dv_stat[i]==dvOFF)
	RCALL SUBOPT_0x29
	CPI  R30,LOW(0x81)
	BRNE _0x47
;     480 		{
;     481 		out_stat[i]=0;
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x2B
;     482 		}             
;     483 	else if(dv_stat[i]==dvSTAR)
	RJMP _0x48
_0x47:
	RCALL SUBOPT_0x29
	CPI  R30,LOW(0x42)
	BRNE _0x49
;     484 		{
;     485 		out_stat[i]=(1<<RELE1);
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x2C
;     486 		}
;     487 	else if(dv_stat[i]==dvTRIAN)
	RJMP _0x4A
_0x49:
	RCALL SUBOPT_0x29
	CPI  R30,LOW(0x24)
	BRNE _0x4B
;     488 		{
;     489 		out_stat[i]=(1<<RELE1);
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x2C
;     490 		} 
;     491 	else if(dv_stat[i]==dvFULL)
	RJMP _0x4C
_0x4B:
	RCALL SUBOPT_0x29
	CPI  R30,LOW(0x99)
	BRNE _0x4D
;     492 		{
;     493 		out_stat[i]=(1<<RELE1);
	RCALL SUBOPT_0x2A
	RCALL SUBOPT_0x2C
;     494 		} 
;     495 	else if(dv_stat[i]==dvFR)
	RJMP _0x4E
_0x4D:
	RCALL SUBOPT_0x29
	CPI  R30,LOW(0x66)
	BRNE _0x4F
;     496 		{
;     497 		out_stat[i]=(1<<RELE2);
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(2)
	RJMP _0xF1
;     498 		}		
;     499 	else out_stat[i]=0;						
_0x4F:
	RCALL SUBOPT_0x2A
	LDI  R30,LOW(0)
_0xF1:
	ST   X,R30
_0x4E:
_0x4C:
_0x4A:
_0x48:
;     500 	if(dv_cnt[i])dv_cnt[i]--;		
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_dv_cnt)
	SBCI R31,HIGH(-_dv_cnt)
	LD   R30,Z
	CPI  R30,0
	BREQ _0x51
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_dv_cnt)
	SBCI R27,HIGH(-_dv_cnt)
	RCALL SUBOPT_0x28
	ST   X,R30
;     501 	}
_0x51:
	SUBI R16,-1
	RJMP _0x45
_0x46:
;     502 }
	RJMP _0xEC
;     503 
;     504 //-----------------------------------------------
;     505 void out_drv(void)
;     506 {
_out_drv:
;     507 char i; 
;     508 
;     509 DDRD.1=1;
	ST   -Y,R16
;	i -> R16
	SBI  0x11,1
;     510 if(out_stat[0]&(1<<RELE1))PORTD.2=1;
	LDS  R30,_out_stat
	ANDI R30,LOW(0x1)
	BREQ _0x52
	SBI  0x12,2
;     511 else PORTD.2=0;
	RJMP _0x53
_0x52:
	CBI  0x12,2
_0x53:
;     512 
;     513 DDRD.2=1; 
	SBI  0x11,2
;     514 if(out_stat[0]&(1<<RELE2))PORTD.1=1;
	LDS  R30,_out_stat
	ANDI R30,LOW(0x2)
	BREQ _0x54
	SBI  0x12,1
;     515 else PORTD.1=0;
	RJMP _0x55
_0x54:
	CBI  0x12,1
_0x55:
;     516 
;     517 out_word=0;
	LDI  R30,LOW(0)
	STS  _out_word,R30
;     518 if(out_stat[1]&(1<<RELE1))out_word|=(1<<0);
	__GETB1MN _out_stat,1
	ANDI R30,LOW(0x1)
	BREQ _0x56
	LDS  R30,_out_word
	ORI  R30,1
	STS  _out_word,R30
;     519 if(out_stat[1]&(1<<RELE2))out_word|=(1<<1);
_0x56:
	__GETB1MN _out_stat,1
	ANDI R30,LOW(0x2)
	BREQ _0x57
	LDS  R30,_out_word
	ORI  R30,2
	STS  _out_word,R30
;     520 
;     521 if(out_stat[2]&(1<<RELE1))out_word|=(1<<2);
_0x57:
	__GETB1MN _out_stat,2
	ANDI R30,LOW(0x1)
	BREQ _0x58
	LDS  R30,_out_word
	ORI  R30,4
	STS  _out_word,R30
;     522 if(out_stat[2]&(1<<RELE2))out_word|=(1<<3);
_0x58:
	__GETB1MN _out_stat,2
	ANDI R30,LOW(0x2)
	BREQ _0x59
	LDS  R30,_out_word
	ORI  R30,8
	STS  _out_word,R30
;     523 
;     524 if(out_stat[3]&(1<<RELE1))out_word|=(1<<4);
_0x59:
	__GETB1MN _out_stat,3
	ANDI R30,LOW(0x1)
	BREQ _0x5A
	LDS  R30,_out_word
	ORI  R30,0x10
	STS  _out_word,R30
;     525 if(out_stat[3]&(1<<RELE2))out_word|=(1<<5);
_0x5A:
	__GETB1MN _out_stat,3
	ANDI R30,LOW(0x2)
	BREQ _0x5B
	LDS  R30,_out_word
	ORI  R30,0x20
	STS  _out_word,R30
;     526 
;     527 spi(out_word);
_0x5B:
	LDS  R30,_out_word
	RCALL SUBOPT_0x1
;     528 DDRD.3=1;
	SBI  0x11,3
;     529 PORTD.3=1;
	SBI  0x12,3
;     530 delay_us(100);
	__DELAY_USW 200
;     531 PORTD.3=0;
	CBI  0x12,3
;     532 
;     533 
;     534 }
	RJMP _0xEC
;     535 
;     536 //-----------------------------------------------
;     537 void avar_drv(void)
;     538 {
_avar_drv:
;     539 //adc_bank_[5] - датчик т-ры двигателя №1
;     540 //adc_bank_[7] - датчик вл. двигателя №1
;     541 //adc_bank_[3] - датчик т-ры двигателя №2
;     542 //adc_bank_[0] - датчик вл. двигателя №2
;     543 
;     544 char i;
;     545 signed temp_S;
;     546 char temp;
;     547 
;     548 for(i=0;i<2;i++)
	RCALL __SAVELOCR4
;	i -> R16
;	temp_S -> R17,R18
;	temp -> R19
	LDI  R16,LOW(0)
_0x5D:
	CPI  R16,2
	BRLO PC+2
	RJMP _0x5E
;     549 	{
;     550 	temp_S=adc_buff_[PTR_IN_TEMPER[i]];
	LDI  R26,LOW(_PTR_IN_TEMPER*2)
	LDI  R27,HIGH(_PTR_IN_TEMPER*2)
	RCALL SUBOPT_0x2D
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x2F
	LD   R17,X+
	LD   R18,X
;     551 	if((temp_S>680)&&(main_cnt>10))
	LDI  R30,LOW(680)
	LDI  R31,HIGH(680)
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x60
	RCALL SUBOPT_0x30
	BRLT _0x61
_0x60:
	RJMP _0x5F
_0x61:
;     552 		{
;     553 		cnt_avtHH[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avtHH)
	SBCI R27,HIGH(-_cnt_avtHH)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x31
;     554 		cnt_avtKZ[i]=0;
	RCALL SUBOPT_0x32
;     555 		cnt_avtON[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x33
;     556 		cnt_avtOFF[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x34
;     557 		gran_char(&cnt_avtHH[i],0,50);
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_cnt_avtHH)
	SBCI R31,HIGH(-_cnt_avtHH)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     558 		if(cnt_avtHH[i]>=50) av_temper[i]=avtHH;
	SUBI R30,LOW(-_cnt_avtHH)
	SBCI R31,HIGH(-_cnt_avtHH)
	RCALL SUBOPT_0x36
	BRLT _0x62
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_temper)
	SBCI R27,HIGH(-_av_temper)
	RCALL SUBOPT_0x37
;     559 		}
_0x62:
;     560 	else if((temp_S<15)&&(main_cnt>10))
	RJMP _0x63
_0x5F:
	__CPWRN 17,18,15
	BRGE _0x65
	RCALL SUBOPT_0x30
	BRLT _0x66
_0x65:
	RJMP _0x64
_0x66:
;     561 		{
;     562 		cnt_avtHH[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x38
;     563 		cnt_avtKZ[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avtKZ)
	SBCI R27,HIGH(-_cnt_avtKZ)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x31
;     564 		cnt_avtON[i]=0;
	RCALL SUBOPT_0x33
;     565 		cnt_avtOFF[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x34
;     566 		gran_char(&cnt_avtKZ[i],0,50);
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_cnt_avtKZ)
	SBCI R31,HIGH(-_cnt_avtKZ)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     567 		if(cnt_avtKZ[i]>=50) av_temper[i]=avtKZ;
	SUBI R30,LOW(-_cnt_avtKZ)
	SBCI R31,HIGH(-_cnt_avtKZ)
	RCALL SUBOPT_0x36
	BRLT _0x67
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_temper)
	SBCI R27,HIGH(-_av_temper)
	RCALL SUBOPT_0x39
;     568 		}
_0x67:
;     569 	else if((temp_S>195)&&(main_cnt>10))
	RJMP _0x68
_0x64:
	LDI  R30,LOW(195)
	LDI  R31,HIGH(195)
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x6A
	RCALL SUBOPT_0x30
	BRLT _0x6B
_0x6A:
	RJMP _0x69
_0x6B:
;     570 		{
;     571 		cnt_avtHH[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x38
;     572 		cnt_avtKZ[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x32
;     573 		cnt_avtON[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avtON)
	SBCI R27,HIGH(-_cnt_avtON)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x31
;     574 		cnt_avtOFF[i]=0;
	RCALL SUBOPT_0x34
;     575 		gran_char(&cnt_avtON[i],0,50);
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_cnt_avtON)
	SBCI R31,HIGH(-_cnt_avtON)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     576 		if(cnt_avtON[i]>=50) av_temper[i]=avtON;
	SUBI R30,LOW(-_cnt_avtON)
	SBCI R31,HIGH(-_cnt_avtON)
	RCALL SUBOPT_0x36
	BRLT _0x6C
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_temper)
	SBCI R27,HIGH(-_av_temper)
	RCALL SUBOPT_0x3A
;     577 		}
_0x6C:
;     578 	else if((temp_S<145)&&(main_cnt>10))
	RJMP _0x6D
_0x69:
	__CPWRN 17,18,145
	BRGE _0x6F
	RCALL SUBOPT_0x30
	BRLT _0x70
_0x6F:
	RJMP _0x6E
_0x70:
;     579 		{
;     580 		cnt_avtHH[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x38
;     581 		cnt_avtKZ[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x32
;     582 		cnt_avtON[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x33
;     583 		cnt_avtOFF[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avtOFF)
	SBCI R27,HIGH(-_cnt_avtOFF)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x3B
;     584 		gran_char(&cnt_avtOFF[i],0,50);
	SUBI R30,LOW(-_cnt_avtOFF)
	SBCI R31,HIGH(-_cnt_avtOFF)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     585 		if(cnt_avtOFF[i]>=50) av_temper[i]=avtOFF;
	SUBI R30,LOW(-_cnt_avtOFF)
	SBCI R31,HIGH(-_cnt_avtOFF)
	RCALL SUBOPT_0x36
	BRLT _0x71
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x3C
;     586 		}
_0x71:
;     587 	else if(main_cnt<=10)av_temper[i]=avtOFF;
	RJMP _0x72
_0x6E:
	RCALL SUBOPT_0x30
	BRLT _0x73
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x3C
;     588 	
;     589 	temp_S=adc_buff_[PTR_IN_VL[i]];
_0x73:
_0x72:
_0x6D:
_0x68:
_0x63:
	LDI  R26,LOW(_PTR_IN_VL*2)
	LDI  R27,HIGH(_PTR_IN_VL*2)
	RCALL SUBOPT_0x2D
	ADD  R30,R26
	ADC  R31,R27
	RCALL SUBOPT_0x3D
	LD   R17,X+
	LD   R18,X
;     590 	if((temp_S>670)&&(main_cnt>10))
	LDI  R30,LOW(670)
	LDI  R31,HIGH(670)
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x75
	RCALL SUBOPT_0x30
	BRLT _0x76
_0x75:
	RJMP _0x74
_0x76:
;     591 		{
;     592 		cnt_avvHH[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avvHH)
	SBCI R27,HIGH(-_cnt_avvHH)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x31
;     593 		cnt_avvKZ[i]=0;
	RCALL SUBOPT_0x3E
;     594 		cnt_avvON[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x3F
;     595 		cnt_avvOFF[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x40
;     596 		gran_char(&cnt_avvHH[i],0,50);
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_cnt_avvHH)
	SBCI R31,HIGH(-_cnt_avvHH)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     597 		if(cnt_avvHH[i]>=50) av_vl[i]=avvHH;
	SUBI R30,LOW(-_cnt_avvHH)
	SBCI R31,HIGH(-_cnt_avvHH)
	RCALL SUBOPT_0x36
	BRLT _0x77
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_vl)
	SBCI R27,HIGH(-_av_vl)
	RCALL SUBOPT_0x37
;     598 		}
_0x77:
;     599 	else if((temp_S<20)&&(main_cnt>10))
	RJMP _0x78
_0x74:
	__CPWRN 17,18,20
	BRGE _0x7A
	RCALL SUBOPT_0x30
	BRLT _0x7B
_0x7A:
	RJMP _0x79
_0x7B:
;     600 		{
;     601 		cnt_avvHH[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x41
;     602 		cnt_avvKZ[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avvKZ)
	SBCI R27,HIGH(-_cnt_avvKZ)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x31
;     603 		cnt_avvON[i]=0;
	RCALL SUBOPT_0x3F
;     604 		cnt_avvOFF[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x40
;     605 		gran_char(&cnt_avvKZ[i],0,50);
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_cnt_avvKZ)
	SBCI R31,HIGH(-_cnt_avvKZ)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     606 		if(cnt_avvKZ[i]>=50) av_vl[i]=avvKZ;
	SUBI R30,LOW(-_cnt_avvKZ)
	SBCI R31,HIGH(-_cnt_avvKZ)
	RCALL SUBOPT_0x36
	BRLT _0x7C
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_vl)
	SBCI R27,HIGH(-_av_vl)
	RCALL SUBOPT_0x39
;     607 		}
_0x7C:
;     608 	else if((temp_S<510)&&(main_cnt>10))
	RJMP _0x7D
_0x79:
	__CPWRN 17,18,510
	BRGE _0x7F
	RCALL SUBOPT_0x30
	BRLT _0x80
_0x7F:
	RJMP _0x7E
_0x80:
;     609 		{
;     610 		cnt_avvHH[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x41
;     611 		cnt_avvKZ[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x3E
;     612 		cnt_avvON[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avvON)
	SBCI R27,HIGH(-_cnt_avvON)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x31
;     613 		cnt_avvOFF[i]=0;
	RCALL SUBOPT_0x40
;     614 		gran_char(&cnt_avvON[i],0,50);
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_cnt_avvON)
	SBCI R31,HIGH(-_cnt_avvON)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     615 		if(cnt_avvON[i]>=50) av_vl[i]=avvON;
	SUBI R30,LOW(-_cnt_avvON)
	SBCI R31,HIGH(-_cnt_avvON)
	RCALL SUBOPT_0x36
	BRLT _0x81
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_vl)
	SBCI R27,HIGH(-_av_vl)
	RCALL SUBOPT_0x3A
;     616 		}
_0x81:
;     617 	else if((temp_S>540)&&(main_cnt>10))
	RJMP _0x82
_0x7E:
	LDI  R30,LOW(540)
	LDI  R31,HIGH(540)
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x84
	RCALL SUBOPT_0x30
	BRLT _0x85
_0x84:
	RJMP _0x83
_0x85:
;     618 		{
;     619 		cnt_avvHH[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x41
;     620 		cnt_avvKZ[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x3E
;     621 		cnt_avvON[i]=0;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x3F
;     622 		cnt_avvOFF[i]++;
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_cnt_avvOFF)
	SBCI R27,HIGH(-_cnt_avvOFF)
	RCALL SUBOPT_0x27
	RCALL SUBOPT_0x3B
;     623 		gran_char(&cnt_avvOFF[i],0,50);
	SUBI R30,LOW(-_cnt_avvOFF)
	SBCI R31,HIGH(-_cnt_avvOFF)
	RCALL SUBOPT_0x24
	RCALL SUBOPT_0x13
	RCALL SUBOPT_0x35
;     624 		if(cnt_avvOFF[i]>=50) av_vl[i]=avvOFF;
	SUBI R30,LOW(-_cnt_avvOFF)
	SBCI R31,HIGH(-_cnt_avvOFF)
	RCALL SUBOPT_0x36
	BRLT _0x86
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x42
;     625 		}
_0x86:
;     626 	else if(main_cnt<=10)av_vl[i]=avvOFF;		
	RJMP _0x87
_0x83:
	RCALL SUBOPT_0x30
	BRLT _0x88
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x42
;     627 	}
_0x88:
_0x87:
_0x82:
_0x7D:
_0x78:
	SUBI R16,-1
	RJMP _0x5D
_0x5E:
;     628 
;     629 for(i=0;i<4;i++)
	LDI  R16,LOW(0)
_0x8A:
	CPI  R16,4
	BRSH _0x8B
;     630 	{
;     631 	temp_S=adc_buff_[PTR_IN_UPP[i]];
	LDI  R26,LOW(_PTR_IN_UPP*2)
	LDI  R27,HIGH(_PTR_IN_UPP*2)
	RCALL SUBOPT_0x2D
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	RCALL SUBOPT_0x43
	ADD  R26,R30
	ADC  R27,R31
	LD   R17,X+
	LD   R18,X
;     632 	if(temp_S<100)upp_cnt[i]++;
	__CPWRN 17,18,100
	BRGE _0x8C
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_upp_cnt)
	SBCI R27,HIGH(-_upp_cnt)
	RCALL SUBOPT_0x27
	ST   X,R30
;     633 	else if(temp_S>200) upp_cnt[i]--;
	RJMP _0x8D
_0x8C:
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	CP   R30,R17
	CPC  R31,R18
	BRGE _0x8E
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_upp_cnt)
	SBCI R27,HIGH(-_upp_cnt)
	RCALL SUBOPT_0x28
	ST   X,R30
;     634 	gran_char(&upp_cnt[i],0,10);
_0x8E:
_0x8D:
	RCALL SUBOPT_0x2D
	SUBI R30,LOW(-_upp_cnt)
	SBCI R31,HIGH(-_upp_cnt)
	RCALL SUBOPT_0x24
	LDI  R30,LOW(10)
	ST   -Y,R30
	RCALL SUBOPT_0x35
;     635 	
;     636 	if(upp_cnt[i]>=9)av_upp[i]=avuON;
	RCALL SUBOPT_0x44
	CPI  R30,LOW(0x9)
	BRLT _0x8F
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_upp)
	SBCI R27,HIGH(-_av_upp)
	RCALL SUBOPT_0x3A
;     637 	else if(upp_cnt[i]<=1)av_upp[i]=avuOFF;
	RJMP _0x90
_0x8F:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x44
	MOV  R26,R30
	LDI  R30,LOW(1)
	CP   R30,R26
	BRLT _0x91
	RCALL SUBOPT_0x2E
	SUBI R26,LOW(-_av_upp)
	SBCI R27,HIGH(-_av_upp)
	LDI  R30,LOW(170)
	ST   X,R30
;     638 	}
_0x91:
_0x90:
	SUBI R16,-1
	RJMP _0x8A
_0x8B:
;     639 }
	RJMP _0xEB
;     640 
;     641 
;     642 //-----------------------------------------------
;     643 void can_in_an(void)
;     644 { 
_can_in_an:
;     645 char i;
;     646 
;     647 if((fifo_can_in[ptr_rx_rd,1]&0b11100011)==0b00000000) //сообщение от платы контроллера
	ST   -Y,R16
;	i -> R16
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,1
	LD   R30,Z
	ANDI R30,LOW(0xE3)
	BREQ PC+2
	RJMP _0x92
;     648 	{
;     649 	if(fifo_can_in[ptr_rx_rd,0]==((adres<<5)&0b11100000))//сообщение №0 именно для этой платы расширения
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	CPI  R30,0
	BREQ PC+2
	RJMP _0x93
;     650 		{
;     651 	    
;     652 	    	if((fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])&&
;     653 	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,7])&&
;     654 	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,8]))	
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x46
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x47
	POP  R26
	CP   R30,R26
	BRNE _0x95
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x46
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x48
	POP  R26
	CP   R30,R26
	BRNE _0x95
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x46
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x49
	POP  R26
	CP   R30,R26
	BREQ _0x96
_0x95:
	RJMP _0x94
_0x96:
;     655 	    	   	{
;     656 	    	   	dv_on[0]=fifo_can_in[ptr_rx_rd,6];
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x47
	STS  _dv_on,R30
;     657 	    	   	
;     658 	    	     }
;     659 	    	if((fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])&&
_0x94:
;     660 	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,11])&&
;     661 	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,12]))	dv_on[1]=fifo_can_in[ptr_rx_rd,9];
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4B
	POP  R26
	CP   R30,R26
	BRNE _0x98
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4C
	POP  R26
	CP   R30,R26
	BRNE _0x98
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4D
	POP  R26
	CP   R30,R26
	BREQ _0x99
_0x98:
	RJMP _0x97
_0x99:
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	__PUTB1MN _dv_on,1
;     662 	    	   
;     663 	    	
;     664 	    	for(i=0;i<2;i++)
_0x97:
	LDI  R16,LOW(0)
_0x9B:
	CPI  R16,2
	BRSH _0x9C
;     665 	    		{
;     666 	    		if(dv_on[i]!=dv_on_old[i])
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	PUSH R30
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4F
	POP  R26
	CP   R30,R26
	BREQ _0x9D
;     667 	    			{
;     668 	    			if(dv_on[i]==dvOFF)
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x81)
	BRNE _0x9E
;     669 	    				{
;     670 	    				dv_stat[i]=dvOFF;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x50
;     671 	    				dv_on_old[i]=dvOFF;
	RCALL SUBOPT_0x51
;     672 	    				}                  
;     673 	    			else if(dv_on[i]==dvSTAR)
	RJMP _0x9F
_0x9E:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x42)
	BRNE _0xA0
;     674 	    				{
;     675 	    				dv_stat[i]=dvSTAR;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x52
;     676 	    				dv_cnt[i]=10;
	RCALL SUBOPT_0x53
;     677 	    				dv_on_old[i]=dvSTAR;
	RCALL SUBOPT_0x54
;     678 	    				} 
;     679 	    			else if(dv_on[i]==dvTRIAN)
	RJMP _0xA1
_0xA0:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x24)
	BRNE _0xA2
;     680 	    				{
;     681 	    				dv_stat[i]=dvTRIAN;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x55
;     682 	    				dv_cnt[i]=10;
	RCALL SUBOPT_0x53
;     683 	    				dv_on_old[i]=dvTRIAN;
	RCALL SUBOPT_0x56
;     684 	    				}  
;     685 	    			else if(dv_on[i]==dvFULL)
	RJMP _0xA3
_0xA2:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x99)
	BRNE _0xA4
;     686 	    				{
;     687 	    				dv_stat[i]=dvFULL;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x57
;     688 	    				dv_cnt[i]=35;
	RCALL SUBOPT_0x58
;     689 	    				dv_on_old[i]=dvFULL;
	RCALL SUBOPT_0x59
;     690 	    				}	   
;     691 	    				
;     692 	    			else if(dv_on[i]==dvFR)
	RJMP _0xA5
_0xA4:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x66)
	BRNE _0xA6
;     693 	    				{
;     694 	    				dv_stat[i]=dvFR;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x5A
;     695 	    				dv_cnt[i]=35;
	RCALL SUBOPT_0x58
;     696 	    				dv_on_old[i]=dvFR;
	RCALL SUBOPT_0x5B
;     697 	    				}	  	    				 				 
;     698 	    			}
_0xA6:
_0xA5:
_0xA3:
_0xA1:
_0x9F:
;     699 	    		}   
_0x9D:
	SUBI R16,-1
	RJMP _0x9B
_0x9C:
;     700 	 	}
;     701 	else if(fifo_can_in[ptr_rx_rd,0]==(((adres<<5)&0b11100000)+1))//сообщение №1 именно для этой платы расширения
	RJMP _0xA7
_0x93:
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	CPI  R26,LOW(0x1)
	BREQ PC+2
	RJMP _0xA8
;     702 		{
;     703 		    //	plazma++;
;     704 	    	if((fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,6])&&
;     705 	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,7])&&
;     706 	    	   (fifo_can_in[ptr_rx_rd,5]==fifo_can_in[ptr_rx_rd,8]))	
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x46
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x47
	POP  R26
	CP   R30,R26
	BRNE _0xAA
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x46
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x48
	POP  R26
	CP   R30,R26
	BRNE _0xAA
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x46
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x49
	POP  R26
	CP   R30,R26
	BREQ _0xAB
_0xAA:
	RJMP _0xA9
_0xAB:
;     707 	    	   	{
;     708 	    	   	dv_on[2]=fifo_can_in[ptr_rx_rd,6];
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x47
	__PUTB1MN _dv_on,2
;     709 	    	   	
;     710 	    	     }
;     711 	    	if((fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,10])&&
_0xA9:
;     712 	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,11])&&
;     713 	    	   (fifo_can_in[ptr_rx_rd,9]==fifo_can_in[ptr_rx_rd,12]))	dv_on[3]=fifo_can_in[ptr_rx_rd,9];
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4B
	POP  R26
	CP   R30,R26
	BRNE _0xAD
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4C
	POP  R26
	CP   R30,R26
	BRNE _0xAD
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	PUSH R30
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4D
	POP  R26
	CP   R30,R26
	BREQ _0xAE
_0xAD:
	RJMP _0xAC
_0xAE:
	RCALL SUBOPT_0x45
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0xA
	POP  R26
	POP  R27
	RCALL SUBOPT_0x4A
	__PUTB1MN _dv_on,3
;     714 	    	   
;     715 	    	
;     716 	    	for(i=2;i<4;i++)
_0xAC:
	LDI  R16,LOW(2)
_0xB0:
	CPI  R16,4
	BRSH _0xB1
;     717 	    		{
;     718 	    		if(dv_on[i]!=dv_on_old[i])
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	PUSH R30
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4F
	POP  R26
	CP   R30,R26
	BREQ _0xB2
;     719 	    			{
;     720 	    			if(dv_on[i]==dvOFF)
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x81)
	BRNE _0xB3
;     721 	    				{
;     722 	    				dv_stat[i]=dvOFF;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x50
;     723 	    				dv_on_old[i]=dvOFF;
	RCALL SUBOPT_0x51
;     724 	    				}                  
;     725 	    			else if(dv_on[i]==dvSTAR)
	RJMP _0xB4
_0xB3:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x42)
	BRNE _0xB5
;     726 	    				{
;     727 	    				dv_stat[i]=dvSTAR;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x52
;     728 	    				dv_cnt[i]=10;
	RCALL SUBOPT_0x53
;     729 	    				dv_on_old[i]=dvSTAR;
	RCALL SUBOPT_0x54
;     730 	    				} 
;     731 	    			else if(dv_on[i]==dvTRIAN)
	RJMP _0xB6
_0xB5:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x24)
	BRNE _0xB7
;     732 	    				{
;     733 	    				dv_stat[i]=dvTRIAN;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x55
;     734 	    				dv_cnt[i]=10;
	RCALL SUBOPT_0x53
;     735 	    				dv_on_old[i]=dvTRIAN;
	RCALL SUBOPT_0x56
;     736 	    				}  
;     737 	    			else if(dv_on[i]==dvFULL)
	RJMP _0xB8
_0xB7:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x99)
	BRNE _0xB9
;     738 	    				{
;     739 	    				dv_stat[i]=dvFULL;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x57
;     740 	    				dv_cnt[i]=35;
	RCALL SUBOPT_0x58
;     741 	    				dv_on_old[i]=dvFULL;
	RCALL SUBOPT_0x59
;     742 	    				}
;     743 	    			else if(dv_on[i]==dvFR)
	RJMP _0xBA
_0xB9:
	RCALL SUBOPT_0x2D
	RCALL SUBOPT_0x4E
	CPI  R30,LOW(0x66)
	BRNE _0xBB
;     744 	    				{
;     745 	    				dv_stat[i]=dvFR;
	RCALL SUBOPT_0x2E
	RCALL SUBOPT_0x5A
;     746 	    				dv_cnt[i]=35;
	RCALL SUBOPT_0x58
;     747 	    				dv_on_old[i]=dvFR;
	RCALL SUBOPT_0x5B
;     748 	    				}	    					    				 
;     749 	    			}
_0xBB:
_0xBA:
_0xB8:
_0xB6:
_0xB4:
;     750 	    		}
_0xB2:
	SUBI R16,-1
	RJMP _0xB0
_0xB1:
;     751 	    	}	 	
;     752 	}	
_0xA8:
_0xA7:
;     753 }
_0x92:
_0xEC:
	LD   R16,Y+
	RET
;     754 
;     755 //-----------------------------------------------
;     756 void can_hndl(void)
;     757 {            
_can_hndl:
;     758 while(rx_counter)
_0xBC:
	LDS  R30,_rx_counter
	CPI  R30,0
	BREQ _0xBE
;     759 	{
;     760 	can_in_an();
	RCALL _can_in_an
;     761 	rx_counter--;
	LDS  R30,_rx_counter
	SUBI R30,LOW(1)
	STS  _rx_counter,R30
;     762 	ptr_rx_rd++;
	LDS  R30,_ptr_rx_rd
	SUBI R30,-LOW(1)
	STS  _ptr_rx_rd,R30
;     763 	if(ptr_rx_rd>=FIFO_CAN_IN_LEN)ptr_rx_rd=0;
	LDS  R26,_ptr_rx_rd
	CPI  R26,LOW(0xA)
	BRLO _0xBF
	LDI  R30,LOW(0)
	STS  _ptr_rx_rd,R30
;     764 	
;     765 	}
_0xBF:
	RJMP _0xBC
_0xBE:
;     766 }
	RET
;     767 
;     768 //-----------------------------------------------
;     769 void adc_hndl(void)
;     770 {
_adc_hndl:
;     771 char i,j;
;     772 int temp_UI;
;     773 for(i=0;i<8;i++)
	RCALL __SAVELOCR4
;	i -> R16
;	j -> R17
;	temp_UI -> R18,R19
	LDI  R16,LOW(0)
_0xC1:
	CPI  R16,8
	BRSH _0xC2
;     774 	{  
;     775 	temp_UI=0;
	__GETWRN 18,19,0
;     776 	for(j=0;j<16;j++)
	LDI  R17,LOW(0)
_0xC4:
	CPI  R17,16
	BRSH _0xC5
;     777 		{
;     778 		temp_UI+=adc_buff[i,j];
	MOV  R30,R16
	RCALL SUBOPT_0x5C
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0x5D
	POP  R26
	POP  R27
	RCALL SUBOPT_0x5E
	__ADDWRR 18,19,30,31
;     779 		}
	SUBI R17,-1
	RJMP _0xC4
_0xC5:
;     780 	adc_buff_[i]=temp_UI>>4;	
	MOV  R30,R16
	RCALL SUBOPT_0x43
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	__GETW1R 18,19
	RCALL __ASRW4
	POP  R26
	POP  R27
	RCALL __PUTWP1
;     781 	}
	SUBI R16,-1
	RJMP _0xC1
_0xC2:
;     782 
;     783 for(i=0;i<4;i++)
	LDI  R16,LOW(0)
_0xC7:
	CPI  R16,4
	BRSH _0xC8
;     784 	{  
;     785 	temp_UI=0;
	__GETWRN 18,19,0
;     786 	for(j=0;j<16;j++)
	LDI  R17,LOW(0)
_0xCA:
	CPI  R17,16
	BRSH _0xCB
;     787 		{
;     788 		temp_UI+=curr_ch_buff[i,j];
	MOV  R30,R16
	RCALL SUBOPT_0x5F
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0x5D
	POP  R26
	POP  R27
	RCALL SUBOPT_0x5E
	__ADDWRR 18,19,30,31
;     789 		}
	SUBI R17,-1
	RJMP _0xCA
_0xCB:
;     790 	curr_ch_buff_[i]=temp_UI>>1;
	MOV  R30,R16
	LDI  R26,LOW(_curr_ch_buff_)
	LDI  R27,HIGH(_curr_ch_buff_)
	RCALL SUBOPT_0x60
	PUSH R31
	PUSH R30
	__GETW1R 18,19
	ASR  R31
	ROR  R30
	POP  R26
	POP  R27
	RCALL __PUTWP1
;     791 	
;     792 	//curr_ch_buff_[0]=58;	
;     793 	}	
	SUBI R16,-1
	RJMP _0xC7
_0xC8:
;     794 plazma_int[0]=adc_buff_[PTR_IN_TEMPER[0]];
	LDI  R30,LOW(_PTR_IN_TEMPER*2)
	LDI  R31,HIGH(_PTR_IN_TEMPER*2)
	RCALL SUBOPT_0x2F
	RCALL __GETW1P
	STS  _plazma_int,R30
	STS  _plazma_int+1,R31
;     795 plazma_int[1]=adc_buff_[PTR_IN_TEMPER[1]];
	__POINTW1FN _PTR_IN_TEMPER,1
	RCALL SUBOPT_0x2F
	RCALL __GETW1P
	__PUTW1MN _plazma_int,2
;     796 plazma_int[2]=adc_buff_[PTR_IN_VL[0]];
	LDI  R30,LOW(_PTR_IN_VL*2)
	LDI  R31,HIGH(_PTR_IN_VL*2)
	RCALL SUBOPT_0x3D
	RCALL __GETW1P
	__PUTW1MN _plazma_int,4
;     797 plazma_int[3]=adc_buff_[PTR_IN_VL[1]];	
	__POINTW1FN _PTR_IN_VL,1
	RCALL SUBOPT_0x3D
	RCALL __GETW1P
	__PUTW1MN _plazma_int,6
;     798 }
_0xEB:
	RCALL __LOADLOCR4
	ADIW R28,4
	RET
;     799 
;     800 //-----------------------------------------------
;     801 void adc_drv(void)
;     802 { 
_adc_drv:
;     803 unsigned self_adcw,temp_UI;
;     804 char temp;
;     805 
;     806 DDRB.1=1;
	RCALL __SAVELOCR5
;	self_adcw -> R16,R17
;	temp_UI -> R18,R19
;	temp -> R20
	SBI  0x17,1
;     807              
;     808 self_adcw=ADCW;
	__INWR 16,17,4
;     809 
;     810 if(adc_cnt_main<4)
	RCALL SUBOPT_0x61
	BRLO PC+2
	RJMP _0xCC
;     811 	{
;     812 	if(self_adcw<self_min)self_min=self_adcw; 
	LDS  R30,_self_min
	LDS  R31,_self_min+1
	CP   R16,R30
	CPC  R17,R31
	BRSH _0xCD
	__PUTWMRN _self_min,0,16,17
;     813 	if(self_adcw>self_max)self_max=self_adcw;
_0xCD:
	__CPWRR 12,13,16,17
	BRSH _0xCE
	__MOVEWRR 12,13,16,17
;     814 	
;     815 	self_cnt++;
_0xCE:
	LDS  R30,_self_cnt
	SUBI R30,-LOW(1)
	STS  _self_cnt,R30
;     816 	if(self_cnt>=30)
	LDS  R26,_self_cnt
	CPI  R26,LOW(0x1E)
	BRLO _0xCF
;     817 		{
;     818 		curr_ch_buff[adc_cnt_main,adc_cnt_main1[adc_cnt_main]]=self_max-self_min;
	MOV  R30,R11
	RCALL SUBOPT_0x5F
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0x5D
	POP  R26
	POP  R27
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	RCALL SUBOPT_0x62
	POP  R26
	POP  R27
	RCALL SUBOPT_0x60
	PUSH R31
	PUSH R30
	LDS  R26,_self_min
	LDS  R27,_self_min+1
	__GETW1R 12,13
	SUB  R30,R26
	SBC  R31,R27
	POP  R26
	POP  R27
	RCALL __PUTWP1
;     819 		if(adc_cnt_main==0)
	TST  R11
	BRNE _0xD0
;     820 			{
;     821 		    //	plazma_int[0]=self_max;
;     822 		    //	plazma_int[1]=self_min;
;     823 			}
;     824 		
;     825 		adc_cnt_main1[adc_cnt_main]++;
_0xD0:
	RCALL SUBOPT_0x63
	RCALL SUBOPT_0x27
	ST   X,R30
;     826 		if(adc_cnt_main1[adc_cnt_main]>=16)adc_cnt_main1[adc_cnt_main]=0;
	RCALL SUBOPT_0x62
	CPI  R30,LOW(0x10)
	BRLO _0xD1
	RCALL SUBOPT_0x63
	RCALL SUBOPT_0x2B
;     827 		adc_cnt_main++;
_0xD1:
	INC  R11
;     828 		if(adc_cnt_main<4)
	RCALL SUBOPT_0x61
	BRSH _0xD2
;     829 			{
;     830 			curr_buff=0;
	RCALL SUBOPT_0x64
;     831 			self_cnt=0;
;     832 		    //	self_cnt_zero_for=0;
;     833 			self_cnt_not_zero=0;
;     834 			self_cnt_zero_after=0;
;     835 			self_min=1023;
	RCALL SUBOPT_0x65
;     836 			self_max=0;			
;     837 			} 			
;     838  
;     839 						
;     840 	 	}  		
_0xD2:
;     841 	}
_0xCF:
;     842 else if(adc_cnt_main==4)
	RJMP _0xD3
_0xCC:
	LDI  R30,LOW(4)
	CP   R30,R11
	BRNE _0xD4
;     843 	{
;     844 	adc_buff[adc_ch,adc_ch_cnt]=self_adcw;
	MOV  R30,R14
	RCALL SUBOPT_0x5C
	PUSH R27
	PUSH R26
	RCALL SUBOPT_0x5D
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
;     845 	
;     846 	adc_ch++;
	INC  R14
;     847 	if(adc_ch>=8)
	LDI  R30,LOW(8)
	CP   R14,R30
	BRLO _0xD5
;     848 		{
;     849 		adc_ch=0;
	CLR  R14
;     850 		
;     851 		adc_cnt_main=5;
	LDI  R30,LOW(5)
	RCALL SUBOPT_0x66
;     852 		
;     853 		curr_buff=0;
;     854 		self_cnt=0;
;     855 		//self_cnt_zero_for=0;
;     856 		self_cnt_not_zero=0;
;     857 		self_cnt_zero_after=0;         
;     858 		
;     859 		adc_ch_cnt++;
	LDS  R30,_adc_ch_cnt
	SUBI R30,-LOW(1)
	STS  _adc_ch_cnt,R30
;     860 		if(adc_ch_cnt>=16)adc_ch_cnt=0;
	LDS  R26,_adc_ch_cnt
	CPI  R26,LOW(0x10)
	BRLO _0xD6
	LDI  R30,LOW(0)
	STS  _adc_ch_cnt,R30
;     861 		}
_0xD6:
;     862 	}
_0xD5:
;     863 
;     864 else if(adc_cnt_main==5)
	RJMP _0xD7
_0xD4:
	LDI  R30,LOW(5)
	CP   R30,R11
	BRNE _0xD8
;     865 	{
;     866 	adc_cnt_main=6;
	LDI  R30,LOW(6)
	RCALL SUBOPT_0x66
;     867 	curr_buff=0;
;     868 	self_cnt=0;
;     869     //	self_cnt_zero_for=0;
;     870 	self_cnt_not_zero=0;
;     871 	self_cnt_zero_after=0;
;     872 	self_min=1023;
	RCALL SUBOPT_0x65
;     873 	self_max=0;
;     874 	}
;     875 else if(adc_cnt_main==6)
	RJMP _0xD9
_0xD8:
	LDI  R30,LOW(6)
	CP   R30,R11
	BRNE _0xDA
;     876 	{
;     877 	adc_cnt_main=0;
	CLR  R11
;     878 	curr_buff=0;
	RCALL SUBOPT_0x64
;     879 	self_cnt=0;
;     880     //	self_cnt_zero_for=0;
;     881 	self_cnt_not_zero=0;
;     882 	self_cnt_zero_after=0;
;     883 	self_min=1023;
	RCALL SUBOPT_0x65
;     884 	self_max=0;
;     885 	}	
;     886 				     
;     887 DDRB|=0b11000000;
_0xDA:
_0xD9:
_0xD7:
_0xD3:
	IN   R30,0x17
	ORI  R30,LOW(0xC0)
	OUT  0x17,R30
;     888 DDRD.5=1;
	SBI  0x11,5
;     889 PORTB=(PORTB&0x3f)|(adc_ch<<6); 
	IN   R30,0x18
	ANDI R30,LOW(0x3F)
	PUSH R30
	MOV  R30,R14
	SWAP R30
	ANDI R30,0xF0
	LSL  R30
	LSL  R30
	POP  R26
	OR   R30,R26
	OUT  0x18,R30
;     890 PORTD.5=adc_ch>>2; 
	MOV  R30,R14
	LSR  R30
	LSR  R30
	RCALL __BSTB1
	IN   R30,0x12
	BLD  R30,5
	OUT  0x12,R30
;     891 
;     892 ADCSRA=0x86;
	LDI  R30,LOW(134)
	OUT  0x6,R30
;     893 ADMUX=ADMUX_CONST[adc_cnt_main];
	LDI  R26,LOW(_ADMUX_CONST*2)
	LDI  R27,HIGH(_ADMUX_CONST*2)
	MOV  R30,R11
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	LPM  R30,Z
	OUT  0x7,R30
;     894 ADCSRA|=0x40;	
	SBI  0x6,6
;     895 } 
	RCALL __LOADLOCR5
	ADIW R28,5
	RET
;     896 
;     897 //-----------------------------------------------
;     898 void t0_init(void)
;     899 {
_t0_init:
;     900 TCCR0=0x03;
	LDI  R30,LOW(3)
	OUT  0x33,R30
;     901 TCNT0=-125;
	LDI  R30,LOW(131)
	OUT  0x32,R30
;     902 TIMSK|=0b00000001;
	IN   R30,0x39
	ORI  R30,1
	OUT  0x39,R30
;     903 }                                                
	RET
;     904 
;     905 //***********************************************
;     906 //***********************************************
;     907 //***********************************************
;     908 //***********************************************
;     909 // Timer 0 overflow interrupt service routine
;     910 interrupt [TIM0_OVF] void timer0_ovf_isr(void)
;     911 {
_timer0_ovf_isr:
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
;     912 t0_init();
	RCALL _t0_init
;     913 adc_drv();
	RCALL _adc_drv
;     914 
;     915 b_mcp=!b_mcp;
	LDI  R30,LOW(32)
	EOR  R2,R30
;     916 if(b_mcp)mcp_drv();
	SBRC R2,5
	RCALL _mcp_drv
;     917 if(++t0_cnt0>=10)
	INC  R4
	LDI  R30,LOW(10)
	CP   R4,R30
	BRLO _0xDC
;     918 	{        
;     919 	t0_cnt0=0;
	CLR  R4
;     920 	b100Hz=1;
	SET
	BLD  R2,0
;     921 
;     922     	if(++t0_cnt1>=10)
	INC  R5
	CP   R5,R30
	BRLO _0xDD
;     923     		{
;     924     		t0_cnt1=0;
	CLR  R5
;     925 		b10Hz=1;
	SET
	BLD  R2,1
;     926 		}
;     927     	if(++t0_cnt2>=20)
_0xDD:
	INC  R6
	LDI  R30,LOW(20)
	CP   R6,R30
	BRLO _0xDE
;     928     		{
;     929     		t0_cnt2=0;
	CLR  R6
;     930 		b5Hz=1;
	SET
	BLD  R2,2
;     931 		}
;     932     	if(++t0_cnt3>=50)
_0xDE:
	INC  R7
	LDI  R30,LOW(50)
	CP   R7,R30
	BRLO _0xDF
;     933     		{
;     934     		t0_cnt3=0;
	CLR  R7
;     935 		b2Hz=1;
	SET
	BLD  R2,3
;     936 		}
;     937     	if(++t0_cnt4>=100)
_0xDF:
	INC  R8
	LDI  R30,LOW(100)
	CP   R8,R30
	BRLO _0xE0
;     938     		{
;     939     		t0_cnt4=0;
	CLR  R8
;     940 		b1Hz=1;
	SET
	BLD  R2,4
;     941 		}								
;     942 	}
_0xE0:
;     943 /*DDRB=0xFF;
;     944 PORTB.0=!PORTB.0;*/
;     945 }
_0xDC:
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
	RETI
;     946 
;     947 //===============================================
;     948 //===============================================
;     949 //===============================================
;     950 //===============================================
;     951 void main(void)
;     952 {
_main:
;     953 
;     954 PORTB=0x00;
	LDI  R30,LOW(0)
	OUT  0x18,R30
;     955 DDRB=0x00;
	OUT  0x17,R30
;     956 
;     957 PORTC=0x00;
	OUT  0x15,R30
;     958 DDRC=0x00;
	OUT  0x14,R30
;     959 
;     960 PORTD=0x00;
	OUT  0x12,R30
;     961 DDRD=0x00;
	OUT  0x11,R30
;     962 
;     963 TCCR1A=0x00;
	OUT  0x2F,R30
;     964 TCCR1B=0x00;
	OUT  0x2E,R30
;     965 TCNT1H=0x00;
	OUT  0x2D,R30
;     966 TCNT1L=0x00;
	OUT  0x2C,R30
;     967 ICR1H=0x00;
	OUT  0x27,R30
;     968 ICR1L=0x00;
	OUT  0x26,R30
;     969 OCR1AH=0x00;
	OUT  0x2B,R30
;     970 OCR1AL=0x00;
	OUT  0x2A,R30
;     971 OCR1BH=0x00;
	OUT  0x29,R30
;     972 OCR1BL=0x00;
	OUT  0x28,R30
;     973 
;     974 ASSR=0x00;
	OUT  0x22,R30
;     975 TCCR2=0x00;
	OUT  0x25,R30
;     976 TCNT2=0x00;
	OUT  0x24,R30
;     977 OCR2=0x00;
	OUT  0x23,R30
;     978 
;     979 MCUCR=0x00;
	OUT  0x35,R30
;     980 
;     981 t0_init();
	RCALL _t0_init
;     982 
;     983 ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     984 SFIOR=0x00;
	LDI  R30,LOW(0)
	OUT  0x30,R30
;     985 
;     986 #asm("sei")
	sei
;     987 can_init(); 
	RCALL _can_init
;     988 
;     989 
;     990 spi(0);
	LDI  R30,LOW(0)
	RCALL SUBOPT_0x1
;     991 DDRD.3=1;
	SBI  0x11,3
;     992 PORTD.3=1;
	SBI  0x12,3
;     993 delay_us(100);
	__DELAY_USW 200
;     994 PORTD.3=0;
	CBI  0x12,3
;     995 while (1)
_0xE1:
;     996 	{
;     997 	if(b100Hz)
	SBRS R2,0
	RJMP _0xE4
;     998 		{
;     999 		b100Hz=0;
	CLT
	BLD  R2,0
;    1000 		
;    1001          	//Подпрограммы исполняемые 100 раз в секунду
;    1002           log_in_drv();				//Драйвер логических входов(УПП,сервис)		
	RCALL _log_in_drv
;    1003 		can_hndl();                   //Обработка входящих сообщений по CAN
	RCALL _can_hndl
;    1004 		}	   
;    1005 	if(b10Hz)
_0xE4:
	SBRS R2,1
	RJMP _0xE5
;    1006 		{
;    1007 		b10Hz=0;                                    
	CLT
	BLD  R2,1
;    1008 		
;    1009       	//Подпрограммы исполняемые 10 раз в секунду
;    1010       	avar_drv();	        		//отслеживание всех аварий
	RCALL _avar_drv
;    1011       	out_hndl();
	RCALL _out_hndl
;    1012       	out_drv();				//управление реле
	RCALL _out_drv
;    1013       	
;    1014 
;    1015       	}	
;    1016 	if(b5Hz)
_0xE5:
	SBRS R2,2
	RJMP _0xE6
;    1017 		{                            
;    1018 		b5Hz=0;                      
	CLT
	BLD  R2,2
;    1019 		
;    1020 		//Подпрограммы исполняемые 5 раз в секунду
;    1021 		adc_hndl();
	RCALL _adc_hndl
;    1022           
;    1023           //out_stat[0]=(1<<RELE2)|(1<<RELE4);
;    1024 		}
;    1025 	if(b2Hz)
_0xE6:
	SBRS R2,3
	RJMP _0xE7
;    1026 		{
;    1027 		b2Hz=0;
	CLT
	BLD  R2,3
;    1028           transmit_hndl(); 
	RCALL _transmit_hndl
;    1029           //bon0=!bon0;                                                       
;    1030 		}								
;    1031 	if(b1Hz)
_0xE7:
	SBRS R2,4
	RJMP _0xE8
;    1032 		{
;    1033 		b1Hz=0;
	CLT
	BLD  R2,4
;    1034           if(main_cnt<1000)main_cnt++;
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRGE _0xE9
	LDS  R30,_main_cnt
	LDS  R31,_main_cnt+1
	ADIW R30,1
	STS  _main_cnt,R30
	STS  _main_cnt+1,R31
;    1035 
;    1036 		}
_0xE9:
;    1037 	}
_0xE8:
	RJMP _0xE1
;    1038 }
_0xEA:
	RJMP _0xEA

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x0:
	LDI  R30,LOW(80)
	OUT  0xD,R30
	LDI  R30,LOW(1)
	OUT  0xE,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 16 TIMES
SUBOPT_0x1:
	ST   -Y,R30
	RJMP _spi

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x2:
	LDD  R30,Y+1
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3:
	LDI  R30,LOW(85)
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4:
	LDD  R30,Y+2
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5:
	LD   R30,Y
	RJMP SUBOPT_0x1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x6:
	LDS  R30,_rts_delay
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x7:
	LDI  R30,LOW(44)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x8:
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	RJMP _spi_bit_modify

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x9:
	LDS  R30,_ptr_rx_wr
	LDI  R26,LOW(_fifo_can_in)
	LDI  R27,HIGH(_fifo_can_in)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 36 TIMES
SUBOPT_0xA:
	LDI  R26,LOW(13)
	LDI  R27,HIGH(13)
	RCALL __MULW12U
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0xB:
	ADD  R30,R26
	ADC  R31,R27
	STD  Y+6,R30
	STD  Y+6+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xC:
	ST   -Y,R30
	RJMP _spi_read

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xD:
	ADIW R26,3
	LD   R30,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xE:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADIW R26,2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0xF:
	LDS  R30,_ptr_tx_rd
	LDI  R26,LOW(_fifo_can_out)
	LDI  R27,HIGH(_fifo_can_out)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x10:
	STD  Y+6,R26
	STD  Y+6+1,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x11:
	LD   R30,X+
	STD  Y+6,R26
	STD  Y+6+1,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES
SUBOPT_0x12:
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x13:
	LDI  R30,LOW(50)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 28 TIMES
SUBOPT_0x14:
	ST   -Y,R30
	RJMP _spi_write

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES
SUBOPT_0x15:
	LDI  R30,LOW(0)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x16:
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,1
	ST   Y,R26
	STD  Y+1,R27
	SBIW R26,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES
SUBOPT_0x17:
	ST   X,R30
	LD   R30,Y
	LDD  R31,Y+1
	ADIW R30,1
	ST   Y,R30
	STD  Y+1,R31
	SBIW R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x18:
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x19:
	LDI  R30,LOW(15)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1A:
	ST   -Y,R30
	RJMP _spi_bit_modify

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1B:
	ST   -Y,R30
	LDI  R30,LOW(1)
	RJMP SUBOPT_0x14

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x1C:
	ST   -Y,R30
	LDI  R30,LOW(64)
	RJMP SUBOPT_0x14

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x1D:
	ST   -Y,R30
	LDI  R30,LOW(0)
	RJMP SUBOPT_0x14

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x1E:
	LDI  R30,LOW(1)
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x1F:
	ST   -Y,R30
	LDI  R30,LOW(255)
	RJMP SUBOPT_0x14

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x20:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x21:
	ST   -Y,R30
	RJMP SUBOPT_0x1E

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x22:
	ST   -Y,R31
	ST   -Y,R30
	RJMP _can_out_adr

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x23:
	LDI  R26,LOW(_serv_cnt)
	LDI  R27,HIGH(_serv_cnt)
	LD   R30,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0x24:
	ST   -Y,R31
	ST   -Y,R30
	RJMP SUBOPT_0x15

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x25:
	LDI  R30,LOW(100)
	ST   -Y,R30
	RJMP _gran_char

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x26:
	LDI  R30,LOW(10)
	CP   R30,R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES
SUBOPT_0x27:
	LD   R30,X
	SUBI R30,-LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x28:
	LD   R30,X
	SUBI R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES
SUBOPT_0x29:
	MOV  R30,R16
	LDI  R31,0
	SUBI R30,LOW(-_dv_stat)
	SBCI R31,HIGH(-_dv_stat)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x2A:
	MOV  R26,R16
	LDI  R27,0
	SUBI R26,LOW(-_out_stat)
	SBCI R27,HIGH(-_out_stat)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 26 TIMES
SUBOPT_0x2B:
	LDI  R30,LOW(0)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x2C:
	LDI  R30,LOW(1)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 37 TIMES
SUBOPT_0x2D:
	MOV  R30,R16
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 75 TIMES
SUBOPT_0x2E:
	MOV  R26,R16
	LDI  R27,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x2F:
	LPM  R30,Z
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES
SUBOPT_0x30:
	LDS  R26,_main_cnt
	LDS  R27,_main_cnt+1
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CP   R30,R26
	CPC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 24 TIMES
SUBOPT_0x31:
	ST   X,R30
	RJMP SUBOPT_0x2E

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x32:
	SUBI R26,LOW(-_cnt_avtKZ)
	SBCI R27,HIGH(-_cnt_avtKZ)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x33:
	SUBI R26,LOW(-_cnt_avtON)
	SBCI R27,HIGH(-_cnt_avtON)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x34:
	SUBI R26,LOW(-_cnt_avtOFF)
	SBCI R27,HIGH(-_cnt_avtOFF)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES
SUBOPT_0x35:
	RCALL _gran_char
	RJMP SUBOPT_0x2D

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x36:
	LD   R30,Z
	CPI  R30,LOW(0x32)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x37:
	LDI  R30,LOW(102)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x38:
	SUBI R26,LOW(-_cnt_avtHH)
	SBCI R27,HIGH(-_cnt_avtHH)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x39:
	LDI  R30,LOW(105)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3A:
	LDI  R30,LOW(85)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3B:
	ST   X,R30
	RJMP SUBOPT_0x2D

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x3C:
	SUBI R26,LOW(-_av_temper)
	SBCI R27,HIGH(-_av_temper)
	LDI  R30,LOW(170)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3D:
	LPM  R30,Z
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3E:
	SUBI R26,LOW(-_cnt_avvKZ)
	SBCI R27,HIGH(-_cnt_avvKZ)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x3F:
	SUBI R26,LOW(-_cnt_avvON)
	SBCI R27,HIGH(-_cnt_avvON)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x40:
	SUBI R26,LOW(-_cnt_avvOFF)
	SBCI R27,HIGH(-_cnt_avvOFF)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x41:
	SUBI R26,LOW(-_cnt_avvHH)
	SBCI R27,HIGH(-_cnt_avvHH)
	RJMP SUBOPT_0x2B

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x42:
	SUBI R26,LOW(-_av_vl)
	SBCI R27,HIGH(-_av_vl)
	LDI  R30,LOW(170)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x43:
	LDI  R26,LOW(_adc_buff_)
	LDI  R27,HIGH(_adc_buff_)
	LDI  R31,0
	LSL  R30
	ROL  R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x44:
	SUBI R30,LOW(-_upp_cnt)
	SBCI R31,HIGH(-_upp_cnt)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 31 TIMES
SUBOPT_0x45:
	LDS  R30,_ptr_rx_rd
	LDI  R26,LOW(_fifo_can_in)
	LDI  R27,HIGH(_fifo_can_in)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES
SUBOPT_0x46:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,5
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x47:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,6
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x48:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,7
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x49:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,8
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES
SUBOPT_0x4A:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,9
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4B:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,10
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4C:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,11
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4D:
	ADD  R30,R26
	ADC  R31,R27
	ADIW R30,12
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES
SUBOPT_0x4E:
	SUBI R30,LOW(-_dv_on)
	SBCI R31,HIGH(-_dv_on)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x4F:
	SUBI R30,LOW(-_dv_on_old)
	SBCI R31,HIGH(-_dv_on_old)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x50:
	SUBI R26,LOW(-_dv_stat)
	SBCI R27,HIGH(-_dv_stat)
	LDI  R30,LOW(129)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x51:
	SUBI R26,LOW(-_dv_on_old)
	SBCI R27,HIGH(-_dv_on_old)
	LDI  R30,LOW(129)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x52:
	SUBI R26,LOW(-_dv_stat)
	SBCI R27,HIGH(-_dv_stat)
	LDI  R30,LOW(66)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x53:
	SUBI R26,LOW(-_dv_cnt)
	SBCI R27,HIGH(-_dv_cnt)
	LDI  R30,LOW(10)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x54:
	SUBI R26,LOW(-_dv_on_old)
	SBCI R27,HIGH(-_dv_on_old)
	LDI  R30,LOW(66)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x55:
	SUBI R26,LOW(-_dv_stat)
	SBCI R27,HIGH(-_dv_stat)
	LDI  R30,LOW(36)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x56:
	SUBI R26,LOW(-_dv_on_old)
	SBCI R27,HIGH(-_dv_on_old)
	LDI  R30,LOW(36)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x57:
	SUBI R26,LOW(-_dv_stat)
	SBCI R27,HIGH(-_dv_stat)
	LDI  R30,LOW(153)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x58:
	SUBI R26,LOW(-_dv_cnt)
	SBCI R27,HIGH(-_dv_cnt)
	LDI  R30,LOW(35)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x59:
	SUBI R26,LOW(-_dv_on_old)
	SBCI R27,HIGH(-_dv_on_old)
	LDI  R30,LOW(153)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5A:
	SUBI R26,LOW(-_dv_stat)
	SBCI R27,HIGH(-_dv_stat)
	LDI  R30,LOW(102)
	RJMP SUBOPT_0x31

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5B:
	SUBI R26,LOW(-_dv_on_old)
	SBCI R27,HIGH(-_dv_on_old)
	RJMP SUBOPT_0x37

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5C:
	LDI  R26,LOW(_adc_buff)
	LDI  R27,HIGH(_adc_buff)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x5D:
	LSL  R30
	ROL  R31
	RCALL __LSLW4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5E:
	ADD  R26,R30
	ADC  R27,R31
	MOV  R30,R17
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	RCALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x5F:
	LDI  R26,LOW(_curr_ch_buff)
	LDI  R27,HIGH(_curr_ch_buff)
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x60:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x61:
	LDI  R30,LOW(4)
	CP   R11,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x62:
	MOV  R30,R11
	LDI  R31,0
	SUBI R30,LOW(-_adc_cnt_main1)
	SBCI R31,HIGH(-_adc_cnt_main1)
	LD   R30,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x63:
	MOV  R26,R11
	LDI  R27,0
	SUBI R26,LOW(-_adc_cnt_main1)
	SBCI R27,HIGH(-_adc_cnt_main1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES
SUBOPT_0x64:
	LDI  R30,0
	STS  _curr_buff,R30
	STS  _curr_buff+1,R30
	LDI  R30,LOW(0)
	STS  _self_cnt,R30
	STS  _self_cnt_not_zero,R30
	STS  _self_cnt_zero_after,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES
SUBOPT_0x65:
	LDI  R30,LOW(1023)
	LDI  R31,HIGH(1023)
	STS  _self_min,R30
	STS  _self_min+1,R31
	CLR  R12
	CLR  R13
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES
SUBOPT_0x66:
	MOV  R11,R30
	RJMP SUBOPT_0x64

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

__MULW12U:
	MUL  R31,R26
	MOV  R31,R0
	MUL  R30,R27
	ADD  R31,R0
	MUL  R30,R26
	MOV  R30,R0
	ADD  R31,R1
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__PUTWP1:
	ST   X+,R30
	ST   X,R31
	RET

__BSTB1:
	CLT
	CLR  R0
	CPSE R30,R0
	SET
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

