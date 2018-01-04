CREATE TABLE diretor (
    idDiretor int IDENTITY(1,1),
    nome varchar(45) NOT NULL,
    PRIMARY KEY (idDiretor) 
); 

CREATE TABLE genero(
	idGenero int IDENTITY(1,1),
	nome varchar(45) NOT NULL,
	PRIMARY KEY (idGenero)
);

CREATE TABLE filme(
	idfilme int IDENTITY(1,1),
	nomeBR varchar(45) NOT NULL,
	nomeEN varchar(45),
	anoLancamento int,
	diretor_idDiretor int NOT NULL,
	sinopse text,
	genero_idgenero int NOT NULL,
	PRIMARY KEY (idfilme),
	FOREIGN KEY (diretor_idDiretor) REFERENCES diretor(idDiretor),
	FOREIGN KEY (genero_idgenero) REFERENCES genero(idGenero)
);

CREATE TABLE premiacao(
	idpremiacao int IDENTITY(1,1),
	nome varchar(45) NOT NULL,
	ano int NOT NULL,
	PRIMARY KEY (idpremiacao)
);

CREATE TABLE filme_has_premiacao(
	filme_idfilme int,
	premiacao_idpremiacao int NOT NULL,
	ganhou bit NOT NULL,
	PRIMARY KEY (filme_idFilme, premiacao_idpremiacao),
	FOREIGN KEY (filme_idfilme) REFERENCES filme(idfilme),
	FOREIGN KEY (premiacao_idpremiacao) REFERENCES premiacao(idpremiacao)
);

CREATE TABLE horario(
	idhorario int IDENTITY(1,1),
	horario time NOT NULL,
	PRIMARY KEY (idhorario)
);

CREATE TABLE sala(
	idsala int IDENTITY(1,1),
	nome varchar(45) NOT NULL,
	capacidade int NOT NULL,
	PRIMARY KEY(idsala)
);

CREATE TABLE filme_exibido_sala(
	filme_idfilme int,
	sala_idsala int,
	horario_idhorario int,
	PRIMARY KEY(filme_idfilme, sala_idsala, horario_idhorario),
	FOREIGN KEY (filme_idfilme) REFERENCES filme(idfilme),
	FOREIGN KEY (sala_idsala) REFERENCES sala(idsala),
	FOREIGN KEY (horario_idhorario) REFERENCES horario(idhorario)
);

CREATE TABLE funcao(
	idfuncao int IDENTITY(1,1),
	nome varchar(45)
	PRIMARY KEY (idfuncao)
);

CREATE TABLE funcionario(
	idfuncionario int IDENTITY(1,1),
	nome varchar(45) NOT NULL,
	carteiraTrabalho int NOT NULL,
	dataContratacao date NOT NULL,
	salario float NOT NULL,
	PRIMARY KEY (idfuncionario)
);

CREATE TABLE horario_trabalho_funcionario(
	horario_idhorario int,
	funcionario_idfuncionario int NOT NULL,
	funcao_idfuncao int NOT NULL,
	PRIMARY KEY (horario_idhorario, funcionario_idfuncionario),
	FOREIGN KEY (funcao_idfuncao) REFERENCES funcao(idfuncao)
);