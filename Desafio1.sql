create table tb_valores(
	id serial,
	quantidade integer,
	preco numeric(8,3),
	desconto numeric(8,3),
	total numeric(8,3)
)

insert into tb_valores (quantidade, preco, desconto, total)
	values (2, 3.5, 1, 0);
insert into tb_valores (quantidade, preco, desconto, total)
	values (4, 8.29, 2, 0);
insert into tb_valores (quantidade, preco, desconto, total)
	values (1, 2.33, 0.5, 0);
insert into tb_valores (quantidade, preco, desconto, total)
	values (3, 1.10, 0, 0);
insert into tb_valores (quantidade, preco, desconto, total)
	values (10, 2.75, 0, 0);
	update  tb_valores set total=(preco*quantidade) - desconto;
	select * from tb_valores
	select sum(total) from tb_valores;
	