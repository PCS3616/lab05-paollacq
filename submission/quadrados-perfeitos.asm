; Cálculo dos Quadrados Perfeitos na MVN
        @ /0000
INICIO  LD N        ; Carrega o número inicial
        MM PROX     ; Armazena o valor inicial em PROX

LOOP    LD I        ; Contador i do somatório
        ML DOIS     ; Multiplica por 2
        AD UM       ; Calcula o próximo ímpar
        AD PROX     ; Soma com o número armazenado
        MM PROX     ; Atualiza o valor para o próximo loop

        LD I        ; Incrementa o contador i
        AD UM       
        MM I

        LD PTR      ; Monta a instrução de armazenamento
        AD OP_MM    
        MM ARMAZENA ; Executa a instrução montada
        LD PROX
ARMAZENA K /0000

        LD PTR      ; Atualiza o endereço onde será armazenado o próximo resultado
        AD DOIS     
        MM PTR

        LD N        ; Incrementa N para controlar a repetição
        AD UM
        MM N

        LD N        ; Verifica se atingiu o limite (64 números)
        SB LIM
        JZ FINALIZA ; Se sim, termina a execução
        JP LOOP     ; Caso contrário, continua

FINALIZA HM =0      ; Finaliza execução

; Variáveis
@ /300
N       K /0000     ; Contador inicial
I       K /0000     ; Contador interno
PROX    K /0000     ; Resultado acumulado
PTR     K /0102     ; Endereço de armazenamento

@ /308 
OP_MM   K /9000     ; Operação MM

; Constantes
@ /200
UM      K /0001     ; Constante 1
DOIS    K /0002     ; Constante 2
LIM     K /0040     ; Limite de cálculos (64 números)

@ /100
INICIO  K /0000     ; Ponto inicial