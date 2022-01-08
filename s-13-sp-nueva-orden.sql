--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Creación de nueva orden 

create or replace procedure sp_nueva_orden (
  p_cliente_id in number, p_medicamento_presentacion_1 in number,p_unidades_mp_1 in number,
  p_medicamento_presentacion_2 in number default null,p_unidades_mp_2 in number default null,
  p_medicamento_presentacion_3 in number default null,p_unidades_mp_3 in number default null,
  p_medicamento_presentacion_4 in number default null,p_unidades_mp_4 in number default null,
  p_medicamento_presentacion_5 in number default null,p_unidades_mp_5 in number default null
) is

v_sql_pedido varchar2(4000);
v_sql_detalle_pedido varchar2(4000);
v_sql_historico varchar2(4000);
v_medicamento_presentacion varchar2;
v_pedido_seq number;
v_detalle_pedido_seq number;
v_historico_seq number;

begin
for m in 1..5 loop
  if p_medicamento_presentacion_.m  not null then
    select seq_pedido.nextval into v_pedido_seq from dual;
    select seq_detalle_pedido.nextval into v_detalle_pedido_seq from dual;
    select seq_historico_status.nextval into v_historico_seq from dual;

    v_sql_pedido:='insert into pedido (pedido_id,fecha_status,folio,repartidor_id,cliente_id,status_pedido_id)'
                ||'values (:ph_pedido_id,sysdate,folio_pedido(:ph_pedido_id),dbms_random.value(1,1000),:ph_cliente_id,1)';
    execute immediate v_sql_pedido using v_pedido_seq,p_cliente_id;

    v_sql_detalle_pedido:='insert into detalle_pedido ( '
                        ||'detalle_pedido_id,unidades,farmacia_id,medicamento_presentacion_id,pedido_id)'
                        ||'values(:ph_detalle_pedido_id,:ph_unidades_mp_1,dbms_random.value(1,500),:ph_medicamento_presentacion_1,:ph_pedido_id)';
    execute immediate v_sql_detalle_pedido using v_detalle_pedido_seq,p_unidades_mp_.m,p_medicamento_presentacion_.m,v_pedido_seq;

    v_sql_historico:='insert into historico_status ( '
                    ||'historico_status_id,fecha_status,pedido_id,status_pedido_id)'
                    ||'values(:ph_historico_id,sysdate,:ph_pedido_id,1)';
    execute immediate v_sql_historico using v_historico_seq,v_pedido_seq;
  end if;
end loop;
end;
/
show errors
