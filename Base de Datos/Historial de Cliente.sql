--Historial del Cliente
--Se muestran en una grilla el historial de todas las transacciones de un cliente.

--Función para saber cantidad de páginas según un usuario y un tipo (compra inmediata o subasta).
--Se utiliza para la paginación al mostrar el historial de compras o subastas.
CREATE FUNCTION SALUDOS.cantidadDePaginasHistorialDe(@usuario nvarchar(255), @tipoDePublicacion nvarchar(255))
RETURNS int AS
	BEGIN
	DECLARE @cuenta decimal

	SET	@cuenta = (	SELECT COUNT(*)
					FROM SALUDOS.TRANSACCIONES trns, SALUDOS.TIPOS tipo
					WHERE	trns.TIPO_COD = tipo.TIPO_COD AND
							TIPO_NOMBRE = @tipoDePublicacion AND
							USUA_USERNAME = @usuario)
	
		SET @cuenta = CEILING(@cuenta / 10)

	RETURN CONVERT(int, @cuenta)

	END
GO	

CREATE FUNCTION SALUDOS.historialDeCompras(@usuario nvarchar(255))
RETURNS @compras TABLE (Código numeric(18,0), Descripción nvarchar(255), Precio numeric(18,2), Fecha datetime) AS
	BEGIN
		INSERT @compras
			SELECT trns.TRAN_COD, PUBL_DESCRIPCION, TRAN_PRECIO, TRAN_FECHA
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.TRANSACCIONES trns, SALUDOS.TIPOS tipo
			WHERE	publ.PUBL_COD = trns.PUBL_COD AND
					trns.TIPO_COD = tipo.TIPO_COD AND
					TIPO_NOMBRE = 'Compra Inmediata' AND
					trns.USUA_USERNAME = @usuario
			ORDER BY TRAN_FECHA DESC
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.historialDeSubastas(@usuario nvarchar(255))
RETURNS @subastas TABLE (	Código numeric(18,0), Descripción nvarchar(255),
							Oferta numeric(18,2), Adjudicada nvarchar(2), Fecha datetime) AS
	BEGIN
		INSERT @subastas
			SELECT	trns.TRAN_COD, PUBL_DESCRIPCION, TRAN_PRECIO,
					CASE WHEN TRAN_ADJUDICADA = 1 THEN 'Sí' ELSE 'No' END, TRAN_FECHA
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.TRANSACCIONES trns, SALUDOS.TIPOS tipo
			WHERE	publ.PUBL_COD = trns.PUBL_COD AND
					trns.TIPO_COD = tipo.TIPO_COD AND
					TIPO_NOMBRE = 'Subasta' AND
					trns.USUA_USERNAME = @usuario
			ORDER BY TRAN_FECHA DESC
		RETURN;
	END
GO
