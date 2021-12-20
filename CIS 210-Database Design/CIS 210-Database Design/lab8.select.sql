--Katie Schramm
--Lab 8
--Due: December 2
PRINT'Q1: List of consumer names and number of requests for each (0 if no requests)'
SELECT C.NAME, COUNT(R.Prod_ID) 'NUMBER OF REQUESTS'
FROM Tb_Consumer C LEFT JOIN Tb_Requests R ON C.Con_ID=R.CON_ID
GROUP BY NAME

PRINT 'Q2: List of consumer names from Wausau and number of computer requests for each (0 if no requests)'
SELECT TB_CONSUMER.Name, COUNT(TB_PRODUCT.Prod_ID) REQUESTS_Count
FROM Tb_Consumer FULL JOIN 
	(Tb_Requests INNER JOIN Tb_Product 
		ON Tb_Requests.Prod_ID=Tb_Product.PROD_ID
		AND TB_PRODUCT.NAME='COMPUTER')
	ON Tb_Consumer.Con_ID=Tb_Requests.Con_ID
WHERE City='WAUSAU'
GROUP BY TB_CONSUMER.Name;

PRINT 'Q3: List of supplier names from Wausau and number of offers for each (0 if no offers)'
SELECT Name, COUNT(Prod_ID) Offers_Count
FROM Tb_Supplier LEFT JOIN Tb_Offers ON Tb_Supplier.Supp_ID=Tb_Offers.Supp_ID
WHERE City='WAUSAU'
GROUP BY Name

PRINT 'Q4: List of product names and average value of offers for that product (0 if no offers)'
SELECT Name, AVG(ISNULL(QUANTITY*PRICE, 0)) Offers_Count
FROM Tb_Product LEFT JOIN Tb_Offers ON Tb_PRODUCT.PROD_ID=Tb_Offers.PROD_ID
GROUP BY Name

PRINT 'Q5: List of product names and number of offers and requests for each product (0 if no offers or no requests)'
SELECT ISNULL(Tb_Product.Name,Tb_Product.Name) Name,
COUNT(DISTINCT Supp_ID) 'Number of Offers',
COUNT(DISTINCT Con_ID) 'Number of Requests'
FROM TB_Offers FULL JOIN 
	(Tb_Product left join tb_requests ON Tb_Product.Prod_ID=Tb_Requests.Prod_ID) 
	on Tb_Product.Prod_ID=TB_Offers.Prod_ID
GROUP BY name; 

PRINT 'Q6: List of product names and average value of offers, requests and transactions (0 if none)'
SELECT Name,
count(distinct tb_offers.supp_ID) offers,
AVG(isnull(tb_offers.Quantity*tb_offers.Price, 0)) 'Avg Offers',
count(distinct tb_requests.Con_ID) requests,
AVG(isnull(tb_requests.Quantity*tb_requests.Price, 0)) 'Avg Requests',
count(distinct Tb_Transactions.tran_ID) transactions,
AVG(isnull(Tb_Transactions.Quantity*Tb_Transactions.Price, 0)) 'Avg Transaction'
FROM TB_Offers FULL JOIN 
	(tb_requests full join
		(Tb_Transactions full join Tb_Product ON Tb_Product.Prod_ID=Tb_Transactions.Prod_ID)
	on Tb_Product.Prod_ID=Tb_Requests.Prod_ID)
	on Tb_Product.Prod_ID=TB_Offers.Prod_ID
GROUP BY name

PRINT 'Q7: List of Consumer-Product pairs and quantity of product requested by consumer(0 if none)'
SELECT Tb_Consumer.Name Consumer,Tb_Product.Name Product,
		sum(isnull(quantity, 0)) 'Quantity Requested'
FROM Tb_Requests RIGHT JOIN
          (Tb_Product CROSS JOIN Tb_Consumer)
	   ON Tb_requests.prod_ID=Tb_product.prod_ID
	  AND Tb_Consumer.Con_ID=Tb_requests.Con_ID
GROUP BY Tb_product.Name, Tb_consumer.Name

PRINT 'Q8: List of pairs of Supplier-Consumer cities and number of Supplier-Consumers pairs, with supplier in the first city and consumer in the second city, having at least one transaction between them (0 if no transactions between the two cities)'SELECT SCity 'Supplier City',CCity 'Consumer City',COUNT(Supp_ID) 'Number of Supplier-Consumer Pairs'
FROM (SELECT S.City AS SCity,C.City AS CCity,T.Supp_ID,T.Con_ID
	FROM (Tb_Supplier S CROSS JOIN Tb_Consumer C) LEFT JOIN Tb_Transactions T ON 
			T.Con_ID=C.Con_ID AND S.Supp_ID=T.Supp_ID
	GROUP BY S.City,C.City,T.Supp_ID,T.Con_ID) SC
GROUP BY SCity,CCity
ORDER BY SCity,CCity