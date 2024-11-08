/*----------------------------------------------------------------------------
 *      RL-ARM - TCPnet
 *----------------------------------------------------------------------------
 *      Name:    SNMP_MIB.C
 *      Purpose: SNMP Agent Management Information Base Module
 *      Rev.:    V4.10
 *----------------------------------------------------------------------------
 *      This code is part of the RealView Run-Time Library.
 *      Copyright (c) 2004-2010 KEIL - An ARM Company. All rights reserved.
 *---------------------------------------------------------------------------*/

#include <Net_Config.h>

/* snmp_demo.c */
extern U8   get_button (void);
extern void LED_out (U32 val);
extern BOOL LCDupdate;
extern U8   lcd_text[2][16+1];

/* System */
extern U32  snmp_SysUpTime;

/* Local variables */
static U8   LedOut;
static U8   KeyIn;

/* MIB Read Only integer constants */
static const U8 sysServices = 79;

/* MIB Entry event Callback functions. */
static void write_leds (int mode);
static void read_key (int mode);
static void upd_display (int mode);

/*----------------------------------------------------------------------------
 *      MIB Data Table
 *---------------------------------------------------------------------------*/

const MIB_ENTRY snmp_mib[] = {

  /* ---------- System MIB ----------- */

  /* SysDescr Entry */
  { MIB_OCTET_STR | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 1, 0},
    MIB_STR("Embedded System SNMP V1.0"),
    NULL },
  /* SysObjectID Entry */
  { MIB_OBJECT_ID | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 2, 0},
    MIB_STR("\x2b\x06\x01\x02\x01\x01\x02\x00"),
    NULL },
  /* SysUpTime Entry */
  { MIB_TIME_TICKS | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 3, 0},
    4, &snmp_SysUpTime,
    NULL },
  /* SysContact Entry */
  { MIB_OCTET_STR | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 4, 0},
    MIB_STR("test@keil.com"),
    NULL },
  /* SysName Entry */
  { MIB_OCTET_STR | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 5, 0},
    MIB_STR("Evaluation board"),
    NULL },
  /* SysLocation Entry */
  { MIB_OCTET_STR | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 6, 0},
    MIB_STR("Local"),
    NULL },
  /* SysServices Entry */
  { MIB_INTEGER | MIB_ATR_RO,
    8, {OID0(1,3), 6, 1, 2, 1, 1, 7, 0},
    MIB_INT(sysServices),
    NULL },

  /* ---------- Experimental MIB ----------- */

  /* LedOut Entry */
  { MIB_INTEGER,
    6, {OID0(1,3), 6, 1, 3, 1, 0},
    MIB_INT(LedOut),
    write_leds },
  /* KeyIn Entry */
  { MIB_INTEGER | MIB_ATR_RO,
    6, {OID0(1,3), 6, 1, 3, 2, 0},
    MIB_INT(KeyIn),
    read_key },
  /* LCD line1 Entry */
  { MIB_OCTET_STR,
    6, {OID0(1,3), 6, 1, 3, 3, 0},
    MIB_STR(lcd_text[0]),
    upd_display },
  /* LCD line2 Entry */
  { MIB_OCTET_STR,
    6, {OID0(1,3), 6, 1, 3, 4, 0},
    MIB_STR(lcd_text[1]),
    upd_display },
};
const int snmp_mib_size = (sizeof(snmp_mib) / sizeof(MIB_ENTRY));

/*----------------------------------------------------------------------------
 *      MIB Callback Functions
 *---------------------------------------------------------------------------*/

static void write_leds (int mode) {
  /* No action on read access. */
  if (mode == MIB_WRITE) {
    LED_out (LedOut);
  }
}

static void read_key (int mode) {
  /* Read ARM Digital Input */
  if (mode == MIB_READ) {
    KeyIn = get_button();
  }
}

static void upd_display (int mode) {
  /* Update LCD Module display text. */
  if (mode == MIB_WRITE) {
    /* Write access. */
    LCDupdate = __TRUE;
  }
}

/*----------------------------------------------------------------------------
 * end of file
 *---------------------------------------------------------------------------*/
