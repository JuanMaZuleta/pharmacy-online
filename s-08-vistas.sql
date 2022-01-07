--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Vistas para el caso de estudio "Pharmacy Online"


--COMENTAR VISTA
--Vista para mostrar resumen de la información de un pedido 
create or replace view v_pedido_completado as 
select c.nombre,c.ap_paterno,f.farmacia_id,co.direccion ubicacion_farmacia,
 dp.unidades, mn.nombre,pre.cantidad,m.precio, p.folio folio_compra,p.importe
from cliente c 
join pedido 
on c.cliente_id=p.cliente_id
join detalle_pedido dp 
on p.pedido_id=dp.pedido_id
join farmacia f 
on dp.farmacia_id=f.farmacia_id
join centro_de_operacion co. 
on f.farmacia_id=co.centro_de_operacion_id
join medicamento_presentacion mp 
on dp.medicamento_presentacion_id=mp.medicamento_presentacion_id
join medicamento m 
on mp.medicamento_id=m.medicamento_id
join medicamento_nombre mn 
on m.medicamento_id=mn.medicamento_nombre_id
left join presentacion pre 
on mp.presentacion_id=pre,presentacion_id
where p.status_pedido_id=(
  select status_pedido_id from status_pedido where clave='ENTREGADO'
);


--Vista para mostrar el resumen de la informacion de los pedidos cancelados
create or replace view v_pedidos_cancelados as 
select c.cliente_id,c.nombre cliente,c.ap_paterno,p.folio folio_compra,
  mn.nombre medicamento,pre.cantidad presentacion,dp.unidades,m.precio, 
  importe (p.folio) importe_total,f.farmacia_id,co.direccion ubicacion_farmacia
from cliente c 
join pedido p
  on c.cliente_id=p.cliente_id
join status_pedido sp
  on sp.status_pedido_id = p.status_pedido_id
join detalle_pedido dp 
  on p.pedido_id=dp.pedido_id
join farmacia f 
  on dp.farmacia_id=f.farmacia_id
join centro_de_operacion co 
  on f.farmacia_id=co.centro_de_operacion_id
join medicamento_presentacion mp 
  on dp.medicamento_presentacion_id=mp.medicamento_presentacion_id
join medicamento m 
  on mp.medicamento_id=m.medicamento_id
join medicamento_nombre mn 
  on m.medicamento_id=mn.medicamento_nombre_id
join presentacion pre 
  on mp.presentacion_id=pre.presentacion_id
where sp.descripcion = 'CANCELADO'
order by cliente_id asc;







--Vista para mostrar los medicamentos en sus diferentes presentaciones y nombres
create or replace view v_medicamento_presentacion as
select m.medicamento_id,mn.nombre,p.cantidad presentacion,m.precio,
  m.sustancia_activa,m.descripcion
from medicamento m 
join medicamento_nombre mn 
  on m.medicamento_id=mn.medicamento_id
join medicamento_presentacion mp 
  on m.medicamento_id=mp.medicamento_id
join presentacion p                       --comentar left join
  on mp.presentacion_id=p.presentacion_id;

--Vista para revisión de historico del estatus de los pedidos
create or replace view v_historico_pedido as 
select p.folio, p.importe, s.clave,h.fecha_status
from pedido p
join historico_status h
on p.pedido_id=h.pedido_id
left join status_pedido s
on h.status_pedido_id=s.status_pedido_id;
