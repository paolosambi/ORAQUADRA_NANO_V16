============================================
  oraQuadra Nano V16 - Web Flasher
============================================

PREREQUISITI
------------
- Arduino CLI  (winget install Arduino.ArduinoCLI)
- Python       (https://www.python.org/downloads/)
- Driver USB CH340 o CP2102
- Browser con WebSerial: Chrome, Edge o Opera


COMPILAZIONE
------------
Esegui compile.bat dalla cartella web_flasher.

Lo script fa tutto in automatico:
  [1/4] Installa ESP32 core 2.0.17 se mancante
  [2/4] Configura il partition scheme custom_16mb_ota
  [3/4] Compila lo sketch
  [4/4] Copia i bin e genera merged.bin


FLASH VIA USB
-------------
Esegui flash.bat (Windows) o flash.sh (macOS/Linux).
Usa esptool.py per scrivere direttamente sulla flash via seriale.


FLASH VIA BROWSER
-----------------
Il manifest.json e' gia configurato per ESP Web Tools.
Servire questa cartella via HTTPS e aprire la pagina in Chrome.


PRIMO AVVIO DOPO IL FLASH
--------------------------
Il firmware al boot:
  1. Inizializza la SD card (FAT32)
  2. Crea la cartella /ARCADE se non esiste
  3. Da quel momento si possono caricare le ROM via web
     collegandosi al dispositivo e aprendo la pagina /arcade


FILE
----
compile.bat           Script di compilazione
flash.bat             Flash via USB (Windows)
flash.sh              Flash via USB (macOS/Linux)
manifest.json         Configurazione ESP Web Tools

bootloader.bin        Bootloader          @ 0x0
partitions.bin        Tabella partizioni  @ 0x8000
boot_app0.bin         Boot OTA            @ 0xE000
firmware.bin          Firmware            @ 0x10000
littlefs.bin          LittleFS: voci      @ 0xC10000
build/                File di compilazione


NOTE TECNICHE
-------------
Board:       ESP32-S3 Dev Module
Core:        esp32 2.0.17
Partizioni:  custom_16mb_ota (6MB app + 6MB OTA + 3.8MB LittleFS)
Flash:       16MB, QIO, 80MHz
PSRAM:       OPI
SD Card:     SPI - CS=42, MOSI=47, CLK=48, MISO=41, FAT32


PROBLEMI COMUNI
---------------
Porta COM non trovata     -> Installa driver CH340/CP2102
Browser non supportato    -> Serve Chrome, Edge o Opera
Cavo USB non funziona     -> Deve essere un cavo dati, non solo ricarica
SD non rilevata           -> Verificare inserimento e formato FAT32


============================================
Progetto oraQuadra di Paolo Sambinello
============================================
