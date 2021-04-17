test_and_set:
    push    ebp
    mov     ebp, esp

    push    eax
    push    ebx

    mov     eax, 0
    mov     ebx, [ebp + 8]
.10L:
    lock bts [ebx], eax
    jnc     .10E


.12L:
    bt      [ebx], eax
    jc      .12L
    jmp     .10L
.10E:
    pop     ebx
    pop     eax

    mov     esp, ebp
    pop     ebp

    ret