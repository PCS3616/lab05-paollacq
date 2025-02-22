@ /0000
INICIO   GD /000          ; Lê 2 bytes ASCII para o primeiro dígito de x
         MM PRIMEIRO      ; Armazena em PRIMEIRO
         SB CONVERSAO     ; Converte: (valor ASCII) - 0x3030
         MM PRIMEIRO      ; Guarda o valor convertido

         GD /000          ; Lê 2 bytes (espaços) – serão descartados
         MM ESPACOS

         GD /000          ; Lê 2 bytes ASCII para o primeiro dígito de y
         MM SEGUNDO       ; Armazena em SEGUNDO
         SB CONVERSAO     ; Converte para BCD
         MM SEGUNDO       ; Guarda o valor convertido

         ; Soma os dois dígitos (em BCD)
         LD PRIMEIRO
         AD SEGUNDO
         MM RESULTADO

         ; Chama a sub-rotina para ajustar se o dígito menos significativo for >= 10
         SC AJUSTE

         ; Converte o resultado de volta para ASCII e imprime
         LD RESULTADO
         AD CONVERSAO     ; Soma 0x3030 para converter de volta para ASCII
         MM RESULTADO
         PD SAIDA

         HM =0          ; Finaliza o programa

@ /200
AJUSTE   LD RESULTADO
         ; Sub-rotina: ajusta "vai-um" se RESULTADO tiver LSD >= 10
         ML DESLOCAMENTO   ; Multiplica por 0x0100
         DV DESLOCAMENTO   ; Divide por 0x0100 (não altera RESULTADO)
         SB LIMIAR         ; Subtrai o limiar (0x000A)
         JN PULA           ; Se negativo, não há ajuste
         LD RESULTADO
         SB LIMIAR         ; Subtrai 10
         AD DESLOCAMENTO   ; Soma 0x0100 (carry)
         MM RESULTADO      ; Armazena o resultado ajustado
PULA    RS AJUSTE         ; Retorna da sub-rotina

@ /100
PRIMEIRO    K /0       ; Primeiro dígito (BCD)
SEGUNDO     K /0       ; Segundo dígito (BCD)
RESULTADO   K /0       ; Soma (BCD)
ESPACOS     K /0       ; Espaços (descartados)

@ /110
CONVERSAO   K /3030    ; Valor para conversão ASCII <-> BCD (0x3030)
LIMIAR      K /000A    ; Limiar: 10 (0x000A)
DESLOCAMENTO K /0100    ; Valor para "deslocamento" (0x0100)
SAIDA       K /E100    ; Dispositivo de saída (o teste substitui E100 por e300)
