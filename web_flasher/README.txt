============================================
  oraQuadra Nano - Flasher
  Sistema di programmazione
============================================
SCOMPATTARE LA CARTELLA build.zip in web_flasher/build e eseguire flash.bat (se win) flash.sh (se mac)

PREREQUISITI
------------
1. Arduino CLI installato
   - Download: https://arduino.github.io/arduino-cli/
   - Oppure: winget install Arduino.ArduinoCLI

2. Python installato (per il server locale)
   - Download: https://www.python.org/downloads/

3. Driver USB CH340/CP2102 installati


RISOLUZIONE PROBLEMI
--------------------
- "Porta COM non trovata": Installa i driver CH340/CP2102
- "Browser non supportato": Usa Chrome, Edge o Opera
- "Compilazione fallita": Verifica le librerie Arduino richieste
- "Connessione fallita": Prova un altro cavo USB (deve essere dati, non solo ricarica)


NOTE TECNICHE
-------------
- Board: ESP32-S3 Dev Module
- Partition: HUGE APP (per sketch grandi)
- PSRAM: OPI PSRAM
- Flash: 16MB
- Offset firmware: 0x10000 (65536)


============================================
Progetto oraQuadra di Paolo Sambinello
============================================
