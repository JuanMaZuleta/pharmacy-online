--@Autores: Diego Cruz, Pedro Martínez, Manuel Zuleta
--@Fecha creación: 02/01/2022
--@Descripción: Código DDL caso de estudio "Pharmacy Online"


Prompt tabla centro_de_operacion

create table centro_de_operacion( 
	centro_de_operacion_id  number(10,0) constraint centro_oper_pk primary key,
	clave varchar2(6) not null,
	direccion varchar2(200) not null,
	telefono 	number(20,0) not null,
	longitud number(10,3) not null,
	latitud number(10,3) not null,
	es_farmacia number(1,0) not null,
	es_oficina number(1,0) not null,
	es_almacen number(1,0) not null,
	constraint centro_de_operacion_tipo_chk check(
		es_farmacia=1 and es_almacen=0 and es_oficina=0 or 
		es_farmacia=0 and es_almacen=1 and es_oficina=0 or
		es_farmacia=0 and es_almacen=0 and es_oficina=1 or
		es_farmacia=1 and es_almacen=1 and es_oficina=0),
	constraint centro_de_operacion_clave_uk unique (clave)
);

Prompt tabla empleado

create table empleado(
  empleado_id number(10,0) not null,
  celular number(10,0),
  nombre varchar2(40) not null,
  ap_paterno varchar2(40) not null,
  ap_materno varchar2(40) not null,
  rfc varchar2(13) not null,
  fecha_ingreso date,
  centro_de_operacion_id number(10,0) not null,
  sueldo_mensual number(10,2) not null,
  sueldo_quincenal generated always as (sueldo_mensual/2) virtual,
  --antiguedad generated always as (sysdate - fecha_ingreso)/365 virtual,
  constraint empleado_pk primary key(empleado_id),
  constraint empleado_centro_de_operacion_id_fk foreign key(centro_de_operacion_id)
  references centro_de_operacion(centro_de_operacion_id)
);
Prompt tabla farmacia

create table farmacia (
	farmacia_id number (10,0) constraint farmacia_pk primary key,
	rfc_fiscal varchar2(20) not null,
	pagina_web varchar2(200) not null,
	gerente_id number (10,0) not null,
	constraint farmacia_farmacia_id_fk foreign key(farmacia_id)
	references centro_de_operacion(centro_de_operacion_id),
	constraint farmacia_gerente_id_fk foreign key (gerente_id) 
	references empleado(empleado_id), 
	constraint farmacia_gerente_id_uk unique(gerente_id)
);

Prompt almacen

create table almacen (
	almacen_id number(10,0) constraint almacen_pk primary key,
	tipo char(1) not null,
	capacidad	number(5,0) not null,
	distribucion blob	not null,
	almacen_contingencia_id 	number(10,0),
	constraint almacen_almacen_contingencia_id_fk foreign key(almacen_contingencia_id)
	references almacen(almacen_id),
	constraint almacen_almacen_id_fk foreign key(almacen_id)
	references centro_de_operacion(centro_de_operacion_id),
	constraint almacen_tipo_chk check(tipo in('C','M','D'))
);

Prompt oficina

create table oficina (
	oficina_id number(10,0) constraint oficina_pk primary key,
	nombre varchar2(100) not null,
	clave_presupuestal varchar2(40) not null,
	numero_call_center number(20,0) not null,
	constraint oficina_oficina_id_fk foreign key(oficina_id) 
	references centro_de_operacion(centro_de_operacion_id)
);

Prompt presentacion

create table presentacion (
	presentacion_id  number(10,0) constraint presentacion_pk primary key,
	cantidad		 number(5,0) not null
);

Prompt medicamento

create table medicamento (
	medicamento_id number(10,0) constraint medicamento_id primary key,
	sustancia_activa 	varchar2(400)	not null,
	descripcion	varchar2(400) not null,
	es_riesgo  number(1,0) not null
);

Prompt tabla medicamento_nombre

create table medicamento_nombre(
	medicamento_nombre_id number(10,0) constraint medicamento_nombre_pk primary key,
	nombre varchar2(100) not null,
	medicamento_id number(10,0) not null,
	constraint mednom_medicamento_id_fk foreign key(medicamento_id)
	references medicamento(medicamento_id)
);

Prompt tabla medicamento_presentacion

create table medicamento_presentacion(
	medicamento_presentacion_id number(10,0) constraint medicamento_presentacion_pk primary key,
	precio 			    number(5,0) not null,
	medicamento_id constraint medpres_medicamento_id_fk 
	references medicamento(medicamento_id),
	presentacion_id constraint medpres_presentacion_id_fk
  references presentacion(presentacion_id),
	constraint medicamento_precio_chk check(precio>0)
);

Prompt tabla farmacia_medicamento_presentacion

create table farmacia_medicamento_presentacion (
  unidades number(5,0) not null,
	medicamento_presentacion_id constraint farmedpres_medicamento_presentacion_id_fk
	references medicamento_presentacion(medicamento_presentacion_id),
	farmacia_id	constraint farmedpres_farmacia_id_fk
	references centro_de_operacion(centro_de_operacion_id),
	constraint farmedpres_pk primary key(medicamento_presentacion_id,farmacia_id),
  constraint farmedpres_unidades_chk check (unidades>=0)
);

Prompt tabla farmacia_medicamento_presentacion

create table farmacia_medicamento_presentacion (
  unidades number(5,0) not null,
	medicamento_presentacion_id constraint farmedpres_medicamento_presentacion_id_fk
	references medicamento_presentacion(medicamento_presentacion_id),
	farmacia_id	constraint farmedpres_farmacia_id_fk
	references centro_de_operacion(centro_de_operacion_id),
	constraint farmedpres_pk primary key(medicamento_presentacion_id,farmacia_id),
  constraint farmedpres_unidades_chk check (unidades>=0)
);

Prompt tabla operacion

create table operacion (
	operacion_id number(10,0) constraint operacion_pk primary key,
	fecha date default sysdate,
	tipo char(1) not null,
	almacen_id constraint oper_alamacen_id_fk 
	references centro_de_operacion(centro_de_operacion_id),
	responsable_id constraint operacion_responsable_id_fk 
	references empleado(empleado_id),
	constraint operecion_tipo_chk check (tipo in('E','S'))
);

Prompt tabla medicamento_operacion

create table medicamento_operacion (
	medicamento_operacion_id  number(10,0) constraint med_oper_pk primary key,
	unidades number(5,0) not null,
	medicamento_presentacion_id constraint medoper_med_pres_id_fk 
	references medicamento_presentacion(medicamento_presentacion_id),
	operacion_id constraint medoper_operacion_id_fk
	references operacion(operacion_id),
  constraint medoper_unidades_chk check (unidades>0)
);

Prompt tabla tarjeta

create table tarjeta(
  tarjeta_id number(10,0) constraint tarjeta_pk primary key,
  numero number(16,0) not null,
  anio_expiracion varchar2(2) not null,
  mes varchar2(2) not null
);

Prompt tabla cliente

create table cliente(
  cliente_id number(10,0) not null,
  curp varchar2(18),
  direccion varchar2(100),
  ap_paterno varchar2(40) not null,
  ap_materno varchar2(40) not null,
  nombre varchar2(40) not null,
  email varchar2(100) not null,
  telefono number(10) not null,
  rfc varchar2(13) not null,
  tarjeta_id number(10,0),
  constraint cliente_pk primary key(cliente_id),
  constraint cliente_tarjeta_id_fk foreign key(tarjeta_id)
  references tarjeta(tarjeta_id),
  constraint cliente_tarjeta_id_uk unique(tarjeta_id),
  constraint cliente_curp_uk unique(curp),
  constraint cliente_rfc_uk unique(rfc)
);

Prompt tabla status_pedido

create table status_pedido(
  status_pedido_id number(10,0) not null,
  clave varchar2(20) not null,
  descripcion varchar2(100) not null,
  constraint status_pedido_fk primary key(status_pedido_id)
);

Prompt tabla pedido

create table pedido(
  pedido_id number(10,0) not null,
  fecha_status date not null,
  folio varchar2(13) not null,
  repartidor_id number(10,0) not null,
  cliente_id number(10,0) not null,
  status_pedido_id number(10,0) not null,
  constraint pedido_pk primary key(pedido_id),
  constraint pedido_repartidor_id_fk foreign key(repartidor_id)
  references empleado(empleado_id),
  constraint pedido_cliente_id_fk foreign key(cliente_id)
  references cliente(cliente_id),
  constraint pedido_status_pedido_id_fk foreign key(status_pedido_id)
  references status_pedido(status_pedido_id),
  constraint pedido_folio_uk unique(folio)
);

Prompt tabla ubicacion

create table ubicacion(
  ubicacion_id number(10,0) not null,
  longitud number(10,7) not null,
  latitud number(10,7) not null,
  fecha date default sysdate,
  pedido_id number(10,0) not null,
  constraint ubicacion_pk  primary key(ubicacion_id)
);

Prompt tabla historico_status

create table historico_status(
  historico_status_id number(10,0) not null,
  fecha_status date not null,
  pedido_id number(10,0) not null,
  status_pedido_id number(10,0) not null,
  constraint historico_status_pk primary key(historico_status_id),
  constraint historico_status_pedido__id_fk foreign key(pedido_id)
  references pedido(pedido_id),
  constraint historico_status_status_pedido_id_fk foreign key(status_pedido_id)
  references status_pedido(status_pedido_id)
);

Prompt tabla detalle_pedido

create table detalle_pedido(
  detalle_pedido_id number(10,0) not null,
  unidades number(5,0) not null,
  farmacia_id number(10,0) not null,
  medicamento_presentacion_id number(10,0) not null,
  pedido_id number(10,0) not null,
  constraint detalle_pedido_pk primary key(detalle_pedido_id),
  constraint detalle_pedido_farmacia_id_fk foreign key(farmacia_id)
  references farmacia(farmacia_id),
  constraint detalle_pedido_medicamento_presentacion_id_fk foreign key (medicamento_presentacion_id)
  references medicamento_presentacion(medicamento_presentacion_id),
  constraint detalle_pedido_pedido_id_fk foreign key(pedido_id)
  references pedido(pedido_id),
  constraint detalle_pedido_unidades_chk check(unidades>0)
);

