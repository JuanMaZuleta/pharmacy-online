--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 04/01/2022
--@Descripción: Creaciòn de secuencias

create sequence seq_empleado 
start with 1
increment by 3
nomaxvalue
nominvalue
nocycle
cache 6;

create sequence seq_ubicacion
start with 1
increment by 3
nomaxvalue
nominvalue
nocycle
cache 6;

create sequence seq_pedido
start with 1
increment by 3
nomaxvalue
nominvalue
nocycle
cache 6;

create sequence seq_tarjeta
start with 1
increment by 3
nomaxvalue
nominvalue
nocycle
cache 6;

create sequence seq_cliente
start with 1
increment by 3
nomaxvalue
nominvalue
nocycle
cache 6;

create sequence seq_status_pedido
start with 1
increment by 1
maxvalue 10
minvalue 1
nocycle;

create sequence seq_historico_status
start with 1
increment by 1
maxvalue 50
minvalue 1
nocycle;

create sequence seq_detalle_pedido
start with 1
increment by 3
nomaxvalue
nominvalue
nocycle
cache 6;
