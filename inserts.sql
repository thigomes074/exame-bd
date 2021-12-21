INSERT INTO "Plano" ("nome", "preco") VALUES ("Bronze", 9.99), ("Prata", 24.99), ("Ouro", 39.99);

INSERT INTO "Cliente" ("cpf", "nome", "email", "senha", "dataNascimento", "genero") VALUES
    ("123.321.123-32", "Julia da Silva", "ju@gmail.com", "123@gmail", date("2003-05-14"), "F"),
    ("231.423.154-65", "Abílio Loio Malafaia", "ab@gmail.com", "19312", date("1995-02-24"), "M");

INSERT INTO "Cliente" ("cpf", "nome", "email", "senha", "dataNascimento", "genero", "dataAssinatura", "fk_Plano_id") VALUES
    ("456.321.989-12", "Rodrigo Siqueira", "ro@gmail.com", "bdedms", date("1998-12-17"), "M", date("now", "-1 month"), 1),
    ("433.343.223-21", "Rui Curado Ataíde", "rUI@gmail.com", "ruigatao", date("1994-11-12"), "M", date("now", "-3 month"), 2),
    ("544.131.123-98", "Diego Feira Quintais", "diego@gmail.com", "dragao.98", date("2004-10-10"), "M", date("now", "-2 month"), 3),
    ("554.766.877-23", "Érica Franqueira", "erica@gmail.com", "81283287", date("2000-07-07"), "F", date("now", "-8 month"), 3);

INSERT INTO "Pais" ("nome") VALUES ("Brasil"), ("EUA"), ("México"), ("Inglaterra");

INSERT INTO "Filme" ("titulo", "anoLancamento", "duracao", "fk_Pais_id", "inclusao", "fk_Plano_id") VALUES
    ("Matriz", 1999, 150, 2, date("now", "-4 month"), 1),
    ("O Protetor", 2004, 132, 1, date("now", "-4 month"), 1),
    ("Infiltrado", 2021, 58, 2, date("now", "-4 month"), 2),
    ("Joker", 2019, 62, 3, date("now", "-4 month"), 2),
    ("Animais Fantásticos: Os Crimes de Grindelwald", 2018, 74, 4, date("now", "-4 month"), 3);

INSERT INTO "Genero" ("nome") VALUES ("Aventura"), ("Ação"), ("Drama"), ("Romance"), ("Comédia");

INSERT INTO "Pagamento" ("data", "fk_Cliente_id") VALUES 
    (date("now"), "456.321.989-12"),
    (date("now"), "433.343.223-21"), (date("now", "-1 month"), "433.343.223-21"), (date("now", "-2 month"), "433.343.223-21"),
    (date("now"), "544.131.123-98"), (date("now", "-1 month"), "544.131.123-98");

-- ATORES
INSERT INTO "Pessoa" ("nome", "Pessoa_TIPO") VALUES
    ("Keanu Reeves", 0), ("Laurence Fishburne", 0),
    ("Denzel Washington", 0), ("Bill Pullman", 0),
    ("Jason Statham", 0), ("Scott Eastwood", 0), ("Josh Hartnett", 0),
    ("Joaquin Phoenix", 0),
    ("Johnny Depp", 0), ("Eddie Redmayne", 0);

-- DIRETORES
INSERT INTO "Pessoa" ("nome", "Pessoa_TIPO") VALUES
    ("Lilly Wachowski", 1), ("Lana Wachowski", 1),
    ("Antoine Fuqua", 1),
    ("Guy Ritchie", 1),
    ("Todd Phillips", 1),
    ("David Yates", 1);

INSERT INTO "ClienteFilme" ("data", "fk_Cliente_id", "fk_Filme_id") VALUES 
    (datetime("now"), "456.321.989-12", 2), (datetime("now"), "456.321.989-12", 1), (datetime("now", "-5 day"), "456.321.989-12", 2),
    (datetime("now"), "554.766.877-23", 5), (datetime("now", "-2 day"), "554.766.877-23", 5), (datetime("now", "-4 day"), "554.766.877-23", 5),
    (datetime("now", "-7 month"), "554.766.877-23", 4),
    (datetime("now", "-1 month"), "433.343.223-21", 1),
    (datetime("now", "-4 month"), "433.343.223-21", 1);

INSERT INTO "FilmeGenero" ("fk_Filme_id", "fk_Genero_id") VALUES 
    (1, 2), (2, 2), (3, 2), (4, 3), (5, 1);

INSERT INTO "FilmePessoa" ("fk_Filme_id", "fk_Pessoa_id") VALUES 
    (1, 1), (1, 2), (1, 11), (1, 12),
    (2, 3), (2, 4), (2, 13),
    (3, 5), (3, 6), (3, 7), (3, 14),
    (4, 8), (4, 15),
    (5, 9), (5, 10), (5, 16);