--PRIMEIRA QUERIE
SELECT 
    d.id_disciplina AS codigo_disciplina, 
    d.nome_disciplina, 
    dh.semestre, 
    dh.ano, 
    dh.nota_final
FROM 
    disciplina_historico dh
JOIN 
    disciplina d ON dh.id_disciplina = d.id_disciplina
WHERE 
    dh.id_aluno = 146448; --TROCAR O ID PARA UM QUE FOI GERADO (aluno) ESTE QUE ESTÁ É SOMENTE UM EXEMPLO

------------------------------------------------------------------------------------------------------------------

--SEGUNDA QUERIE (Historico de disciplinas ministrada pelo professor de id X)
SELECT 
    d.id_disciplina AS codigo_disciplina, 
    d.nome_disciplina, 
    hp.semestre, 
    hp.ano
FROM 
    historico_professor hp
JOIN 
    disciplina d ON hp.id_disciplina = d.id_disciplina
WHERE 
    hp.id_professor = 1; --VARIAVEL PARA TROCAR O ID DO PROFESSOR DA QUERIE

------------------------------------------------------------------------------------------------------------------

--TERCEIRA QUERIE (ALUNOS QUE SE FORMARAM EM UM DETERMINADO ANO E SEMESTRE)
SELECT 
    a.id_aluno, 
    a.nome_aluno
FROM 
    aluno a
WHERE 
    NOT EXISTS (
        SELECT 
            1
        FROM 
            matriz_curricular mc
        JOIN 
            disciplina_historico dh ON mc.id_disciplina = dh.id_disciplina
        WHERE 
            dh.id_aluno = a.id_aluno
            AND dh.nota_final < 5.0
            AND dh.ano = 2022 -- DEFINIR ANO DESEJADO
            AND dh.semestre = 2 --DEFINIR SEMESTRE DESEJADO ENTRE 1 E 2
    )
AND 
    EXISTS (
        SELECT 
            1
        FROM 
            disciplina_historico dh2
        WHERE 
            dh2.id_aluno = a.id_aluno
            AND dh2.ano = 2022 -- DEFINIR ANO DESEJADO
            AND dh2.semestre = 2 --DEFINIR SEMESTRE DESEJADO ENTRE 1 E 2
    );

------------------------------------------------------------------------------------------------------------------

--QUARTA QUERIE (PROFESSORES CHEFES DE DEPARTAMENTO)
SELECT 
    p.id_professor, 
    p.nome_professor, 
    d.nome_departamento
FROM 
    professor p
JOIN 
    departamento d ON p.id_professor = d.id_chefe;

------------------------------------------------------------------------------------------------------------------

--QUINTA QUERIE (GRUPOS DE TCC)
SELECT 
    tg.id_grupo, 
    p.id_professor AS id_orientador, 
    p.nome_professor AS nome_orientador, 
    a.id_aluno, 
    a.nome_aluno
FROM 
    tcc_grupo tg
JOIN 
    professor p ON tg.id_orientador = p.id_professor
JOIN 
    tcc_membro tm ON tg.id_grupo = tm.id_grupo
JOIN 
    aluno a ON tm.id_aluno = a.id_aluno
ORDER BY 
    tg.id_grupo, a.id_aluno;