DROP TABLE IF EXISTS "ClienteFilme";
DROP TABLE IF EXISTS "FilmeGenero";
DROP TABLE IF EXISTS "FilmePessoa";
DROP TABLE IF EXISTS "Pagamento";
DROP TABLE IF EXISTS "Plano";
DROP TABLE IF EXISTS "Pessoa";
DROP TABLE IF EXISTS "Genero";
DROP TABLE IF EXISTS "Filme";
DROP TABLE IF EXISTS "Pais";
DROP TABLE IF EXISTS "Cliente";

CREATE TABLE "Plano" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "preco" INTEGER CHECK("preco" >= 0) NOT NULL
);

CREATE TABLE "Cliente" (
    "cpf" TEXT CHECK(LENGTH("cpf") == 14) PRIMARY KEY,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL UNIQUE,
    "senha" TEXT NOT NULL,
    "dataNascimento" TEXT CHECK ("dataNascimento" IS date("dataNascimento")) NOT NULL,
    "genero" TEXT CHECK(LENGTH("genero") == 1) NOT NULL,
    "dataAssinatura" TEXT CHECK ("dataAssinatura" IS date("dataAssinatura")) DEFAULT NULL,
    "vigencia" TEXT DEFAULT (date('now', '+6 month')),
    "fk_Plano_id" INTEGER DEFAULT NULL,
    FOREIGN KEY ("fk_Plano_id") REFERENCES "Plano" ("id") ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE "Pais" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL
);

CREATE TABLE "Filme" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL UNIQUE,
    "anoLancamento" INTEGER NOT NULL,
    "duracao" INTEGER CHECK("duracao" > 0) NOT NULL,
    "inclusao" TEXT CHECK ("inclusao" IS date("inclusao")) NOT NULL,
    "fk_Plano_id" INTEGER NOT NULL,
    "fk_Pais_id" INTEGER NOT NULL,
    FOREIGN KEY ("fk_Plano_id") REFERENCES "Plano" ("id") ON DELETE NO ACTION ON UPDATE CASCADE,
    FOREIGN KEY ("fk_Pais_id") REFERENCES "Pais" ("id") ON DELETE NO ACTION ON UPDATE CASCADE
);

CREATE TABLE "Genero" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL UNIQUE
);

CREATE TABLE "Pagamento" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "data" TEXT CHECK ("data" IS date("data")) NOT NULL,
    "fk_Cliente_id" TEXT CHECK(LENGTH("fk_Cliente_id") == 14) NOT NULL,
    FOREIGN KEY ("fk_Cliente_id") REFERENCES "Cliente" ("cpf") ON DELETE NO ACTION ON UPDATE CASCADE
);

-- 0 === ATOR | 1 === DIRETOR
CREATE TABLE "Pessoa" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "Pessoa_TIPO" INTEGER CHECK ("Pessoa_TIPO" IN (0, 1)) NOT NULL
);

CREATE TABLE "ClienteFilme" (
    "data" TEXT CHECK ("data" IS datetime("data")) NOT NULL,
    "fk_Filme_id" INTEGER NOT NULL,
    "fk_Cliente_id" TEXT CHECK(LENGTH("fk_Cliente_id") == 14) NOT NULL,
    PRIMARY KEY ("data", "fk_Filme_id", "fk_Cliente_id"),
    FOREIGN KEY ("fk_Filme_id") REFERENCES "Filme" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("fk_Cliente_id") REFERENCES "Cliente" ("cpf") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "FilmeGenero" (
    "fk_Filme_id" INTEGER NOT NULL,
    "fk_Genero_id" INTEGER NOT NULL,
    PRIMARY KEY ("fk_Filme_id", "fk_Genero_id"),
    FOREIGN KEY ("fk_Filme_id") REFERENCES "Filme" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("fk_Genero_id") REFERENCES "Genero" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE "FilmePessoa" (
    "fk_Filme_id" INTEGER NOT NULL,
    "fk_Pessoa_id" INTEGER NOT NULL,
    PRIMARY KEY ("fk_Filme_id", "fk_Pessoa_id"),
    FOREIGN KEY ("fk_Filme_id") REFERENCES "Filme" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("fk_Pessoa_id") REFERENCES "Pessoa" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);