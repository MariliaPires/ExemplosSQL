/* como eu recupero a lista de clientes */
select * from cliente;

/* lista de clientes em ordem alfabetica */
select * from cliente order by nome desc;

/* recuperar todos os filmes */
select * from filme;

/* recuperar filmes dos mais recentes para os mais antigos */
select * from filme order by anoLancamento DESC, titulo DESC;

/* quero saber quem atua em qual filme */
select titulo, nome from ator inner join estrelado_por
    on ator.idAtor = estrelado_por.idAtor
    inner join filme on filme.idFilme = estrelado_por.idFilme;
    
/* quem atua em um determinado filme */
select titulo, nome from ator inner join estrelado_por
    on ator.idAtor = estrelado_por.idAtor
    inner join filme on filme.idFilme = estrelado_por.idFilme
    where estrelado_por.idFilme = 9;

