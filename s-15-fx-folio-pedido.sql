create or replace function folio_pedido(
  p_fecha_pedido date default sysdate
) return varchar2 is
  --Declaracion de variables
  v_folio varchar2(13);
begin 
  select upper('PO#' 
    || seq_pedido.nextval
    || to_char(p_fecha_pedido,'ddmmyy')
  ) folio
  into v_folio
  from dual;
  while length(v_folio)<13 loop
    v_folio:=v_folio||0;
  end loop;
  return v_folio;
end;
/
show errors
