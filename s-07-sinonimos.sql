-- @Autor (es): Cruz Ramos Diego Alejandro
-- Juan Manuel Zuleta Ceja
-- Pedro Martínez Alvarez
-- @Fecha creación: 04/01/2022
-- @Descripción: Creación de sinonimos

connect cmz_proy_admin/cmz
prompt Creando sinonimos del usuario admin
create or replace public synonym s_cliente for cliente;
create or replace public synonym s_ubicacion for ubicacion;
create or replace public synonym s_tarjeta for tarjeta;

prompt Dando permisos al usuario invitado
grant select on empleado to cmz_proy_invitado;
grant select on medicamento to cmz_proy_invitado;
grant select on centro_de_operacion to cmz_proy_invitado;

connect cmz_proy_invitado/cmz
prompt Creando sinonimos del usuario guest
create or replace synonym s_empleado for cmz_proy_admin.empleado;
create or replace synonym s_medicamento for cmz_proy_admin.medicamento;
create or replace synonym s_cen_de_op for cmz_proy_admin.centro_de_operacion;

connect cmz_proy_admin/cmz
prompt Creando sinonimos con prefijo
create or replace synonym pr_centro_de_operacion 
  for cmz_proy_admin.centro_de_operacion;
create or replace synonym pr_empleado 
  for cmz_proy_admin.empleado;
create or replace synonym pr_farmacia 
  for cmz_proy_admin.farmacia;
create or replace synonym pr_almacen 
  for cmz_proy_admin.almacen;
create or replace synonym pr_oficina 
  for cmz_proy_admin.oficina;
create or replace synonym pr_operacion 
  for cmz_proy_admin.operacion;
create or replace synonym pr_medicamento_operacion 
  for cmz_proy_admin.medicamento_operacion;
create or replace synonym pr_farmacia_medicamento_operacion 
  for cmz_proy_admin.farmacia_medicamento_operacion;
create or replace synonym pr_medicamento_presentacion 
  for cmz_proy_admin.medicamento_presentacion;
create or replace synonym pr_medicamento 
  for cmz_proy_admin.medicamento;
create or replace synonym pr_presentacion 
  for cmz_proy_admin.presentacion;
create or replace synonym pr_medicamento_nombre 
  for cmz_proy_admin.medicamento_nombre;
create or replace synonym pr_pedido 
  for cmz_proy_admin.pedido;
create or replace synonym pr_cliente 
  for cmz_proy_admin.cliente;
create or replace synonym pr_tarjeta 
  for cmz_proy_admin.tarjeta;
create or replace synonym pr_detalle_pedido 
  for cmz_proy_admin.detalle_pedido;
create or replace synonym pr_historico_status 
  for cmz_proy_admin.historico_status;
create or replace synonym pr_status_pedido
  for cmz_proy_admin.status_pedido;
