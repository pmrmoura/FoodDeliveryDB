CREATE TABLE USUARIO(
    NUMERO_TELEFONE VARCHAR2(11) NOT NULL PRIMARY KEY,
    CPF VARCHAR2(11) NOT NULL UNIQUE,
    EMAIL VARCHAR2(50) NOT NULL UNIQUE,
    NOME VARCHAR2(150) NOT NULL,
    EH_VIP INT,
    NUMERO_TELEFONE_PADRINHO VARCHAR2(11), 

    CONSTRAINT NUMERO_TELEFONE_FK  FOREIGN KEY (NUMERO_TELEFONE_PADRINHO) REFERENCES USUARIO(NUMERO_TELEFONE)
);

CREATE TABLE ENDERECO (
    NUMERO_TELEFONE VARCHAR2(13) NOT NULL,
    BAIRRO VARCHAR(20) NOT NULL,
    RUA VARCHAR(50) NOT NULL,
    CEP VARCHAR(20) NOT NULL,
    CIDADE VARCHAR(15) NOT NULL,
    NUMERO_CASA INT NOT NULL,

    CONSTRAINT KEY_ENDERECO PRIMARY KEY(NUMERO_TELEFONE, BAIRRO, RUA, CEP, CIDADE, NUMERO_CASA),
    CONSTRAINT FK_NUMERO_TELEFONE  FOREIGN KEY (NUMERO_TELEFONE) REFERENCES USUARIO(NUMERO_TELEFONE)
); 

CREATE TABLE GANHA(
    NUMERO_TELEFONE VARCHAR2(11) NOT NULL,
    NOME_CODIGO VARCHAR2(20) NOT NULL,
    CONSTRAINT PK_GANHA PRIMARY KEY (NUMERO_TELEFONE, NOME_CODIGO),
    CONSTRAINT FK_NUMERO_TELEFONE_GANHA FOREIGN KEY (NUMERO_TELEFONE) REFERENCES USUARIO(NUMERO_TELEFONE),
    CONSTRAINT FK_NOME_CODIGO_GANHA FOREIGN KEY (NOME_CODIGO) REFERENCES CUPOM(NOME_CODIGO)
);

CREATE TABLE RESTAURANTE (
    CNPJ VARCHAR2(14) NOT NULL PRIMARY KEY,
    NOME VARCHAR2(100) NOT NULL,
    ENDERECO VARCHAR2(200) NOT NULL,
    CONTA_BANCO INT
);

CREATE TABLE ENTREGADOR(
    CPF VARCHAR2(11) NOT NULL PRIMARY KEY,
    NOME VARCHAR2(50) NOT NULL,
    TELEFONE1 VARCHAR(11) NOT NULL,
    TELEFONE2 VARCHAR(11),
    EH_APP INT NOT NULL,
    NOTA INT,
    CNPJ VARCHAR2(14),
    CONSTRAINT FK_CNPJ_RESTAURANTE2 FOREIGN KEY (CNPJ) REFERENCES RESTAURANTE(CNPJ)
);

CREATE TABLE PRATO (
    CNPJ VARCHAR2(14) NOT NULL,
    NUMERO_PRATO INT NOT NULL,
    NOME_PRATO VARCHAR2(60) NOT NULL,
    IMAGEM BLOB,
    PRECO FLOAT NOT NULL,
    DESCRICAO VARCHAR2(300) NOT NULL,
    
    CONSTRAINT PK_PRATO PRIMARY KEY (CNPJ, NUMERO_PRATO),
    CONSTRAINT FK_CNPJ FOREIGN KEY (CNPJ) REFERENCES RESTAURANTE(CNPJ)
);

CREATE TABLE PRODUTO(
    CODIGO INT NOT NULL PRIMARY KEY
);

CREATE TABLE FORNECEDOR(
    CNPJ VARCHAR2(14) NOT NULL PRIMARY KEY
);

CREATE TABLE PROMOCAO(
    CODIGO VARCHAR2(20) NOT NULL PRIMARY KEY
);

CREATE TABLE COMPRA(
    CNPJ_RESTAURANTE VARCHAR2(14) NOT NULL,
    CODIGO_PRODUTO INT NOT NULL,
    CNPJ_FORNECEDORES VARCHAR2(14) NOT NULL,
    CODIGO_PROMOCAO VARCHAR2(20),

    CONSTRAINT PK_COMPRA PRIMARY KEY(CNPJ_RESTAURANTE, CODIGO_PRODUTO, CNPJ_FORNECEDORES ),
    CONSTRAINT FK_CNPJ_RESTAURANTE FOREIGN KEY (CNPJ_RESTAURANTE) REFERENCES RESTAURANTE(CNPJ),
    CONSTRAINT FK_CODIGO_PRODUTO FOREIGN KEY (CODIGO_PRODUTO) REFERENCES PRODUTO(CODIGO),
    CONSTRAINT FK_CNPJ_FORNECEDORES FOREIGN KEY (CNPJ_FORNECEDORES) REFERENCES FORNECEDOR(CNPJ),
    CONSTRAINT FK_CODIGO_PROMOCAO FOREIGN KEY (CODIGO_PROMOCAO) REFERENCES PROMOCAO(CODIGO)
);

CREATE TABLE PEDIDO(
    NUMERO_PEDIDO VARCHAR2(20) NOT NULL PRIMARY KEY,
    PRECO FLOAT NOT NULL,
    NUMERO_TELEFONE_USUARIO VARCHAR2(11) NOT NULL,
    CNPJ_RESTAURANTE VARCHAR2(14) NOT NULL,
    CPF_ENTREGADOR VARCHAR2(11) NOT NULL,
    NOME_CODIGO_CUPOM VARCHAR2(20),
    CONSTRAINT FK_NUMERO_TELEFONE_USUARIO_PEDIDO FOREIGN KEY (NUMERO_TELEFONE_USUARIO) REFERENCES USUARIO(NUMERO_TELEFONE),
    CONSTRAINT FK_CNPJ_RESTAURANTE_PEDIDO FOREIGN KEY (CNPJ_RESTAURANTE) REFERENCES RESTAURANTE(CNPJ),
    CONSTRAINT FK_CPF_ENTREGADOR_PEDIDO FOREIGN KEY (CPF_ENTREGADOR) REFERENCES ENTREGADOR(CPF),
    CONSTRAINT FK_COD_CUPOM_PEDIDO FOREIGN KEY (NOME_CODIGO_CUPOM) REFERENCES CUPOM(NOME_CODIGO)
);
