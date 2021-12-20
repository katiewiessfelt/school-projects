--Katie Schramm
--Lab 7
--Due: 11/18

PRINT 'Q1: List of names of consumers having requests for all types of products'
SELECT Name 
FROM Tb_Consumer C
WHERE NOT EXISTS(
	SELECT *
	FROM Tb_Product P
	WHERE NOT EXISTS(
		SELECT *
		FROM Tb_Requests R
		WHERE C.Con_ID=R.Con_ID
			AND Prod_ID=P.Prod_ID));
PRINT 'Q2: List of names of consumers not having requests for all types of products'
SELECT Name 
FROM Tb_Consumer C
WHERE EXISTS(
	SELECT *
	FROM Tb_Product P
	WHERE NOT EXISTS(
		SELECT *
		FROM Tb_Requests R
		WHERE C.Con_ID=R.Con_ID
			AND Prod_ID=P.Prod_ID));

PRINT'Q3: List of names of consumers having purchased all types of products'
SELECT Name 
FROM Tb_Consumer C
WHERE NOT EXISTS
	(SELECT *
	FROM Tb_Product P
	WHERE NOT EXISTS
		(SELECT *
		FROM Tb_Transactions
		WHERE C.Con_ID=CON_ID
			AND  Prod_ID=P.Prod_ID))

PRINT'Q4: List of names of consumers having purchased all products for which they have requests'
SELECT Name 
FROM Tb_Consumer C
WHERE C.Con_ID IN (Select DISTINCT Con_ID
		From Tb_Requests)
	AND NOT EXISTS(SELECT *
		FROM Tb_Requests R
		WHERE C.Con_ID=R.Con_ID
			AND NOT EXISTS (SELECT *
				FROM Tb_Transactions
				WHERE C.Con_ID=Con_ID
					AND Prod_ID=R.Prod_ID));

PRINT 'Q5: List of names of consumers having purchases from all supplier cities'
SELECT NAME
FROM Tb_Consumer C
WHERE NOT EXISTS(
	SELECT DISTINCT CITY
	FROM Tb_Supplier
	EXCEPT
	SELECT DISTINCT CITY
	FROM Tb_Transactions T, Tb_Supplier S2
	WHERE T.SUPP_ID=S2.SUPP_ID
		AND C.CON_ID=T.CON_ID);

PRINT 'Q6: List of cheapest product(s) offered by each supplier and corresponding price'
SELECT S.Name, P.Name, O.Price AS 'Best Price'
FROM Tb_Supplier S, Tb_OFFERS O,Tb_Product P
WHERE S.SUPP_ID=O.SUPP_ID
	AND O.Prod_ID=P.Prod_ID
	AND O.Price <= ALL
		(SELECT PRICE
		FROM Tb_OFFERS
		WHERE S.SUPP_ID=TB_Offers.SUPP_ID)

PRINT 'Q7: List of name of consumer and the supplier city where he/she spent the most'
SELECT C.NAME, S.CITY, SUM(PRICE*QUANTITY) AS 'Amount Spent'
FROM Tb_Transactions T, Tb_Supplier S, Tb_Consumer C
WHERE T.Supp_ID=S.Supp_ID
	AND C.Con_ID=T.Con_ID
GROUP BY C.Con_ID, C.NAME, S.CITY
HAVING SUM(PRICE*QUANTITY)>=ALL(
	SELECT SUM(PRICE*QUANTITY)
	FROM Tb_Transactions T, Tb_Supplier S
	WHERE T.Supp_ID=S.Supp_ID
		AND C.Con_ID=T.Con_ID
	GROUP BY CON_ID, S.CITY)

PRINT 'Q8: List of name of supplier city where each product sold best'
SELECT P.NAME, S.CITY, SUM(QUANTITY) AS 'QUANTITY SOLD'
FROM Tb_Transactions T, Tb_Supplier S, Tb_Product P
WHERE T.Supp_ID=S.Supp_ID
	AND P.PROD_ID=T.PROD_ID
GROUP BY P.PROD_ID, P.NAME, S.CITY
HAVING SUM(QUANTITY)>=ALL(
	SELECT SUM(QUANTITY)
	FROM Tb_Transactions T, Tb_Supplier S
	WHERE T.Supp_ID=S.Supp_ID
		AND P.PROD_ID=T.PROD_ID
	GROUP BY PROD_ID, S.CITY)