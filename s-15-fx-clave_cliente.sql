/*Función para construir una clave para cada cliente. 
Las claves estàn compuetas por el prefijo "CL-"seguido de las 2 primeras letras del CURP, 
seguido de las 2 últimas letras del apellido materno y por la primera letra del nombre.
La clave esta formada únicamente por caracteres en mayúsculas. 
Algunos clientes no cuentan con CURP. Si el CURP no existe, 
se haga uso de la cadena ‘00’.*/

create or replace function clave_cliente(
  p_email varchar2
) return varchar2 is
  --Declaracion de variables
  v_clave varchar2(20);
begin 
  select upper('CL-' 
    || nvl(substr(curp,1,2),'00')
    || substr(ap_materno,length(ap_materno)-1,2)
    || substr(nombre,1,1)
  ) clave
  into v_clave
  from cliente c
  where c.email =  p_email;
  return v_clave;
end;
/
show errors


