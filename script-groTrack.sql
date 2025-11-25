create database grotrack;
use grotrack;

-- Tabela: oficinas
CREATE TABLE oficinas (
  id_oficina INT PRIMARY KEY,
  razao_social VARCHAR(45),
  cnpj CHAR(13),
  dt_criacao DATETIME,
  status TINYINT(1),
  email VARCHAR(45),
  senha VARCHAR(255)
);

-- Tabela: enderecos
CREATE TABLE enderecos (
  id_endereco INT PRIMARY KEY,
  cep CHAR(9),
  logradouro VARCHAR(60),
  numero VARCHAR(10),
  complemento VARCHAR(45),
  bairro VARCHAR(45),
  cidade VARCHAR(45),
  estado VARCHAR(45)
);

-- Tabela: clientes
CREATE TABLE clientes (
  id_cliente INT PRIMARY KEY,
  nome VARCHAR(45),
  cpf_cnpj VARCHAR(45),
  telefone VARCHAR(11),
  email VARCHAR(255),
  tipoCliente VARCHAR(45),
  fk_endereco INT,
  fk_empresa INT,
  FOREIGN KEY (fk_endereco) REFERENCES enderecos(id_endereco),
  FOREIGN KEY (fk_empresa) REFERENCES oficinas(id_oficina)
);

-- Tabela: veiculos
CREATE TABLE veiculos (
  id_veiculo INT PRIMARY KEY,
  placa VARCHAR(10),
  marca VARCHAR(10),
  modelo VARCHAR(45),
  ano_modelo INT,
  ano_fabricacao INT,
  prefixo VARCHAR(45),
  tipoProprietario INT
);

-- Tabela: registroEntrada
CREATE TABLE registroEntrada (
  id_registro_entrada INT PRIMARY KEY,
  data_entrada_prevista DATE,
  data_entrada_efetiva DATE,
  responsavel VARCHAR(11),
  extintor TINYINT,
  macaco TINYINT,
  chave_roda TINYINT,
  estepe TINYINT,
  monitor INT,
  fk_veiculo INT,
  FOREIGN KEY (fk_veiculo) REFERENCES veiculos(id_veiculo)
);

-- Tabela: ordensDeServicos
CREATE TABLE ordensDeServicos (
  id_ordem_servico INT PRIMARY KEY,
  valor_total DECIMAL(10,2),
  dt_saida_prevista DATE,
  dt_saida_efetiva DATE,
  status VARCHAR(45),
  seguradora TINYINT,
  nf_realizada TINYINT,
  pgto_realizado TINYINT,
  fk_entrada INT,
  FOREIGN KEY (fk_entrada) REFERENCES registroEntrada(id_registro_entrada)
);

-- Tabela: funcionarios
CREATE TABLE funcionarios (
  id_funcionario INT PRIMARY KEY,
  nome VARCHAR(45),
  cargo VARCHAR(45),
  especialidade VARCHAR(45),
  telefone VARCHAR(11),
  fk_empresa INT,
  email VARCHAR(255),
  FOREIGN KEY (fk_empresa) REFERENCES oficinas(id_oficina)
);

-- Tabela: funcionarios_ordem_servico
CREATE TABLE funcionarios_ordem_servico (
  fk_funcionario INT,
  fk_servico INT,
  fk_ordem_servico INT,
  FOREIGN KEY (fk_funcionario) REFERENCES funcionarios(id_funcionario),
  FOREIGN KEY (fk_servico) REFERENCES servicos(id_servico),
  FOREIGN KEY (fk_ordem_servico) REFERENCES ordensDeServicos(id_ordem_servico)
);

-- Tabela: servicos
CREATE TABLE servicos (
  id_servico INT PRIMARY KEY,
  nome VARCHAR(255),
  tipo_servico VARCHAR(45),
  tempo_base INT,
  ativo TINYINT
);

-- Tabela: itensServicos
CREATE TABLE itensServicos (
  id_servico INT PRIMARY KEY,
  fk_ordem_servico INT,
  fk_servico INT,
  preco_cobrado DECIMAL(10,4),
  parte_veiculo VARCHAR(45),
  lado_veiculo VARCHAR(45),
  cor VARCHAR(45),
  especificacao_servico VARCHAR(45),
  observacoes_item VARCHAR(45),
  FOREIGN KEY (fk_ordem_servico) REFERENCES ordensDeServicos(id_ordem_servico),
  FOREIGN KEY (fk_servico) REFERENCES servicos(id_servico)
);

-- Tabela: produtos
CREATE TABLE produtos (
  id_peca INT PRIMARY KEY,
  nome VARCHAR(45),
  fornecedor_id VARCHAR(100),
  preco_compra DECIMAL(10,2),
  preco_venda DECIMAL(10,2),
  quantidade_estoque INT,
  visivel_orcamento TINYINT
);

-- Tabela: itensProdutos
CREATE TABLE itensProdutos (
  id_lista_pecas INT PRIMARY KEY,
  fk_ordem_servico INT,
  fk_peca INT,
  quantidade INT,
  preco_peca DECIMAL(10,2),
  baixado TINYINT,
  FOREIGN KEY (fk_ordem_servico) REFERENCES ordensDeServicos(id_ordem_servico),
  FOREIGN KEY (fk_peca) REFERENCES produtos(id_peca)
);
