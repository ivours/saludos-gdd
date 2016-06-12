--El script está dividido en las secciones:
--Creación de tablas y foreign keys
--Migración e índices
--Funciones y procedures relacionados a Fecha
--Funciones y procedures relacionados a Publicaciones
--Funciones y procedures relacionados a Comprar y Ofertar
--Funciones y procedures relacionados a Facturas
--Funciones y procedures relacionados a Historial de Cliente
--Funciones y procedures relacionados a Listado Estadístico
--Funciones y procedures relacionados a Calificar Compras
--Procedures relacionados a Login y Cambio de Password
--Funciones y procedures relacionados a ABM Usuario
--Funciones y procedures relacionados a ABM Rol
--Procedures relacionados a ABM Visibilidad de Publicación
--Funciones getters auxiliares

USE GD1C2016
GO

CREATE SCHEMA SALUDOS AUTHORIZATION gd
GO

-------------------------------------------
-----Creación de tablas y foreign keys-----
-------------------------------------------
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
	CONSTRAINT CK_TIPO_NOMBRE CHECK
		(TIPO_NOMBRE IN ('Compra Inmediata', 'Subasta')),
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

CREATE TABLE SALUDOS.COMPRAS(
	COMP_COD		int IDENTITY,	--new
	COMP_PRECIO		numeric(18,2),	--Oferta_Monto, si ganó una subasta, o Publicacion_Precio si era una compra.
	COMP_CANTIDAD	numeric(2,0),	--Compra_Cantidad.
	COMP_FECHA		datetime,		--Compra_Fecha.
	COMP_FORMA_PAGO	nvarchar(255),	--Forma_Pago_Desc.
	COMP_OPTA_ENVIO	bit,			--new. Si quiere que se lo manden.
	USUA_USERNAME	nvarchar(255),	--FK. Comprador.
	PUBL_COD		numeric(18,0),	--FK. Qué compró.
	CONSTRAINT PK_COMPRAS PRIMARY KEY (COMP_COD),
)

CREATE TABLE SALUDOS.OFERTAS(
	OFER_COD		int IDENTITY,	--new
	OFER_OFERTA		numeric(18,2),	--Oferta_Monto.
	OFER_FECHA		datetime,		--Oferta_Fecha.
	OFER_OPTA_ENVIO	bit,			--new. Si quiere que se lo manden.
	USUA_USERNAME	nvarchar(255),	--FK. Ofertante.
	PUBL_COD		numeric(18,0),	--FK. Qué ofertó.
	CONSTRAINT PK_OFERTAS PRIMARY KEY (OFER_COD),
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
	USUA_TIPO				nvarchar(255),		--new.
	USUA_HABILITADO			bit DEFAULT 1,
	CONSTRAINT CK_USUA_TIPO CHECK (USUA_TIPO IN ('Empresa', 'Cliente', 'Administrador')),
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
		(ITEM_DESCRIPCION IN ('Comisión por Publicación', 'Comisión por Venta', 'Comisión por Envío')), 
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


ALTER TABLE SALUDOS.COMPRAS
	ADD CONSTRAINT FK_COMPRAS_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.COMPRAS
	ADD CONSTRAINT FK_COMPRAS_PUBL_COD
	FOREIGN KEY (PUBL_COD)
	REFERENCES SALUDOS.PUBLICACIONES(PUBL_COD)


ALTER TABLE SALUDOS.OFERTAS
	ADD CONSTRAINT FK_OFERTAS_USUA_USERNAME
	FOREIGN KEY (USUA_USERNAME)
	REFERENCES SALUDOS.USUARIOS(USUA_USERNAME)

ALTER TABLE SALUDOS.OFERTAS
	ADD CONSTRAINT FK_OFERTAS_PUBL_COD
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

---------------------------------------
----------Migración e índices----------
---------------------------------------
--Agregando roles.
INSERT INTO SALUDOS.ROLES (ROL_NOMBRE)
	VALUES ('Administrador'), ('Cliente'), ('Empresa')


--Agregando funcionalidades.
INSERT INTO SALUDOS.FUNCIONALIDADES(FUNC_NOMBRE)
	VALUES	('ABM Roles'),
			('ABM Usuarios'),
			('ABM Visibilidades'),
			('Vender'),
			('Comprar/Ofertar'),
			('Historial de cliente'),
			('Calificar al vendedor'),
			('Consulta de facturas'),
			('Listado estadístico')


--Agregando funcionalidades por cada rol.
INSERT INTO SALUDOS.FUNCIONALIDADESXROL(
	ROL_COD, FUNC_COD)
SELECT
	ROL_COD, FUNC_COD
FROM SALUDOS.ROLES, SALUDOS.FUNCIONALIDADES
WHERE	(ROL_NOMBRE = 'Cliente' AND
			FUNC_NOMBRE IN ('Vender', 'Comprar/Ofertar', 'Historial de cliente', 'Calificar al vendedor', 'Consulta de facturas')) OR
		(ROL_NOMBRE = 'Empresa' AND
			FUNC_NOMBRE IN ('Vender', 'Consulta de facturas')) OR
		(ROL_NOMBRE = 'Administrador' AND
			FUNC_NOMBRE LIKE '%')


--La tabla maestra tiene datos de clientes guardados en dos lugares distintos.
--Primero se migran clientes que hayan hecho una publicación.
INSERT INTO SALUDOS.CLIENTES(
	CLIE_NRO_DOCUMENTO, CLIE_APELLIDO, CLIE_NOMBRE, CLIE_FECHA_NACIMIENTO, CLIE_MAIL,
	CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_CODIGO_POSTAL, CLIE_TIPO_DOCUMENTO)
SELECT DISTINCT
	Publ_Cli_Dni, Publ_Cli_Apeliido, Publ_Cli_Nombre, Publ_Cli_Fecha_Nac, Publ_Cli_Mail,
	Publ_Cli_Dom_Calle, Publ_Cli_Nro_Calle, Publ_Cli_Piso, Publ_Cli_Depto, Publ_Cli_Cod_Postal, 'DNI'
FROM gd_esquema.Maestra
WHERE Publ_Cli_Dni IS NOT NULL


--Luego se migran clientes que hayan realizado una compra.
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


--Migrando empresas.
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


--Migrando rubros.
INSERT INTO SALUDOS.RUBROS(
	RUBR_NOMBRE)
SELECT DISTINCT
	Publicacion_Rubro_Descripcion
FROM gd_esquema.Maestra
WHERE Publicacion_Rubro_Descripcion IS NOT NULL


--Migrando visibilidades.
INSERT INTO SALUDOS.VISIBILIDADES(
	VISI_COD, VISI_DESCRIPCION, VISI_COMISION_ENVIO,
	VISI_COMISION_PUBLICACION, VISI_COMISION_VENTA)
SELECT DISTINCT
	Publicacion_Visibilidad_Cod, Publicacion_Visibilidad_Desc, 0.10,
	Publicacion_Visibilidad_Precio, Publicacion_Visibilidad_Porcentaje
FROM gd_esquema.Maestra

UPDATE SALUDOS.VISIBILIDADES
SET VISI_COMISION_ENVIO = 0.00
WHERE VISI_DESCRIPCION = 'Gratis'

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
	HASHBYTES('SHA2_256', EMPR_CUIT),
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


--Agregando estados.
INSERT INTO SALUDOS.ESTADOS(
	ESTA_NOMBRE)
VALUES ('Activa'), ('Finalizada'), ('Borrador'), ('Pausada')


--Agregando tipos.
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
SELECT
	Item_Factura_Monto, Item_Factura_Cantidad,
	Factura_Nro,
	CASE
		WHEN Item_Factura_Monto = Publicacion_Visibilidad_Precio
				THEN 'Comisión por Publicación'
		ELSE 'Comisión por Venta'
	END
FROM gd_esquema.Maestra
WHERE Item_Factura_Monto IS NOT NULL

UPDATE items
SET items.ITEM_DESCRIPCION = 'Comisión por Venta' 
FROM (
    SELECT *, ROW_NUMBER() OVER (PARTITION BY FACT_COD ORDER BY (SELECT NULL)) filas
    FROM SALUDOS.ITEMS
) items
WHERE filas > 1


--Migrando compras de publicaciones de tipo Compra Inmediata.
INSERT INTO SALUDOS.COMPRAS(
	COMP_CANTIDAD, COMP_OPTA_ENVIO, COMP_FECHA, COMP_FORMA_PAGO,
	COMP_PRECIO, PUBL_COD, USUA_USERNAME)

SELECT DISTINCT
	Compra_Cantidad, 0, Compra_Fecha, 'Efectivo',
	Publicacion_Precio, Publicacion_Cod,
	LOWER(Cli_Nombre) + LOWER(Cli_Apeliido)
FROM gd_esquema.Maestra
WHERE Compra_Fecha IS NOT NULL AND Publicacion_Tipo = 'Compra Inmediata'


--Migrando compras de publicaciones de tipo Subasta.
INSERT INTO SALUDOS.COMPRAS(
	COMP_CANTIDAD, COMP_OPTA_ENVIO, COMP_FECHA, COMP_FORMA_PAGO,
	COMP_PRECIO, PUBL_COD, USUA_USERNAME)

SELECT DISTINCT
	1, 0, Oferta_Fecha, 'Efectivo',
	Oferta_Monto, Publicacion_Cod,
	LOWER(Cli_Nombre) + LOWER(Cli_Apeliido)
FROM gd_esquema.Maestra t1
WHERE	Oferta_Fecha IS NOT NULL
		AND Publicacion_Tipo = 'Subasta' AND
		Oferta_Monto =	(SELECT MAX(Oferta_Monto)
						FROM gd_esquema.Maestra t2
						WHERE Oferta_Monto IS NOT NULL AND t2.Publicacion_Cod = t1.Publicacion_Cod)


--Migrando ofertas de Subastas.
INSERT INTO SALUDOS.OFERTAS(
	OFER_FECHA, OFER_OFERTA, OFER_OPTA_ENVIO, PUBL_COD,
	USUA_USERNAME)

SELECT DISTINCT
	Oferta_Fecha, Oferta_Monto, 0, Publicacion_Cod,
	LOWER(Cli_Nombre) + LOWER(Cli_Apeliido)
FROM gd_esquema.Maestra
WHERE Oferta_Fecha IS NOT NULL


--Migrando calificaciones.
SET IDENTITY_INSERT SALUDOS.CALIFICACIONES ON;

INSERT INTO SALUDOS.CALIFICACIONES(
	CALI_COD, CALI_ESTRELLAS,
	CALI_DESCRIPCION, PUBL_COD, USUA_USERNAME)
SELECT DISTINCT
	Calificacion_Codigo, CEILING(Calificacion_Cant_Estrellas/2),
	Calificacion_Descripcion, Publicacion_Cod,
	LOWER(Cli_Nombre) + LOWER(Cli_Apeliido)
FROM gd_esquema.Maestra
WHERE Calificacion_Codigo IS NOT NULL

SET IDENTITY_INSERT SALUDOS.CALIFICACIONES OFF;

GO

UPDATE SALUDOS.CALIFICACIONES
SET CALI_FECHA = COMP_FECHA
FROM SALUDOS.COMPRAS
WHERE CALIFICACIONES.PUBL_COD = COMPRAS.PUBL_COD
	AND CALIFICACIONES.USUA_USERNAME = COMPRAS.USUA_USERNAME


--Creando administrador default.
INSERT INTO SALUDOS.USUARIOS(
	USUA_USERNAME, USUA_PASSWORD, USUA_TIPO)
VALUES('admin', HASHBYTES('SHA2_256', CONVERT(nvarchar(255), 'w23e')), 'Administrador')


--Agregando roles Cliente, Empresa y Administrador
--a los clientes, empresas... y administrador.
INSERT INTO SALUDOS.ROLESXUSUARIO(
	USUA_USERNAME, ROL_COD)
SELECT USUA_USERNAME, ROL_COD
FROM SALUDOS.USUARIOS, SALUDOS.ROLES
WHERE	USUA_TIPO = 'Cliente' AND ROL_NOMBRE = 'Cliente' OR
		USUA_TIPO = 'Empresa' AND ROL_NOMBRE = 'Empresa' OR
		USUA_TIPO = 'Administrador' AND ROL_NOMBRE = 'Administrador'


--Creando índices.
CREATE INDEX IDX_RUBR_NOMBRE
ON SALUDOS.RUBROS (RUBR_NOMBRE)

CREATE INDEX IDX_ROL_NOMBRE
ON SALUDOS.ROLES (ROL_NOMBRE)

CREATE INDEX IDX_CLIENTE_NOMBRE
ON SALUDOS.CLIENTES (CLIE_NOMBRE)

CREATE INDEX IDX_CLIENTE_APELLIDO
ON SALUDOS.CLIENTES (CLIE_APELLIDO)

CREATE INDEX IDX_CLIENTE_NRO_DOC
ON SALUDOS.CLIENTES (CLIE_NRO_DOCUMENTO)

CREATE INDEX IDX_CLIENTE_MAIL
ON SALUDOS.CLIENTES (CLIE_MAIL)

CREATE INDEX IDX_EMPRESA_RAZON_SOCIAL
ON SALUDOS.EMPRESAS (EMPR_RAZON_SOCIAL)

CREATE INDEX IDX_EMPRESA_CUIT
ON SALUDOS.EMPRESAS (EMPR_CUIT)

CREATE INDEX IDX_EMPRESA_MAIL
ON SALUDOS.EMPRESAS (EMPR_MAIL)


-----------------------------------------------------
-----Functions y procedures relacionados a Fecha-----
-----------------------------------------------------
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


--------------------------------------------------------
-----Funciones y procedures relacionadas a Facturas-----
--------------------------------------------------------
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

--Factura compra y envío, de corresponder, para las subastas ganadas.
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

--Factura la comisión por publicación.
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

--Factura una publicación gratuita para los usuarios nuevos.
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

--Factura únicamente la comisión de compra.
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

--Factura las comisiones de compra y envío.
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


-------------------------------------------------------------
-----Funciones y procedures relacionadas a Publicaciones-----
-------------------------------------------------------------
CREATE FUNCTION SALUDOS.mostrarPublicaciones(
	@descripcion nvarchar(255), @rubro nvarchar(255))
RETURNS @publicaciones TABLE (	Código numeric(18,0), Descripción nvarchar(255),
								Precio numeric(18,2), Rubro nvarchar(255),
								Tipo nvarchar(255), Envío nvarchar(2)) AS
	BEGIN
		--Requisitos para mostrar una publicación:
		--#El usuario debe estar habilitado,
		--#La descripción tiene que incluir el texto que se busca,
		--#La publicación debe pertenecer al rubro pedido,
		--#La publicación debe estar activa.

		INSERT @publicaciones
		SELECT	PUBL_COD, PUBL_DESCRIPCION, PUBL_PRECIO, RUBR_NOMBRE, TIPO_NOMBRE,
				CASE WHEN PUBL_PERMITE_ENVIO = 1 THEN 'Sí' ELSE 'No' END
		FROM SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr, SALUDOS.TIPOS tipo
		WHERE	1 = (	SELECT USUA_HABILITADO
						FROM SALUDOS.USUARIOS usua
						WHERE usua.USUA_USERNAME = publ.USUA_USERNAME) AND
				(PUBL_DESCRIPCION LIKE '%' + @descripcion + '%' OR @descripcion IS NULL) AND
				publ.RUBR_COD = rubr.RUBR_COD AND
				(publ.RUBR_COD = (	SELECT RUBR_COD
									FROM SALUDOS.RUBROS
									WHERE RUBR_NOMBRE = @rubro) OR @rubro IS NULL) AND
				publ.TIPO_COD =	tipo.TIPO_COD AND
				ESTA_COD = (	SELECT ESTA_COD
								FROM SALUDOS.ESTADOS
								WHERE ESTA_NOMBRE = 'Activa')
		ORDER BY VISI_COD
		RETURN;
	END
GO

--Para poder paginar las publicaciones.
CREATE FUNCTION SALUDOS.cantidadDePaginasPublicaciones(
	@descripcion nvarchar(255), @rubro nvarchar(255))
RETURNS int AS
	BEGIN
		
		DECLARE @cuenta decimal
		
		SET @cuenta = (
			SELECT COUNT(*)
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr, SALUDOS.TIPOS tipo
			WHERE	1 = (	SELECT USUA_HABILITADO
							FROM SALUDOS.USUARIOS usua
							WHERE usua.USUA_USERNAME = publ.USUA_USERNAME) AND
					(PUBL_DESCRIPCION LIKE '%' + @descripcion + '%' OR @descripcion IS NULL) AND
					publ.RUBR_COD = rubr.RUBR_COD AND
					(publ.RUBR_COD = (	SELECT RUBR_COD
										FROM SALUDOS.RUBROS
										WHERE RUBR_NOMBRE = @rubro) OR @rubro IS NULL) AND
					publ.TIPO_COD =	tipo.TIPO_COD AND
					ESTA_COD = (	SELECT ESTA_COD
									FROM SALUDOS.ESTADOS
									WHERE ESTA_NOMBRE = 'Activa')
		)

		SET @cuenta = CEILING(@cuenta / 10)
		RETURN CONVERT(int, @cuenta)
	END
GO

--Al iniciar la aplicación se revisa qué publicaciones deben estar activas y cuáles no.
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

	UPDATE SALUDOS.PUBLICACIONES
	SET SALUDOS.PUBLICACIONES.ESTA_COD = @codFinalizada
	FROM 	(SELECT comp.PUBL_COD, PUBL_STOCK, SUM(COMP_CANTIDAD) AS COMP_ACTUALES, ESTA_COD
			FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
			WHERE comp.PUBL_COD = publ.PUBL_COD AND COMP_FECHA <= SALUDOS.fechaActual() 
			GROUP BY comp.PUBL_COD, PUBL_STOCK, ESTA_COD) COMPRAS
	WHERE	COMPRAS.ESTA_COD = @codActiva AND
			COMPRAS.COMP_ACTUALES = COMPRAS.PUBL_STOCK AND
			COMPRAS.PUBL_COD = SALUDOS.PUBLICACIONES.PUBL_COD
GO

--Al iniciar la publicación se adjudican las subastas terminadas a sus ganadores.
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
	COMP_CANTIDAD, COMP_FECHA, COMP_FORMA_PAGO, COMP_OPTA_ENVIO,
	COMP_PRECIO, PUBL_COD, USUA_USERNAME)

	SELECT DISTINCT
	1, OFER_FECHA, 'Efectivo', OFER_OPTA_ENVIO,
	OFER_OFERTA, t1.PUBL_COD, t1.USUA_USERNAME

	FROM SALUDOS.OFERTAS t1, SALUDOS.PUBLICACIONES publ
	WHERE	publ.PUBL_COD = t1.PUBL_COD AND
			TIPO_COD = @tipoSubasta AND
			ESTA_COD = @codFinalizada AND
			OFER_OFERTA = 	(SELECT MAX(OFER_OFERTA)
							FROM SALUDOS.OFERTAS t2
							WHERE t2.PUBL_COD = t1.PUBL_COD)
			AND NOT EXISTS (SELECT PUBL_COD
							FROM SALUDOS.COMPRAS comp
							WHERE comp.PUBL_COD = publ.PUBL_COD)

	EXEC SALUDOS.facturarSubastasAdjudicadas
GO

--Generar publicación.
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

	DECLARE @codPublicacion numeric(18,0)
	SET @codPublicacion = SCOPE_IDENTITY()

	DECLARE @usuarioNuevo bit
	SET @usuarioNuevo = (	SELECT USUA_NUEVO
							FROM SALUDOS.USUARIOS
							WHERE USUA_USERNAME = @usuario)

	IF (@visibilidad <> 'Gratis' AND @usuarioNuevo = 1)
		BEGIN
			EXEC SALUDOS.facturarPublicacionGratuita @codPublicacion

			UPDATE SALUDOS.USUARIOS
			SET USUA_NUEVO = 0
			WHERE USUA_USERNAME = @usuario
		END
	ELSE BEGIN
		EXEC SALUDOS.facturarPublicacion @codPublicacion
	END

GO

--Stock de una publicación considerando las compras ya realizadas.
CREATE FUNCTION SALUDOS.stockActual(@codPublicacion numeric(18,0))
RETURNS int AS
	BEGIN
		DECLARE @cantidadComprada int
		
		SET @cantidadComprada = (
			SELECT SUM(COMP_CANTIDAD)
			FROM SALUDOS.COMPRAS
			WHERE	PUBL_COD = @codPublicacion AND
					COMP_FECHA <= SALUDOS.fechaActual()
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

--Muestra las publicaciones para cambiar su estado.
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

CREATE FUNCTION SALUDOS.detallesPublicacionCompraInmediata(@codigo numeric(18,0))
RETURNS @publicaciones TABLE (	Descripción nvarchar(255), Precio numeric(18,2), Rubro nvarchar(255),
								Stock numeric(18,0), Envío bit, Vendedor nvarchar(255)) AS
	BEGIN
		INSERT @publicaciones
		SELECT PUBL_DESCRIPCION, PUBL_PRECIO, RUBR_NOMBRE, SALUDOS.stockActual(@codigo), PUBL_PERMITE_ENVIO, USUA_USERNAME
		FROM SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr
		WHERE	PUBL_COD = @codigo AND
				publ.RUBR_COD = rubr.RUBR_COD
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.detallesPublicacionSubasta(@codigo numeric(18,0))
RETURNS @publicaciones TABLE (	Descripción nvarchar(255), Precio numeric(18,2), Rubro nvarchar(255),
								Última_Oferta numeric(18,2), Envío bit, Vendedor nvarchar(255)) AS
	BEGIN
		INSERT @publicaciones
		SELECT PUBL_DESCRIPCION, PUBL_PRECIO, RUBR_NOMBRE, SALUDOS.ultimaOferta(@codigo), PUBL_PERMITE_ENVIO, USUA_USERNAME
		FROM SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr
		WHERE	PUBL_COD = @codigo AND
				publ.RUBR_COD = rubr.RUBR_COD
		RETURN;
	END
GO


-----------------------------------------------------------------
-----Funciones y procedures relacionadas a Comprar y Ofertar-----
-----------------------------------------------------------------
CREATE PROCEDURE SALUDOS.comprar
	@codPublicacion numeric(18,0),
	@cantidadComprada numeric(18,0),
	@usuario nvarchar(255),	
	@optaEnvio bit
AS
	INSERT INTO SALUDOS.COMPRAS(
	COMP_CANTIDAD, COMP_FECHA, COMP_FORMA_PAGO,
	COMP_PRECIO, PUBL_COD, USUA_USERNAME, COMP_OPTA_ENVIO)

	VALUES(
	@cantidadComprada, SALUDOS.fechaActual(), 'Efectivo',

	(SELECT PUBL_PRECIO
	FROM SALUDOS.PUBLICACIONES
	WHERE PUBL_COD = @codPublicacion),

	@codPublicacion, @usuario, @optaEnvio)

	IF SALUDOS.stockActual(@codPublicacion) = 0 BEGIN
		EXEC SALUDOS.cambiarEstadoPublicacion @codPublicacion, 'Finalizada'
	END

	DECLARE @precio numeric(18,2)
	SET @precio =	(SELECT PUBL_PRECIO
					FROM SALUDOS.PUBLICACIONES
					WHERE PUBL_COD = @codPublicacion)

	IF @optaEnvio = 1
		BEGIN
			EXEC SALUDOS.facturarCompraYEnvio @codPublicacion, @cantidadComprada, @precio
		END
	ELSE
		BEGIN
			EXEC SALUDOS.facturarCompra	@codPublicacion, @cantidadComprada, @precio
		END
GO

CREATE PROCEDURE SALUDOS.ofertar
	@codPublicacion numeric(18,0),
	@oferta numeric(18,2),
	@usuario nvarchar(255),
	@optaEnvio bit
AS
	INSERT INTO SALUDOS.OFERTAS(
	OFER_FECHA, OFER_OFERTA,
	PUBL_COD, USUA_USERNAME, OFER_OPTA_ENVIO)

	VALUES(
	SALUDOS.fechaActual(), @oferta,
	@codPublicacion, @usuario, @optaEnvio)
GO

CREATE FUNCTION SALUDOS.ultimaOferta(@codPublicacion numeric(18,0))
RETURNS numeric(18,2) AS
	BEGIN
		DECLARE @oferta numeric(18,2)
		
		SET @oferta = (
			SELECT MAX(OFER_OFERTA)
			FROM SALUDOS.OFERTAS
			WHERE PUBL_COD = @codPublicacion
		)

		IF @oferta IS NULL 
			SET @oferta = 0.00
		
		RETURN @oferta

	END

GO


--------------------------------------------------------------------
-----Funciones y procedures relacionadas a Historial de Cliente-----
--------------------------------------------------------------------
--Para paginar el historial de compras u ofertas.
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
RETURNS @compras TABLE (Código_Compra numeric(18,0), Código_Publicación numeric(18,0),
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
RETURNS @subastas TABLE (	Código_Oferta numeric(18,0), Código_Publicación numeric(18,0),
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

CREATE FUNCTION SALUDOS.cantidadComprasRealizadas(@username nvarchar(255))
RETURNS int AS
	BEGIN
		
		DECLARE @compra int
		SET @compra = (	SELECT TIPO_COD
						FROM SALUDOS.TIPOS
						WHERE TIPO_NOMBRE = 'Compra Inmediata')
		
		DECLARE @cuenta int
		SET @cuenta = (SELECT COUNT(*)
					   FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
					   WHERE	comp.PUBL_COD = publ.PUBL_COD AND
								comp.USUA_USERNAME = @username AND
								publ.TIPO_COD = @compra)	
		RETURN @cuenta
	END
GO

CREATE FUNCTION SALUDOS.cantidadSubastasGanadas(@username nvarchar(255))
RETURNS int AS
	BEGIN
		
		DECLARE @subasta int
		SET @subasta = (	SELECT TIPO_COD
						FROM SALUDOS.TIPOS
						WHERE TIPO_NOMBRE = 'Subasta')
		
		DECLARE @cuenta int
		SET @cuenta = (SELECT COUNT(*)
					   FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
					   WHERE	comp.PUBL_COD = publ.PUBL_COD AND
								comp.USUA_USERNAME = @username AND
								publ.TIPO_COD = @subasta)	
		RETURN @cuenta
	END
GO


-------------------------------------------------------------------
-----Funciones y procedures relacionadas a Listado Estadístico-----
-------------------------------------------------------------------
--Esta función no devuelve nada post-migración porque todos los productos fueron vendidos.
CREATE FUNCTION SALUDOS.vendedoresConMayorCantidadDeProductosNoVendidos(@anio int, @trimestre int, @visibilidad nvarchar(255))
RETURNS @tabla TABLE (Vendedor nvarchar(255), Productos_sin_vender int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		DECLARE @codFinalizada int
		SET @codFinalizada = (	SELECT ESTA_COD
								FROM SALUDOS.ESTADOS
								WHERE ESTA_NOMBRE = 'Finalizada')
			
		INSERT @tabla
			SELECT TOP 5 usua.USUA_USERNAME, COUNT(*) cantidad
			FROM SALUDOS.USUARIOS usua, SALUDOS.PUBLICACIONES publ, SALUDOS.VISIBILIDADES visi
			WHERE	usua.USUA_USERNAME = publ.USUA_USERNAME AND
					publ.VISI_COD = visi.VISI_COD AND
					VISI_DESCRIPCION = @visibilidad AND
					ESTA_COD = @codFinalizada AND
					YEAR(publ.PUBL_FINALIZACION) = @anio AND
					(MONTH(publ.PUBL_FINALIZACION) BETWEEN @primerMes AND @tercerMes) AND
					NOT EXISTS (	SELECT comp.PUBL_COD
									FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ2
									WHERE publ2.PUBL_COD = comp.PUBL_COD AND publ2.PUBL_COD = publ.PUBL_COD)
			GROUP BY usua.USUA_USERNAME
			ORDER BY cantidad DESC
		RETURN;
	END
GO

--Esta función no devuelve nada post-migración porque todos los productos fueron vendidos.
CREATE FUNCTION SALUDOS.productosSinVenderDeUnVendedor(@anio int, @trimestre int, @usuario nvarchar(255), @visibilidad nvarchar(255))
RETURNS @tabla TABLE (	Código numeric(18,0), Descripción nvarchar(255), Precio numeric(18,2),
						Inicio datetime, Finalización datetime)
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		DECLARE @codFinalizada int
		SET @codFinalizada = (	SELECT ESTA_COD
								FROM SALUDOS.ESTADOS
								WHERE ESTA_NOMBRE = 'Finalizada')

		INSERT @tabla
			SELECT PUBL_COD, PUBL_DESCRIPCION, PUBL_PRECIO, PUBL_INICIO, PUBL_FINALIZACION
			FROM SALUDOS.PUBLICACIONES publ, SALUDOS.VISIBILIDADES visi
			WHERE	USUA_USERNAME = @usuario AND
					publ.VISI_COD = visi.VISI_COD AND
					VISI_DESCRIPCION = @visibilidad AND
					ESTA_COD = @codFinalizada AND
					YEAR(publ.PUBL_FINALIZACION) = @anio AND
					(MONTH(publ.PUBL_FINALIZACION) BETWEEN @primerMes AND @tercerMes) AND
					NOT EXISTS (	SELECT comp.PUBL_COD
									FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ2
									WHERE publ2.PUBL_COD = comp.PUBL_COD AND publ2.PUBL_COD = publ.PUBL_COD)
			ORDER BY publ.PUBL_INICIO
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.clientesMasCompradoresEnUnRubro(@anio int, @trimestre int, @rubro nvarchar(255))
RETURNS @tabla TABLE (Cliente nvarchar(255), Productos_comprados int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		INSERT @tabla
			SELECT TOP 5 comp.USUA_USERNAME, COUNT(COMP_COD) cantidad
			FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ, SALUDOS.RUBROS rubr
			WHERE	comp.PUBL_COD = publ.PUBL_COD AND
					publ.RUBR_COD = rubr.RUBR_COD AND
					YEAR(comp.COMP_FECHA) = @anio AND
					(MONTH(comp.COMP_FECHA) BETWEEN @primerMes AND @tercerMes) AND
					RUBR_NOMBRE = @rubro
			GROUP BY comp.USUA_USERNAME
			ORDER BY cantidad DESC 
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMasFacturas(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Facturas int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		INSERT @tabla
			SELECT TOP 5 USUA_USERNAME, COUNT(FACT_COD) cantidad
			FROM SALUDOS.FACTURAS
			WHERE	YEAR(FACT_FECHA) = @anio AND
					(MONTH(FACT_FECHA) BETWEEN @primerMes AND @tercerMes)
			GROUP BY USUA_USERNAME
			ORDER BY cantidad DESC
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMayorFacturacion(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Monto_Facturado int) AS
	BEGIN
		DECLARE @primerMes int
		DECLARE @tercerMes int
		
		SET @primerMes = (@trimestre * 3) - 2 
		SET @tercerMes = @trimestre * 3

		INSERT @tabla
			SELECT TOP 5 publ.USUA_USERNAME, SUM(COMP_PRECIO * COMP_CANTIDAD) monto
			FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ
			WHERE	comp.PUBL_COD = publ.PUBL_COD AND
					YEAR(comp.COMP_FECHA) = @anio AND
					(MONTH(COMP.COMP_FECHA) BETWEEN @primerMes AND @tercerMes)
			GROUP BY publ.USUA_USERNAME
			ORDER BY monto DESC
		RETURN;
	END
GO


-----------------------------------------------------------------
-----Funciones y procedures relacionadas a Calificar Compras-----
-----------------------------------------------------------------
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
RETURNS @publicaciones TABLE (	Vendedor nvarchar(255), Código numeric(18,0),
								Descripción nvarchar(255), Precio numeric(18,2),
								Tipo nvarchar(255)) AS
BEGIN
	INSERT @publicaciones
		SELECT publ.USUA_USERNAME, publ.PUBL_COD, PUBL_DESCRIPCION, COMP_PRECIO, TIPO_NOMBRE
		FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ, SALUDOS.TIPOS tipo
		WHERE	comp.PUBL_COD = publ.PUBL_COD AND
				publ.TIPO_COD = tipo.TIPO_COD AND
				comp.USUA_USERNAME = @usuario AND
				NOT EXISTS(	SELECT *
							FROM SALUDOS.CALIFICACIONES cali
							WHERE	publ.PUBL_COD = cali.PUBL_COD AND
									cali.USUA_USERNAME = comp.USUA_USERNAME)
	RETURN;
END
GO

CREATE FUNCTION SALUDOS.cuantasEstrellasPara(@usuario nvarchar(255), @estrellas int)
RETURNS int AS
	BEGIN
		RETURN(
			SELECT COUNT(*)
			FROM SALUDOS.CALIFICACIONES cali, SALUDOS.PUBLICACIONES publ, SALUDOS.TIPOS tipo
			WHERE	cali.PUBL_COD = publ.PUBL_COD AND
					publ.TIPO_COD = tipo.TIPO_COD AND	
					cali.USUA_USERNAME = @usuario AND
					CALI_ESTRELLAS = @estrellas
		)
	END
GO

CREATE FUNCTION SALUDOS.cantidadCalificacionesPendientes(@usuario nvarchar(255))
RETURNS int AS
	BEGIN
		RETURN (
			SELECT COUNT(*)
			FROM SALUDOS.COMPRAS comp, SALUDOS.PUBLICACIONES publ, SALUDOS.TIPOS tipo
			WHERE	comp.PUBL_COD = publ.PUBL_COD AND
					publ.TIPO_COD = tipo.TIPO_COD AND
					comp.USUA_USERNAME = @usuario AND
					NOT EXISTS(	SELECT *
								FROM SALUDOS.CALIFICACIONES cali
								WHERE	publ.PUBL_COD = cali.PUBL_COD AND
										cali.USUA_USERNAME = @usuario)
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


--------------------------------------------------------------
-----Procedures relacionados a Login y Cambio de Password-----
--------------------------------------------------------------
CREATE PROCEDURE SALUDOS.login
(@usuario nvarchar(255), @password_ingresada nvarchar(255))
AS
BEGIN
	DECLARE @password nvarchar(255),
			@password_hasheada nvarchar(255),
			@intentos tinyint,
			@existe_usuario int,
			@usuario_habilitado bit

	SELECT @existe_usuario = COUNT(*)
	FROM SALUDOS.USUARIOS
	WHERE USUA_USERNAME = @usuario


	IF @existe_usuario = 0
		BEGIN
			RAISERROR('El usuario no existe.', 16, 1)
			RETURN
		END


	SELECT @usuario_habilitado = USUA_HABILITADO
	FROM SALUDOS.USUARIOS
	WHERE USUA_USERNAME = @usuario

	IF @usuario_habilitado = 0
		BEGIN
			RAISERROR('El usuario ha sido inhabilitado. Por favor, contáctese con un administrador', 16, 1)
			RETURN
		END


	SELECT @password = USUA_PASSWORD
	FROM SALUDOS.USUARIOS
	WHERE USUA_USERNAME = @usuario

	SELECT @password_hasheada = HASHBYTES('SHA2_256',@password_ingresada)

	IF @password <> @password_hasheada
		BEGIN
			RAISERROR('Contraseña incorrecta.', 16, 1)

			UPDATE SALUDOS.USUARIOS
			SET USUA_INTENTOS_LOGIN = USUA_INTENTOS_LOGIN + 1
			WHERE USUA_USERNAME =  @usuario

			SELECT @intentos = USUA_INTENTOS_LOGIN
			FROM SALUDOS.USUARIOS
			WHERE USUA_USERNAME = @usuario

			IF @intentos >= 3
			BEGIN
				RAISERROR('Ha ingresado la contraseña 3 veces de forma incorrecta. El usuario ha sido inhabilitado', 16, 1)

				UPDATE SALUDOS.USUARIOS
				SET USUA_HABILITADO = 0
				WHERE USUA_USERNAME = @usuario

				RETURN
			END
		
		END
	ELSE
		BEGIN
			UPDATE SALUDOS.USUARIOS
			SET USUA_INTENTOS_LOGIN = 0
			WHERE USUA_USERNAME = @usuario
			RETURN
		END
END
GO

CREATE PROCEDURE SALUDOS.cambiarPassword
(@username nvarchar(255), @passwordActual nvarchar(255), @nuevaPassword nvarchar(255))
AS BEGIN
	DECLARE @password nvarchar(255)
	IF (SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0	---No existe el usuario----
		BEGIN
			RAISERROR('No existe el usuario.',16,1) 
		END
	
	SET @password = (SELECT USUA_PASSWORD FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username)
	
	IF(HASHBYTES('SHA2_256', @passwordActual) = @password)----La pass actual es correcta----
		BEGIN
			UPDATE SALUDOS.USUARIOS
			SET USUA_PASSWORD = HASHBYTES('SHA2_256', @nuevaPassword)
			WHERE USUA_USERNAME = @username
		END
	ELSE
		BEGIN
			RAISERROR('La contraseña actual es incorrecta', 16,1)
		END
END
GO

--Un administrador puede modificar cualquier password.
CREATE PROCEDURE SALUDOS.cambiarPasswordAdmin
(@username nvarchar(255), @nuevaPassword nvarchar(255))
AS BEGIN
	IF (SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0	---No existe el usuario----
		BEGIN
			RAISERROR('No existe el usuario.',16,1) 
		END
	
	UPDATE SALUDOS.USUARIOS
	SET USUA_PASSWORD = HASHBYTES('SHA2_256', @nuevaPassword)
	WHERE USUA_USERNAME = @username
END

GO

-----------------------------------------------------------
-----Funciones y procedures relacionados a ABM Usuario-----
-----------------------------------------------------------
CREATE FUNCTION SALUDOS.existeTipoYNumeroDeDocumento
(@username nvarchar(255), @nro_documento numeric(18,0), @tipo_documento nvarchar(50))
RETURNS int
AS
BEGIN
	DECLARE @existe int

	SET @existe = (SELECT COUNT(*) 
	FROM SALUDOS.CLIENTES
	WHERE CLIE_NRO_DOCUMENTO = @nro_documento AND CLIE_TIPO_DOCUMENTO = @tipo_documento AND USUA_USERNAME <> @username)

	RETURN @existe
END
GO

CREATE PROCEDURE SALUDOS.altaUsuarioCliente
(@username nvarchar(255), @password nvarchar(255), @id_rol int, @nombre nvarchar(255), @apellido nvarchar(255),
 @telefono numeric(18,0), @calle nvarchar(255), @nro_calle numeric(18,0), @nacimiento datetime, @cod_postal nvarchar(50),
 @depto nvarchar(50), @piso numeric(18,0), @localidad nvarchar(255), @documento numeric(18,0), @tipo_documento nvarchar(50),
 @mail nvarchar(50))
 AS
 BEGIN TRANSACTION
	IF ((SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0) --NO EXISTE OTRO USERNAME IGUAL
		BEGIN
			IF (SALUDOS.existeTipoYNumeroDeDocumento(@username, @documento, @tipo_documento) = 0) --NO EXISTE CLIENTE CON MISMO TIPO Y NRO DE DOCUMENTO
				BEGIN
					DECLARE @fecha_actual datetime
					SET @fecha_actual = SALUDOS.fechaActual()
					INSERT INTO SALUDOS.USUARIOS(USUA_USERNAME, USUA_PASSWORD, USUA_NUEVO)
					VALUES(@username, HASHBYTES('SHA2_256', @password), 1)
					
					INSERT INTO SALUDOS.CLIENTES(CLIE_NOMBRE, CLIE_APELLIDO, CLIE_TELEFONO, CLIE_CALLE, CLIE_NRO_CALLE, 
					CLIE_FECHA_NACIMIENTO, CLIE_CODIGO_POSTAL, CLIE_DEPTO, CLIE_PISO, CLIE_LOCALIDAD, CLIE_NRO_DOCUMENTO,
					CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_FECHA_CREACION, USUA_USERNAME)
					VALUES(@nombre, @apellido, @telefono, @calle, @nro_calle, @nacimiento, @cod_postal, @depto, @piso,
					@localidad, @documento, @tipo_documento, @mail, @fecha_actual, @username)

					INSERT INTO SALUDOS.ROLESXUSUARIO(USUA_USERNAME, ROL_COD)
					VALUES(@username, @id_rol)
				END
			ELSE
				BEGIN
					RAISERROR('Ya existe un usuario con el mismo tipo y número de documento', 16, 1)
					RETURN
				END
		END
	ELSE
		BEGIN
			RAISERROR('Ya existe el usuario', 16, 1)
			RETURN
		END
COMMIT
GO

CREATE PROCEDURE SALUDOS.modificarCliente
(@id_cliente int, @nombre nvarchar(255), @apellido nvarchar(255), @telefono numeric(18,0), @calle nvarchar(255),
 @nro_calle numeric(18,0), @nacimiento datetime, @cod_postal nvarchar(50), @depto nvarchar(50), @piso numeric(18,0),
 @localidad nvarchar(255), @documento numeric(18,0), @tipo_documento nvarchar(50), @mail nvarchar(50))
AS
BEGIN
	DECLARE @username nvarchar(255)
	SET @username = (SELECT USUA_USERNAME FROM SALUDOS.CLIENTES WHERE CLIE_COD = @id_cliente)
	IF SALUDOS.existeTipoYNumeroDeDocumento(@username, @documento, @tipo_documento) = 0
		BEGIN
			UPDATE SALUDOS.CLIENTES
			SET CLIE_NOMBRE = @nombre, CLIE_APELLIDO = @apellido, CLIE_TELEFONO = @telefono, CLIE_CALLE = @calle,
			CLIE_NRO_CALLE = @nro_calle, CLIE_FECHA_NACIMIENTO = @nacimiento, CLIE_CODIGO_POSTAL = @cod_postal,
			CLIE_DEPTO = @depto, CLIE_PISO = @piso, CLIE_LOCALIDAD = @localidad, CLIE_NRO_DOCUMENTO = @documento,
			CLIE_TIPO_DOCUMENTO = @tipo_documento, CLIE_MAIL = @mail
			WHERE CLIE_COD = @id_cliente
		END
	ELSE
		BEGIN
			RAISERROR('El tipo y nro de documento ya existe', 16, 1)
			RETURN
		END
END
GO

CREATE FUNCTION SALUDOS.existeRazonSocialYCuit
(@username nvarchar(255), @razon_social nvarchar(255), @cuit nvarchar(50))
RETURNS int
AS
BEGIN
	DECLARE @existe int

	SET @existe = (SELECT COUNT(*)
	FROM SALUDOS.EMPRESAS WHERE EMPR_RAZON_SOCIAL = @razon_social AND EMPR_CUIT = @cuit)

	RETURN @existe
END
GO

CREATE PROCEDURE SALUDOS.altaUsuarioEmpresa
(@username nvarchar(255), @password nvarchar(255), @id_rol int, @razon_social nvarchar(255), @cuit nvarchar(50), 
 @mail nvarchar(50), @telefono numeric(18,0), @calle nvarchar(100), @nro_calle numeric(18,0), @piso numeric(18,0),
 @depto nvarchar(50), @ciudad nvarchar(50), @contacto nvarchar(50), @cod_postal nvarchar(50), @localidad nvarchar(50),
 @id_rubro int)
AS
BEGIN TRANSACTION
	IF ((SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0)----No existe otro usuario igual
		BEGIN
			IF (SALUDOS.existeRazonSocialYCuit(@username, @razon_social, @cuit) = 0)------No existe empresa con misma razon y cuit
				BEGIN
					DECLARE @fecha_actual datetime
					SET @fecha_actual = SALUDOS.fechaActual()
					INSERT INTO SALUDOS.USUARIOS(USUA_USERNAME, USUA_PASSWORD, USUA_NUEVO)
					VALUES(@username, HASHBYTES('SHA2_256', @password), 1)

					INSERT INTO SALUDOS.EMPRESAS(EMPR_RAZON_SOCIAL, EMPR_CUIT, EMPR_MAIL, EMPR_TELEFONO, EMPR_CALLE,
					EMPR_NRO_CALLE, EMPR_PISO, EMPR_DEPTO, EMPR_CIUDAD, EMPR_CONTACTO, EMPR_CODIGO_POSTAL, EMPR_LOCALIDAD,
					RUBR_COD, EMPR_FECHA_CREACION, USUA_USERNAME)
					VALUES(@razon_social, @cuit, @mail, @telefono, @calle, @nro_calle, @piso, @depto, @ciudad, @contacto, 
					@cod_postal, @localidad, @id_rubro, @fecha_actual, @username)

					INSERT INTO ROLESXUSUARIO(USUA_USERNAME, ROL_COD)
					VALUES(@username, @id_rol)
				END
			ELSE
				BEGIN
					RAISERROR('Ya existe empresa con misma Razon Social y Cuit', 16, 1)
					RETURN
				END
		END
	ELSE
		BEGIN
			RAISERROR('Ya existe el usuario', 16, 1)
			RETURN
		END
COMMIT
GO

CREATE PROCEDURE SALUDOS.modificarEmpresa
(@id_empresa int, @razon_social nvarchar(255), @cuit nvarchar(50), @mail nvarchar(50), @telefono numeric(18,0), @calle nvarchar(100), 
 @nro_calle numeric(18,0), @piso numeric(18,0), @depto nvarchar(50), @ciudad nvarchar(50), @contacto nvarchar(50), 
 @cod_postal nvarchar(50), @localidad nvarchar(50), @id_rubro int)
AS
BEGIN
	DECLARE @username nvarchar(255)
	SET @username = (SELECT USUA_USERNAME FROM SALUDOS.EMPRESAS WHERE EMPR_COD = @id_empresa)
	IF(SALUDOS.existeRazonSocialYCuit(@username, @razon_social, @cuit) = 0)---------No existe empresa con misma razon y cuit
		BEGIN
			UPDATE SALUDOS.EMPRESAS
			SET EMPR_RAZON_SOCIAL = @razon_social, EMPR_CUIT = @cuit, EMPR_MAIL = @mail, EMPR_TELEFONO = @telefono, 
			EMPR_CALLE = @calle, EMPR_NRO_CALLE = @nro_calle, EMPR_PISO = @piso, EMPR_DEPTO = @depto, EMPR_CIUDAD = @ciudad,
			EMPR_CONTACTO = @contacto, EMPR_CODIGO_POSTAL = @cod_postal, EMPR_LOCALIDAD = @localidad, RUBR_COD = @id_rubro
			WHERE EMPR_COD = @id_empresa
		END
	ELSE
		BEGIN
			RAISERROR('Ya existe empresa con misma Razon Social y Cuit', 16, 1)
			RETURN
		END
END
GO

CREATE PROCEDURE SALUDOS.borrarUsuario
(@username nvarchar(255))
AS
BEGIN
	UPDATE SALUDOS.USUARIOS
	SET USUA_HABILITADO = 0
	WHERE USUA_USERNAME = @username
END
GO

CREATE PROCEDURE SALUDOS.habilitarUsuario
(@username nvarchar(255))
AS
BEGIN
	UPDATE SALUDOS.USUARIOS
	SET USUA_HABILITADO = 1
	WHERE USUA_USERNAME = @username
END
GO

CREATE FUNCTION SALUDOS.filtrarEmpresas
(@razon_social nvarchar(255), @cuit nvarchar(50), @mail nvarchar(50))
RETURNS @empresas TABLE
(
	EMPR_RAZON_SOCIAL		nvarchar(255),
	EMPR_CUIT				nvarchar(50),
	EMPR_MAIL				nvarchar(50),
	EMPR_TELEFONO			numeric(18,0),
	EMPR_CALLE				nvarchar(100),
	EMPR_NRO_CALLE			numeric(18,0),
	EMPR_PISO				numeric(18,0),
	EMPR_DEPTO				nvarchar(50),
	EMPR_CIUDAD				nvarchar(50),
	EMPR_CONTACTO			nvarchar(50),
	EMPR_CODIGO_POSTAL		nvarchar(50),
	EMPR_LOCALIDAD			nvarchar(50),
	RUBR_NOMBRE				nvarchar(255)

)
AS
BEGIN
	IF(@cuit = '')
		BEGIN
			INSERT INTO @empresas(EMPR_RAZON_SOCIAL, EMPR_CUIT, EMPR_MAIL, EMPR_TELEFONO, EMPR_CALLE,
			EMPR_NRO_CALLE, EMPR_PISO, EMPR_DEPTO, EMPR_CIUDAD, EMPR_CONTACTO, EMPR_CODIGO_POSTAL,
			EMPR_LOCALIDAD, RUBR_NOMBRE)
			SELECT EMPR_RAZON_SOCIAL, EMPR_CUIT, EMPR_MAIL, EMPR_TELEFONO, EMPR_CALLE, EMPR_NRO_CALLE,
			EMPR_PISO, EMPR_DEPTO, EMPR_CIUDAD, EMPR_CONTACTO, EMPR_CODIGO_POSTAL, EMPR_LOCALIDAD, RUBR_NOMBRE
			FROM SALUDOS.EMPRESAS E LEFT JOIN SALUDOS.RUBROS R ON E.RUBR_COD = R.RUBR_COD
			WHERE EMPR_RAZON_SOCIAL LIKE '%' + @razon_social + '%' AND
			EMPR_MAIL LIKE '%' + @mail + '%'
		END
	ELSE
		BEGIN
			INSERT INTO @empresas(EMPR_RAZON_SOCIAL, EMPR_CUIT, EMPR_MAIL, EMPR_TELEFONO, EMPR_CALLE,
			EMPR_NRO_CALLE, EMPR_PISO, EMPR_DEPTO, EMPR_CIUDAD, EMPR_CONTACTO, EMPR_CODIGO_POSTAL,
			EMPR_LOCALIDAD, RUBR_NOMBRE)
			SELECT EMPR_RAZON_SOCIAL, EMPR_CUIT, EMPR_MAIL, EMPR_TELEFONO, EMPR_CALLE, EMPR_NRO_CALLE,
			EMPR_PISO, EMPR_DEPTO, EMPR_CIUDAD, EMPR_CONTACTO, EMPR_CODIGO_POSTAL, EMPR_LOCALIDAD, RUBR_NOMBRE
			FROM SALUDOS.EMPRESAS E LEFT JOIN SALUDOS.RUBROS R ON E.RUBR_COD = R.RUBR_COD
			WHERE EMPR_RAZON_SOCIAL LIKE '%' + @razon_social + '%' AND
			CONVERT(nvarchar, EMPR_CUIT) = @cuit AND
			EMPR_MAIL LIKE '%' + @mail + '%'
		END
	RETURN
END
GO

CREATE FUNCTION SALUDOS.filtrarClientes
(@nombre nvarchar(255), @apellido nvarchar(255), @nro_documento nvarchar(255), @mail nvarchar(50))
RETURNS @clientes TABLE
(
	CLIE_NOMBRE				nvarchar(255),
	CLIE_APELLIDO			nvarchar(255),
	CLIE_TELEFONO			numeric(18,0),
	CLIE_CALLE				nvarchar(255),
	CLIE_NRO_CALLE			numeric(18,0),
	CLIE_FECHA_NACIMIENTO	datetime,
	CLIE_CODIGO_POSTAL		nvarchar(50),
	CLIE_DEPTO				nvarchar(50),
	CLIE_PISO				numeric(18,0),
	CLIE_LOCALIDAD			nvarchar(255),
	CLIE_NRO_DOCUMENTO		numeric(18,0),
	CLIE_TIPO_DOCUMENTO		nvarchar(50),
	CLIE_MAIL				nvarchar(50)
)
AS
BEGIN
	IF (@nro_documento = '')
		BEGIN
			INSERT INTO @clientes (CLIE_NOMBRE, CLIE_APELLIDO, CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_TELEFONO,
			CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_LOCALIDAD, CLIE_CODIGO_POSTAL, CLIE_FECHA_NACIMIENTO)
			SELECT CLIE_NOMBRE, CLIE_APELLIDO, CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_TELEFONO,
			CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_LOCALIDAD, CLIE_CODIGO_POSTAL, CLIE_FECHA_NACIMIENTO
			FROM SALUDOS.CLIENTES
			WHERE CLIE_NOMBRE LIKE '%' + @nombre + '%' AND
			CLIE_APELLIDO LIKE '%' + @apellido + '%' AND
			CLIE_MAIL LIKE '%' + @mail + '%'
		END
	ELSE
		BEGIN
			INSERT INTO @clientes (CLIE_NOMBRE, CLIE_APELLIDO, CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_TELEFONO,
			CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_LOCALIDAD, CLIE_CODIGO_POSTAL, CLIE_FECHA_NACIMIENTO)
			SELECT CLIE_NOMBRE, CLIE_APELLIDO, CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_TELEFONO,
			CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_LOCALIDAD, CLIE_CODIGO_POSTAL, CLIE_FECHA_NACIMIENTO
			FROM SALUDOS.CLIENTES
			WHERE CLIE_NOMBRE LIKE '%' + @nombre + '%' AND
			CLIE_APELLIDO LIKE '%' + @apellido + '%' AND
			CONVERT(nvarchar, CLIE_NRO_DOCUMENTO) = @nro_documento AND
			CLIE_MAIL LIKE '%' + @mail + '%'
		END
	RETURN
END
GO


-------------------------------------------------------
-----Funciones y procedures relacionados a ABM Rol-----
-------------------------------------------------------
CREATE FUNCTION SALUDOS.existeRol
(@nombre nvarchar(50))
RETURNS int
AS
BEGIN
	DECLARE @existe int
	SET @existe = (SELECT COUNT(*) FROM SALUDOS.ROLES WHERE ROL_NOMBRE = @nombre)

	RETURN @existe
END
GO

CREATE PROCEDURE SALUDOS.crearRol
(@nombre nvarchar(50))
AS BEGIN
	IF SALUDOS.existeRol(@nombre) = 0
		BEGIN
			INSERT INTO SALUDOS.ROLES(ROL_NOMBRE)
			VALUES (@nombre)
		END
	ELSE
		BEGIN
			RAISERROR('Ya existe el rol', 16, 1)
			RETURN
		END	
END
GO

CREATE PROCEDURE SALUDOS.borrarRol
(@id_rol int)
AS BEGIN
	UPDATE SALUDOS.ROLES
	SET ROL_HABILITADO = 0
	WHERE ROL_COD = @id_rol

	UPDATE SALUDOS.ROLESXUSUARIO
	SET RXU_HABILITADO = 0
	WHERE ROL_COD = @id_rol

END
GO

CREATE PROCEDURE SALUDOS.habilitarRol
(@id_rol int)
AS BEGIN
	UPDATE SALUDOS.ROLES
	SET ROL_HABILITADO = 1
	WHERE ROL_COD = @id_rol
END
GO

CREATE PROCEDURE SALUDOS.modificarRol
(@id_rol int, @nombre nvarchar(50))
AS BEGIN
	UPDATE SALUDOS.ROLES
	SET ROL_NOMBRE = @nombre
	WHERE ROL_COD = @id_rol
END
GO

CREATE PROCEDURE SALUDOS.agregarFuncionalidadARol
(@nombre_rol nvarchar(255), @nombre_funcionalidad nvarchar(255))
AS 
	BEGIN TRY
		DECLARE @id_rol int, @id_funcionalidad int
		SET @id_rol = (SELECT ROL_COD FROM SALUDOS.ROLES WHERE ROL_NOMBRE = @nombre_rol)
		SET @id_funcionalidad = (SELECT FUNC_COD FROM SALUDOS.FUNCIONALIDADES WHERE FUNC_NOMBRE = @nombre_funcionalidad)
		INSERT INTO SALUDOS.FUNCIONALIDADESXROL(ROL_COD, FUNC_COD)
		VALUES(@id_rol, @id_funcionalidad)
	END TRY
	BEGIN CATCH
		RAISERROR('Esta funcionalidad ya está asociada a este rol', 16, 1)
	END CATCH
GO

CREATE PROCEDURE SALUDOS.quitarFuncionalidadDeRol
(@nombre_rol nvarchar(255), @nombre_funcionalidad nvarchar(255))
AS BEGIN
	DECLARE @id_rol int, @id_funcionalidad int
	SET @id_rol = (SELECT ROL_COD FROM SALUDOS.ROLES WHERE ROL_NOMBRE = @nombre_rol)
	SET @id_funcionalidad = (SELECT FUNC_COD FROM SALUDOS.FUNCIONALIDADES WHERE FUNC_NOMBRE = @nombre_funcionalidad)
	DELETE FROM SALUDOS.FUNCIONALIDADESXROL
	WHERE ROL_COD = @id_rol AND FUNC_COD = @id_funcionalidad
END
GO


------------------------------------------------------------------
-----Procedures relacionados a ABM Visibilidad de Publicación-----
------------------------------------------------------------------
CREATE PROCEDURE SALUDOS.altaVisibilidad
(@nombre_visibilidad nvarchar(255), @comision_publicacion numeric(18,2), @comision_venta numeric (18,2), @comision_envio numeric(18,2))
AS BEGIN
	INSERT INTO SALUDOS.VISIBILIDADES(VISI_COMISION_ENVIO, VISI_COMISION_PUBLICACION, VISI_COMISION_VENTA, VISI_DESCRIPCION)
	VALUES(@comision_envio, @comision_publicacion, @comision_venta, @nombre_visibilidad)
END
GO

CREATE PROCEDURE SALUDOS.modificarVisibilidad
(@nombre_visibilidad nvarchar(255), @comision_publicacion numeric(18,2), @comision_venta numeric (18,2), @comision_envio numeric(18,2))
AS BEGIN
	UPDATE SALUDOS.VISIBILIDADES
	SET VISI_COMISION_ENVIO = @comision_envio, VISI_COMISION_PUBLICACION = @comision_publicacion, 
		VISI_COMISION_VENTA = @comision_venta, VISI_DESCRIPCION = @nombre_visibilidad
	WHERE VISI_DESCRIPCION = @nombre_visibilidad
END
GO

CREATE PROCEDURE SALUDOS.bajaVisibilidad
(@nombre_visibilidad nvarchar(255))
AS BEGIN
	DELETE SALUDOS.VISIBILIDADES
	WHERE VISI_DESCRIPCION = @nombre_visibilidad
END
GO

CREATE PROCEDURE SALUDOS.asignarVisibilidadAPublicacion
(@desc_visibilidad nvarchar(255), @cod_publicacion numeric(18,0))
AS BEGIN
	UPDATE SALUDOS.PUBLICACIONES
	SET VISI_COD = (SELECT VISI_COD FROM SALUDOS.VISIBILIDADES
					WHERE VISI_DESCRIPCION = @desc_visibilidad)
	WHERE PUBL_COD = @cod_publicacion
END
GO


------------------------------------------------
----------Funciones getters auxiliares----------
------------------------------------------------
CREATE FUNCTION SALUDOS.getTipoUsuario
(@username nvarchar(255))
RETURNS TABLE
AS
	RETURN (SELECT USUA_TIPO FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username)
GO

CREATE FUNCTION SALUDOS.getRolesUsuario
(@username nvarchar(255))
RETURNS TABLE
AS
	RETURN (SELECT R.ROL_NOMBRE FROM SALUDOS.USUARIOS U, SALUDOS.ROLESXUSUARIO RXU, SALUDOS.ROLES R
			WHERE U.USUA_USERNAME = @username AND U.USUA_USERNAME = RXU.USUA_USERNAME AND R.ROL_COD = RXU.ROL_COD)
GO

CREATE FUNCTION SALUDOS.getFuncionalidadesRol
(@rol nvarchar(255))
RETURNS TABLE
AS
	RETURN (SELECT FUNC_NOMBRE FROM SALUDOS.ROLES R, SALUDOS.FUNCIONALIDADESXROL FR, SALUDOS.FUNCIONALIDADES F
			WHERE R.ROL_NOMBRE = @rol 
			AND R.ROL_COD = FR.ROL_COD AND F.FUNC_COD = FR.FUNC_COD)
GO

CREATE FUNCTION SALUDOS.getNombresVisibilidades
()
RETURNS TABLE
AS
	RETURN (SELECT VISI_DESCRIPCION
			FROM SALUDOS.VISIBILIDADES)
GO

CREATE FUNCTION SALUDOS.getRoles
(@nombreRol nvarchar(255), @habilitado nvarchar(50))
RETURNS TABLE
AS
	RETURN
		(SELECT ROL_NOMBRE FROM SALUDOS.ROLES WHERE	
		(ROL_NOMBRE = @nombreRol OR @nombreRol is null) AND
		(CONVERT(nvarchar, ROL_HABILITADO) = @habilitado OR @habilitado is null))
GO

CREATE FUNCTION SALUDOS.getUsuarios
(@username nvarchar(255), @tipo nvarchar(255), @habilitado nvarchar(50))
RETURNS TABLE
AS
	RETURN SELECT USUA_USERNAME FROM SALUDOS.USUARIOS WHERE 
			(USUA_USERNAME = @username OR @username IS NULL) AND
			(USUA_TIPO = @tipo OR @tipo IS NULL) AND
			(CONVERT(NVARCHAR,USUA_HABILITADO) = @habilitado OR @habilitado IS NULL)
GO

CREATE FUNCTION SALUDOS.getIdRubro
(@nombre_rubro nvarchar(255))
RETURNS TABLE
AS
	RETURN SELECT RUBR_COD FROM SALUDOS.RUBROS WHERE
			RUBR_NOMBRE = @nombre_rubro
GO

CREATE FUNCTION SALUDOS.getIdEmpresa
(@razon_social nvarchar(255), @cuit nvarchar(255))
RETURNS TABLE
AS
	RETURN SELECT EMPR_COD FROM SALUDOS.EMPRESAS WHERE
			EMPR_RAZON_SOCIAL = @razon_social AND EMPR_CUIT = @cuit
GO

CREATE FUNCTION SALUDOS.getIdCliente
(@tipo_doc nvarchar(50), @nro_doc nvarchar(50))
RETURNS TABLE
AS
	RETURN SELECT CLIE_COD FROM SALUDOS.CLIENTES WHERE
			CLIE_TIPO_DOCUMENTO = @tipo_doc AND
			CONVERT(nvarchar, CLIE_NRO_DOCUMENTO) = @nro_doc
GO

CREATE FUNCTION SALUDOS.getItemsFactura
(@cod_factura numeric(18,0))
RETURNS TABLE
AS
	RETURN SELECT ITEM_DESCRIPCION, ITEM_IMPORTE, ITEM_CANTIDAD
	FROM SALUDOS.ITEMS I 
	WHERE I.FACT_COD = @cod_factura
GO

CREATE FUNCTION SALUDOS.getComisionPublicacion
(@nombre_visibilidad nvarchar(255))
RETURNS TABLE
AS
	RETURN 
		SELECT VISI_COMISION_PUBLICACION FROM SALUDOS.VISIBILIDADES
		WHERE VISI_DESCRIPCION = @nombre_visibilidad
GO

CREATE FUNCTION SALUDOS.getComisionVenta
(@nombre_visibilidad nvarchar(255))
RETURNS TABLE
AS
	RETURN
		SELECT VISI_COMISION_VENTA FROM SALUDOS.VISIBILIDADES
		WHERE VISI_DESCRIPCION = @nombre_visibilidad
GO

CREATE FUNCTION SALUDOS.getComisionEnvio
(@nombre_visibilidad nvarchar(255))
RETURNS TABLE
AS
	RETURN
		SELECT VISI_COMISION_ENVIO FROM SALUDOS.VISIBILIDADES
		WHERE VISI_DESCRIPCION = @nombre_visibilidad
GO
