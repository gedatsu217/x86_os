%include    "../include/define.s"
%include    "../include/macro.s"

    ORG     KERNEL_LOAD

[BITS 32]

kernel:
    mov     esi, BOOT_LOAD + SECT_SIZE
    movzx   eax, word [esi + 0]
    movzx   ebx, word [esi + 2]
    shl     eax, 4
    add     eax, ebx
    mov     [FONT_ADR], eax

    cdecl   draw_font, 63, 13




    jmp     $

ALIGN 4, db 0
FONT_ADR    dd  0

%include    "../modules/protect/vga.s"
%include    "../modules/protect/draw_char.s"
%include    "../modules/protect/draw_font.s"

    times   KERNEL_SIZE - ($ - $$)  db  0