USE ProgSCRIPT;
-- CRIAR AS TABELAS
CREATE TABLE Clientes (
	ID_Cliente INT PRIMARY KEY,
	Nome_Cliente VARCHAR(50),
	Endereco_Cliente VARCHAR(100)
);

CREATE TABLE Produtos (
	ID_Produto INT PRIMARY KEY,
	Nome_Produto VARCHAR(50),
	Preco_Produto DECIMAL(10, 2)
);

CREATE TABLE Pedidos (
	ID_Pedido INT PRIMARY KEY,
	ID_Cliente INT,
	Data_Pedido DATE,
	FOREIGN KEY (ID_Cliente)
		REFERENCES Clientes(ID_Cliente)
);

CREATE TABLE ItensPedidos (
	ID_Pedido INT,
	ID_Produto INT,
	Quantidade INT,
	FOREIGN KEY (ID_Pedido) 
		REFERENCES Pedidos(ID_Pedido),
	FOREIGN KEY (ID_Produto)
		REFERENCES Produtos(ID_Produto)
);

-- Popular o Banco

INSERT INTO Clientes VALUES (1, 'João', 'Rua A, 123');
INSERT INTO Clientes VALUES (2, 'Maria', 'Rua B, 456');
INSERT INTO Clientes VALUES (3, 'José', 'Rua C, 789');

INSERT INTO Produtos VALUES (1, 'Camiseta', 29.99);
INSERT INTO Produtos VALUES (2, 'Calça', 59.99);
INSERT INTO Produtos VALUES (3, 'Tênis', 99.99);

INSERT INTO Pedidos VALUES (1, 1, '2022-01-01');
INSERT INTO Pedidos VALUES (2, 2, '2022-01-02');
INSERT INTO Pedidos VALUES (3, 3, '2022-01-03');

INSERT INTO ItensPedidos VALUES (1, 1, 2);
INSERT INTO ItensPedidos VALUES (1, 2, 1);
INSERT INTO ItensPedidos VALUES (2, 2, 1);
INSERT INTO ItensPedidos VALUES (2, 3, 1);
INSERT INTO ItensPedidos VALUES (3, 1, 3);
INSERT INTO ItensPedidos VALUES (3, 3, 2);

-- Exemplos
-- Selecionar o nome e o endereço de 
-- todos os clientes que já fizeram um 
-- pedido na empresa
SELECT c.Nome_Cliente, c.Endereco_Cliente
FROM Clientes c
INNER JOIN Pedidos p ON c.ID_Cliente = p.ID_Cliente;

-- Selecione o nome do produto, o preço e a quantidade
-- de cada item do pedido feito em um pedido.
SELECT pr.Nome_Produto, pr.Preco_Produto, ip.Quantidade
FROM ItensPedidos ip
INNER JOIN Produtos pr ON pr.ID_Produto = ip.ID_Produto;

-- Listar todos os pedidos com seus respectivos 
-- clientes, mesmo que não tenham feito nenhum pedido.

SELECT * FROM Pedidos p
LEFT JOIN Clientes c ON p.ID_Cliente = c.ID_Cliente;

-- Listar todos os produtos com seus respectivos pedidos 
-- e quantidades, mesmo que não tenham sido pedidos.
SELECT * FROM Produtos p
LEFT JOIN ItensPedidos ip 
ON p.ID_Produto = ip.ID_Produto;

-- Listar todos os pedidos com seus respectivos 
-- clientes e produtos, mesmo que não tenham 
-- sido pedidos.

SELECT * FROM Pedidos p
LEFT JOIN Clientes c ON 
p.ID_Cliente = c.ID_Cliente
LEFT JOIN ItensPedidos ip ON 
p.ID_Pedido = ip.ID_Pedido
LEFT JOIN Produtos pr ON 
ip.ID_Produto = pr.ID_Produto;

-- Listar todos os clientes que não fizeram nenhum pedido.

SELECT *
FROM Clientes
LEFT JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
WHERE Pedidos.IdPedido IS NULL;

-- Listar todos os produtos que nunca foram pedidos.

SELECT *
FROM Produtos
LEFT JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto
WHERE ItensPedido.IdPedido IS NULL;

-- Retornar todos os pedidos, com seus respectivos clientes, mesmo que não haja um cliente correspondente:

SELECT *
FROM Pedidos
RIGHT JOIN Clientes ON Pedidos.IdCliente = Clientes.IdCliente;

-- Retornar todos os itens de pedido, com seus respectivos produtos, mesmo que não haja um produto correspondente:

SELECT *
FROM ItensPedido
RIGHT JOIN Produtos ON ItensPedido.IdProduto = Produtos.IdProduto;

-- Retornar todos os produtos, com seus respectivos itens de pedido, mesmo que não haja um item de pedido correspondente:

SELECT *
FROM Produtos
RIGHT JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto;

-- Retornar todos os clientes, com a soma total dos valores de seus pedidos:

SELECT Clientes.IdCliente, Clientes.NomeCliente, SUM(Produtos.PrecoProduto * ItensPedido.Quantidade) AS TotalGasto
FROM Clientes
RIGHT JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
RIGHT JOIN ItensPedido ON Pedidos.IdPedido = ItensPedido.IdPedido
RIGHT JOIN Produtos ON ItensPedido.IdProduto = Produtos.IdProduto
GROUP BY Clientes.IdCliente, Clientes.NomeCliente;

-- Retornar todos os pedidos, com seus respectivos itens de pedido e produtos, mesmo que não haja um produto ou item de pedido correspondente:

SELECT *
FROM Pedidos
RIGHT JOIN ItensPedido ON Pedidos.IdPedido = ItensPedido.IdPedido
RIGHT JOIN Produtos ON ItensPedido.IdProduto = Produtos.IdProduto;

-- Escreva uma consulta SQL que retorne os clientes e seus pedidos, incluindo aqueles que não possuem pedidos.

SELECT *
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente;

-- Escreva uma consulta SQL que retorne todos os produtos, seus preços e quantidades vendidas em pedidos, incluindo aqueles que não foram vendidos em nenhum pedido.

SELECT *
FROM Produtos
FULL OUTER JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto;

-- Escreva uma consulta SQL que retorne todos os clientes, seus pedidos e os produtos em cada pedido, incluindo aqueles que não possuem pedidos ou produtos.

SELECT *
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
FULL OUTER JOIN ItensPedido ON Pedidos.IdPedido = ItensPedido.IdPedido;

-- Escreva uma consulta SQL que retorne a quantidade total de cada produto vendido em pedidos, incluindo aqueles que não foram vendidos em nenhum pedido.

SELECT Produtos.IdProduto, Produtos.NomeProduto, COALESCE(SUM(ItensPedido.Quantidade), 0) AS QuantidadeVendida
FROM Produtos
FULL OUTER JOIN ItensPedido ON Produtos.IdProduto = ItensPedido.IdProduto
GROUP BY Produtos.IdProduto, Produtos.NomeProduto;

-- Escreva uma consulta SQL que retorne os clientes e seus pedidos, incluindo aqueles que não possuem pedidos, ordenados por nome do cliente e data do pedido.

SELECT *
FROM Clientes
FULL OUTER JOIN Pedidos ON Clientes.IdCliente = Pedidos.IdCliente
ORDER BY Clientes.NomeCliente, Pedidos.DataPedido;