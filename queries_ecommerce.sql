-- Quantos pedidos foram feitos por cada cliente?
SELECT c.nome as cliente,
	COUNT(p.id) as contagem
	FROM tb_cliente as c
	INNER JOIN tb_pedido as p
	ON c.id = p.id_cliente
	GROUP BY cliente
	ORDER BY c.nome;

-- Algum vendedor também é fornecedor?
SELECT cnpj, razao_social
	FROM tb_vendedor
	WHERE cnpj IN (SELECT cnpj FROM tb_fornecedor)
	AND razao_social IN (SELECT razao_social FROM tb_fornecedor);

-- Qual a relação de produtos, fornecedores e estoques?
SELECT f.razao_social as fornecedor,
	p.nome as produto,
	e.local as estoque
	FROM tb_fornecedor as f
	INNER JOIN tb_fornecedor_produto as fp
	ON f.id = fp.id_fornecedor
	INNER JOIN tb_produto as p
	ON p.id = fp.id_produto
	INNER JOIN tb_estoque_produto as ep
	ON p.id = ep.id_produto
	INNER JOIN tb_estoque as e
	ON e.id = ep.id_estoque;

-- Qual a relação de nomes dos fornecedores e nomes dos produtos?
SELECT f.razao_social as fornecedor,
	p.nome as produto
	FROM tb_fornecedor as f
	INNER JOIN tb_fornecedor_produto as fp
	ON f.id = fp.id_fornecedor
	INNER JOIN tb_produto as p
	ON p.id = fp.id_produto;