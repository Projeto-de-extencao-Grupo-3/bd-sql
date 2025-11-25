-- 1. Oficinas
INSERT INTO oficinas (id_oficina, razao_social, cnpj, dt_criacao, status, email, senha)
VALUES (1, 'Oficina Mecânica São Paulo', '1234567890123', '2025-11-25 10:00:00', 1, 'contato@oficinasaopaulo.com', 'senha123');

-- 2. Endereços
INSERT INTO enderecos (id_endereco, cep, logradouro, numero, complemento, bairro, cidade, estado)
VALUES (1, '01001-000', 'Rua das Flores', '100', 'Sala 1', 'Centro', 'São Paulo', 'SP');

-- 3. Clientes
INSERT INTO clientes (id_cliente, nome, cpf_cnpj, telefone, email, tipoCliente, fk_endereco, fk_empresa)
VALUES (1, 'Carlos Silva', '12345678900', '11999999999', 'carlos.silva@email.com', 'Pessoa Física', 1, 1);

-- 4. Veículos
INSERT INTO veiculos (id_veiculo, placa, marca, modelo, ano_modelo, ano_fabricacao, prefixo, tipoProprietario)
VALUES (1, 'ABC1234', 'Toyota', 'Corolla', 2020, 2019, 'SP-001', 1);

-- 5. Funcionários
INSERT INTO funcionarios (id_funcionario, nome, cargo, especialidade, telefone, fk_empresa, email)
VALUES (1, 'João Pereira', 'Mecânico', 'Motor', '11988887777', 1, 'joao.pereira@oficinasaopaulo.com');

-- 6. Serviços
INSERT INTO servicos (id_servico, nome, tipo_servico, tempo_base, ativo)
VALUES (1, 'Troca de óleo', 'Mecânica', 60, 1);

-- 7. Produtos
INSERT INTO produtos (id_peca, nome, fornecedor_id, preco_compra, preco_venda, quantidade_estoque, visivel_orcamento)
VALUES (1, 'Filtro de óleo', 'Fornecedor SP', 30.00, 50.00, 100, 1);

-- 8. Registro de Entrada
INSERT INTO registroEntrada (
  id_registro_entrada, data_entrada_prevista, data_entrada_efetiva, responsavel,
  extintor, macaco, chave_roda, estepe, monitor, fk_veiculo
) VALUES (
  1, '2025-11-25', '2025-11-25', 'Carlos',
  1, 1, 1, 1, 1, 1
);

-- 9. Ordem de Serviço
INSERT INTO ordensDeServicos (
  id_ordem_servico, valor_total, dt_saida_prevista, dt_saida_efetiva, status,
  seguradora, nf_realizada, pgto_realizado, fk_entrada
) VALUES (
  1, 1250.75, '2025-11-28', '2025-11-29', 'Concluído',
  1, 1, 1, 1
);

-- 10. Funcionários vinculados à Ordem de Serviço
INSERT INTO funcionarios_ordem_servico (fk_funcionario, fk_servico, fk_ordem_servico)
VALUES (1, 1, 1);

-- 11. Itens de Serviços
INSERT INTO itensServicos (
  id_servico, fk_ordem_servico, fk_servico, preco_cobrado,
  parte_veiculo, lado_veiculo, cor, especificacao_servico, observacoes_item
) VALUES (
  100, 1, 1, 150.00,
  'Motor', 'N/A', 'N/A', 'Óleo sintético', 'Troca realizada com sucesso'
);

-- 12. Itens de Produtos
INSERT INTO itensProdutos (id_lista_pecas, fk_ordem_servico, fk_peca, quantidade, preco_peca, baixado)
VALUES (1, 1, 1, 1, 50.00, 1);
