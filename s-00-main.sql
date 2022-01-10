--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 04/01/2022
--@Descripción: Invocaciòn de scripts
--Conectando como usuario sys 
connect sys/system as sysdba

set serveroutput on
declare
  v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where username ='CMZ_PROY_ADMIN';
  if v_count > 0 then
    execute immediate 'drop user CMZ_PROY_ADMIN cascade';
    dbms_output.put_line('Usuario CMZ_PROY_ADMIN eliminado');
  else
    dbms_output.put_line('El usuario CMZ_PROY_ADMIN no existe, no se requiere eliminar');
  end if;
end;
/

set serveroutput on
declare 
  v_count number(1,0);
begin
  select count(*) into v_count
  from dba_users
  where username ='CMZ_PROY_INVITADO';
  if v_count > 0 then
    execute immediate 'drop user CMZ_PROY_INVITADO cascade';
    dbms_output.put_line('Usuario CMZ_PROY_INVITADO eliminado');
  else
    dbms_output.put_line('El usuario CMZ_PROY_INVITADO no existe, no se requiere eliminar');
end if;
end;
/

prompt ejecuciòn de s-01-usuarios.sql
@s-01-usuarios.sql

prompt conectando como cmz_proy_admin
connect cmz_proy_admin/cmz

prompt ejecuciòn de s-02-entidades.sql
@s-02-entidades.sql

prompt ejecucion de s-03-tablas-temporales.sql
@s-03-tablas-temporales.sql

prompt ejecucion de s-04-tablas-externas.sql
@s-04-tablas-externas.sql

prompt ejecuciòn de s-05-secuencias.sql
@s-05-secuencias.sql

prompt ejecucion de s-06-indices.sql
@s-06-indices.sql

prompt ejecucion de s-07-sinonimos.sql
@s-07-sinonimos.sql

prompt ejecucion de s-15-fx-importe.sql
@s-15-fx-importe.sql

prompt ejecucion s-15-fx-clave_cliente.sql
@s-15-fx-clave_cliente.sql

prompt ejecucion s-15-fx-folio-pedido.sql
@s-15-fx-folio-pedido.sql

prompt ejecucion de s-08-vistas.sql
@s-08-vistas.sql

prompt ejecuciòn de carga-inicial
@s-09-carga-inicial.sql

prompt ejecucion de s-10-consultas.sql
@s-10-consultas.sql

prompt pruebas de procemdimientos 
prompt p-nueva-orden
@s-13-p-nueva-orden.sql

prompt p-promocion
@s-13-p-promocion.sql

prompt p-actualiza-distribucion
@s-13-p-actualiza-distribucion.sql

Prompt Listo!
