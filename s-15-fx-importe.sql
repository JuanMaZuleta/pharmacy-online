--Función para obtener el importe de un pedido
create or replace function importe(
  p_folio varchar2
) return number is
  --Declaracion de variables
  v_importe number(10,0);
begin 
  select sum(m.precio*dp.unidades)
  into v_importe
  from pedido p 
  join detalle_pedido dp 
    on p.pedido_id = dp.pedido_id
  join medicamento_presentacion mp 
    on mp.medicamento_presentacion_id = dp.medicamento_presentacion_id
  join medicamento m
    on m.medicamento_id = mp.medicamento_id
  where p.folio =  p_folio;
  return v_importe;
end;
/
show errors
