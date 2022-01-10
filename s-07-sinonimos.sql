-- @Autor (es): Cruz Ramos Diego Alejandro
-- Juan Manuel Zuleta Ceja
-- Pedro Martínez Alvarez
-- @Fecha creación: 04/01/2022
-- @Descripción: Creación de sinonimos

connect cmz_proy_admin/cmz
prompt Creando sinonimos del usuario admin
create or replace public synonym comprador for cliente;
create or replace public synonym lugar for ubicacion;
create or replace public synonym tarjeta_de_pago for tarjeta;

prompt Dando permisos al usuario invitado
grant select on cliente to cmz_proy_invitado;
grant select on ubicacion to cmz_proy_invitado;
grant select on tarjeta to cmz_proy_invitado;
grant select on empleado to cmz_proy_invitado;
grant select on medicamento to cmz_proy_invitado;
grant select on centro_de_operacion to cmz_proy_invitado;

connect cmz_proy_invitado/cmz
prompt Creando sinonimos del usuario invitado
create or replace synonym empleado for cmz_proy_admin.empleado;
create or replace synonym medicamento for cmz_proy_admin.medicamento;
create or replace synonym centro_de_operacion for cmz_proy_admin.centro_de_operacion;

connect cmz_proy_admin/cmz
prompt Creando sinonimos con prefijo
create or replace synonym pr_centro_de_operacion 
  for centro_de_operacion;
create or replace synonym pr_empleado 
  for empleado;
create or replace synonym pr_farmacia 
  for farmacia;
create or replace synonym pr_almacen 
  for almacen;
create or replace synonym pr_oficina 
  for oficina;
create or replace synonym pr_operacion 
  for operacion;
create or replace synonym pr_medicamento_operacion 
  for medicamento_operacion;
create or replace synonym pr_farmacia_medicamento_operacion 
  for farmacia_medicamento_operacion;
create or replace synonym pr_medicamento_presentacion 
  for medicamento_presentacion;
create or replace synonym pr_medicamento 
  for medicamento;
create or replace synonym pr_presentacion 
  for presentacion;
create or replace synonym pr_medicamento_nombre 
  for medicamento_nombre;
create or replace synonym pr_pedido 
  for pedido;
create or replace synonym pr_cliente 
  for cliente;
create or replace synonym pr_tarjeta 
  for tarjeta;
create or replace synonym pr_detalle_pedido 
  for detalle_pedido;
create or replace synonym pr_historico_status 
  for historico_status;
create or replace synonym pr_status_pedido
  for status_pedido;
create or replace synonym pr_empleado_despedido
  for empleado_despedido;
create or replace synonym pr_operacion_riesgo
  for operacion_riesgo;
