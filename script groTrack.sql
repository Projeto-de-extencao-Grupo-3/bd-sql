CREATE DATABASE groTrack;
USE groTrack;

CREATE TABLE enderecos (
    idEndereco INT AUTO_INCREMENT PRIMARY KEY,
    cep CHAR(9),
    logradouro VARCHAR(60),
    numero VARCHAR(10),
    complemento VARCHAR(45),
    bairro VARCHAR(45),
    cidade VARCHAR(45),
    estado VARCHAR(45),
    fkOficina INT
);

CREATE TABLE empresas (
    idEmpresa INT AUTO_INCREMENT PRIMARY KEY,
    razaoSocial VARCHAR(45),
    cnpj CHAR(14),
    dtrCriacao DATETIME,
    status TINYINT(1),
    email VARCHAR(45),
    fkEndereco INT,
    FOREIGN KEY (fkEndereco) REFERENCES enderecos(idEndereco)
);

CREATE TABLE funcionarios (
    idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    cargo VARCHAR(45),
    especialidade VARCHAR(45),
    telefone VARCHAR(11),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa)
);

CREATE TABLE clientes (
    idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    cpfCnpj VARCHAR(45),
    telefone VARCHAR(11),
    email VARCHAR(255),
    fkEmpresa INT,
    FOREIGN KEY (fkEmpresa) REFERENCES empresas(idEmpresa)
);

CREATE TABLE veiculos (
    idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
    placa VARCHAR(10),
    marca VARCHAR(10),
    modelo VARCHAR(10),
    anoModelo INT,
    anoFabricacao INT,
    cor VARCHAR(45),
    fkProprietario INT,
    FOREIGN KEY (fkProprietario) REFERENCES clientes(idCliente)
);

CREATE TABLE ordensDeServicos (
    idOs INT AUTO_INCREMENT PRIMARY KEY,
    dtEntrada DATE,
    dtSaidaPrevista DATE,
    dtSaidaEfetiva DATE,
    status VARCHAR(45),
    descricao_problema VARCHAR(400),
    valorTotal DECIMAL(10,2),
    fkVeiculo INT,
    FOREIGN KEY (fkVeiculo) REFERENCES veiculos(idVeiculo)
);

CREATE TABLE listaServicos (
    idServico INT AUTO_INCREMENT PRIMARY KEY,
    nomeServico VARCHAR(45),
    descricao VARCHAR(45),
    precoBase DECIMAL(10,2)
);

CREATE TABLE itensServicos (
    idServico INT,
    idOs INT,
    valorCobrado DECIMAL(10,2),
    PRIMARY KEY (idServico, idOs),
    FOREIGN KEY (idServico) REFERENCES listaServicos(idServico),
    FOREIGN KEY (idOs) REFERENCES ordensDeServicos(idOs)
);

CREATE TABLE listaPecas (
    idPeca INT AUTO_INCREMENT PRIMARY KEY,
    nomePeca VARCHAR(45),
    fabricante VARCHAR(45),
    precoUnitario DECIMAL(10,2),
    qtdEstoque INT
);

CREATE TABLE itensPecas (
    idListaPecas INT,
    idOs INT,
    quantidade INT,
    desconto INT,
    valorPecas DECIMAL(10,2),
    PRIMARY KEY (idListaPecas, idOs),
    FOREIGN KEY (idListaPecas) REFERENCES listaPecas(idPeca),
    FOREIGN KEY (idOs) REFERENCES ordensDeServicos(idOs)
);

CREATE TABLE etapasDeServicos (
    idEtapa INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(45),
    tempoMedioDias INT
);

CREATE TABLE etapaAtual (
    idEtapaAtual INT AUTO_INCREMENT PRIMARY KEY,
    fkOs INT,
    fkEtapa INT,
    status VARCHAR(45),
    dtInicio DATETIME,
    dtTermino DATETIME,
    fkServico INT,
    FOREIGN KEY (fkEtapa) REFERENCES etapasDeServicos(idEtapa),
    FOREIGN KEY (fkOs) REFERENCES ordensDeServicos(idOs),
    FOREIGN KEY (fkServico) REFERENCES listaServicos(idServico)
);

CREATE TABLE funcionariosEtapa (
    fkFuncionario INT,
    fkEtapa INT,
    PRIMARY KEY (fkFuncionario, fkEtapa),
    FOREIGN KEY (fkFuncionario) REFERENCES funcionarios(idFuncionario),
    FOREIGN KEY (fkEtapa) REFERENCES etapasDeServicos(idEtapa)
);
