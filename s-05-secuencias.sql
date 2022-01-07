--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 04/01/2022
--@Descripción: Creaciòn de secuencias

create sequence seq_empleado 
start with 1001
nocycle
cache 20;

create sequence seq_ubicacion
start with 1001
nocycle
cache 20;

create sequence seq_pedido
start with 1
nocycle
cache 20;

create sequence seq_tarjeta
start with 801
nocycle
cache 20;

create sequence seq_cliente
start with 1001
nocycle
cache 20;

create sequence seq_historico_status
start with 1
nocycle
cache 20;

create sequence seq_detalle_pedido
start with 1001
nocycle
cache 6;

create sequence centro_de_operacion_seq
start with 1001
cache 20
nocycle;

create sequence medicamento_presentacion_seq
start with 1
cache 20
nocycle;

create sequence medicamento_seq
start with 1
increment by 1
cache 20
nocycle;

create sequence presentacion_seq
start with 11
cache 20
nocycle;

create sequence medicamento_nombre_seq
start with 1001
cache 20
nocycle;

create sequence operacion_seq
start with 1001
cache 20
nocycle;

create sequence medicamento_operacion_seq
start with 1001
cache 20
nocycle;
