--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Función que carga un archivo jpg al campo distribución en almacén

prompt Configurando directorio
connect sys/system as sysdba
create or replace directory planos_dir as '/tmp/proyecto/planos';
grant read, write on directory planos_dir to cmz_proy_admin;

prompt Creando procedimiento con usuario cmz_proy_admin
connect cmz_proy_admin/cmz
show user

Prompt creando el directorio /tmp/proyecto en caso de no existir
!mkdir -p /tmp/proyecto

Prompt moviendo la carpeta de imagenes a directorio
!cp -r planos /tmp/proyecto

set serveroutput on
create or replace procedure sp_inserta_plano
(p_almacen_id in number, p_nombre_archivo in varchar2) is

--Deckaración de variables para la carga del archivo
v_bfile bfile;
v_src_offset number;
v_dest_offset number;
v_blob blob;
v_src_length number;
v_dest_length number;

begin
dbms_output.put_line('Cargando plano '||p_nombre_archivo);

--Validando si el archivo existe y asignando el archivo externo a v_bfile
v_bfile:=bfilename('PLANOS_DIR',p_nombre_archivo);
if dbms_lob.fileexists(v_bfile)=0 then
	raise_application_error(-20001,'El archivo '||p_nombre_archivo||' no existe.');
end if;

--Verificando si el archivo está abierto
if dbms_lob.isopen(v_bfile)=1 then
	raise_application_error(-20001,'El archivo '||p_nombre_archivo||' está abierto. No se puede usar');
end if;

--abriendo archivo 
dbms_lob.open(v_bfile,dbms_lob.lob_readonly);

--Actualizando blob en la tabla
--Asegurarse que la tabla alamcen contenga datos y la columna distribucion debe tener un blob vacío.
--Asignar v_blob
select distribucion into v_blob
from almacen
where almacen_id=p_almacen_id
for update;

--Definición de bytes de inicio para la lectura
v_src_offset:=1;
v_dest_offset:=1;

--Carga de archivo con paquete dbms_lob
dbms_lob.loadblobfromfile(
	dest_lob      => v_blob,
	src_bfile     => v_bfile,
	amount        => dbms_lob.getlength(v_bfile),
	dest_offset   => v_dest_offset,
	src_offset    => v_src_offset
    );
    
--Cerrando archivo
dbms_lob.close(v_bfile);

--Validando carga
v_src_length:=dbms_lob.getlength(v_bfile);
v_dest_length:=dbms_lob.getlength(v_blob);
 
 --Corroborando si carga se realizó adecuadamente 
if v_dest_length<>v_src_length then 
	raise_application_error(-20001,'El archivo '||p_nombre_archivo||' no se cargó correctamente');
end if;
end;
/
show errors

