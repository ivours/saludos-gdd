USE GD1C2016
GO

CREATE SCHEMA SALUDOS
GO

CREATE TABLE SALUDOS.PUBLICACIONES(
	PUBL_COD			numeric(18,0) IDENTITY, --Publicacion_Cod
	PUBL_DESCRIPCION	nvarchar(255),			--Publicacion_Descripcion
	PUBL_STOCK			numeric (18,0),			--Publicacion_Stock
	PUBL_INICIO			datetime,				--Publicacion_Fecha
	PUBL_FINALIZACION	datetime,				--Publicacion_Fecha_Venc
	PUBL_PRECIO			numeric(18,2),			--Publicacion_Precio
	PUBL_PREGUNTAS		bit,					--new
	PUBL_PERMITE_ENVIO	bit,					--new
	USUA_USERNAME		nvarchar(255),			--FK. Creador.
	VISI_COD			int,					--FK. Visibilidad.
	RUBR_COD			int,					--FK. Rubro.
	ESTA_COD			int,					--FK. Estado.
	TIPO_COD			int,					--Fk. Tipo.
	CONSTRAINT PK_PUBLICACIONES PRIMARY KEY (PUBL_COD),
)

CREATE TABLE SALUDOS.ESTADOS(
	ESTA_COD	int IDENTITY,	--PK. 
	ESTA_NOMBRE	nvarchar(255)	--Publicacion_Estado. Reemplaza Publicada.
	CONSTRAINT CK_ESTA_NOMBRE CHECK
		(ESTA_NOMBRE IN ('Borrador', 'Activa', 'Pausada', 'Finalizada')),
	CONSTRAINT PK_ESTADOS PRIMARY KEY (ESTA_COD),
)

CREATE TABLE SALUDOS.TIPOS(
	TIPO_COD	int IDENTITY,	--PK.
	TIPO_NOMBRE	nvarchar(255)	--Publicacion_Tipo.
	--CONSTRAINT CK_TIPO_NOMBRE CHECK
	--	(TIPO_NOMBRE IN ('Compra Inmediata', 'Subasta')),
	CONSTRAINT PK_TIPOS PRIMARY KEY (TIPO_COD),
)

CREATE TABLE SALUDOS.VISIBILIDADES(
	VISI_COD					int,	--reemplaza Publiacion_Visibilidad_Cod
	VISI_COMISION_PUBLICACION	numeric(18,2),	--Publicacion_Visibilidad_Precio
	VISI_COMISION_VENTA			numeric(18,2),	--Publicacion_Visibilidad_Porcentaje
	VISI_COMISION_ENVIO			numeric(18,2),	--new. 10% del valor inicial de la publicación.
	VISI_DESCRIPCION			nvarchar(255),	--Publicacion_Visibilidad_Desc
	CONSTRAINT PK_VISIBILIDADES PRIMARY KEY (VISI_COD),
)

CREATE TABLE SALUDOS.RUBROS(
	RUBR_COD			int IDENTITY,	--new
	RUBR_NOMBRE			nvarchar(255),	--Publicacion_Rubro_Descripcion
	RUBR_DESCRIPCION	nvarchar(255),	--new
	CONSTRAINT PK_RUBROS PRIMARY KEY (RUBR_COD),
)

CREATE TABLE SALUDOS.TRANSACCIONES(
	TRAN_COD				int	IDENTITY,	--new
	TRAN_ADJUDICADA			bit,			--Si fue adjudicada (para subastas)
	TRAN_PRECIO				numeric(18,2),	--Oferta_Monto (en caso de subasta). Sino, es el precio de compra.
	TRAN_CANTIDAD_COMPRADA	numeric(2,0),	--Compra_Cantidad (en caso de compra directa)
	TRAN_FECHA				datetime,		--Compra_Fecha u Oferta_Fecha. Momento de la transacción.
	USUA_USERNAME			nvarchar(255),	--FK. Comprador/ofertante.
	PUBL_COD				numeric(18,0),	--FK. Qué compra u oferta.
	TIPO_COD				int				--FK. Compra o subasta.
	CONSTRAINT PK_TRANSACCIONES PRIMARY KEY (TRAN_COD),
)

CREATE TABLE SALUDOS.CALIFICACIONES(
	CALI_COD				int	IDENTITY,	--Calificacion_Codigo
	CALI_ESTRELLAS			numeric(18,0),	--Calificacion_Cant_Estrellas
	CALI_DESCRIPCION		nvarchar(255),	--Calificacion_Descripcion
	CALI_FECHA				datetime,		--new
	USUA_USERNAME			nvarchar(255),	--FK. Quién califica.
	PUBL_COD				numeric(18,0),	--FK. Respecto de qué publicación califica.
	CONSTRAINT PK_CALIFICACIONES PRIMARY KEY (CALI_COD),
)

CREATE TABLE SALUDOS.EMPRESAS(
	EMPR_COD				int IDENTITY,	--new
	EMPR_RAZON_SOCIAL		nvarchar(255),	--Publ_Empresa_Razon_Social
	EMPR_CUIT				nvarchar(50),	--Publ_Empresa_Cuit
	EMPR_MAIL				nvarchar(50),	--Publ_Empresa_Mail
	EMPR_TELEFONO			numeric(18,0),	--new
	EMPR_CALLE				nvarchar(100),	--Publ_Empresa_Dom_Calle
	EMPR_NRO_CALLE			numeric(18,0),	--Publ_Empresa_Nro_Calle
	EMPR_PISO				numeric(18,0),	--Publ_Empresa_Piso
	EMPR_DEPTO				nvarchar(50),	--Publ_Empresa_Depto
	EMPR_CIUDAD				nvarchar(50),	--new
	EMPR_CONTACTO			nvarchar(50),	--new
	EMPR_CODIGO_POSTAL		nvarchar(50),	--Publ_Empresa_Cod_Postal
	EMPR_LOCALIDAD			nvarchar(50),	--new
	EMPR_FECHA_CREACION		datetime,		--Publ_Empresa_Fecha_Creacion
	USUA_USERNAME			nvarchar(255),	--FK. Usuario de la empresa.
	RUBR_COD				int,			--FK. Rubro principal donde se desempeña.
	CONSTRAINT PK_EMPRESAS PRIMARY KEY (EMPR_COD)
)

CREATE TABLE SALUDOS.CLIENTES(				--PARA EL QUE PUBLICA / PARA EL QUE COMPRA
	CLIE_COD				int IDENTITY,	--new
	CLIE_NOMBRE				nvarchar(255),	--Publ_Cli_Nombre	  / Cli_Nombre
	CLIE_APELLIDO			nvarchar(255),	--Publ_Cli_Apeliido   / Cli_Apeliido
	CLIE_TELEFONO			numeric(18,0),	--new
	CLIE_CALLE				nvarchar(255),	--Publ_Cli_Dom_Calle  / Cli_Dom_Calle
	CLIE_NRO_CALLE			numeric(18,0),	--Publ_Cli_Nro_Calle  / Cli_Nro_Calle
	CLIE_FECHA_CREACION		datetime,		--new
	CLIE_FECHA_NACIMIENTO	datetime,		--Publ_Cli_Fecha_Nac  / Cli_Fecha_Nac
	CLIE_CODIGO_POSTAL		nvarchar(50),	--Publ_Cli_Cod_Postal / Cli_Cod_Postal
	CLIE_DEPTO				nvarchar(50),	--Publ_Cli_Depto	  / Cli_Depto
	CLIE_PISO				numeric(18,0),	--Publ_Cli_Piso		  / Cli_Piso
	CLIE_LOCALIDAD			nvarchar(255),	--new
	CLIE_NRO_DOCUMENTO		numeric(18,0),	--Publ_Cli_Dni		  / Cli_Dni
	CLIE_TIPO_DOCUMENTO		nvarchar(50),	--new
	CLIE_MAIL				nvarchar(50),	--Publ_Cli_Mail		  / Cli_Mail
	USUA_USERNAME			nvarchar(255),	--FK. Usuario del cliente.
	CONSTRAINT PK_CLIENTES PRIMARY KEY (CLIE_COD)
)

CREATE TABLE SALUDOS.USUARIOS(
	USUA_USERNAME			nvarchar(255),		--new
	USUA_PASSWORD			nvarchar(255),		--new
	USUA_NUEVO				bit DEFAULT 0,		--new
	USUA_INTENTOS_LOGIN		tinyint DEFAULT 0,	--new
	USUA_SIN_CALIFICAR		tinyint DEFAULT 0,	--new
	USUA_TIPO				nvarchar(255),		--new.
	USUA_HABILITADO			bit DEFAULT 1,
	CONSTRAINT CK_USUA_TIPO CHECK (USUA_TIPO IN ('Empresa', 'Cliente')),
	CONSTRAINT PK_USUA_USERNAME PRIMARY KEY (USUA_USERNAME)
)

CREATE TABLE SALUDOS.FACTURAS(
	FACT_COD				numeric(18,0) IDENTITY,	--Factura_Nro
	FACT_FECHA				datetime,				--Factura_Fecha
	FACT_TOTAL				numeric(18,2),			--Factura_Total
	USUA_USERNAME			nvarchar(255),			--FK. A quién corresponde la factura.
	PUBL_COD				numeric(18,0),			--FK. Por qué publicación se factura.
	CONSTRAINT PK_FACTURAS PRIMARY KEY (FACT_COD)
)

CREATE TABLE SALUDOS.ITEMS(
	ITEM_COD				int	IDENTITY,	--new
	ITEM_IMPORTE			numeric(18,2),	--Item_Factura_Monto
	ITEM_CANTIDAD			numeric(2,0),	--Item_Factura_Cantidad
	ITEM_DESCRIPCION		nvarchar(255),	--new. A qué corresponde el cobro.
	FACT_COD				numeric(18,0),	--FK. Factura a la que pertenece.
	CONSTRAINT CK_ITEM_DESCRIPCION CHECK
		(ITEM_DESCRIPCION IN ('Comisión por Publicación', 'Comisión por Venta', 'Comisión por envío')), 
	CONSTRAINT PK_ITEMS PRIMARY KEY (ITEM_COD)
)

CREATE TABLE SALUDOS.ROLES(
	ROL_COD			int IDENTITY,
	ROL_NOMBRE		nvarchar(50),
	ROL_HABILITADO	bit DEFAULT 1,
	CONSTRAINT PK_ROLES PRIMARY KEY (ROL_COD)
)

CREATE TABLE SALUDOS.FUNCIONALIDADES(
	FUNC_COD		int IDENTITY,
	FUNC_NOMBRE		nvarchar(50),
	CONSTRAINT PK_FUNCIONALIDADES PRIMARY KEY (FUNC_COD)
)

CREATE TABLE SALUDOS.ROLESXUSUARIO(
	ROL_COD			int,
	USUA_USERNAME	nvarchar(255),
	RXU_HABILITADO	bit DEFAULT 1,
	CONSTRAINT PK_ROLESXUSUARIO PRIMARY KEY (ROL_COD, USUA_USERNAME)
)

CREATE TABLE SALUDOS.FUNCIONALIDADESXROL(
	FUNC_COD		int,
	ROL_COD			int,
	CONSTRAINT PK_FUNCIONALIDADESXROL PRIMARY KEY (FUNC_COD, ROL_COD)
)


-----------FKs QUE HAY QUE AGREGAR-----------
ALTER TABLE SALUDOS.PUBLICACIONES
	ADD CONSTRAINT FK_PUBLICACIONES_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.PUBLICACIONES
	ADD CONSTRAINT FK_PUBLICACIONES_VISI_COD
	FOREIGN KEY (VISI_COD)
	REFERENCES SALUDOS.VISIBILIDADES(VISI_COD)

ALTER TABLE SALUDOS.PUBLICACIONES
	ADD CONSTRAINT FK_PUBLICACIONES_RUBR_COD
	FOREIGN KEY (RUBR_COD)
	REFERENCES SALUDOS.RUBROS(RUBR_COD)

ALTER TABLE SALUDOS.PUBLICACIONES
	ADD CONSTRAINT FK_PUBLICACIONES_ESTA_COD
	FOREIGN KEY (ESTA_COD)
	REFERENCES SALUDOS.ESTADOS(ESTA_COD)

ALTER TABLE SALUDOS.PUBLICACIONES
	ADD CONSTRAINT FK_PUBLICACIONES_TIPO_COD
	FOREIGN KEY (TIPO_COD)
	REFERENCES SALUDOS.TIPOS(TIPO_COD)


ALTER TABLE SALUDOS.TRANSACCIONES
	ADD CONSTRAINT FK_TRANSACCIONES_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.TRANSACCIONES
	ADD CONSTRAINT FK_TRANSACCIONES_PUBL_COD
	FOREIGN KEY (PUBL_COD)
	REFERENCES SALUDOS.PUBLICACIONES(PUBL_COD)

ALTER TABLE SALUDOS.TRANSACCIONES
	ADD CONSTRAINT FK_TRANSACCIONES_TIPO_COD
	FOREIGN KEY (TIPO_COD)
	REFERENCES SALUDOS.TIPOS(TIPO_COD)


ALTER TABLE SALUDOS.CALIFICACIONES
	ADD CONSTRAINT FK_CALIFICACIONES_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.CALIFICACIONES
	ADD CONSTRAINT FK_CALIFICACIONES_PUBL_COD
	FOREIGN KEY (PUBL_COD)
	REFERENCES SALUDOS.PUBLICACIONES(PUBL_COD)


ALTER TABLE SALUDOS.EMPRESAS
	ADD CONSTRAINT FK_EMPRESAS_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.EMPRESAS
	ADD CONSTRAINT FK_EMPRESAS_RUBR_COD
	FOREIGN KEY (RUBR_COD)
	REFERENCES SALUDOS.RUBROS(RUBR_COD)


ALTER TABLE SALUDOS.CLIENTES
	ADD CONSTRAINT FK_CLIENTES_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)


ALTER TABLE SALUDOS.FACTURAS
	ADD CONSTRAINT FK_FACTURAS_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.FACTURAS
	ADD CONSTRAINT FK_FACTURAS_PUBL_COD
	FOREIGN KEY (PUBL_COD)
	REFERENCES SALUDOS.PUBLICACIONES(PUBL_COD)


ALTER TABLE SALUDOS.ITEMS
	ADD CONSTRAINT FK_ITEMS_FACT_COD
	FOREIGN KEY (FACT_COD)
	REFERENCES SALUDOS.FACTURAS(FACT_COD)


ALTER TABLE SALUDOS.ROLESXUSUARIO
	ADD CONSTRAINT FK_ROLESXUSUARIO_ROL_COD
	FOREIGN KEY (ROL_COD)
	REFERENCES SALUDOS.ROLES(ROL_COD)

ALTER TABLE SALUDOS.ROLESXUSUARIO
	ADD CONSTRAINT FK_ROLESXUSUARIO_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)


ALTER TABLE SALUDOS.FUNCIONALIDADESXROL
	ADD CONSTRAINT FK_FUNCIONALIDADESXROL_FUNC_COD
	FOREIGN KEY (FUNC_COD)
	REFERENCES SALUDOS.FUNCIONALIDADES(FUNC_COD)

ALTER TABLE SALUDOS.FUNCIONALIDADESXROL
	ADD CONSTRAINT FK_FUNCIONALIDADESXROL_ROL_COD
	FOREIGN KEY (ROL_COD)
	REFERENCES SALUDOS.ROLES(ROL_COD)


--Creación de tabla Fecha, function y procedure
--para manejar la fecha del sistema.
CREATE TABLE SALUDOS.FECHA(
	hoy datetime
)
GO

CREATE FUNCTION SALUDOS.fechaActual()
RETURNS datetime
AS 
	BEGIN
	RETURN (SELECT TOP 1 * FROM SALUDOS.FECHA)
	END
GO

CREATE PROCEDURE SALUDOS.asignarFecha
	@fecha datetime
AS
	DELETE FROM SALUDOS.FECHA
	INSERT INTO SALUDOS.FECHA
		VALUES (@fecha)
GO

-----MIGRATION TIME-----

--Agrego roles
INSERT INTO SALUDOS.ROLES (ROL_NOMBRE)
	VALUES ('Administrador'), ('Cliente'), ('Empresa')

--Agrego funcionalidades
INSERT INTO SALUDOS.FUNCIONALIDADES(FUNC_NOMBRE)
	VALUES	('ABM Roles'),
			('ABM Usuarios'),
			('ABM Rubros'),
			('ABM Visibilidades'),
			('Vender'),
			('Comprar/Ofertar'),
			('Historial de cliente'),
			('Calificar al vendedor'),
			('Consulta de facturas'),
			('Listado estadístico')

--La tabla maestra tiene datos de clientes guardados en dos lugares distintos.
--Primero migro clientes que hayan hecho una publicación.
INSERT INTO SALUDOS.CLIENTES(
	CLIE_NRO_DOCUMENTO, CLIE_APELLIDO, CLIE_NOMBRE, CLIE_FECHA_NACIMIENTO, CLIE_MAIL,
	CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_CODIGO_POSTAL, CLIE_TIPO_DOCUMENTO)
SELECT DISTINCT
	Publ_Cli_Dni, Publ_Cli_Apeliido, Publ_Cli_Nombre, Publ_Cli_Fecha_Nac, Publ_Cli_Mail,
	Publ_Cli_Dom_Calle, Publ_Cli_Nro_Calle, Publ_Cli_Piso, Publ_Cli_Depto, Publ_Cli_Cod_Postal, 'DNI'
FROM gd_esquema.Maestra
WHERE Publ_Cli_Dni IS NOT NULL

--Luego migro clientes que hayan realizado una compra.
INSERT INTO SALUDOS.CLIENTES(
	CLIE_NRO_DOCUMENTO, CLIE_APELLIDO, CLIE_NOMBRE, CLIE_FECHA_NACIMIENTO, CLIE_MAIL,
	CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_CODIGO_POSTAL, CLIE_TIPO_DOCUMENTO)
SELECT DISTINCT
	Cli_Dni, Cli_Apeliido, Cli_Nombre, Cli_Fecha_Nac, Cli_Mail,
	Cli_Dom_Calle, Cli_Nro_Calle, Cli_Piso, Cli_Depto, Cli_Cod_Postal, 'DNI'
FROM gd_esquema.Maestra
WHERE	Cli_Dni IS NOT NULL
		AND NOT EXISTS(
		SELECT CLIE_NRO_DOCUMENTO
		FROM SALUDOS.CLIENTES
		WHERE Cli_Dni = CLIE_NRO_DOCUMENTO)
--Resulta que a pesar de que la información está dos veces,
--los 28 clientes son los mismos. Así que esto no hace nada:
--0 rows affected. Pero me parece que tiene sentido dejarlo.

--Migrando empresas
INSERT INTO SALUDOS.EMPRESAS(
	EMPR_RAZON_SOCIAL, EMPR_CUIT, EMPR_FECHA_CREACION,
	EMPR_MAIL, EMPR_CALLE, EMPR_NRO_CALLE,
	EMPR_PISO, EMPR_DEPTO, EMPR_CODIGO_POSTAL)
SELECT DISTINCT
	Publ_Empresa_Razon_Social, Publ_Empresa_Cuit, Publ_Empresa_Fecha_Creacion,
	Publ_Empresa_Mail, Publ_Empresa_Dom_Calle, Publ_Empresa_Nro_Calle,
	Publ_Empresa_Piso, Publ_Empresa_Depto, Publ_Empresa_Cod_Postal
FROM gd_esquema.Maestra
WHERE Publ_Empresa_Razon_Social IS NOT NULL

--Migrando rubros
INSERT INTO SALUDOS.RUBROS(
	RUBR_NOMBRE)
SELECT DISTINCT
	Publicacion_Rubro_Descripcion
FROM gd_esquema.Maestra
WHERE Publicacion_Rubro_Descripcion IS NOT NULL

--Migrando visibilidades
INSERT INTO SALUDOS.VISIBILIDADES(
	VISI_COD, VISI_DESCRIPCION, VISI_COMISION_ENVIO,
	VISI_COMISION_PUBLICACION, VISI_COMISION_VENTA)
SELECT DISTINCT
	Publicacion_Visibilidad_Cod, Publicacion_Visibilidad_Desc, 0.10,
	Publicacion_Visibilidad_Precio, Publicacion_Visibilidad_Porcentaje
FROM gd_esquema.Maestra

GO

--Creando usuarios para clientes.
INSERT INTO SALUDOS.USUARIOS(
	USUA_USERNAME,
	USUA_PASSWORD,
	USUA_TIPO)
SELECT DISTINCT
	(LOWER(CLIE_NOMBRE) + LOWER(CLIE_APELLIDO)),
	HASHBYTES('SHA2_256', CONVERT(nvarchar(255), CLIE_NRO_DOCUMENTO)),
	'Cliente'
FROM SALUDOS.CLIENTES

UPDATE SALUDOS.CLIENTES
SET SALUDOS.CLIENTES.USUA_USERNAME = USUARIOS.USUA_USERNAME
FROM (
	SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS) USUARIOS
WHERE
	USUARIOS.USUA_USERNAME = LOWER(SALUDOS.CLIENTES.CLIE_NOMBRE) + LOWER(SALUDOS.CLIENTES.CLIE_APELLIDO)

--Creando usuarios para empresas.
INSERT INTO SALUDOS.USUARIOS(
	USUA_USERNAME,
	USUA_PASSWORD,
	USUA_TIPO)
SELECT DISTINCT
	LOWER(EMPR_RAZON_SOCIAL),
	HASHBYTES('SHA2_256', EMPR_RAZON_SOCIAL),
	'Empresa'
FROM SALUDOS.EMPRESAS

UPDATE SALUDOS.EMPRESAS
SET SALUDOS.EMPRESAS.USUA_USERNAME = USUARIOS.USUA_USERNAME
FROM (
	SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS) USUARIOS
WHERE
	USUARIOS.USUA_USERNAME = LOWER(SALUDOS.EMPRESAS.EMPR_RAZON_SOCIAL)

GO

INSERT INTO SALUDOS.ESTADOS(
	ESTA_NOMBRE)
VALUES ('Activa'), ('Finalizada'), ('Borrador'), ('Pausada')

INSERT INTO SALUDOS.TIPOS(
	TIPO_NOMBRE)
VALUES ('Compra Inmediata'), ('Subasta')

GO

--Migrando publicaciones.
--En primera instancia, todas se migran con estado Activa, porque se desconoce la fecha actual.
--Al iniciar la aplicación se revisa qué publicaciones deben pasarse a Finalizadas.
SET IDENTITY_INSERT SALUDOS.PUBLICACIONES ON;

INSERT INTO SALUDOS.PUBLICACIONES(
	PUBL_COD, PUBL_DESCRIPCION, PUBL_STOCK,
	PUBL_INICIO, PUBL_FINALIZACION, PUBL_PRECIO,
	PUBL_PREGUNTAS, PUBL_PERMITE_ENVIO, VISI_COD,
	ESTA_COD, TIPO_COD,	USUA_USERNAME, RUBR_COD
	)
SELECT DISTINCT
	Publicacion_Cod, Publicacion_Descripcion, Publicacion_Stock,
	Publicacion_Fecha, Publicacion_Fecha_Venc, Publicacion_Precio,
	0, 0, Publicacion_Visibilidad_Cod,
	
	(SELECT ESTA_COD
	FROM SALUDOS.ESTADOS
	WHERE ESTA_NOMBRE = 'Activa'),

	(SELECT TIPO_COD
	FROM SALUDOS.TIPOS
	WHERE TIPO_NOMBRE = Publicacion_Tipo),

	(SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS
	WHERE	(USUA_USERNAME = LOWER(Publ_Cli_Nombre) + LOWER(Publ_Cli_Apeliido))
		OR	(USUA_USERNAME = LOWER(Publ_Empresa_Razon_Social))),

	(SELECT RUBR_COD
	FROM SALUDOS.RUBROS
	WHERE RUBR_NOMBRE = Publicacion_Rubro_Descripcion)
FROM gd_esquema.Maestra

SET IDENTITY_INSERT SALUDOS.PUBLICACIONES OFF;

GO


--Migrando calificaciones.
SET IDENTITY_INSERT SALUDOS.CALIFICACIONES ON;

INSERT INTO SALUDOS.CALIFICACIONES(
	CALI_COD, CALI_ESTRELLAS,
	CALI_DESCRIPCION, PUBL_COD, USUA_USERNAME)
SELECT DISTINCT
	Calificacion_Codigo, Calificacion_Cant_Estrellas,
	Calificacion_Descripcion, Publicacion_Cod,

	(SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS
	WHERE	USUA_USERNAME = LOWER(Cli_Nombre) + LOWER(Cli_Apeliido))
FROM gd_esquema.Maestra
WHERE Calificacion_Codigo IS NOT NULL

SET IDENTITY_INSERT SALUDOS.CALIFICACIONES OFF;

GO


--Migrando facturas.
SET IDENTITY_INSERT SALUDOS.FACTURAS ON;

INSERT INTO SALUDOS.FACTURAS(
	FACT_COD, FACT_FECHA,
	FACT_TOTAL, PUBL_COD,
	USUA_USERNAME)
SELECT DISTINCT
	Factura_Nro, Factura_Fecha,
	Factura_Total, Publicacion_Cod,

	(SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS
	WHERE	(USUA_USERNAME = LOWER(Publ_Cli_Nombre) + LOWER(Publ_Cli_Apeliido))
		OR	(USUA_USERNAME = LOWER(Publ_Empresa_Razon_Social)))
FROM gd_esquema.Maestra
WHERE Factura_Nro IS NOT NULL

SET IDENTITY_INSERT SALUDOS.FACTURAS OFF;

--Migrando items.
INSERT INTO SALUDOS.ITEMS(
	ITEM_IMPORTE, ITEM_CANTIDAD,
	FACT_COD, ITEM_DESCRIPCION)
SELECT DISTINCT
	Item_Factura_Monto, Item_Factura_Cantidad,
	Factura_Nro,
	CASE
		WHEN Item_Factura_Monto = Publicacion_Visibilidad_Precio
				THEN 'Comisión por Publicación'
		ELSE 'Comisión por Venta'
	END
FROM gd_esquema.Maestra
WHERE Item_Factura_Monto IS NOT NULL


--Migrando transacciones de Compras Inmediatas.
INSERT INTO SALUDOS.TRANSACCIONES(
	PUBL_COD, TRAN_PRECIO,
	TRAN_CANTIDAD_COMPRADA, TRAN_FECHA, TRAN_ADJUDICADA,
	TIPO_COD,
	USUA_USERNAME)

SELECT DISTINCT
	Publicacion_Cod, Publicacion_Precio,
	Compra_Cantidad, Compra_Fecha, 1,

	(SELECT TIPO_COD
	FROM SALUDOS.TIPOS
	WHERE TIPO_NOMBRE = Publicacion_Tipo),

	(SELECT USUA_USERNAME
	FROM SALUDOS.USUARIOS
	WHERE	USUA_USERNAME = LOWER(Cli_Nombre) + LOWER(Cli_Apeliido))
FROM gd_esquema.Maestra
WHERE Compra_Fecha IS NOT NULL AND Publicacion_Tipo = 'Compra Inmediata'

--si es una subasta, y el usuario además de una oferta_fecha tiene una compra_fecha para una misma publicación...
--entonces sólo pasar la oferta, dejarla con esa fecha, y poner el bit de adjudicada en 1.
--si no tiene una compra_fecha, entonces no la ganó, el bit va en 0.
--si es una compra,

--CASE
--	WHEN Publicacion_Tipo = 'Subasta' and exists
--	(select Oferta_Monto, publicacion_cod, Cli_nombre from gd_esquema.Maestra t1 where exists
--		(select oferta_monto, cli_nombre from gd_esquema.Maestra t2 where t2.Oferta_Monto > t1.oferta_monto
--			and t1.Publicacion_Cod = t2.publicacion_cod) order by t1.publicacion_cod)
--		THEN 1
--	ELSE 0
--END

--select oferta_fecha, oferta_monto, compra_fecha, compra_cantidad, publicacion_cod, cli_nombre
--from gd_esquema.Maestra t1
--where calificacion_codigo is null and publicacion_tipo = 'Subasta' and t1.cli_nombre =
--	(select cli_nombre
--	from gd_esquema.Maestra t2
--	where compra_fecha is not null and calificacion_codigo is null
--	and t2.publicacion_cod = t1.publicacion_cod)
--order by publicacion_cod

--select distinct publicacion_cod, cli_nombre
--from gd_esquema.Maestra t1
--where calificacion_codigo is null and publicacion_tipo = 'Subasta' and t1.cli_nombre =
--	(select cli_nombre
--	from gd_esquema.Maestra t2
--	where compra_fecha is not null and calificacion_codigo is null
--	and t2.publicacion_cod = t1.publicacion_cod)
--order by publicacion_cod

--CASE
--	WHEN Cli_Nombre = (
--		SELECT Cli_Nombre
--		FROM gd_esquema.Maestra
--		WHERE Publicacion_Tipo = 'Subasta' AND Compra_Fecha IS NOT NULL) then 1
--	WHEN Publicacion_Tipo = 'Compra Inmediata' then 0
--	ELSE 0
--END,
