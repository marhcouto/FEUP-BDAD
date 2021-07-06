-- Funcionários que trabalham na empresa 'NewClean Limpeza' e nunca fizeram um serviço 
-- para um estabelecimento do tipo 'Lazer'

.mode columns
.headers on
.nullvalue NULL

SELECT nome as "Nome funcionário"
FROM Funcionario_Externo NATURAL JOIN (
    SELECT ID_servico, ID_funcionario
    FROM Servico
    EXCEPT
        SELECT ID_servico, ID_funcionario
        FROM Servico NATURAL JOIN Estabelecimento
        WHERE tipo_de_estabelecimento = "Lazer"
    )
WHERE nome_empresa = "NewClean Limpeza";
