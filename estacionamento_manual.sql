drop  table tb_marca CASCADE;
drop  table tb_modelo  CASCADE;
drop  table tb_veiculo CASCADE;
drop  table tb_condutor CASCADE;
drop  table tb_Movimentacao CASCADE;
drop  table tb_movimentacao CASCADE;

create table tb_marca(
	id serial ,
	nome varchar(100) not null
);
	insert into tb_marca(nome) values ('Honda');
	insert into tb_marca(nome) values('Ford');
	insert into tb_marca(nome) values('Mercedes');
	
select * from tb_marca;
	
create table tb_modelo(
	id serial,
	nome varchar (100) not null,
	marca_id integer not null
);
insert into tb_modelo(nome, marca_id) values ('City',1);
insert into tb_modelo(nome, marca_id) values ('F1000',2);
insert into tb_modelo(nome, marca_id) values ('Sprinter',3);

select * from tb_modelo;

create table tb_veiculo(
	id serial,
	placa varchar(12) not null unique,
	modelo_id integer not null,
	cor varchar(35) not null,
	tipo varchar(6) not null,
	ano integer not null
);


select * from tb_veiculo;

insert into tb_veiculo(placa, modelo_id, cor, tipo, ano) values ('ABC-123', 1, 'vermelho', 'carro',1980);
insert into tb_veiculo(placa, modelo_id, cor, tipo, ano) values ('DEF-456', 2, 'amarelo', 'moto',2005);
insert into tb_veiculo(placa, modelo_id, cor, tipo, ano) values ('GHI-789', 3, 'preto', 'van',2015);


create table tb_condutor (
	id serial,
	nome varchar(100) not null,
	cpf varchar(15) not null,
	telefone varchar(17) not null,
	tempoPago interval,
	tempoDesconto interval
);

CREATE OR REPLACE FUNCTION cpf_validacao() 
RETURNS trigger AS 
$$ BEGIN
  IF  NEW.cpf !~ '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}-[0-9]{2}$' THEN /* [0-9] é uma classe de caracteres que representa qualquer dígito de 0 a 9.
												{3} indica que a classe de caracteres anterior ([0-9]) deve aparecer exatamente 3 vezes.*/
    RAISE EXCEPTION 'CPF inválido, Lembre-se que deve ter 14 caracteres e estar no formato 000.000.000-00, composto apenas por numeros e simbolos';
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trigger_cpf 
BEFORE INSERT ON tb_condutor
FOR EACH ROW 
EXECUTE FUNCTION cpf_validacao();



select * from tb_condutor;

insert into tb_condutor(nome, cpf, telefone, tempoPago, tempoDesconto) values ('Cleitin', '120.521.622-88', '+45 8591-268','50 hours','5 hours');
insert into tb_condutor(nome, cpf, telefone, tempoPago, tempoDesconto) values ('Vanderzin', '124.521.897-22', '+45 8741-564','12 hours', '0 hours');
insert into tb_condutor(nome, cpf, telefone, tempoPago, tempoDesconto) values ('Pedrin', '120.521.645-11', '+45 6842-974','100 hours', '10 hours');
insert into tb_condutor(nome, cpf, telefone) values ('Pedrin', '120.521.622-98', '+45 6842-974');

create table tb_Movimentacao(
	id serial,
	valorHora numeric,
	valorMinutoMulta numeric,
	fimExpediente Timestamp,
	tempoParaDesconto interval,
	gerarDesconto bool,
	vagasMoto integer,
	vagasCarro integer,
	vagasVan integer
);
insert into tb_Movimentacao(valorhora, valorMinutoMulta, fimExpediente, tempoParaDesconto,gerarDesconto,vagasMoto,vagasCarro,vagasVan)
values (20,1,'2023-03-29 23:00:00','50 hours','no',10,15,8);

select * from tb_Movimentacao;
 
create table tb_movimentacao(
	id serial,
	Movimentacao_id integer not null,
	veiculo_id integer not null,
	condutor_id integer not null,
	entrada Timestamp,
	saida Timestamp,
	tempo interval,
	tempoMulta interval,
	tempoDesconto interval,
	valorDesconto numeric(8,3),
	valorHoraMulta numeric(8,3),
	valorHora numeric(8,3),
	valorMulta numeric(8,3),
	valorTotal numeric(8,3)
);

	alter table tb_marca add primary key (id);
	alter table tb_modelo add primary key (id);
	alter table tb_condutor add primary key (id);
	alter table tb_movimentacao add primary key (id);
	alter table tb_veiculo add primary key (id);
	
	alter table tb_modelo add unique (nome);
	alter table tb_marca add unique (nome);
	alter table tb_condutor add unique (cpf);
	
	alter table tb_modelo add foreign key (marca_id) references tb_marca(id);
	alter table tb_veiculo add foreign key (modelo_id) references tb_modelo (id);
	alter table tb_movimentacao add foreign key (veiculo_id) references tb_veiculo(id);
	alter table tb_movimentacao add foreign key (Movimentacao_id) references tb_movimentacao(id);
	alter table tb_movimentacao add foreign key (condutor_id) references tb_condutor(id);

	insert into tb_movimentacao(veiculo_id, condutor_id,Movimentacao_id ,entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,1,1,'2023-01-02 14:30:00','2023-01-02 22:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,Movimentacao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-01-02 14:10:00','2023-01-02 21:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,Movimentacao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,2,1,'2023-01-03 16:10:00','2023-01-03 21:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,Movimentacao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,3,1,'2023-01-29 13:20:00','2023-01-29 22:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-01-29 14:10:00','2023-01-29 21:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,2,1,'2023-01-30 08:10:00','2023-01-30 22:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,1,1,'2023-01-30 08:10:00','2023-01-30 22:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,1,1,'2023-03-29 05:10:00','2023-03-29 23:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-03-29 10:10:00','2023-03-29 21:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,1,1,'2023-03-29 11:10:00','2023-03-29 22:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,3,1,'2023-03-30 14:30:00','2023-03-30 20:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-04-01 14:10:00','2023-04-01 21:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,1,1,'2023-04-02 04:10:00','2023-04-2 23:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,1,1,'2023-04-03 14:10:00','2023-04-03 21:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,3,1,'2023-04-04 02:10:00','2023-04-04 15:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,2,1,'2023-04-05 12:00:00','2023-04-05 18:30:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,1,1,'2023-04-06 01:00:00','2023-04-06 12:30:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,2,1,'2023-04-07 02:00:00','2023-04-07 03:33:33',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,3,1,'2023-04-05 09:30:00','2023-04-05 19:30:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,1,1,'2023-04-05 12:00:00','2023-04-05 18:30:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,3,1,'2023-04-06 03:00:00','2023-04-06 03:33:33',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,2,1,'2023-04-06 04:00:00','2023-04-06 05:33:33',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,1,1,'2023-04-06 06:00:00','2023-04-06 08:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-04-07 02:00:00','2023-04-07 23:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,3,1,'2023-04-07 02:00:00','2023-04-07 23:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,1,1,'2023-04-07 06:30:00','2023-04-07 23:00:00',
			'0 hours','0 hours',0,0);
			
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-04-08 03:00:00','2023-04-08 05:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,1,1,'2023-04-08 06:00:00','2023-04-08 10:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (3,3,1,'2023-04-08 08:00:00','2023-04-08 22:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (2,2,1,'2023-04-09 03:33:00','2023-04-09 05:00:00',
			'0 hours','0 hours',0,0);
	insert into tb_movimentacao(veiculo_id, condutor_id,configuracao_id, entrada,saida,tempoMulta,tempoDesconto,
			valorDesconto,valorHoraMulta) values (1,3,1,'2023-04-09 05:00:00','2023-04-09 23:00:00',
			'0 hours','0 hours',0,0);
	
	update tb_movimentacao set tempo = AGE(saida,entrada);
	update tb_movimentacao set valorTotal = (EXTRACT(HOUR FROM tempo) * (SELECT valorHora FROM tb_configuracao) 
                 + (EXTRACT(MINUTE FROM tempo) * (SELECT  valorHora FROM tb_configuracao) / 60));		 
	update tb_movimentacao set valorHoraMulta = (60*(SELECT valorMinutoMulta from tb_configuracao));
	update tb_movimentacao set valorHora = (SELECT valorHora FROM tb_configuracao);
	update tb_movimentacao set valorMulta = (SELECT valorMinutoMulta FROM tb_configuracao);
	
	CREATE view mais_visitas as 
	SELECT COUNT(veiculo.placa) as "VISITAS", placa as "Placa" FROM tb_veiculo veiculo INNER JOIN tb_movimentacao movimentacao ON movimentacao.veiculo_id = veiculo.id  GROUP BY veiculo.placa ORDER BY "VISITAS" DESC LIMIT 1;
	
	CREATE view visita_janeiro as 
	SELECT COUNT(veiculo.placa) as "VISITAS JANEIRO", placa as "Placa" FROM tb_veiculo veiculo INNER JOIN tb_movimentacao movimentacao  ON movimentacao.veiculo_id = veiculo.id WHERE movimentacao.entrada BETWEEN '2023-01-01' AND '2023-01-31' GROUP BY veiculo.placa ORDER BY "VISITAS JANEIRO" DESC LIMIT 1;
	
	CREATE view maisTempoV as 
	SELECT SUM(movimentacao.tempo) as "Tempo", veiculo.placa as "Placa" FROM tb_movimentacao movimentacao INNER JOIN tb_veiculo veiculo ON movimentacao.veiculo_id = veiculo.id  GROUP BY veiculo.placa ORDER BY "Tempo" DESC LIMIT 1;
	
	CREATE view maisTempoC as 
	SELECT SUM(movimentacao.tempo) as "Tempo", condutor.nome as "CONDUTOR" FROM tb_movimentacao movimentacao INNER JOIN tb_condutor condutor ON movimentacao.condutor_id = condutor.id  GROUP BY condutor.nome ORDER BY "Tempo" DESC LIMIT 1;

	
	select * from tb_movimentacao;
	
	select * from mais_visitas;
	
	select * from visita_janeiro;
	
	select * from maisTempoV;
	
	select * from maisTempoC;
