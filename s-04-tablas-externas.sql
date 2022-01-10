--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 03/01/2022
--@Descripción: creación de tabla externa

--Se requiere del usuario SYS para crear un objeto tipo
--directory y otorgar privilegios.
prompt Conectando como sys
connect sys/system as sysdba
show user

set serveroutput on
declare
  v_count_dir number(1,0);
begin
  select count(*) into v_count_dir
  from dba_directories
  where directory_name='TMP_DIR';
  if v_count_dir > 0 then
    execute immediate 'drop directory tmp_dir';
    dbms_output.put_line('Directorio eliminado');
  else
    dbms_output.put_line('El directorio tmp_dir no existe. No se puede eliminar');
  end if;
end;
/
--Un objeto tipo directory es un objeto que se crea y almacena en el
-- diccionario de datos y se emplea para mapear directorios
-- reales en el sistema de archivos. En este caso tmp_dir es un
-- objeto que apunta al directorio /tmp/bases del servidor
prompt creando directorio tmp_dir
create or replace directory tmp_dir as '/tmp/demandas';

--se otorgan permisos para que el usuario jorge0507 de la BD pueda leer
--el contenido del directorio
grant read, write on directory tmp_dir to cmz_proy_admin;
prompt Contectando con usuario admin para crear la tabla externa
connect cmz_proy_admin/cmz
show user

set serveroutput on
declare 
v_count_tabla number(1,0);
begin 
  select count(*) into v_count_tabla
  from user_tables
  where table_name='DEMANDAS_EXT';
  if v_count_tabla > 0 then
    execute immediate 'drop table demandas_ext';
    dbms_output.put_line('Tabla eliminada');  
  end if;
end;
/

prompt creando tabla externa
create table demandas_ext (
demanda_id number(10, 0),
farmacia_id number(10,0),
descripcion varchar2(40),
estado varchar2(40),
multa number(10),
fecha_inicio date,
fecha_fin date
)
organization external (
--En oracle existen 2 tipos de drivers para parsear el archivo:
-- oracle_loader y oracle_datapump
type oracle_loader
default directory tmp_dir
access parameters (
records delimited by newline
badfile tmp_dir:'demandas_ext_bad.log'
logfile tmp_dir:'demandas_ext.log'
fields terminated by ','
lrtrim
missing field values are null
(
demanda_id, farmacia_id, descripcion, estado, multa,
fecha_inicio date mask "dd/mm/yyyy", fecha_fin date mask "dd/mm/yyyy"
)
)
location ('demandas_ext.csv')
)
reject limit unlimited;
--En esta instrucción se crea el directorio /tmp/bases para

prompt creando el directorio /tmp/demandas en caso de no existir
!mkdir -p /tmp/demandas
--copiar el archivo csv
prompt copiando el archivo csv a /tmp/demandas
!cp demandas_ext.csv /tmp/demandas
--Otorgando permisos
!chmod 777 /tmp/demandas

/*
prompt mostrando los datos
set linesize window
col descripcion format a20
col estado format a20

select * from demandas_ext;*/
