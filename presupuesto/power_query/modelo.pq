// Consultas Power Query (lenguaje M) del modelo, extraidas del .pbix.
// Servidores, codigo de sociedad y tenant de SharePoint reemplazados por marcadores.
// El .pbix con datos NO se publica.

// ===== Origen Estados =====
shared #"Origen Estados" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="SELECT#(tab)CONCAT(BASE.DIA,'/', BASE.MES,'/', BASE.ANIO COLLATE Latin1_General_BIN) FECHA#(tab)#(lf)#(tab)#(tab) ,BASE.CODIGO_CONTABLE#(lf)#(tab)#(tab) ,LEFT(BASE.CODIGO_CONTABLE,5) CODIGO_CONTABLE_5#(lf)#(tab)#(tab) ,BASE.VALOR#(lf)#(tab)#(tab) ,BASE.INDICADOR#(lf)#(tab)#(tab) ,BASE.CODIGO_CONTABLE AS [CODIGO_CONTABLE NUM]#(lf)#(tab)#(tab) ,LEFT(BASE.CODIGO_CONTABLE,1) AS ORDEN#(lf)FROM(#(lf)#(tab)SELECT  DIA = 1, MES, ANIO, CODIGO_CONTABLE,INDICADOR, VALOR#(lf)FROM (  #(lf)    select  FACT.RYEAR AS ANIO#(lf)#(tab)#(tab),FACT.RACCT as CODIGO_CONTABLE#(lf)#(tab)#(tab),FACT.DRCRK AS INDICADOR#(lf)#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01) ENERO#(tab)#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02) FEBRERO#(lf)#(tab)#(tab) ,SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03) MARZO#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04) ABRIL#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05) MAYO#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06) JUNIO#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07) JULIO#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08) AGOSTO#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08)+SUM(FACT.TSL09) SEPTIEMBRE#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08)+SUM(FACT.TSL09)+SUM(FACT.TSL10) OCTUBRE#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08)+SUM(FACT.TSL09)+SUM(FACT.TSL10)+SUM(FACT.TSL11) NOVIEMBRE#(lf)#(tab)#(tab),SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08)+SUM(FACT.TSL09)+SUM(FACT.TSL10)+SUM(FACT.TSL11)+SUM(FACT.TSL12) DICIEMBRE#(lf)#(tab)#(tab)--,SUM(FACT.TSLVT)+SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)#(lf)#(tab)#(tab)--#(tab)#(tab)#(tab)#(tab)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08)#(lf)#(tab)#(tab)--#(tab)#(tab)#(tab)#(tab)+SUM(FACT.TSL09)+SUM(FACT.TSL10)+SUM(FACT.TSL11)+SUM(FACT.TSL12) AS TOTAL#(lf)#(tab)#(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[FAGLFLEXT] FACT#(lf)#(lf)where RYEAR >= 2023#(lf)#(tab)AND FACT.RCLNT = 400#(lf)#(tab)AND FACT.RBUKRS LIKE 'EMP1'#(lf)GROUP BY  FACT.RYEAR, FACT.RACCT, FACT.DRCRK#(lf)HAVING SUM(FACT.TSLVT) +SUM(FACT.TSL01)+SUM(FACT.TSL02)+SUM(FACT.TSL03)+SUM(FACT.TSL04)#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)+SUM(FACT.TSL05)+SUM(FACT.TSL06)+SUM(FACT.TSL07)+SUM(FACT.TSL08)#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)+SUM(FACT.TSL09)+SUM(FACT.TSL10)+SUM(FACT.TSL11)+SUM(FACT.TSL12) <> 0#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)--AND FACT.RACCT LIKE '1111501012' #(lf)) p  #(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  #(lf)#(lf)WHERE VALOR <> 0#(lf)--#(tab)AND MES LIKE 'DICIEMBRE'#(lf)--#(tab)AND AÑO LIKE '2024'#(lf)--#(tab)AND CODIGO_CONTABLE LIKE '11215%'#(lf)--ORDER BY AÑO, MES;#(lf)#(tab)) BASE#(lf)"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}, {"CODIGO_CONTABLE NUM", Int64.Type}, {"ORDEN", Int64.Type}})
in
    #"Tipo cambiado";

// ===== PlanE_5 =====
shared #"PlanE_5" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="  select left ([CÓDIGO CONTABLE],5) as [CÓDIGO CONTABLE]#(lf)      ,[NIVEL 1]#(lf)      ,[NIVEL 2]#(lf)      ,[NIVEL 3]#(lf)      ,[NIVEL 5]#(lf)      from [PRESUPUESTO_CONTABILIDAD_DM].[dbo].[PlanCuentasC2026_2]#(lf)      group by  left ([CÓDIGO CONTABLE],5) #(lf)      ,[NIVEL 1]#(lf)      ,[NIVEL 2]#(lf)      ,[NIVEL 3]#(lf)      ,[NIVEL 5]"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"CÓDIGO CONTABLE", type text}}),
    #"Personalizada agregada" = Table.AddColumn(#"Tipo cambiado", "RESULTADO", each if Text.Start([CÓDIGO CONTABLE], 2)="62" then "Ingresos"
else if Text.Start([CÓDIGO CONTABLE], 2)="63" then "Gastos"
else null),
    #"Tipo cambiado1" = Table.TransformColumnTypes(#"Personalizada agregada",{{"RESULTADO", type text}})
in
    #"Tipo cambiado1";

// ===== DAX =====
shared #"DAX" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Columna1", type text}}),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tipo cambiado",{"Columna1"})
in
    #"Columnas quitadas";

// ===== PlanE_10 =====
shared #"PlanE_10" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="SELECT #(lf)    S.SAKNR AS NumeroCuenta,#(lf)#(tab)P.[CÓDIGO CONTABLE],#(lf)#(tab)P.[NIVEL 1],#(lf)#(tab)P.[NIVEL 2],#(lf)#(tab)P.[NIVEL 3],#(lf)#(tab)P.[NIVEL 5],#(lf)#(tab)P.[NIVEL 7],#(lf)    K.TXT50 AS NombreCuenta,#(lf)    CASE #(lf)        WHEN S.XBILK = 'X' THEN 'Cuenta de Mayor'#(lf)        ELSE 'Subcuenta'#(lf)    END AS TipoCuenta#(lf)#(tab)--,S.*#(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[SKA1] S#(lf)INNER JOIN [SERVIDOR_SAP].[PRD].[prd].[SKAT] K #(lf)    ON S.SAKNR = K.SAKNR #(lf)    AND K.MANDT = S.MANDT#(lf)#(tab)AND S.KTOPL = K.KTOPL #(lf)    AND K.SPRAS = 'S'#(lf)#(lf)LEFT JOIN [PRESUPUESTO_CONTABILIDAD_DM].[dbo].[PlanCuentasC2026_2] P#(lf)ON LEFT(S.SAKNR,7) BETWEEN P.R_MIN AND P.R_MAX#(lf)#(tab)#(lf)where S.MANDT = 400#(lf)#(tab)and S.KTOPL = 'CGCC'#(lf)#(lf)#(lf)"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"CÓDIGO CONTABLE", type text}})
in
    #"Tipo cambiado";

// ===== Ingresos PRE =====
shared #"Ingresos PRE" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="SELECT CONCAT(DIA,'/',MES,'/', DOCYEAR COLLATE Latin1_General_BIN) FECHA#(lf)#(tab)#(tab), left(CMMTITEM,6) CMMTITEM, PROCESS , VALOR#(lf)#(lf)FROM (#(lf)SELECT  DIA=1#(lf)#(tab)#(tab),DOCYEAR#(lf)#(tab)#(tab),CMMTITEM#(lf)#(tab)#(tab)--,BUDCAT#(lf)#(tab)#(tab)--,PROCESS#(lf)#(tab)#(tab),PROCESS#(tab)=CASE WHEN (BUDCAT = '9F' AND PROCESS LIKE 'ENTR') THEN 'PRESUPUESTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9F' AND PROCESS LIKE 'RETN') THEN 'TRASPASO REDUCCION'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9F' AND PROCESS LIKE 'SUPL') THEN 'TRASPASO INCREMENTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab) #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9G' AND PROCESS LIKE 'RETN') THEN 'REDUCCION'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9G' AND PROCESS LIKE 'SUPL') THEN 'INCREMENTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  #(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  #(lf)#(tab)#(tab)#(tab)#(tab)#(tab) END#(lf)#(tab)#(tab),ENERO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01) ELSE SUM(TVAL01) END#(lf)#(tab)#(tab),FEBRERO#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)ELSE SUM(TVAL02) END#(lf)#(tab)#(tab),MARZO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03) ELSE SUM(TVAL03) END#(lf)#(tab)#(tab),ABRIL#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04) ELSE SUM(TVAL04) END#(lf)#(tab)#(tab),MAYO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05) ELSE SUM(TVAL05) END#(lf)#(tab)#(tab),JUNIO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06) ELSE SUM(TVAL06) END#(lf)#(tab)#(tab),JULIO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07) ELSE SUM(TVAL07) END#(lf)#(tab)#(tab),AGOSTO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08) ELSE SUM(TVAL08) END#(lf)#(tab)#(tab),SEPTIEMBRE#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09) ELSE SUM(TVAL09) END#(lf)#(tab)#(tab),OCTUBRE#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09)+SUM(TVAL10) ELSE SUM(TVAL10) END#(lf)#(tab)#(tab),NOVIEMBRE  = CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09)+SUM(TVAL10)+SUM(TVAL11) ELSE SUM(TVAL11) END#(lf)#(tab)#(tab),DICIEMBRE#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09)+SUM(TVAL10)+SUM(TVAL11)+SUM(TVAL12) ELSE SUM(TVAL12) END#(lf)#(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[FMBL]#(lf)where DOCYEAR > 2022#(lf)#(tab)AND CLIENT =400#(lf)#(tab)--AND LEFT(CMMTITEM,1) IN ('1', '2', '3')#(lf)#(tab)AND CMMTITEM BETWEEN '100000' AND '399999'#(lf)#(tab)--AND CMMTITEM =  380108#(lf)#(tab)AND#(tab)(BUDCAT = '9F' #(lf)#(tab)OR#(tab)(BUDCAT = '9G' AND PROCESS LIKE 'RETN')#(lf)#(tab)OR#(tab)(BUDCAT = '9G' AND PROCESS LIKE 'SUPL'))#(lf)#(tab)--AND FUNDSCTR =3290#(lf)#(tab)GROUP BY #(lf)#(tab)#(tab)DOCYEAR, CMMTITEM ,BUDCAT, PROCESS#(lf)#(lf))p#(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  #(lf)WHERE VALOR <>0"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}})
in
    #"Tipo cambiado";

// ===== Gastos PRE =====
shared #"Gastos PRE" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="SELECT CONCAT(DIA,'/',MES,'/', DOCYEAR COLLATE Latin1_General_BIN) FECHA#(lf)#(tab)#(tab), CMMTITEM, FUNDSCTR, PROCESS , VALOR#(lf)#(lf)FROM (#(lf)SELECT  DIA=1#(lf)#(tab)#(tab),DOCYEAR#(lf)#(tab)#(tab),CMMTITEM#(lf)#(tab)#(tab)--,BUDCAT#(lf)#(tab)#(tab)--,PROCESS#(lf)#(tab)#(tab),FUNDSCTR#(lf)#(tab)#(tab),PROCESS#(tab)=CASE WHEN (BUDCAT = '9F' AND PROCESS LIKE 'ENTR') THEN 'PRESUPUESTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9F' AND PROCESS LIKE 'RECV') THEN 'TRASPASO INCREMENTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9F' AND PROCESS LIKE 'SEND') THEN 'TRASPASO REDUCCION'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9G' AND PROCESS LIKE 'SEND') THEN 'REFORMA REDUCCION'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9G' AND PROCESS LIKE 'RECV') THEN 'REFORMA INCREMENTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9F' AND PROCESS LIKE 'RETN') THEN 'REDUCCION'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)  WHEN (BUDCAT = '9F' AND PROCESS LIKE 'SUPL') THEN 'SUPLEMENTO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab) END#(lf)#(tab)#(tab),ENERO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01) ELSE SUM(TVAL01) END#(lf)#(tab)#(tab),FEBRERO#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)ELSE SUM(TVAL02) END#(lf)#(tab)#(tab),MARZO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03) ELSE SUM(TVAL03) END#(lf)#(tab)#(tab),ABRIL#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04) ELSE SUM(TVAL04) END#(lf)#(tab)#(tab),MAYO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05) ELSE SUM(TVAL05) END#(lf)#(tab)#(tab),JUNIO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06) ELSE SUM(TVAL06) END#(lf)#(tab)#(tab),JULIO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07) ELSE SUM(TVAL07) END#(lf)#(tab)#(tab),AGOSTO#(tab)#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08) ELSE SUM(TVAL08) END#(lf)#(tab)#(tab),SEPTIEMBRE#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09) ELSE SUM(TVAL09) END#(lf)#(tab)#(tab),OCTUBRE#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09)+SUM(TVAL10) ELSE SUM(TVAL10) END#(lf)#(tab)#(tab),NOVIEMBRE  = CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09)+SUM(TVAL10)+SUM(TVAL11) ELSE SUM(TVAL11) END#(lf)#(tab)#(tab),DICIEMBRE#(tab)= CASE WHEN BUDCAT LIKE '9F' THEN SUM(TVAL01)+SUM(TVAL02)+SUM(TVAL03)+SUM(TVAL04)+SUM(TVAL05)+SUM(TVAL06)+SUM(TVAL07)+SUM(TVAL08)+SUM(TVAL09)+SUM(TVAL10)+SUM(TVAL11)+SUM(TVAL12) ELSE SUM(TVAL12) END#(lf)#(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[FMBL]#(lf)where DOCYEAR > 2022#(lf)#(tab)--AND LEFT(CMMTITEM,1) IN ('5', '7', '8', '9')#(lf)#(tab)AND CMMTITEM BETWEEN '500000' AND '999999'#(lf)#(tab)--AND CMMTITEM =  840104#(lf)#(tab)AND#(tab)(BUDCAT = '9F' #(lf)#(tab)OR#(tab)(BUDCAT = '9G' AND PROCESS LIKE 'SEND')#(lf)#(tab)OR#(tab)(BUDCAT = '9G' AND PROCESS LIKE 'RECV'))#(lf)#(tab)--AND FUNDSCTR =3290#(lf)GROUP BY #(lf)#(tab)#(tab)DOCYEAR, CMMTITEM ,BUDCAT,FUNDSCTR, PROCESS#(lf)#(lf)#(lf))p#(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  #(lf)WHERE VALOR <>0"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}})
in
    #"Tipo cambiado";

// ===== DAX INGRESOS =====
shared #"DAX INGRESOS" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Columna1", type text}}),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tipo cambiado",{"Columna1"})
in
    #"Columnas quitadas";

// ===== Ingresos DEV =====
shared #"Ingresos DEV" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="select CONCAT('1/', MES,'/',Año COLLATE Latin1_General_BIN) FECHA#(lf)#(tab)#(tab),Partida AS PARTIDA, Proceso as PROCESO, VALOR#(lf)#(lf)FROM (#(lf)SELECT  BASE.Año, BASE.Partida, BASE.Proceso#(lf)#(tab)#(tab),ENERO#(tab)#(tab)= SUM(isnull(BASE.[01],0))#(lf)#(tab)#(tab),FEBRERO#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))#(lf)#(tab)#(tab),MARZO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0)) #(lf)#(tab)#(tab),ABRIL#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0)) #(lf)#(tab)#(tab),MAYO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0)) #(lf)#(tab)#(tab),JUNIO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0)) #(lf)#(tab)#(tab),JULIO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))#(lf)#(tab)#(tab),AGOSTO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))#(lf)#(tab)#(tab),SEPTIEMBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))#(lf)#(tab)#(tab),OCTUBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))#(lf)#(tab)#(tab),NOVIEMBRE  = SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))#(lf)#(tab)#(tab),DICIEMBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))+SUM(isnull(BASE.[12],0))#(lf)#(lf)FROM (#(lf)#(tab)SELECT Año, Partida,Proceso, [01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]#(lf)#(tab)from#(lf)#(tab)(#(lf)#(tab)SELECT #(tab) right(PERIO,2) Mes , GJAHR Año, FIPEX Partida#(lf)#(tab)#(tab),CASE WHEN BTART  = 0100 THEN 'ORIGINAL'#(lf)#(tab)#(tab)#(tab) WHEN BTART  = 0250 THEN 'RECAUDADO'#(lf)#(tab)#(tab)END Proceso#(lf)#(tab)#(tab),SUM(TRBTR) Devengado#(lf)#(tab)#(lf)#(tab)#(tab)FROM [SERVIDOR_SAP].[PRD].[prd].[FMIFIIT] #(lf)#(tab)#(tab)where #(lf)#(tab)#(tab)#(tab)MANDT  = 400#(lf)#(tab)#(tab)AND FIKRS LIKE 'EMP1'#(lf)#(tab)#(tab)AND GJAHR >2022#(lf)#(tab)#(tab)--AND FIPEX =380107#(tab)#(lf)#(tab)#(tab)AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')#(tab)#(tab)#(lf)#(tab)#(tab)AND RLDNR = '9B'#(lf)#(tab)#(tab)--AND LEFT(FIPEX,1) IN ('1','2','3')#(lf)#(tab)#(tab)AND FIPEX BETWEEN '100000' AND '399999'#(lf)#(tab)#(tab)AND BTART IN ('0100', '0250') -- 100 ORIGINAL , 250 PAGADO#(lf)#(tab)#(tab)group by  GJAHR, PERIO, FIPEX, BTART#(lf)#(tab)) FUENTE #(lf)#(tab)#(lf)#(tab)PIVOT (#(lf)#(tab)    sum(Devengado)#(lf)#(tab)    FOR Mes IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12])#(lf)#(tab)) AS pivote#(lf)) BASE#(lf)#(lf)GROUP BY BASE.Año, BASE.Partida, BASE.Proceso#(lf)#(lf)#(lf)#(lf))p#(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  "]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}}),
    #"Primeros caracteres extraídos" = Table.TransformColumns(#"Tipo cambiado", {{"PARTIDA", each Text.Start(_, 6), type text}})
in
    #"Primeros caracteres extraídos";

// ===== Gasto DEV =====
shared #"Gasto DEV" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="select CONCAT('1/', MES,'/',Año COLLATE Latin1_General_BIN) FECHA#(lf)#(tab)#(tab) ,Centro ,Partida AS PARTIDA , Proceso, VALOR#(lf)#(lf)FROM (#(lf)SELECT  BASE.Año, BASE.Centro, BASE.Partida, BASE.Proceso#(lf)#(tab)#(tab),ENERO#(tab)#(tab)= SUM(isnull(BASE.[01],0))#(lf)#(tab)#(tab),FEBRERO#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))#(lf)#(tab)#(tab),MARZO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0)) #(lf)#(tab)#(tab),ABRIL#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0)) #(lf)#(tab)#(tab),MAYO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0)) #(lf)#(tab)#(tab),JUNIO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0)) #(lf)#(tab)#(tab),JULIO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))#(lf)#(tab)#(tab),AGOSTO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))#(lf)#(tab)#(tab),SEPTIEMBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))#(lf)#(tab)#(tab),OCTUBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))#(lf)#(tab)#(tab),NOVIEMBRE  = SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))#(lf)#(tab)#(tab),DICIEMBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))+SUM(isnull(BASE.[12],0))#(lf)#(lf)FROM (#(lf)#(tab)SELECT Año,Centro, Partida,Proceso, [01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]#(lf)#(tab)from#(lf)#(tab)(#(lf)#(tab)#(tab)SELECT #(tab) right(PERIO,2) Mes , GJAHR Año, FISTL Centro, FIPEX Partida#(lf)#(tab)#(tab)#(tab),CASE WHEN RLDNR LIKE '9A' THEN 'DEVENGADO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)WHEN RLDNR LIKE '9B' THEN 'PAGADO'#(lf)#(tab)#(tab)#(tab)#(tab)END Proceso#(tab)#(tab)#(lf)#(tab)#(tab)#(tab), SUM(FKBTR) Devengado#(lf)#(tab)#(tab)#(tab)--,FKBTR,RLDNR,BTART,PAYFLG#(lf)#(tab)#(tab)FROM [SERVIDOR_SAP].[PRD].[prd].[FMIFIIT] #(lf)#(tab)#(tab)where #(lf)#(tab)#(tab)#(tab)MANDT  = 400#(lf)#(tab)#(tab)AND FIKRS LIKE 'EMP1'#(lf)#(tab)#(tab)AND GJAHR > 2022#(lf)#(tab)#(tab)--AND FIPEX =    570203 #(lf)#(tab)#(tab)AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')#(tab)#(lf)#(tab)--#(tab)and PERIO = 001#(lf)#(tab)#(tab)AND FIPEX BETWEEN '500000' AND '999999'#(tab)#(tab)#(lf)#(tab)#(tab)AND (RLDNR = '9A' #(lf)#(tab)#(tab)#(tab)OR RLDNR = '9B'AND BTART = 0250#(lf)#(tab)#(tab)#(tab))#(lf)#(tab)#(tab)group by  GJAHR, PERIO, FISTL, FIPEX ,RLDNR#(lf)#(tab)) FUENTE #(lf)#(tab)#(lf)#(tab)PIVOT (#(lf)#(tab)    sum(Devengado)#(lf)#(tab)    FOR Mes IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12])#(lf)#(tab)) AS pivote#(lf)) BASE#(lf)#(lf)GROUP BY BASE.Año,BASE.Centro, BASE.Partida, BASE.Proceso#(lf)#(lf)#(lf)#(lf))p#(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  #(lf)#(lf)where VALOR <>0"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}})
in
    #"Tipo cambiado";

// ===== DAX  GASTOS =====
shared #"DAX  GASTOS" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Columna1", type text}}),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tipo cambiado",{"Columna1"})
in
    #"Columnas quitadas";

// ===== Centro Gestor SAP =====
shared #"Centro Gestor SAP" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="SELECT FICTR Codigo #(lf), BEZEICH Nombre #(lf), BESCHR Descripcion #(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[FMFCTRT] #(lf)WHERE  #(lf)MANDT = 400 #(lf)AND FIKRS LIKE 'EMP1' #(lf)AND SPRAS LIKE 'S' "])
in
    Origen;

// ===== PlanP_6 =====
shared #"PlanP_6" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM"),
    #"dbo_PlanP_6$" = Origen{[Schema="dbo",Item="PlanP_6C"]}[Data],
    #"Tipo cambiado" = Table.TransformColumnTypes(#"dbo_PlanP_6$",{{"CODIGO", type text}}),
    #"Texto insertado después del delimitador" = Table.AddColumn(#"Tipo cambiado", "NIVEL 6 T", each Text.AfterDelimiter([#"NIVEL 6"], " "), type text),
    #"Columna duplicada" = Table.DuplicateColumn(#"Texto insertado después del delimitador", "CODIGO", "CODIGO - Copia"),
    #"Dividir columna por posiciones" = Table.SplitColumn(#"Columna duplicada", "CODIGO - Copia", Splitter.SplitTextByPositions({0, 2, 4}), {"CODIGO - Copia.1", "CODIGO - Copia.2", "CODIGO - Copia.3"}),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Dividir columna por posiciones",{{"CODIGO - Copia.1", "GRUPO"}, {"CODIGO - Copia.2", "SUBGRUPO"}, {"CODIGO - Copia.3", "ITEM"}})
in
    #"Columnas con nombre cambiado";

// ===== DEBITO =====
shared #"DEBITO" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM"),
    #"dbo_DÉBITO$" = Origen{[Schema="dbo",Item="DÉBITO$"]}[Data],
    #"Tipo cambiado" = Table.TransformColumnTypes(#"dbo_DÉBITO$",{{"CÓDIGO CONTABLE", type text}, {"DÉBITO", type text}})
in
    #"Tipo cambiado";

// ===== Verificacion_Contable =====
shared #"Verificacion_Contable" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="#(lf)SELECT#(tab)CONCAT(BASE.DIA,'/', BASE.MES,'/', BASE.ANIO COLLATE Latin1_General_BIN) FECHA#(tab)#(lf)#(tab)#(tab) ,BASE.CODIGO_CONTABLE#(lf)#(tab)#(tab) ,LEFT(BASE.CODIGO_CONTABLE,5) CODIGO_CONTABLE_5#(lf)#(tab)#(tab) ,BASE.VALOR#(lf)#(tab)#(tab) ,BASE.INDICADOR#(lf)#(tab)#(tab) ,BASE.CODIGO_CONTABLE AS [CODIGO_CONTABLE NUM]#(lf)#(tab)#(tab) ,LEFT(BASE.CODIGO_CONTABLE,1) AS ORDEN#(lf)FROM(#(lf)#(tab)SELECT  DIA = 1, MES, ANIO, CODIGO_CONTABLE, VALOR, INDICADOR#(lf)FROM (  #(lf)    select  FACT.RYEAR AS ANIO#(lf)#(tab)#(tab),FACT.RACCT as CODIGO_CONTABLE#(lf)#(tab)#(tab),FACT.DRCRK AS INDICADOR#(lf)#(lf)#(tab)#(tab),SUM(FACT.TSLVT)ENERO#(tab)#(lf)#(tab)#(tab),SUM(FACT.TSLVT) FEBRERO#(lf)#(tab)#(tab),SUM(FACT.TSLVT) MARZO#(lf)#(tab)#(tab),SUM(FACT.TSLVT) ABRIL#(lf)#(tab)#(tab),SUM(FACT.TSLVT) MAYO#(lf)#(tab)#(tab),SUM(FACT.TSLVT) JUNIO#(lf)#(tab)#(tab),SUM(FACT.TSLVT) JULIO#(lf)#(tab)#(tab),SUM(FACT.TSLVT) AGOSTO#(lf)#(tab)#(tab),SUM(FACT.TSLVT) SEPTIEMBRE#(lf)#(tab)#(tab),SUM(FACT.TSLVT) OCTUBRE#(lf)#(tab)#(tab),SUM(FACT.TSLVT) NOVIEMBRE#(lf)#(tab)#(tab),SUM(FACT.TSLVT) DICIEMBRE#(tab)#(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[FAGLFLEXT] FACT#(lf)#(lf)where RYEAR >= 2023#(lf)#(tab)AND FACT.RCLNT = 400#(lf)#(tab)AND FACT.RBUKRS LIKE 'EMP1'#(lf)GROUP BY  FACT.RYEAR, FACT.RACCT, FACT.DRCRK#(lf)HAVING SUM(FACT.TSLVT) <> 0#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)#(tab)--AND FACT.RACCT LIKE '1111501012' #(lf)) p  #(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  #(lf)#(lf)WHERE VALOR <> 0#(lf)#(lf)#(tab)) BASE#(lf)#(lf)"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}, {"CODIGO_CONTABLE NUM", Int64.Type}, {"ORDEN", Int64.Type}})
in
    #"Tipo cambiado";

// ===== CREDITO =====
shared #"CREDITO" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM"),
    #"dbo_CRÉDITO$" = Origen{[Schema="dbo",Item="CRÉDITO$"]}[Data],
    #"Primeros caracteres extraídos" = Table.TransformColumns(#"dbo_CRÉDITO$", {{"CÓDIGO ", each Text.Start(Text.From(_, "es-EC"), 7), type text}}),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Primeros caracteres extraídos",{{"CRÉDITO", type text}})
in
    #"Tipo cambiado";

// ===== PlanE_10CREDITO =====
shared #"PlanE_10CREDITO" =
let
    Origen = PlanE_10
in
    Origen;

// ===== Origen EstadosINGRESOS =====
shared #"Origen EstadosINGRESOS" =
let
    Origen = #"Origen Estados"
in
    Origen;

// ===== Verificacion_Ingresos =====
shared #"Verificacion_Ingresos" =
let
    Origen = #"Verificacion_Contable"
in
    Origen;

// ===== Fecha Corte =====
shared #"Fecha Corte" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="#(lf)SELECT SYSDATETIMEOFFSET() AT TIME ZONE 'UTC' AT TIME ZONE 'SA Pacific Standard Time' AS FechaHora_Quito"])
in
    Origen;

// ===== Centro Gestor =====
shared #"Centro Gestor" =
let
    /* DATOS FICTICIOS. En el modelo real esta es una tabla estatica (dimension) con el
       catalogo de centros gestores de la institucion, de columnas:
       [Codigo, Nombre, Unidad, Tipo Unidad, Tipo Servicio, Programa, Subprograma].
       El catalogo real identifica a la institucion, asi que aqui va un ejemplo reducido
       y ficticio; la dimension real se carga igual, como tabla fija o desde el DW. */
    Origen = Table.FromRows({
        {"1000","DIRECCION FICTICIA A","UNIDAD A","DIRECCION GENERAL","GENERAL","ADMINISTRACION","ADMINISTRACION"},
        {"2000","DIRECCION FICTICIA B","UNIDAD B","DIRECCION GENERAL","SOCIAL","DESARROLLO SOCIAL","DESARROLLO SOCIAL"},
        {"3000","DIRECCION FICTICIA C","UNIDAD C","DIRECCION GENERAL","OBRAS","INFRAESTRUCTURA","OBRAS PUBLICAS"}
        },
        {"Codigo","Nombre","Unidad","Tipo Unidad","Tipo Servicio","Programa","Subprograma"}),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Codigo", Int64.Type}})
in
    #"Tipo cambiado";

// ===== Proyección =====
shared #"Proyección" =
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("VZBBD4IwDIX/y847rAzGOJooBxP14JFwELKYJQhmgon+ekubmfEuS7/XvjVtGgFCisPowoSvkspqlmhlIzJktetCdMGwSnI1stMtfNnLCoI5Frsu+IGg1mlcQQMf7s8hzTLIjsvo2eOoktgQ2WYzu35zn14zmyaKzArZ1T1n7x64OzWUHAkKq0s/L5HbzYKwHuM8vZPBCtJkWC+y9/2/AUTb/gA=", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [N = _t, MesL = _t, Proyectado = _t]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Proyectado", type number}})
in
    #"Tipo cambiado";

// ===== Gasto COMPROMETIDO =====
shared #"Gasto COMPROMETIDO" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="select CONCAT('1/', MES,'/',Año COLLATE Latin1_General_BIN) FECHA#(lf)#(tab)#(tab) ,Centro ,Partida AS PARTIDA , VALOR#(lf)#(lf)FROM (#(lf)SELECT  BASE.Año, BASE.Centro, BASE.Partida#(lf)#(tab)#(tab),ENERO#(tab)#(tab)= SUM(isnull(BASE.[01],0))#(lf)#(tab)#(tab),FEBRERO#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))#(lf)#(tab)#(tab),MARZO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0)) #(lf)#(tab)#(tab),ABRIL#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0)) #(lf)#(tab)#(tab),MAYO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0)) #(lf)#(tab)#(tab),JUNIO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0)) #(lf)#(tab)#(tab),JULIO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))#(lf)#(tab)#(tab),AGOSTO#(tab)#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))#(lf)#(tab)#(tab),SEPTIEMBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))#(lf)#(tab)#(tab),OCTUBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))#(lf)#(tab)#(tab),NOVIEMBRE  = SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))#(lf)#(tab)#(tab),DICIEMBRE#(tab)= SUM(isnull(BASE.[01],0))+SUM(isnull(BASE.[02],0))+SUM(isnull(BASE.[03],0))+SUM(isnull(BASE.[04],0))+SUM(isnull(BASE.[05],0))+SUM(isnull(BASE.[06],0))+SUM(isnull(BASE.[07],0))+SUM(isnull(BASE.[08],0))+SUM(isnull(BASE.[09],0))+SUM(isnull(BASE.[10],0))+SUM(isnull(BASE.[11],0))+SUM(isnull(BASE.[12],0))#(lf)#(lf)FROM (#(lf)#(tab)SELECT Año,Centro, Partida, [01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12]#(lf)#(tab)from#(lf)#(tab)(#(lf)#(tab)#(tab)SELECT RIGHT(PERIO,2) Mes, GJAHR Año, FISTL Centro, FIPEX Partida#(tab)#(lf)#(tab)#(tab),ISNULL(SUM(TRBTR),0) Comprometido#(lf)FROM [SERVIDOR_SAP].[PRD].[prd].[FMIOI]#(lf)WHERE MANDT = 400#(lf)#(tab)AND GJAHR > 2022#(lf)#(tab)AND RLDNR LIKE '9B'#(lf)#(tab)AND FIPEX BETWEEN '500000' AND '999999'#(lf)#(tab)AND BTART IN  ('0100','0150','0600','0650','0500')#(tab)#(lf)#(tab)AND RFTYP  LIKE 'FMRES'#(lf)#(tab)AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')#(lf)#(tab)AND STATS NOT LIKE 'X'#(lf)group by  GJAHR, PERIO, FISTL, FIPEX ,RLDNR#(lf)#(tab)) FUENTE #(lf)#(tab)#(lf)#(tab)PIVOT (#(lf)#(tab)    sum(Comprometido)#(lf)#(tab)    FOR Mes IN ([01],[02],[03],[04],[05],[06],[07],[08],[09],[10],[11],[12])#(lf)#(tab)) AS pivote#(lf)) BASE#(lf)#(lf)GROUP BY BASE.Año,BASE.Centro, BASE.Partida#(lf)#(lf)#(lf)#(lf))p#(lf)UNPIVOT (  #(lf)    VALOR FOR MES IN (ENERO,FEBRERO, MARZO, ABRIL, MAYO, JUNIO, JULIO, AGOSTO, SEPTIEMBRE, OCTUBRE, NOVIEMBRE, DICIEMBRE)  #(lf)) AS unpvt  #(lf)#(lf)where VALOR <>0"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}})
in
    #"Tipo cambiado";

// ===== Gasto DEV DES =====
shared #"Gasto DEV DES" =
let
    Origen = Sql.Database("SERVIDOR_DW\DATAWAREHOUSE", "PRESUPUESTO_CONTABILIDAD_DM", [Query="SELECT #(tab) #(tab)CONCAT('1/', right(PERIO,2),'/',GJAHR COLLATE Latin1_General_BIN) FECHA#(lf)#(tab)#(tab)#(tab), FISTL Centro, FIPEX Partida#(lf)#(tab)#(tab)#(tab),CASE WHEN RLDNR = '9A' THEN 'DEVENGADO'#(lf)#(tab)#(tab)#(tab)#(tab)#(tab)WHEN RLDNR = '9B' THEN 'PAGADO'#(lf)#(tab)#(tab)#(tab)#(tab)END Proceso#(tab)#(tab)#(lf)#(tab)#(tab)#(tab), SUM(FKBTR) Devengado#(lf)#(tab)#(tab)#(tab)--,FKBTR,RLDNR,BTART,PAYFLG#(lf)#(tab)#(tab)FROM [SERVIDOR_SAP].[PRD].[prd].[FMIFIIT] #(lf)#(tab)#(tab)where #(lf)#(tab)#(tab)#(tab)MANDT  = 400#(lf)#(tab)#(tab)AND FIKRS = 'EMP1'#(lf)#(tab)#(tab)AND GJAHR > 2022#(lf)#(tab)#(tab)--AND FIPEX =    570203 #(lf)#(tab)#(tab)AND PERIO  in ('012', '011', '010' ,'009','008', '007', '006' ,'005','004', '003', '002' ,'001')#(tab)#(lf)#(tab)#(tab)AND FIPEX BETWEEN '500000' AND '999999'#(tab)#(tab)#(lf)#(tab)#(tab)AND (RLDNR = '9A' #(lf)#(tab)#(tab)#(tab)OR RLDNR = '9B'AND BTART = 0250#(lf)#(tab)#(tab)#(tab))#(lf)#(tab)#(tab)group by  GJAHR, PERIO, FISTL, FIPEX ,RLDNR"]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"FECHA", type date}})
in
    #"Tipo cambiado";

// ===== DAX INDICADORES =====
shared #"DAX INDICADORES" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Columna1", type text}}),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tipo cambiado",{"Columna1"})
in
    #"Columnas quitadas";

// ===== MET =====
shared #"MET" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Tipo cambiado" = Table.TransformColumnTypes(Origen,{{"Columna1", type text}})
in
    #"Tipo cambiado";
