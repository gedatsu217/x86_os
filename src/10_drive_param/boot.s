%include    "../include/define.s"
%include    "../include/macro.s"

    ORG         BOOT_LOAD

entry:
    jmp     ipl

    times   90 - ($ - $$) db 0x90

ipl:
    cli
    mov     ax, 0x0000
    mov     ds, ax
    mov     es, ax
    mov     ss, ax
    mov     sp, BOOT_LOAD
    sti
    mov     [BOOT + drive.no], dl

    cdecl   puts, .s0

    mov     bx, BOOT_SECT - 1
    mov     cx, BOOT_LOAD + SECT_SIZE

    cdecl   read_chs, BOOT, bx, cx

    cmp     ax, bx
.10Q:
    jz     .10E
.10T:
    cdecl   puts, .e0
    call    reboot
.10E:
    jmp     stage_2


.s0 db  "Booting...", 0x0A, 0x0D, 0
.s1 db  "--------", 0x0A, 0x0D, 0
.e0 db  "Error:sector read", 0

ALIGN 2, db 0
BOOT:
    istruc  drive
        at  drive.no,   dw  0
        at  drive.cyln, dw  0
        at  drive.head, dw  0
        at  drive.sect, dw  2
    iend
.DRIVE:     dw  0

%include    "../modules/real/puts.s"
%include    "../modules/real/reboot.s"
%include    "../modules/real/read_chs.s"

    times   510 - ($ - $$) db 0x00
    db      0x55, 0xAA

%include    "../modules/real/itoa.s"
%include    "../modules/real/get_drive_param.s"

stage_2:
    cdecl   puts, .s0

    cdecl   get_drive_param, BOOT
    cmp     ax, 0
.10Q:
    jne     .10E
.10T:
    cdecl   puts, .e0
    call    reboot
.10E:
    mov     ax, [BOOT + drive.no]
    cdecl   itoa, ax, .p1, 2, 16, 0b0100
    mov     ax, [BOOT + drive.cyln]
    cdecl   itoa, ax, .p2, 4, 16, 0b0100
    mov     ax, [BOOT + drive.head]
    cdecl   itoa, ax, .p3, 2, 16, 0b0100
    mov     ax, [BOOT + drive.sect]
    cdecl   itoa, ax, .p4, 2, 16, 0b0100
    cdecl   puts, .s1

    jmp     $

.s0 db  "2nd stage...", 0x0A, 0x0D, 0

.s1 db  " Drive:0x"
.p1 db  "  , C:0x"
.p2 db  "    , H:0x"
.p3 db  "  , S:0x"
.p4 db  "  ", 0x0A, 0x0D, 0

.e0 db  "Can't get drive parameter.", 0

    times BOOT_SIZE - ($ - $$)   db  0