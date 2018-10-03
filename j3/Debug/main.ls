   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
  43                     ; 9 main()
  43                     ; 10 {
  45                     	switch	.text
  46  0000               _main:
  50                     ; 12 CLK->CKDIVR=0;
  52  0000 725f50c6      	clr	20678
  53                     ; 14 	GPIOD->DDR|=(1<<6);
  55  0004 721c5011      	bset	20497,#6
  56                     ; 15 	GPIOD->CR1|=(1<<6);
  58  0008 721c5012      	bset	20498,#6
  59                     ; 16 	GPIOD->CR2&=~(1<<6);
  61  000c 721d5013      	bres	20499,#6
  62                     ; 18 	GPIOC->ODR|=(1<<5);
  64  0010 721a500a      	bset	20490,#5
  65                     ; 19 	GPIOC->ODR&=~(1<<5);
  67  0014 721b500a      	bres	20490,#5
  68  0018               L12:
  69                     ; 24 			GPIOD->ODR^=(1<<6);
  71  0018 c6500f        	ld	a,20495
  72  001b a840          	xor	a,	#64
  73  001d c7500f        	ld	20495,a
  75  0020 20f6          	jra	L12
  99                     	xdef	_main
 100                     	switch	.ubsct
 101  0000               _cnt:
 102  0000 00000000      	ds.b	4
 103                     	xdef	_cnt
 123                     	end
