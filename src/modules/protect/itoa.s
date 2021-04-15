itoa:
    push    ebp
    mov     ebp, esp

    push    eax
    push    ebx
    push    ecx
    push    edx
    push    esi
    push    edi

    mov     eax, [ebp + 8]
    mov     esi, [ebp + 12]
    mov     ecx, [ebp + 16]

    mov     edi, esi
    add     edi, ecx
    dec     edi

    mov     ebx, [ebp + 24]

    test    ebx, 0b0001
.10Q:
    je      .10E
    cmp     eax, 0
.12Q:
    jge     .12E
    or      ebx, 0b0010
.12E:
.10E:
    test    ebx, 0b0010
.20Q:
    je      .20E
    cmp     eax, 0
.22Q:
    jge     .22F
    neg     eax
    mov     [esi], byte '-'
    jmp     .22E
.22F:
    mov     [esi], byte '+'
.22E:
    dec     ecx
.20E:
    mov     ebx, [ebp + 20]
.30L:
    mov     edx, 0
    div     ebx

    mov     esi, edx
    mov     dl, byte [.ascii + esi]

    mov     [edi], dl
    dec     edi

    cmp     eax, 0
    loopnz  .30L
.30E:
    cmp     ecx, 0
.40Q:
    je      .40E
    mov     al, ' '
    cmp     [ebp + 24], word 0b0100
.42Q:
    jne     .42E 
    mov     al, '0'
.42E:
    std
    rep     stosb
.40E:
    pop     edi
    pop     esi
    pop     edx
    pop     ecx
    pop     ebx
    pop     eax

    mov     esp, ebp
    pop     ebp

    ret

.ascii  db  "0123456789ABCDEF"
