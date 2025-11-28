CREATE DATABASE IF NOT EXISTS grotrack;
USE grotrack;

CREATE TABLE oficinas (
    id_oficina INT NOT NULL,
    razao_social VARCHAR(45) NOT NULL,
    cnpj CHAR(14),
    dt_criacao DATETIME NOT NULL,
    status TINYINT(1) DEFAULT 1,
    email VARCHAR(45),
    senha VARCHAR(255),
    PRIMARY KEY (id_oficina)
);

CREATE TABLE enderecos (
    id_endereco INT NOT NULL,
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
    id_funcionario INT NOT NULL,
    nome VARCHAR(50) NOT NULL,
    cargo VARCHAR(45),
    especialidade VARCHAR(100),
    telefone VARCHAR(11),
    fk_oficina INT NOT NULL,
    PRIMARY KEY (id_funcionario),
    FOREIGN KEY (fk_oficina) REFERENCES oficinas (id_oficina)
);

CREATE TABLE clientes (
    id_cliente INT NOT NULL,
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
    id_veiculo INT NOT NULL,
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
    id_registro_entrada INT NOT NULL,
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
    id_ordem_servico INT NOT NULL,
    valor_total DECIMAL(10,2),
    dt_saida_prevista DATE,
    dt_saida_efetiva DATE,
    status VARCHAR(45),
    seguradora TINYINT(1) DEFAULT 0,
    nf_realizada TINYINT(1) DEFAULT 0,
    pagt_realizado TINYINT(1) DEFAULT 0,
    fk_entrada INT NOT NULL,
    PRIMARY KEY (id_ordem_servico),
    FOREIGN KEY (fk_entrada) REFERENCES registro_entrada (id_registro_entrada)
);

CREATE TABLE servicos (
    id_servico INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    tipo_servico VARCHAR(45),
    tempo_base INT,
    ativo TINYINT(1) DEFAULT 1,
    PRIMARY KEY (id_servico)
);

CREATE TABLE produtos (
    id_produto INT NOT NULL,
    nome VARCHAR(45) NOT NULL,
    fornecedor_nf VARCHAR(45),
    preco_compra DECIMAL(10,2),
    preco_venda DECIMAL(10,2),
    quantidade_estoque INT,
    viavel_orcamento TINYINT(1) DEFAULT 1,
    PRIMARY KEY (id_produto)
);

CREATE TABLE funcionario_servico (
    fk_funcionario INT NOT NULL,
    fk_servico INT NOT NULL,
    fk_ordem_servico INT NOT NULL,
    PRIMARY KEY (fk_funcionario, fk_servico, fk_ordem_servico),
    FOREIGN KEY (fk_funcionario) REFERENCES funcionarios (id_funcionario),
    FOREIGN KEY (fk_servico) REFERENCES servicos (id_servico),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_de_servicos (id_ordem_servico)
);

CREATE TABLE itens_servicos (
    fk_ordem_servico INT NOT NULL,
    fk_servico INT NOT NULL,
    preco_cobrado DECIMAL(10,4),
    parte_veiculo VARCHAR(45),
    lado_veiculo VARCHAR(45),
    cor VARCHAR(45),
    especificacao_servico VARCHAR(100),
    observacoes_item VARCHAR(45),
    PRIMARY KEY (fk_ordem_servico, fk_servico),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_de_servicos (id_ordem_servico),
    FOREIGN KEY (fk_servico) REFERENCES servicos (id_servico)
);

CREATE TABLE itens_produtos (
    fk_lista_pecas INT NOT NULL,
    fk_ordem_servico INT NOT NULL,
    fk_peca INT NOT NULL,
    quantidade INT,
    preco_peca DECIMAL(10,2),
    baixado TINYINT(1) DEFAULT 0,
    PRIMARY KEY (fk_lista_pecas, fk_ordem_servico, fk_peca),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordem_de_servicos (id_ordem_servico),
    FOREIGN KEY (fk_peca) REFERENCES produtos (id_produto)
);

INSERT INTO oficinas (id_oficina, razao_social, cnpj, dt_criacao, status, email, senha)
VALUES 
(1, 'GRO Track', '14820390000150', NOW() , 1, 'geosmar@grotrack.com',
'$2a$10$jK9yW8hs15vmta/TyTRTZOAlXi8UGn0KQYtzqI5WY0WL7ek8RU0xu');

INSERT INTO enderecos (id_endereco, cep, logradouro, numero, complemento, bairro, cidade, estado)
VALUES
(1, '01001-000', 'Praça da Sé', '45', 'Apto 101', 'Centro', 'São Paulo', 'SP'),
(2, '70070-000', 'Eixo Monumental', '100', 'Torre B', 'Asa Sul', 'Brasília', 'DF');

INSERT INTO clientes (id_cliente, nome, cpf_cnpj, telefone, email, tipo_cliente, fk_endereco, fk_oficina)
VALUES
(1, 'Ana Paula Martins', '12345678909', '11987654321', 'ana.martins@example.com', 'PESSOA_FISICA', 1, 1),
(2, 'Bruno Henrique Souza', '98765432100', '11991234567', 'bruno.souza@example.com', 'PESSOA_FISICA', 2, 1);

INSERT INTO funcionarios (id_funcionario, nome, cargo, especialidade, telefone, fk_oficina)
VALUES
(1, 'Diego Rafael Lima', 'Mecânico Chefe', 'Sistemas de Freios e Transmissão', '31999988888', 1),
(2, 'Luiz Fernando Rocha', 'Eletricista de Veículos', 'Elétrica e Eletrônica de Ônibus', '31988887777', 1);

INSERT INTO veiculos (id_veiculo, placa, modelo, ano_modelo, ano_fabricacao, prefixo, fk_proprietario)
VALUES
(1, 'FRO1C23', 'Apache Vip V', 2024, 2024, 'A', 1),
(2, 'TUR7E89', 'Paradiso G8 1800 DD', 2022, 2022, 'B', 2);

INSERT INTO registro_entrada
(id_registro_entrada, data_entrada_prevista, data_entrada_efetiva, responsavel, cpf, extintor, macaco, chave_roda, geladeira, monitor, estepe, som_dvd, caixa_ferramentas, fk_veiculo)
VALUES
(1, '2025-10-25', '2025-10-25', 'Carlos Souza', '98765432109', 1, 1, 1, 0, 0, 1, 0, 1, 1),
(2, '2025-10-20', '2025-10-21', 'Mariana Alves', '12345678909', 1, 1, 1, 1, 1, 1, 1, 0, 2);

INSERT INTO ordem_de_servicos
(id_ordem_servico, valor_total, dt_saida_prevista, dt_saida_efetiva, status, seguradora, nf_realizada, pagt_realizado, fk_entrada)
VALUES
(1, 1850.00, '2025-10-28', NULL, 'EM_PROGRESSO', 0, 0, 0, 1),
(2, 4500.00, '2025-10-27', '2025-10-27', 'CONCLUIDA', 1, 1, 1, 2);

INSERT INTO servicos (id_servico, nome, tipo_servico, tempo_base, ativo)
VALUES
(1, 'Troca de óleo e filtro', '3', 60, 1),
(2, 'Revisão do sistema de freios', '3', 120, 1),
(3, 'Reparo em parachoque dianteiro', '1', 180, 1),
(4, 'Repintura completa da lateral direita', '2', 240, 1);

INSERT INTO produtos
(id_produto, nome, fornecedor_nf, preco_compra, preco_venda, quantidade_estoque, viavel_orcamento)
VALUES
(1, 'Filtro de óleo', 'NF-987654', 120.50, 180.00, 45, 1),
(2, 'Pastilha de freio', 'NF-123456', 90.00, 150.00, 60, 1),
(3, 'Bateria 150Ah', 'NF-555222', 400.00, 650.00, 20, 1),
(4, 'Amortecedor traseiro', 'NF-998877', 250.00, 390.00, 30, 1),
(5, 'Correia dentada', 'NF-441122', 70.00, 120.00, 50, 1);

INSERT INTO itens_produtos
(fk_lista_pecas, fk_ordem_servico, fk_peca, quantidade, preco_peca, baixado)
VALUES
(1, 1, 1, 2, 180.00, 0),
(2, 1, 2, 4, 150.00, 0);

INSERT INTO itens_servicos
(fk_ordem_servico, fk_servico, preco_cobrado, parte_veiculo, lado_veiculo,
cor, especificacao_servico, observacoes_item)
VALUES
(1, 3, 350.00, '1', '1', 'Vermelho',
'Reparo no parachoque dianteiro após colisão leve', 'Necessário retoque de pintura'),
(1, 4, 420.00, '3', '4', 'Vermelho',
'Repintura completa da lateral direita devido a riscos', 'Usar tinta metálica original');