-- Implementação do projeto lógico do Trabalho Integrado

CREATE TABLE Talento (
                id_talento 					VARCHAR(255) NOT NULL,
                participante 				VARCHAR(255) NOT NULL,
                CONSTRAINT id_talento_pk 	PRIMARY KEY (id_talento)
);
COMMENT ON TABLE Talento IS 					'Tabela para guardar dados relacionados aos talentos';
COMMENT ON COLUMN Talento.id_talento IS 		'Número de identificação do talento';
COMMENT ON COLUMN Talento.participante IS 		'Nome do participante de cada talento';


CREATE TABLE Talento_validacao (
                id_validacao 				VARCHAR(255) NOT NULL,
                id_talento 					VARCHAR(255) NOT NULL,
                nome_talento 				VARCHAR(255) NOT NULL,
                CONSTRAINT id_validacao_pk 	PRIMARY KEY (id_validacao)
);
COMMENT ON TABLE Talento_validacao IS 						'Tabela de validação de dados relacionados aos nomes dos talentos';
COMMENT ON COLUMN Talento_validacao.id_validacao IS 		'Número de identificação da validação';
COMMENT ON COLUMN Talento_validacao.id_talento IS 			'Número de identificação do talento';
COMMENT ON COLUMN Talento_validacao.nome_talento IS 		'Nome dos talentos';


CREATE TABLE Funcionario (
                id_funcionario 					VARCHAR(38) 	NOT NULL,
                nome_funcionario 				VARCHAR(255) 	NOT NULL,
                desc_funcionario 				VARCHAR(280) 	NOT NULL,
                foto_url 						VARCHAR(255) 	NOT NULL,
                data_ativo 						DATE 			NOT NULL,
                data_exclusao_conta 			DATE 			NOT NULL,
                funcao 							VARCHAR(255) 	NOT NULL,
                CONSTRAINT id_funcionario_pk 	PRIMARY KEY 	(id_funcionario)
);
COMMENT ON TABLE Funcionario IS 						'Tabela para guardar dados relacionandos aos funcionarios';
COMMENT ON COLUMN Funcionario.id_funcionario IS 		'Numero de identificação do funcionario';
COMMENT ON COLUMN Funcionario.nome_funcionario IS 		'Nome do funcionário';
COMMENT ON COLUMN Funcionario.desc_funcionario IS 		'Descrição do perfil do funcionário';
COMMENT ON COLUMN Funcionario.foto_url IS 				'Url da foto de perfil do funcionário';
COMMENT ON COLUMN Funcionario.data_ativo IS 			'Data da ultima vez que a conta ficou ativa';
COMMENT ON COLUMN Funcionario.data_exclusao_conta IS 	'Data de exclusao da conta do funcionário';
COMMENT ON COLUMN Funcionario.funcao IS 				'Define qual será a função do usuário: admin ou normal';


CREATE TABLE funcionario_talento (
                id_talento 								VARCHAR(255) NOT NULL,
                id_funcionario 							VARCHAR(38) NOT NULL,
                CONSTRAINT id_funcionario_talento_pk 	PRIMARY KEY (id_talento, id_funcionario)
);
COMMENT ON TABLE funcionario_talento IS 					'Tabela para vincular as tabelas funcionario e talento';
COMMENT ON COLUMN funcionario_talento.id_talento IS 		'Número de identificação do talento';
COMMENT ON COLUMN funcionario_talento.id_funcionario IS 	'Numero de identificação do funcionario';


CREATE TABLE Publicacoes (
                id_publicacao 				VARCHAR(255) 	NOT NULL,
                id_talento 					VARCHAR(255) 	NOT NULL,
                id_funcionario 				VARCHAR(38)	 	NOT NULL,
                nome_publicacao 			VARCHAR(255) 	NOT NULL,
                data_publicacao 			DATE 			NOT NULL,
                data_exclusao_publicacao 	DATE 			NOT NULL,
                imagem_url 					VARCHAR(255) 	NOT NULL,
                descricao 					VARCHAR(280) 	NOT NULL,
                CONSTRAINT id_publicacao_pk PRIMARY KEY 	(id_publicacao)
);
COMMENT ON TABLE Publicacoes IS 							'Tabela para guardar dados ralacionados as publicações';
COMMENT ON COLUMN Publicacoes.id_publicacao IS 				'Número de identificação da publicação';
COMMENT ON COLUMN Publicacoes.id_talento IS 				'Número de identificação do talento';
COMMENT ON COLUMN Publicacoes.id_funcionario IS 			'Numero de identificação do funcionario';
COMMENT ON COLUMN Publicacoes.nome_publicacao IS 			'Nome da publicação';
COMMENT ON COLUMN Publicacoes.data_publicacao IS 			'Data que foi realizada a publicação';
COMMENT ON COLUMN Publicacoes.data_exclusao_publicacao IS 	'Data que foi excluida a publicação';
COMMENT ON COLUMN Publicacoes.imagem_url IS 				'Url da imagem da publicação';
COMMENT ON COLUMN Publicacoes.descricao IS 					'Descrição da publicação';

-- Criando as Foregeing Keys
ALTER TABLE 		Publicacoes 
ADD CONSTRAINT 		talento_publicacoes_fk
FOREIGN KEY 		(id_talento)
REFERENCES 			Talento (id_talento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 		Talento_validacao 
ADD CONSTRAINT 		talento_talento_validacao_fk
FOREIGN KEY 		(id_talento)
REFERENCES 			Talento (id_talento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 		funcionario_talento 
ADD CONSTRAINT 		talento_funcionario_talento_fk
FOREIGN KEY 		(id_talento)
REFERENCES 			Talento (id_talento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 		Publicacoes 
ADD CONSTRAINT 		funcionario_publicacoes_fk
FOREIGN KEY 		(id_funcionario)
REFERENCES 			Funcionario (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE 		funcionario_talento 
ADD CONSTRAINT 		funcionario_funcionario_talento_fk
FOREIGN KEY 		(id_funcionario)
REFERENCES 			Funcionario (id_funcionario)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

-- Criação de restrições de checagem
ALTER TABLE 			Funcionario
ADD CONSTRAINT 			cc_funcao
CHECK 					(funcao IN ('ADMIN', 'NORMAL'));

ALTER TABLE 			Talento_validacao
ADD CONSTRAINT 			cc_nome_talento
CHECK 					(nome_talento IN ('ESPORTE', 'CULINARIA', 'MUSICAS', 'FESTA', 'VIAGENS', 'LIVROS'));
