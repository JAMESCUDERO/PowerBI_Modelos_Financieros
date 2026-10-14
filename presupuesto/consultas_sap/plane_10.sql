/* Consulta embebida en Power Query (tabla 'PlanE_10').
   Origen: Sql.Database("SERVIDOR_DW\\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM").
   Servidores y codigo de sociedad reemplazados por marcadores. */

SELECT 
    S.SAKNR AS NumeroCuenta,
	P.[CÓDIGO CONTABLE],
	P.[NIVEL 1],
	P.[NIVEL 2],
	P.[NIVEL 3],
	P.[NIVEL 5],
	P.[NIVEL 7],
    K.TXT50 AS NombreCuenta,
    CASE 
        WHEN S.XBILK = 'X' THEN 'Cuenta de Mayor'
        ELSE 'Subcuenta'
    END AS TipoCuenta
	--,S.*
FROM [SERVIDOR_SAP].[PRD].[prd].[SKA1] S
INNER JOIN [SERVIDOR_SAP].[PRD].[prd].[SKAT] K 
    ON S.SAKNR = K.SAKNR 
    AND K.MANDT = S.MANDT
	AND S.KTOPL = K.KTOPL 
    AND K.SPRAS = 'S'

LEFT JOIN [PRESUPUESTO_CONTABILIDAD_DM].[dbo].[PlanCuentasC2026_2] P
ON LEFT(S.SAKNR,7) BETWEEN P.R_MIN AND P.R_MAX
	
where S.MANDT = 400
	and S.KTOPL = 'CGCC'
