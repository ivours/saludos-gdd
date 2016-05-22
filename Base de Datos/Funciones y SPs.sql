---------LOGIN---------
CREATE PROCEDURE SALUDOS.login
(@usuario nvarchar(50), @password_ingresada nvarchar(50))
AS
BEGIN
	DECLARE @password nvarchar(50),
			@password_hasheada nvarchar(50),
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

	SELECT @password_hasheada = convert(nvarchar(50), HASHBYTES('SHA2_256', @password_ingresada), 1)

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




--------CREAR USUARIO CLIENTE----------
CREATE PROCEDURE SALUDOS.alta_usuario_cliente
(@username nvarchar(50), @password nvarchar(50), @nombre_rol nvarchar(50), @nombre nvarchar(255), @apellido nvarchar(255),
 @telefono numeric(18,0), @calle nvarchar(255), @nro_calle numeric(18,0), @nacimiento datetime, @cod_postal nvarchar(50),
 @depto nvarchar(50), @piso numeric(18,0), @localidad nvarchar(255), @documento numeric(18,0), @tipo_documento nvarchar(50),
 @mail nvarchar(50))
 AS
 BEGIN TRANSACTION
	IF ((SELECT COUNT(*) FROM SALUDOS.USUARIOS WHERE USUA_USERNAME = @username) = 0) --NO EXISTE OTRO USERNAME IGUAL
		BEGIN
			IF ((SELECT COUNT(*) FROM SALUDOS.CLIENTES WHERE CLIE_NRO_DOCUMENTO = @documento
			AND CLIE_TIPO_DOCUMENTO = @tipo_documento)=0) --NO EXISTE CLIENTE CON MISMO TIPO Y NRO DE DOCUMENTO
				BEGIN
					INSERT INTO SALUDOS.USUARIOS(USUA_USERNAME, USUA_PASSWORD, USUA_NUEVO, USUA_SIN_CALIFICAR)
					VALUES(@username, convert(nvarchar(50), HASHBYTES('SHA2_256', @password), 1), 1, 1)
					
					INSERT INTO SALUDOS.CLIENTES(CLIE_NOMBRE, CLIE_APELLIDO, CLIE_TELEFONO, CLIE_CALLE, CLIE_NRO_CALLE, 
					CLIE_FECHA_NACIMIENTO, CLIE_CODIGO_POSTAL, CLIE_DEPTO, CLIE_PISO, CLIE_LOCALIDAD, CLIE_NRO_DOCUMENTO,
					CLIE_TIPO_DOCUMENTO, CLIE_MAIL, CLIE_FECHA_CREACION)
					VALUES(@nombre, @apellido, @telefono, @calle, @nro_calle, @nacimiento, @cod_postal, @depto, @piso,
					@localidad, @documento, @tipo_documento, @mail, GETDATE())

					INSERT INTO SALUDOS.ROLESXUSUARIO(USUA_USERNAME, ROL_NOMBRE)
					VALUES(@username, @nombre_rol)
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
