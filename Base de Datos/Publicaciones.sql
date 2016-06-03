CREATE PROCEDURE SALUDOS.actualizarEstadosDePublicaciones AS
	
	DECLARE @fecha datetime
	DECLARE @codActiva int
	DECLARE @codFinalizada int
	
	SET @fecha = SALUDOS.fechaActual()

	SET @codActiva = (	SELECT ESTA_COD 
						FROM SALUDOS.ESTADOS
						WHERE ESTA_NOMBRE = 'Activa')
	
	SET @codFinalizada = (	SELECT ESTA_COD 
							FROM SALUDOS.ESTADOS
							WHERE ESTA_NOMBRE = 'Finalizada')

	UPDATE SALUDOS.PUBLICACIONES
	SET SALUDOS.PUBLICACIONES.ESTA_COD = @codActiva
	WHERE	PUBL_INICIO < @fecha AND
			PUBL_FINALIZACION > @fecha AND
			ESTA_COD IN (@codActiva, @codFinalizada)
			
	UPDATE SALUDOS.PUBLICACIONES
	SET SALUDOS.PUBLICACIONES.ESTA_COD = @codFinalizada
	WHERE  (PUBL_INICIO > @fecha OR
			PUBL_FINALIZACION < @fecha) AND
			ESTA_COD IN (@codActiva, @codFinalizada)
GO

