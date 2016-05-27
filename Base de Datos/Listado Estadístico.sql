--Listado Estadístico
--Esta funcionalidad debe permitir consultar el TOP 5 de:
--# Vendedores con mayor cantidad de productos no vendidos.
--  Dicho listado debe filtrarse por grado de visibilidad de la publicación y por mes-año.
--  Primero se deberá ordenar por fecha y luego por visibilidad.
--# Clientes con mayor cantidad de productos comprados, por mes y por año, dentro de un rubro particular
--# Vendedores con mayor cantidad de facturas dentro de un mes y año particular
--# Vendedores con mayor monto facturado dentro de un mes y año particular

CREATE FUNCTION SALUDOS.vendedoresConMayorCantidadDeProductosNoVendidos(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Productos_sin_vender int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5
			FROM
			WHERE
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.clientesMasCompradoresEnUnRubro(@anio int, @trimestre int, @rubro nvarchar(255))
RETURNS @tabla TABLE (Cliente nvarchar(255), Productos_comprados int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5
			FROM
			WHERE
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMasFacturas(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor nvarchar(255), Facturas int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5
			FROM
			WHERE
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.vendedoresConMayorFacturacion(@anio int, @trimestre int)
RETURNS @tabla TABLE (Vendedor numeric(18,0), Monto_Facturado int) AS
	BEGIN
		INSERT @tabla
			SELECT TOP 5
			FROM
			WHERE
		RETURN;
	END
GO
