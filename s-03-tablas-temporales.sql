--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 03/01/2022
--@Descripción: Creación de tablas temporales

create global temporary table centro_de_operacion_total(
    select * from centro_de_operacion co
    left join farmacia f
     on f.farmacia_id=co.centro_de_operacion_id
    left join almacen a 
    on a.almacen_id=co.centro_de_operacion_id
    left join oficina o 
    on o.oficina_id=co.centro_de_operacion_id
) on commit preserve rows;

create private temporary table ora$ptt_presentacion_disponible_medicamento(
    select *.m,*.p,mn.nombre medicamento_nombre mn
    join medicamento m 
    on mn.medicamento_id=m.medicamento_id 
    join medicamento_presentacion mp
    on mp.medicamento_id=m.medicamento_id
    left join presentacion p
    on p.presentacion_id=mp.presentacion_id
) on commit drop definition;
