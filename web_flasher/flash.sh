#!/bin/bash

echo "============================================"
echo "  oraQuadra Nano - Flash Diretto Completo"
echo "============================================"
echo ""

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"

# Verifica file necessari
for f in firmware.bin bootloader.bin partitions.bin boot_app0.bin; do
    if [ ! -f "$f" ]; then
        echo "[ERRORE] $f non trovato!"
        echo "Esegui prima compile.sh"
        exit 1
    fi
done

# Cerca littlefs.bin o littlefs_2mb.bin
LITTLEFS_FILE=""
if [ -f "littlefs.bin" ]; then
    LITTLEFS_FILE="littlefs.bin"
elif [ -f "littlefs_2mb.bin" ]; then
    LITTLEFS_FILE="littlefs_2mb.bin"
fi

if [ -z "$LITTLEFS_FILE" ]; then
    echo "[AVVISO] littlefs.bin non trovato - i file audio non saranno flashati"
    FLASH_LITTLEFS=0
else
    echo "      Trovato: $LITTLEFS_FILE"
    FLASH_LITTLEFS=1
fi

# Verifica Python
if ! command -v python3 &>/dev/null && ! command -v python &>/dev/null; then
    echo "[ERRORE] Python non trovato!"
    echo "Installa Python da: https://www.python.org/downloads/"
    echo "Oppure: brew install python3"
    exit 1
fi
PYTHON=$(command -v python3 || command -v python)

echo "[1/3] Verifico esptool..."
if ! $PYTHON -m pip show esptool &>/dev/null; then
    echo "      Installo esptool..."
    $PYTHON -m pip install esptool
fi

# Installa pyserial se necessario
if ! $PYTHON -c "import serial" &>/dev/null; then
    $PYTHON -m pip install pyserial
fi

echo ""
echo "[2/3] Cerco porte seriali disponibili..."
echo ""

# Lista porte seriali su macOS
$PYTHON -c "
import serial.tools.list_ports
ports = list(serial.tools.list_ports.comports())
if not ports:
    print('  Nessuna porta trovata!')
    print('  Assicurati che il dispositivo sia collegato via USB.')
    print('  Su macOS potresti dover installare il driver CH340/CP210x.')
else:
    for p in ports:
        print(f'  {p.device} - {p.description}')
"

echo ""
read -p "Inserisci la porta seriale (es. /dev/cu.usbserial-0001): " PORTA

if [ -z "$PORTA" ]; then
    echo "[ERRORE] Nessuna porta specificata!"
    exit 1
fi

echo ""
echo "[3/3] Flash COMPLETO in corso su $PORTA..."
echo "      Metti l'ESP32 in modalita BOOT se necessario"
echo "      (tieni premuto BOOT, premi RESET, rilascia BOOT)"
echo ""
echo "File da flashare:"
echo "  - bootloader.bin   @ 0x0"
echo "  - partitions.bin   @ 0x8000"
echo "  - boot_app0.bin    @ 0xe000"
echo "  - firmware.bin     @ 0x10000"
if [ $FLASH_LITTLEFS -eq 1 ]; then
    echo "  - $LITTLEFS_FILE     @ 0xC10000"
fi
echo ""

if [ $FLASH_LITTLEFS -eq 1 ]; then
    $PYTHON -m esptool --chip esp32s3 --port "$PORTA" --baud 921600 \
        --before default_reset --after hard_reset write_flash -z \
        --flash_mode dio --flash_freq 80m --flash_size 16MB \
        0x0 bootloader.bin \
        0x8000 partitions.bin \
        0xe000 boot_app0.bin \
        0x10000 firmware.bin \
        0xC10000 "$LITTLEFS_FILE"
else
    $PYTHON -m esptool --chip esp32s3 --port "$PORTA" --baud 921600 \
        --before default_reset --after hard_reset write_flash -z \
        --flash_mode dio --flash_freq 80m --flash_size 16MB \
        0x0 bootloader.bin \
        0x8000 partitions.bin \
        0xe000 boot_app0.bin \
        0x10000 firmware.bin
fi

if [ $? -eq 0 ]; then
    echo ""
    echo "============================================"
    echo "  FLASH COMPLETATO CON SUCCESSO!"
    echo "============================================"
    echo ""
    echo "Premi RESET sull'ESP32 per avviare il firmware."
else
    echo ""
    echo "[ERRORE] Flash fallito!"
    echo "Verifica:"
    echo "  - La porta seriale e corretta"
    echo "  - L'ESP32 e in modalita BOOT"
    echo "  - Il cavo USB e un cavo dati"
    echo "  - Su macOS: driver CH340/CP210x installato"
fi
