-- Nome dos eventos que têm saldo positivo, ocorreram há menos de dois anos e aconteceram em todos os Pisos ao mesmo tempo


.mode	columns
.headers	on
.nullvalue	NULL


SELECT nome_evento as "Nome do Evento"
FROM (
    SELECT nome_evento, duracao, data_evento, hora, count(numero_piso) as nPisos
    FROM Evento JOIN Evento_Piso using(nome_evento, data_evento)
    WHERE strftime('%Y', datetime('now')) - strftime('%Y', data_evento) < 2 and bilhetes_vendidos * preco_bilhetes > preco_realizacao 
    GROUP BY nome_evento
) JOIN (SELECT count(numero_piso) as nPisos FROM Piso) using(nPisos);
