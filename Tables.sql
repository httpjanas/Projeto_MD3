/* Criando as tabelas: */

CREATE TABLE "tb_alunos" (
  "cpf" varchar(14) PRIMARY KEY,
  "nome" varchar(60),
  "data_de_nascimento" date,
  "rua" varchar(30),
  "bairro" varchar(30),
  "cidade" varchar(30),
  "estado" varchar(30),
  "email" varchar(30),
  "data_de_matricula" date,
  "id_forma_de_pagamento" int,
  "id_curso" int,
  "id_turma" int
);

CREATE TABLE "tb_facilitadores" (
  "cpf" varchar(14) PRIMARY KEY,
  "nome" varchar(60),
  "data_de_nascimento" date,
  "rua" varchar(30),
  "bairro" varchar(30),
  "cidade" varchar(30),
  "estado" varchar(30),
  "email" varchar(60),
  "formacao" varchar(30),
  "id_area" int,
  "id_departamento" int
);

CREATE TABLE "tb_departamentos" (
  "id" int PRIMARY KEY,
  "nome" varchar(60),
  "descricao" text,
  "numero_de_funcionarios" int
);

CREATE TABLE "tb_modulos" (
  "id" int PRIMARY KEY,
  "nome" varchar(60),
  "id_curso" int,
  "descricao" text
);

CREATE TABLE "tb_cursos" (
  "id" int PRIMARY KEY,
  "nome" varchar(60),
  "quantidade_de_modulos" int
);

CREATE TABLE "tb_turma" (
  "id" int PRIMARY KEY,
  "id_curso" int,
  "data_de_inicio" date,
  "data_de_termino" date,
  "cpf_facilitador_soft" varchar(14),
  "cpf_facilitador_tech" varchar(14)
);

CREATE TABLE "tb_area" (
  "id" int PRIMARY KEY,
  "id_departamento" int,
  "nome" varchar(60)
);

CREATE TABLE "tb_forma_de_pagamento" (
  "id" int PRIMARY KEY,
  "nome" varchar(60)
);

ALTER TABLE "tb_alunos" ADD FOREIGN KEY ("id_curso") REFERENCES "tb_cursos" ("id");

ALTER TABLE "tb_alunos" ADD FOREIGN KEY ("id_turma") REFERENCES "tb_turma" ("id");

ALTER TABLE "tb_alunos" ADD FOREIGN KEY ("id_forma_de_pagamento") REFERENCES "tb_forma_de_pagamento" ("id");

ALTER TABLE "tb_turma" ADD FOREIGN KEY ("id_curso") REFERENCES "tb_cursos" ("id");

ALTER TABLE "tb_modulos" ADD FOREIGN KEY ("id_curso") REFERENCES "tb_cursos" ("id");

ALTER TABLE "tb_area" ADD FOREIGN KEY ("id_departamento") REFERENCES "tb_departamentos" ("id");

ALTER TABLE "tb_facilitadores" ADD FOREIGN KEY ("id_area") REFERENCES "tb_area" ("id");

ALTER TABLE "tb_facilitadores" ADD FOREIGN KEY ("id_departamento") REFERENCES "tb_departamentos" ("id");

ALTER TABLE "tb_turma" ADD FOREIGN KEY ("cpf_facilitador_soft") REFERENCES "tb_facilitadores" ("cpf");

ALTER TABLE "tb_turma" ADD FOREIGN KEY ("cpf_facilitador_tech") REFERENCES "tb_facilitadores" ("cpf");

/* Visualizando as tabelas */

select * from tb_alunos 
select * from tb_area
select * from tb_cursos 
select * from tb_departamentos
select * from tb_facilitadores 
select * from tb_forma_de_pagamento
select * from tb_modulos 
select * from tb_turma

/* Select */

-- Selecionar a quantidade total de estudantes cadastrados no banco:

select count(cpf) as "Quantidade total de alunos: " from tb_alunos

-- Selecionar todos os estudantes com os respectivos cursos que eles estão cadastrados:

select tb_alunos.nome as "Nome: ", tb_cursos.nome as "Curso: " from tb_alunos
inner join tb_cursos on tb_alunos.id_curso = tb_cursos.id

-- Selecionar quais pessoas facilitadoras atuam em mais de uma turma:

select tb_facilitadores.nome as "Nome: ", tb_area.nome as "Área: ", count(tb_turma.cpf_facilitador_soft) 
as "Quantidade: " from tb_facilitadores
inner join tb_area on tb_facilitadores.id_area = tb_area.id
inner join tb_turma on tb_facilitadores.cpf = tb_turma.cpf_facilitador_soft
group by tb_facilitadores.cpf, tb_area.id, tb_area.nome
order by count(tb_turma.cpf_facilitador_soft) desc
limit 1

-- Selecionar quais pessoas facilitadoras atuam em mais de uma turma:

select tb_facilitadores.nome as "Nome: ", tb_area.nome as "Área: ", count(tb_turma.cpf_facilitador_tech) 
as "Quantidade: " from tb_facilitadores
inner join tb_area on tb_facilitadores.id_area = tb_area.id
inner join tb_turma on tb_facilitadores.cpf = tb_turma.cpf_facilitador_tech
group by tb_facilitadores.cpf, tb_area.id, tb_area.nome
order by count(tb_turma.cpf_facilitador_tech) desc
limit 1

-- Quantos alunos dos cursos 1 e 2 realizam o pagamento durante e quantos realizam o pagamentos após o curso:

select tb_forma_de_pagamento.nome as "Forma de pagamento: ", count(tb_alunos.cpf) 
as "Quantidade de alunos pela forma de pagamento: " from tb_alunos
inner join tb_forma_de_pagamento on tb_forma_de_pagamento.id = tb_alunos.id_forma_de_pagamento
group by tb_forma_de_pagamento.nome
order by tb_forma_de_pagamento.nome


-- Quantos alunos do curso 1 (Analise de Dados) realizam o pagamento durante e quantos realizam o pagamentos após o curso:

select tb_forma_de_pagamento.nome as "Forma de pagamento: ", count(tb_alunos.cpf) 
as "Quantidade de alunos pela forma de pagamento: " from tb_alunos
inner join tb_forma_de_pagamento on tb_forma_de_pagamento.id = tb_alunos.id_forma_de_pagamento
where tb_alunos.id_curso = 1
group by tb_forma_de_pagamento.nome

-- Quantos alunos do curso 2 (Desenvolvimento Web) realizam o pagamento durante e quantos realizam o pagamentos após o curso:

select tb_forma_de_pagamento.nome as "Forma de pagamento: ", count(tb_alunos.cpf) 
as "Quantidade de alunos pela forma de pagamento: " from tb_alunos
inner join tb_forma_de_pagamento on tb_forma_de_pagamento.id = tb_alunos.id_forma_de_pagamento
where tb_alunos.id_curso = 2
group by tb_forma_de_pagamento.nome

-- Qual a formação dos facilitadores e quantos são formados em cada formação:

select tb_area.nome as "Área: ", tb_facilitadores.formacao as "Formação: ", count(tb_facilitadores.formacao) 
as "Quantidade: " from tb_facilitadores
inner join tb_area on tb_facilitadores.id_area = tb_area.id
group by tb_facilitadores.formacao, tb_area.nome
order by count(tb_facilitadores.formacao) desc

-- A qual estado pertence a maior quantidade de alunos:

select estado as "Estados: ", count(estado) from tb_alunos
group by "Estados: "
order by count desc
limit 1