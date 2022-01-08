--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Función que carga un archivo txt al campo distribución en almacén

prompt Configurando directorio
conn sys/system as sysdba
create or replace directory fotos_dir as '/home/manuel/Desktop/bd/proyectoFinal/distribucionAlmacen';
grant read, write on directory fotos_dir to --USUARIO_ADMIN;

set serveroutput on
create or replace function distribucionAlmacen(
    p_almacen_id number,
    p_nombre_archivo varchar2
) return blob is 

v_bfile bfile;
v_src_offset number:=1;
v_dest_offset number:=1;
v_blob blob;
v_src_length number;
v_dest_length number;

begin 
     v_bfile:=bfilename('FOTOS_DIR',p_nombre_archivo);
    if dbms_lob.fileexists(v_bfile)=0 then
        raise_application_error(-20001,'El archivo '||p_nombre_archivo||' no existe.');
    end if;

    select distribucion into v_blob
    from almacen
    where almacen_id=p_almacen_id
    for update;

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
    if v_dest_length<>v_src_length then 
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' no se cargó correctamente');
    end if;
    end loop;
  return v_bfile;
end;
/
show errors
