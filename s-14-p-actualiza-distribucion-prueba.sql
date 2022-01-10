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
select dbms_lob.getlength(distribucion) into v_tamanio
from almacen 
where almacen_id=502;

dbms_output.put_line('El tamanio de la imagen del plano es: '|| v_tamanio||'.');

end;
/ 
show errors
