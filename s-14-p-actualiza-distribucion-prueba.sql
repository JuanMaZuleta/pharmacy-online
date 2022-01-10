--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Prueba del procedimiento que inserta una imagen en tabla almacen

set serveroutput on
declare 
v_tamanio number;

begin 
dbms_output.put_line('Insertando plano de distribucion en almacen');
sp_inserta_plano(502,'plano-190.jpg');

--Se comprueba que la longitud del campo blob distribucion es diferente de 0 
select dbms_lob.getlength(distribucion) into v_tamanio
from almacen 
where almacen_id=502;

--Se imprime en pantalla el tamaño de la imagen reci
dbms_output.put_line('El tamanio de la imagen del plano es: '|| v_tamanio||'.');
commit;
end;
/ 
show errors
