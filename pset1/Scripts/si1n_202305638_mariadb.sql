DROP 				DATABASE 
IF EXISTS 			uvv;

DROP USER 
IF EXISTS 			lucas_morais;

DROP SCHEMA 
IF EXISTS 			lojas;

-- Criação do usuário que será o dono do Banco de Dados
CREATE USER 		'lucas_morais'@'%' 		IDENTIFIED BY 'pass';

GRANT CREATE, CREATE ROUTINE, CREATE VIEW, SHOW VIEW ON *.* TO 		'lucas_morais'@'%';

-- Criando Bando de Dados
CREATE DATABASE 			uvv 
CHARACTER SET 				utf8mb4 
COLLATE 				utf8mb4_unicode_ci;


GRANT ALL PRIVILEGES ON 	uvv.* 
TO 				lucas_morais;
				   
-- Conectando ao Banco de Dados "uvv"
USE 	uvv;

-- Criando o Esquema
CREATE SCHEMA 		lojas;

-- Ajustando o esquema padrão
ALTER USER 		'lucas_morais'@'%';



-- Implementação do projeto lógico do Banco de Dados "Lojas UVV"
CREATE TABLE uvv.lojas (
                loja_id 			NUMERIC(38) 	NOT NULL,
                nome 				VARCHAR(255) 	NOT NULL,
                endereco_web 			VARCHAR(100),
                endereco_fisico 		VARCHAR(512),
                latitude 			NUMERIC,
                longitude 			NUMERIC,
                logo 				LONGBLOB,
                logo_mime_type 			VARCHAR(512),
                logo_arquivo 			VARCHAR(512),
                logo_charset 			VARCHAR(512),
                logo_ultima_atualizacao 	DATE,
                PRIMARY KEY 			(loja_id)
);

ALTER TABLE lojas 		COMMENT 		'Tabela para dados relacionados as lojas.';

ALTER TABLE lojas MODIFY COLUMN loja_id 		NUMERIC(38) 	COMMENT 		'Número de identificação da loja.';

ALTER TABLE lojas MODIFY COLUMN nome 			VARCHAR(255) 	COMMENT 		'Nome da loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_web 		VARCHAR(100) 	COMMENT 		'Endereço da web da loja.';

ALTER TABLE lojas MODIFY COLUMN endereco_fisico		VARCHAR(512) 	COMMENT 		'Endereço físico da loja.';

ALTER TABLE lojas MODIFY COLUMN latitude 		NUMERIC 	COMMENT 		'Latitude de onde se encontra a loja.';

ALTER TABLE lojas MODIFY COLUMN longitude 		NUMERIC 	COMMENT 		'Longitude de onde se encontra a loja.';

ALTER TABLE lojas MODIFY COLUMN logo 			BLOB 		COMMENT 		'Dado relacionado a logo da loja.';

ALTER TABLE lojas MODIFY COLUMN logo_mime_type 		VARCHAR(512) 	COMMENT 		'Informação sobre o formato do arquivo.';

ALTER TABLE lojas MODIFY COLUMN logo_arquivo 		VARCHAR(512) 	COMMENT 		'Dado relacionado a imagem do arquivo da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_charset 		VARCHAR(512) 	COMMENT 		'O conjunto de carcteres associada a imagem da logo.';

ALTER TABLE lojas MODIFY COLUMN logo_ultima_atualizacao DATE 		COMMENT 		'Data da última atualização da logo.';


CREATE TABLE uvv.produtos (
                produto_id 			NUMERIC(38) 	NOT NULL,
                nome 				VARCHAR(255) 	NOT NULL,
                preco_unitario 			NUMERIC(10,2),
                detalhes 			LONGBLOB,
                imagem 				LONGBLOB,
                imagem_mime_type 		VARCHAR(512),
                imagem_arquivo 			VARCHAR(512),
                imagem_charset 			VARCHAR(512),
                imagem_ultima_atualizacao 	DATE,
                PRIMARY KEY 			(produto_id)
);

ALTER TABLE produtos 		COMMENT 		'Tabela para dados relacionados ao produtos';

ALTER TABLE produtos MODIFY COLUMN produto_id 			NUMERIC(38) 	COMMENT 		'Número de identificação do produto.';

ALTER TABLE produtos MODIFY COLUMN nome 			VARCHAR(255) 	COMMENT 		'Nome do produto.';

ALTER TABLE produtos MODIFY COLUMN preco_unitario 		NUMERIC(10, 2) 	COMMENT 		'Preço unitário do produto.';

ALTER TABLE produtos MODIFY COLUMN detalhes 			BLOB 		COMMENT 		'Detalhes relacionado ao produto.';
	
ALTER TABLE produtos MODIFY COLUMN imagem 			BLOB 		COMMENT 		'Imagem relacionada ao produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_mime_type 		VARCHAR(512) 	COMMENT 		'Informação sobre o formato do arquivo.';

ALTER TABLE produtos MODIFY COLUMN imagem_arquivo 		VARCHAR(512) 	COMMENT 		'Dado relacionado a imagem do arquivo do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_charset 		VARCHAR(512) 	COMMENT 		'O conjunto de carcteres associada a imagem do produto.';

ALTER TABLE produtos MODIFY COLUMN imagem_ultima_atualizacao	DATE 		COMMENT 		'Data da última atualização da imagem.';


CREATE TABLE uvv.estoques (
                estoque_id 		NUMERIC(38) NOT NULL,
                loja_id 		NUMERIC(38) NOT NULL,
                produto_id 		NUMERIC(38) NOT NULL,
                quantidade 		NUMERIC(38) NOT NULL,
                PRIMARY KEY 		(estoque_id)
);

ALTER TABLE estoques 		COMMENT 		'Tabela para dados relacionados ao estoque.';

ALTER TABLE estoques MODIFY COLUMN estoque_id 		NUMERIC(38) 	COMMENT 	'Número de identificação do estoque.';

ALTER TABLE estoques MODIFY COLUMN loja_id 		NUMERIC(38) 	COMMENT 	'Número de identificação da loja.';

ALTER TABLE estoques MODIFY COLUMN produto_id 		NUMERIC(38) 	COMMENT 	'Número de identificação do produto.';

ALTER TABLE estoques MODIFY COLUMN quantidade 		NUMERIC(38)	COMMENT		'Quantidade de estoques.';


CREATE TABLE uvv.clientes (
                cliente_id 		NUMERIC(38) 	NOT NULL,
                email 			VARCHAR(255) 	NOT NULL,
                nome 			VARCHAR(255) 	NOT NULL,
                telefone1 		VARCHAR(20),
                telefone2 		VARCHAR(20),
                telefone3 		VARCHAR(20),
                PRIMARY KEY 		(cliente_id)
);

ALTER TABLE clientes 		COMMENT			'Tabela para dados relacionados ao cliente';

ALTER TABLE clientes MODIFY COLUMN cliente_id 		NUMERIC(38) 	COMMENT 	'Número de identificação do cliente.';

ALTER TABLE clientes MODIFY COLUMN email 		VARCHAR(255) 	COMMENT 	'E-mail do cliente.';

ALTER TABLE clientes MODIFY COLUMN nome 		VARCHAR(255) 	COMMENT 	'Nome do cliente.';

ALTER TABLE clientes MODIFY COLUMN telefone1 		VARCHAR(20) 	COMMENT 	'Telefone 1 do cliente.';

ALTER TABLE clientes MODIFY COLUMN telefone2 		VARCHAR(20) 	COMMENT 	'Telefone 2 do cliente.';

ALTER TABLE clientes MODIFY COLUMN telefone3		VARCHAR(20) 	COMMENT 	'Telefone 3 do cliente.';


CREATE TABLE uvv.pedidos (
                pedido_id 		NUMERIC(38) 	NOT NULL,
                data_hora 		DATETIME 	NOT NULL,
                cliente_id 		NUMERIC(38) 	NOT NULL,
                status 			VARCHAR(15) 	NOT NULL,
                loja_id 		NUMERIC(38) 	NOT NULL,
                PRIMARY KEY 		(pedido_id)
);

ALTER TABLE pedidos 		COMMENT 		'Tabela para dados relacionados aos pedidos';

ALTER TABLE pedidos MODIFY COLUMN pedido_id 		NUMERIC(38) 	COMMENT 	'Número de identificação do pedido.';

ALTER TABLE pedidos MODIFY COLUMN data_hora 		TIMESTAMP 	COMMENT 	'Data e hora que foi feito o pedido.';

ALTER TABLE pedidos MODIFY COLUMN cliente_id 		NUMERIC(38)	COMMENT 	'Número de identificação do cliente.';

ALTER TABLE pedidos MODIFY COLUMN status 		VARCHAR(15) 	COMMENT 	'Status do pedido.';

ALTER TABLE pedidos MODIFY COLUMN loja_id 		NUMERIC(38) 	COMMENT 	'Número de identificação da loja.';


CREATE TABLE uvv.envios (
                envio_id 		NUMERIC(38) 	NOT NULL,
                loja_id 		NUMERIC(38) 	NOT NULL,
                cliente_id	 	NUMERIC(38) 	NOT NULL,
                endereco_entrega 	VARCHAR(512) 	NOT NULL,
                status 			VARCHAR(15) 	NOT NULL,
                PRIMARY KEY 		(envio_id)
);

ALTER TABLE envios 		COMMENT 		'Tabela para dados relacionados a produtos enviados';

ALTER TABLE envios MODIFY COLUMN envio_id 			NUMERIC(38) 	COMMENT 	'Número de identificação do envio.';

ALTER TABLE envios MODIFY COLUMN loja_id 			NUMERIC(38) 	COMMENT 	'Número de identificação da loja.';

ALTER TABLE envios MODIFY COLUMN cliente_id 			NUMERIC(38) 	COMMENT 	'Número de identificação do cliente.';

ALTER TABLE envios MODIFY COLUMN endereco_entrega 		VARCHAR(512) 	COMMENT 	'Endereço de entrega do envio.';

ALTER TABLE envios MODIFY COLUMN status 			VARCHAR(15) 	COMMENT 	'Status do envio.';


CREATE TABLE uvv.pedidos_itens (
                pedido_id 			NUMERIC(38) 	NOT NULL,
                produto_id 			NUMERIC(38) 	NOT NULL,
                numero_da_linha 		NUMERIC(38) 	NOT NULL,
                preco_unitario 			NUMERIC(10,2) 	NOT NULL,
                quantidade 			NUMERIC(38) 	NOT NULL,
                envio_id 			NUMERIC(38),
                PRIMARY KEY 			(pedido_id, produto_id)
);

ALTER TABLE pedidos_itens 		COMMENT 		'Tabela para dados relacionados aos itens pedidos';

ALTER TABLE pedidos_itens MODIFY COLUMN pedido_id 			NUMERIC(38) 	COMMENT 	'Número de identificação do pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN produto_id 			NUMERIC(38) 	COMMENT 	'Número de identificação do produto.';

ALTER TABLE pedidos_itens MODIFY COLUMN numero_da_linha 		NUMERIC(38) 	COMMENT 	'Número da linha do item pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN preco_unitario 			NUMERIC(10, 2) 	COMMENT 	'Preço unitário do item pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN quantidade 			NUMERIC(38) 	COMMENT 	'Quantidade do item pedido.';

ALTER TABLE pedidos_itens MODIFY COLUMN envio_id 			NUMERIC(38) 	COMMENT 	'Número de identificação do envio.';

-- Criação das Foregein Keys
ALTER TABLE 		pedidos 
ADD CONSTRAINT 		lojas_pedidos_fk
FOREIGN KEY 		(loja_id)
REFERENCES 		lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		envios 
ADD CONSTRAINT 		lojas_envios_fk
FOREIGN KEY 		(loja_id)
REFERENCES 		lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		estoques 
ADD CONSTRAINT 		lojas_estoques_fk
FOREIGN KEY 		(loja_id)
REFERENCES 		lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		estoques 
ADD CONSTRAINT 		produtos_estoques_fk
FOREIGN KEY 		(produto_id)
REFERENCES 		produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		pedidos_itens 
ADD CONSTRAINT 		produtos_pedidos_itens_fk
FOREIGN KEY 		(produto_id)
REFERENCES 		produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		envios 
ADD CONSTRAINT 		clientes_envios_fk
FOREIGN KEY 		(cliente_id)
REFERENCES 		clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		pedidos 
ADD CONSTRAINT 		clientes_pedidos_fk
FOREIGN KEY 		(cliente_id)
REFERENCES 		clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		pedidos_itens 
ADD CONSTRAINT 		pedidos_pedidos_itens_fk
FOREIGN KEY 		(pedido_id)
REFERENCES 		pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE 		pedidos_itens 
ADD CONSTRAINT 		envios_pedidos_itens_fk
FOREIGN KEY 		(envio_id)
REFERENCES 		envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- Criação de restrições de checagem

ALTER TABLE 		pedidos
ADD CONSTRAINT 		cc_pedidos_status
CHECK 			(status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE 		envios
ADD CONSTRAINT 		cc_envios_status
CHECK 			(status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE 		lojas
ADD CONSTRAINT 		cc_lojas_endereco
CHECK 			((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

ALTER TABLE 		produtos
ADD CONSTRAINT 		cc_produtos_preco_unitario
CHECK 			(preco_unitario >= 0);

ALTER TABLE 		estoques
ADD CONSTRAINT 		cc_estoques_quantidade
CHECK 			(quantidade >= 0);

ALTER TABLE 		pedidos_itens
ADD CONSTRAINT 		cc_pedidos_itens_quantidade
CHECK 			(quantidade >= 0);

ALTER TABLE 		clientes
ADD CONSTRAINT 		cc_clientes_telefone1
ADD CHECK 		(telefone1 REGEXP '^[0-9]+$');

ALTER TABLE	 	clientes
ADD CONSTRAINT 		cc_clientes_telefone2
ADD CHECK 		(telefone2 REGEXP '^[0-9]+$');

ALTER TABLE 		clientes
ADD CONSTRAINT 		cc_clientes_telefone3
ADD CHECK 		(telefone3 REGEXP '^[0-9]+$');

ALTER TABLE 		pedidos_itens
ADD CONSTRAINT 		cc_pedidos_itens_preco_unitario
CHECK 			(preco_unitario >= 0);


