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

insert into funcionario values (null, 'Isidro' , 'isidro@acme.com', 'M', '2020-01-01', 15000, 1 , null);
insert into funcionario values (null, 'Jose' , 'jose@acme.com', 'M', '2020-03-01', 15000, 2 , null);
insert into funcionario values (null, 'Pedro' , 'pedro@acme.com', 'M', '2020-02-01', 15000, 2 , null);
insert into funcionario values (null, 'Joao' , 'jao@acme.com', 'M', '2020-01-01', 15000, 2 , null);
insert into funcionario values (null, 'Alice' , 'alice@acme.com', 'F', '2020-01-01', 15000, 3 , null);

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
