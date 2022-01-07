--@Autor(es):  Cruz Ramos Diego Alejandro
--             Martinez Alvarez Pedro
--             Zuleta Ceja Juan Manuel
--@Fecha creación: 04/01/2022
--@Descripción: Creación de índices

--Índices en tabla EMPLEADO
create index empleado_nombre_ix on empleado(upper(nombre));
create unique index empleado_rfc_iuk on empleado(rfc);
create index empleado_centro_operacion_id_ix on empleado(centro_de_operacion_id);
--create index empleado_fecha_ingreso_ix on empleado(to_char(fecha_ingreso,'dd/mm/yyyy')); solo si exite una consulta

--Índices en tabla PEDIDO
create unique index pedido_folio_iuk on pedido(folio);
create index pedido_repartidor_id_ix on pedido(repartidor_id);
create index pedido_cliente_id_ix on pedido(cliente_id);

--Índices en tabla TARJETA
create index tarjeta_numero_ix on tarjeta(numero);

--Índices en tabla CLIENTE
create index cliente_email_ix on cliente(email);
create index cliente_rfc_ix on cliente(rfc);
create index cliente_tarjeta_id_ix on cliente(tarjeta_id);
create index cliente_nombre_ix on cliente(upper(nombre));

--Índices en tabla HISTORICO_STATUS
create index historico_status_pedido_id_ix on historico_status(pedido_id);

--Índices en tabla DETALLE_PEDIDO
create index detalle_pedido_farmacia_id_ix on detalle_pedido(farmacia_id);
create index detalle_pedido_medicamento_pres_id_ix on detalle_pedido(medicamento_presentacion_id);
create index detalle_pedido_pedido_id_ix on detalle_pedido(pedido_id);

--Índices en tabla CENTRO_DE_OPERACION
create unique index centro_operacion_clave_iuk on centro_de_operacion(clave);

--Índices en tabla FARMACIA
create unique index farmacia_rfc_fiscal_iuk on farmacia(rfc_fiscal);
create index farmacia_gerente_id_ix on farmacia(gerente_id);

--Índices en tabla ALMACEN
create index almacen_almacen_contigencia_id_ix on almacen(almacen_contigencia_id);
--create index alamcen_capacidad_ix on almacen(max(capacidad)); Si existe consulta

--Índices en tabla OFICINA
create index oficina_nombre_ix on oficina(upper(nombre));
--create unique index oficina_clave_presupuestal_iuk on oficina(clave_presupuestal);

--Índices en tabla OPERACION
create index operacion_almacen_id_ix on operacion(almacen_id);
create index operacion_responsable_id_ix on operacion(responsable_id);
--create index operacion_fecha_ix on operacion(to_char(fecha,'dd/mm/yyyy')); solo si exite una consulta

--Índices en tabla MEDICAMENTO_OPERACION
create index medicamento_operacion_almacen_id_ix on medicamento_operacion(almacen_id);
create index medicamento_operacion_operacion_id_ix on medicamento_operacion(operacion_id);
--create index medicamento_operacion_unidades_ix on medicamento_operacion(max(unidades)); Si existe consulta

--Índices en tabla FARMACIA_MEDICAMENTO_PRESENTACION
--create index farmacia_medicamento_presentacion_unidades_ix on farmacia_medicamento_presentacion(max(unidades)); Si existe consulta

--Índices en tabla MEDICAMENTO_PRESENTACION
create index medicamento_presentacion_medicamento_id_ix on medicamento_presentacion(medicamento_id);

--Índices en tabla MEDICAMENTO
--create index medicamento_precio_ix on medicamento(avg(precio)); Si existe consulta

--Índices MEDICAMENTO_NOMBRE
create index medicamento_nombre_medicamento_id_ix on medicamento_nombre(medicamento_id);
create index medicamento_nombre_nombre_ix on medicamento_nombre(upper(nombre));
