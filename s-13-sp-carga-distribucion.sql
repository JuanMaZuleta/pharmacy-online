prompt Configurando directorio
conn sys/system as sysdba
create or replace directory fotos_dir as '/home/manuel/Desktop/bd/proyectoFinal/distribucionAlmacen';
grant read, write on directory fotos_dir to --USUARIO_ADMIN;

prompt Creando procedimiento con usuario USUARIO_ADMIN
conn --USUARIO_ADMIN
set serveroutput on
create or replace procedure sp_distribucion_almacen
(p_almacen_inicial_id in number, p_almacen_final_id in number) is

v_bfile bfile;
v_src_offset number;
v_dest_offset number;
v_blob blob;
v_src_length number;
v_dest_length number;
v_nombre_archivo varchar2(50);
v_almacen number;

begin
    for v_index in p_almacen_inicial_id..p_almacen_inicial_id+p_almacen_final_id loop
    v_nombre_archivo:='almacen-'||v_index||'.txt';
    dbms_output.put_line('Cargando foto para '||v_nombre_archivo);
    --Validando si el archivo existe
    v_bfile:=bfilename('FOTOS_DIR',v_nombre_archivo);
    if dbms_lob.fileexists(v_bfile)=0 then
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' no existe.');
    end if;
    --Validando que es el archivo que le corresponde al almacen
    select almacen_id into v_almacen
    from almacen
    where almacen_id=v_index
    if v_almacen<> v_index then
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' no corresponde al almacen '||v_almacen'.');
    end if;
    --abrir archivo
    if dbms_lob.isopen(v_bfile)=1 then
        raise_application_error(-20001,'El archivo '||v_nombre_archivo||' está abierto. No se puede usar');
    end if;
    --abriendo archivo 
    dbms_lob.open(v_bfile,dbms_lob.lob_readonly);
    --Actualizando blob en la tabla
    --Asegurarse que la tabla auto contenga datos y la columna foto debe tener un blob vacío.
    --Asignar v_blob
    select foto into v_blob
    from auto
    where almacen_id=v_index 
    for update;
    --Escribiendo bytes
    v_src_offset:=1;
    v_dest_offset:=1;
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
end;
/
show errors


