--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Prueba tr-actual_unidades
Prompt ===================================
Prompt Prueba tr-empleado_despedido
Prompt Eliminando un registro de empleado
Prompt ===================================

declare
v_empleado_id number;
v_empleado_desp_id number;
v_registro_encontrado number;
v_usuario varchar2(20);
v_liquidacion number;
v_descripcion varchar2(2000);
v_sueldo_mensual number;

begin
--Se inserta un nuevo empleado
  insert into empleado (empleado_id, sueldo_mensual, celular, 
    nombre, ap_paterno, ap_materno, rfc, fecha_ingreso, centro_de_operacion_id) 
  values (seq_empleado.nextval, 10000, '5424528101', 'Diego', 'Martinez', 
    'Zuleta', 'CURSC507956HZ', sysdate, 1000);

--Se guarda el empleado_id a eliminar
  select seq_empleado.currval into v_empleado_id
  from dual;

--Se guarda el sueldo mensual del empleado
  select sueldo_mensual into v_sueldo_mensual 
  from empleado 
  where empleado_id = v_empleado_id;

--Se elimina el empleado creado
  delete from empleado
  where empleado_id = v_empleado_id;

--Se guarda el id del registro creado en la tabla empleado_despedido
  select empleado_desp_seq.currval into v_empleado_desp_id
  from dual;

--Se hace la consulta para ver si existe aun el empleado despedido
  select count(*) into v_registro_encontrado
  from empleado
  where empleado_id = v_empleado_id;
  if v_registro_encontrado = 0
--Si no se encuentra el registro 
  then
--Se guardan las variables con las que se compruba el funcionamiento del 
--trigger
    select usuario, descripcion, liquidacion into v_usuario, v_descripcion,
      v_liquidacion
    from empleado_despedido
    where empleado_despedido_id = v_empleado_desp_id; 
  
    if v_usuario <> 'CMZ_PROY_ADMIN' then
      raise_application_error(-20001,'El valor del campo usuario es incorrecto, 
      se obtuvo '
      ||v_usuario
      || ', se esperaba cmz_proy_admin');
    else
      dbms_output.put_line('valor para columna usuario correcta.');
    end if;
  
    if v_liquidacion <> '60000' then
      raise_application_error(-20001,'El valor del campo liquidacion 
      es incorrecto, se obtuvo '
      ||v_liquidacion
      || ', se esperaba 60000');
    else
      dbms_output.put_line('valor para columna liquidacion correcta.');
    end if;

    dbms_output.put_line('Valor para columna descripcion: ' 
    || v_descripcion);
  else
    raise_application_error(-20001,'El registro es incorrecto');
  end if;
  --si se llega a este punto quiere decir que todo está OK, 
  --se indica que la prueba fue exitosa.
  dbms_output.put_line('OK, prueba exitosa.');

end;
/

  set linesize window
  col descripcion format a30

  select * from empleado_despedido;
