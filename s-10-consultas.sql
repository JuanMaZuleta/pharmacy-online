--1.Generar un reporte que muestre el numero de pedidos CAPTURADOS,
--EN TRANSITO, ENTREDADOS, DEVUELTOS Y CANCELADOS.
create table consulta_1 as
select sp.descripcion status,count(*) cantidad
from pedido p
join status_pedido sp
  on p.status_pedido_id = sp.status_pedido_id
group by sp.descripcion;

--2.Generar un reporte que muestre los datos de las demandas existentes, el rfc
--fiscal de la farmacia y el nombre del gerente*
create table consulta_2 as
select d.*,f.rfc_fiscal, e.nombre gerente, e.rfc
from demandas_ext d,farmacia f, empleado e
where d.farmacia_id = f.farmacia_id and
e.empleado_id = f.gerente_id;

--3.Generar un reporte que muestre los siguientes datos:
--*Nombre,apellidos y telefono del cliente
--*De existir, los datos de la tarjeta de pago
create table consulta_3 as
select c.nombre, c.ap_materno, c.ap_paterno,c.telefono, t.numero numero_tarjeta, 
  t.anio_expiracion, t.mes 
from comprador c,tarjeta_de_pago t
where c.tarjeta_id = t.tarjeta_id(+);

--4.Para cada cliente mostrar su compra màxima y mìnima
create table consulta_4 as
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
5.Generar una sentencia SQL que muestre el identificador del cliente, 
su nombre, sus apellidos, el folio de sus pedidos, nombre y apellidos de 
los responsables del pedido, el identificador del centro de operacion y su 
direccion, asì como el nombre de la oficina.*/
create table consulta_5 as
select cliente_id, c.nombre nombre_cliente, c.ap_paterno, c.ap_materno,
  p.folio folio_pedido, e.nombre nombre_responsable, 
  e.ap_paterno ap_paterno_responsable, e.ap_materno ap_materno_responsable,
  centro_de_operacion_id, co.direccion direccion_centro_de_operacion
from cliente c
natural join pedido p
join empleado e
  on e.empleado_id = p.repartidor_id
join centro_de_operacion co using(centro_de_operacion_id)
order by cliente_id;

--6.Mostrar el total de pedidos que fueron devueltos en el año del 2013
create table consulta_6 as
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

/*7.Generar un reporte de todos los clientes que cumplan con 
alguna de las siguientes condiciones:
a. Que el cliente haya realizado mas de 3 pedidos 
b. Que el monto total de todos pedidos supere a los $550,000.*/
create table consulta_7 as
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
8.Generar una consulta que determine la perdida màxima y mìnima generada por los
pedidos cancelados o devueltos*/
create table consulta_8 as
select 
  min(perdida) perdida_minima, 
  max(perdida) perdida_maxima
from (select v_pedidos_cancelados_devueltos.farmacia_id,
        sum(v_pedidos_cancelados_devueltos.importe_total) perdida
      from v_pedidos_cancelados_devueltos
      group by (v_pedidos_cancelados_devueltos.farmacia_id));
