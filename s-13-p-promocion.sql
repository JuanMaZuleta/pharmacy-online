--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Creación de nueva orden 

set serveroutput on
create or replace procedure sp_promocion 
(p_farmacia_id in number,p_unidades_regalo in number) is 

--Cursor para iterar sobre consulta
cursor cur_promocion is 
select dp.unidades,p.status_pedido_id,m.es_riesgo,dp.medicamento_presentacion_id
from detalle_pedido dp
join pedido p 
on dp.pedido_id=p.pedido_id
join medicamento_presentacion mp
on mp.medicamento_presentacion_id=dp.medicamento_presentacion_id
join medicamento m 
on mp.medicamento_id=m.medicamento_id;

--Variable para ejecutar sql dinámico
v_sql_promocion varchar2(4000);

--Variable para calcular unidades totales
v_undidades_regalo number;

begin
--Inicialización de cursor
for r in cur_promocion loop
--Verificación de límite arbitrario
	if p_unidades_regalo > 5 then 
		 raise_application_error(-20001,'La cantidad de medicamentos de regalo '
		 								||p_unidades_regalo
										||' es exesiva. Sólo se regalan entre 1 a 5 unidades. ');
	end if;

	v_undidades_regalo:=r.unidades + p_unidades_regalo;

--Actualización de registro en detalle pedido con nuevas unidades de regalo 
	if r.status_pedido_id=1 and r.es_riesgo=0 then
		v_sql_promocion:='update detalle_pedido'
					   ||' set unidades=:ph_unidades_regalo'
		    		 ||' where farmacia_id=:ph_farmacia_id and medicamento_presentacion_id=:ph_medicamento_presentacion_id';
		execute immediate v_sql_promocion using v_undidades_regalo,p_farmacia_id,r.medicamento_presentacion_id;
	end if;
end loop;
end;
/ 
show errors

