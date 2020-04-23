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

/* quero quanto em R$ de locacoes foram na data 2020-04-01 */
select sum(valorAluguel) from aluga where dataAluguel = '2020-04-01';

/* quais sao os valores de aluguel por data (agrupados) */ 
select dataAluguel, sum(valorAluguel) as 'total' 
     from aluga group by dataAluguel
     order by dataAluguel desc;
     
/* qual o ticket medio de aluguel de filmes? */
select avg(valorAluguel) from aluga;

/* quanto o cliente 1 ja alugou - quanto ele deve */
select sum(valorAluguel), nome from aluga inner join cliente
   using(idCliente) /* equivale a: on aluga.idCliente = cliente.idCliente */
   where idCliente = 1;
   
   
/* quanto cada cliente deve */   
select sum(valorAluguel), nome from aluga inner join cliente
   using(idCliente) /* equivale a: on aluga.idCliente = cliente.idCliente */
   group by idCliente;
   
   
/* quanto cada cliente deve, ordenado pelos principais devedores */
select sum(valorAluguel) as 'divida', nome from aluga inner join cliente
   using(idCliente) /* equivale a: on aluga.idCliente = cliente.idCliente */
   group by idCliente
   order by divida DESC;
