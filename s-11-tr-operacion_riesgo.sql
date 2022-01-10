--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Trigger para registrar una operacion de salida con un  
--              medicamento de riesgo

create or replace trigger tr_operacion_riesgo
  for insert or
  update of unidades on medicamento_operacion
  compound trigger

  v_unidades number;
  v_tipo_medica number;
  v_medicamento_id number;
  v_operacion_id number; 
  v_tipo_oper char(1);

--Antes de la insercion o la actualización
--Se guardan las variables operacion_id, tipo de operacion, medicamento,
--si es de riesgo el medicamento 
  before each row is 
  v_med_pres_id number;

  begin
    case
      when inserting then
        select tipo into v_tipo_oper
        from operacion
        where operacion_id = :new.operacion_id;

        select medicamento_id into v_medicamento_id
        from medicamento_presentacion 
        where medicamento_presentacion_id = :new.medicamento_presentacion_id;

        select es_riesgo into v_tipo_medica
        from medicamento 
        where medicamento_id = v_medicamento_id;

        v_operacion_id := :new.operacion_id;
        v_unidades := :new.unidades;

      when updating ('unidades') then
        select tipo into v_tipo_oper
        from operacion
        where operacion_id = :old.operacion_id;

        select medicamento_id into v_medicamento_id
        from medicamento_presentacion 
        where medicamento_presentacion_id = :old.medicamento_presentacion_id;

        select es_riesgo into v_tipo_medica
        from medicamento 
        where medicamento_id = v_medicamento_id;

        v_operacion_id := :old.operacion_id;
        v_unidades := :new.unidades;
      end case;
  end before each row;

  after statement is
  v_descripcion varchar2 (400);
--Despues de la insercion o actualización
--Se verifica si es de riesgo y salida 
--, si se cumple entonces se guarda un registro en la tabla
--operacion_riesgo.
  begin
    if v_tipo_medica = 1 and v_tipo_oper = 'S' then
      v_descripcion := 'El usuario '
      ||sys_context('USERENV', 'SESSION_USER')
      ||' ha insertado los datos de una operacion con fecha '
      ||to_char(sysdate,'dd/mm/yyyy hh24:mi:ss')
      ||'. La operacion: '
      ||v_operacion_id
      ||' contiene el medicamento: '
      ||v_medicamento_id
      ||' catalogado como riesgoso.';

      insert into operacion_riesgo (operacion_riesgo_id, fecha_evento, 
        usuario, descripcion, unidades)
      values (operacion_riesgo_seq.nextval, sysdate, 
        sys_context('USERENV', 'SESSION_USER'), v_descripcion, v_unidades);             
    end if;
  end after statement;
end;
/
show errors