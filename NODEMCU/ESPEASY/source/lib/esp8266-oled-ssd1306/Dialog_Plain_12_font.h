/**The MIT License (MIT)

Copyright (c) 2015 by Daniel Eichhorn

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

See more at http://blog.squix.ch
*/

#ifndef DIALOG_PLAIN_FONT_H
#define DIALOG_PLAIN_FONT_H

// OLED library version >= 3.0.0
// Created by http://oleddisplay.squix.ch/ Consider a donation
// In case of problems make sure that you are using the font file with the correct version!
const char Dialog_plain_12[] PROGMEM = {
	0x0D, // Width: 13
	0x0F, // Height: 15
	0x20, // First Char: 32
	0xE0, // Numbers of Chars: 224

	// Jump Table:
	0xFF, 0xFF, 0x00, 0x04,  // 32:65535
	0x00, 0x00, 0x06, 0x05,  // 33:0
	0x00, 0x06, 0x07, 0x05,  // 34:6
	0x00, 0x0D, 0x11, 0x0A,  // 35:13
	0x00, 0x1E, 0x0E, 0x08,  // 36:30
	0x00, 0x2C, 0x16, 0x0C,  // 37:44
	0x00, 0x42, 0x12, 0x09,  // 38:66
	0x00, 0x54, 0x03, 0x03,  // 39:84
	0x00, 0x57, 0x06, 0x05,  // 40:87
	0x00, 0x5D, 0x08, 0x05,  // 41:93
	0x00, 0x65, 0x0B, 0x07,  // 42:101
	0x00, 0x70, 0x12, 0x0A,  // 43:112
	0x00, 0x82, 0x04, 0x03,  // 44:130
	0x00, 0x86, 0x08, 0x05,  // 45:134
	0x00, 0x8E, 0x04, 0x03,  // 46:142
	0x00, 0x92, 0x07, 0x04,  // 47:146
	0x00, 0x99, 0x0E, 0x08,  // 48:153
	0x00, 0xA7, 0x0C, 0x07,  // 49:167
	0x00, 0xB3, 0x0C, 0x07,  // 50:179
	0x00, 0xBF, 0x0C, 0x07,  // 51:191
	0x00, 0xCB, 0x0E, 0x08,  // 52:203
	0x00, 0xD9, 0x0C, 0x07,  // 53:217
	0x00, 0xE5, 0x0E, 0x08,  // 54:229
	0x00, 0xF3, 0x0D, 0x08,  // 55:243
	0x01, 0x00, 0x0E, 0x08,  // 56:256
	0x01, 0x0E, 0x0E, 0x08,  // 57:270
	0x01, 0x1C, 0x04, 0x03,  // 58:284
	0x01, 0x20, 0x04, 0x03,  // 59:288
	0x01, 0x24, 0x12, 0x0A,  // 60:292
	0x01, 0x36, 0x12, 0x0A,  // 61:310
	0x01, 0x48, 0x12, 0x0A,  // 62:328
	0x01, 0x5A, 0x09, 0x06,  // 63:346
	0x01, 0x63, 0x16, 0x0C,  // 64:355
	0x01, 0x79, 0x10, 0x08,  // 65:377
	0x01, 0x89, 0x0E, 0x08,  // 66:393
	0x01, 0x97, 0x10, 0x09,  // 67:407
	0x01, 0xA7, 0x10, 0x09,  // 68:423
	0x01, 0xB7, 0x0C, 0x07,  // 69:439
	0x01, 0xC3, 0x0B, 0x07,  // 70:451
	0x01, 0xCE, 0x12, 0x0A,  // 71:462
	0x01, 0xE0, 0x10, 0x09,  // 72:480
	0x01, 0xF0, 0x04, 0x03,  // 73:496
	0x01, 0xF4, 0x04, 0x03,  // 74:500
	0x01, 0xF8, 0x0E, 0x08,  // 75:504
	0x02, 0x06, 0x0C, 0x06,  // 76:518
	0x02, 0x12, 0x12, 0x0A,  // 77:530
	0x02, 0x24, 0x10, 0x09,  // 78:548
	0x02, 0x34, 0x12, 0x0A,  // 79:564
	0x02, 0x46, 0x0D, 0x08,  // 80:582
	0x02, 0x53, 0x12, 0x0A,  // 81:595
	0x02, 0x65, 0x10, 0x09,  // 82:613
	0x02, 0x75, 0x0E, 0x08,  // 83:629
	0x02, 0x83, 0x0D, 0x07,  // 84:643
	0x02, 0x90, 0x10, 0x09,  // 85:656
	0x02, 0xA0, 0x0F, 0x08,  // 86:672
	0x02, 0xAF, 0x15, 0x0C,  // 87:687
	0x02, 0xC4, 0x10, 0x08,  // 88:708
	0x02, 0xD4, 0x0D, 0x07,  // 89:724
	0x02, 0xE1, 0x10, 0x09,  // 90:737
	0x02, 0xF1, 0x06, 0x05,  // 91:753
	0x02, 0xF7, 0x08, 0x04,  // 92:759
	0x02, 0xFF, 0x08, 0x05,  // 93:767
	0x03, 0x07, 0x11, 0x0A,  // 94:775
	0x03, 0x18, 0x0C, 0x06,  // 95:792
	0x03, 0x24, 0x05, 0x06,  // 96:804
	0x03, 0x29, 0x0E, 0x08,  // 97:809
	0x03, 0x37, 0x0E, 0x08,  // 98:823
	0x03, 0x45, 0x0C, 0x07,  // 99:837
	0x03, 0x51, 0x0E, 0x08,  // 100:849
	0x03, 0x5F, 0x0E, 0x08,  // 101:863
	0x03, 0x6D, 0x07, 0x04,  // 102:877
	0x03, 0x74, 0x0E, 0x08,  // 103:884
	0x03, 0x82, 0x0C, 0x07,  // 104:898
	0x03, 0x8E, 0x04, 0x03,  // 105:910
	0x03, 0x92, 0x04, 0x03,  // 106:914
	0x03, 0x96, 0x0C, 0x07,  // 107:918
	0x03, 0xA2, 0x04, 0x03,  // 108:930
	0x03, 0xA6, 0x14, 0x0B,  // 109:934
	0x03, 0xBA, 0x0C, 0x07,  // 110:954
	0x03, 0xC6, 0x0E, 0x08,  // 111:966
	0x03, 0xD4, 0x0E, 0x08,  // 112:980
	0x03, 0xE2, 0x0E, 0x08,  // 113:994
	0x03, 0xF0, 0x09, 0x05,  // 114:1008
	0x03, 0xF9, 0x0C, 0x07,  // 115:1017
	0x04, 0x05, 0x08, 0x05,  // 116:1029
	0x04, 0x0D, 0x0C, 0x07,  // 117:1037
	0x04, 0x19, 0x0D, 0x07,  // 118:1049
	0x04, 0x26, 0x11, 0x0A,  // 119:1062
	0x04, 0x37, 0x0C, 0x07,  // 120:1079
	0x04, 0x43, 0x0D, 0x07,  // 121:1091
	0x04, 0x50, 0x0E, 0x07,  // 122:1104
	0x04, 0x5E, 0x0C, 0x07,  // 123:1118
	0x04, 0x6A, 0x06, 0x05,  // 124:1130
	0x04, 0x70, 0x0B, 0x07,  // 125:1136
	0x04, 0x7B, 0x11, 0x0A,  // 126:1147
	0x04, 0x8C, 0x0C, 0x07,  // 127:1164
	0x04, 0x98, 0x0C, 0x07,  // 128:1176
	0x04, 0xA4, 0x0C, 0x07,  // 129:1188
	0x04, 0xB0, 0x0C, 0x07,  // 130:1200
	0x04, 0xBC, 0x0C, 0x07,  // 131:1212
	0x04, 0xC8, 0x0C, 0x07,  // 132:1224
	0x04, 0xD4, 0x0C, 0x07,  // 133:1236
	0x04, 0xE0, 0x0C, 0x07,  // 134:1248
	0x04, 0xEC, 0x0C, 0x07,  // 135:1260
	0x04, 0xF8, 0x0C, 0x07,  // 136:1272
	0x05, 0x04, 0x0C, 0x07,  // 137:1284
	0x05, 0x10, 0x0C, 0x07,  // 138:1296
	0x05, 0x1C, 0x0C, 0x07,  // 139:1308
	0x05, 0x28, 0x0C, 0x07,  // 140:1320
	0x05, 0x34, 0x0C, 0x07,  // 141:1332
	0x05, 0x40, 0x0C, 0x07,  // 142:1344
	0x05, 0x4C, 0x0C, 0x07,  // 143:1356
	0x05, 0x58, 0x0C, 0x07,  // 144:1368
	0x05, 0x64, 0x0C, 0x07,  // 145:1380
	0x05, 0x70, 0x0C, 0x07,  // 146:1392
	0x05, 0x7C, 0x0C, 0x07,  // 147:1404
	0x05, 0x88, 0x0C, 0x07,  // 148:1416
	0x05, 0x94, 0x0C, 0x07,  // 149:1428
	0x05, 0xA0, 0x0C, 0x07,  // 150:1440
	0x05, 0xAC, 0x0C, 0x07,  // 151:1452
	0x05, 0xB8, 0x0C, 0x07,  // 152:1464
	0x05, 0xC4, 0x0C, 0x07,  // 153:1476
	0x05, 0xD0, 0x0C, 0x07,  // 154:1488
	0x05, 0xDC, 0x0C, 0x07,  // 155:1500
	0x05, 0xE8, 0x0C, 0x07,  // 156:1512
	0x05, 0xF4, 0x0C, 0x07,  // 157:1524
	0x06, 0x00, 0x0C, 0x07,  // 158:1536
	0x06, 0x0C, 0x0C, 0x07,  // 159:1548
	0xFF, 0xFF, 0x00, 0x04,  // 160:65535
	0x06, 0x18, 0x06, 0x05,  // 161:1560
	0x06, 0x1E, 0x0E, 0x08,  // 162:1566
	0x06, 0x2C, 0x0E, 0x08,  // 163:1580
	0x06, 0x3A, 0x0C, 0x07,  // 164:1594
	0x06, 0x46, 0x0C, 0x07,  // 165:1606
	0x06, 0x52, 0x06, 0x05,  // 166:1618
	0x06, 0x58, 0x0C, 0x07,  // 167:1624
	0x06, 0x64, 0x07, 0x05,  // 168:1636
	0x06, 0x6B, 0x16, 0x0D,  // 169:1643
	0x06, 0x81, 0x0A, 0x06,  // 170:1665
	0x06, 0x8B, 0x0E, 0x08,  // 171:1675
	0x06, 0x99, 0x12, 0x0A,  // 172:1689
	0x06, 0xAB, 0x08, 0x05,  // 173:1707
	0x06, 0xB3, 0x16, 0x0D,  // 174:1715
	0x06, 0xC9, 0x09, 0x06,  // 175:1737
	0x06, 0xD2, 0x09, 0x06,  // 176:1746
	0x06, 0xDB, 0x12, 0x0A,  // 177:1755
	0x06, 0xED, 0x08, 0x05,  // 178:1773
	0x06, 0xF5, 0x07, 0x05,  // 179:1781
	0x06, 0xFC, 0x09, 0x06,  // 180:1788
	0x07, 0x05, 0x0E, 0x07,  // 181:1797
	0x07, 0x13, 0x0C, 0x07,  // 182:1811
	0x07, 0x1F, 0x03, 0x03,  // 183:1823
	0x07, 0x22, 0x08, 0x06,  // 184:1826
	0x07, 0x2A, 0x07, 0x05,  // 185:1834
	0x07, 0x31, 0x0C, 0x07,  // 186:1841
	0x07, 0x3D, 0x0E, 0x07,  // 187:1853
	0x07, 0x4B, 0x16, 0x0B,  // 188:1867
	0x07, 0x61, 0x16, 0x0C,  // 189:1889
	0x07, 0x77, 0x16, 0x0B,  // 190:1911
	0x07, 0x8D, 0x0A, 0x06,  // 191:1933
	0x07, 0x97, 0x10, 0x08,  // 192:1943
	0x07, 0xA7, 0x10, 0x08,  // 193:1959
	0x07, 0xB7, 0x10, 0x08,  // 194:1975
	0x07, 0xC7, 0x10, 0x08,  // 195:1991
	0x07, 0xD7, 0x0E, 0x07,  // 196:2007
	0x07, 0xE5, 0x0E, 0x07,  // 197:2021
	0x07, 0xF3, 0x14, 0x0B,  // 198:2035
	0x08, 0x07, 0x10, 0x09,  // 199:2055
	0x08, 0x17, 0x0C, 0x07,  // 200:2071
	0x08, 0x23, 0x0C, 0x07,  // 201:2083
	0x08, 0x2F, 0x0C, 0x07,  // 202:2095
	0x08, 0x3B, 0x0C, 0x07,  // 203:2107
	0x08, 0x47, 0x04, 0x03,  // 204:2119
	0x08, 0x4B, 0x05, 0x03,  // 205:2123
	0x08, 0x50, 0x05, 0x03,  // 206:2128
	0x08, 0x55, 0x07, 0x05,  // 207:2133
	0x08, 0x5C, 0x10, 0x09,  // 208:2140
	0x08, 0x6C, 0x10, 0x09,  // 209:2156
	0x08, 0x7C, 0x12, 0x0A,  // 210:2172
	0x08, 0x8E, 0x12, 0x0A,  // 211:2190
	0x08, 0xA0, 0x12, 0x0A,  // 212:2208
	0x08, 0xB2, 0x12, 0x0A,  // 213:2226
	0x08, 0xC4, 0x12, 0x0A,  // 214:2244
	0x08, 0xD6, 0x10, 0x0A,  // 215:2262
	0x08, 0xE6, 0x12, 0x0A,  // 216:2278
	0x08, 0xF8, 0x10, 0x09,  // 217:2296
	0x09, 0x08, 0x10, 0x09,  // 218:2312
	0x09, 0x18, 0x10, 0x09,  // 219:2328
	0x09, 0x28, 0x10, 0x09,  // 220:2344
	0x09, 0x38, 0x0D, 0x07,  // 221:2360
	0x09, 0x45, 0x0E, 0x08,  // 222:2373
	0x09, 0x53, 0x0E, 0x08,  // 223:2387
	0x09, 0x61, 0x0E, 0x08,  // 224:2401
	0x09, 0x6F, 0x0E, 0x08,  // 225:2415
	0x09, 0x7D, 0x0E, 0x08,  // 226:2429
	0x09, 0x8B, 0x0E, 0x08,  // 227:2443
	0x09, 0x99, 0x0E, 0x08,  // 228:2457
	0x09, 0xA7, 0x0E, 0x08,  // 229:2471
	0x09, 0xB5, 0x16, 0x0C,  // 230:2485
	0x09, 0xCB, 0x0C, 0x07,  // 231:2507
	0x09, 0xD7, 0x0E, 0x08,  // 232:2519
	0x09, 0xE5, 0x0E, 0x08,  // 233:2533
	0x09, 0xF3, 0x0E, 0x08,  // 234:2547
	0x0A, 0x01, 0x0E, 0x08,  // 235:2561
	0x0A, 0x0F, 0x04, 0x03,  // 236:2575
	0x0A, 0x13, 0x05, 0x03,  // 237:2579
	0x0A, 0x18, 0x05, 0x03,  // 238:2584
	0x0A, 0x1D, 0x05, 0x03,  // 239:2589
	0x0A, 0x22, 0x0E, 0x08,  // 240:2594
	0x0A, 0x30, 0x0C, 0x07,  // 241:2608
	0x0A, 0x3C, 0x0E, 0x08,  // 242:2620
	0x0A, 0x4A, 0x0E, 0x08,  // 243:2634
	0x0A, 0x58, 0x0E, 0x08,  // 244:2648
	0x0A, 0x66, 0x0E, 0x08,  // 245:2662
	0x0A, 0x74, 0x0E, 0x08,  // 246:2676
	0x0A, 0x82, 0x11, 0x0A,  // 247:2690
	0x0A, 0x93, 0x0E, 0x08,  // 248:2707
	0x0A, 0xA1, 0x0C, 0x07,  // 249:2721
	0x0A, 0xAD, 0x0C, 0x07,  // 250:2733
	0x0A, 0xB9, 0x0C, 0x07,  // 251:2745
	0x0A, 0xC5, 0x0C, 0x07,  // 252:2757
	0x0A, 0xD1, 0x0D, 0x07,  // 253:2769
	0x0A, 0xDE, 0x0E, 0x08,  // 254:2782
	0x0A, 0xEC, 0x0B, 0x07,  // 255:2796

	// Font Data:
	0x00,0x00,0x00,0x00,0xF8,0x09,	// 33
	0x00,0x00,0x38,0x00,0x00,0x00,0x38,	// 34
	0x00,0x00,0x00,0x01,0x40,0x0D,0xC0,0x03,0x78,0x01,0x40,0x0F,0xE0,0x01,0x58,0x01,0x40,	// 35
	0x00,0x00,0x70,0x08,0xC8,0x08,0xFC,0x1F,0x88,0x08,0x88,0x0D,0x18,0x07,	// 36
	0x00,0x00,0x70,0x00,0x88,0x00,0x88,0x08,0x70,0x06,0x80,0x01,0x40,0x00,0x30,0x07,0x88,0x08,0x80,0x08,0x00,0x07,	// 37
	0x00,0x00,0x80,0x07,0xF0,0x0C,0x48,0x08,0x88,0x09,0x08,0x0B,0x00,0x06,0x80,0x0F,0x80,0x08,	// 38
	0x00,0x00,0x38,	// 39
	0x00,0x00,0xF0,0x07,0x0C,0x18,	// 40
	0x00,0x00,0x00,0x00,0x1C,0x18,0xE0,0x07,	// 41
	0x00,0x00,0x50,0x00,0x60,0x00,0xF8,0x00,0x60,0x00,0x50,	// 42
	0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x01,0xF0,0x0F,0x00,0x01,0x00,0x01,0x00,0x01,0x00,0x01,	// 43
	0x00,0x10,0x00,0x0C,	// 44
	0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x01,	// 45
	0x00,0x00,0x00,0x08,	// 46
	0x00,0x30,0x00,0x0F,0xE0,0x00,0x18,	// 47
	0x00,0x00,0xE0,0x03,0x18,0x0C,0x08,0x08,0x08,0x08,0x18,0x0C,0xE0,0x03,	// 48
	0x00,0x00,0x08,0x08,0x08,0x08,0xF8,0x0F,0x00,0x08,0x00,0x08,	// 49
	0x00,0x00,0x18,0x0C,0x08,0x0E,0x08,0x0B,0x88,0x08,0x70,0x08,	// 50
	0x00,0x0C,0x08,0x08,0x48,0x08,0x48,0x08,0xC8,0x0C,0xB0,0x07,	// 51
	0x00,0x00,0x00,0x03,0xC0,0x02,0x60,0x02,0x18,0x02,0xF8,0x0F,0x00,0x02,	// 52
	0x00,0x0C,0x78,0x08,0x48,0x08,0x48,0x08,0xC8,0x0C,0x80,0x07,	// 53
	0x00,0x00,0xE0,0x03,0x90,0x0C,0x48,0x08,0x48,0x08,0xC8,0x0C,0x88,0x07,	// 54
	0x00,0x00,0x08,0x00,0x08,0x08,0x08,0x0E,0xC8,0x03,0x78,0x00,0x18,	// 55
	0x00,0x00,0x70,0x07,0x88,0x09,0x88,0x08,0x88,0x08,0x88,0x09,0x70,0x07,	// 56
	0x00,0x00,0xF0,0x08,0x98,0x09,0x08,0x09,0x08,0x09,0x98,0x04,0xE0,0x03,	// 57
	0x00,0x00,0x40,0x08,	// 58
	0x00,0x10,0x20,0x0C,	// 59
	0x00,0x00,0x80,0x01,0x80,0x01,0x80,0x03,0x40,0x02,0x40,0x02,0x60,0x04,0x20,0x04,0x20,0x04,	// 60
	0x00,0x00,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,0x40,0x02,	// 61
	0x00,0x00,0x20,0x04,0x20,0x04,0x40,0x02,0x40,0x02,0xC0,0x02,0x80,0x01,0x80,0x01,0x00,0x01,	// 62
	0x00,0x00,0x08,0x00,0x88,0x0B,0xC8,0x00,0x70,	// 63
	0x00,0x00,0xC0,0x07,0x20,0x08,0x10,0x10,0x88,0x23,0x48,0x24,0x48,0x24,0x48,0x24,0xD0,0x17,0x30,0x04,0xC0,0x03,	// 64
	0x00,0x08,0x00,0x0F,0xE0,0x03,0x38,0x02,0x18,0x02,0xE0,0x02,0x00,0x07,0x00,0x0C,	// 65
	0x00,0x00,0xF8,0x0F,0x88,0x08,0x88,0x08,0x88,0x08,0x88,0x08,0x70,0x07,	// 66
	0x00,0x00,0xE0,0x03,0x10,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x10,0x04,	// 67
	0x00,0x00,0xF8,0x0F,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x10,0x04,0xE0,0x03,	// 68
	0x00,0x00,0xF8,0x0F,0x88,0x08,0x88,0x08,0x88,0x08,0x88,0x08,	// 69
	0x00,0x00,0xF8,0x0F,0x88,0x00,0x88,0x00,0x88,0x00,0x08,	// 70
	0x00,0x00,0xE0,0x03,0x10,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x88,0x08,0x88,0x08,0x90,0x07,	// 71
	0x00,0x00,0xF8,0x0F,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0xF8,0x0F,	// 72
	0x00,0x00,0xF8,0x0F,	// 73
	0x00,0x40,0xF8,0x3F,	// 74
	0x00,0x00,0xF8,0x0F,0xC0,0x00,0x60,0x01,0x30,0x02,0x18,0x04,0x08,0x08,	// 75
	0x00,0x00,0xF8,0x0F,0x00,0x08,0x00,0x08,0x00,0x08,0x00,0x08,	// 76
	0x00,0x00,0xF8,0x0F,0x18,0x00,0xE0,0x00,0x00,0x03,0x00,0x03,0xE0,0x00,0x18,0x00,0xF8,0x0F,	// 77
	0x00,0x00,0xF8,0x0F,0x18,0x00,0x60,0x00,0xC0,0x01,0x00,0x03,0x00,0x0C,0xF8,0x0F,	// 78
	0x00,0x00,0xE0,0x03,0x10,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x10,0x04,0xE0,0x03,	// 79
	0x00,0x00,0xF8,0x0F,0x88,0x00,0x88,0x00,0x88,0x00,0x88,0x00,0x70,	// 80
	0x00,0x00,0xE0,0x03,0x10,0x04,0x08,0x08,0x08,0x08,0x08,0x08,0x08,0x18,0x10,0x24,0xE0,0x03,	// 81
	0x00,0x00,0xF8,0x0F,0x88,0x00,0x88,0x00,0x88,0x00,0x88,0x01,0x70,0x07,0x00,0x0C,	// 82
	0x00,0x00,0x70,0x0C,0xC8,0x08,0x88,0x08,0x88,0x08,0x88,0x08,0x18,0x07,	// 83
	0x08,0x00,0x08,0x00,0x08,0x00,0xF8,0x0F,0x08,0x00,0x08,0x00,0x08,	// 84
	0x00,0x00,0xF8,0x07,0x00,0x0C,0x00,0x08,0x00,0x08,0x00,0x08,0x00,0x0C,0xF8,0x07,	// 85
	0x08,0x00,0x78,0x00,0xC0,0x01,0x00,0x0E,0x00,0x0E,0x80,0x03,0x70,0x00,0x18,	// 86
	0x00,0x00,0xF8,0x00,0x80,0x0F,0x00,0x0C,0xC0,0x03,0x38,0x00,0x78,0x00,0x80,0x07,0x00,0x0C,0xC0,0x07,0x78,	// 87
	0x00,0x00,0x08,0x0C,0x30,0x06,0xE0,0x01,0xC0,0x01,0x30,0x03,0x18,0x0C,0x00,0x08,	// 88
	0x08,0x00,0x10,0x00,0x60,0x00,0x80,0x0F,0x60,0x00,0x18,0x00,0x08,	// 89
	0x00,0x00,0x08,0x0C,0x08,0x0E,0x08,0x0B,0x88,0x08,0x68,0x08,0x38,0x08,0x18,0x08,	// 90
	0x00,0x00,0xFC,0x1F,0x04,0x10,	// 91
	0x18,0x00,0xE0,0x00,0x00,0x0F,0x00,0x30,	// 92
	0x00,0x00,0x00,0x00,0x04,0x10,0xFC,0x1F,	// 93
	0x00,0x00,0x40,0x00,0x20,0x00,0x30,0x00,0x18,0x00,0x08,0x00,0x10,0x00,0x20,0x00,0x40,	// 94
	0x00,0x40,0x00,0x40,0x00,0x40,0x00,0x40,0x00,0x40,0x00,0x40,	// 95
	0x00,0x00,0x02,0x00,0x0C,	// 96
	0x00,0x00,0x60,0x06,0x20,0x09,0x20,0x09,0x20,0x09,0x60,0x05,0xC0,0x0F,	// 97
	0x00,0x00,0xFC,0x0F,0x40,0x04,0x20,0x08,0x20,0x08,0x60,0x0C,0xC0,0x07,	// 98
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x08,0x20,0x08,0x20,0x08,	// 99
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x08,0x20,0x08,0x40,0x04,0xFC,0x0F,	// 100
	0x00,0x00,0xC0,0x07,0x60,0x0D,0x20,0x09,0x20,0x09,0x60,0x09,0xC0,0x09,	// 101
	0x20,0x00,0xF8,0x0F,0x24,0x00,0x24,	// 102
	0x00,0x00,0xC0,0x07,0x60,0x4C,0x20,0x48,0x20,0x48,0x40,0x64,0xE0,0x3F,	// 103
	0x00,0x00,0xFC,0x0F,0x40,0x00,0x20,0x00,0x20,0x00,0xC0,0x0F,	// 104
	0x00,0x00,0xE4,0x0F,	// 105
	0x00,0x40,0xE4,0x3F,	// 106
	0x00,0x00,0xFC,0x0F,0x00,0x01,0x80,0x02,0x40,0x04,0x20,0x08,	// 107
	0x00,0x00,0xFC,0x0F,	// 108
	0x00,0x00,0xE0,0x0F,0x40,0x00,0x20,0x00,0x20,0x00,0xC0,0x0F,0x40,0x00,0x20,0x00,0x20,0x00,0xC0,0x0F,	// 109
	0x00,0x00,0xE0,0x0F,0x40,0x00,0x20,0x00,0x20,0x00,0xC0,0x0F,	// 110
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x08,0x20,0x08,0x60,0x0C,0xC0,0x07,	// 111
	0x00,0x00,0xE0,0x7F,0x40,0x04,0x20,0x08,0x20,0x08,0x60,0x0C,0xC0,0x07,	// 112
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x08,0x20,0x08,0x40,0x04,0xE0,0x7F,	// 113
	0x00,0x00,0xE0,0x0F,0x40,0x00,0x20,0x00,0x20,	// 114
	0x00,0x00,0xC0,0x08,0x20,0x09,0x20,0x09,0x20,0x09,0x20,0x06,	// 115
	0x20,0x00,0xF8,0x0F,0x20,0x08,0x20,0x08,	// 116
	0x00,0x00,0xE0,0x07,0x00,0x08,0x00,0x08,0x00,0x04,0xE0,0x0F,	// 117
	0x00,0x00,0xE0,0x00,0x00,0x07,0x00,0x08,0x00,0x07,0xE0,0x01,0x20,	// 118
	0x00,0x00,0xE0,0x01,0x00,0x0E,0x00,0x0F,0xE0,0x00,0xE0,0x01,0x00,0x0E,0x00,0x0F,0xE0,	// 119
	0x00,0x00,0x20,0x0C,0xC0,0x06,0x80,0x01,0xC0,0x06,0x60,0x0C,	// 120
	0x00,0x00,0xE0,0x40,0x00,0x67,0x00,0x38,0x00,0x07,0xE0,0x00,0x20,	// 121
	0x00,0x00,0x20,0x0C,0x20,0x0E,0x20,0x0B,0xA0,0x08,0x60,0x08,0x20,0x08,	// 122
	0x00,0x00,0x80,0x00,0x80,0x00,0x7C,0x3F,0x04,0x20,0x04,0x20,	// 123
	0x00,0x00,0x00,0x00,0xFC,0x3F,	// 124
	0x00,0x00,0x04,0x20,0x04,0x20,0x7C,0x3F,0x80,0x00,0x80,	// 125
	0x00,0x00,0x00,0x01,0x80,0x00,0x80,0x00,0x80,0x00,0x00,0x01,0x00,0x01,0x00,0x01,0x80,	// 126
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 127
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 128
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 129
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 130
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 131
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 132
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 133
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 134
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 135
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 136
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 137
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 138
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 139
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 140
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 141
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 142
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 143
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 144
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 145
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 146
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 147
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 148
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 149
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 150
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 151
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 152
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 153
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 154
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 155
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 156
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 157
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 158
	0xF8,0x3F,0x08,0x20,0x08,0x20,0x08,0x20,0x08,0x20,0xF8,0x3F,	// 159
	0x00,0x00,0x00,0x00,0xC8,0x0F,	// 161
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x08,0xF0,0x3F,0x20,0x08,0x20,0x08,	// 162
	0x00,0x00,0x80,0x08,0xF0,0x0F,0x88,0x08,0x88,0x08,0x88,0x08,0x08,0x08,	// 163
	0x00,0x00,0xC0,0x07,0x40,0x04,0x40,0x04,0x40,0x04,0xC0,0x07,	// 164
	0x00,0x00,0x58,0x01,0x60,0x01,0x80,0x0F,0x60,0x01,0x58,0x01,	// 165
	0x00,0x00,0x00,0x00,0x78,0x3C,	// 166
	0x00,0x00,0xB0,0x21,0x48,0x22,0x48,0x24,0x88,0x1C,0x00,0x03,	// 167
	0x00,0x00,0x04,0x00,0x00,0x00,0x04,	// 168
	0x00,0x00,0x00,0x00,0xE0,0x03,0x30,0x06,0xD8,0x0D,0x28,0x0A,0x28,0x0A,0x28,0x0A,0x18,0x0C,0x30,0x06,0xE0,0x03,	// 169
	0x00,0x00,0xE8,0x02,0xA8,0x02,0xA8,0x02,0xF0,0x02,	// 170
	0x00,0x00,0x00,0x01,0x80,0x02,0x40,0x05,0x80,0x01,0xC0,0x02,0x40,0x04,	// 171
	0x00,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0x80,0x07,	// 172
	0x00,0x00,0x00,0x01,0x00,0x01,0x00,0x01,	// 173
	0x00,0x00,0x00,0x00,0xE0,0x03,0x30,0x06,0x18,0x0C,0xE8,0x0B,0xA8,0x08,0x68,0x0B,0x18,0x0C,0x30,0x06,0xE0,0x03,	// 174
	0x00,0x00,0x04,0x00,0x04,0x00,0x04,0x00,0x04,	// 175
	0x00,0x00,0x30,0x00,0x48,0x00,0x48,0x00,0x30,	// 176
	0x00,0x00,0x80,0x08,0x80,0x08,0x80,0x08,0xF0,0x0B,0x80,0x08,0x80,0x08,0x80,0x08,0x80,0x08,	// 177
	0x08,0x01,0x88,0x01,0x48,0x01,0x38,0x01,	// 178
	0x08,0x01,0x28,0x01,0x28,0x01,0xD8,	// 179
	0x00,0x00,0x00,0x00,0x08,0x00,0x04,0x00,0x02,	// 180
	0x00,0x00,0xE0,0x7F,0x00,0x08,0x00,0x08,0x00,0x08,0xE0,0x0F,0x00,0x08,	// 181
	0x20,0x00,0xF0,0x00,0xF8,0x00,0xF8,0x3F,0x08,0x00,0xF8,0x3F,	// 182
	0x00,0x00,0x80,	// 183
	0x00,0x00,0x00,0x00,0x00,0x40,0x00,0x60,	// 184
	0x00,0x00,0x88,0x00,0xF8,0x00,0x80,	// 185
	0x00,0x00,0x70,0x02,0x88,0x02,0x88,0x02,0x88,0x02,0x70,0x02,	// 186
	0x00,0x00,0x40,0x06,0x80,0x02,0x40,0x05,0xC0,0x02,0x80,0x01,0x00,0x01,	// 187
	0x00,0x00,0x88,0x00,0xF8,0x00,0x80,0x0C,0x00,0x03,0x80,0x00,0x60,0x00,0x18,0x07,0x00,0x05,0x80,0x0F,0x00,0x04,	// 188
	0x00,0x00,0x88,0x00,0xF8,0x00,0x80,0x08,0x00,0x06,0x80,0x01,0x40,0x00,0xB0,0x08,0x88,0x0C,0x80,0x0A,0x80,0x09,	// 189
	0x88,0x00,0xA8,0x00,0xA8,0x00,0xD8,0x0C,0x00,0x03,0xC0,0x00,0x20,0x00,0x18,0x07,0x80,0x04,0x80,0x0F,0x00,0x04,	// 190
	0x00,0x00,0x00,0x07,0x80,0x09,0xE8,0x08,0x00,0x08,	// 191
	0x00,0x08,0x00,0x0F,0xE0,0x03,0x39,0x02,0x1A,0x02,0xE0,0x02,0x00,0x07,0x00,0x0C,	// 192
	0x00,0x08,0x00,0x0F,0xE0,0x03,0x38,0x02,0x1B,0x02,0xE1,0x02,0x00,0x07,0x00,0x0C,	// 193
	0x00,0x08,0x00,0x0F,0xE0,0x03,0x3A,0x02,0x1B,0x02,0xE0,0x02,0x00,0x07,0x00,0x0C,	// 194
	0x00,0x08,0x00,0x0F,0xE3,0x03,0x39,0x02,0x1A,0x02,0xE3,0x02,0x00,0x07,0x00,0x0C,	// 195
	0x00,0x0C,0x80,0x07,0xF2,0x02,0x08,0x02,0xF2,0x02,0x80,0x07,0x00,0x0C,	// 196
	0x00,0x0C,0x80,0x03,0x77,0x02,0x19,0x02,0x66,0x02,0x80,0x03,0x00,0x0C,	// 197
	0x00,0x0C,0x00,0x07,0xE0,0x03,0x38,0x02,0x08,0x02,0xF8,0x0F,0x88,0x08,0x88,0x08,0x88,0x08,0x88,0x08,	// 198
	0x00,0x00,0xE0,0x03,0x10,0x06,0x08,0x0C,0x08,0x4C,0x08,0x7C,0x08,0x0C,0x10,0x04,	// 199
	0x00,0x00,0xF8,0x0F,0x89,0x08,0x8A,0x08,0x88,0x08,0x88,0x08,	// 200
	0x00,0x00,0xF8,0x0F,0x88,0x08,0x8A,0x08,0x89,0x08,0x88,0x08,	// 201
	0x00,0x00,0xF8,0x0F,0x8A,0x08,0x89,0x08,0x8A,0x08,0x88,0x08,	// 202
	0x00,0x00,0xF8,0x0F,0x8A,0x08,0x88,0x08,0x8A,0x08,0x88,0x08,	// 203
	0x01,0x00,0xFA,0x0F,	// 204
	0x00,0x00,0xFA,0x0F,0x01,	// 205
	0x02,0x00,0xF9,0x0F,0x02,	// 206
	0x00,0x00,0x02,0x00,0xF8,0x0F,0x02,	// 207
	0x80,0x00,0xF8,0x0F,0x88,0x08,0x88,0x08,0x08,0x08,0x08,0x08,0x10,0x04,0xE0,0x03,	// 208
	0x00,0x00,0xF8,0x0F,0x1A,0x00,0x61,0x00,0xC3,0x01,0x02,0x03,0x01,0x0C,0xF8,0x0F,	// 209
	0x00,0x00,0xE0,0x03,0x10,0x04,0x08,0x08,0x09,0x08,0x0A,0x08,0x08,0x08,0x10,0x04,0xE0,0x03,	// 210
	0x00,0x00,0xE0,0x03,0x10,0x04,0x08,0x08,0x0A,0x08,0x09,0x08,0x08,0x08,0x10,0x04,0xE0,0x03,	// 211
	0x00,0x00,0xE0,0x03,0x10,0x04,0x0A,0x08,0x09,0x08,0x09,0x08,0x0A,0x08,0x10,0x04,0xE0,0x03,	// 212
	0x00,0x00,0xE0,0x03,0x10,0x04,0x0B,0x08,0x09,0x08,0x0A,0x08,0x0B,0x08,0x10,0x04,0xE0,0x03,	// 213
	0x00,0x00,0xE0,0x03,0x10,0x04,0x0A,0x08,0x08,0x08,0x08,0x08,0x0A,0x08,0x10,0x04,0xE0,0x03,	// 214
	0x00,0x00,0x00,0x00,0x20,0x04,0x40,0x02,0x80,0x01,0x80,0x01,0x40,0x02,0x20,0x04,	// 215
	0x00,0x00,0xE0,0x0B,0x10,0x04,0x08,0x0B,0x88,0x09,0xC8,0x08,0x68,0x08,0x10,0x04,0xE8,0x03,	// 216
	0x00,0x00,0xF8,0x07,0x00,0x0C,0x01,0x08,0x02,0x08,0x00,0x08,0x00,0x0C,0xF8,0x07,	// 217
	0x00,0x00,0xF8,0x07,0x00,0x0C,0x00,0x08,0x02,0x08,0x01,0x08,0x00,0x0C,0xF8,0x07,	// 218
	0x00,0x00,0xF8,0x07,0x00,0x0C,0x03,0x08,0x01,0x08,0x03,0x08,0x00,0x0C,0xF8,0x07,	// 219
	0x00,0x00,0xF8,0x07,0x00,0x0C,0x02,0x08,0x00,0x08,0x02,0x08,0x00,0x0C,0xF8,0x07,	// 220
	0x08,0x00,0x10,0x00,0x60,0x00,0x82,0x0F,0x60,0x00,0x18,0x00,0x08,	// 221
	0x00,0x00,0xF8,0x0F,0x20,0x02,0x20,0x02,0x20,0x02,0x20,0x02,0xC0,0x01,	// 222
	0x00,0x00,0xF8,0x0F,0x04,0x00,0xE4,0x08,0x94,0x08,0x18,0x09,0x00,0x06,	// 223
	0x00,0x00,0x60,0x06,0x24,0x09,0x28,0x09,0x30,0x09,0x60,0x05,0xC0,0x0F,	// 224
	0x00,0x00,0x60,0x06,0x20,0x09,0x30,0x09,0x28,0x09,0x64,0x05,0xC0,0x0F,	// 225
	0x00,0x00,0x60,0x06,0x38,0x09,0x24,0x09,0x2C,0x09,0x70,0x05,0xC0,0x0F,	// 226
	0x00,0x00,0x60,0x06,0x2C,0x09,0x24,0x09,0x28,0x09,0x6C,0x05,0xC0,0x0F,	// 227
	0x00,0x00,0x60,0x06,0x24,0x09,0x20,0x09,0x24,0x09,0x60,0x05,0xC0,0x0F,	// 228
	0x00,0x00,0x60,0x06,0x24,0x09,0x2A,0x09,0x2A,0x09,0x64,0x05,0xC0,0x0F,	// 229
	0x00,0x00,0x20,0x07,0xA0,0x08,0xA0,0x08,0xA0,0x0C,0xC0,0x07,0x60,0x0D,0x20,0x09,0x20,0x09,0x60,0x09,0xC0,0x09,	// 230
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x4C,0x20,0x7C,0x20,0x04,	// 231
	0x00,0x00,0xC0,0x07,0x64,0x0D,0x2C,0x09,0x20,0x09,0x60,0x09,0xC0,0x09,	// 232
	0x00,0x00,0xC0,0x07,0x60,0x0D,0x20,0x09,0x2C,0x09,0x64,0x09,0xC0,0x09,	// 233
	0x00,0x00,0xC0,0x07,0x68,0x0D,0x24,0x09,0x24,0x09,0x68,0x09,0xC0,0x09,	// 234
	0x00,0x00,0xC0,0x07,0x60,0x0D,0x24,0x09,0x20,0x09,0x64,0x09,0xC0,0x09,	// 235
	0x04,0x00,0xF8,0x0F,	// 236
	0x00,0x00,0xF8,0x0F,0x04,	// 237
	0x08,0x00,0xE4,0x0F,0x08,	// 238
	0x04,0x00,0xE0,0x0F,0x04,	// 239
	0x00,0x00,0xC0,0x07,0x74,0x0C,0x2C,0x08,0x38,0x08,0x24,0x0C,0xC0,0x07,	// 240
	0x00,0x00,0xE0,0x0F,0x4C,0x00,0x2C,0x00,0x2C,0x00,0xC0,0x0F,	// 241
	0x00,0x00,0xC0,0x07,0x64,0x0C,0x2C,0x08,0x20,0x08,0x60,0x0C,0xC0,0x07,	// 242
	0x00,0x00,0xC0,0x07,0x60,0x0C,0x20,0x08,0x2C,0x08,0x64,0x0C,0xC0,0x07,	// 243
	0x00,0x00,0xC0,0x07,0x68,0x0C,0x24,0x08,0x24,0x08,0x68,0x0C,0xC0,0x07,	// 244
	0x00,0x00,0xC0,0x07,0x6C,0x0C,0x24,0x08,0x28,0x08,0x6C,0x0C,0xC0,0x07,	// 245
	0x00,0x00,0xC0,0x07,0x64,0x0C,0x20,0x08,0x20,0x08,0x64,0x0C,0xC0,0x07,	// 246
	0x00,0x00,0x80,0x00,0x80,0x00,0x80,0x00,0xA0,0x02,0x80,0x00,0x80,0x00,0x80,0x00,0x80,	// 247
	0x00,0x00,0xC0,0x0F,0x60,0x0C,0x20,0x0B,0xA0,0x08,0x60,0x0C,0xE0,0x07,	// 248
	0x00,0x00,0xE0,0x07,0x04,0x08,0x18,0x08,0x00,0x04,0xE0,0x0F,	// 249
	0x00,0x00,0xE0,0x07,0x00,0x08,0x18,0x08,0x04,0x04,0xE0,0x0F,	// 250
	0x00,0x00,0xE0,0x07,0x18,0x08,0x04,0x08,0x18,0x04,0xE0,0x0F,	// 251
	0x00,0x00,0xE0,0x07,0x04,0x08,0x00,0x08,0x04,0x04,0xE0,0x0F,	// 252
	0x00,0x00,0xE0,0x40,0x00,0x67,0x10,0x38,0x0C,0x07,0xE4,0x01,0x20,	// 253
	0x00,0x00,0xFC,0x7F,0x40,0x04,0x20,0x08,0x20,0x08,0x60,0x0C,0xC0,0x07,	// 254
	0x00,0x00,0xE0,0x40,0x04,0x47,0x00,0x38,0x84,0x07,0xE0	// 255
};

#endif

