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
; -------------------------------------------------------
; Lê dois números x e y (2 dígitos cada, 0<=x,y<=99) 
; em uma única linha no formato: <x-d1><x-d2><space><space><y-d1><y-d2>
; Ex.: "07  54" => Saída: "61"
; -------------------------------------------------------

@ /0000
INICIO  GD /000        ; Lê 2 bytes ASCII p/ x
        SB ASCII       ; Subtrai 0x3030 => BCD
        MM XIN         ; Guarda em XIN

        GD /000        ;  Lê 2 espaços "  " => 0x2020
        MM SPACES      ; descarta, não converte

        GD /000        ;  Lê 2 bytes ASCII p/ y
        SB ASCII
        MM YIN

        LD XIN
        AD YIN
        MM SOMA

        LD SOMA
        SB DEZ         ; AC = (SOMA - 0x000A)
        JN SEM_CARRY   ; se <0 => LSD <10 => não faz carry
        JP COM_CARRY   ; se >=0 => LSD >=10 => faz carry

SEM_CARRY JP CONVERTE

COM_CARRY LD SOMA
          SB DEZ       ; subtrai 0x000A
          AD CEM       ; soma 0x0100 => "vai-um" no BCD
          MM SOMA
          JP CONVERTE

CONVERTE LD SOMA
        AD ASCII
        MM SOMA

        LD SOMA
        PD SAIDA

        HM =0          ; fim do programa


; VARIÁVEIS 
@ /0100
XIN     K /0000    ; valor de X em BCD
SPACES  K /0000    ; 2 espaços lidos
YIN     K /0000    ; valor de Y em BCD
SOMA    K /0000    ; soma de X+Y (BCD 2 bytes)

; CONSTANTES
@ /0110
ASCII   K /3030    ; p/ converter entre ASCII <-> BCD
DEZ     K /000A    ; (decimal 10)
CEM     K /0100    ; carry no dígito alto
SAIDA   K /E100    ; dispositivo de saída redirecionado p/ teste
