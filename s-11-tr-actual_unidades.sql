--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Trigger para actualizar las unidades en la farmacia
--              cuando existe un pedido

create or replace trigger tr_actual_unidades
  after insert
  on detalle_pedido
  for each row

declare
  v_uni_existentes number;
  v_uni_actuales number ;

begin

  select unidades into v_uni_existentes
  from farmacia_medicamento_presentacion
  where medicamento_presentacion_id = :new.medicamento_presentacion_id
    and farmacia_id = :new.farmacia_id;
  
  v_uni_actuales := v_uni_existentes - :new.unidades;

  update farmacia_medicamento_presentacion
  set unidades = v_uni_actuales
  where medicamento_presentacion_id = :new.medicamento_presentacion_id
    and farmacia_id = :new.farmacia_id;

end;
/
show errors
  
      
  
