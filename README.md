Criação do Banco de Dados: No PostgreSQL, crie um banco com o nome desejado.

Execução do Script SQL: Execute o script create_tables.sql no banco de dados criado. Este script criará todas as tabelas necessárias para o funcionamento do banco de dados.

População das Tabelas: Execute o arquivo Python populate_tables.py para popular as tabelas com dados fictícios. Certifique-se de ter a biblioteca Faker instalada e trocar as informações do script para atender as autenticações do banco.<br>
<br>Alunos:<br>
Caio de Souza Conceição - RA: 22.122.033-8 <br>
Pedro Henrique Algodoal - RA: 22.122.072-6<br>
Samir Oliveira da Costa - RA: 22.122.030-4



```mermaid
erDiagram
    aluno ||--o{ historico_disciplina : id_aluno
    aluno ||--o{ tcc_membro : id_aluno
    professor ||--o{ historico_professor : id_professor
    professor ||--o{ tcc_grupo : id_professor
    departamento ||--|| professor : id_departamento
    departamento ||--o{ curso : id_departamento
    curso ||--o{ disciplina : id-curso
    disciplina ||--o{ matriz_curricular : id_disciplina
    curso ||--o{ matriz_curricular : id-curso
    matriz_curricular ||--o{ disciplina : id_disciplina
    tcc_grupo ||--o{ tcc_membro : id_grupo_tcc

    aluno {
        int id_aluno PK
        string nome_aluno
        date data_nascimento_aluno
        string email_aluno
    }

    professor {
        int id_professor PK
        string nome_professor
        string email_professor
    }

    departamento {
        int id_departamento PK
        string nome_departamento
        int chefe_departamento_id FK
    }

    curso {
        int id_curso PK
        string nome_curso
        int id_departamento FK
    }

    disciplina {
        int id_disciplina PK
        string nome_disciplina
        int id_curso FK
    }

    matriz_curricular {
        int id_matriz PK
        int id_curso FK
        int id_disciplina FK
    }

    historico_disciplina {
        int id_historico PK
        int id_aluno FK
        int id_disciplina FK
        int ano_historico
        int semestre_historico
        float nota_final
    }

    historico_professor {
        int id_historico PK
        int id_professor FK
        int id_disciplina FK
        int ano_historico
        int semestre_historico
    }
    
    tcc_grupo {
        int id_grupo_tcc PK
        string descricao_tcc
        int id_professor_orientador FK
    }

    tcc_membro {
        int id_grupo_tcc FK
        int id_aluno FK
    }
```
