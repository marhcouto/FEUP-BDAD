# **Relational Algebra**
## Relax: Relational Algebra Calculator

    1. π nr Aluno
    2. πcod, design (σcurso = 'AC' Cadeira)
    3. πNome Aluno ∩ πNome Prof
    4. πNome Aluno - πNome Prof
    5. πNome Aluno ∪ πNome Prof
    6. πAluno.Nome σProva.cod = 'TS1' (Aluno ⨝ Prova)
    7. π Aluno.Nome σ Cadeira.curso = 'IS' (Aluno ⨝ Prova ⨝ Cadeira)
    8. ProvasIS = (Prova ⋉ σcurso = 'IS' Cadeira) | AlunosIS = σProva.nota ≥ 10 (ProvasIS ⨝ Aluno) | (πAluno.Nome, Prova.cod (AlunosIS)) ÷ (πProva.cod ProvasIS)
    9. γ max(nota)→max_nota Prova
    10. ProvasBD = (σcod = 'BD' (Prova)) | γ avg(nota)→avgNota ProvasBD
    11. γ count(nr)->noAlunos Aluno
    12. γ curso; count(cod)->noCadeiras Cadeira
    13. γ nr; count(cod)->noProvas Prova
    14. ProvasPAluno = γ nr; count(cod)->noProvas Prova | γ avg(noProvas ->mediaNoProvas ProvasPAluno
    15. NotasPos = σ nota ≥ 10 (Aluno ⨝ Prova) | NotasFinais = γ Aluno.Nome, Prova.cod; max(nota)->notaMax NotasPos | γ Aluno.Nome; avg(notaMax)->media NotasFinais
    16. NotaMaxCadeira = γ cod; max(nota)->notaMax Prova | AlunoProva = (Aluno ⨝ Prova) | MelhorAluno = AlunoProva ⨝ (ρ nota←notaMax (NotaMaxCadeira)) | π Aluno.Nome, Prova.cod, Prova.nota MelhorAluno
    17. AlunosNotasPos = Aluno ⨝ (σnota≥10 Prova) | AlunoBestNota = γ Aluno.Nome, Prova.cod; max(nota)->bestNota AlunosNotasPos | AlunoCadeirasCurso = γ Cadeira.curso, Aluno.Nome; count(cod)->noCadeirasFeitas (AlunoBestNota ⨝ Cadeira) | CadeirasCurso = γ curso; count(cod)->noCadeiras Cadeira |AlunosAprovados = σ noCadeirasFeitas = noCadeiras (CadeirasCurso ⨝ AlunoCadeirasCurso) | π Aluno.Nome, Cadeira.curso (τ Cadeira.curso AlunosAprovados)

