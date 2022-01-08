--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 03/01/2022
--@Descripción: Creaciòn de usuarios y roles

--Conectando como usuario sys 
connect sys as sysdba/system

--Creación de roles. 
prompt creando roles

create role rol_admin;
grant create session, create table, create view, create procedure, 
create sequence, create synonym, create public synonym, create trigger to rol_admin;

create role rol_invitado;
grant create session, create synonym to rol_invitado;

--Crear usuarios
prompt creando usuarios

create user cmz_proy_admin identified by cmz quota unlimited on users;
grant rol_admin to cmz_proy_admin;

create user cmz_proy_invitado identified by cmz;
grant rol_invitado to cmz_proy_invitado;



