-- Empresas associadas a estabelecimentos ordenadas pelo valor que pagam mensalmente por metro quadrado

.mode	columns
.headers	on
.nullvalue	NULL

SELECT nome_empresa,
    CASE 
        WHEN frequencia_pagamento = 'semanal' THEN valor_pagamento * 4.3 / dimensoes
        WHEN frequencia_pagamento = 'mensal' THEN valor_pagamento / dimensoes
        WHEN frequencia_pagamento = 'anual' THEN valor_pagamento / (12 * dimensoes)
        WHEN frequencia_pagamento = 'trimestral' THEN valor_pagamento / (3 * dimensoes)
        WHEN frequencia_pagamento = 'semestral' THEN valor_pagamento / (6 * dimensoes)
    END renda_mensal_pm2
FROM Contrato JOIN Empresa USING(nome_empresa) JOIN Estabelecimento USING(nome_empresa) JOIN Espaco USING(numero_espaco, numero_piso)
ORDER BY renda_mensal_pm2 DESC;