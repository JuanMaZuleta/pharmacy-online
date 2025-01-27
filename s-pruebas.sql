-- @Autor (es): Cruz Ramos Diego Alejandro
-- Juan Manuel Zuleta Ceja
-- Pedro Martínez Alvarez
-- @Fecha creación: 04/01/2022
-- @Descripción: Ejecución de pruebas y triggers

prompt prueba para p-nueva-orden
@s-14-p-nueva-orden-prueba.sql

prompt prueba para p-promocion
@s-14-p-promocion-prueba.sql

prompt prueba para p-carga-distribucion
@s-14-p-actualiza-distribucion-prueba.sql

prompt ejecucion de triggers
prompt tr-actual_unidades
@s-11-tr-actual_unidades.sql

prompt tr-empleado_despedido
@s-11-tr-empleado_despedido.sql

prompt tr-operacion_riesgo
@s-11-tr-operacion_riesgo.sql

prompt ejecución de pruebas para triggers
prompt prueba para tr-actual_unidades
@s-12-tr-actual_unidades-prueba.sql

prompt prueba para tr-empleado_despedido
@s-12-tr-empleado_despedido-prueba.sql

prompt prueba para tr-empleado_despedido
@s-12-tr-operacion_riesgo-prueba.sql

prompt prueba para función clave_cliente
@s-16-fx-clave-cliente-prueba.sql