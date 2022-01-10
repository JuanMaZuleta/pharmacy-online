--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Prueba de función que crea una clave para cliente.

set serveroutput on
declare 
v_clave varchar2(20);
v_email varchar(50);

begin
select email into v_email
from cliente 
where cliente_id=1;

dbms_output.put_line('Se generara la clave al cliente con id=1 e email: '
										||v_email);

select clave_cliente(v_email) into v_clave from dual;

dbms_output.put_line('La clave para el cliente es: '
										||v_clave);
end;
/ 
show errors
