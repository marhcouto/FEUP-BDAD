-- Qual o número de fiscalizações, para cada espaço, com avaliação >=3?

.mode	columns
.headers	on
.nullvalue	NULL

SELECT numero_piso, numero_espaco, COUNT(avaliacao) AS num_boas_avaliacoes
FROM Fiscalizacao
WHERE avaliacao >=3
GROUP BY numero_piso, numero_espaco;