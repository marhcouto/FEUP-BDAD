-- Nome da empresa de serviços cuja média de avaliação dos espaços onde ditos serviços foram feitos é a melhor de entre 
-- tods os prestadores de serviços, e respetiva média

.mode	columns
.headers	on
.nullvalue	NULL

DROP VIEW IF EXISTS EmpresasFives;
CREATE VIEW EmpresasFives as 
SELECT *, avg(avaliacao) as avgFives
FROM Servico JOIN Funcionario_Externo using (ID_funcionario) JOIN Espaco using (numero_espaco, numero_piso) 
JOIN Fiscalizacao using(numero_espaco, numero_piso)
GROUP BY nome_empresa;

SELECT nome_empresa, avgFives
FROM EmpresasFives e1
WHERE NOT EXISTS (SELECT * FROM EmpresasFives e2 WHERE e2.avgFives > e1.avgFives);





