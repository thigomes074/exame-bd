-- 3.1) Mostrar o ranking dos filmes mais assistidos por faixa etária e por gênero do cliente em um dado mês e ano.
-- Considere as faixas etárias -17, 18-23, 24-31, 32-41, 42-53, 54-67, 68-83, 84-.

SELECT "Filme"."titulo", "Cliente"."genero",
    case 
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) <= 17 then '-17'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) BETWEEN 18 AND 23 then '18-23'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) BETWEEN 24 AND 31 then '24-31'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) BETWEEN 32 AND 41 then '32-41'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) BETWEEN 42 AND 53 then '42-53'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) BETWEEN 54 AND 67 then '54-67'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) BETWEEN 68 AND 83 then '68-83'
        when cast ((JulianDay('now') - JulianDay("Cliente"."dataNascimento")) / 365 AS integer) > 84 then '84-'
    end AS "faixaEtaria" FROM "Filme"
    JOIN "ClienteFilme" on "Filme"."id"="ClienteFilme"."fk_Filme_id"
    JOIN "Cliente" on "ClienteFilme"."fk_Cliente_id"="Cliente"."cpf"
GROUP BY "faixaEtaria", "genero"
ORDER BY "faixaEtaria";

-- 3.2) Mostrar os títulos dos filmes de um dado gênero com 2 dados atores no elenco.

SELECT "titulo", "genero", "nome" as "ator" FROM 
(SELECT "Filme"."id" as "idFilme", "Filme"."titulo", "Genero"."nome" as "genero" FROM "Filme"
    JOIN "FilmeGenero" on "idFilme"="FilmeGenero"."fk_Filme_id"
    JOIN "Genero" on "FilmeGenero"."fk_Genero_id"="Genero"."id"
WHERE "genero"="Ação")
    JOIN "FilmePessoa" on "idFilme"="FilmePessoa"."fk_Filme_id"
    JOIN "Pessoa" on "FilmePessoa"."fk_Pessoa_id"="Pessoa"."id"
WHERE "Pessoa_TIPO" = 0 AND ("ator" = "Keanu Reeves" OR "ator" = "Jason Statham");

-- 3.3) Mostrar o nome do ator mais assistido nos últimos 6 meses.

SELECT "Pessoa"."nome" FROM "Pessoa"
    JOIN "FilmePessoa" on "Pessoa"."id"="FilmePessoa"."fk_Pessoa_id"
    JOIN "ClienteFilme" on "FilmePessoa"."fk_Filme_id"="ClienteFilme"."fk_Filme_id"
WHERE "ClienteFilme"."data" >= date("now", "-6 month") AND "Pessoa"."Pessoa_TIPO" = 0
GROUP BY "Pessoa"."nome"
ORDER BY COUNT("Pessoa"."nome") DESC, "Pessoa"."nome" ASC
LIMIT 0, 1;

-- 3.4) Mostrar o título do filme mais assistido por gênero em um dado intervalo de datas.

SELECT "Filme"."titulo", "Cliente"."genero" FROM "Filme"
    JOIN "ClienteFilme" on "Filme"."id"="ClienteFilme"."fk_Filme_id"
    JOIN "Cliente" on "Cliente"."cpf"="ClienteFilme"."fk_Cliente_id"
WHERE "data" BETWEEN datetime("now", "-5 month") AND datetime("now")
GROUP BY "Filme"."titulo", "Cliente"."Genero";

-- 3.5) Mostrar os nomes dos diretores que estão entre os 5 mais assistidos em pelo menos 3 dos últimos 6 meses.

SELECT "Pessoa"."nome",
    case
        when ("ClienteFilme"."data" > date("now", "-1 month") AND "ClienteFilme"."data" <= date("now")) then '1 mês atrás'
        when ("ClienteFilme"."data" > date("now", "-2 month") AND "ClienteFilme"."data" <= date("now", "-1 month")) then '2 meses atrás'
        when ("ClienteFilme"."data" > date("now", "-3 month") AND "ClienteFilme"."data" <= date("now", "-2 month")) then '3 meses atrás'
        when ("ClienteFilme"."data" > date("now", "-4 month") AND "ClienteFilme"."data" <= date("now", "-3 month")) then '4 meses atrás'
        else 'muitos meses atrás'
    end AS "mês" FROM "Pessoa"
    JOIN "FilmePessoa" on "Pessoa"."id"="FilmePessoa"."fk_Pessoa_id"
    JOIN "ClienteFilme" on "FilmePessoa"."fk_Filme_id"="ClienteFilme"."fk_Filme_id"
WHERE "Pessoa"."Pessoa_TIPO" = 1
GROUP BY "mês";

-- 3.6) Remover do catálogo os filmes que foram assistidos menos de 10 vezes em cada um dos últimos 6 meses.

DELETE FROM "Filme" WHERE id IN (
    SELECT id FROM 
        (SELECT "Filme"."id",
        case 
            when "ClienteFilme"."data" >= date("now", "-1 month") then 1
            when "ClienteFilme"."data" >= date("now", "-2 month") AND "ClienteFilme"."data" < date("now", "-1 month") then 2
            when "ClienteFilme"."data" >= date("now", "-3 month") AND "ClienteFilme"."data" < date("now", "-2 month") then 3
            when "ClienteFilme"."data" >= date("now", "-4 month") AND "ClienteFilme"."data" < date("now", "-3 month") then 4
            when "ClienteFilme"."data" >= date("now", "-5 month") AND "ClienteFilme"."data" < date("now", "-4 month") then 5
            when "ClienteFilme"."data" >= date("now", "-6 month") AND "ClienteFilme"."data" < date("now", "-5 month") then 6
        end AS "mês"
        FROM "Filme" 
        JOIN "ClienteFilme" on "Filme"."id"="ClienteFilme"."fk_Filme_id"
        WHERE "mês" <= 6
        GROUP BY "titulo", "mês"
        HAVING COUNT("Filme"."titulo") < 10)
);