--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Creaciòn de usuarios y roles

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

--Creación de roles. 
prompt creando roles

create role rol_admin;
grant create session, create table, create view,create procedure, 
create sequence to rol_admin;

create role rol_invitado;
grant create session to rol_invitado;

--Crear usuarios
prompt creando usuarios

create user cmz_proy_admin identified by cmz quota unlimited on users;
grant rol_admin to cmz_proy_admin;

create user cmz_proy_invitado identified by cmz;
grant rol_invitado to cmz_proy_invitado;


prompt conectando como cmz_proy_admin
connect cmz_proy_admin/cmz

prompt ejecuciòn de s-02


prompt ejecuciòn de s-03-carga-inicial.sql

Prompt Listo!
