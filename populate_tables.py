from faker import Faker #Biblioteca para gerar os nomes e emails falsos
import psycopg2
import random

fake = Faker("pt_BR")

conn = psycopg2.connect(
    host="localhost",
    user="postgres",
    password="123123", #Alterar para o respectivo banco da máquina
    dbname="BANCO6"    #Alterar para o respectivo banco da máquina
)
cursor = conn.cursor()

cursos = [
    "Ciência da Computação",
    "Engenharia Elétrica",
    "Engenharia de Robôs",
    "Engenharia Química",
    "Engenharia Mecânica",
    "Administração"
]
departamentos = [
    "Ciência da Computação",
    "Matemática",
    "Elétrica",
    "Química",
    "Mecânica",
    "Física",
    "Administração de Empresas"
]
disciplinas = [
    "Cálculo Diferencial e Integral",
    "Física para Engenharia",
    "Álgebra Linear",
    "Mecânica dos Sólidos",
    "Banco de Dados",
    "Termodinâmica",
    "Cálculo Numérico",
    "Resistência dos Materiais",
    "Fundamentos de Programação"
]

for i, departamento in enumerate(departamentos):
    cursor.execute("INSERT INTO departamento (id_departamento, nome_departamento) VALUES (%s, %s)", (i + 1, departamento))
conn.commit()

cursor.execute("SELECT id_departamento FROM departamento")
departamentos = cursor.fetchall()
for i in range(30):
    id_departamento = random.choice(departamentos)[0]
    id_professor = i
    cursor.execute(
        "INSERT INTO professor (id_professor, nome_professor, email_professor, id_departamento) VALUES (%s, %s, %s, %s)",
        (id_professor, fake.name(), fake.email(), id_departamento)
    )
conn.commit()

cursor.execute("SELECT id_departamento FROM departamento")
departamentos = cursor.fetchall()
for i, curso in enumerate(cursos):
    id_departamento = random.choice(departamentos)[0]
    cursor.execute(
        "INSERT INTO curso (id_curso, nome_curso, id_departamento) VALUES (%s, %s, %s)",
        (i + 1, curso, id_departamento)
    )
conn.commit()

for i in range(80):
    id_aluno = random.randint(100000, 999999)
    cursor.execute(
        "INSERT INTO aluno (id_aluno, nome_aluno, ano_inicio, email_aluno) VALUES (%s, %s, %s, %s)",
        (id_aluno, fake.name(), random.randint(2010, 2024), fake.email())
    )
conn.commit()

cursor.execute("SELECT id_curso FROM curso")
cursos = cursor.fetchall()
for i, disciplina in enumerate(disciplinas):
    id_curso = random.choice(cursos)[0]
    cursor.execute(
        "INSERT INTO disciplina (id_disciplina, nome_disciplina, id_curso) VALUES (%s, %s, %s)",
        (i + 1, disciplina, id_curso)
    )
conn.commit()

cursor.execute("SELECT id_curso FROM curso")
cursos = cursor.fetchall()
cursor.execute("SELECT id_disciplina FROM disciplina")
disciplinas = cursor.fetchall()
for i in range(len(disciplinas)):
    id_curso = random.choice(cursos)[0]
    id_disciplina = disciplinas[i][0]
    cursor.execute(
        "INSERT INTO matriz_curricular (id_matriz, id_curso, id_disciplina) VALUES (%s, %s, %s)",
        (i + 1, id_curso, id_disciplina)
    )
conn.commit()

cursor.execute("SELECT id_aluno FROM aluno")
alunos = cursor.fetchall()
cursor.execute("SELECT id_disciplina FROM disciplina")
disciplinas = cursor.fetchall()
for i in range(300):
    id_aluno = random.choice(alunos)[0]
    id_disciplina = random.choice(disciplinas)[0]
    cursor.execute(
        "INSERT INTO disciplina_historico (id_historico, id_aluno, id_disciplina, ano, semestre, nota_final) VALUES (%s, %s, %s, %s, %s, %s)",
        (i + 1, id_aluno, id_disciplina, random.randint(2010, 2024), random.randint(1, 2), round(random.uniform(0, 10), 2))
    )
conn.commit()

cursor.execute("SELECT id_professor FROM professor")
professores = cursor.fetchall()
cursor.execute("SELECT id_disciplina FROM disciplina")
disciplinas = cursor.fetchall()
for i in range(100):
    id_professor = random.choice(professores)[0]
    id_disciplina = random.choice(disciplinas)[0]
    cursor.execute(
        "INSERT INTO historico_professor (id_historico, id_professor, id_disciplina, ano, semestre) VALUES (%s, %s, %s, %s, %s)",
        (i + 1, id_professor, id_disciplina, random.randint(2010, 2024), random.randint(1, 2))
    )
conn.commit()

cursor.execute("SELECT id_professor FROM professor")
professores = cursor.fetchall()
for i in range(20):
    id_orientador = random.choice(professores)[0]
    cursor.execute(
        "INSERT INTO tcc_grupo (id_grupo, descricao_grupo, id_orientador) VALUES (%s, %s, %s)",
        (i + 1, fake.bs(), id_orientador)
    )
conn.commit()

cursor.execute("SELECT id_grupo FROM tcc_grupo")
grupos_tcc = cursor.fetchall()
cursor.execute("SELECT id_aluno FROM aluno")
alunos = cursor.fetchall()
for id_grupo in grupos_tcc:
    num_membros = random.randint(2, 4)
    membros = random.sample(alunos, num_membros)
    for membro in membros:
        cursor.execute(
            "INSERT INTO tcc_membro (id_grupo, id_aluno) VALUES (%s, %s)",
            (id_grupo[0], membro[0])
        )
conn.commit()

cursor.execute("SELECT id_departamento FROM departamento")
departamentos = cursor.fetchall()
cursor.execute("SELECT id_professor FROM professor")
professores = cursor.fetchall()
for id_departamento in departamentos:
    id_chefe = random.choice(professores)[0]
    cursor.execute(
        "UPDATE departamento SET id_chefe = %s WHERE id_departamento = %s",
        (id_chefe, id_departamento[0])
    )
conn.commit()

cursor.close()
conn.close()
