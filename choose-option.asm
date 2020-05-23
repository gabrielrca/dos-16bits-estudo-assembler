;----------------------------------------------------------------------
;Programa feito por Gabriel Aquino - gabriel@labnet.nce.ufrj.br
;choose-option.asm - programa de unico segmento de 16-bit que objetiva ler e 
;;comparar um char através de um "if" implementado em assembler 
;
;Compile o asm fazendo "c:\> nasm -f bin -o choose-option.com choose-option.asm"
;---------------------------------------------------------------------


;diretiva de montagem para definir localizaçao absoluta do programa
    org  0x100        

; Abaixo o codigo usando a int 21h para chamar a interrupcao do DOS...


;escreve mensagem de opcao
    mov  dx, msginfo    ; endereco da mensagem "msggab" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS

;espera entrada no teclado 
    mov ah, 01          ;ah=01 - subfuncao de leitura de caracter da entrada padrao sem eco
    int 0x21            ;Chama a interrupcao do DOS
    mov cl,al           ;O caracter lido fica guardado no registrador al e jogo pro cl

;como o al eh par do ah (ah:al) as instrucoes abaixo mexem tambem no al
;por isso eu guardo o que ta no al em cl

;pula linha
    mov dl, 0x0D        ;move o char 0x0D (\n ou 'pula linha') para dl
    mov ah, 02          ;ah=02 - subfuncao de escrita de caracter na entrada padrao
    int 0x21            ;Chama a interrupcao do DOS

;pula linha
    mov dl, 0x0A        ;move o char 0x0A (\r ou 'return' ou 'enter') para dl
    mov ah, 02          ;ah=02 - subfuncao de escrita de caracter na entrada padrao
    int 0x21            ;Chama a interrupcao do DOS

;compara pra ver se é S (equivale ao "if(value==s):" )
    cmp cl, 0x53        ;0x53 eh o ascii do char 'S'
    je PRESSY
    cmp cl, 0x73        ;0x73 eh o ascii do char 's'
    je PRESSY

;compara pra ver se é N (equivale ao "if(value==n):" )
    cmp cl, 0x4E        ;0x4E eh o ascii do char 'N'
    je PRESSN
    cmp cl, 0x6E        ;0x6E eh o ascii do char 'n'
    je PRESSN

;mensagem default caso nao tenha apertado nem S nem N
    ;escreve mensagem 
    mov  dx, msgdft     ; endereco da mensagem "msggab" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS

;termina o programa
    mov  ah, 0x4c       ; subfuncao de terminar o programa 
    mov  al,0           ; codigo de retorno 
    int  0x21           ; Chama interrupcao do dos


PRESSY:
    ;escreve mensagem 
    mov  dx, msgsim     ; endereco da mensagem "msggab" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS

;termina o programa
    mov  ah, 0x4c       ; subfuncao de terminar o programa 
    mov  al,0           ; codigo de retorno 
    int  0x21           ; Chama interrupcao do dos

PRESSN:
    ;escreve mensagem 
    mov  dx, msgnao     ; endereco da mensagem "msggab" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS

;termina o programa
    mov  ah, 0x4c       ; subfuncao de terminar o programa 
    mov  al,0           ; codigo de retorno 
    int  0x21           ; Chama interrupcao do dos

;abaixo as mensagens com as suas marcacoes
    msginfo  db 'Deseja continuar? (S/N)', 0x0d, 0x0a, '$'   ; $-terminated message
    msgsim  db 'Voce apertou SIM', 0x0d, 0x0a, '$'   ; $-terminated message
    msgnao  db 'Voce apertou NAO', 0x0d, 0x0a, '$'   ; $-terminated message
    msgdft  db 'Nao escolheu opcao valida. Fim.', 0x0d, 0x0a, '$'   ; $-terminated message