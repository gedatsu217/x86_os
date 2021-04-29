acpi_find:
    push    ebp
    mov     ebp, esp

    push    ebx
    push    ecx
    push    edi

    mov     edi, [ebp + 8]
    mov     ecx, [ebp + 12]
    mov     eax, [ebp + 16]

    cld
.10L:
    repne   scasb

    cmp     ecx, 0
    jnz     .11E
    mov     eax, 0
    jmp     .10E
.11E:
    cmp     eax, [es:edi - 1]
    jne     .10L

    dec     edi
    mov     eax, edi
.10E:
    pop     edi
    pop     ecx
    pop     ebx

    mov     esp, ebp
    pop     ebp

    ret