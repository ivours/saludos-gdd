insert into saludos.usuarios(usua_username, usua_tipo)
values('felipe', 'Cliente')

insert into saludos.publicaciones(publ_precio, tipo_cod)
values(1, 1)

insert into saludos.transacciones(publ_cod, tipo_cod, usua_username, tran_adjudicada)
values(71079, 1, 'felipe', 1)

select * from saludos.usuarios
select * from saludos.publicaciones
select * from saludos.transacciones


--Agregando cuántas calificaciones tiene pendientes cada usuario.
--Resulta que es cero para todos los usuarios, pero bue...
--Hacer el select fue interesante. ¯\_(o.o)_/¯
UPDATE SALUDOS.USUARIOS
SET USUA_SIN_CALIFICAR = cuento.cuantos
FROM(
	SELECT usua.USUA_USERNAME, COUNT(*) cuantos
	FROM SALUDOS.TRANSACCIONES trns, SALUDOS.PUBLICACIONES publ, SALUDOS.TIPOS tipo, SALUDOS.USUARIOS usua
	WHERE	trns.PUBL_COD = publ.PUBL_COD AND
			trns.TIPO_COD = tipo.TIPO_COD AND
			trns.TRAN_ADJUDICADA = 1 AND
			USUA_TIPO = 'Cliente' AND
			trns.USUA_USERNAME = usua.USUA_USERNAME AND
			NOT EXISTS(	SELECT *
						FROM SALUDOS.CALIFICACIONES cali
						WHERE	publ.PUBL_COD = cali.PUBL_COD AND
								cali.USUA_USERNAME = trns.USUA_USERNAME)
	GROUP BY usua.USUA_USERNAME) cuento
WHERE cuento.USUA_USERNAME = SALUDOS.USUARIOS.USUA_USERNAME
