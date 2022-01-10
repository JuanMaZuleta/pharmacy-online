--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Bloque para validar el funcionamiento del trigger 
--              tr-operacion_riesgo
set serveroutput on
Prompt ===================================
Prompt Prueba tr-operacion_riesgo
Prompt Insertando una nuevo registro en medicamento_operacion con 
Prompt medicamento de riesgo y tipo salida.
Prompt ===================================

declare
v_operacion_riesgo_id number;
v_registro_encontrado number;
v_usuario varchar2(400);
v_descripcion varchar2(2000);
v_unidades number;

begin
  --Se inserta un registro en medicamento_operacion
  insert into medicamento_operacion (medicamento_operacion_id, unidades, 
    medicamento_presentacion_id, operacion_id) 
  values (medicamento_operacion_seq.nextval, 20, 4, 1000);

  --Se guarda el id del registro creado en la tabla operacion_riesgo
  select operacion_riesgo_seq.currval into v_operacion_riesgo_id
  from dual;

  --Se hace la consulta para ver si existe el registro en operacion_riesgo
  select count(*) into v_registro_encontrado
  from operacion_riesgo
  where operacion_riesgo_id = v_operacion_riesgo_id;
  if v_registro_encontrado = 1 
  --Si se encuentra el registro
  then
  --Se guardan las variables con las que se compruba el funcionamiento del 
  --trigger
    select usuario, descripcion, unidades into v_usuario, v_descripcion,
      v_unidades
    from operacion_riesgo
    where operacion_riesgo_id = v_operacion_riesgo_id; 
  
    if v_usuario <> 'CMZ_PROY_ADMIN' then
      raise_application_error(-20001,'El valor del campo usuario es incorrecto, 
      se obtuvo '
      ||v_usuario
      || ', se esperaba cmz_proy_admin');
    else
      dbms_output.put_line('valor para columna usuario correcta.');
    end if;
  
    if v_unidades <> '20' then
      raise_application_error(-20001,'El valor del campo unidades 
      es incorrecto, se obtuvo '
      ||v_unidades
      || ', se esperaba 20');
    else
      dbms_output.put_line('valor para columna unidades correcta.');
    end if;

    dbms_output.put_line('Valor para columna descripcion: ' 
    || v_descripcion);
  else
    raise_application_error(-20001,'El registro es incorrecto');
  end if;
  --si se llega a este punto quiere decir que todo está OK, 
  --se indica que la prueba fue exitosa.
  dbms_output.put_line('OK, prueba exitosa.');
  commit;
end;
/

Prompt ===================================
Prompt Prueba tr-operacion_riesgo
Prompt Actualizando las unidades en medicamento_operacion con 
Prompt medicamento de riesgo y tipo salida.
Prompt ===================================

declare

v_operacion_riesgo_id number;
v_registro_encontrado number;
v_usuario varchar2(400);
v_descripcion varchar2(2000);
v_unidades number;
v_med_oper_id number; 

begin
  --Se guarda el actual valor del id de la operacion anterior
  select medicamento_operacion_seq.currval into v_med_oper_id
  from dual;
 
  --Se actualizan las unidades de la anterior operacion
  update medicamento_operacion
  set unidades = 40
  where medicamento_operacion_id = v_med_oper_id;

  --Se guarda el id del registro creado en la tabla operacion_riesgo
  select operacion_riesgo_seq.currval into v_operacion_riesgo_id
  from dual;

  --Se hace la consulta para ver si existe el registro en operacion_riesgo
  select count(*) into v_registro_encontrado
  from operacion_riesgo
  where operacion_riesgo_id = v_operacion_riesgo_id;
  if v_registro_encontrado = 1 
  --Si se encuentra el registro
  then
  --Se guardan las variables con las que se compruba el funcionamiento del 
  --trigger
    select usuario, descripcion, unidades into v_usuario, v_descripcion,
      v_unidades
    from operacion_riesgo
    where operacion_riesgo_id = v_operacion_riesgo_id; 
  
    if v_usuario <> 'CMZ_PROY_ADMIN' then
      raise_application_error(-20001,'El valor del campo usuario es incorrecto, 
      se obtuvo '
      ||v_usuario
      || ', se esperaba cmz_proy_admin');
    else
      dbms_output.put_line('valor para columna usuario correcta.');
    end if;
  
    if v_unidades <> '40' then
      raise_application_error(-20001,'El valor del campo unidades 
      es incorrecto, se obtuvo '
      ||v_unidades
      || ', se esperaba 40');
    else
      dbms_output.put_line('valor para columna unidades correcta.');
    end if;

    dbms_output.put_line('Valor para columna descripcion: ' 
    || v_descripcion);
  else
    raise_application_error(-20001,'El registro es incorrecto');
  end if;
  --si se llega a este punto quiere decir que todo está OK, 
  --se indica que la prueba fue exitosa.
  dbms_output.put_line('OK, prueba exitosa.');
  commit;
end;
/
  set linesize window
  col descripcion format a30

  select * from operacion_riesgo;
