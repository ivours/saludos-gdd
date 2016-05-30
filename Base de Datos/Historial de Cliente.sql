--Historial del Cliente
--Se muestran en una grilla el historial de todas las transacciones de un cliente.

CREATE FUNCTION SALUDOS.historialDeCompras(@usuario nvarchar(255))
RETURNS @compras TABLE (Código numeric(18,0), Descripción nvarchar(255), Precio numeric(18,2),
						Fecha datetime, Estrellas numeric(18,0)) AS
	BEGIN
		INSERT @compras
			SELECT 
			FROM 
			WHERE
			ORDER BY
		RETURN;
	END
GO

CREATE FUNCTION SALUDOS.historialDeSubastas(@usuario nvarchar(255))
RETURNS @subastas TABLE (Código numeric(18,0), Descripción nvarchar(255), Oferta numeric(18,2),
						Adjudicada bit, Fecha datetime, Estrellas numeric(18,0)) AS
	BEGIN
		INSERT @subastas
			SELECT 
			FROM 
			WHERE
			ORDER BY
		RETURN;
	END
GO

