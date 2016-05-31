---------LOGIN---------
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
			RAISERROR('El usuario ha sido inhabilitado. Por favor, cont�ctese con un administrador', 16, 1)
			RETURN
		END


	SELECT @password = USUA_PASSWORD
	FROM SALUDOS.USUARIOS
	WHERE USUA_USERNAME = @usuario

	SELECT @password_hasheada = HASHBYTES('SHA2_256',@password_ingresada)

	IF @password <> @password_hasheada
		BEGIN
			RAISERROR('Contrase�a incorrecta.', 16, 1)

			UPDATE SALUDOS.USUARIOS
			SET USUA_INTENTOS_LOGIN = USUA_INTENTOS_LOGIN + 1
			WHERE USUA_USERNAME =  @usuario

			SELECT @intentos = USUA_INTENTOS_LOGIN
			FROM SALUDOS.USUARIOS
			WHERE USUA_USERNAME = @usuario

			IF @intentos >= 3
			BEGIN
				RAISERROR('Ha ingresado la contrase�a 3 veces de forma incorrecta. El usuario ha sido inhabilitado', 16, 1)

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


-------FUNCION PARA VER SI YA ESTA EN USO EL TIPO Y NRO DE DOC----------
CREATE FUNCTION SALUDOS.existeTipoYNumeroDeDocumento
(@nro_documento numeric(18,0), @tipo_documento nvarchar(50))
RETURNS int
AS
BEGIN
	DECLARE @existe int

	SET @existe = (SELECT COUNT(*) 
	FROM SALUDOS.CLIENTES
	WHERE CLIE_NRO_DOCUMENTO = @nro_documento AND CLIE_TIPO_DOCUMENTO = @tipo_documento)

	RETURN @existe
END
GO


--------CREAR USUARIO CLIENTE----------
CREATE PROCEDURE SALUDOS.altaUsuarioCliente
(@username nvarchar(255), @password nvarchar(255), @id_rol int, @nombre nvarchar(255), @apellido nvarchar(255),
 @telefono numeric(18,0), @calle nvarchar(255), @nro_calle numeric(18,0), @nacimiento datetime, @cod_postal nvarchar(50),
 @depto nvarchar(50), @piso numeric(18,0), @localidad nvarchar(255), @documento numeric(18,0), @tipo_documento nvarchar(50),
 @mail nvarchar(50))
 AS
 BEGIN TRANSACTION
	IF ((SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0) --NO EXISTE OTRO USERNAME IGUAL
		BEGIN
			IF (SALUDOS.existeTipoYNumeroDeDocumento(@documento, @tipo_documento) = 0) --NO EXISTE CLIENTE CON MISMO TIPO Y NRO DE DOCUMENTO
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
					RAISERROR('Ya existe un usuario con el mismo tipo y n�mero de documento', 16, 1)
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



---------MODIFICAR CLIENTE-----------
CREATE PROCEDURE SALUDOS.modificarCliente
(@id_cliente int, @nombre nvarchar(255), @apellido nvarchar(255), @telefono numeric(18,0), @calle nvarchar(255),
 @nro_calle numeric(18,0), @nacimiento datetime, @cod_postal nvarchar(50), @depto nvarchar(50), @piso numeric(18,0),
 @localidad nvarchar(255), @documento numeric(18,0), @tipo_documento nvarchar(50), @mail nvarchar(50))
AS
BEGIN

	IF SALUDOS.existeTipoYNumeroDeDocumento(@documento, @tipo_documento) = 0
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





--------FUNCION PARA VER SI EXISTE EMPRESA CON MISMO RAZON SOCIAL Y CUIT---------
CREATE FUNCTION SALUDOS.existeRazonSocialYCuit
(@razon_social nvarchar(255), @cuit nvarchar(50))
RETURNS int
AS
BEGIN
	DECLARE @existe int

	SET @existe = (SELECT COUNT(*)
	FROM SALUDOS.EMPRESAS WHERE EMPR_RAZON_SOCIAL = @razon_social AND EMPR_CUIT = @cuit)

	RETURN @existe
END
GO

--------CREAR USUARIO EMPRESA----------
CREATE PROCEDURE SALUDOS.altaUsuarioEmpresa
(@username nvarchar(255), @password nvarchar(255), @id_rol int, @razon_social nvarchar(255), @cuit nvarchar(50), 
 @mail nvarchar(50), @telefono numeric(18,0), @calle nvarchar(100), @nro_calle numeric(18,0), @piso numeric(18,0),
 @depto nvarchar(50), @ciudad nvarchar(50), @contacto nvarchar(50), @cod_postal nvarchar(50), @localidad nvarchar(50),
 @id_rubro int)
AS
BEGIN TRANSACTION
	IF ((SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0)----No existe otro usuario igual
		BEGIN
			IF (SALUDOS.existeRazonSocialYCuit(@razon_social, @cuit) = 0)------No existe empresa con misma razon y cuit
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


-----------MODIFICAR EMPRESA------------
CREATE PROCEDURE SALUDOS.modificarEmpresa
(@id_empresa int, @razon_social nvarchar(255), @cuit nvarchar(50), @mail nvarchar(50), @telefono numeric(18,0), @calle nvarchar(100), 
 @nro_calle numeric(18,0), @piso numeric(18,0), @depto nvarchar(50), @ciudad nvarchar(50), @contacto nvarchar(50), 
 @cod_postal nvarchar(50), @localidad nvarchar(50), @id_rubro int)
AS
BEGIN
	IF(SALUDOS.existeRazonSocialYCuit(@razon_social, @cuit) = 0)---------No existe empresa con misma razon y cuit
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



--------BORRAR USUARIO----------
CREATE PROCEDURE SALUDOS.borrarUsuario
(@username nvarchar(255))
AS
BEGIN
	UPDATE SALUDOS.USUARIOS
	SET USUA_HABILITADO = 0
	WHERE USUA_USERNAME = @username
END
GO


------HABILITAR USUARIO-----------
CREATE PROCEDURE SALUDOS.habilitarUsuario
(@username nvarchar(255))
AS
BEGIN
	UPDATE SALUDOS.USUARIOS
	SET USUA_HABILITADO = 1
	WHERE USUA_USERNAME = @username
END
GO


-----FUNCION PARA VER SI EXISTE ROL CON MISMO NOMBRE------
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

--------CREAR ROL------------
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

----------BORRAR ROL-------------
CREATE PROCEDURE SALUDOS.borrarRol
(@id_rol int)
AS BEGIN
	UPDATE SALUDOS.ROLES
	SET ROL_HABILITADO = 0
	WHERE ROL_COD = @id_rol

	UPDATE SALUDOS.ROLESXUSUARIOS
	SET RXU_HABILITADO = 0
	WHERE ROL_COD = @id_rol

END
GO


----------MODIFICAR ROL-----------
CREATE PROCEDURE SALUDOS.modificarRol
(@id_rol int, @nombre nvarchar(50))
AS BEGIN
	UPDATE SALUDOS.ROLES
	SET ROL_NOMBRE = @nombre
	WHERE ROL_COD = @id_rol
END
GO


--------AGREGAR FUNCIONALIDAD A ROL------
CREATE PROCEDURE SALUDOS.agregarFuncionalidadARol
(@id_rol int, @id_funcionalidad int)
AS 
	BEGIN TRY
		INSERT INTO SALUDOS.FUNCIONALIDADESXROL(ROL_COD, FUNC_COD)
		VALUES(@id_rol, @id_funcionalidad)
	END TRY
	BEGIN CATCH
		RAISERROR('Esta funcionalidad ya esta asociada a este rol', 16, 1)
	END CATCH
GO


--------QUITAR FUNCIONALIDAD DE UN ROL-------
CREATE PROCEDURE SALUDOS.quitarFuncionalidadDeRol
(@id_rol int, @id_funcionalidad int)
AS BEGIN
	DELETE FROM SALUDOS.FUNCIONALIDADESXROL
	WHERE ROL_COD = @id_rol AND FUNC_COD = @id_funcionalidad
END
GO


-------OBTENER USUARIO--------
CREATE FUNCTION SALUDOS.getTipoUsuario
(@username nvarchar(255))
RETURNS TABLE
AS
	RETURN (SELECT USUA_TIPO FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username)
GO



------MOSTRAR ROLES DE USUARIO------
CREATE FUNCTION SALUDOS.getRolesUsuario
(@username nvarchar(255))
RETURNS TABLE
AS
	RETURN (SELECT R.ROL_NOMBRE FROM SALUDOS.USUARIOS U, SALUDOS.ROLESXUSUARIO RXU, SALUDOS.ROLES R
			WHERE U.USUA_USERNAME = RXU.USUA_USERNAME AND R.ROL_COD = RXU.ROL_COD)
GO


------FILTRAR CLIENTES-------
CREATE FUNCTION SALUDOS.filtrarClientes
(@nombre nvarchar(255), @apellido nvarchar(255), @nro_documento numeric(18,0), @mail nvarchar(50))
RETURNS TABLE
AS
	RETURN (SELECT CLIE_NOMBRE, CLIE_APELLIDO, CLIE_NRO_DOCUMENTO, CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_TELEFONO,
			CLIE_CALLE, CLIE_NRO_CALLE, CLIE_PISO, CLIE_DEPTO, CLIE_LOCALIDAD, CLIE_CODIGO_POSTAL, CLIE_FECHA_NACIMIENTO
			FROM SALUDOS.CLIENTES
			WHERE CLIE_NOMBRE LIKE '%' + @nombre + '%' AND
			CLIE_APELLIDO LIKE '%' + @apellido + '%' AND 
			CLIE_NRO_DOCUMENTO LIKE '%' + @nro_documento + '%' AND
			CLIE_MAIL LIKE '%' + @mail + '%')
GO



-----FILTRAR EMPRESAS-------
CREATE FUNCTION SALUDOS.filtrarEmpresas
(@razon_social nvarchar(255), @cuit nvarchar(50), @mail nvarchar(50))
RETURNS TABLE
AS
	RETURN (SELECT EMPR_RAZON_SOCIAL, EMPR_MAIL, EMPR_TELEFONO, EMPR_CALLE, EMPR_NRO_CALLE, EMPR_PISO, EMPR_DEPTO, EMPR_LOCALIDAD, 
	EMPR_CODIGO_POSTAL, EMPR_CIUDAD, EMPR_CUIT, EMPR_CONTACTO, RUBR_NOMBRE
	FROM SALUDOS.EMPRESAS E JOIN SALUDOS.RUBROS R ON E.RUBR_COD = R.RUBR_COD
	WHERE EMPR_RAZON_SOCIAL LIKE '%' + @razon_social + '%' AND
	EMPR_CUIT LIKE '%' + @cuit + '%' AND
	EMPR_MAIL LIKE '%' + @mail + '%')
GO