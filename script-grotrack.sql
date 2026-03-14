DROP DATABASE IF EXISTS grotrack;
CREATE DATABASE IF NOT EXISTS grotrack CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE grotrack;

CREATE TABLE oficinas (
    id_oficina INT NOT NULL AUTO_INCREMENT,
    razao_social VARCHAR(45) NOT NULL,
    cnpj CHAR(14),
    data_criacao DATETIME NOT NULL,
    status TINYINT(1) DEFAULT 1,
    email VARCHAR(45),
    PRIMARY KEY (id_oficina)
);

CREATE TABLE enderecos (
    id_endereco INT NOT NULL AUTO_INCREMENT,
    cep CHAR(9) NOT NULL,
    logradouro VARCHAR(100) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(40),
    cidade VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_endereco)
);

CREATE TABLE funcionarios (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(50) NOT NULL,
    cargo VARCHAR(45),
    especialidade VARCHAR(100),
    telefone VARCHAR(11),
    fk_oficina INT NOT NULL,
    email VARCHAR(60) NULL,
    senha VARCHAR(255) NULL,
    PRIMARY KEY (id_funcionario),
    FOREIGN KEY (fk_oficina) REFERENCES oficinas (id_oficina)
);

CREATE TABLE clientes (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf_cnpj VARCHAR(14) NOT NULL,
    telefone VARCHAR(11),
    email VARCHAR(255),
    tipo_cliente VARCHAR(45),
    fk_endereco INT NOT NULL,
    fk_oficina INT NOT NULL,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (fk_endereco) REFERENCES enderecos (id_endereco),
    FOREIGN KEY (fk_oficina) REFERENCES oficinas (id_oficina)
);

CREATE TABLE veiculos (
    id_veiculo INT NOT NULL AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL,
    modelo VARCHAR(45),
    ano_modelo INT,
    ano_fabricacao INT,
    prefixo VARCHAR(45),
    fk_proprietario INT NOT NULL,
    PRIMARY KEY (id_veiculo),
    FOREIGN KEY (fk_proprietario) REFERENCES clientes (id_cliente)
);

CREATE TABLE registro_entrada (
    id_registro_entrada INT NOT NULL AUTO_INCREMENT,
    data_entrada_prevista DATE,
    data_entrada_efetiva DATE,
    responsavel VARCHAR(45),
    cpf CHAR(11),
    extintor TINYINT(1), 
    macaco TINYINT(1), 
    chave_roda TINYINT(1), 
    geladeira TINYINT(1), 
    monitor TINYINT(1), 
    estepe TINYINT(1), 
    som_dvd TINYINT(1), 
    caixa_ferramentas TINYINT(1), 
    fk_veiculo INT NOT NULL,
    PRIMARY KEY (id_registro_entrada),
    FOREIGN KEY (fk_veiculo) REFERENCES veiculos (id_veiculo)
);

CREATE TABLE ordem_de_servicos (
    id_ordem_servico INT NOT NULL AUTO_INCREMENT,
    valor_total DECIMAL(10,2),
    data_saida_prevista DATE,
    data_saida_efetiva DATE,
    status VARCHAR(45),
    seguradora TINYINT(1) DEFAULT 0,
    nf_realizada TINYINT(1) DEFAULT 0,
    pagt_realizado TINYINT(1) DEFAULT 0,
    fk_entrada INT NOT NULL,
    ativo TINYINT DEFAULT 1,
    PRIMARY KEY (id_ordem_servico),
    FOREIGN KEY (fk_entrada) REFERENCES registro_entrada (id_registro_entrada)
);

CREATE TABLE produtos (
    id_produto INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fornecedor_nf VARCHAR(45),
    preco_compra DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    quantidade_estoque INT,
    visivel_orcamento TINYINT(1) DEFAULT 1,
    tipo_servico VARCHAR(45),
    PRIMARY KEY (id_produto)
);

CREATE TABLE itens_servicos (
	id_registro_servico INT AUTO_INCREMENT,
    fk_ordem_servico INT NOT NULL,
    preco_cobrado DECIMAL(10,4),
    parte_veiculo VARCHAR(45),
    lado_veiculo VARCHAR(45),
	tipo_servico varchar(45),
    cor VARCHAR(45),
    especificacao_servico VARCHAR(100),
    observacoes_item VARCHAR(45),
    PRIMARY KEY (id_registro_servico, fk_ordem_servico),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_de_servicos (id_ordem_servico)
);

CREATE TABLE funcionarios_servico (
    fk_funcionario INT NOT NULL,
    fk_servico INT NOT NULL,
    fk_ordem_servico INT NOT NULL,
    PRIMARY KEY (fk_funcionario, fk_servico, fk_ordem_servico),
    FOREIGN KEY (fk_funcionario) REFERENCES funcionarios (id_funcionario),
    FOREIGN KEY (fk_servico) REFERENCES itens_servicos (id_registro_servico),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_de_servicos (id_ordem_servico)
);


CREATE TABLE itens_produtos (
	id_registro_peca INT AUTO_INCREMENT,
    fk_lista_pecas INT NOT NULL,
    fk_ordem_servico INT NOT NULL,
    fk_produto INT NOT NULL,
    quantidade INT,
    preco_peca DECIMAL(10,2),
    baixado TINYINT(1) DEFAULT 0,
    PRIMARY KEY (id_registro_peca, fk_lista_pecas, fk_ordem_servico, fk_produto),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_de_servicos (id_ordem_servico),
    FOREIGN KEY (fk_produto) REFERENCES produtos (id_produto)
);

-- ========================================
-- Table: enderecos (no dependencies)
-- ========================================
INSERT INTO `enderecos` VALUES (1,'01001-000','Praça da Sé',45,'Apto 101','Centro','São Paulo','SP'),(2,'70070-000','Eixo Monumental',100,'Torre B','Asa Sul','Brasília','DF');

-- ========================================
-- Table: oficinas (no dependencies)
-- ========================================
INSERT INTO `oficinas` VALUES (1,'GRO Track','14820390000150','2026-01-16 16:27:41',1,'geosmar@grotrack.com');

-- ========================================
-- Table: clientes (depends on: enderecos, oficinas)
-- ========================================
INSERT INTO `clientes` VALUES (1,'Ana Paula Martins','12345678909','11987654321','ana.martins@example.com','PESSOA_FISICA',1,1),(2,'Bruno Henrique Souza','98765432100','11991234567','bruno.souza@example.com','PESSOA_FISICA',2,1);

-- ========================================
-- Table: veifculos (depends on: clientes)
-- ========================================
INSERT INTO `veiculos` VALUES (1,'FRO1C23','Apache Vip V',2024,2024,'A',1),(2,'TUR7E89','Paradiso G8 1800 DD',2022,2022,'B',2);

-- ========================================
-- Table: funcionarios (depends on: oficinas)
-- ========================================
INSERT INTO `funcionarios` VALUES (1,'Geosmar','Chefe de Produção','Sistemas de Freios e Transmissão','31999988888',1, 'geosmar@grotrack.com.br', "$2a$10$jK9yW8hs15vmta/TyTRTZOAlXi8UGn0KQYtzqI5WY0WL7ek8RU0xu"),(2,'Anne Kelly','Administradora','Elétrica e Eletrônica de Ônibus','31988887777',1, 'anne@grotrack.com.br', "$2a$10$jK9yW8hs15vmta/TyTRTZOAlXi8UGn0KQYtzqI5WY0WL7ek8RU0xu");

-- ========================================
-- Table: registro_entrada (depends on: veiculos)
-- ========================================
INSERT INTO `registro_entrada` VALUES (1,'2025-10-25','2025-10-25','Carlos Souza','98765432109',1,1,1,0,0,1,0,1,1),(2,'2025-10-20','2025-10-21','Mariana Alves','12345678909',1,1,1,1,1,1,1,0,2);

-- ========================================
-- Table: ordem_de_servicos (depends on: registro_entrada)
-- ========================================
INSERT INTO `ordem_de_servicos` VALUES (1,1850,'2025-10-28',NULL,'EM_PRODUCAO',0,0,0,1,1),(2,4500,'2025-10-27','2025-10-27','FINALIZADO',1,1,1,2,1);

-- ========================================
-- Table: produtos (no dependencies)
-- ========================================
INSERT INTO `produtos` VALUES 
    (1,'Filtro de óleo','NF-987654',120.5,180,45,1, "MECANICA"),
    (2,'Pastilha de freio','NF-123456',90,150,60,1, "MECANICA"),
    (3,'Bateria 150Ah','NF-555222',400,650,20,1, "MECANICA"),
    (4,'Amortecedor traseiro','NF-998877',250,390,30,1, "MECANICA"),
    (5,'Correia dentada','NF-441122',70,120,50,1, "MECANICA");

-- ========================================
-- Table: itens_servicos (depends on: ordem_de_servicos, servicos)
-- ========================================
INSERT INTO `itens_servicos`(fk_ordem_servico, preco_cobrado, parte_veiculo, lado_veiculo, tipo_servico, cor, especificacao_servico, observacoes_item) VALUES 
(1,350,'PARACHOQUE','DIANTEIRO','FUNILARIA','Vermelho','Reparo no parachoque dianteiro após colisão leve','Necessário retoque de pintura'),
(1,420,'SAIA','DIREITO','FUNILARIA','Vermelho','Repintura completa da lateral direita devido a riscos','Usar tinta metálica original');

-- ========================================
-- Table: itens_produtos (depends on: ordem_de_servicos, produtos)
-- ========================================
INSERT INTO `itens_produtos` VALUES (1,1,1,1,2,180,0),(2,2,1,2,4,150,0);

-- ========================================
-- VIEWS: KPIs Analise Financeira
-- ========================================

-- QUANTIDADE DE NOTAS FISCAIS PENDENTES
CREATE OR REPLACE VIEW vw_kpi_nfs_pendentes AS
SELECT 
	ofic.id_oficina,
    COUNT(nf_realizada) as quantidade_nfs_pendentes
FROM ordem_de_servicos AS os
JOIN registro_entrada AS ent ON os.fk_entrada = ent.id_registro_entrada
JOIN veiculos AS v ON ent.fk_veiculo = v.id_veiculo
JOIN clientes AS c ON v.fk_proprietario = c.id_cliente
JOIN oficinas AS ofic ON c.fk_oficina = ofic.id_oficina
WHERE nf_realizada = 0 AND pagt_realizado = 1 AND os.status = 'FINALIZADO'
GROUP BY ofic.id_oficina;

-- VALOR E QUANTIDADE DE SERVIÇOS NÃO PAGOS
CREATE OR REPLACE VIEW vw_kpi_servicos_nao_pagos AS
SELECT 
    ofic.id_oficina,
    -- Soma o total de todas as O.S. não pagas daquela oficina
    SUM(
        COALESCE((SELECT SUM(its.preco_cobrado) FROM itens_servicos its WHERE its.fk_ordem_servico = os.id_ordem_servico), 0) +
        COALESCE((SELECT SUM(itp.preco_peca * itp.quantidade) FROM itens_produtos itp WHERE itp.fk_ordem_servico = os.id_ordem_servico), 0)
    ) AS total_valor_nao_pago,
    -- Conta quantas ordens de serviço estão com pagt_realizado = 0
    COUNT(os.id_ordem_servico) AS quantidade_servicos_nao_pagos
FROM ordem_de_servicos AS os
JOIN registro_entrada AS ent ON os.fk_entrada = ent.id_registro_entrada
JOIN veiculos AS v ON ent.fk_veiculo = v.id_veiculo
JOIN clientes AS c ON v.fk_proprietario = c.id_cliente
JOIN oficinas AS ofic ON c.fk_oficina = ofic.id_oficina
WHERE os.pagt_realizado = 0 AND os.status = 'FINALIZADO'
GROUP BY ofic.id_oficina;

-- QUANTIDADE DE PAGAMENTOS REALIZADOS
CREATE OR REPLACE VIEW vw_kpi_pgtos_realizados AS
SELECT 
    ofic.id_oficina,
    COUNT(pagt_realizado) AS total_pagamentos_realizados
FROM ordem_de_servicos as os
JOIN registro_entrada as ent
ON os.fk_entrada = ent.id_registro_entrada
JOIN veiculos as v
ON ent.fk_veiculo = v.id_veiculo
JOIN clientes as c
ON v.fk_proprietario = c.id_cliente
JOIN oficinas as ofic 
ON c.fk_oficina = ofic.id_oficina
WHERE os.pagt_realizado = 1 AND os.status = 'FINALIZADO'
GROUP BY id_ordem_servico;

-- usuário administrador com acesso remoto (todas as tabelas)
CREATE USER IF NOT EXISTS 'admin'@'%' IDENTIFIED BY 'sua_senha_segura';
GRANT ALL PRIVILEGES ON grotrack.* TO 'admin'@'%';
FLUSH PRIVILEGES;


CREATE TABLE IF NOT EXISTS arquivos (
  id_arquivo INT NOT NULL auto_increment,
  nome VARCHAR(255) NULL,
  formato VARCHAR(45) NULL,
  template VARCHAR(45) NOT NULL,
  status VARCHAR(45) NOT NULL,
  url VARCHAR(255) NULL,
  data_criacao DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  data_atualizacao DATETIME NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  fk_ordem_servico INT NOT NULL,
  PRIMARY KEY (id_arquivo)
);

CREATE TABLE IF NOT EXISTS metadados (
  id_metadado INT NOT NULL auto_increment,
  chave VARCHAR(255) NULL,
  valor VARCHAR(255) NULL,
  fk_arquivo INT NOT NULL,
  PRIMARY KEY (id_metadado),
  FOREIGN KEY (fk_arquivo) REFERENCES arquivos(id_arquivo)
);