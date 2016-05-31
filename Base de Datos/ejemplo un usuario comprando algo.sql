select * from saludos.usuarios

UPDATE SALUDOS.USUARIOS
SET USUA_SIN_CALIFICAR = 0

UPDATE SALUDOS.USUARIOS
SET USUA_TIPO = 'Cliente'
where usua_username = 'felipe'

insert into saludos.publicaciones(publ_precio, tipo_cod)
values(1, 1)

insert into saludos.transacciones(publ_cod, tipo_cod, usua_username, tran_adjudicada)
values(71080, 1, 'felipe', 1)

select * from saludos.publicaciones
select * from saludos.transacciones
