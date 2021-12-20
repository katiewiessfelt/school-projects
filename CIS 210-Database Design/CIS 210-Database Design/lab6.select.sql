--Lab 6
--Katie Schramm
--11/11

print 'Q1: List of names of consumers that are requesting computers, but not TVs'
SELECT C.NAME
FROM Tb_Consumer C, Tb_Requests R, Tb_Product P
WHERE C.Con_ID=R.Con_ID
	AND R.Prod_ID=P.Prod_ID
	AND P.NAME='COMPUTER'
	AND C.NAME NOT IN
		(SELECT C.NAME
		FROM Tb_Consumer C, Tb_Requests R, Tb_Product P
		WHERE C.Con_ID=R.Con_ID
			AND R.Prod_ID=P.Prod_ID
			AND P.NAME='TV')

print 'Q2: List of names of consumers requesting autos and TVs'
SELECT C.NAME
FROM Tb_Consumer C, Tb_Requests R, Tb_Product P
WHERE C.Con_ID=R.Con_ID
	AND R.Prod_ID=P.Prod_ID
	AND P.NAME='AUTO'
	AND C.NAME IN
		(SELECT C.NAME
		FROM Tb_Consumer C, Tb_Requests R, Tb_Product P
		WHERE C.Con_ID=R.Con_ID
			AND R.Prod_ID=P.Prod_ID
			AND P.NAME='TV')

print 'Q3: List of names of consumers and number of products for which they have requests'
SELECT NAME, COUNT(Prod_ID) '# of Requests'
FROM Tb_Consumer C, Tb_Requests R
WHERE R.Con_ID=C.Con_ID
GROUP BY NAME

print 'Q4: List of names of consumers and number of cities from which they purchased products'
SELECT C.NAME, COUNT(DISTINCT S.CITY) '# of Cities'
FROM Tb_Consumer C, Tb_Transactions T, Tb_Supplier S
WHERE C.Con_ID=T.Con_ID
	AND T.Supp_ID=S.Supp_ID
GROUP BY C.NAME

print 'Q5: List product for which the total offered quantities exceeds total requested quantities'
select p.Name, o.SQ as 'Offered Quantities', r.SQ as 'Requested Quantities'
from Tb_Product p,
	(select distinct prod_id, SUM(quantity) AS SQ
	from TB_Offers
	group by Prod_ID) o,
		(select distinct prod_id, SUM(quantity) AS SQ
		from Tb_Requests
		group by Prod_ID) r
	WHERE p.Prod_ID = o.Prod_ID
		AND p.Prod_ID = r.Prod_ID
		AND o.SQ > r.SQ
	ORDER BY p.Name;

print 'Q6: List of names of consumers that are not requesting any of the products offered by suppliers in Madison'
SELECT DISTINCT NAME
FROM Tb_Consumer C
WHERE Con_ID NOT IN
	(SELECT CON_ID
	FROM Tb_Requests R, TB_Offers O
	WHERE R.PROD_ID=O.Prod_ID
		AND O.SUPP_ID IN
		(SELECT Supp_ID
		FROM Tb_Supplier
		WHERE CITY='MADISON'))

print 'Q7: List of names of suppliers from Madison having sold computers and TV to consumers in Wausau'
SELECT S.NAME
FROM Tb_Supplier S, Tb_Transactions T, Tb_Product P, Tb_Consumer C
WHERE S.Supp_ID=T.Supp_ID
	AND T.Prod_ID=P.Prod_ID
	AND T.Con_ID=C.Con_ID
	AND S.CITY='MADISON'
	AND C.CITY='WAUSAU'
	AND P.NAME='COMPUTER'
INTERSECT
SELECT S.NAME
FROM Tb_Supplier S, Tb_Transactions T, Tb_Product P, Tb_Consumer C
WHERE S.Supp_ID=T.Supp_ID
	AND T.Prod_ID=P.Prod_ID
	AND T.Con_ID=C.Con_ID
	AND S.CITY='MADISON'
	AND C.CITY='WAUSAU'
	AND P.NAME='TV'

print 'Q8: List of names of suppliers offering only autos'
SELECT S.NAME
FROM Tb_Supplier S, TB_Offers O, Tb_Product P
WHERE S.Supp_ID=O.Supp_ID
	AND O.Prod_ID=P.Prod_ID
	AND P.NAME='AUTO'
	AND S.NAME NOT IN
		(SELECT DISTINCT S.NAME
		FROM Tb_Supplier S, TB_Offers O, Tb_Product P
		WHERE S.Supp_ID=O.Supp_ID
			AND O.Prod_ID=P.Prod_ID
			AND P.NAME<>'AUTO')

print 'Q9: List of names of products that are offered both in Wausau and Madison'
SELECT P.NAME
FROM Tb_Product P, TB_Offers O, Tb_Supplier S
WHERE O.Supp_ID=S.Supp_ID
	AND P.Prod_ID=O.Prod_ID
	AND S.City='WAUSAU'
INTERSECT
SELECT P.NAME
FROM Tb_Product P, TB_Offers O, Tb_Supplier S
WHERE O.Supp_ID=S.Supp_ID
	AND P.Prod_ID=O.Prod_ID
	AND S.City='MADISON'

print 'Q10: List of names of products that are not offered nor requested'
SELECT NAME
FROM Tb_Product
WHERE PROD_ID NOT IN
		(SELECT DISTINCT PROD_ID FROM TB_Offers)
	AND PROD_ID NOT IN
		(SELECT DISTINCT PROD_ID FROM TB_REQUESTS)