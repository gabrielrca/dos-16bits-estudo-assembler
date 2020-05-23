;----------------------------------------------------------------------
;Programa feito por Gabriel Aquino - gabriel@labnet.nce.ufrj.br
;ola.asm - programa de unico segmento de 16-bit estilo "hello world" 
;
;O objetivo desse programa é exemplificar a saída de dados através 
;;da interrupçao 0x21
;
;Compile o asm fazendo "c:\> nasm -f bin -o ola.com ola.asm"
;---------------------------------------------------------------------

;diretiva de montagem para definir localizaçao absoluta do programa
    org  0x100        

; Abaixo o codigu usando a int 21h para chamar a interrupcao do DOS...

    mov  dx, msggab    ; endereco da mensagem "msg-gab" no reg. dx
    mov  ah, 9          ; ah=9 - subfuncao de printar string do DOS
    int  0x21           ; Chama a interrupcao do DOS

    mov  ah, 0x4c       ; subfuncao de terminar o programa 
    mov  al,0           ; codigo de retorno 
    int  0x21           ; Chama interrupcao do dos

;abaixo a mensagem, com a marcação "msg"
;caracteres: 0x0A eh o \n e 0x0D eh \r (return ou enter).
;a interrupcao ah=09 termina a string com o char '$'
    msggab  db 'Ola, Gabriel. Tudo bem?', 0x0d, 0x0a, '$'   ; $-terminated message