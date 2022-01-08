--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Creación de nueva orden 

create or replace procedure sp_nueva_orden 
(p_cliente_id in number, p_medicamento_presentacion in number,p_unidades_mp in number) is

v_sql_pedido varchar2(4000);
v_sql_detalle_pedido varchar2(4000);
v_sql_historico varchar2(4000);
v_pedido_seq number;
v_detalle_pedido_seq number;
v_historico_seq number;
v_folio varchar2(13);
v_farmacia_id number;

begin
select seq_pedido.nextval into v_pedido_seq from dual;
select seq_detalle_pedido.nextval into v_detalle_pedido_seq from dual;
select seq_historico_status.nextval into v_historico_seq from dual;
select folio_pedido(sysdate) into v_folio from dual;
select farmacia_id into v_farmacia_id from farmacia where gerente_id=floor(dbms_random.value(1,500));

v_sql_pedido:='insert into pedido (pedido_id,fecha_status,folio,repartidor_id,cliente_id,status_pedido_id)'
            ||'values (:ph_pedido_id,sysdate,:ph_folio,dbms_random.value(1,1000),:ph_cliente_id,1)';
execute immediate v_sql_pedido using v_pedido_seq,v_folio,p_cliente_id;

v_sql_detalle_pedido:='insert into detalle_pedido ( '
                    ||'detalle_pedido_id,unidades,farmacia_id,medicamento_presentacion_id,pedido_id)'
                    ||'values(:ph_detalle_pedido_id,:ph_unidades_mp_1,:ph_farmacia_id,:ph_medicamento_presentacion_1,:ph_pedido_id)';
execute immediate v_sql_detalle_pedido using v_detalle_pedido_seq,p_unidades_mp,v_farmacia_id, p_medicamento_presentacion,v_pedido_seq;

v_sql_historico:='insert into historico_status ( '
                ||'historico_status_id,fecha_status,pedido_id,status_pedido_id)'
                ||'values(:ph_historico_id,sysdate,:ph_pedido_id,1)';
execute immediate v_sql_historico using v_historico_seq,v_pedido_seq;
end;
/
show errors
