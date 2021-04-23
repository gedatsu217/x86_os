init_page:
    pusha
    cdecl   page_set_4m, CR3_BASE
    mov     [0x00106000 + 0x107 * 4], dword 0
    popa
    ret


page_set_4m:
    push    ebp
    mov     ebp, esp

    pusha

    cld     
    mov     edi, [ebp + 8]
    mov     eax, 0x00000000
    mov     ecx, 1024
    rep     stosd

    mov     eax, edi
    and     eax, ~0x0000_0FFF
    or      eax, 7
    mov     [edi - (1024 * 4)], eax

    mov     eax, 0x00000007
    mov     ecx, 1024

.10L:
    stosd
    add     eax, 0x00001000
    loop    .10L 

    popa
    mov     esp, ebp
    pop     ebp

    ret
