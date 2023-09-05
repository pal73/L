// получаем клики со страницы и значения с компонентов

#define AP_SSID "PAL-HOME-XI"
#define AP_PASS "palpalpal"

#include <GyverPortal.h>
GyverPortal ui;

#include <Ticker.h>
Ticker time_grid;

// переменные
bool valCheck;
bool valSwitch;
String valText;
int valNum;
char valPass[10];
float valSpin;
int valSlider;
GPdate valDate;
GPtime valTime;
GPcolor valCol;
int valSelect;
int valRad;

//********************************************************************
//Сетка времени
char tgh_cnt0, tgh_cnt1, tgh_cnt2, tgh_cnt3, tgh_cnt4;
bool b1000Hz, b100Hz, b10Hz, b5Hz, b2Hz, b1Hz;

//********************************************************************
//Индикация
bool led_output;

//********************************************************************
//Отладка
short plazma;


//--------------------------------------------------------------------
//Сетка времени
void time_grid_hndl(void)
{
b1000Hz=1;
if(++tgh_cnt0>=10)
  {
  tgh_cnt0=0;
  b100Hz=1;
  if(++tgh_cnt1>=10)
    {
    tgh_cnt1=0;
    b10Hz=1;
    }
  if(++tgh_cnt2>=20)
    {
    tgh_cnt2=0;
    b5Hz=1;
    }  
  if(++tgh_cnt3>=50)
    {
    tgh_cnt3=0;
    b2Hz=1;
    } 
  if(++tgh_cnt4>=100)
    {
    tgh_cnt4=0;
    b1Hz=1;
    }  
  }
}

// конструктор страницы
void build() {
  GP.BUILD_BEGIN(GP_DARK);

  GP.TITLE("Title", "t1");
  GP.HR();

  GP.LABEL("Value: ");
  GP.LABEL("NAN", "val");       GP.BREAK();
  GP.LABEL("Check: ");
  GP.CHECK("ch", valCheck);     GP.BREAK();
  GP.LABEL("Switch: ");
  GP.SWITCH("sw", valSwitch);   GP.BREAK();
  GP.TEXT("txt", "text", valText);    GP.BREAK();
  GP.NUMBER("num", "number", valNum); GP.BREAK();
  GP.PASS("pass", "pass", valPass);   GP.BREAK();
  GP.SPINNER("spn", valSpin);
  GP.SLIDER("sld", valSlider, 0, 10); GP.BREAK();
  GP.DATE("date", valDate);     GP.BREAK();
  GP.TIME("time", valTime);     GP.BREAK();
  GP.COLOR("col", valCol);      GP.BREAK();
  GP.SELECT("sel", "val 1,val 2,val 3", valSelect);  GP.BREAK();
  GP.RADIO("rad", 0, valRad); GP.LABEL("Value 0"); GP.BREAK();
  GP.RADIO("rad", 1, valRad); GP.LABEL("Value 1"); GP.BREAK();
  GP.RADIO("rad", 2, valRad); GP.LABEL("Value 2"); GP.BREAK();
  GP.RADIO("rad", 3, valRad); GP.LABEL("Value 3"); GP.BREAK();
  GP.BREAK();
  GP.BUTTON("btn", "Button");

  GP.UPDATE("num");

  GP.BUILD_END();
}

void setup() {
  pinMode(LED_BUILTIN,OUTPUT);
  Serial.begin(115200);
  WiFi.mode(WIFI_STA);
  WiFi.begin(AP_SSID, AP_PASS);
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println(WiFi.localIP());

  // подключаем конструктор и запускаем
  ui.attachBuild(build);
  ui.attach(action);
  ui.start();

  time_grid.attach(0.001, time_grid_hndl);
}

void action() {
  if (ui.update()) {
    Serial.println(ui.updateName());
    
    if (ui.update("num")) ui.answer(plazma);   // просто ответ
    //if (portal.update("sld")) portal.answer(sld);           // ответ из переменной
  }
  
  // был клик по компоненту
  if (ui.click()) {
    // проверяем компоненты и обновляем переменные

    // 1. переписали вручную
    if (ui.click("ch")) {
      valCheck = ui.getBool("ch");
      Serial.print("Check: ");
      Serial.println(valCheck);
    }

    // 2. автоматическое обновление переменной
    if (ui.clickBool("sw", led_output/*valSwitch*/)) {
      Serial.print("Switch: ");
      Serial.println(valSwitch);
    }

    if (ui.clickString("txt", valText)) {
      Serial.print("Text: ");
      Serial.println(valText);
    }

    if (ui.clickInt("num", valNum)) {
      Serial.print("Number: ");
      Serial.println(valNum);
    }

    if (ui.clickStr("pass", valPass)) {
      Serial.print("Password: ");
      Serial.println(valPass);
    }

    if (ui.clickFloat("spn", valSpin)) {
      Serial.print("Spinner: ");
      Serial.println(valSpin);
    }

    if (ui.clickInt("sld", valSlider)) {
      Serial.print("Slider: ");
      Serial.println(valSlider);
    }

    if (ui.clickDate("date", valDate)) {
      Serial.print("Date: ");
      Serial.println(valDate.encode());
    }

    if (ui.clickTime("time", valTime)) {
      Serial.print("Time: ");
      Serial.println(valTime.encode());
    }

    if (ui.clickColor("col", valCol)) {
      Serial.print("Color: ");
      Serial.println(valCol.encode());
    }

    if (ui.clickInt("sel", valSelect)) {
      Serial.print("Select: ");
      Serial.println(valSelect);
    }
    if (ui.clickInt("rad", valRad)) {
      Serial.print("Radio: ");
      Serial.println(valRad);
    }

    if (ui.click("btn")) plazma++;//Serial.println("Button click");
  }
}

void loop() 
{
ui.tick();

if(b1000Hz)
  {
  b1000Hz=0;
  }  

if(b100Hz)
  {
  b100Hz=0;
  }

if(b10Hz)
  {
  b10Hz=0;

  //led_output=!led_output;
  digitalWrite(LED_BUILTIN, led_output);
  }

if(b5Hz)
  {
  b5Hz=0;

  
  }

if(b2Hz)
  {
  b2Hz=0;
  }

if(b1Hz)
  {
  b1Hz=0;

  Serial.println(plazma);
  }
}
