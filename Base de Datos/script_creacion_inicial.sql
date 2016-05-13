CREATE SCHEMA SALUDOS


CREATE TABLE SALUDOS.PUBLICACIONES(

PUBL_CODIGO numeric(18,0) PRIMARY KEY,
PUBL_DESCRIPCION nvarchar(255),
PUBL_STOCK numeric (18,0),
PUBL_INICIO date,
PUBL_FINALIZACION date,
PUBL_PRECIO numeric(18,2),
PUBL_ESTADO varchar(10), --(borrador, activa, pausada, finalizada)
PUBL_TIPO nvarchar(255),
PUBL_PREGUNTAS bit,
PUBL_FECHA date,
)

CREATE TABLE SALUDOS.VISIBILIDADES(
VISI_COD int IDENTITY, --si me responden y me dejan volar los códigos existentes 1000#
VISI_COMISION_PUBLICACION numeric(18,  2),--maestra: Publicacion_Visibilidad_Precio
VISI_COMISION_VENTA numeric(18,2), --maestra: Publicacion_Visibilidad_Porcentaje
VISI_COMISION_ENVIO numeric(18, 2), --10% del valor inicial de la publicación.
VISI_PERMITE_ENVIO bit,
VISI_DESCRIPCION nvarchar(255),
)

--A Publicaciones hay que agregarle los siguientes FK:
--ALTER TABLE SALUDOS.PUBLICACIONES
--PUBL_CREADOR FK
--PUBL_VISIBILIDAD FK
--PUBL_RUBRO FK

