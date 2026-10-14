/* Consulta embebida en Power Query (tabla 'Gasto DEV').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

select CONCAT('1/', MES,'/',Año COLLATE Latin1_General_BIN) FECHA
		 ,Centro ,Partida AS PARTIDA , Proceso, VALOR

FROM (
SELECT  BASE.Año, BASE.Centro, BASE.Partida, BASE.Proceso
		,ENERO		= SUM(isnull(BASE.[01],0))
		,FEBRERO	= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))
		,MARZO		= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0)) 
		,ABRIL		= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0)) 
		,MAYO		= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0)) 
		,JUNIO		= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0)) 
		,JULIO		= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))
		,AGOSTO		= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))
		,SEPTIEMBRE	= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))
		,OCTUBRE	= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))
		,NOVIEMBRE  = SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))
		,DICIEMBRE	= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))+SUM(isnull(BASE.[12],0))

FROM (
	SELECT Año,Centro, Partida,Proceso, [01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]
	from
	(
		SELECT 	 right(PERIO,2) Mes , GJAHR Año, FISTL Centro, FIPEX Partida
			,CASE WHEN RLDNR LIKE '9A' THEN 'DEVENGADO'
					WHEN RLDNR LIKE '9B' THEN 'PAGADO'
				END Proceso		
			, SUM(FKBTR) Devengado
			--,FKBTR,RLDNR,BTART,PAYFLG
		FROM [SERVIDOR_SAP].[PRD].[prd].[FMIFIIT] 
		where 
			MANDT  = 400
		AND FIKRS LIKE 'EMP1'
		AND GJAHR > 2022
		--AND FIPEX =    570203 
		AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')	
	--	and PERIO = 001
		AND FIPEX BETWEEN '500000' AND '999999'		
		AND (RLDNR = '9A' 
			OR RLDNR = '9B'AND BTART = 0250
			)
		group by  GJAHR, PERIO, FISTL, FIPEX ,RLDNR
	) FUENTE 
	
	PIVOT (
	    sum(Devengado)
	    FOR Mes IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12])
	) AS pivote
) BASE

GROUP BY BASE.Año,BASE.Centro, BASE.Partida, BASE.Proceso



)p
UNPIVOT (  
    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  
) AS unpvt  

where VALOR <>0
