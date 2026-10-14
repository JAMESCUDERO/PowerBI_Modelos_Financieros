/* Consulta embebida en Power Query (tabla 'PlanE_5').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

select left ([CÓDIGO CONTABLE],5) as [CÓDIGO CONTABLE]
      ,[NIVEL 1]
      ,[NIVEL 2]
      ,[NIVEL 3]
      ,[NIVEL 5]
      from [PRESUPUESTO_CONTABILIDAD_DM].[dbo].[PlanCuentasC2026_2]
      group by  left ([CÓDIGO CONTABLE],5) 
      ,[NIVEL 1]
      ,[NIVEL 2]
      ,[NIVEL 3]
      ,[NIVEL 5]
