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
	WHERE	PUBL_INICIO <= @fecha AND
			PUBL_FINALIZACION > @fecha AND
			ESTA_COD IN (@codActiva, @codFinalizada)
			
	UPDATE SALUDOS.PUBLICACIONES
	SET SALUDOS.PUBLICACIONES.ESTA_COD = @codFinalizada
	WHERE  (PUBL_INICIO > @fecha OR
			PUBL_FINALIZACION <= @fecha) AND
			ESTA_COD IN (@codActiva, @codFinalizada)
GO

CREATE PROCEDURE SALUDOS.adjudicarSubastas AS
	DECLARE @tipoSubasta int

	SET @tipoSubasta = (SELECT TIPO_COD
						FROM SALUDOS.TIPOS
						WHERE TIPO_NOMBRE = 'Subasta')
	
	DECLARE @codFinalizada int
	SET @codFinalizada = (	SELECT ESTA_COD 
							FROM SALUDOS.ESTADOS
							WHERE ESTA_NOMBRE = 'Finalizada')

	INSERT INTO SALUDOS.COMPRAS(
	COMP_CANTIDAD, COMP_FECHA, COMP_FORMA_PAGO,
	COMP_PRECIO, PUBL_COD, USUA_USERNAME)

	SELECT DISTINCT
	1, OFER_FECHA, 'Efectivo',
	OFER_OFERTA, t1.PUBL_COD, t1.USUA_USERNAME

	FROM SALUDOS.OFERTAS t1, SALUDOS.PUBLICACIONES publ
	WHERE	publ.PUBL_COD = t1.PUBL_COD AND
			TIPO_COD = @tipoSubasta AND
			ESTA_COD = @codFinalizada AND
			OFER_OFERTA = 	(SELECT MAX(OFER_OFERTA)
							FROM SALUDOS.OFERTAS t2
							WHERE t2.PUBL_COD = t1.PUBL_COD)
GO


CREATE PROCEDURE SALUDOS.crearPublicacion
	@usuario nvarchar(255),
	@tipo nvarchar(255),
	@descripcion nvarchar(255),
	@stock numeric(18,0),
	@precio numeric(18,2),
	@rubro nvarchar(255),
	@estado nvarchar(255),
	@preguntas bit,
	@visibilidad nvarchar(255),
	@envio bit
AS
	INSERT INTO SALUDOS.PUBLICACIONES(
	USUA_USERNAME, TIPO_COD, PUBL_DESCRIPCION,
	PUBL_STOCK, PUBL_PRECIO, RUBR_COD, ESTA_COD,
	PUBL_PREGUNTAS,	VISI_COD, PUBL_PERMITE_ENVIO,
	PUBL_INICIO, PUBL_FINALIZACION)

	VALUES(
	(SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS
	WHERE USUA_USERNAME = @usuario),

	(SELECT TIPO_COD
	FROM SALUDOS.TIPOS
	WHERE TIPO_NOMBRE = @tipo),

	@descripcion, @stock, @precio,

	(SELECT RUBR_COD
	FROM SALUDOS.RUBROS
	WHERE RUBR_NOMBRE = @rubro),

	(SELECT ESTA_COD
	FROM SALUDOS.ESTADOS
	WHERE ESTA_NOMBRE = @estado),

	@preguntas,

	(SELECT VISI_COD
	FROM SALUDOS.VISIBILIDADES
	WHERE VISI_DESCRIPCION = @visibilidad),

	@envio,

	(SELECT SALUDOS.fechaActual()),

	DATEADD(day, 7, SALUDOS.fechaActual())
	)
GO

CREATE FUNCTION SALUDOS.stockActual(@codPublicacion numeric(18,0))
RETURNS int AS
	BEGIN
		DECLARE @cantidadComprada int
		
		SET @cantidadComprada = (
			SELECT SUM(TRAN_CANTIDAD_COMPRADA)
			FROM SALUDOS.TRANSACCIONES
			WHERE	PUBL_COD = @codPublicacion AND
					TRAN_FECHA <= SALUDOS.fechaActual()
		)

		IF @cantidadComprada IS NULL
			SET @cantidadComprada = 0

		DECLARE @stockInicial int
		SET @stockInicial = (
			SELECT PUBL_STOCK
			FROM SALUDOS.PUBLICACIONES
			WHERE PUBL_COD = @codPublicacion
		)

		RETURN (@stockInicial - @cantidadComprada)
	END
GO

CREATE PROCEDURE SALUDOS.comprar
	@codPublicacion numeric(18,0),
	@cantidadComprada int,
	@usuario nvarchar(255)
AS
	INSERT INTO SALUDOS.TRANSACCIONES(
	PUBL_COD, TIPO_COD, TRAN_ADJUDICADA,
	TRAN_CANTIDAD_COMPRADA, TRAN_FECHA,
	TRAN_FORMA_PAGO, TRAN_PRECIO, USUA_USERNAME)

	VALUES(
	@codPublicacion,
	
	(SELECT TIPO_COD
	FROM SALUDOS.TIPOS
	WHERE TIPO_NOMBRE = 'Compra Inmediata'),
	
	1, @cantidadComprada,
	SALUDOS.fechaActual(), 'Efectivo',

	(SELECT PUBL_PRECIO
	FROM SALUDOS.PUBLICACIONES
	WHERE PUBL_COD = @codPublicacion),

	@usuario
	)
GO

CREATE PROCEDURE SALUDOS.ofertar
	@codPublicacion numeric(18,0),
	@oferta numeric(18,2),
	@usuario nvarchar(255)
AS
	INSERT INTO SALUDOS.TRANSACCIONES(
	PUBL_COD, TIPO_COD, TRAN_ADJUDICADA,
	TRAN_CANTIDAD_COMPRADA, TRAN_FECHA,
	TRAN_FORMA_PAGO, TRAN_PRECIO, USUA_USERNAME)

	VALUES(
	@codPublicacion,
	
	(SELECT TIPO_COD
	FROM SALUDOS.TIPOS
	WHERE TIPO_NOMBRE = 'Subasta'),
	
	0, 1,
	SALUDOS.fechaActual(), 'Efectivo',

	@oferta, @usuario
	)
GO

CREATE FUNCTION SALUDOS.ultimaOferta(@codPublicacion numeric(18,0))
RETURNS numeric(18,2) AS
	BEGIN
		DECLARE @oferta numeric(18,2)
		
		SET @oferta = (
			SELECT MAX(TRAN_PRECIO)
			FROM SALUDOS.TRANSACCIONES
			WHERE PUBL_COD = @codPublicacion
		)

		IF @oferta IS NULL 
			SET @oferta = 0.00
		
		RETURN @oferta

	END

GO

CREATE PROCEDURE SALUDOS.cambiarEstadoPublicacion
	@codPublicacion numeric(18,0),
	@nuevoEstado nvarchar(255)
AS
	DECLARE @codEstado int 
	SET @codEstado	= (	SELECT ESTA_COD
						FROM SALUDOS.ESTADOS
						WHERE ESTA_NOMBRE = @nuevoEstado)

	UPDATE SALUDOS.PUBLICACIONES
	SET SALUDOS.PUBLICACIONES.ESTA_COD = @codEstado
	WHERE PUBL_COD = @codPublicacion
GO

CREATE FUNCTION SALUDOS.filtrarPublicacionesParaCambioDeEstado(
	@descripcion nvarchar(255), @creador nvarchar(255), @estado nvarchar(255))
RETURNS @publicaciones TABLE (	Código numeric(18,0), Descripción nvarchar(255),
								Vendedor nvarchar(255), Estado nvarchar(255)) AS
	BEGIN
		INSERT @publicaciones
		SELECT PUBL_COD, PUBL_DESCRIPCION, USUA_USERNAME, ESTA_NOMBRE
		FROM SALUDOS.PUBLICACIONES, SALUDOS.ESTADOS esta
		WHERE	(USUA_USERNAME = @creador OR @creador IS NULL) AND
				(PUBL_DESCRIPCION LIKE '%' + @descripcion + '%' OR @descripcion IS NULL) AND
				(esta.ESTA_COD = (	SELECT ESTA_COD
									FROM SALUDOS.ESTADOS
									WHERE ESTA_NOMBRE = @estado) OR @estado IS NULL)
		ORDER BY PUBL_COD
		RETURN;
	END
GO
