USE GD1C2016
GO

CREATE SCHEMA SALUDOS

CREATE TABLE SALUDOS.PUBLICACIONES(
	PUBL_COD			numeric(18,0) IDENTITY, --Publicacion_Cod
	PUBL_DESCRIPCION	nvarchar(255),			--Publicacion_Descripcion
	PUBL_STOCK			numeric (18,0),			--Publicacion_Stock
	PUBL_INICIO			datetime,				--Publicacion_Fecha
	PUBL_FINALIZACION	datetime,				--Publicacion_Fecha_Venc
	PUBL_PRECIO			numeric(18,2),			--Publicacion_Precio
	PUBL_ESTADO			varchar(10),			--Publicacion_Estado (borrador, activa, pausada, finalizada. reemplaza Publicada)
	PUBL_TIPO			nvarchar(255),			--Publicacion_Tipo
	PUBL_PREGUNTAS		bit,					--new
	PUBL_PERMITE_ENVIO	bit,					--new
	USUA_USERNAME		nvarchar(255),			--FK. Creador.
	VISI_COD			int,					--FK. Visibilidad.
	RUBR_COD			int,					--FK. Rubro.
	CONSTRAINT PK_PUBLICACIONES PRIMARY KEY (PUBL_COD),
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
	TRAN_TIPO				nvarchar(255),	--Compra o subasta
	TRAN_ADJUDICADA			bit,			--Si fue adjudicada (para subastas)
	TRAN_PRECIO				numeric(18,2),	--Oferta_Monto (en caso de subasta). Sino, es el precio de compra.
	TRAN_CANTIDAD_COMPRADA	numeric(2,0),	--Compra_Cantidad (en caso de compra directa)
	TRAN_FECHA				datetime,		--Compra_Fecha u Oferta_Fecha. Momento de la transacción.
	USUA_USERNAME			nvarchar(255),	--FK. Comprador/ofertante.
	PUBL_COD				numeric(18,0),	--FK. Qué compra u oferta.
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
	CONSTRAINT PK_EMPRESAS PRIMARY KEY (EMPR_RAZON_SOCIAL, EMPR_CUIT)
)

CREATE TABLE SALUDOS.CLIENTES(				--PARA EL QUE PUBLICA / PARA EL QUE COMPRA
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
	CONSTRAINT PK_CLIENTES PRIMARY KEY (CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO)
)

CREATE TABLE SALUDOS.USUARIOS(
	USUA_USERNAME			nvarchar(255),	--new
	USUA_PASSWORD			nvarchar(255),	--new
	USUA_NUEVO				bit,			--new
	USUA_INTENTOS_LOGIN		tinyint,		--new
	USUA_SIN_CALIFICAR		tinyint,		--new
	USUA_TIPO				nvarchar(1),	--new. 'e' = empresa, 'c' = cliente
	USUA_HABILITADO			bit DEFAULT 1,
	CONSTRAINT CK_USUARIO CHECK (USUA_TIPO IN ('e', 'c')),
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
	FACT_COD				numeric(18,0),	--FK. Factura a la que pertenece.
	CONSTRAINT PK_ITEMS PRIMARY KEY (ITEM_COD)
)

CREATE TABLE SALUDOS.ROLES(
	ROL_NOMBRE		nvarchar(50),
	ROL_HABILITADO	bit DEFAULT 1,
	CONSTRAINT PK_ROLES PRIMARY KEY (ROL_NOMBRE)
)

CREATE TABLE SALUDOS.FUNCIONALIDADES(
	FUNC_NOMBRE		nvarchar(50),
	CONSTRAINT PK_FUNCIONALIDADES PRIMARY KEY (FUNC_NOMBRE)
)

CREATE TABLE SALUDOS.ROLESXUSUARIO(
	ROL_NOMBRE		nvarchar(50),
	USUA_USERNAME	nvarchar(255),
	RXU_HABILITADO	bit DEFAULT 1,
	CONSTRAINT PK_ROLESXUSUARIO PRIMARY KEY (ROL_NOMBRE, USUA_USERNAME)
)

CREATE TABLE SALUDOS.FUNCIONALIDADESXROL(
	FUNC_NOMBRE		nvarchar(50),
	ROL_NOMBRE		nvarchar(50),
	CONSTRAINT PK_FUNCIONALIDADESXROL PRIMARY KEY (FUNC_NOMBRE, ROL_NOMBRE)
)

GO


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


ALTER TABLE SALUDOS.TRANSACCIONES
	ADD CONSTRAINT FK_TRANSACCIONES_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.TRANSACCIONES
	ADD CONSTRAINT FK_TRANSACCIONES_PUBL_COD
	FOREIGN KEY (PUBL_COD)
	REFERENCES SALUDOS.PUBLICACIONES(PUBL_COD)


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
	ADD CONSTRAINT FK_ROLESXUSUARIO_ROL_NOMBRE
	FOREIGN KEY (ROL_NOMBRE)
	REFERENCES SALUDOS.ROLES(ROL_NOMBRE)

ALTER TABLE SALUDOS.ROLESXUSUARIO
	ADD CONSTRAINT FK_ROLESXUSUARIO_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)


ALTER TABLE SALUDOS.FUNCIONALIDADESXROL
	ADD CONSTRAINT FK_FUNCIONALIDADESXROL_FUNC_NOMBRE
	FOREIGN KEY (FUNC_NOMBRE)
	REFERENCES SALUDOS.FUNCIONALIDADES(FUNC_NOMBRE)

ALTER TABLE SALUDOS.FUNCIONALIDADESXROL
	ADD CONSTRAINT FK_FUNCIONALIDADESXROL_ROL_NOMBRE
	FOREIGN KEY (ROL_NOMBRE)
	REFERENCES SALUDOS.ROLES(ROL_NOMBRE)


-----MIGRATION TIME-----

--Agrego roles
INSERT INTO SALUDOS.ROLES (ROL_NOMBRE)
	VALUES ('Administrador'),('Cliente'), ('Empresa')

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
--Primero agrego clientes que hayan hecho una publicación.
INSERT INTO SALUDOS.CLIENTES(
	CLIE_NRO_DOCUMENTO, CLIE_APELLIDO, CLIE_NOMBRE, CLIE_FECHA_NACIMIENTO, CLIE_MAIL,
	CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_CODIGO_POSTAL, CLIE_TIPO_DOCUMENTO)
SELECT DISTINCT
	Publ_Cli_Dni, Publ_Cli_Apeliido, Publ_Cli_Nombre, Publ_Cli_Fecha_Nac, Publ_Cli_Mail,
	Publ_Cli_Dom_Calle, Publ_Cli_Nro_Calle, Publ_Cli_Piso, Publ_Cli_Depto, Publ_Cli_Cod_Postal, 'DNI'
FROM gd_esquema.Maestra
WHERE Publ_Cli_Dni IS NOT NULL

--Luego agrego clientes que hayan realizado una compra.
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

--Agrego empresas
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

--Agrego rubros
INSERT INTO SALUDOS.RUBROS(
	RUBR_NOMBRE)
SELECT DISTINCT
	Publicacion_Rubro_Descripcion
FROM gd_esquema.Maestra
WHERE Publicacion_Rubro_Descripcion IS NOT NULL

--Agrego visibilidades
INSERT INTO SALUDOS.VISIBILIDADES(
	VISI_COD, VISI_DESCRIPCION, VISI_COMISION_ENVIO,
	VISI_COMISION_PUBLICACION, VISI_COMISION_VENTA)
SELECT DISTINCT
	Publicacion_Visibilidad_Cod, Publicacion_Visibilidad_Desc, 0.10,
	Publicacion_Visibilidad_Precio, Publicacion_Visibilidad_Porcentaje
FROM gd_esquema.Maestra

GO

--Procedure que genera username y password para un cliente.
CREATE PROCEDURE SALUDOS.generarUsuariosDeClientes
	@dni nvarchar(255),
	@nombre nvarchar(255),
	@apellido nvarchar(255)
AS
	BEGIN
		INSERT INTO SALUDOS.USUARIOS
			(USUA_USERNAME, USUA_PASSWORD, USUA_TIPO)
		VALUES
			(LOWER(@nombre) + LOWER(@apellido), HASHBYTES('SHA2_256', @dni), 'c')
	END
GO

--Procedure que genera username y password para una empresa.
CREATE PROCEDURE SALUDOS.generarUsuariosDeEmpresas
	@razonsocial nvarchar(255),
	@cuit nvarchar(255)
AS
	BEGIN
		INSERT INTO SALUDOS.USUARIOS
			(USUA_USERNAME, USUA_PASSWORD, USUA_TIPO)
		VALUES
			(LOWER(@razonsocial), HASHBYTES('SHA2_256', @cuit), 'e')
	END
GO

--Procedure que migra todos los clientes y empresas.
CREATE PROCEDURE SALUDOS.migrarUsuarios
AS
	BEGIN
		DECLARE cursorUsuariosDeClientes CURSOR FOR
		SELECT CONVERT(nvarchar(255), CLIE_NRO_DOCUMENTO), CLIE_NOMBRE, CLIE_APELLIDO FROM SALUDOS.CLIENTES

		DECLARE @dni nvarchar(255)
		DECLARE @nombre nvarchar(255)
		DECLARE @apellido nvarchar(255)

		OPEN cursorUsuariosDeClientes
		FETCH NEXT FROM cursorUsuariosDeClientes INTO @dni, @nombre, @apellido
		WHILE (@@FETCH_STATUS = 0)
	
		BEGIN
			EXECUTE SALUDOS.generarUsuariosDeClientes @dni, @nombre, @apellido
			FETCH NEXT FROM cursorUsuariosDeClientes INTO @dni, @nombre, @apellido
		END
			
		CLOSE cursorUsuariosDeClientes
		DEALLOCATE cursorUsuariosDeClientes

		-------------------------------------------
		
		DECLARE cursorUsuariosDeEmpresas CURSOR FOR
		SELECT CONVERT(nvarchar(255), EMPR_RAZON_SOCIAL), EMPR_CUIT FROM SALUDOS.EMPRESAS

		DECLARE @razonsocial nvarchar(255)
		DECLARE @cuit nvarchar(255)

		OPEN cursorUsuariosDeEmpresas
		FETCH NEXT FROM cursorUsuariosDeEmpresas INTO @razonsocial, @cuit
		WHILE (@@FETCH_STATUS = 0)
	
		BEGIN
			EXECUTE SALUDOS.generarUsuariosDeEmpresas @razonsocial, @cuit
			FETCH NEXT FROM cursorUsuariosDeEmpresas INTO @razonsocial, @cuit
		END
			
		CLOSE cursorUsuariosDeEmpresas
		DEALLOCATE cursorUsuariosDeEmpresas

	END

GO

EXECUTE SALUDOS.migrarUsuarios
GO

UPDATE SALUDOS.USUARIOS
SET USUA_NUEVO = 0, USUA_INTENTOS_LOGIN = 0
