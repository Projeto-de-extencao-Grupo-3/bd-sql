/* Cátalogo de Serviços */
-- FUNILARIA
INSERT INTO servicos (tipo_servico, descricao, tempo_base, ativo) VALUES
('Funilaria', 'Reparo de Avaria Leve em Estrutura', 180, 1), -- 180 minutos (3h)
('Funilaria', 'Substituição de Painel Lateral (Grande)', 480, 1), -- 480 minutos (8h)
('Funilaria', 'Reparo Estrutural em Longarina do Chassi', 600, 1); -- 600 minutos (10h)

-- PINTURA
INSERT INTO servicos (tipo_servico, descricao, tempo_base, ativo) VALUES
('Pintura', 'Pintura de Peça Específica (Parachoque, Saia)', 120, 1),
('Pintura', 'Pintura de Lateral/Carroceria (Geral)', 720, 1), -- 720 minutos (12h)
('Pintura', 'Retoque de Pintura Localizado (Spot Repair)', 60, 1);

-- MECÂNICA
INSERT INTO servicos (tipo_servico, descricao, tempo_base, ativo) VALUES
('Mecânica', 'Troca de Embreagem (Ônibus Pesado - Mão de Obra)', 420, 1),
('Mecânica', 'Revisão e Ajuste do Sistema de Freios a Ar', 750.00, 1),
('Mecânica', 'Substituição da Bomba Injetora/Sistema de Combustível', 300, 1);

-- BÁSICOS
INSERT INTO servicos (tipo_servico, descricao, tempo_base, ativo) VALUES
('Básicos', 'Troca de Óleo e Filtros (Completo)', 60, 1),
('Básicos', 'Alinhamento e Balanceamento (Eixos Dianteiros e Traseiros)', 90, 1),
('Básicos', 'Inspeção Detalhada de Segurança e Itens de Frota', 45, 1);

/* Itens Servicos */
-- Exemplo 1: Serviço de Funilaria
-- Reparo Estrutural em Chassi (fk_servico = 3)
INSERT INTO itensServicos (fk_ordem_servico, fk_servico, preco_cobrado, parte_veiculo, lado_veiculo, cor, especificacao_servico, observacoes_item) VALUES
(1, 3, 1200.0000, 'Longarina Dianteira', 'Esquerdo', NULL, 'Soldagem Estrutural', 'Reforço de longarina devido a impacto em sarjeta.');

-- Exemplo 2: Serviço de Pintura (Detalhes Condicionais Preenchidos)
-- Pintura de Lateral/Carroceria (Geral) (fk_servico = 5)
INSERT INTO itensServicos (fk_ordem_servico, fk_servico, preco_cobrado, parte_veiculo, lado_veiculo, cor, especificacao_servico, observacoes_item) VALUES
(1, 5, 2000.0000, 'Lateral Superior e Teto', 'Ambos', 'Azul Padrão (RAL 5005)', 'Completa', 'Lixamento total da área superior para aderência, aplicação de PU.'); 
-- Preço Cobrado ajustado de 2200 para 2000 (implicando um desconto de R$200,00).

-- Exemplo 3: Serviço de Mecânica
-- Troca de Embreagem (Mão de Obra) (fk_servico = 7)
INSERT INTO itensServicos (fk_ordem_servico, fk_servico, preco_cobrado, parte_veiculo, lado_veiculo, cor, especificacao_servico, observacoes_item) VALUES
(1, 7, 1400.0000, 'Transmissão', 'N/A', NULL, 'Substituição', 'Mão de obra para troca. Peças na tabela itensProdutos. Necessário lubrificação.');

-- Exemplo 4: Serviço Básico
-- Alinhamento e Balanceamento (fk_servico = 11)
INSERT INTO itensServicos (fk_ordem_servico, fk_servico, preco_cobrado, parte_veiculo, lado_veiculo, cor, especificacao_servico, observacoes_item) VALUES
(1, 11, 237.5000, 'Eixos', 'Ambos', NULL, 'Preventiva', 'Eixos dianteiro e traseiro alinhados conforme padrão do fabricante.');
-- Preço Cobrado ajustado de 250 para 237.50 (implicando um desconto de R$12,50).