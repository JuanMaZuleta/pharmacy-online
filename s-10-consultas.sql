/*2. Generar un reporte que muestre el numero de pedidos CAPTURADOS,
EN TRANSITO, ENTREDADOS, DEVUELTOS Y CANCELADOS.*/
select sp.descripcion status,count(*) cantidad
from pedido p
join status_pedido sp
  on p.status_pedido_id = sp.status_pedido_id
group by sp.descripcion;


/*2. Generar un reporte que muestre el numero de pedidos CAPTURADOS,
EN TRANSITO, ENTREDADOS, DEVUELTOS Y CANCELADOS.*/
select sp.descripcion status,count(*) cantidad
from pedido p
join status_pedido sp
  on p.status_pedido_id = sp.status_pedido_id
group by sp.descripcion;
  
  
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

/*1. Seleccionar los pedidos que tienen el status de cancelado
y mostrar como el detalle de dichos pedidos.*/



/*2. Generar un reporte que muestre el nombre, presentacion y precio de 
los medicamentos comprados por el usuario #########.*/


/*3.Seleccionar el total de los ingresos obtenidos del año 2020*/


/*4.Generar un reporte que muestre el id y nombre de los empleados que son responsables 
de los pedidos que tienen el stutas de cancelado, así como el detalle de cada uno de 
los pedidos.



