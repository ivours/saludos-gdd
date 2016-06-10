--Historial del Cliente
--Se muestran en una grilla el historial de todas las transacciones de un cliente.

--Función para saber cantidad de páginas según un usuario y un tipo (compra inmediata o subasta).
--Se utiliza para la paginación al mostrar el historial de compras o subastas.
CREATE FUNCTION SALUDOS.cantidadDePaginasHistorialDe(@usuario nvarchar(255), @tipoDePublicacion nvarchar(255))
RETURNS int AS
	BEGIN
	DECLARE @cuenta decimal

	IF @tipoDePublicacion = 'Compras'
		BEGIN
			SET	@cuenta = (	SELECT COUNT(*)
							FROM SALUDOS.COMPRAS
							WHERE USUA_USERNAME = @usuario
							)
		END
	ELSE
		BEGIN
			SET	@cuenta = (	SELECT COUNT(*)
							FROM SALUDOS.OFERTAS
							WHERE USUA_USERNAME = @usuario
							)
		END
	
	SET @cuenta = CEILING(@cuenta / 10)

	RETURN CONVERT(int, @cuenta)

	END
GO	

CREATE FUNCTION SALUDOS.historialDeCompras(@usuario nvarchar(255))
RETURNS @compras TABLE (Código_Transacción numeric(18,0), Código_Publicación numeric(18,0),
						Descripción nvarchar(255), Precio numeric(18,2), Fecha datetime) AS
	BEGIN
		INSERT @compras
			SELECT COMP_COD, publ.PUBL_COD, PUBL_DESCRIPCION, COMP_PRECIO, COMP_FECHA
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.COMPRAS comp
			WHERE	publ.PUBL_COD = comp.PUBL_COD AND
					comp.USUA_USERNAME = @usuario
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.historialDeOfertas(@usuario nvarchar(255))
RETURNS @subastas TABLE (	Código_Transacción numeric(18,0), Código_Publicación numeric(18,0),
							Descripción nvarchar(255), Oferta numeric(18,2), Fecha datetime) AS
	BEGIN
		INSERT @subastas
			SELECT OFER_COD, publ.PUBL_COD, PUBL_DESCRIPCION, OFER_OFERTA, OFER_FECHA
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.OFERTAS ofer
			WHERE	publ.PUBL_COD = ofer.PUBL_COD AND
					ofer.USUA_USERNAME = @usuario
		RETURN;
	END
GO

