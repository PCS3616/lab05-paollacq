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

;  LÊ x e y do teclado (0 <= x,y <= 99)
;  Formato de entrada:  <x-d1><x-d2><space><space><y-d1><y-d2>

@ /0000
INICIO  GD /000       ; Lê 4 nibbles => 2 bytes de ASCII
        SB ASCII      ; Subtrai 0x3030 -> converte p/ BCD
        MM XIN        ; Armazena em XIN

        ; Ler e descartar 2 espaços
        GD /000
        MM SPACES

        ; 3Ler y (2 dígitos)
        GD /000       
        SB ASCII
        MM YIN

        ; Soma x + y
        LD XIN
        AD YIN
        MM SOMA

        ;Verificar se LSD >= 0x000A
        LD SOMA
        SB DEZ       ; AC = SOMA - 0x000A
        JN NO_CARRY  ; se AC < 0 => LSD < 10 => sem carry
        JP YES_CARRY ; se AC >= 0 => LSD >= 10 => faz "vai-um"

NO_CARRY JP CONVERTE

YES_CARRY LD SOMA
        SB DEZ       ; subtrai 0x000A do LSD
        AD CEM       ; soma 0x0100 (vai-um)
        MM SOMA
        JP CONVERTE

CONVERTE LD SOMA
        AD ASCII
        MM SOMA

        ; Imprime no monitor
        LD SOMA
        PD MONITOR

        HM =0       ; fim do programa


;  ÁREA DE DADOS
@ /100
XIN    K /0000    ; armazena x em BCD 
SPACES K /0000    ; para descartar 2 espaços
YIN    K /0000    ; armazena y em BCD
SOMA   K /0000    ; armazena x+y (2 bytes BCD)

;  CONSTANTES
@ /110
ASCII  K /3030    ; 0x3030 => subtrai e depois soma
DEZ    K /000A    ; 0x000A => decimal 10
CEM    K /0100    ; 0x0100 => soma para "vai-um" em BCD
MONITOR K /0000   ; dispositivo de saída (monitor)
