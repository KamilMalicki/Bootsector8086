[org 0x7c00]              ; Określenie początku kodu w pamięci na adres 0x7c00, typowe dla sektora rozruchowego

start:
    mov ax, 0x0000        ; Ustawienie rejestru AX na 0, co jest używane do ustawienia trybu wideo
    int 10h               ; Wywołanie przerwania BIOS 0x10 - ustawienie trybu ekranu (video mode)
                           ; 0x0000 ustawia tryb tekstowy o standardowych rozmiarach ekranu

    mov si, .hello        ; Załadowanie adresu ciągu "Hello, World!" do rejestru SI (Source Index)
    call print            ; Wywołanie funkcji "print", która wypisuje tekst na ekranie
    hlt                   ; Zatrzymanie programu (po wypisaniu tekstu program kończy działanie)

.hello:
    db 'Hello, World!', 0 ; Definicja ciągu tekstowego "Hello, World!" zakończonego zerem (null terminator)

print:
    lodsb                 ; Załadowanie kolejnego bajtu z ciągu (adres wskazywany przez SI) do rejestru AL
    or al, al             ; Sprawdzenie, czy w rejestrze AL znajduje się zero (czy osiągnięto koniec tekstu)
    jz done               ; Jeśli AL == 0 (czyli napotkano null terminator), przejdź do etykiety "done"
    
    mov ah, 0x0e          ; Ustawienie rejestru AH na 0x0e - telegrafowanie (TTY) w trybie tekstowym (wypisanie znaku)
    int 0x10              ; Wywołanie BIOS-owego przerwania 0x10, które odpowiada za rysowanie znaku na ekranie
    jmp print             ; Skok z powrotem do początku funkcji "print", aby kontynuować wypisywanie tekstu

done:
    ret                   ; Zakończenie funkcji "print" i powrót do miejsca, w którym funkcja została wywołana

; Padding - musimy upewnić się, że rozmiar sektora rozruchowego wynosi 512 bajtów.
; Użycie "times" powoduje, że wypełniamy pozostałą część sektora zerami.
    times 510 - ($ - $$) db 0  ; Wypełnienie reszty sektora rozruchowego zerami (aż do 510 bajtów)
    dw 0xAA55              ; Podpis sektora rozruchowego (0xAA55) - BIOS sprawdza ten ciąg jako oznaczenie poprawnego sektora rozruchowego
