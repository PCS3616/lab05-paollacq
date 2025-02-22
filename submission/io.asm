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

;  Lê x e y do teclado (0 <= x,y <= 99) em uma única linha
;  Formato: <x-d1><x-d2><space><space><y-d1><y-d2>
;  Exemplo: "07  54" => imprime "61"

@ /0000
INICIO  GD /000        ; Lê ASCII (2 bytes) de x
        SB ASCII
        MM XIN

        GD /000        ; Lê e descarta 2 espaços
        MM SPACES

        GD /000        ; Lê ASCII (2 bytes) de y
        SB ASCII
        MM YIN

        ; Soma x + y
        LD XIN
        AD YIN
        MM SOMA

        ; Verifica LSD >= 10
        LD SOMA
        SB DEZ         ; AC = SOMA - 0x000A
        JN SEM_CARRY   ; se <0 => LSD <10 => sem carry
        JP COM_CARRY

SEM_CARRY JP CONVERTE

COM_CARRY LD SOMA
          SB DEZ       ; subtrai 0x000A
          AD CEM       ; soma 0x0100 => "vai-um"
          MM SOMA
          JP CONVERTE

CONVERTE  LD SOMA
          AD ASCII     ; soma 0x3030 -> volta ASCII
          MM SOMA

        ; Imprime no "dispositivo E100"
        LD SOMA
        PD SAIDA

        HM =0

; DADOS
@ /0100
XIN    K /0000    
SPACES K /0000    
YIN    K /0000    
SOMA   K /0000    

; CONSTANTES
@ /0110
ASCII  K /3030    
DEZ    K /000A    
CEM    K /0100    

; Use /E100 para que o teste redirecione ao arquivo
SAIDA  K /E100
