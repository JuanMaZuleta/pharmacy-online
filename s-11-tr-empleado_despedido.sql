--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Trigger para crear un respaldo al momento de despedir a un 
--              empleado

create or replace trigger tr_empleado_despedido
  after delete
  on empleado
  for each row

declare
  v_descripcion varchar2 (400);
  v_liquidacion number;

begin
--Se guarda en v_descripcion el usuario y datos del empleado despedido
  v_descripcion := 'El usuario ' 
    ||sys_context('USERENV', 'SESSION_USER')
    ||' ha eliminado los datos de un empleado con fecha '
    ||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')
    ||'. Datos del empleado eliminado: Empleado_id: '
    ||:old.empleado_id 
    ||', nombre: '
    ||:old.nombre 
    ||', Ap_paterno '
    ||:old.ap_paterno 
    ||', Rfc: '
    ||:old.rfc 
    ||', Centro de operacion: '
    ||:old.centro_de_operacion_id 
    ||', Sueldo mensual: '
    ||:old.sueldo_mensual; 
  
--Se declara la liquidacion del empleado
  v_liquidacion := :old.sueldo_mensual * 6;

--Se inserta un registro en empleado_despedido
  insert into empleado_despedido (empleado_despedido_id, fecha_evento, 
    usuario, descripcion, liquidacion)
  values (empleado_desp_seq.nextval, sysdate, 
    sys_context('USERENV', 'SESSION_USER'), v_descripcion, v_liquidacion);

end;
/
show errors
  