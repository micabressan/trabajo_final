-- DROPING THE TYPE TO REPLACE IF THERE IS ALREADY A TYPE WITH THIS NAME

    DROP TYPE tp_telefone FORCE;
    DROP TYPE array_telefone FORCE;
    DROP TYPE atleta FORCE;
    DROP TYPE competicao FORCE;

--- Criando o objeto propriamente dito
    --tp stands for type
    CREATE OR REPLACE TYPE tp_telefone AS OBJECT(
        --essa é a inteface publica composta por:
        ---atributors
        ---methods
        numero VARCHAR2(14),
    );

-- Vamos criar então esses atributos para o caso da questão 1 mp
    --warning ignorem os tabs, eles foram feitos apenas para compreensão melhor
    CREATE OR REPLACE TYPE tp_atleta AS OBJECT(
        -- para atributos temos alguns tipos
        -- NUMBER, VARCHAR2(20) [STRING] , CHAR, DATE.
        cpf VARCHAR2(12),
        nome VARCHAR2(12),
        idade NUMBER,
        telefones array_telefone,
        endereco tp_enderecos,
        peso NUMBER,
        MEMBER FUNCTION participaCompeticao RETURN INTEGER,
    ) --caso queiramos criar uma classe abstrata,neste momento teriamos que colocar 
    NOT FINAL NOT INSTANTIABLE;
    /
        CREATE OR REPLACE TYPE tp_endereco AS OBJECT(
            cep VARCHAR2(6),
            bairro VARCHAR2(20),
            cidade VARCHAR2(20),
            rua VARCHAR2(20),
        );
        /
        -- ainda precisamos criar o arry de telefones
        CREATE OR REPLACE array_telefone AS VARRAY(5) OF tp_telefone
        /

    CREATE OR REPLACE TYPE tp_competicao AS OBJECT(
        codigo NUMBER,
        descricao VARCHAR2(20),
        data DATE,
    );
    /
    --criando um filho de atleta
    CREATE OR REPLACE TYPE tp_nadador UNDER tp_atleta(
        cpf_nadador REF tp_nadador,
    );


-- embora já completamos uma parte do problema, precisamos criar metodos,
-- eis então como fazemos isso 

    MEMEBER FUNCTION ... RETURN,  --Tradicional
    FINAL MEMBER FUNCTION .... RETURN something, --Funcção não pode ser reescrita
    MEMBER PROCEDURE SetOrChangesomething(s number), --Função void

    ORDER MEMEBER fuctionName (alfredo className) RETURN somehting, -- é uma fução de comparação de clases por exemplo
    MAP MEMBER FUNCTION .... RETURN something, -- função de mapeamento

    CONSTRUCTOR FUNCTION ApropriaClasse,


    -- exemplo de como fazer isso no cenário atual
            CREATE OR REPLACE TYPE tp_atleta AS OBJECT(
                FINAL MEMBER FUNCTION getCpf RETURN NUMBER,
                MEMBER PROCEDURE ajusteDePeso(peso number),
                ORDER MEMBER FUNCTION compararPeso( jorginho tp_atleta) RETURN NUMBER,
            ) NOT FINAL NOT INSTANTIABLE;

-- definido isso precisamos trabalhar com a criacao de tabelas correspondentes.
   
    --dando um drop na table no arquivo
    DROP TABLE tb_nadador CASCADE CONSTRAINTS PURGE;
    DROP TABLE tb_competicao CASCADE CONSTRAINTS PURGE;

-- Criando de fato as tabelas de uma classe
    -- tp
    CREATE TABLE tb_nadador OF tp_nadador(
        --temos qe definir a chave primaria,
        cpf_nadador SCOPE IS tb_nadador, -- so exemplificando 
        idade NOT NULL -- somente um exemplo
        --digamos que tenhamos um codigo_competiçao no nadador eis como trabalhamos com isso:
        codigo_competicao WITH ROWID REFERENCES tb_competicao
    );

    CREATE TABLE tb_competicao OF tp_competicao(
        --temos qe definir a chave primaria,
        codigo PRIMARY KEY,
        data NOT NULL
    );