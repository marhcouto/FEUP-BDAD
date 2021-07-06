-- Qual é a dimensão média dos espaços ocupados por estabelecimentos 
-- e, separadamente, por casas de banho?

.mode	columns
.headers	on
.nullvalue	NULL

SELECT * 
FROM (
    SELECT avg(dimensoes) as "Dimensões Estabelecimentos"
    FROM Espaco NATURAL JOIN Estabelecimento
    ) JOIN (
        SELECT avg(dimensoes) as "Dimensões Casas de Banho"
        FROM Espaco NATURAL JOIN Casa_de_Banho
);