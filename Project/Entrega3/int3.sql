-- Quais os nomes dos funcionários que prestaram serviços
-- em casas de banho do tipo "Fraldário" e o numero do espaço e piso respetivos, por ordem alfabética do nome?

.mode	columns
.headers	on
.nullvalue	NULL

SELECT nome, numero_espaco, numero_piso
FROM Funcionario_Externo NATURAL JOIN (
    SELECT numero_espaco, numero_piso, ID_funcionario
    FROM Servico) NATURAL JOIN (
        SELECT numero_piso, numero_espaco, tipo_casa_de_banho
        FROM Casa_de_Banho)
WHERE tipo_casa_de_banho = "Fraldário"
ORDER BY nome ASC;