--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: procedimiento que realiza un ajuste de precio del medicamento

create or replace procedure sp_ajuste_precio (
  p_porcentaje in number,p_precio_referencia in number, p_tipo_cambio in char(1)
) is

v_sql varchar2 (4000);
v_new_precio number;

cursor cur_datos_medicamento is 
select precio, medicamento_presentacion_id
from medicamento_presentacion;

begin 
for p in cur_datos_medicamento loop
  case 
    when p_tipo_cambio='a' then
      if p.precio < p_precio_referencia then
        v_new_precio:=p.precio + (p.precio*(p_porcentaje/100))
        v_sql:='update medicamento_presentacion'
             ||'set precio=:ph_new_precio'
             ||'where medicamento_presentacion_id=ph:medicamento_presentacion_id';
        execute immediate v_sql using v_new_precio,p.medicamento_presentacion_id;
      end if;
    
    when p_tipo_cambio='d' then 
      if p.precio < p_precio_referencia then
        v_new_precio:=p.precio - (p.precio*(p_porcentaje/100))
        v_sql:='update medicamento_presentacion'
             ||'set precio=:ph_new_precio'
             ||'where medicamento_presentacion_id=ph:medicamento_presentaicion_id';
        execute immediate v_sql using v_new_precio,p.medicamento_presentacion_id;
      end if;
end loop;
end;
/
show errors
