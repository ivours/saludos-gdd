
----ESTOS SON NECESARIOS------
CREATE INDEX IDX_RUBR_NOMBRE
ON SALUDOS.RUBROS (RUBR_NOMBRE)

CREATE INDEX IDX_ROL_NOMBRE
ON SALUDOS.ROLES (ROL_NOMBRE)

--------------------------------


--------ESTOS SON PARA LOS FILTROS, PODEMOS SACARLOS SI RELANTIZAN MUCHO LOS INSERT O UPDATES EN CLIENTES Y EMPRESAS--------
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

-----------------------------------------------