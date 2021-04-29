int_timer:
    pushad
    push    ds
    push    es

    mov     ax, 0x0010
    mov     ds, ax
    mov     es, ax

    inc     dword [TIMER_COUNT]
    outp    0x20, 0x20

    str     ax
    cmp     ax, SS_TASK_0
    je      .11L
    cmp     ax, SS_TASK_1
    je      .12L 
    cmp     ax, SS_TASK_2
    je      .13L
    cmp     ax, SS_TASK_3
    je      .14L
    cmp     ax, SS_TASK_4
    je      .15L
    cmp     ax, SS_TASK_5
    je      .16L

    jmp     SS_TASK_0:0
    jmp     .10E
.11L:
    jmp     SS_TASK_1:0
    jmp     .10E

.12L:
    jmp     SS_TASK_2:0
    jmp     .10E

.13L:
    jmp     SS_TASK_3:0
    jmp     .10E

.14L:
    jmp     SS_TASK_4:0
    jmp     .10E

.15L:
    jmp     SS_TASK_5:0
    jmp     .10E

.16L:
    jmp     SS_TASK_6:0
    jmp     .10E
    
.10E:
    pop     es
    pop     ds
    popad

    iret

ALIGN 4, db 0
TIMER_COUNT:    dd  0