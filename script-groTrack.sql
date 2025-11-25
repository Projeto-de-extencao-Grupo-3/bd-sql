USE grotrack;
CREATE TABLE oficinas (
  id_oficina INT PRIMARY KEY,
  razao_social VARCHAR(45),
  cnpj CHAR(13),
  dt_cadastro DATETIME,
  status TINYINT(1),
  email VARCHAR(45)
);

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

CREATE TABLE veiculos (
  id_veiculo INT PRIMARY KEY,
  placa VARCHAR(10),
  marca VARCHAR(10),
  modelo VARCHAR(45),
  ano_modelo INT,
  ano_fabricacao INT,
  renavam VARCHAR(45),
  fk_proprietario INT,
  FOREIGN KEY (fk_proprietario) REFERENCES clientes(id_cliente)
);

CREATE TABLE registroEntrada (
  id_registro_entrada INT PRIMARY KEY,
  data_entrada_prevista DATE,
  data_entrada_efetiva DATE,
  tipo_servico VARCHAR(45),
  CPF CHAR(11),
  marca VARCHAR(45),
  modelo VARCHAR(45),
  chave_rodas TINYINT,
  chave_geral TINYINT,
  km INT,
  motorista INT,
  fk_veiculo INT,
  FOREIGN KEY (fk_veiculo) REFERENCES veiculos(id_veiculo)
);

CREATE TABLE ordensDeServicos (
  id_ordem_servico INT PRIMARY KEY,
  valor_total DECIMAL(10,2),
  dt_saida_prevista DATE,
  dt_saida_efetiva DATE,
  status VARCHAR(45),
  seguradora TINYINT,
  nf_realizada TINYINT,
  preco_realizado TINYINT,
  fk_entrada INT,
  FOREIGN KEY (fk_entrada) REFERENCES registroEntrada(id_registro_entrada)
);

CREATE TABLE servicos (
  id_servico INT PRIMARY KEY,
  nome VARCHAR(255),
  tipo_servico VARCHAR(45),
  tempo_base INT,
  ativo TINYINT
);

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

CREATE TABLE produtos (
  id_peca INT PRIMARY KEY,
  nome VARCHAR(45),
  fornecedor_nf VARCHAR(100),
  preco_compra DECIMAL(10,2),
  preco_venda DECIMAL(10,2),
  quantidade_estoque INT,
  visivel_orcamento TINYINT
);

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
