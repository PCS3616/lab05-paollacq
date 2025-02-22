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

;  Lê x e y do teclado (2 digitos cada) e imprime x+y
;  x e y no formato: <x-d1><x-d2><space><space><y-d1><y-d2>
;  Exemplo de input: "07  54" => Saída: "61"

@ /0000
INICIO  GD /000        ; Lê 2 bytes ASCII p/ x
        SB ASCII       ; Subtrai 0x3030 => BCD
        MM XIN

        GD /000        ; Lê 2 espaços (4 nibbles)
        MM SPACES

        GD /000        ; Lê 2 bytes ASCII p/ y
        SB ASCII
        MM YIN

        ; Soma (x + y)
        LD XIN
        AD YIN
        MM SOMA

        ; Se LSD >= 10, faz carry
        LD SOMA
        SB DEZ         ; AC = SOMA - 0x000A
        JN SEM_CARRY   ; se negativo => LSD <10
        JP COM_CARRY

SEM_CARRY JP CONVERTE

COM_CARRY LD SOMA
          SB DEZ       ; subtrai 10
          AD CEM       ; soma 0x0100
          MM SOMA
          JP CONVERTE

CONVERTE  LD SOMA
          AD ASCII     ; soma 0x3030 => volta a ASCII
          MM SOMA

        ; Imprime (esperado "61" se input "07  54")
        LD SOMA
        PD MONITOR

        HM =0         ; fim

;  ÁREA DE DADOS
@ /0100
XIN    K /0000    
SPACES K /0000    
YIN    K /0000    
SOMA   K /0000    

;  CONSTANTES
@ /0110
ASCII  K /3030    ; p/ converter ASCII <-> BCD
DEZ    K /000A    ; 10 decimal
CEM    K /0100    ; carry BCD
MONITOR K /0000   ; Dispositivo de saída
