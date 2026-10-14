/* Consulta embebida en Power Query (tabla 'Gasto DEV DES').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

SELECT 	 	CONCAT('1/', right(PERIO,2),'/',GJAHR COLLATE Latin1_General_BIN) FECHA
			, FISTL Centro, FIPEX Partida
			,CASE WHEN RLDNR = '9A' THEN 'DEVENGADO'
					WHEN RLDNR = '9B' THEN 'PAGADO'
				END Proceso		
			, SUM(FKBTR) Devengado
			--,FKBTR,RLDNR,BTART,PAYFLG
		FROM [SERVIDOR_SAP].[PRD].[prd].[FMIFIIT] 
		where 
			MANDT  = 400
		AND FIKRS = 'EMP1'
		AND GJAHR > 2022
		--AND FIPEX =    570203 
		AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')	
		AND FIPEX BETWEEN '500000' AND '999999'		
		AND (RLDNR = '9A' 
			OR RLDNR = '9B'AND BTART = 0250
			)
		group by  GJAHR, PERIO, FISTL, FIPEX ,RLDNR
