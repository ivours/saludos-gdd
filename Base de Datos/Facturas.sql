--10. Consultas de facturas realizadas al vendedor.
--Esta funcionalidad permite listar todas las facturas realizadas a un usuario vendedor,
--ya sean por comisión de publicación como ventas y envíos.
--Será necesario que se implementen una serie de filtros, como ser:
--intervalo de fechas, intervalos de importe, buscador por contenido de detalles de factura, a quién está dirigida.  
--Dichos resultados deberán listarse en una grilla, la cual deberá estar paginada.

CREATE FUNCTION SALUDOS.cantidadDeFacturas(
	@fechaInicio datetime, @fechaFinalizacion datetime,
	@codigoPublicacion numeric(18,0), @codigoFactura numeric(18,0),
	@importeMinimo int, @importeMaximo int,
	@destinatario nvarchar(255))
RETURNS int AS
	BEGIN
		DECLARE @cuenta decimal
		
		SET @cuenta = (
			SELECT COUNT(*)
			FROM SALUDOS.FACTURAS
			WHERE	(@fechaInicio <= FACT_FECHA OR @fechaInicio IS NULL) AND
					(@fechaFinalizacion >= FACT_FECHA OR @fechaInicio IS NULL) AND
					(@codigoPublicacion = PUBL_COD OR @codigoPublicacion IS NULL) AND
					(@codigoFactura = FACT_COD OR @codigoFactura IS NULL) AND
					(@importeMinimo <= FACT_TOTAL OR @importeMinimo IS NULL) AND
					(@importeMaximo >= FACT_TOTAL OR @importeMaximo IS NULL) AND
					(@destinatario = USUA_USERNAME OR @destinatario IS NULL)
		)

		SET @cuenta = CEILING(@cuenta / 10)

		RETURN CONVERT(int, @cuenta)

	END
GO

CREATE FUNCTION SALUDOS.facturasRealizadasAlVendedor(
	@fechaInicio datetime, @fechaFinalizacion datetime,
	@codigoPublicacion numeric(18,0), @codigoFactura numeric(18,0),
	@importeMinimo int, @importeMaximo int,
	@destinatario nvarchar(255))
RETURNS @facturas TABLE (	Código_Factura numeric(18,0), Código_Publicación numeric(18,0),
							Usuario nvarchar(255), Total numeric(18,2), Fecha datetime		) AS
	BEGIN
		INSERT @facturas
			SELECT FACT_COD, PUBL_COD, USUA_USERNAME, FACT_TOTAL, FACT_FECHA
			FROM SALUDOS.FACTURAS
			WHERE	(@fechaInicio <= FACT_FECHA OR @fechaInicio IS NULL) AND
					(@fechaFinalizacion >= FACT_FECHA OR @fechaInicio IS NULL) AND
					(@codigoPublicacion = PUBL_COD OR @codigoPublicacion IS NULL) AND
					(@codigoFactura = FACT_COD OR @codigoFactura IS NULL) AND
					(@importeMinimo <= FACT_TOTAL OR @importeMinimo IS NULL) AND
					(@importeMaximo >= FACT_TOTAL OR @importeMaximo IS NULL) AND
					(@destinatario = USUA_USERNAME OR @destinatario IS NULL)
			ORDER BY FACT_FECHA DESC
		RETURN;
	END
GO

CREATE PROCEDURE SALUDOS.facturarSubastasAdjudicadas AS
	BEGIN
		DECLARE cursorSubastasSinFacturar CURSOR FOR

			SELECT DISTINCT fact.PUBL_COD, COMP_PRECIO, COMP_OPTA_ENVIO
			FROM SALUDOS.FACTURAS fact, SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
			WHERE	fact.PUBL_COD = comp.PUBL_COD AND
					fact.PUBL_COD = publ.PUBL_COD AND
					publ.TIPO_COD = (	SELECT TIPO_COD
										FROM SALUDOS.TIPOS
										WHERE TIPO_NOMBRE = 'Subasta') AND
					publ.PUBL_COD IN (	SELECT p.PUBL_COD
										FROM SALUDOS.ITEMS i, SALUDOS.FACTURAS f, SALUDOS.PUBLICACIONES p
										WHERE	i.FACT_COD = f.FACT_COD AND
												f.PUBL_COD = p.PUBL_COD
										GROUP BY p.PUBL_COD
										HAVING COUNT(*) = 1)

			--código que creo que no sirve pero me da miedo borrar--
			--SELECT DISTINCT fact.PUBL_COD, COMP_PRECIO, COMP_OPTA_ENVIO
			--FROM SALUDOS.FACTURAS fact, SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
			--WHERE	fact.PUBL_COD = comp.PUBL_COD AND
			--		fact.PUBL_COD = publ.PUBL_COD AND
			--		publ.TIPO_COD = (	SELECT TIPO_COD
			--							FROM SALUDOS.TIPOS
			--							WHERE TIPO_NOMBRE = 'Subasta') AND
			--		NOT EXISTS (SELECT ITEM_COD
			--					FROM SALUDOS.ITEMS item
			--					WHERE	item.FACT_COD = fact.FACT_COD AND
			--							fact.PUBL_COD = comp.PUBL_COD AND
			--							ITEM_DESCRIPCION LIKE ('Comisión por Venta'))


			--SELECT DISTINCT fact.PUBL_COD, COMP_PRECIO, COMP_OPTA_ENVIO
			--FROM SALUDOS.FACTURAS fact, SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
			--WHERE	fact.PUBL_COD = comp.PUBL_COD AND
			--		fact.PUBL_COD = publ.PUBL_COD AND
			--		publ.TIPO_COD = (	SELECT TIPO_COD
			--							FROM SALUDOS.TIPOS
			--							WHERE TIPO_NOMBRE = 'Subasta') AND
			--		NOT EXISTS (SELECT COUNT(ITEM_COD)
			--					FROM SALUDOS.ITEMS item
			--					WHERE	item.FACT_COD = fact.FACT_COD AND
			--							fact.PUBL_COD = comp.PUBL_COD AND
			--							ITEM_DESCRIPCION LIKE ('Comisión por Venta')
			--					GROUP BY ITEM_COD
			--					HAVING COUNT(ITEM_COD) = 1)
							
			
			--select * from saludos.items where fact_cod = 180059
								
			----cantidad de items para una publicación
			--select p.publ_cod
			--from saludos.items i, saludos.facturas f, saludos.publicaciones p
			--where i.fact_cod = f.fact_cod AND f.publ_cod = p.publ_cod
			--group by p.publ_cod
			--having count(*) = 1
	
			--select * from saludos.facturas where publ_cod = 71079 -41 42 46 51 56

			--					select item_cod, count(item_cod)
			--					from saludos.items i, saludos.facturas f, saludos.publicaciones p
			--					where	f.publ_cod = p.publ_cod
			--					group by item_cod
										

			--SELECT publ_cod, COUNT(FACT_COD)
			--FROM SALUDOS.FACTURAS
			
			--group by publ_cod having count(fact_cod) >1 order by publ_cod
			--SELECT fact.PUBL_COD, COMP_PRECIO, COMP_OPTA_ENVIO
			--FROM SALUDOS.FACTURAS fact, SALUDOS.COMPRAS comp
			--WHERE COMP.publ_COD = fact.PUBL_COD AND 0 = (SELECT COUNT(ITEM_COD)
			--			FROM SALUDOS.ITEMS i, SALUDOS.FACTURAS f, SALUDOS.PUBLICACIONES p
			--			WHERE p.PUBL_COD = f.PUBL_COD AND f.FACT_COD = i.FACT_COD/* and f.publ_cod = fact.publ_cod*/
			--			AND item_descripcion like ('Comisión por Venta')) 

			DECLARE @codPublicacion numeric(18,0)
			DECLARE @precio numeric(18,2)
			DECLARE @optaEnvio bit

			OPEN cursorSubastasSinFacturar
				FETCH NEXT FROM cursorSubastasSinFacturar INTO @codPublicacion, @precio, @optaEnvio
				WHILE (@@FETCH_STATUS = 0)
	
				BEGIN
					IF @optaEnvio = 1
						BEGIN
							EXEC SALUDOS.facturarCompraYEnvio @codPublicacion, 1, @precio
						END
					ELSE
						BEGIN
							EXEC SALUDOS.facturarCompra @codPublicacion, 1, @precio
						END

					FETCH NEXT FROM cursorSubastasSinFacturar INTO @codPublicacion, @precio, @optaEnvio
				END

			CLOSE cursorSubastasSinFacturar
		DEALLOCATE cursorSubastasSinFacturar
	END
GO 

CREATE PROCEDURE SALUDOS.facturarPublicacion
	@codPublicacion numeric(18,0)
AS
	DECLARE @comisionPublicacion numeric(18,2)

	SET @comisionPublicacion =	(SELECT VISI_COMISION_PUBLICACION
								FROM SALUDOS.VISIBILIDADES
								WHERE VISI_COD = (	SELECT VISI_COD
													FROM SALUDOS.PUBLICACIONES
													WHERE PUBL_COD = @codPublicacion)
								)
	
	INSERT INTO SALUDOS.FACTURAS(
	FACT_FECHA, FACT_TOTAL, PUBL_COD, USUA_USERNAME)

	VALUES(
	saludos.fechaActual(), @comisionPublicacion, @codPublicacion,

	(SELECT USUA_USERNAME
	FROM SALUDOS.PUBLICACIONES
	WHERE PUBL_COD = @codPublicacion)
	)

	DECLARE @codFactura numeric(18,0)
	SET @codFactura = SCOPE_IDENTITY()

	INSERT INTO SALUDOS.ITEMS(
	ITEM_IMPORTE, ITEM_CANTIDAD,
	ITEM_DESCRIPCION, FACT_COD)

	VALUES(
	@comisionPublicacion, 1,
	'Comisión por Publicación', @codFactura
	)

GO

CREATE PROCEDURE SALUDOS.facturarPublicacionGratuita
	@codPublicacion numeric(18,0)
AS

INSERT INTO SALUDOS.FACTURAS(
	FACT_FECHA, FACT_TOTAL, PUBL_COD, USUA_USERNAME)

	VALUES(
	saludos.fechaActual(), 0.00, @codPublicacion,

	(SELECT USUA_USERNAME
	FROM SALUDOS.PUBLICACIONES
	WHERE PUBL_COD = @codPublicacion)
	)

	DECLARE @codFactura numeric(18,0)
	SET @codFactura = SCOPE_IDENTITY()

	INSERT INTO SALUDOS.ITEMS(
	ITEM_IMPORTE, ITEM_CANTIDAD,
	ITEM_DESCRIPCION, FACT_COD)

	VALUES(
	0, 1,
	'Comisión por Publicación', @codFactura
	)

GO

CREATE PROCEDURE SALUDOS.facturarCompra
	@codPublicacion numeric(18,0),
	@cantidadComprada numeric(18,0),
	@precio numeric(18,2)
AS
	DECLARE @comisionVenta numeric(18,2)
	SET @comisionVenta =	(SELECT VISI_COMISION_VENTA
							FROM SALUDOS.VISIBILIDADES
							WHERE VISI_COD = (	SELECT VISI_COD
												FROM SALUDOS.PUBLICACIONES
												WHERE PUBL_COD = @codPublicacion)
											 )
	
	INSERT INTO SALUDOS.FACTURAS(
	FACT_FECHA, PUBL_COD, FACT_TOTAL, USUA_USERNAME)

	VALUES(
	saludos.fechaActual(), @codPublicacion,
	@comisionVenta * @cantidadComprada * @precio, 

	(SELECT USUA_USERNAME
	FROM SALUDOS.PUBLICACIONES
	WHERE PUBL_COD = @codPublicacion)
	)

	DECLARE @codFactura numeric(18,0)
	SET @codFactura = SCOPE_IDENTITY()

	INSERT INTO SALUDOS.ITEMS(
	ITEM_IMPORTE, ITEM_CANTIDAD,
	ITEM_DESCRIPCION, FACT_COD)

	VALUES(
	@comisionVenta * @cantidadComprada * @precio, @cantidadComprada,
	'Comisión por Venta', @codFactura
	)

GO

CREATE PROCEDURE SALUDOS.facturarCompraYEnvio
	@codPublicacion numeric(18,0),
	@cantidadComprada numeric(18,0),
	@precio numeric(18,2)
AS
	DECLARE @comisionVenta numeric(18,2)
	SET @comisionVenta =	(SELECT VISI_COMISION_VENTA
							FROM SALUDOS.VISIBILIDADES
							WHERE VISI_COD = (	SELECT VISI_COD
												FROM SALUDOS.PUBLICACIONES
												WHERE PUBL_COD = @codPublicacion)
											 )
	DECLARE @comisionEnvio numeric(18,2)
	SET @comisionEnvio =	(SELECT VISI_COMISION_ENVIO
							FROM SALUDOS.VISIBILIDADES
							WHERE VISI_COD = (	SELECT VISI_COD
												FROM SALUDOS.PUBLICACIONES
												WHERE PUBL_COD = @codPublicacion)
											 )

	INSERT INTO SALUDOS.FACTURAS(
	FACT_FECHA, PUBL_COD, FACT_TOTAL, USUA_USERNAME)

	VALUES(
	saludos.fechaActual(), @codPublicacion,
	(@comisionVenta * @cantidadComprada * @precio) + (@comisionEnvio * @precio),

	(SELECT USUA_USERNAME
	FROM SALUDOS.PUBLICACIONES
	WHERE PUBL_COD = @codPublicacion)
	)

	DECLARE @codFactura numeric(18,0)
	SET @codFactura = SCOPE_IDENTITY()

	INSERT INTO SALUDOS.ITEMS(
	ITEM_IMPORTE, ITEM_CANTIDAD,
	ITEM_DESCRIPCION, FACT_COD)

	VALUES(
	@comisionVenta * @cantidadComprada * @precio, @cantidadComprada,
	'Comisión por Venta', @codFactura
	)

	INSERT INTO SALUDOS.ITEMS(
	ITEM_IMPORTE, ITEM_CANTIDAD,
	ITEM_DESCRIPCION, FACT_COD)

	VALUES(
	@comisionEnvio * @precio, 1,
	'Comisión por Envío', @codFactura
	)

GO
