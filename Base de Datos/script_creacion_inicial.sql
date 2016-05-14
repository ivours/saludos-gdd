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
	PUBL_FECHA			datetime,						--???
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

--CREATE TABLE SALUDOS.EMPRESAS(
--)

--CREATE TABLE SALUDOS.CLIENTES(
--)

--CREATE TABLE SALUDOS.USUARIOS(
--)

--CREATE TABLE SALUDOS.FACTURAS(
--)

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