-- Ordene as empresas com maior numero de serviços prestados.

.mode	columns
.headers	on
.nullvalue	NULL

SELECT nome_empresa, COUNT(ID_servico) AS numero_servicos
    FROM Servico NATURAL JOIN (
        SELECT nome_empresa, ID_funcionario
        FROM Funcionario_Externo)
    GROUP BY nome_empresa
    ORDER BY COUNT(ID_servico) DESC;