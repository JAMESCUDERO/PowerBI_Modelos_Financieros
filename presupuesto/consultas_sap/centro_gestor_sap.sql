/* Consulta embebida en Power Query (tabla 'Centro Gestor SAP').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

SELECT FICTR Codigo 
, BEZEICH Nombre 
, BESCHR Descripcion 
FROM [SERVIDOR_SAP].[PRD].[prd].[FMFCTRT] 
WHERE  
MANDT = 400 
AND FIKRS LIKE 'EMP1' 
AND SPRAS LIKE 'S'
