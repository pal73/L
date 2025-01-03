// чтение температуры (подключение к любым пинам)
#include <GyverMAX6675.h>
#include <SPI.h>

// Пины модуля MAX6675K
#define CLK_PIN   D3  // Пин SCK
#define DATA_PIN  D1  // Пин SO
#define CS_PIN    D2  // Пин CS

// перед подключением библиотеки можно
// задать задержку переключения CLK в микросекундах
// для увеличения качества связи по длинным проводам
//#define MAX6675_DELAY 10

// указываем пины в порядке SCK SO CS
GyverMAX6675<CLK_PIN, DATA_PIN, CS_PIN> sens;

double readThermocouple() {
 
  uint16_t v;
  pinMode(CS_PIN, OUTPUT);
  pinMode(DATA_PIN, INPUT);
  pinMode(CLK_PIN, OUTPUT);
  
  digitalWrite(CS_PIN, LOW);
  delay(1);
 
  // Read in 16 bits,
  //  15    = 0 always
  //  14..2 = 0.25 degree counts MSB First
  //  2     = 1 if thermocouple is open circuit  
  //  1..0  = uninteresting status
  
  v = shiftIn(DATA_PIN, CLK_PIN, MSBFIRST);
  v <<= 8;
  v |= shiftIn(DATA_PIN, CLK_PIN, MSBFIRST);
  
  digitalWrite(CS_PIN, HIGH);
  if (v & 0x4) 
  {    
    // Bit 2 indicates if the thermocouple is disconnected
    return NAN;     
  }
 
  // The lower three bits (0,1,2) are discarded status bits
  v >>= 3;
 
  // The remaining bits are the number of 0.25 degree (C) counts
  return v*0.25;
}

void setup() {
  Serial.begin(9600);
}

void loop() {
  float temperature_read = readThermocouple();
/*  if (sens.readTemp()) {            // Читаем температуру
    Serial.print("Temp: ");         // Если чтение прошло успешно - выводим в Serial
    Serial.print(sens.getTemp());   // Забираем температуру через getTemp
    //Serial.print(sens.getTempInt());   // или getTempInt - целые числа (без float)
    Serial.println(" *C");
  } else Serial.println("Error");   // ошибка чтения или подключения - выводим лог*/

      Serial.print("Temp: ");         // Если чтение прошло успешно - выводим в Serial
    Serial.print(temperature_read);   // Забираем температуру через getTemp
    //Serial.print(sens.getTempInt());   // или getTempInt - целые числа (без float)
    Serial.println(" *C");

  delay(1000);                      // Немного подождем
}
