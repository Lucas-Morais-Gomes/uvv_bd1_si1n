DROP 				DATABASE 
IF EXISTS 			uvv;

DROP ROLE 
IF EXISTS 			lucas_morais;

DROP SCHEMA 
IF EXISTS 			lojas;

-- Criação do usuário que será o dono do Banco de Dados
CREATE USER 		lucas_morais WITH 
					SUPERUSER
					CREATEDB
					CREATEROLE
					ENCRYPTED PASSWORD 'pass';
				
-- Criando Bando de Dados
CREATE 				DATABASE uvv
					OWNER = 		lucas_morais
				    TEMPLATE = 		template0
				    ENCODING =		'UTF8'
				    LC_COLLATE = 'pt_BR.UTF-8'
				    LC_CTYPE = 'pt_BR.UTF-8'
					ALLOW_CONNECTIONS = 	TRUE;
				   
-- Conectando ao Banco de Dados "uvv"
\c 					uvv;

-- Criando o Esquema
CREATE SCHEMA 		lojas 
AUTHORIZATION 		lucas_morais;

-- Ajustando o esquema padrão
SET SEARCH_PATH TO 		lojas, "$user", public;

ALTER USER 				lucas_morais
SET SEARCH_PATH TO 		lojas, "$user", public;

-- Implementação do projeto lógico do Banco de Dados "Lojas UVV"
CREATE TABLE 		lojas (
                		loja_id 					NUMERIC(38) 	NOT NULL,
                		nome 						VARCHAR(255) 	NOT NULL,
		                endereco_web 				VARCHAR(100),
		                endereco_fisico 			VARCHAR(512),
		                latitude 					NUMERIC,
		                longitude 					NUMERIC,
		                logo BYTEA,
		                logo_mime_type 				VARCHAR(512),
		                logo_arquivo 				VARCHAR(512),
		                logo_charset 				VARCHAR(512),
		                logo_ultima_atualizacao 	DATE,
		                CONSTRAINT loja_id_pk 		PRIMARY KEY 	(loja_id)
);
COMMENT ON TABLE lojas IS 							'Tabela para dados relacionados as lojas.';
COMMENT ON COLUMN lojas.loja_id IS 					'Número de identificação da loja.';
COMMENT ON COLUMN lojas.nome IS 					'Nome da loja.';
COMMENT ON COLUMN lojas.endereco_web IS 			'Endereço da web da loja.';
COMMENT ON COLUMN lojas.endereco_fisico IS 			'Endereço físico da loja.';
COMMENT ON COLUMN lojas.latitude IS 				'Latitude de onde se encontra a loja.';
COMMENT ON COLUMN lojas.longitude IS 				'Longitude de onde se encontra a loja.';
COMMENT ON COLUMN lojas.logo IS						'Dado relacionado a logo da loja.';
COMMENT ON COLUMN lojas.logo_mime_type IS		 	'Dado relacionado ao tipo MIME da imagem atribuída a logo, informação sobre o formato do arquivo.';
COMMENT ON COLUMN lojas.logo_arquivo IS 			'Dado relacionado a imagem do arquivo da logo.';
COMMENT ON COLUMN lojas.logo_charset IS 			'Dado relacionado ao conjunto de carcteres associada a imagem da logo.';
COMMENT ON COLUMN lojas.logo_ultima_atualizacao IS 	'Data da última atualização da logo.';


CREATE TABLE 		produtos (
		                produto_id 					NUMERIC(38) 	NOT NULL,
		                nome 						VARCHAR(255)	NOT NULL,
		                preco_unitario 				NUMERIC(10,2),
		                detalhes BYTEA,
		                imagem BYTEA,
		                imagem_mime_type 			VARCHAR(512),
		                imagem_arquivo 				VARCHAR(512),
		                imagem_charset 				VARCHAR(512),
		                imagem_ultima_atualizacao 	DATE,
		                CONSTRAINT produto_id_pk 	PRIMARY KEY 	(produto_id)
);
COMMENT ON TABLE produtos IS 								'Tabela para dados relacionados ao produtos';
COMMENT ON COLUMN produtos.produto_id IS 					'Número de identificação do produto.';
COMMENT ON COLUMN produtos.nome IS 							'Nome do produto.';
COMMENT ON COLUMN produtos.preco_unitario IS 				'Preço unitário do produto.';
COMMENT ON COLUMN produtos.detalhes IS 						'Detalhes relacionado ao produto.';
COMMENT ON COLUMN produtos.imagem IS 						'Imagem relacionada ao produto.';
COMMENT ON COLUMN produtos.imagem_mime_type IS 				'Dado relacionado ao tipo MIME da imagem atribuída ao produto, informação sobre o formato do arquivo.';
COMMENT ON COLUMN produtos.imagem_arquivo IS 				'Dado relacionado a imagem do arquivo do produto.';
COMMENT ON COLUMN produtos.imagem_charset IS 				'Dado relacionado ao conjunto de carcteres associada a imagem do produto.';
COMMENT ON COLUMN produtos.imagem_ultima_atualizacao IS 	'Data da última atualização da imagem.';


CREATE TABLE estoques (
                estoque_id 					NUMERIC(38) 	NOT NULL,
                loja_id 					NUMERIC(38)		NOT NULL,
                produto_id 					NUMERIC(38) 	NOT NULL,
                quantidade 					NUMERIC(38) 	NOT NULL,
                CONSTRAINT estoque_id_pk 	PRIMARY KEY 	(estoque_id)
);

COMMENT ON TABLE estoques IS 					'Tabela para dados relacionados ao estoque.';
COMMENT ON COLUMN estoques.estoque_id IS 		'Número de identificação do estoque.';
COMMENT ON COLUMN estoques.loja_id IS 			'Número de identificação da loja.';
COMMENT ON COLUMN estoques.produto_id IS 		'Número de identificação do produto.';
COMMENT ON COLUMN estoques.quantidade IS		'Quantidade de estoques.';


CREATE TABLE clientes (
                cliente_id 				NUMERIC(38) 	NOT NULL,
                email 					VARCHAR(255) 	NOT NULL,
                nome 					VARCHAR(255) 	NOT NULL,
                telefone1 				VARCHAR(20),
                telefone2 				VARCHAR(20),
                telefone3 				VARCHAR(20),
                CONSTRAINT clientes_pk 	PRIMARY KEY 	(cliente_id)
);
COMMENT ON TABLE clientes IS 					'Tabela para dados relacionados ao cliente';
COMMENT ON COLUMN clientes.cliente_id IS 		'Número de identificação do cliente.';
COMMENT ON COLUMN clientes.email IS 			'E-mail do cliente.';
COMMENT ON COLUMN clientes.nome IS 				'Nome do cliente.';
COMMENT ON COLUMN clientes.telefone1 IS 		'Telefone 1 do cliente.';
COMMENT ON COLUMN clientes.telefone2 IS 		'Telefone 2 do cliente.';
COMMENT ON COLUMN clientes.telefone3 IS 		'Telefone 3 do cliente.';


CREATE TABLE pedidos (
                pedido_id 				NUMERIC(38) 	NOT NULL,
                data_hora 				TIMESTAMP 		NOT NULL,
                cliente_id 				NUMERIC(38) 	NOT NULL,
                status 					VARCHAR(15) 	NOT NULL,
                loja_id 				NUMERIC(38) 	NOT NULL,
                CONSTRAINT pedido_id_pk PRIMARY KEY 	(pedido_id)
);
COMMENT ON TABLE pedidos IS 					'Tabela para dados relacionados aos pedidos';
COMMENT ON COLUMN pedidos.pedido_id IS 			'Número de identificação do pedido.';
COMMENT ON COLUMN pedidos.data_hora IS 			'Data e hora que foi feito o pedido.';
COMMENT ON COLUMN pedidos.cliente_id IS 		'Número de identificação do cliente.';
COMMENT ON COLUMN pedidos.status IS 			'Status do pedido.';
COMMENT ON COLUMN pedidos.loja_id IS 			'Número de identificação da loja.';


CREATE TABLE envios (
                envio_id 				NUMERIC(38) 	NOT NULL,
                loja_id 				NUMERIC(38) 	NOT NULL,
                cliente_id 				NUMERIC(38) 	NOT NULL,
                endereco_entrega 		VARCHAR(512) 	NOT NULL,
                status 					VARCHAR(15) 	NOT NULL,
                CONSTRAINT envio_id_pk 	PRIMARY KEY 	(envio_id)
);
COMMENT ON TABLE envios IS 							'Tabela para dados relacionados a produtos enviados';
COMMENT ON COLUMN envios.envio_id IS 				'Número de identificação do envio.';
COMMENT ON COLUMN envios.loja_id IS 				'Número de identificação da loja.';
COMMENT ON COLUMN envios.cliente_id IS 				'Número de identificação do cliente.';
COMMENT ON COLUMN envios.endereco_entrega IS 		'Endereço de entrega do envio.';
COMMENT ON COLUMN envios.status IS 					'Status do envio.';


CREATE TABLE pedidos_itens (
                pedido_id 						NUMERIC(38) 	NOT NULL,
                produto_id 						NUMERIC(38) 	NOT NULL,
                numero_da_linha 				NUMERIC(38) 	NOT NULL,
                preco_unitario 					NUMERIC(10,2) 	NOT NULL,
                quantidade 						NUMERIC(38) 	NOT NULL,
                envio_id 						NUMERIC(38),
                CONSTRAINT pedido_id_itens_pk 	PRIMARY KEY 	(produto_id)
);

COMMENT ON TABLE pedidos_itens IS 						'Tabela para dados relacionados aos itens pedidos';
COMMENT ON COLUMN pedidos_itens.pedido_id IS 			'Número de identificação do pedido.';
COMMENT ON COLUMN pedidos_itens.produto_id IS 			'Número de identificação do produto.';
COMMENT ON COLUMN pedidos_itens.numero_da_linha IS 		'Número da linha do item pedido.';
COMMENT ON COLUMN pedidos_itens.preco_unitario IS 		'Preço unitário do item pedido.';
COMMENT ON COLUMN pedidos_itens.quantidade IS 			'Quantidade do item pedido.';
COMMENT ON COLUMN pedidos_itens.envio_id IS 			'Número de identificação do envio.';

-- Criando as Foregeing Keys
ALTER TABLE 			pedidos 
ADD CONSTRAINT 			lojas_pedidos_fk
FOREIGN KEY 			(loja_id)
REFERENCES 				lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			envios 
ADD CONSTRAINT 			lojas_envios_fk
FOREIGN KEY 			(loja_id)
REFERENCES 		lojas 	(loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			estoques 
ADD CONSTRAINT 			lojas_estoques_fk
FOREIGN KEY 			(loja_id)
REFERENCES 				lojas (loja_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			estoques 
ADD CONSTRAINT 			produtos_estoques_fk
FOREIGN KEY 			(produto_id)
REFERENCES 				produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			pedidos_itens 
ADD CONSTRAINT 			produtos_pedidos_itens_fk
FOREIGN KEY 			(produto_id)
REFERENCES 				produtos (produto_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			envios 
ADD CONSTRAINT 			clientes_envios_fk
FOREIGN KEY 		 	(cliente_id)
REFERENCES 				clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			pedidos 
ADD CONSTRAINT 			clientes_pedidos_fk
FOREIGN KEY 			(cliente_id)
REFERENCES 				clientes (cliente_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			pedidos_itens 
ADD CONSTRAINT 			pedidos_pedidos_itens_fk
FOREIGN KEY 			(pedido_id)
REFERENCES 				pedidos (pedido_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 			pedidos_itens 
ADD CONSTRAINT 			envios_pedidos_itens_fk
FOREIGN KEY 			(envio_id)
REFERENCES 				envios (envio_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criação de restrições de checagem

ALTER TABLE 			pedidos
ADD CONSTRAINT 			cc_pedidos_status
CHECK 					(status IN ('CANCELADO', 'COMPLETO', 'ABERTO', 'PAGO', 'REEMBOLSADO', 'ENVIADO'));

ALTER TABLE 			envios
ADD CONSTRAINT 			cc_envios_status
CHECK 					(status IN ('CRIADO', 'ENVIADO', 'TRANSITO', 'ENTREGUE'));

ALTER TABLE 			lojas
ADD CONSTRAINT 			cc_lojas_endereco
CHECK 					((endereco_web IS NOT NULL) OR (endereco_fisico IS NOT NULL));

ALTER TABLE 			produtos
ADD CONSTRAINT 			cc_produtos_preco_unitario
CHECK 					(preco_unitario >= 0);

ALTER TABLE 			estoques
ADD CONSTRAINT 			cc_estoques_quantidade
CHECK 					(quantidade >= 0);

ALTER TABLE 			pedidos_itens
ADD CONSTRAINT 			cc_pedidos_itens_quantidade
CHECK 					(quantidade >= 0);

ALTER TABLE 			clientes
ADD CONSTRAINT 			cc_clientes_telefone1
CHECK 					(telefone1 !~ '^-');

ALTER TABLE 			clientes
ADD CONSTRAINT 			cc_clientes_telefone2
CHECK 					(telefone2 !~ '^-');

ALTER TABLE 			clientes
ADD CONSTRAINT 			cc_clientes_telefone3
CHECK 					(telefone3 !~ '^-');

ALTER TABLE 			pedidos_itens
ADD CONSTRAINT 			cc_pedidos_itens_preco_unitario
CHECK 					(preco_unitario >= 0);



