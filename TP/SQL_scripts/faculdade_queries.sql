-- 1. Quais os números dos alunos?
-- SELECT nr 
-- FROM aluno;


-- 2. Qual o código e designação das cadeiras do curso 'AC'?
-- SELECT cod
-- FROM cadeira
-- WHERE curso = 'AC'

-- 3. Existem nomes comuns a alunos e profs? Quais?
-- SELECT nome FROM aluno
-- INTERSECT
-- SELECT nome FROM prof

-- 4. Quais os nomes específicos dos alunos, i.e., que nenhum professor tem?
-- SELECT nome FROM aluno
-- EXCEPT
-- SELECT nome FROM prof
 

-- 5. Quais os nomes das pessoas relacionadas com a faculdade?
-- SELECT nome
-- FROM aluno
-- UNION
-- SELECT nome FROM prof

-- 6. Quais os nomes dos alunos que fizeram alguma prova de 'ts1'?
-- SELECT nome
-- FROM aluno
-- WHERE nr in (SELECT nr 
-- FROM prova
-- WHERE cod = 'TS1')

-- 7. Quais os nomes dos alunos com inscrição no curso 'IS'?
-- SELECT nome 
-- FROM Aluno NATURAL JOIN (
--     SELECT DISTINCT nr
--     FROM PROVA NATURAL JOIN Cadeira 
--     WHERE curso = 'IS'
-- );


-- 8. Qual a relação dos nomes dos alunos que concluíram o curso 'IS'.
-- SELECT curso, nome
-- FROM (
--     (SELECT nome, curso, count(cod) as nCod
--     FROM (
--         SELECT DISTINCT nome, curso, cod
--         FROM prova NATURAL JOIN aluno NATURAL JOIN cadeira
--         WHERE nota >= 10
--     )
--     GROUP BY nome, curso)
--     NATURAL JOIN (
--         SELECT curso, count(cod) as nCadeiras
--         FROM cadeira
--         GROUP BY curso
--     )
-- )
-- WHERE nCod = nCadeiras AND curso = 'IS'
-- ORDER BY curso;

-- 9. Qual a nota máxima existente nas provas?
-- SELECT max(nota) FROM prova;

-- 10. Qual a nota média nas provas de BD?
-- SELECT AVG(nota)
-- FROM Prova
-- WHERE cod = 'BD';

-- 11. Qual o número de alunos?
-- SELECT count(nr) FROM aluno;

-- 12. Qual o número de cadeiras de cada curso?
-- SELECT curso, count(cod)
-- FROM cadeira
-- GROUP BY curso;

-- 13. Qual o número de provas de cada aluno?
-- SELECT nr, count(cod)
-- FROM prova
-- GROUP BY nr;

-- 14. Qual a média do número de provas por aluno?
-- SELECT avg(np) 
-- FROM (SELECT nr, count(cod) as np
-- FROM prova
-- GROUP BY nr);


-- 15. Qual o nome e respetiva média atual (cadeiras feitas, em qualquer curso) de cada aluno?
-- SELECT nome, media FROM aluno
-- NATURAL JOIN (
-- SELECT nr, avg(notamax) as media
-- FROM (
--     SELECT nr, cod, max(nota) notamax
-- FROM prova
-- GROUP BY nr,cod
-- )
-- GROUP BY nr);

-- 16. Qual a nota máxima de cada cadeira e qual o aluno que a obteve?
-- SELECT nome, notamax
-- FROM aluno
-- NATURAL JOIN(
-- SELECT nr, max(nota) as notamax
-- FROM prova
-- GROUP BY cod);

-- 17. Obtenha a relação ordenada por curso dos nomes dos alunos formados.
-- SELECT curso, nome
-- FROM (
--     (SELECT nome, curso, count(cod) as nCod
--     FROM (
--         SELECT DISTINCT nome, curso, cod
--         FROM prova NATURAL JOIN aluno NATURAL JOIN cadeira
--         WHERE nota >= 10
--     )
--     GROUP BY nome, curso)
--     NATURAL JOIN (
--         SELECT curso, count(cod) as nCadeiras
--         FROM cadeira
--         GROUP BY curso
--     )
-- )
-- WHERE nCod = nCadeiras
-- ORDER BY curso;







