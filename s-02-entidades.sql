create table tarjeta(
  tarjeta_id number(10,0) not null,
  numero number(16,0) not null,
  anio_expiracion varchar2(2) not null,
  mes varchar2(2) not null,

  constraint tarjeta_pk primary key(tarjeta_id)
);

create table cliente(
  cliente_id number(10,0) not null,
  curp varchar2(18),
  direccion varchar2(100),
  apellido_paterno varchar2(40) not null,
  apellido_materno varchar2(40) not null,
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

create table status_pedido(
  status_pedido_id number(10,0) not null,
  clave number(10,0) not null,
  descripcion varchar2(100) not null,

  constraint status_pedido_fk primary key(status_pedido_id)
);

create table empleado(
  empleado_id number(10,0) not null,
  celular number(10,0),
  nombre varchar2(40) not null,
  apellido_paterno varchar2(40) not null,
  apellido_materno varchar2(40) not null,
  rfc varchar2(13) not null,
  fecha_ingreso date default sysdate,
  centro_de_operacion_id number(10,0) not null,
  sueldo_mensual number(10,2) not null,
  sueldo_quincenal generated always as (sueldo_mensual/2) virtual,
  antiguedad generated always as (sysdate - fecha_ingreso)/365) virtual,
  
  constraint empleado_pk primary key(empleado_id),
  constraint empleado_centro_de_operacion_id foreign key(centro_de_operacion_id)
  references centro_de_operacion(centro_de_operacion_id)
);

create table pedido(
  pedido_id number(10,0) not null,
  fecha_status date not null,
  folio varchar2(13) not null,
  importe number(5,0) not null,
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

create table ubicacion(
  ubicacion_id number(10,0) not null,
  longitud number(10,7) not null,
  latitud number(10,7) not null,
  fecha date default sysdate,
  pedido_id number(10,0) not null,

  constraint ubicacion_pk  primary key(ubicacion_id)
);

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

create table detalle_pedido(
  detalle_pedido_id number(10,0) not null,
  unidades number(5,0) not null,
  farmacia_id number(10,0) not null,
  medicamento_presentacion_id number(10,0) not null,
  pedido_id number(10,0) not null,

  constraint detalle_pedido_pk foreign key(detalle_pedido_id),
  constraint detalle_pedido_farmacia_id_fk foreign key(farmacia_id)
  references farmacia(centro_de_operacion_id),
  constraint detalle_pedido_medicamento_presentacion_id_fk foreign key (medicamento_presentacion_id)
  references medicamento_presentacion(medicamento_presentacion_id),
  constraint detalle_pedido_pedido_id_fk foreign key(pedido_id)
  references pedido(pedido_id),
  constraint detalle_pedido_unidades_chk check(unidades>0)
);


