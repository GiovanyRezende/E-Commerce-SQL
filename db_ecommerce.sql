CREATE DATABASE IF NOT EXISTS db_ecommerce
COLLATE utf8mb4_general_ci
CHARSET utf8mb4;

CREATE TABLE IF NOT EXISTS tb_endereco(
	id INT PRIMARY KEY AUTO_INCREMENT,
	rua VARCHAR(100) NOT NULL,
	numero INT NOT NULL,
	cep VARCHAR(8) NOT NULL,
	cidade VARCHAR(200) NOT NULL,
	uf VARCHAR(2) NOT NULL,
	complemento VARCHAR(200)
);

CREATE TABLE IF NOT EXISTS tb_metodo(
	id INT PRIMARY KEY AUTO_INCREMENT,
	metodo VARCHAR(20) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_categoria(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_vendedor(
	id INT PRIMARY KEY AUTO_INCREMENT,
	cnpj VARCHAR(14) NOT NULL,
	razao_social VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_fornecedor(
	id INT PRIMARY KEY AUTO_INCREMENT,
	cnpj VARCHAR(14) NOT NULL,
	razao_social VARCHAR(200) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_estoque(
	id INT PRIMARY KEY AUTO_INCREMENT,
	local VARCHAR(250) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_status(
	id INT PRIMARY KEY AUTO_INCREMENT,
	status VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS tb_cliente(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(255) NOT NULL,
	cpf VARCHAR(11) NOT NULL,
	cnpj VARCHAR(14),
	id_endereco INT NOT NULL,
	CONSTRAINT fk_id_endereco_cliente
	FOREIGN KEY (id_endereco) REFERENCES tb_endereco (id) 
);

CREATE TABLE IF NOT EXISTS tb_conta(
	id INT PRIMARY KEY AUTO_INCREMENT,
	email VARCHAR(100) NOT NULL,
	senha VARCHAR(50) NOT NULL,
	telefone VARCHAR(13) NOT NULL,
	data_cadastro DATE NOT NULL,
	id_cliente INT NOT NULL,
	CONSTRAINT fk_id_cliente_conta
	FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id)
);

CREATE TABLE IF NOT EXISTS tb_pf(
	cpf VARCHAR(11) NOT NULL,
	id_conta INT NOT NULL,
	CONSTRAINT uq_cpf_pf UNIQUE (cpf),
	CONSTRAINT fk_id_conta_pf
	FOREIGN KEY (id_conta) REFERENCES tb_conta (id)
);

CREATE TABLE IF NOT EXISTS tb_pj(
	cnpj VARCHAR(14) NOT NULL,
	id_conta INT NOT NULL,
	CONSTRAINT fk_id_conta_pj
	FOREIGN KEY (id_conta) REFERENCES tb_conta (id)
);

CREATE TABLE IF NOT EXISTS tb_produto(
	id INT PRIMARY KEY AUTO_INCREMENT,
	nome VARCHAR(50) NOT NULL,
	descricao VARCHAR(200) NOT NULL,
	valor FLOAT(6,2) NOT NULL,
	id_categoria INT NOT NULL,
	CONSTRAINT fk_id_categoria_produto
	FOREIGN KEY (id_categoria) REFERENCES tb_categoria (id)
);

CREATE TABLE IF NOT EXISTS tb_pedido(
	id INT PRIMARY KEY AUTO_INCREMENT,
	descricao VARCHAR(200) NOT NULL,
	id_cliente INT NOT NULL,
	id_status INT NOT NULL,
	CONSTRAINT fk_id_cliente_pedido
	FOREIGN KEY (id_cliente) REFERENCES tb_cliente (id),
	CONSTRAINT fk_id_status_pedido
	FOREIGN KEY (id_status) REFERENCES tb_status (id)
);

CREATE TABLE IF NOT EXISTS tb_entrega(
	id INT PRIMARY KEY AUTO_INCREMENT,
	codigo_rastreio VARCHAR(50) NOT NULL,
	data_entrega DATE NOT NULL,
	id_pedido INT NOT NULL,
	id_status INT NOT NULL,
	CONSTRAINT fk_id_pedido_entrega
	FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id),
	CONSTRAINT fk_id_status_entrega
	FOREIGN KEY (id_status) REFERENCES tb_status (id)
);

CREATE TABLE IF NOT EXISTS tb_pagamento(
	id INT PRIMARY KEY AUTO_INCREMENT,
	valor FLOAT(6,2) NOT NULL,
	data_pagamento DATE NOT NULL,
	n_parcelas INT NOT NULL,
	id_conta INT NOT NULL,
	id_metodo INT NOT NULL,
	id_pedido INT NOT NULL,
	CONSTRAINT fk_id_conta_pagamento
	FOREIGN KEY (id_conta) REFERENCES tb_conta (id),
	CONSTRAINT fk_id_metodo_pagamento
	FOREIGN KEY (id_metodo) REFERENCES tb_metodo (id),
	CONSTRAINT fk_id_pedido_pagamento
	FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id)
);

CREATE TABLE IF NOT EXISTS tb_produto_vendedor(
	id_vendedor INT NOT NULL,
	id_produto INT NOT NULL,
	qtd INT NOT NULL,
	CONSTRAINT fk_id_vendedor_produto_vendedor
	FOREIGN KEY (id_vendedor) REFERENCES tb_vendedor (id),
	CONSTRAINT fk_id_produto_produto_vendedor
	FOREIGN KEY (id_produto) REFERENCES tb_produto (id) 
);

CREATE TABLE IF NOT EXISTS tb_fornecedor_produto(
	id_fornecedor INT NOT NULL,
	id_produto INT NOT NULL,
	CONSTRAINT fk_id_fornecedor_fornecedor_produto
	FOREIGN KEY (id_fornecedor) REFERENCES tb_fornecedor (id),
	CONSTRAINT fk_id_produto_fornecedor_produto
	FOREIGN KEY (id_produto) REFERENCES tb_produto (id) 
);

CREATE TABLE IF NOT EXISTS tb_estoque_produto(
	id_estoque INT NOT NULL,
	id_produto INT NOT NULL,
	qtd INT NOT NULL,
	CONSTRAINT fk_id_fornecedor_estoque_produto
	FOREIGN KEY (id_estoque) REFERENCES tb_estoque (id),
	CONSTRAINT fk_id_produto_estoque_produto
	FOREIGN KEY (id_produto) REFERENCES tb_produto (id) 
);

CREATE TABLE IF NOT EXISTS tb_produto_pedido(
	id_pedido INT NOT NULL,
	id_produto INT NOT NULL,
	CONSTRAINT fk_id_pedido_produto_pedido
	FOREIGN KEY (id_pedido) REFERENCES tb_pedido (id),
	CONSTRAINT fk_id_produto_produto_pedido
	FOREIGN KEY (id_produto) REFERENCES tb_produto (id) 
);
