--compra (ya no se hace a mano, hay funciones y procedures)

insert into saludos.usuarios(usua_username, usua_tipo)
values('felipe', 'Cliente')

insert into saludos.publicaciones(publ_precio, tipo_cod)
values(1, 1)

insert into saludos.transacciones(publ_cod, tipo_cod, usua_username, tran_adjudicada)
values(71079, 1, 'felipe', 1)


--subasta. la gana helipaz
exec saludos.crearPublicacion 'odamartínez', 'Subasta', 'cacaaaaaaaa', 1, 40.00, 'Soportes', 'Activa', 1, 'Gratuita', 1

exec saludos.ofertar 71079, 14.00, 'odamartínez'
exec saludos.ofertar 71079, 15.00, 'rinaldogarcía'
exec saludos.ofertar 71079, 1000, 'helipaz'

exec saludos.adjudicarSubastas


--prueba respecto a fechas y publicaciones finalizadas
exec saludos.asignarfecha '2015-04-15 00:00:00.000' 
exec saludos.actualizarEstadosDePublicaciones


--ejemplo de cómo estaba hecha la creación de usuarios con dos cursores
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

----Migrando usuarios.
EXECUTE SALUDOS.migrarUsuarios
GO
