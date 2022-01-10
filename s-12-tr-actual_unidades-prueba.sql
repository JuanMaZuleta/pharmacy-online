--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Prueba tr-actual_unidades

set serveroutput on

declare
v_unidades_actuales number;
v_unidades_pedido number;
v_unidades_actualizadas number;
v_medicamento_id number;
v_farmacia_id number;
v_pedido_id number;
v_detalle_pedido_id number;

begin

--Se asignan variables para definir el medicamento, farmacia y pedido  
  v_pedido_id := 560;
  v_medicamento_id := 400; 
  v_farmacia_id := 895;

--Se obtienen las unidades actuales del medicamento_id = 400 
-- en la farmacia 10
  select unidades into v_unidades_actuales
  from farmacia_medicamento_presentacion 
  where medicamento_presentacion_id = v_medicamento_id
    and farmacia_id = v_farmacia_id;

--Se muestran las unidades actuales
  dbms_output.put_line('Las unidades actuales del medicamento_presentacion: '
    ||v_medicamento_id
    ||' son: '
    ||v_unidades_actuales
    ||'.'
  );

 --Se muestra un error si la farmacia ya no tiene disponible unidades 
 --medicamento 

  if v_unidades_actuales = 0 then
    raise_application_error(-20001,'La farmacia: '
    || v_farmacia_id  
    || ', no cuenta con unidades disponibles.');
  end if;

  dbms_output.put_line('Insertando 10 unidades al detalle pedido.');

--Se insertan 10 unidades del medicamento_id = 400 al pedido
  insert into detalle_pedido (detalle_pedido_id, unidades, 
    farmacia_id, medicamento_presentacion_id, pedido_id) 
  values (seq_detalle_pedido.nextval, 10, v_farmacia_id, v_medicamento_id,
    560);
  
  v_unidades_pedido := 10;
  
--Se revisa nuevamente las unidades actuales en farmacia
  select unidades into v_unidades_actualizadas
  from farmacia_medicamento_presentacion 
  where medicamento_presentacion_id = v_medicamento_id
    and farmacia_id = v_farmacia_id;

--Se muestran las unidades actualizadas
  dbms_output.put_line('Las unidades' 
    ||' actualizadas del medicamento_presentacion: '
    ||v_medicamento_id
    ||' son: '
    ||v_unidades_actualizadas
    ||'.'
  );

--Se muestra error si no se actualiza o se termina si todo es correcto
  if v_unidades_actualizadas = v_unidades_actuales - v_unidades_pedido then
    dbms_output.put_line('Es correcta la actualización del ' 
      || 'medicamento en farmacia.');
  else
    raise_application_error(-20001,'Las unidades del medicamento: '
    || v_medicamento_id  
    || ', no se actualizaron correctamente en la farmacia: '
    || v_farmacia_id
    ||'.');
  end if; 
end;
/
show errors



