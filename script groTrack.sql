-- ----------------------------------------------------------------------
-- CRIAÇÃO DO BANCO DE DADOS E USO
-- ----------------------------------------------------------------------
DROP DATABASE IF EXISTS gro_track;
CREATE DATABASE gro_track;
USE gro_track;

-- ----------------------------------------------------------------------
-- 1. Tabela OFICINAS
-- ----------------------------------------------------------------------
CREATE TABLE oficinas (
    id_oficina INT NOT NULL AUTO_INCREMENT,
    razao_social VARCHAR(45) NOT NULL,
    cnpj CHAR(13) NOT NULL UNIQUE, -- CNPJ no formato simplificado (sem pontuação)
    dt_criacao DATETIME NOT NULL,
    status TINYINT NOT NULL, -- 1 (Ativa), 0 (Inativa)
    email VARCHAR(45),
    PRIMARY KEY (id_oficina)
);

-- ----------------------------------------------------------------------
-- 2. Tabela ENDERECOS
-- ----------------------------------------------------------------------
CREATE TABLE enderecos (
    id_endereco INT NOT NULL AUTO_INCREMENT,
    cep CHAR(9) NOT NULL, -- CEP no formato 99999-999
    logradouro VARCHAR(60) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(45),
    bairro VARCHAR(45) NOT NULL,
    cidade VARCHAR(45) NOT NULL,
    estado VARCHAR(45) NOT NULL,
    PRIMARY KEY (id_endereco)
);

-- ----------------------------------------------------------------------
-- 3. Tabela CLIENTES
-- ----------------------------------------------------------------------
CREATE TABLE clientes (
    id_cliente INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cpf_cnpj VARCHAR(14) NOT NULL UNIQUE,
    telefone VARCHAR(11) NOT NULL,
    email VARCHAR(255),
    fk_empresa INT,
    fk_endereco INT,
    PRIMARY KEY (id_cliente),
    FOREIGN KEY (fk_endereco) REFERENCES enderecos (id_endereco),
    FOREIGN KEY (fk_empresa) REFERENCES oficinas (id_oficina)
);

-- ----------------------------------------------------------------------
-- 4. Tabela VEICULOS
-- ----------------------------------------------------------------------
CREATE TABLE veiculos (
    id_veiculo INT NOT NULL AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    marca VARCHAR(10) NOT NULL,
    modelo VARCHAR(45) NOT NULL,
    ano_modelo INT,
    ano_fabricacao INT,
    cor VARCHAR(45),
    fk_proprietario INT NOT NULL,
    PRIMARY KEY (id_veiculo),
    FOREIGN KEY (fk_proprietario) REFERENCES clientes (id_cliente)
);

-- ----------------------------------------------------------------------
-- 5. Tabela ORDENSDESERVICOS (Novos campos: seguradora e pago)
-- ----------------------------------------------------------------------
CREATE TABLE ordensDeServicos (
    id_ordem_servico INT NOT NULL AUTO_INCREMENT,
    dt_entrada_efetiva DATE NOT NULL,
    dt_entrada_agendada DATE,
    dt_saida_prevista DATE,
    dt_saida_efetiva DATE,
    status VARCHAR(45) NOT NULL,
    valor_total DECIMAL(10,2),
    seguradora TINYINT, -- 1 (Sim), 0 (Não). Para saber se envolveu seguradora.
    pago TINYINT, -- 1 (Sim), 0 (Não). Para controle financeiro.
    fk_cliente INT NOT NULL,
    fk_veiculo INT NOT NULL,
    PRIMARY KEY (id_ordem_servico),
    FOREIGN KEY (fk_cliente) REFERENCES clientes (id_cliente),
    FOREIGN KEY (fk_veiculo) REFERENCES veiculos (id_veiculo)
);

-- ----------------------------------------------------------------------
-- 6. Tabela PRODUTOS (Alterados: preco_compra, preco_venda, fornecedor_ref)
-- ----------------------------------------------------------------------
CREATE TABLE produtos (
    id_peca INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    fornecedor_ref VARCHAR(100),
    preco_compra DECIMAL(10,2) NOT NULL,
    preco_venda DECIMAL(10,2) NOT NULL,
    quantidade_estoque INT NOT NULL,
    PRIMARY KEY (id_peca)
);

-- ----------------------------------------------------------------------
-- 7. Tabela ITENSPRODUTOS
-- ----------------------------------------------------------------------
CREATE TABLE itensProdutos (
    id_itens_produto INT NOT NULL AUTO_INCREMENT,
    fk_ordem_servico INT NOT NULL,
    fk_peca INT NOT NULL,
    quantidade INT NOT NULL,
    desconto DECIMAL(5,2),
    preco_peca DECIMAL(10,4) NOT NULL, -- Preço cobrado pela peça (após desconto)
    PRIMARY KEY (id_itens_produto),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordensDeServicos (id_ordem_servico),
    FOREIGN KEY (fk_peca) REFERENCES produtos (id_peca)
);

-- ----------------------------------------------------------------------
-- 8. Tabela SERVICOS (Catálogo de Serviços)
-- ----------------------------------------------------------------------
CREATE TABLE servicos (
    id_servico INT NOT NULL AUTO_INCREMENT,
    tipo_servico VARCHAR(45) NOT NULL, -- Ex: 'Mecânica', 'Pintura', 'Funilaria'
    descricao VARCHAR(255),
    tempo_base INT, -- Tempo médio em minutos/horas para o serviço
    ativo TINYINT NOT NULL, -- 1 (Ativo), 0 (Inativo)
    PRIMARY KEY (id_servico)
);

-- ----------------------------------------------------------------------
-- 9. Tabela ITENSSERVICOS (Alterado: preco_cobrado DECIMAL(10,4), desconto removido)
-- ----------------------------------------------------------------------
CREATE TABLE itensServicos (
    id_item_servico INT NOT NULL AUTO_INCREMENT,
    fk_ordem_servico INT NOT NULL,
    fk_servico INT NOT NULL,
    preco_cobrado DECIMAL(10,4) NOT NULL, -- Preço final da mão de obra cobrado
    parte_veiculo VARCHAR(45),
    lado_veiculo VARCHAR(45),
    cor VARCHAR(45),
    especificacao_servico VARCHAR(255),
    observacoes_item VARCHAR(255),
    PRIMARY KEY (id_item_servico),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordensDeServicos (id_ordem_servico),
    FOREIGN KEY (fk_servico) REFERENCES servicos (id_servico)
);

-- ----------------------------------------------------------------------
-- 10. Tabela FUNCIONARIOS
-- ----------------------------------------------------------------------
CREATE TABLE funcionarios (
    id_funcionario INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(45) NOT NULL,
    cargo VARCHAR(45) NOT NULL,
    especialidade VARCHAR(45),
    telefone VARCHAR(11),
    fk_empresa INT NOT NULL,
    senha VARCHAR(45) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    PRIMARY KEY (id_funcionario),
    FOREIGN KEY (fk_empresa) REFERENCES oficinas (id_oficina)
);

-- ----------------------------------------------------------------------
-- 11. Tabela FUNCIONARIO_SERVICO (Relacionamento N:N de identificação)
-- ----------------------------------------------------------------------
CREATE TABLE funcionario_servico (
    fk_funcionario INT NOT NULL,
    fk_servico INT NOT NULL, -- Serviço que o funcionário pode executar
    fk_ordem_servico INT NOT NULL, -- OS a qual o serviço foi designado
    PRIMARY KEY (fk_funcionario, fk_servico, fk_ordem_servico), -- Chave Primária Composta
    FOREIGN KEY (fk_funcionario) REFERENCES funcionarios (id_funcionario),
    FOREIGN KEY (fk_servico) REFERENCES servicos (id_servico),
    FOREIGN KEY (fk_ordem_servico) REFERENCES ordensDeServicos (id_ordem_servico)
);