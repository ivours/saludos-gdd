CREATE SCHEMA SALUDOS

CREATE TABLE SALUDOS.PUBLICACIONES(
	PUBL_COD			numeric(18,0)	PRIMARY KEY,	--Publicacion_Cod
	PUBL_DESCRIPCION	nvarchar(255),					--Publicacion_Descripcion
	PUBL_STOCK			numeric (18,0),					--Publicacion_Stock
	PUBL_INICIO			datetime,						--Publicacion_Fecha
	PUBL_FINALIZACION	datetime,						--Publicacion_Fecha_Venc
	PUBL_PRECIO			numeric(18,2),					--Publicacion_Precio
	PUBL_ESTADO			varchar(10),					--(borrador, activa, pausada, finalizada)
	PUBL_TIPO			nvarchar(255),					--Publicacion_Tipo
	PUBL_PREGUNTAS		bit,							--new
)

CREATE TABLE SALUDOS.VISIBILIDADES(
	VISI_COD					int				IDENTITY	PRIMARY KEY,	--reemplaza Publiacion_Visibilidad_Cod
	VISI_COMISION_PUBLICACION	numeric(18,2),				--Publicacion_Visibilidad_Precio
	VISI_COMISION_VENTA			numeric(18,2),				--Publicacion_Visibilidad_Porcentaje
	VISI_COMISION_ENVIO			numeric(18,2),				--new. 10% del valor inicial de la publicación.
	VISI_PERMITE_ENVIO			bit,						--new
	VISI_DESCRIPCION			nvarchar(255),				--Publicacion_Visibilidad_Desc
)

CREATE TABLE SALUDOS.RUBROS(
	RUBR_COD			int				IDENTITY	PRIMARY KEY,	--new
	RUBR_NOMBRE			nvarchar(255),								--Publicacion_Rubro_Descripcion
	RUBR_DESCRIPCION	nvarchar(255),								--new
)

CREATE TABLE SALUDOS.TRANSACCIONES(
	TRAN_COD				int				IDENTITY	PRIMARY KEY,
	TRAN_TIPO				nvarchar(255),	--compra o subasta
	TRAN_ADJUDICADA			bit,			--si fue adjudicada (para subastas)
	TRAN_PRECIO				numeric(18,2),	--precio de compra u oferta
	TRAN_CANTIDAD_COMPRADA	numeric(2),		--en caso de compra directa
	TRAN_FECHA				datetime,		--momento de la transacción
)

CREATE TABLE SALUDOS.CALIFICACIONES(
	CALI_COD				int				IDENTITY	PRIMARY KEY,	--Calificacion_Codigo
	CALI_ESTRELLAS			numeric(18,0),								--Calificacion_Cant_Estrellas
	CALI_DESCRIPCION		nvarchar(255),								--Calificacion_Descripcion
	CALI_FECHA				datetime									--new
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
	PRIMARY KEY (EMPR_RAZON_SOCIAL, EMPR_CUIT)
)

CREATE TABLE SALUDOS.CLIENTES(
	CLIE_NOMBRE				nvarchar(255),	--Publ_Cli_Nombre
	CLIE_APELLIDO			nvarchar(255),	--Publ_Cli_Apeliido
	CLIE_TELEFONO			numeric(18,0),	--new
	CLIE_CALLE				nvarchar(255),	--Publ_Cli_Dom_Calle
	CLIE_NRO_CALLE			numeric(18,0),	--Publ_Cli_Nro_Calle
	CLIE_FECHA_CREACION		datetime,		--new
	CLIE_FECHA_NACIMIENTO	datetime,		--new
	CLIE_CODIGO_POSTAL		nvarchar(50),	--Publ_Cli_Cod_Postal
	CLIE_DEPTO				nvarchar(50),	--Publ_Cli_Depto
	CLIE_PISO				numeric(18,0),	--Publ_Cli_Piso
	CLIE_LOCALIDAD			nvarchar(255),	--new
	CLIE_NRO_DOCUMENTO		numeric(18,0),	--Publ_Cli_Dni.
	CLIE_TIPO_DOCUMENTO		nvarchar(50),	--new. Todos los documentos existentes son DNIs.
	CLIE_MAIL				nvarchar(50),	--new
	PRIMARY KEY (CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO)
)

CREATE TABLE SALUDOS.USUARIOS(
	USUA_USERNAME			nvarchar(50),	--new
	USUA_PASSWORD			nvarchar(50),	--new
	USUA_NUEVO				bit,			--new
	USUA_INTENTOS_LOGIN		tinyint,		--new
	USUA_SIN_CALIFICAR		tinyint,		--new
	USUA_TIPO				nvarchar(1),	--new. 'e' = empresa, 'u' = usuario
	CHECK (USUA_TIPO IN ('e', 'u'))
)

CREATE TABLE SALUDOS.FACTURAS(
	FACT_COD				int			IDENTITY PRIMARY KEY,	--Factura_Nro
	FACT_FECHA				datetime,							--Factura_Fecha
	FACT_TOTAL				numeric(18),						--Factura_Total
)

CREATE TABLE SALUDOS.ITEMS(
	ITEM_COD				int			IDENTITY PRIMARY KEY,	--new
	ITEM_IMPORTE			numeric(18),						--Item_Factura_Monto
	ITEM_CANTIDAD			numeric(2),							--Item_Factura_Cantidad
)

--CREATE TABLE SALUDOS.ROLES(
--)

--CREATE TABLE SALUDOS.FUNCIONALIDADES(
--)

--CREATE TABLE SALUDOS.ROLESXUSUARIO(
--)

--CREATE TABLE SALUDOS.FUNCIONALIDADESXROL(
--)

-----------FKs QUE HAY QUE AGREGAR-----------
--ALTER TABLE SALUDOS.PUBLICACIONES
--PUBL_CREADOR FK
--PUBL_VISIBILIDAD FK
--PUBL_RUBRO FK

--ALTER TABLE SALUDOS.TRANSACCIONES
--TRAN_COMPRADOR FK
--TRAN_VENDEDOR FK
--TRAN_PUBLICACION FK

--ALTER TABLE SALUDOS.CALIFICACIONES
--CALI_USUARIO FK
--CALI_PUBLICACION FK

--ALTER TABLE SALUDOS.EMPRESAS
--EMPR_USERNAME FK
--EMPR_RUBRO_PRINCIPAL FK

--ALTER TABLE SALUDOS.CLIENTES
--CLIE_USERNAME FK

--ALTER TABLE SALUDOS.FACTURAS
--FACT_USUARIO FK
--FACT_PUBLICACION FK

--ALTER TABLE SALUDOS.ITEMS
--ITEM_FACTURA FK