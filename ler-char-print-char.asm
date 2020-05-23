;----------------------------------------------------------------------
;Programa feito por Gabriel Aquino - gabriel@labnet.nce.ufrj.br
;ler-char-print.asm - programa de unico segmento de 16-bit que objetiva ler e 
;;printar o mesmo char que foi dado como input 
;
;Compile o asm fazendo "c:\> nasm -f bin -o lerprint.com ler-char-print.asm"
;---------------------------------------------------------------------


;diretiva de montagem para definir localizaçao absoluta do programa
    org  0x100        

; Abaixo o codigo usando a int 21h para chamar a interrupcao do DOS...

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

;entao eu jogo o caracter de al em dl
    mov dl, cl          ;move o char de al para dl
    mov ah, 02          ;ah=02 - subfuncao de escrita de caracter na entrada padrao
    int 0x21            ;Chama a interrupcao do DOS

;termina o programa
    mov  ah, 0x4c       ; subfuncao de terminar o programa 
    mov  al,0           ; codigo de retorno 
    int  0x21           ; Chama interrupcao do dos
