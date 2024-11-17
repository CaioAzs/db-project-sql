# Banco de Dados - SQL (PostgreSQL)

---
- Caio de Souza Conceição
- Pedro Henrique Algodoal
- Samir Oliveira da Costa
  
---

## Descrição do Projeto

Este projeto envolve a criação de um banco de dados para simular um modelo de uma instituição de ensino.

## Instruções de Uso

### 1. Criação do Banco de Dados
Primeiramente, crie um banco de dados no PostgreSQL com o nome "BANCO6".

### 2. Execução do Script SQL
Execute o script `create_tables.sql` no banco de dados criado. Este script irá criar todas as tabelas necessárias para o funcionamento do banco de dados.

```sql
-- Script: create_tables.sql
```

### 3. População das Tabelas
Execute o arquivo `populate_tables.py` para popular as tabelas com dados fictícios. Certifique-se de ter a biblioteca **Faker** instalada. Além disso, altere as configurações do banco de dados no script Python para refletir a autenticação e o banco de dados que você criou.

```bash
pip install faker psycopg2
```

No arquivo `populate_tables.py`, altere as informações de conexão com o banco, como:

```python
conn = psycopg2.connect(
    host="localhost",
    user="postgres",
    password="123123",  # Substitua pela senha do seu banco de dados
    dbname="BANCO6"     # Substitua pelo nome do banco de dados
)
```

Após a alteração, execute o script:

```bash
python populate_tables.py
```

Este script irá preencher as tabelas com dados gerados aleatoriamente.

### 4. Consultas SQL
As consultas SQL fornecidas são exemplos para recuperar informações de diferentes áreas do sistema (ARQUIVO QUERIES.SQL):

1. **Histórico de Disciplinas de um Aluno**
2. **Histórico de Disciplinas Ministradas por um Professor**
3. **Alunos que se Formaram em um Ano e Semestre Específicos**
4. **Professores Chefes de Departamentos**
5. **Grupos de TCC com Orientadores e Membros**

---

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
