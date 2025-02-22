;⠀⠀⠀⠀⠀⠀⠀⠀⢀⣤⣤⣶⠶⠶⣶⣤⣤⡀⠀⠀⠀⠀⠀⠀
;⠀⠀⠀⠀⠀⢀⣴⠾⠛⠉⠀⢠⣾⣴⡾⠛⠻⣷⣄⠀⠀⠀⠀⠀
;⠀⠀⢶⣶⣶⣿⣁⠀⠀⠀⠀⢸⣿⠏⢀⣤⣶⣌⠻⣦⡀⠀⠀⠀
;⠀⠀⣴⡟⠁⢉⣙⣿⣦⡀⠀⢸⡏⣴⠟⢡⣶⣿⣧⡹⣷⡀⠀⠀
;⠀⣼⠏⢀⣾⠟⠛⠛⠻⣿⡆⠀⠀⢿⣄⠀⠙⠉⠹⣷⡸⣷⠀⠀
;⢠⣿⠀⢸⡿⢿⠇⠀⠀⣾⠇⠀⣀⣈⠻⢷⣤⣤⣤⡾⠃⢹⣇⠀
;⢸⣿⠀⢸⣧⣀⣀⣠⣾⢋⣴⢿⣿⡛⠻⣶⣤⣉⠁⠀⠀⠀⣿⠀
;⠈⣿⠀⠀⠙⠛⠛⠋⠁⣼⣯⣀⣿⠿⠶⠟⠉⠛⢷⣄⠀⠀⣿⡇
;⠀⣿⠀⠀⠀⠀⠀⠀⠀⣿⡏⠉⠁⠀⠀⢀⣴⢶⣄  ⢻⡇  ⢸⡇
;⠀⢻⣇⠀⠀⠀⠀⠀⢠⡿⢀⣀⢠⣾⠷⣾⣧⡶⠿⠟⠁⠀⣾⡇
;⠀⠈⣿⣧⡀⠀⠀⣠⣿⣷⠟⢻⣿⣷⡾⠛⠉⠀⠀⠀⠀⢀⣿⠀
;⠀⠀⢹⣿⢻⣦⡀⠉⠛⠛⠛⠛⠋⠁⠀⠀⠀⠀⠀⠀⠀⣼⠏⠀
;⠀⠀⠀⠛⠀⠈⠻⠷⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠸⠟⠀⠀

;  PROGRAMA PRINCIPAL
        LD VALOR       ; Carrega o número cujo fatorial será calculado
        MM VALOR       ; Armazena de volta (padrão, opcional)
        SC SUBFAT      ; Chama a sub-rotina
        LD ACUMULA     ; Ao retornar, carrega o resultado parcial
        MM RESULTDONE  ; Armazena o resultado final
        HM =0          ; Finaliza

;  SUB-ROTINA FATORIAL
@ /0123
SUBFAT  K /0000       ; Apenas uma palavra para alinhar; 
                      ; Mantém compatibilidade com o código gerado

        LD VALOR
        JZ EXIT       ; Se VALOR=0, fatorial=1 (ACUMULA já é 1), sai

LOOP    MM TEMP       ; TEMP <- AC (valor que estamos usando)
        ML ACUMULA    ; AC = AC * ACUMULA
        MM ACUMULA    ; ACUMULA <- (AC)

        LD TEMP       ; Restaura TEMP no AC
        SB ONE        ; Decrementa AC => (TEMP - 1)
        MM TEMP
        JZ EXIT       ; Se chegou a 0, acabou
        JP LOOP       ; Senão, repete

EXIT    RS SUBFAT     ; Retorna ao programa principal

;  ÁREA DE DADOS
@ /100
VALOR       K /0005   ; Valor inicial de N (ex.: 3 => 3! = 6)
@ /108
ACUMULA     K /0001   ; Acumulador de produto, inicia em 1
@ /106
TEMP        K /0001   ; Variável temporária (contador interno)
@ /104
ONE         K /0001   ; Constante 1
@ /102
RESULTDONE  K /0000   ; Onde armazenaremos o resultado final
