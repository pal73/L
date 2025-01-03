Для плат с ESP32  у которых нет onboard чипа USB-преобразователя при работе на 
WIN7 существует проблема драйверов. 
Для решения нужна программа zadig (Положил на гуглдиск/Полезное). 
Устанавливать драйвера по пуктам в https://voltiq.ru/s/esp32-c3-supermini-ne-opredelyaetsya-windows-8-1-kak-com-port/
Для прошивки необходимо вводить плату в режим программирования BOOT потом RESET.
После прошивки RESET
Плата похоже не может отдавать Serial по USB

https://duino.ru/blog/esp32-c3-osobennosti/   тут схема
https://duino.ru/esp32-c3/			в комментах полезное
https://github.com/sigmdel/supermini_esp32c3_sketches?tab=readme-ov-file#06_async_web_led  пробные скетчи на гитхабе

1


