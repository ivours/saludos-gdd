--9. Calificar al vendedor
--Mostrar un historial de las últimas cinco compras o subastas calificadas.
--Informar cuántas compras ha realizado el cliente junto con desglose por estrellas utilizadas.
--Lo mismo para las subastas.

CREATE FUNCTION SALUDOS.ultimasCincoCalificaciones(@usuario nvarchar(255))
RETURNS @calificaciones TABLE (Estrellas numeric(18,0), Descripción nvarchar(255), Fecha datetime) AS
	BEGIN
		INSERT @calificaciones
			SELECT TOP 5 CALI_ESTRELLAS, CALI_DESCRIPCION, CALI_FECHA
			FROM SALUDOS.CALIFICACIONES
			WHERE USUA_USERNAME = @usuario
			ORDER BY CALI_FECHA desc
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.calificacionesPendientes(@usuario nvarchar(255))
RETURNS @publicaciones TABLE (Código numeric(18,0), Descripción nvarchar(255), Precio numeric(18,2), Tipo nvarchar(255)) AS
BEGIN
	INSERT @publicaciones
		SELECT publ.PUBL_COD, PUBL_DESCRIPCION, TRAN_PRECIO, TIPO_NOMBRE
		FROM SALUDOS.TRANSACCIONES trns, SALUDOS.PUBLICACIONES publ, SALUDOS.TIPOS tipo
		WHERE	trns.PUBL_COD = publ.PUBL_COD AND
				trns.TIPO_COD = tipo.TIPO_COD AND
				trns.TRAN_ADJUDICADA = 1 AND
				trns.USUA_USERNAME = @usuario AND
				NOT EXISTS(	SELECT *
							FROM SALUDOS.CALIFICACIONES cali
							WHERE	publ.PUBL_COD = cali.PUBL_COD AND
									cali.USUA_USERNAME = trns.USUA_USERNAME)
	RETURN;
END
GO

CREATE FUNCTION SALUDOS.cuantasEstrellasPara(@usuario nvarchar(255), @estrellas int, @tipo_publicacion varchar(255))
RETURNS int AS
	BEGIN
		RETURN(
			SELECT COUNT(*)
			FROM SALUDOS.CALIFICACIONES cali, SALUDOS.PUBLICACIONES publ, SALUDOS.TIPOS tipo
			WHERE	cali.PUBL_COD = publ.PUBL_COD AND
					publ.TIPO_COD = tipo.TIPO_COD AND	
					cali.USUA_USERNAME = @usuario AND
					CALI_ESTRELLAS = @estrellas AND
					TIPO_NOMBRE = @tipo_publicacion
		)
	END
GO

CREATE FUNCTION SALUDOS.cantidadCalificacionesPendientes(@usuario nvarchar(255))
RETURNS int AS
	BEGIN
		RETURN(
			SELECT USUA_SIN_CALIFICAR
			FROM SALUDOS.USUARIOS
			WHERE USUA_USERNAME = @usuario
		)
	END
GO

CREATE PROCEDURE SALUDOS.calificarPublicacion(
	@usuario nvarchar(255),
	@publicacion numeric(18,0),
	@estrellas numeric(18,0),
	@descripcion nvarchar(255))
AS
	BEGIN
		DECLARE @fecha datetime
		SET @fecha = SALUDOS.fechaActual()

		INSERT INTO SALUDOS.CALIFICACIONES
			(USUA_USERNAME, PUBL_COD,
			CALI_ESTRELLAS, CALI_DESCRIPCION,
			CALI_FECHA)
		VALUES(
			@usuario, @publicacion,
			@estrellas, @descripcion,
			@fecha)
	END
GO
