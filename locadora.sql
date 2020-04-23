/* criando a base de dados */
create database locadora;

/* verificando se as bases existem */
show databases;

/* acessando a base */
use locadora;

/* criando as tabelas */
create table cliente(
   idCliente integer not null auto_increment,
   nome varchar(100) not null,
   endereco varchar(150) not null,
   telefone varchar(20),
   email varchar(100) unique not null,
   constraint pk_idCliente primary key (idCliente)
);

/* listando as tabelas criadas */
show tables;

/* mostrando a estrutura da tabela criada */
desc cliente;

/* CUIDADO - removendo uma tabela e TODOS os dados dela */
drop table cliente;

/* tabela filme */
create table filme(
   idFilme integer not null auto_increment,
   titulo  varchar(100) not null,
   categoria varchar(50) not null,
   anoLancamento integer,
   duracao integer,
   estudio varchar(50),
   lancamento boolean not null default false,
   
   constraint pk_idFilme primary key (idFilme)
);

create table ator(
    idAtor integer not null auto_increment,
    nome varchar(100) not null,
    minibio text,
    
    constraint pk_idAtor primary key (idAtor)
);

create table midia(
    idMidia integer not null auto_increment,
    preco   float not null,
    tipo    varchar(1) not null,
    disponivel boolean default true,
    idFilme integer not null,
    
    constraint pk_idMidia primary key (idMidia),
    constraint fk_idFilme_midia foreign key (idFilme) references filme(idFilme)
);

create table estrelado_por(
   idFilme integer not null,
   idAtor  integer not null,
   
   constraint pk_idFilme_idAtor primary key (idFilme, idAtor),
   constraint fk_idFilme_estrelado foreign key (idFilme) references filme(idFilme),
   constraint fk_idAtor_estrelado foreign key (idAtor) references ator(idAtor)
);

create table aluga(
    idAluguel integer not null auto_increment,
    idCliente integer not null,
    idMidia   integer not null,
    dataAluguel date not null,
    dataDevolucaoPrev date not null,
    dataDevolucaoEfet date not null,
    valorAluguel  float not null,
    valorMulta    float not null default 0,
    valorRecebido float not null,
    situacao      varchar(1),
    
    constraint pk_aluga primary key (idAluguel),
    constraint fk_idCliente_aluga foreign key (idCliente) references cliente(idCliente),
    constraint fk_idMidia_aluga foreign key (idMidia) references midia(idMidia)
);

