/* Consulta embebida en Power Query (tabla 'Fecha Corte').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

SELECT SYSDATETIMEOFFSET() AT TIME ZONE 'UTC' AT TIME ZONE 'SA Pacific Standard Time' AS FechaHora_Quito
