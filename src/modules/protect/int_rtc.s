rtc_int_en:
    push    ebp
    mov     ebp, esp

    push    eax

    outp    0x70, 0x0B
    in      al, 0x71
    or      al, [ebp + 8]

    out     0x71, al

    pop     eax
    mov     esp, ebp
    pop     ebp

    ret

int_rtc:
    pusha
    push    ds
    push    es

    mov     ax, 0x0010
    mov     ds, ax
    mov     es, ax

    cdecl   rtc_get_time, RTC_TIME

    outp    0x70, 0x0C
    in      al, 0x71

    mov     al, 0x20
    out     0xA0, al
    out     0x20, al

    pop     es
    pop     ds
    popa

    iret