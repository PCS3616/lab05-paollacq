; Cálculo do Fatorial na MVN (Padrão Atualizado)
        @ /0000
        LD N        ; Carrega o número o qual será calculado o fatorial
        MM N        ; Guarda o valor inicial do N em RES
        SC FAT      ; Chamada da sub-rotina
        LD RES
        MM RESFINAL ; Armazena o resultado final
        HM =0       ; Finaliza execução

@ /200
FAT     K /0000
        LD N
        JZ FIM      ; Trata em especial o caso do fatorial de zero
LOOP    MM PROV
        ML RES      ; Multiplica pelo próximo valor na sequência do fatorial
        MM RES
        LD PROV
        SB UM
        MM PROV
        JZ FIM      ; Pula para o fim
        JP LOOP     ; Volta para o loop
FIM     RS FAT      ; Retorna da sub-rotina

; Rótulos
@ /100
N       K /0000     ; Valor inicial de N

@ /020
RES     K /0001     ; Reserva uma posição da memória para armazenar o resultado final

@ /024
PROV    K /0001     ; Resultado provisório

@ /022
UM      K /0001     ; Constante 1

@ /102
RESFINAL K /0001    ; Armazena o resultado final
