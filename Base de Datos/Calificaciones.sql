--9. Calificar al vendedor
--Mostrar un historial de las últimas cinco compras o subastas calificadas.
--Informar cuántas compras ha realizado el cliente junto con desglose por estrellas utilizadas.
--Lo mismo para las subastas.

CREATE FUNCTION SALUDOS.ultimasCincoCalificaciones(@usuario nvarchar(255))
RETURNS @calificaciones TABLE (Estrellas numeric(18,0), Descripcion nvarchar(255), Fecha datetime) AS
	BEGIN
		INSERT @calificaciones
			SELECT TOP 5 CALI_ESTRELLAS, CALI_DESCRIPCION, CALI_FECHA
			FROM SALUDOS.CALIFICACIONES
			WHERE USUA_USERNAME = @usuario
			ORDER BY CALI_FECHA desc
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

CREATE FUNCTION SALUDOS.calificacionesPendientes(@usuario nvarchar(255))
RETURNS int AS
	BEGIN
		RETURN(
			SELECT USUA_SIN_CALIFICAR
			FROM SALUDOS.USUARIOS
			WHERE USUA_USERNAME = @usuario
		)
	END
GO
