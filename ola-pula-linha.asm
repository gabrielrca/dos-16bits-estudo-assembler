;----------------------------------------------------------------------
;Programa feito por Gabriel Aquino - gabriel@labnet.nce.ufrj.br
;ola-pula-linha.asm - programa de unico segmento de 16-bit estilo "hello world"
;;com  entrada no teclado para continuar o programa 
;
;O objetivo desse programa é exemplificar a saída de dados através 
;;da interrupçao 0x21
;
;Compile o asm fazendo "c:\> nasm -f bin -o ola.com ola.asm"
;---------------------------------------------------------------------

;diretiva de montagem para definir localizaçao absoluta do programa
    org  0x100        

; Abaixo o codigo usando a int 21h para chamar a interrupcao do DOS...

;escreve mensagem 
    mov  dx, msggab     ; endereco da mensagem "msggab" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS
;escreve mensagem 
    mov  dx, msginfo    ; endereco da outra mensagem "msginfo" no reg. dx
    int  0x21           ; Chama a interrupcao do DOS (ja esta setado ah=9 anteriormente)
;espera entrada no teclado 
    mov ah, 01          ;ah=01 - subfuncao de leitura da entrada padrao sem eco
    int 0x21            ;Chama a interrupcao do DOS
;escreve mensagem
    mov  dx, msgtdbem   ; endereco da mensagem "msgtdbem" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS
;termina o programa
    mov  ah, 0x4c       ; subfuncao de terminar o programa 
    mov  al,0           ; codigo de retorno 
    int  0x21           ; Chama interrupcao do dos

;abaixo as mensagens com as suas marcacoes
    msggab  db 'Ola, Gabriel.', 0x0d, 0x0a, '$'   ; $-terminated message
    msginfo  db '<aperte uma tecla para continuar...>', 0x0d, 0x0a, '$'   ; $-terminated message
    msgtdbem  db 'Tudo bem?', 0x0d, 0x0a, '$'   ; $-terminated message