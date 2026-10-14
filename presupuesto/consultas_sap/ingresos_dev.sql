/* Consulta embebida en Power Query (tabla 'Ingresos DEV').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

select CONCAT('1/', MES,'/',Año COLLATE Latin1_General_BIN) FECHA
		,Partida AS PARTIDA, Proceso as PROCESO, VALOR

FROM (
SELECT  BASE.Año, BASE.Partida, BASE.Proceso
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
	SELECT Año, Partida,Proceso, [01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]
	from
	(
	SELECT 	 right(PERIO,2) Mes , GJAHR Año, FIPEX Partida
		,CASE WHEN BTART  = 0100 THEN 'ORIGINAL'
			 WHEN BTART  = 0250 THEN 'RECAUDADO'
		END Proceso
		,SUM(TRBTR) Devengado
	
		FROM [SERVIDOR_SAP].[PRD].[prd].[FMIFIIT] 
		where 
			MANDT  = 400
		AND FIKRS LIKE 'EMP1'
		AND GJAHR >2022
		--AND FIPEX =380107	
		AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')		
		AND RLDNR = '9B'
		--AND LEFT(FIPEX,1) IN ('1','2','3')
		AND FIPEX BETWEEN '100000' AND '399999'
		AND BTART IN ('0100', '0250') -- 100 ORIGINAL , 250 PAGADO
		group by  GJAHR, PERIO, FIPEX, BTART
	) FUENTE 
	
	PIVOT (
	    sum(Devengado)
	    FOR Mes IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12])
	) AS pivote
) BASE

GROUP BY BASE.Año, BASE.Partida, BASE.Proceso



)p
UNPIVOT (  
    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  
) AS unpvt
