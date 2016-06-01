--Listado Estadístico
--Esta funcionalidad debe permitir consultar el TOP 5 de:
--# Vendedores con mayor cantidad de productos no vendidos.
--  Dicho listado debe filtrarse por grado de visibilidad de la publicación y por mes-año.
--  Primero se deberá ordenar por fecha y luego por visibilidad.
--# Clientes con mayor cantidad de productos comprados, por mes y por año, dentro de un rubro particular
--# Vendedores con mayor cantidad de facturas dentro de un mes y año particular
--# Vendedores con mayor monto facturado dentro de un mes y año particular

--Esta función no devuelve nada post-migración porque todos los productos fueron vendidos.
CREATE FUNCTION SALUDOS.vendedoresConMayorCantidadDeProductosNoVendidos(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Productos_sin_vender int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5 usua.USUA_USERNAME, COUNT(*) cantidad
			FROM SALUDOS.USUARIOS usua, SALUDOS.PUBLICACIONES publ
			WHERE	usua.USUA_USERNAME = publ.USUA_USERNAME AND
					NOT EXISTS (	SELECT trns.PUBL_COD
									FROM SALUDOS.TRANSACCIONES trns, SALUDOS.PUBLICACIONES publ2
									WHERE publ2.PUBL_COD = trns.PUBL_COD AND publ2.PUBL_COD = publ.PUBL_COD)
			GROUP BY usua.USUA_USERNAME
			ORDER BY cantidad DESC
		RETURN;
	END
GO

--Lo mismo que para la función anterior.
CREATE FUNCTION SALUDOS.productosSinVenderDeUnVendedor(@anio int, @trimestre int, @usuario nvarchar(255))
RETURNS @tabla TABLE (	Código numeric(18,0), Descripción nvarchar(255), Precio numeric(18,2),
						Inicio datetime, Finalización datetime)
	BEGIN
		INSERT @tabla
			SELECT PUBL_COD, PUBL_DESCRIPCION, PUBL_PRECIO, PUBL_INICIO, PUBL_FINALIZACION
			FROM SALUDOS.PUBLICACIONES publ
			WHERE USUA_USERNAME = @usuario AND
				NOT EXISTS (	SELECT trns.PUBL_COD
								FROM SALUDOS.TRANSACCIONES trns, SALUDOS.PUBLICACIONES publ2
								WHERE publ2.PUBL_COD = trns.PUBL_COD AND publ2.PUBL_COD = publ.PUBL_COD)
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.clientesMasCompradoresEnUnRubro(@anio int, @trimestre int, @rubro nvarchar(255))
RETURNS @tabla TABLE (Cliente nvarchar(255), Productos_comprados int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5 trns.USUA_USERNAME, COUNT(TRAN_COD) cantidad
			FROM SALUDOS.TRANSACCIONES trns, SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr
			WHERE	trns.PUBL_COD = publ.PUBL_COD AND
					publ.RUBR_COD = rubr.RUBR_COD AND
					TRAN_ADJUDICADA = 1 AND
					RUBR_NOMBRE = @rubro
			GROUP BY trns.USUA_USERNAME
			ORDER BY cantidad DESC 
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMasFacturas(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Facturas int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5 USUA_USERNAME, COUNT(FACT_COD) cantidad
			FROM SALUDOS.FACTURAS
			GROUP BY USUA_USERNAME
			ORDER BY cantidad DESC
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMayorFacturacion(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor numeric(18,0), Monto_Facturado int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5 publ.USUA_USERNAME, SUM(TRAN_PRECIO * TRAN_CANTIDAD_COMPRADA) monto
			FROM SALUDOS.TRANSACCIONES trns, SALUDOS.PUBLICACIONES publ
			WHERE	trns.PUBL_COD = publ.PUBL_COD AND
					TRAN_ADJUDICADA = 1
			GROUP BY publ.USUA_USERNAME
			ORDER BY monto DESC
		RETURN;
	END
GO
