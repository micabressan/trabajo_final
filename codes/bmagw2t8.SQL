CREATE DATABASE revisao_orcamento;
USE revisao_orcamento;

CREATE TABLE cliente(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
nome VARCHAR(60) NOT NULL,
cpf BIGINT NOT NULL,
nascimento DATE,
limite_credito DOUBLE NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE atendente(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
nome VARCHAR(60) NOT NULL,
sexo CHAR(1) NOT NULL,
email VARCHAR(60) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE servico(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
descricao VARCHAR(50) NOT NULL,
duracao TIME NOT NULL,
preco DOUBLE NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE situacao_orcamento(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
descricao VARCHAR(50) NOT NULL,
PRIMARY KEY (id)
);

CREATE TABLE orcamento(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
data DATE NOT NULL,
valor_total DOUBLE(9,2) NOT NULL,
observacoes TEXT NOT NULL,
data_autorizacao DATE NULL,
situacao_orcamento_id INT UNSIGNED NOT NULL,
atendente_id INT UNSIGNED NOT NULL,
cliente_id INT UNSIGNED NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (situacao_orcamento_id) REFERENCES situacao_orcamento(id),
FOREIGN KEY (atendente_id) REFERENCES atendente(id),
FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

CREATE TABLE servicos_orcamentos(
id INT(11) UNSIGNED AUTO_INCREMENT NOT NULL,
servico_id INT UNSIGNED NOT NULL,
orcamento_id INT UNSIGNED NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (orcamento_id) REFERENCES orcamento(id),
FOREIGN KEY (servico_id) REFERENCES servico(id)
);