--Listado Estadístico
--Esta funcionalidad debe permitir consultar el TOP 5 de:
--# Vendedores con mayor cantidad de productos no vendidos.
--  Dicho listado debe filtrarse por grado de visibilidad de la publicación y por mes-año.
--  Primero se deberá ordenar por fecha y luego por visibilidad.
--# Clientes con mayor cantidad de productos comprados, por mes y por año, dentro de un rubro particular
--# Vendedores con mayor cantidad de facturas dentro de un mes y año particular
--# Vendedores con mayor monto facturado dentro de un mes y año particular

--Esta función no devuelve nada post-migración porque todos los productos fueron vendidos.
CREATE FUNCTION SALUDOS.vendedoresConMayorCantidadDeProductosNoVendidos(@anio int, @trimestre int, @visibilidad nvarchar(255))
RETURNS @tabla TABLE (Vendedor nvarchar(255), Productos_sin_vender int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		DECLARE @codFinalizada int
		SET @codFinalizada = (	SELECT ESTA_COD
								FROM SALUDOS.ESTADOS
								WHERE ESTA_NOMBRE = 'Finalizada')
			
		INSERT @tabla
			SELECT TOP 5 usua.USUA_USERNAME, COUNT(*) cantidad
			FROM SALUDOS.USUARIOS usua, SALUDOS.PUBLICACIONES publ, SALUDOS.VISIBILIDADES visi
			WHERE	usua.USUA_USERNAME = publ.USUA_USERNAME AND
					publ.VISI_COD = visi.VISI_COD AND
					VISI_DESCRIPCION = @visibilidad AND
					ESTA_COD = @codFinalizada AND
					YEAR(publ.PUBL_FINALIZACION) = @anio AND
					(MONTH(publ.PUBL_FINALIZACION) BETWEEN @primerMes AND @tercerMes) AND
					NOT EXISTS (	SELECT comp.PUBL_COD
									FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ2
									WHERE publ2.PUBL_COD = comp.PUBL_COD AND publ2.PUBL_COD = publ.PUBL_COD)
			GROUP BY usua.USUA_USERNAME
			ORDER BY cantidad DESC
		RETURN;
	END
GO

--Lo mismo que para la función anterior.
CREATE FUNCTION SALUDOS.productosSinVenderDeUnVendedor(@anio int, @trimestre int, @usuario nvarchar(255), @visibilidad nvarchar(255))
RETURNS @tabla TABLE (	Código numeric(18,0), Descripción nvarchar(255), Precio numeric(18,2),
						Inicio datetime, Finalización datetime)
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		DECLARE @codFinalizada int
		SET @codFinalizada = (	SELECT ESTA_COD
								FROM SALUDOS.ESTADOS
								WHERE ESTA_NOMBRE = 'Finalizada')

		INSERT @tabla
			SELECT PUBL_COD, PUBL_DESCRIPCION, PUBL_PRECIO, PUBL_INICIO, PUBL_FINALIZACION
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.VISIBILIDADES visi
			WHERE	USUA_USERNAME = @usuario AND
					publ.VISI_COD = visi.VISI_COD AND
					VISI_DESCRIPCION = @visibilidad AND
					ESTA_COD = @codFinalizada AND
					YEAR(publ.PUBL_FINALIZACION) = @anio AND
					(MONTH(publ.PUBL_FINALIZACION) BETWEEN @primerMes AND @tercerMes) AND
					NOT EXISTS (	SELECT comp.PUBL_COD
									FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ2
									WHERE publ2.PUBL_COD = comp.PUBL_COD AND publ2.PUBL_COD = publ.PUBL_COD)
			ORDER BY publ.PUBL_INICIO
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.clientesMasCompradoresEnUnRubro(@anio int, @trimestre int, @rubro nvarchar(255))
RETURNS @tabla TABLE (Cliente nvarchar(255), Productos_comprados int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		INSERT @tabla
			SELECT TOP 5 comp.USUA_USERNAME, COUNT(COMP_COD) cantidad
			FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr
			WHERE	comp.PUBL_COD = publ.PUBL_COD AND
					publ.RUBR_COD = rubr.RUBR_COD AND
					YEAR(comp.COMP_FECHA) = @anio AND
					(MONTH(comp.COMP_FECHA) BETWEEN @primerMes AND @tercerMes) AND
					RUBR_NOMBRE = @rubro
			GROUP BY comp.USUA_USERNAME
			ORDER BY cantidad DESC 
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMasFacturas(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Facturas int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		INSERT @tabla
			SELECT TOP 5 USUA_USERNAME, COUNT(FACT_COD) cantidad
			FROM SALUDOS.FACTURAS
			WHERE	YEAR(FACT_FECHA) = @anio AND
					(MONTH(FACT_FECHA) BETWEEN @primerMes AND @tercerMes)
			GROUP BY USUA_USERNAME
			ORDER BY cantidad DESC
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMayorFacturacion(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Monto_Facturado int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		INSERT @tabla
			SELECT TOP 5 publ.USUA_USERNAME, SUM(COMP_PRECIO * COMP_CANTIDAD) monto
			FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
			WHERE	comp.PUBL_COD = publ.PUBL_COD AND
					YEAR(comp.COMP_FECHA) = @anio AND
					(MONTH(COMP.COMP_FECHA) BETWEEN @primerMes AND @tercerMes)
			GROUP BY publ.USUA_USERNAME
			ORDER BY monto DESC
		RETURN;
	END
GO
