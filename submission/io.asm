; io.asm - Soma de dois números (0 <= x,y <= 99)
; Entrada: <x-d1><x-d2><space><space><y-d1><y-d2>
; Exemplo: "07  54" → saída: "61"

@ /0000
START   GD /000         ; Lê 2 bytes ASCII para o primeiro número
        SB BASE         ; Converte: (valor ASCII) - 0x3030  → BCD
        MM FIRST        ; Armazena em FIRST

        GD /000         ; Lê 2 bytes (espaços); descarta
        MM BLANKS

        GD /000         ; Lê 2 bytes ASCII para o segundo número
        SB BASE
        MM SECOND       ; Armazena em SECOND

        ; Soma os dois números (em BCD)
        LD FIRST
        AD SECOND
        MM SUMOUT

        ; Verifica se o dígito menos significativo é >= 10
        LD SUMOUT
        SB TEN          ; AC = SUMOUT - 0x000A
        JN NO_ADD       ; Se negativo, LSD < 10 → sem ajuste
        JP DO_ADD       ; Se >= 0, LSD >= 10 → faz "vai-um"

NO_ADD  JP CONVERT

DO_ADD  LD SUMOUT
        SB TEN        ; Subtrai 0x000A do LSD
        AD ADD100     ; Adiciona 0x0100 (carry)
        MM SUMOUT
        JP CONVERT

CONVERT LD SUMOUT
        AD BASE       ; Converte de volta para ASCII: +0x3030
        MM SUMOUT

        ; Imprime o resultado no dispositivo de saída /E100
        LD SUMOUT
        PD OUTDEV

        HM =0      ; Fim do programa

; Área de Dados
@ /0100
FIRST   K /0000    ; Primeiro número em BCD
BLANKS  K /0000    ; Espaços (descartados)
SECOND  K /0000    ; Segundo número em BCD
SUMOUT  K /0000    ; Soma de FIRST + SECOND (BCD)

; Constantes
@ /0110
BASE    K /3030    ; 0x3030 (para converter entre ASCII e BCD)
TEN     K /000A    ; 0x000A (10 decimal)
ADD100  K /0100    ; 0x0100 (para "vai-um" no BCD)
OUTDEV  K /E100    ; Dispositivo de saída (o teste substituirá E100 por e300)
