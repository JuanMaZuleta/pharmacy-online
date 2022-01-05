-- @Autor (es): Cruz Ramos Diego Alejandro
-- Juan Manuel Zuleta Ceja
-- Pedro Martínez Alvarez
-- @Fecha creación: 05/01/2022
-- @Descripción: Carga de datos

--si ocurre un error, se hace rollback de los datos y se sale de SQL
whenever sqlerror exit rollback

prompt realizando la carga de datos
@s-pr-centro_de_operacion.sql
@s-pr-almacen.sql
@s-pr-farmacia.sql
@s-pr-oficina.sql
@s-pr-cliente.sql
@s-pr-pedido.sql
@s-pr-detalle_pedido.sql
@s-pr-empleado.sql
@s-pr-farmacia_medicamento_presentacion.sql
@s-pr-presentacion.sql
@s-pr-medicamento.sql
@s-pr-medicamento_nombre.sql
@s-pr-medicamento_operacion.sql
@s-pr-medicamento_presentacion.sql
@s-pr-operacion.sql
@s-pr-presentacion.sql
@s-pr-status_pedido.sql
@s-pr-tarjeta.sql
@s-pr-ubicacion.sql

prompt confirmando cambios
commit;

--Si se encuentra un error no sale de sql
--no hace commit ni rollback
--regresa al estado original

whenever sqlerror continue none

Prompt Se han cargado los datos
