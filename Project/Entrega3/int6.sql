-- Quantos funcionários tem os estabelecimentos do tipo 'loja'

.mode columns
.headers on
.nullvalue NULL

SELECT nome_empresa, count(ID_funcionario) AS num_funcionarios
FROM Funcionario_Interno NATURAL JOIN (
        SELECT nome_empresa, numero_espaco, numero_piso
        FROM Estabelecimento
        WHERE tipo_de_estabelecimento="Loja"
)
GROUP BY nome_empresa;