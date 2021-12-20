--Lab 4
--Katie Schramm
--10/28
PRINT 'Q1: List of auto transactions in Wausau ordered by the transaction value in ascending order'
SELECT T.TRAN_ID, T.PRICE*T.QUANTITY AS VALUE
FROM TB_TRANSACTIONS AS T, TB_PRODUCT AS P, TB_CONSUMER AS C
WHERE P.NAME='Auto' AND C.CITY='Wausau' AND P.PROD_ID=T.PROD_ID AND T.CON_ID=C.CON_ID
ORDER BY VALUE

PRINT 'Q2: List of the number and average value of computer requests in Wausau'
SELECT COUNT(C.CON_ID), AVG(R.PRICE*R.QUANTITY) AS VALUE
FROM TB_PRODUCT AS P,
	TB_CONSUMER AS C,
	TB_REQUESTS AS R
WHERE C.CON_ID=R.CON_ID 
	AND P.PROD_ID=R.PROD_ID
	AND P.NAME='COMPUTER' 
	AND C.CITY='WAUSAU'

PRINT 'Q3: List of names of suppliers offering both computers and autos (Do NOT use INTERSECT)'
SELECT NAME
FROM TB_SUPPLIER
WHERE SUPP_ID IN
	(SELECT DISTINCT SUPP_ID
	FROM TB_OFFERS AS O, TB_PRODUCT AS P
	WHERE O.PROD_ID=P.PROD_ID
		AND P.NAME='AUTO')
	AND SUPP_ID IN
		(SELECT DISTINCT SUPP_ID
		FROM TB_OFFERS O, TB_PRODUCT P
		WHERE O.PROD_ID=P.PROD_ID
		AND P.NAME='COMPUTER')

PRINT 'Q4: List of the consumer cities and number of consumers in each city'
SELECT CITY, COUNT(CON_ID) AS 'NUMBER OF CONSUMERS'
FROM TB_CONSUMER
GROUP BY CITY

PRINT 'Q5: List of the value of product offers for each supplier issuing at least one offer'
SELECT DISTINCT S.NAME, SUM(O.QUANTITY*O.PRICE) AS VALUE
FROM TB_SUPPLIER AS S, TB_OFFERS AS O
WHERE O.SUPP_ID=S.SUPP_ID
GROUP BY S.NAME

PRINT 'Q6: List of the name of consumers having at least 4 auto transactions'
SELECT C.NAME
FROM TB_CONSUMER AS C, TB_TRANSACTIONS AS T, TB_PRODUCT AS P
WHERE C.CON_ID=T.CON_ID
	AND P.PROD_ID=T.PROD_ID
	AND P.NAME='AUTO'
GROUP BY C.NAME HAVING 4<=COUNT(DISTINCT T.TRAN_ID)

PRINT 'Q7: List of the name of consumers having purchased at least 3 different products whose suppliers are from Wausau'
SELECT C.NAME
FROM TB_CONSUMER AS C, TB_TRANSACTIONS AS T, TB_SUPPLIER AS S
WHERE C.CON_ID=T.CON_ID
	AND S.SUPP_ID=T.SUPP_ID
	AND S.CITY='WAUSAU'
GROUP BY C.NAME
HAVING COUNT(T.PROD_ID)>2

PRINT 'Q8: List the amount spent by each consumer for each product type he/she purchased'
SELECT DISTINCT C.NAME AS 'CONSUMER', P.NAME AS 'PRODUCT', SUM(PRICE*T.QUANTITY) AS 'AMOUNT SPENT'
FROM TB_CONSUMER AS C, TB_TRANSACTIONS AS T, TB_PRODUCT AS P
WHERE C.CON_ID=T.CON_ID
	AND P.PROD_ID=T.PROD_ID
	AND P.PROD_ID=T.PROD_ID
GROUP BY C.NAME, P.NAME
ORDER BY C.NAME
		

PRINT 'Q9: List of the number of orange offers in each city that offers oranges'
SELECT CITY, COUNT(O.SUPP_ID) AS 'AMOUNT OF OFFERS'
FROM TB_SUPPLIER AS S, TB_OFFERS AS O, TB_PRODUCT AS P
WHERE S.SUPP_ID=O.SUPP_ID
	AND P.PROD_ID=O.PROD_ID
	AND P.NAME='ORANGE'
GROUP BY CITY

PRINT 'Q10: List the cities where the number of computer offers is less than the number of computer requests'SELECT DISTINCT S.City,COUNT(DISTINCT O.Supp_ID) AS "Computer Offers",COUNT(DISTINCT R.Con_ID) AS "Computer Requests"
FROM Tb_Supplier S, Tb_Consumer C,TB_Offers O, Tb_Requests R,Tb_Product P
WHERE S.Supp_ID=O.Supp_ID
	And O.Prod_ID=R.Prod_ID
	And R.Con_ID=C.Con_ID
	And S.City=C.City
	And P.Prod_ID=O.Prod_ID
	and P.Name='Computer'
GROUP BY S.City
HAVING COUNT(DISTINCT O.Supp_ID) < COUNT(DISTINCT R.Con_ID); 