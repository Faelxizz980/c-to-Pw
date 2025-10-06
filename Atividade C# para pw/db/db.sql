DROP DATABASE if EXISTS Banco;
CREATE DATABASE if NOT EXISTS Banco;
Use Banco;


CREATE TABLE if not exists cliente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(255),
    senha VARCHAR(255),
    telefone BIGINT,
    endereco VARCHAR(255)
);

-- Tabela pessoa física
CREATE TABLE if not exists p_fisica (
    cpf BIGINT PRIMARY KEY,
    nome VARCHAR(255),
    data_nasc DATE,
    sexo ENUM('Masculino', 'Feminino', 'Outros'),
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id)
);

-- Tabela pessoa jurídica
CREATE TABLE if not exists p_juridica (
    cnpj BIGINT PRIMARY KEY,
    razao_social VARCHAR(255),
    nome_fantasia VARCHAR(255),
    fundacao DATE,
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id)
);

-- Tabela conta
CREATE TABLE if not exists conta (
    numero INT UNSIGNED PRIMARY KEY,
    tipo_conta ENUM('CC', 'CP'),
    saldo FLOAT,
    cliente INT UNSIGNED,
    FOREIGN KEY (cliente) REFERENCES cliente(id)
);

-- Tabela transacoes
CREATE TABLE if not exists transacoes (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('Saque', 'Deposito', 'Transferencia'),
    valor FLOAT,
    data DATETIME,
    descricao VARCHAR(255),
    conta_num INT UNSIGNED,
    FOREIGN KEY (conta_num) REFERENCES conta(numero)
);
----------------------Criação Procedures------------------------------------------

CREATE PROCEDURE  p_consultaCliente ()
Begin
    SELECT * FROM cliente;
END;

CREATE PROCEDURE p_consultarClienteByID (IN clienteID int)
Begin
    SELECT * FROM cliente WHERE id = clienteID;
END;

CREATE PROCEDURE p_consultarConta ()
Begin
    SELECT * FROM conta;
END;

CREATE PROCEDURE p_consultarContaByID(IN ContaNum INT)
Begin
    SELECT * FROM conta where numero = ContaNum;
END;

CREATE PROCEDURE p_consultarPFisica()
Begin
    SELECT * FROM p_fisica;
End;

CREATE PROCEDURE p_consultarPFisicaByCPF (IN cpf BIGINT)
begin
    SELECT * FROM p_fisica WHERE cpf = cpf;
END;

CREATE PROCEDURE p_consultarPJuridica()
Begin
    SELECT * FROM p_juridica;
END;

CREATE PROCEDURE p_consultarPJuridicaByCNPJ(IN Cnpj BIGINT)
begin
    SELECT * FROM p_juridica where cnpj = Cnpj;
END;

CREATE PROCEDURE p_consultarTransacoes()
begin
    SELECT * FROM transacoes;
END;

CREATE PROCEDURE p_consultarTransacoesByID (IN TransacoesID INT )
begin
    SELECT * FROM transacoes WHERE id = TransacoesID;
END;
---------- procedure de inserção de dados -------------------------------------------

CREATE procedure cadastrarCliente (
    IN _usuario VARCHAR(255),
    IN _senha VARCHAR(255),
    IN _telefone BIGINT,
    IN _endereco VARCHAR(255)
)
Begin
