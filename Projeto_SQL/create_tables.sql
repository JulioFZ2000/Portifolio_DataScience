-- Criando a tabela de clientes
CREATE TABLE t_clientes (
    id_cliente INT PRIMARY KEY,
    nome_cli VARCHAR(100),
  	regiao varchar(2),
    email_cli VARCHAR(100),
    data_cadastro DATE
);

-- Criando a tabela de produtos
CREATE TABLE t_produtos (
    id_produto INT PRIMARY KEY,
    nome_prod VARCHAR(100),
    descricao_prod VARCHAR(250),
    preco_prod DECIMAL(8,2),
    estoque_prod INT
);

-- Criando a tabela de pedidos
CREATE TABLE t_pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    data_pedido varchar(20),
    status_pedido VARCHAR(20), -- Status: em análise, a caminho, entregue, pagamento pendente, devolução
    FOREIGN KEY (id_cliente) REFERENCES t_clientes(id_cliente)
);

-- Criando a tabela de itens do pedido
CREATE TABLE t_itens_pedido (
    id_iten INT PRIMARY KEY,
    id_pedido INT,
    id_produto INT, 
    qtd_produto DECIMAL(10,2),
    FOREIGN KEY (id_pedido) REFERENCES t_pedidos(id_pedido),
    FOREIGN KEY (id_produto) REFERENCES t_produtos(id_produto)
);

-- Criando a tabela de funcionários
CREATE TABLE t_funcionarios (
    id_funci INT PRIMARY KEY,
    nome_funci VARCHAR(100),
    cargo_funci VARCHAR(50),
    salario_funci DECIMAL(10,2),
    data_contratacao DATE
);
