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

--Consulta para insertar parámetro email en la función
select email into v_email
from cliente 
where cliente_id=1;

--Se imprime la información del cliente al que se le generará una clave
dbms_output.put_line('Se generara la clave al cliente con id= 1 e email: '
		||v_email);

--Se aplica la función 
select clave_cliente(v_email) into v_clave from dual;

--Se imprime el valor de la clave generada 
dbms_output.put_line('La clave para el cliente es: '
		||v_clave);
commit;
end;
/ 
show errors
