print 'Q1: List of names of suppliers whose city starts with `M`'
SELECT name
from Tb_Supplier
where city like 'M%'

print 'Q2: List of names of products whose name starts with `A`, `C` or `O`'
select name
from Tb_Product
where name like '[ACO]%'

print 'Q3: List of names of consumers whose name starts with `S` and not ends with `h` or `r`'
select name
from Tb_Consumer
where name like 'S%' and name not like '%[hr]'

print 'Q4: List of names of consumers whose name does not start with `H` or `J` and has `a` in the third position'
select name
from Tb_Consumer
where name not like '[HJ]%' and name like '__a%'

print 'Q5: List of each product name and total transaction values for the product in each of the following supplier cities: Wausau, Chicago, Madison'
SELECT Tb_Product.Name,
	sum(Case when S.City='Wausau' Then T.Price*T.Quantity else 0 End) 'Wausau',
	sum(Case when S.City='Chicago' Then T.Price*T.Quantity else 0 End) 'Chicago',
	sum(Case when S.City='Madison' Then T.Price*T.Quantity else 0 End) 'Madison'
FROM Tb_Product,Tb_Supplier S,Tb_Transactions T
WHERE S.Supp_ID = T.Supp_ID
	AND Tb_Product.Prod_ID = T.Prod_ID
GROUP BY Tb_Product.Name; 

print 'Q6: Reduce by 10% the price of products having at least two offers'
update TB_Offers
set price=.9*price
where Prod_ID in
	(select prod_id
	from Tb_offers
	group by prod_id
	having count(Prod_ID)>1);

print 'Q7: Delete all offers for which there are no sales'
delete from TB_Offers
where not exists 
	(select * from Tb_Transactions 
	where TB_Offers.prod_id=Tb_Transactions.Prod_ID 
		and TB_Offers.Supp_ID=Tb_Transactions.Supp_ID)

select * from TB_Offers

print 'Q8: Reduce by 20% computer prices and prices for products having at least 4 offers'
UPDATE TB_Offers
SET Price=0.8*Price
WHERE Prod_ID IN
	(SELECT Prod_ID
	 FROM Tb_Product P
	 WHERE CASE
		     WHEN Name='computer' THEN 1
			 when (SELECT COUNT(*)
			     FROM Tb_Offers
			     WHERE Tb_Offers.Prod_ID=P.Prod_ID)>=4 then 1
			 else 0
  		   END=1);


select * from TB_Offers