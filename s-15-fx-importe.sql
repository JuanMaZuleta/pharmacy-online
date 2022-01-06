--Función para obtener el importe de un pedido
create or replace function importe(
  p_folio number
) return number is
  --Declaracion de variables
  v_importe pedido.importe%type;
begin 
  select sum(m.precio)
  into v_importe
  from pedido p 
  join detalle_pedido dp 
    on p.pedido_id = dp.pedido_id
  join medicamento_presentacion mp 
    on mp.medicamento_presentacion_id = dp.detalle_pedido
  join medicamento
    on m.medicamento_id = mp.medicamento_presentacion
  where p.folio =  p_folio;
  return v_importe;
end;
/
show errors