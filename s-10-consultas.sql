/*2. Generar un reporte que muestre el numero de pedidos CAPTURADOS,
EN TRANSITO, ENTREDADOS, DEVUELTOS Y CANCELADOS.*/
select sp.descripcion status,count(*) cantidad
from pedido p
join status_pedido sp
  on p.status_pedido_id = sp.status_pedido_id
group by sp.descripcion;

--Mostrar un reporte de los cliente. Los datos del reporte son:
--* Nombre,apellidos y telefono del cliente
--*De existir, los datos de la tarjeta
select c.nombre, c.ap_materno, c.ap_paterno,c.telefono, t.numero numero_tarjeta, 
  t.anio_expiracion, t.mes 
from cliente c,tarjeta t
where c.tarjeta_id = t.tarjeta_id(+);

--Para cada cliente mostrar su compra màxima y mìnima
select c.cliente_id,c.nombre,min(importe(p.folio)) compra_minima,
  max(importe(p.folio)) compra_maxima
from cliente c,pedido p,historico_status hs,status_pedido sp
where c.cliente_id = p.cliente_id and
  p.pedido_id = hs.pedido_id and
  sp.status_pedido_id = hs.status_pedido_id and 
  sp.descripcion = 'ENTREGADO'
group by c.cliente_id, c.nombre
order by cliente_id;
  

/*
Generar una sentencia SQL que muestre el identificador del cliente, 
su nombre, sus apellidos, el folio de sus pedidos, nombre y apellidos de 
los responsables del pedido, el identificador del centro de operacion y su 
direccion, asì como el nombre de la oficina.*/

select cliente_id, c.nombre nombre_cliente, c.ap_paterno, c.ap_materno,
  p.folio folio_pedido, e.nombre nombre_responsable, e.ap_paterno, e.ap_materno,
  centro_de_operacion_id, co.direccion
from cliente c
natural join pedido p
join empleado e
  on e.empleado_id = p.repartidor_id
join centro_de_operacion co using(centro_de_operacion_id)
order by cliente_id;


/*2. Mostrar el total de pedidos que fueron devueltos en el año
del 2013*/
select (
  select count(*)
  from pedido p
  join historico_status hs
    on p.pedido_id = hs.pedido_id
  join status_pedido sp
    on sp.status_pedido_id =  hs.status_pedido_id
  where to_char(hs.fecha_status,'YYYY')='2013'
  and sp.descripcion = 'DEVUELTO'
     ) num_pedidos_devueltos
from dual;



/*7. Generar un reporte de todos los clientes que cumplan con 
alguna de las siguientes condiciones:
a. Que el cliente haya realizado mas de 3 pedidos 
b. Que el monto total de todos pedidos supere a los $550,000.*/
select c.cliente_id,c.nombre,c.ap_paterno,c.ap_materno,
  count (*) num_pedidos, sum(importe(p.folio)) compra
from cliente c 
join pedido p
  on c.cliente_id=p.cliente_id
group by (c.cliente_id,c.nombre,c.ap_paterno,c.ap_materno)
having count(*) > 3
union
select c.cliente_id,c.nombre,c.ap_paterno,c.ap_materno,
  count (*) num_pedidos, sum(importe(p.folio)) compra
from cliente c 
join pedido p
  on c.cliente_id=p.cliente_id
group by (c.cliente_id,c.nombre,c.ap_paterno,c.ap_materno)
having sum(importe(p.folio)) > 550000;

/*
Generar una consulta que determine la perdida màxima y mìnima generada por los
pedidos cancelados o devueltos*/
select 
  min(perdida) perdida_minima, 
  max(perdida) perdida_maxima
from (select v_perdidas.farmacia_id,sum(v_perdidas.importe_total) perdida
  from v_perdidas
  group by (v_perdidas.farmacia_id));

----PENDIENTES

  
/*1. Seleccionar el número total de pedidos cancelados realizados en el 2015, 
así como el total de ingresos perdidos del mismo año.*/
--create table consulta_1 as
select (
  select count(*)
  from pedido p
  join historico_status hs
    on p.pedido_id = hs.pedido_id
  join status_pedido sp
    on hs.status_pedido_id=sp.status_pedido_id
  where sp.descripcion = 'CANCELADO' and
  to_char(hs.fecha_status,'YYYY')='2015'
  ) num_pedidos,
(
  select sum(sv.precio_venta)
  from subasta s
  join articulo a
    on s.subasta_id = a.subasta_id
  join subasta_venta sv
    on a.articulo_id =  sv.articulo_id
  where to_char(s.fecha_inicio,'YYYY')='2010'
) ingresos
from dual;
select * from pedido;



--Seleccionar al cliente que ha realizado mas pedidos 
select * 
from cliente 
where cliente_id = (
  select 

)
select c.cliente_id,c.nombre, count(*) num_pedidos
from cliente c
join pedido p
 on c.cliente_id = p.cliente_id
group by (c.cliente_id, c.nombre)
order by c.cliente_id;



--Generar un reporte que contenga de la cantidad de medicamentos de regiesgo
--entregados 





/*1. Seleccionar los pedidos que tienen el status de cancelado
y mostrar como el detalle de dichos pedidos.*/



/*2. Generar un reporte que muestre el nombre, presentacion y precio de 
los medicamentos comprados por el usuario #########.*/


/*3.Seleccionar el total de los ingresos obtenidos del año 2020*/


/*4.Generar un reporte que muestre el id y nombre de los empleados que son responsables 
de los pedidos que tienen el stutas de cancelado, así como el detalle de cada uno de 
los pedidos.



