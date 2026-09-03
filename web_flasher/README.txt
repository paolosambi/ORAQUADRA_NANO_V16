========================================================================
 ORAQUADRA NANO  -  versione V16
 Web flasher: installazione dal browser o da riga di comando
 Build del 3 settembre 2026
========================================================================


NOVITÀ DI QUESTA VERSIONE

  Annuncio vocale all'accensione
    All'avvio la scheda si presenta e dice giorno, data e ora, presi
    dall'orologio di rete (NTP), quindi detta l'indirizzo a cui collegarsi:

      "Ciao sono OraQuadra Nano. Oggi è lunedì 20 ottobre 2026.
       Sono le ore 18 e 15 minuti. Con il browser Chrome collegati a
       http://192.168.1.50:8080"

    L'indirizzo viene scandito cifra per cifra, così si può trascrivere
    mentre lo si ascolta. Se l'ora di rete non è ancora disponibile
    l'annuncio viene rimandato al momento in cui arriva, invece di dire
    una data sbagliata.

    Le voci sono registrate nella scheda: l'annuncio non richiede alcun
    collegamento a servizi esterni. Oltre all'italiano sono disponibili
    inglese, tedesco, francese e spagnolo (vedi "SCHEDA microSD").

  Più reti WiFi memorizzate
    Ogni rete a cui la scheda si collega resta in memoria, fino a otto.
    Spostandola tra casa, ufficio o un altro sito, al ritorno si ricollega
    da sola: la procedura con il codice QR compare solo davanti a una rete
    mai vista. La memoria delle reti sopravvive agli aggiornamenti del
    firmware.

  Impostazioni applicate subito
    Nella pagina web e nel pannello impostazioni a schermo ogni modifica
    viene salvata e applicata immediatamente, senza premere alcun tasto di
    conferma: vale anche mentre si trascina un cursore o si scrive in un
    campo di testo. Nel pannello a schermo il salvataggio avviene appena si
    alza il dito, quindi nulla va perso se la pagina si chiude da sola.

  Correzioni all'annuncio dell'ora
    - "mezzanotte" viene detto solo quando è davvero mezzanotte
    - all'ora esatta non vengono più annunciati i minuti
    - orario sempre in formato 24 ore, dalle 0:00 alle 23:59


COSA SERVE
  - la scheda OraQuadra Nano e un cavo USB-C dati (non solo di ricarica)
  - per l'installazione dal browser: Chrome, Edge oppure Opera
  - per l'installazione da riga di comando: Python 3 con esptool
    (pip install esptool, su macOS e Linux pip3 install esptool)


INSTALLAZIONE DAL BROWSER (la piu' semplice)
  1. apri la pagina del web flasher con Chrome, Edge o Opera
  2. collega la scheda al computer
  3. premi il pulsante di installazione e scegli la porta seriale
     della scheda quando il browser la chiede

  Firefox e Safari non supportano WebSerial e non funzionano.


INSTALLAZIONE DA RIGA DI COMANDO

  Windows
    1. collega la scheda al computer
    2. apri Gestione dispositivi e annota la porta COM della scheda
       (per esempio COM5)
    3. doppio clic su  flash.bat  e digita la porta quando richiesta

  macOS e Linux
    1. collega la scheda
    2. da terminale:   ./flash.sh
    3. se compare un errore di permessi:
         sudo usermod -a -G dialout $USER
       poi esci e rientra nella sessione

  La scrittura dura circa due minuti. Non staccare il cavo.
  Se la scheda non viene riconosciuta, tieni premuto il tasto BOOT
  mentre colleghi il cavo, poi rilascialo.


PRIMO AVVIO
  La scheda cerca una rete WiFi conosciuta. Non trovandone, mostra sullo
  schermo un codice QR e crea una rete propria chiamata OraQuadra_xxxxxx:
  inquadra il QR con il telefono (oppure collegati a quella rete) e indica
  la rete di casa con la relativa password.

  A configurazione avvenuta la scheda annuncia a voce il proprio indirizzo:
  aprilo con il browser per accedere a tutte le impostazioni.


SCHEDA microSD (facoltativa)
  Gli annunci vocali in inglese, tedesco, francese e spagnolo stanno nel
  pacchetto completo, cartella SD_CARD: copia en, de, fr, es nella radice
  di una microSD e inseriscila nel lettore. Servono solo per quelle lingue,
  in italiano non serve alcuna microSD.


VERIFICA DEI FILE

  Le impronte SHA-256 dei binari pubblicati sono elencate qui sotto. Chi
  vuole controllare che il download sia integro puo' confrontarle:

      Windows   certutil -hashfile firmware.bin SHA256
      macOS     shasum -a 256 firmware.bin
      Linux     sha256sum firmware.bin

  bootloader.bin   2a71d69b471e20c2bac7fb469f3c6a807b3ebee780e348e5889db0da849ca363
  partitions.bin   6731888b421c3946dac16356659877021e0f46dbd1c55abafa17989eb7265387
  boot_app0.bin    f94c5d786a7a8fab06ac5d10e33bf37711a6697636dc037559ea19cc410a17f0
  firmware.bin     f5252abcac40bc4bcfd31bb1364973e706a89f4c396aa916ada736f699cc2468
  littlefs.bin     f95d82d52b7cf346a10db015b222be2cf194b5da83671f48191a65e29e874a18

CONTENUTO
  bootloader.bin          avvio della scheda            -> 0x0
  partitions.bin          mappa della memoria           -> 0x8000
  boot_app0.bin           selettore di avvio            -> 0xe000
  firmware.bin            programma OraQuadra Nano      -> 0x10000
  littlefs.bin            voci e risorse                -> 0xC10000
  manifest.json           configurazione per ESP Web Tools
  flash.bat               installazione su Windows
  flash.sh                installazione su macOS e Linux

  Qui trovi i programmi pronti da installare, non il codice sorgente:
  vedi "AUTORE E LICENZA" per ottenerlo.


RIPRISTINO
  La scheda resta sempre riprogrammabile: se qualcosa va storto, ripeti
  l'installazione. Nessuna protezione hardware viene attivata e nessuna
  memoria interna viene bloccata in modo permanente.


AUTORE E LICENZA

  OraQuadra Nano - Copyright (C) 2026 Paolo Sambinello
  https://github.com/paolosambi

  Questo programma e' software libero: puoi ridistribuirlo e modificarlo
  secondo i termini della GNU General Public License versione 3, come
  pubblicata dalla Free Software Foundation. Il testo completo della licenza
  si trova su https://www.gnu.org/licenses/gpl-3.0.html

  Il programma e' distribuito nella speranza che sia utile, ma SENZA ALCUNA
  GARANZIA, neppure la garanzia implicita di COMMERCIABILITA' o IDONEITA'
  PER UNO SCOPO PARTICOLARE.

  Cosa significa in pratica:
    - puoi usarlo, copiarlo, studiarlo e regalarlo a chi vuoi
    - puoi modificarlo e ridistribuire la tua versione, ma resta software
      libero sotto la stessa licenza
    - devi conservare l'attribuzione all'autore originale
    - non puoi ridistribuirlo come opera propria ne' renderlo proprietario:
      la licenza lo vieta, e la nota di paternita' e' incisa nel firmware
      stesso, dove resta leggibile anche estraendolo dalla scheda

  CODICE SORGENTE
  La GPL da' a chi riceve questo programma il diritto di ottenerne il codice
  sorgente completo. Lo trovi qui:

      https://github.com/paolosambi

  In alternativa puoi richiederlo all'autore: viene fornito nella stessa
  versione dei binari qui inclusi.

  Il programma usa librerie di terze parti con le rispettive licenze, tra cui
  ESP32-audioI2S (GPL), GFX Library for Arduino (BSD) e WiFiManager (MIT).
