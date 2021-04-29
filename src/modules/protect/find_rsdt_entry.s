find_rsdt_entry:
    push    ebp
    mov     ebp, esp

    push    ebx
    push    ecx
    push    esi
    push    edi

    mov     esi, [ebp + 8]
    mov     ecx, [ebp + 12]

    mov     ebx, 0

    mov     edi, esi
    add     edi, [esi + 4]
    add     esi, 36

.10L:
    cmp     esi, edi
    jge     .10E
    
    lodsd

    cmp     [eax], ecx
    jne     .12E
    mov     ebx, eax
    jmp     .10E
.12E:
    jmp     .10L
.10E:
    mov     eax, ebx

    pop     edi
    pop     esi
    pop     ecx
    pop     ebx

    mov     esp, ebp
    pop     ebp

    ret
