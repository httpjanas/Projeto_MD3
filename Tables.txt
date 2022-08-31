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