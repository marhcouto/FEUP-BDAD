-- Quantas pessoas estacionaram no piso -2 durante 
-- o evento mais lucrativo?

.mode columns
.headers on
.nullvalue NULL

SELECT *
FROM Bilhete NATURAL JOIN (
    SELECT nome_evento, data_evento, hora, duracao,
    max(bilhetes_vendidos*preco_bilhetes-preco_realizacao) AS lucro_max
    FROM Evento
)
WHERE data_evento = data AND hora_entrada>=hora AND numero_estacionamento=-2
AND hora_entrada<=hora+duracao/60;
