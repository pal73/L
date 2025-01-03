## Драйвер для ESP32.
На плате стоит какой-то CH9102X. (USB\VID_1A86&PID_55D4)

Драйвера нашлись [здесь](https://driverslab.ru/2213-winchiphead-ch34x-ch910x-usb-to-serial-driver.html) , (далее ведет в поганый яндекс браузер https://filesinfo.ru/r/20892/?link=https://driverslab.ru/download/ports/CH343CDC.ZIP
где справа вверху ссылочка на файлик CH343CDC.ZIP (лежит теперь на [гуглодиске](https://drive.google.com/file/d/1BvQlCLLOvIpd1B5ZKxWEBJseFLz2f5PS/view?usp=drive_link)) в нем экзешник сразу все сделал)

2. В плату необходимо прошить интерпретатор ПИТОНа. Первый раз - трэш)))

Прошивки интерпретаторов ПИТОНа для разных плат лежат там - https://micropython.org/download/
		для ESP32 - https://micropython.org/download/ESP32_GENERIC/ . Скачиваем прошивку (.bin)

Далее это нужно залить в ESP32. Тут начинаются танцы  

THONNY 4.1.4  это делать отказался и на буке и на компе хотя должен -

Процесс хорошо описан [здесь](https://randomnerdtutorials.com/flashing-micropython-firmware-esptool-py-esp32-esp8266/
) 
установить esptool удалось только на буке, на компе ни в какую  - через командную строку pip install esptool
для проверки правильности установки делаем там же  esptool.py version.

В компе нашлась exeшная версия esptool в C:\Users\PAL-HOME\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.6 ее использует ардуина при прошивке 
ESPшек, там я ее и подсмотрел.

Сначала стираем содержимое ESP32:
	для компа  - C:\Users\PAL-HOME\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.6>es
ptool.exe --chip esp32 erase_flash
	для бука - python -m esptool --chip esp32 erase_flash 

Далее: Заливаем прошивку интерпретатора Питона. Прошивку положить в одну папку с esptool.exe если на компе. Или 
сделать эту папку текущей в случае esptool.py :

для компа C:\Users\PAL-HOME\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.6>es
ptool.exe --chip esp32 --port COM44 write_flash -z 0x1000 ESP32_GENERIC-20240602
-v1.23.0.bin

для бука python -m esptool --chip esp32 --port COM44 write_flash -z 0x1000 ESP32_GENERIC-20240602-v1.23.0.bin

При стирании и прошивке иногда требовалось зажимать кнопку BOOT на ESP32

3. Можно приступать к экспериментам с Micropython в Thoony или в любой терминалке на скорости 115200

Светодиод на плате ESP32 - вторая ножка!!! 

Моргание светодиодом - 

>>> import machine
>>> p2 = machine.Pin(2, machine.Pin.OUT)
>>> p2.on()
>>> p2.off()
>>> p2.on()

На help() выдает некоторое количество полезной инфы


 [Документация на Micropython](https://docs.micropython.org/en/latest/)
