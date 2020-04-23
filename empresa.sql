create database empresa;
use empresa;

/* criando tabelas */

create table departamento(
  idDepto smallint not null auto_increment,
  nomeDep varchar(50),
  andar smallint,
  constraint pk_depto primary key (idDepto)
);
create table funcionario(
   idFunc smallint not null auto_increment,
   nomeF varchar(100),
   emailF varchar(100),
   sexo enum('M','F'),
   dataAd date,
   salario float,
   idDepto smallint not null,
   idSuper smallint,
   
   constraint pk_func primary key (idFunc),
   constraint fk_depto_func foreign key (idDepto) references departamento (idDepto),
   constraint fk_super_func foreign key (idSuper) references funcionario (idFunc)
);

create table projeto(
   idProj smallint not null auto_increment,
   descrP varchar(50),
   constraint pk_proj primary key (idProj)
);

create table projfunc(
    idFunc smallint not null,
    idProj smallint not null,
    dataI  date,
    constraint pk_projfunc primary key (idFunc, idProj),
    constraint fk_func_projfunc foreign key (idFunc) references funcionario (idFunc),
    constraint fk_proj_projfunc foreign key (idProj) references projeto(idProj)
);


/* inserts */
insert into departamento values (null, 'Presidencia',18);
insert into departamento values (null, 'Engenharia',17);
insert into departamento values (null, 'Financeiro',17);
insert into departamento values (null, 'Inovacao', 16);

insert into funcionario values (null, 'Isidro' , 'isidro@acme.com', 'M', '2020-01-01', 15000, 1 , null);
insert into funcionario values (null, 'Joao' , 'jao@acme.com', 'M', '2020-01-01', 4850, 2 , 1);
insert into funcionario values (null, 'Alice' , 'alice@acme.com', 'F', '2020-01-01', 7230, 3 , 1);
insert into funcionario values (null, 'Jose' , 'jose@acme.com', 'M', '2020-03-01', 6300, 2 , 2);
insert into funcionario values (null, 'Pedro' , 'pedro@acme.com', 'M', '2020-02-01', 5700, 2 , 2);

insert into projeto values (null, 'Sistema de Estoque');
insert into projeto values (null, 'Sistema de Cobranca');
insert into projeto values (null, 'Sistema de Ensino EAD');
insert into projeto values (null, 'Sistema de Vendas');

insert into projfunc values (2,1,'2020-03-01');
insert into projfunc values (2,2,'2020-03-15');
insert into projfunc values (3,2,'2020-02-20');
insert into projfunc values (3,3,'2020-02-25');
insert into projfunc values (4,1,'2020-01-10');
insert into projfunc values (4,2,'2020-01-15');
insert into projfunc values (4,3,'2020-01-20');


/* respostas para os exercicios propostos */
/* 1 - Listar todos os departamentos com funcionarios alocados */
select nomeDep, count(idFunc) as 'quantidade' 
from funcionario inner join departamento on funcionario.idDepto = departamento.idDepto 
group by funcionario.idDepto
having quantidade > 0;

/* 2 - existe algum Pedro na empresa? */
select * from funcionario where nomeF like 'Pedro%'; 

/* 3 - mostre todos os funcionarios que estao em todos os projetos */
select nomeF, descrP from 
     funcionario inner join projfunc using (idFunc)
     inner join projeto using (idProj) order by nomeF;

/* 3a - Mostre todos os funcionarios que nao estao em projetos - usando SubQueries */
select nomeF from funcionario where 
    idFunc not in (select idFunc from projFunc);
    
/* 3b - Mostre todos os funcionarios que nao estao em projetos - usando juncao externa*/
select nomeF, descrP from
   funcionario left outer join projFunc using (idFunc)
   left outer join projeto using (idProj);
  
/* 4 - mostre quem ganha acima da galera do projeto 3 
    a query interna (1) obtem todos os salarios de quem esta no projeto 3
    a query externa (2) pega o nome e o salario dos funcionarios cujo salario seja MAIOR QUE TODOS que foram retonrados na query 1
*/
/*query 2*/
 select nomeF, salario from funcionario where
  salario > all (
     /* query 1 */
     select salario from 
       funcionario inner join projFunc using(idFunc) 
       where idProj = 3);
   
   
/* 5 - Mostre todos os funcionarios que sao  supervisores */
select * from funcionario 
    where idFunc in 
       (select idSuper from funcionario);

/* 6 - mostre quantos departamentos tem funcionarios  - muito parecido com o 1 */
select nomeDep, count(idFunc) from 
   departamento left outer join funcionario using (idDepto)
   group by idDepto;
   
/* 7 - Os projetos na empresa estao vinculados a quais departamentos? */
select distinct nomeDep, descrP from
    departamento inner join funcionario using (idDepto)
                 inner join projfunc using (idFunc)
				 inner join projeto  using (idProj);