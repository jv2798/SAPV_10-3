--HN
--10.1.1.64
SET DATEFORMAT YMD
go

IF OBJECT_ID('tempdb.dbo.##TiendasCerradas') IS NOT NULL 
    DROP TABLE ##TiendasCerradas  
    
    
IF OBJECT_ID('tempdb.dbo.##tiendas') IS NOT NULL 
    DROP TABLE ##tiendas  
GO

SET DATEFORMAT YMD
go

IF OBJECT_ID('tempdb.dbo.##TiendasCerradas') IS NOT NULL 
    DROP TABLE ##TiendasCerradas  
    
    
IF OBJECT_ID('tempdb.dbo.##tiendas') IS NOT NULL 
    DROP TABLE ##tiendas  
GO


SELECT  ROW_NUMBER() OVER ( ORDER BY NAME ASC ) consec ,
        '[' + name + '].[dbo].' Tienda
INTO    ##tiendas
FROM    sys.databases
WHERE   name LIKE 'SAPV%' AND name NOT IN ('SAPV000')


DECLARE @I INT ,
    @F INT ,
    @Ichar VARCHAR(3) ,
    @TSQL VARCHAR(6000) ,
    @ServerOrigen VARCHAR(30) ,
    @TiendaCerro CHAR(1) ,
    @tienda INT ,
    @t VARCHAR(100)
    

CREATE TABLE ##TiendasCerradas
    (
      CodigoTienda INT ,
      FechaInterna DATETIME ,
      telefono VARCHAR(15) ,
      Fax VARCHAR(15)
    )	

 
SELECT  @I = MIN(consec) ,
        @F = MAX(consec)
FROM    ##tiendas   
    
    
    
WHILE @I <= @F 
    BEGIN          
        SELECT  @ServerOrigen = Tienda
        FROM    ##tiendas
        WHERE   consec = @I  
            
        SELECT  @TSQL = 'insert ##TiendasCerradas 
			select codigotienda,fechainterna,TelefonoTienda,FaxTienda from'
                + @ServerOrigen
                + 'parametrostienda'
		
        EXEC (@TSQL)
        
        SET @I = @I + 1	

    END


--SELECT  *
--FROM    ##TiendasCerradas
--WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC)

---- USAR SI SE OCUPA RANGO DE FECHAS
----AND FechaInterna BETWEEN '2017-05-01 00:00:00.000'
----AND     '2017-05-01 00:00:00.000'


--ORDER BY FechaInterna 
DECLARE @HORA TIME = CONVERT (time, SYSDATETIME())
DECLARE @FechaActual DATE  = GETDATE()
DECLARE @FechadeCierre DATE = GETDATE()+1



IF @HORA < '10:00:00.000'

		BEGIN

				SELECT  COUNT(*) as 'Tiendas Cerradas'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna = @FechaActual -- tiendas Cerradas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'

				SELECT  COUNT(*) as 'Tiendas no cerradas'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna <  @FechaActual -- tiendas no cerradas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'


				SELECT  CodigoTienda,DATEDIFF(day, FechaInterna, getdate())+1 as 'N�mero de d�as que no han cerrado-Jader',FechaInterna,telefono,Fax
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna < @FechadeCierre -- todas las tiendas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'
				ORDER BY FechaInterna,CodigoTienda


				SELECT count(FechaInterna)	AS 'Cierres Pendiente'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna = @FechaActual

				SELECT count(FechaInterna)	AS 'Cierres Mayor de 1 dia '
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna < @FechaActual
		END

ELSE IF @HORA >= '10:00:00.000'  AND  @hora <= '15:45:00.000'        

		BEGIN

				SELECT  COUNT(*) as 'Tiendas Cerradas'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna = @FechaActual -- tiendas Cerradas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'

				SELECT  COUNT(*) as 'Tiendas no cerradas'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna <  @FechaActual -- tiendas no cerradas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'


				SELECT  CodigoTienda,DATEDIFF(day, FechaInterna, getdate())+1 as 'N�mero de d�as que no han cerrado-Jader',FechaInterna,telefono,Fax
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna < @FechadeCierre -- todas las tiendas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'
				ORDER BY FechaInterna,CodigoTienda

				SELECT count(FechaInterna)	AS 'Cierres Pendiente'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna = @FechaActual

				SELECT count(FechaInterna)	AS 'Cierres Mayor de 1 dia '
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna < @FechaActual
		END
ELSE

		BEGIN
		
				SELECT  COUNT(*) as 'Tiendas Cerradas'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna = @FechadeCierre -- tiendas Cerradas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'

				SELECT  COUNT(*) as 'Tiendas no cerradas'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna <=  @FechaActual -- tiendas no cerradas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'


				SELECT  CodigoTienda,DATEDIFF(day, FechaInterna, getdate())+1 as 'N�mero de d�as que no han cerrado-Jader',FechaInterna,telefono,Fax
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna < @FechadeCierre-- todas las tiendas.
				--        --AND FechaInterna BETWEEN '2016-07-16 00:00:00.000'
				--        --                 AND     '2016-07-19 00:00:00.000'
				ORDER BY FechaInterna,CodigoTienda	

				SELECT count(FechaInterna)	AS 'Cierres Pendiente'
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna = @FechaActual

				SELECT count(FechaInterna)	AS 'Cierres Mayor de 1 dia '
				FROM    ##TiendasCerradas
				WHERE   CodigoTienda NOT IN ( select CodigoTienda from  BDWork.dbo.TiendasCerradas_COC) AND FechaInterna < @FechaActual
		END	