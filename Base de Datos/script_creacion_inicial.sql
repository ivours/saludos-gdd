CREATE SCHEMA SALUDOS

CREATE TABLE SALUDOS.PUBLICACIONES(
	PUBL_CODIGO			numeric(18,0)	PRIMARY KEY,	--Publicacion_Cod
	PUBL_DESCRIPCION	nvarchar(255),					--Publicacion_Descripcion
	PUBL_STOCK			numeric (18,0),					--Publicacion_Stock
	PUBL_INICIO			date,							--Publicacion_Fecha
	PUBL_FINALIZACION	date,							--Publicacion_Fecha_Venc
	PUBL_PRECIO			numeric(18,2),					--Publicacion_Precio
	PUBL_ESTADO			varchar(10),					--(borrador, activa, pausada, finalizada)
	PUBL_TIPO			nvarchar(255),					--Publicacion_Tipo
	PUBL_PREGUNTAS		bit,							--new
	PUBL_FECHA			date,							--???
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

--CREATE TABLE SALUDOS.TRANSACCIONES(
--)

--CREATE TABLE SALUDOS.CALIFICACIONES(
--)

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

--A Publicaciones hay que agregarle los siguientes FK:
--ALTER TABLE SALUDOS.PUBLICACIONES
--PUBL_CREADOR FK
--PUBL_VISIBILIDAD FK
--PUBL_RUBRO FK

