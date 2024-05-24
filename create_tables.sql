CREATE TABLE departamento (
    id_departamento INT PRIMARY KEY,
    nome_departamento VARCHAR(100) NOT NULL
);

CREATE TABLE professor (
    id_professor BIGINT PRIMARY KEY,
    nome_professor VARCHAR(100) NOT NULL,
    email_professor VARCHAR(100) NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

ALTER TABLE departamento
ADD COLUMN id_chefe BIGINT,
ADD FOREIGN KEY (id_chefe) REFERENCES professor(id_professor);

CREATE TABLE curso (
    id_curso INT PRIMARY KEY,
    nome_curso VARCHAR(100) NOT NULL,
    id_departamento INT,
    FOREIGN KEY (id_departamento) REFERENCES departamento(id_departamento)
);

CREATE TABLE disciplina (
    id_disciplina INT PRIMARY KEY,
    nome_disciplina VARCHAR(100) NOT NULL,
    id_curso INT,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso)
);

CREATE TABLE matriz_curricular (
    id_matriz INT PRIMARY KEY,
    id_curso INT,
    id_disciplina INT,
    FOREIGN KEY (id_curso) REFERENCES curso(id_curso),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE aluno (
    id_aluno BIGINT PRIMARY KEY,
    nome_aluno VARCHAR(100) NOT NULL,
    ano_inicio INT NOT NULL,
    email_aluno VARCHAR(100) NOT NULL
);

CREATE TABLE disciplina_historico (
    id_historico INT PRIMARY KEY,
    id_aluno BIGINT,
    id_disciplina INT,
    ano INT,
    semestre INT,
    nota_final FLOAT,
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE historico_professor (
    id_historico INT PRIMARY KEY,
    id_professor BIGINT,
    id_disciplina INT,
    ano INT,
    semestre INT,
    FOREIGN KEY (id_professor) REFERENCES professor(id_professor),
    FOREIGN KEY (id_disciplina) REFERENCES disciplina(id_disciplina)
);

CREATE TABLE tcc_grupo (
    id_grupo INT PRIMARY KEY,
    descricao_grupo VARCHAR(100) NOT NULL,
    id_orientador BIGINT,
    FOREIGN KEY (id_orientador) REFERENCES professor(id_professor)
);

CREATE TABLE tcc_membro (
    id_grupo INT,
    id_aluno BIGINT,
    PRIMARY KEY (id_grupo, id_aluno),
    FOREIGN KEY (id_grupo) REFERENCES tcc_grupo(id_grupo),
    FOREIGN KEY (id_aluno) REFERENCES aluno(id_aluno)
);
