--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Prueba del procedimiento que genera las inserciones 
              --para generar un nuevo pedido

set serveroutput on 
declare 
v_farmacia_id number;
v_unidades number;
v_medicamento_nombre varchar2(100);
v_detalle_pedido number;

begin
sp_nueva_orden(1,1,10);
commit;

select dp.unidades,mn.nombre,dp.farmacia_id,dp.detalle_pedido_id into v_unidades,v_medicamento_nombre,v_farmacia_id,v_detalle_pedido
from detalle_pedido dp
join medicamento_presentacion mp 
on dp.medicamento_presentacion_id=mp.medicamento_presentacion_id
join medicamento m
on mp.medicamento_id=m.medicamento_id
join medicamento_nombre mn
on m.medicamento_id=mn.medicamento_id
where dp.detalle_pedido_id=(select max(detalle_pedido_id) from detalle_pedido) 
and mn.medicamento_nombre_id=(
    select min(medicamento_nombre_id) 
    from medicamento_nombre mn
    join medicamento m
      on mn.medicamento_id=m.medicamento_id
    join medicamento_presentacion mp   
      on m.medicamento_id=mp.medicamento_id
    where mp.medicamento_presentacion_id=1);

dbms_output.put_line('Se realizó una nueva orden con id= '
                    ||v_detalle_pedido ||'.'
                    ||' Se compraron  '
                    ||v_unidades
                    || ' unidades del medicamento '
                    ||v_medicamento_nombre
                    ||' en la farmacia con id= '
                    ||v_farmacia_id);
commit;
end;
/ 
show errors
