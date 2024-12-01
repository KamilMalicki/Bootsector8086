[org 0x7c00]

start:
    mov ax, 0x0000
    int 10h

    mov si, .hello
    call print
    hlt

.hello:
    db 'Hello, World!', 0


print:
    lodsb
    or al, al
    jz done
    mov ah, 0x0e
    int 0x10
    jmp print
done:
    ret

    times 510 - ($ - $$) db 0
    dw 0xAA55

