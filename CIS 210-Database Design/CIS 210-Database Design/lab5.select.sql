PRINT 'Q1: List of names of consumers not requesting anything'
	SELECT NAME
	FROM Tb_Consumer
	WHERE Con_ID NOT IN
		(SELECT CON_ID
		FROM Tb_Requests R, Tb_Product P
		WHERE R.Prod_ID=P.Prod_ID)
PRINT 'Q2: List of names of consumers not requesting computers or autos'
	SELECT CON_ID, NAME
	FROM Tb_Consumer
	WHERE Con_ID NOT IN
		(SELECT CON_ID
		FROM Tb_Requests R, Tb_Product P
		WHERE R.Prod_ID=P.Prod_ID
			AND P.NAME='COMPUTER'
			OR P.NAME='AUTO')
PRINT 'Q3: List of names of consumers requesting at least one product but not requesting milk'
	(SELECT C.CON_ID, C.NAME
	 FROM TB_CONSUMER C, Tb_Requests R, TB_PRODUCT P
	 WHERE C.CON_ID=R.CON_ID
		AND R.PROD_ID=P.PROD_ID)
	EXCEPT
	(SELECT C.Con_ID, C.NAME
	 FROM TB_CONSUMER C, Tb_Requests R, TB_PRODUCT P
	 WHERE C.CON_ID=R.CON_ID
		AND R.PROD_ID=P.PROD_ID
		AND P.NAME='MILK')
PRINT 'Q4: List of names of consumers having purchased at least two product types' --(Don’t use aggregate function)
	SELECT Name
	FROM Tb_Consumer
	WHERE Con_ID IN
		(SELECT DISTINCT T1.Con_ID
		FROM Tb_Transactions T1, Tb_Transactions T2
		WHERE T1.Con_ID=T2.Con_ID AND T1.Prod_ID<>T2.Prod_ID)
PRINT 'Q5: List of names of consumers from Wausau with no suppliers from Stevens Point'
	SELECT Name
	FROM Tb_Consumer
	WHERE City='WAUSAU'
		AND CON_ID NOT IN
			(SELECT DISTINCT CON_ID
			 FROM Tb_Transactions, Tb_Supplier
			 WHERE Tb_Transactions.SUPP_ID=Tb_SUPPLIER.Supp_ID
				AND City='STEVENS POINT');
PRINT 'Q6: List of names of consumers that are not requesting computers nor oranges'
	SELECT NAME
	FROM TB_CONSUMER
	WHERE CON_ID NOT IN
			(SELECT CON_ID
			FROM Tb_Requests R, TB_PRODUCT P
			WHERE R.PROD_ID=P.PROD_ID
				AND NAME='COMPUTER'
				OR NAME='ORANGE')
PRINT 'Q7: List of names of suppliers having sales both for computers and autos'
	(SELECT S.NAME
	FROM Tb_Transactions T, TB_PRODUCT P, Tb_Supplier S
	WHERE T.PROD_ID=P.PROD_ID
		AND S.SUPP_ID=T.SUPP_ID
		AND P.NAME='AUTO')
	INTERSECT
	(SELECT S.NAME
	FROM Tb_Transactions T, TB_PRODUCT P, Tb_Supplier S
	WHERE T.PROD_ID=P.PROD_ID
		AND S.SUPP_ID=T.SUPP_ID
		AND P.NAME='COMPUTER')
PRINT 'Q8: List of names of suppliers having at most one consumer' --(Don’t use COUNT)
	select s.Name
	from tb_supplier s
	where s.supp_id not in
		(select t1.supp_id
		from tb_transactions t1, tb_transactions t2
		where t1.supp_id = t2.supp_id
			and t1.con_id <> t2.con_id); 

PRINT 'Q9: List of names of suppliers offering only computers'
	SELECT DISTINCT S.Name
	FROM Tb_Supplier S, TB_Offers O, Tb_Product P
	WHERE S.Supp_ID=O.Supp_ID
	    AND O.Prod_ID=P.Prod_ID
	    AND P.NAME ='COMPUTER'
	    AND S.Supp_ID NOT IN
		    (SELECT DISTINCT O.Supp_ID
			FROM TB_Offers O, Tb_Product P
			WHERE O.PROD_ID=P.PROD_ID
				AND P.NAME<>'COMPUTER')
PRINT 'Q10: List of names of suppliers offering only computers and trucks'
	SELECT DISTINCT S.Name
	FROM Tb_Supplier S, TB_Offers O, Tb_Product P
	WHERE S.Supp_ID=O.Supp_ID
	    AND O.Prod_ID=P.Prod_ID
	    AND P.NAME ='TRUCK'
	INTERSECT
	SELECT DISTINCT S.Name
	FROM Tb_Supplier S, TB_Offers O, Tb_Product P
	WHERE S.Supp_ID=O.Supp_ID
	    AND O.Prod_ID=P.Prod_ID
	    AND P.NAME ='COMPUTER'
	    AND O.Supp_ID NOT IN
		    (SELECT DISTINCT O.Supp_ID
			FROM TB_Offers O, Tb_Product P
			WHERE O.PROD_ID=P.PROD_ID
				AND P.NAME<>'TRUCK'
				AND P.NAME<>'COMPUTER')