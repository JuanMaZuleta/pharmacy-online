--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Prueba del procedimiento que aplica una promocion 

set serveroutput on 
declare 
v_unidades_previas number;
v_unidades_nuevas number;
v_farmacia_id number;
v_medicamento_nombre varchar2(100);
v_detalle_pedido number;

begin
select dp.unidades, dp.farmacia_id, mn.nombre, dp.detalle_pedido_id 
into v_unidades_previas,v_farmacia_id,v_medicamento_nombre,v_detalle_pedido
from detalle_pedido dp
join medicamento_presentacion mp 
on dp.medicamento_presentacion_id=mp.medicamento_presentacion_id
join medicamento m
on mp.medicamento_id=m.medicamento_id
join medicamento_nombre mn
on m.medicamento_id=mn.medicamento_id
where dp.medicamento_presentacion_id=387
and dp.farmacia_id=1 
and mn.medicamento_nombre_id=887;

dbms_output.put_line('Se aplico la promocion al pedido con id='
										||v_detalle_pedido
										|| ' en la farmacia con id= '
                    ||v_farmacia_id
                    ||' al medicamento '
                    ||v_medicamento_nombre
                    ||' que tenía '
                    ||v_unidades_previas);
 
sp_promocion(1,5);
commit;

select dp.unidades 
into v_unidades_nuevas
from detalle_pedido dp
join medicamento_presentacion mp 
	on dp.medicamento_presentacion_id=mp.medicamento_presentacion_id
join medicamento m
	on mp.medicamento_id=m.medicamento_id
join medicamento_nombre mn
	on m.medicamento_id=mn.medicamento_id
where dp.medicamento_presentacion_id=387 and dp.farmacia_id=1 and mn.medicamento_nombre_id=887;

dbms_output.put_line('Ahora se tienen '||v_unidades_nuevas||' en total.');
commit;
end;
/
show errors
