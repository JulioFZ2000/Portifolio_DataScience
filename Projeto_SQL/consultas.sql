
/* 
		Análise de Vendas
	Quais foram od produtos mais vendidos no mês de fevereiro de 2023? 
*/

SELECT tpr.nome_prod,
    SUM(tpr.preco_prod * tip.qtd_produto) AS total_de_vendas_produto
FROM t_itens_pedido tip  
inner JOIN t_produtos tpr ON tip.id_produto = tpr.id_produto  
inner join t_pedidos tp on tip.id_pedido = tp.id_pedido
where tp.data_pedido BETWEEN '2023/02/01' and '2023/02/28' 
GROUP BY tpr.id_produto  
ORDER BY total_de_vendas_produto DESC;


/* 
		Desempenho por Região
	Qual a receita total por região em 6 meses?
*/

select tc.regiao,
	sum(tpr.preco_prod * tip.qtd_produto) as lucro_total
from t_clientes tc
inner join t_pedidos tp on tc.id_cliente = tp.id_cliente
inner join t_itens_pedido tip on tp.id_pedido = tip.id_pedido
inner join t_produtos tpr on tip.id_produto = tpr.id_produto
where tp.data_pedido BETWEEN '2023/01/01' and '2023/06/30' 
GROUP by tc.regiao
order by lucro_total desc;


/* 
		Cálculo de Média de Vendas
	Qual é a média de vendas diárias por produto nos últimos 3 meses?
*/

select tpr.nome_prod, 
	sum(tpr.preco_prod * tip.qtd_produto) / count (DISTINCT tp.data_pedido) as media_diaria_do_produto
from t_itens_pedido tip
inner join t_produtos tpr on tip.id_produto = tpr.id_produto
inner join t_pedidos tp on tip.id_pedido = tp.id_pedido
where tp.data_pedido between  '2023/01/01' and '2023/03/31' 
group by tpr.nome_prod
order by media_diaria_do_produto desc;


/* 
		Churn de Clientes
	Quantos clientes não realizaram compras nos últimos 3 meses?
*/
SELECT tc.nome_cli 
from t_clientes tc
where  tc.id_cliente not in (
	select tc.id_cliente
	from t_itens_pedido tip
	inner JOIN t_pedidos tp on tip.id_pedido = tp.id_pedido
	inner join t_clientes tc on tp.id_cliente = tc.id_cliente
	where tp.data_pedido  between  '2023/01/01' and '2023/03/31' 
)


/* 
		Desempenho de Produtos em Diferentes Períodos
	Como as vendas de um produto específico mudaram nos últimos 3 meses?
*/

select tpr.nome_prod, tp.data_pedido,
	sum(tpr.preco_prod * tip.qtd_produto) as valor_vendido_no_periodo
from t_itens_pedido tip
inner join t_produtos tpr on tip.id_produto = tpr.id_produto
inner join t_pedidos tp on tip.id_pedido = tp.id_pedido
where tp.data_pedido between '2023/01/01' and '2023/03/31' 
GROUP by tpr.nome_prod, tp.data_pedido
order by tp.data_pedido asc;


/* 
		Segmentação de Clientes
	Quantos clientes gastaram mais de R$1000 no último mês?
*/

SELECT tc.nome_cli, 
	sum(tpr.preco_prod * tip.qtd_produto) as valor_gasto
from t_itens_pedido tip
inner join t_produtos tpr on tip.id_produto = tpr.id_produto
inner join t_pedidos tp on tip.id_pedido = tp.id_pedido
inner join t_clientes tc on tp.id_cliente = tc.id_cliente
WHERE tp.data_pedido between '2023/01/01' and '2023/02/28' 
GROUP by tc.nome_cli
HAVING sum(tpr.preco_prod * tip.qtd_produto) >= 1000
order by valor_gasto desc;


/* 
		Produtos mais vendidos
	Quanto cada produto rendeu em vendas?
*/

SELECT tpr.nome_prod,
       SUM(tpr.preco_prod * tip.qtd_produto) AS total_vendas_produtos
FROM t_itens_pedido tip
inner jOIN t_produtos tpr ON tip.id_produto = tpr.id_produto
GROUP BY tip.id_produto
order by total_vendas_produtos desc;


/* 
	Qual a quantidades e valores totais de produtos vendidos para cada cliente

*/


SELECT tc.nome_cli, tpr.nome_prod, 
    SUM(tip.qtd_produto) AS qtd_total_produto, 
    SUM(tpr.preco_prod * tip.qtd_produto) AS valor_total_deste_produto
FROM t_clientes tc
inner JOIN t_pedidos tp ON tc.id_cliente = tp.id_cliente
inner JOIN t_itens_pedido tip ON tp.id_pedido = tip.id_pedido
inner JOIN t_produtos tpr ON tip.id_produto = tpr.id_produto
GROUP BY tc.nome_cli, tpr.nome_prod
ORDER BY tc.nome_cli DESC;


/* 
		Lucro com vendas concluidas
	Quanto foi os ganhos com pedidos entregues?
*/


select tp.status_pedido, 
	sum(tpr.preco_prod * tip.qtd_produto) as vendas_com_status_entregues
from t_itens_pedido tip
inner join t_pedidos tp on tip.id_pedido = tp.id_pedido
inner join t_produtos tpr on tip.id_produto = tpr.id_produto
where tp.status_pedido = 'entregue'
group by tp.status_pedido;


/* 
		Quantidade de produtos vendidos por Cliente
	Quanto foi a quantidade de produtos vendidas por Cliente?
*/


SELECT tc.nome_cli, 
       SUM(tip.qtd_produto) AS qtd_produtos_comprados
FROM t_clientes tc
INNER JOIN t_pedidos tp ON tc.id_cliente = tp.id_cliente
INNER JOIN t_itens_pedido tip ON tp.id_pedido = tip.id_pedido
GROUP BY tc.nome_cli
ORDER BY qtd_produtos_comprados DESC;






