// Consultas Power Query (lenguaje M) del modelo, extraidas del .pbix.
// Servidores, codigo de sociedad y tenant de SharePoint reemplazados por marcadores.
// El .pbix con datos NO se publica.

// ===== Data Estados =====
shared #"Data Estados" =
let
    Origen = Table.NestedJoin(Consulta1, {"CÓDIGO CONTABLE"}, #"Plan de cuentas EF", {"CÓDIGO CONTABLE"}, "Plan de cuentas EF", JoinKind.LeftOuter),
    #"Se expandió Plan de cuentas EF" = Table.ExpandTableColumn(Origen, "Plan de cuentas EF", {"NIVEL 1", "NIVEL 2", "NIVEL 3", "NIVEL 5"}, {"NIVEL 1", "NIVEL 2", "NIVEL 3", "NIVEL 5"}),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Se expandió Plan de cuentas EF",{{"MONTO", type number}}),
    #"Dividir columna por delimitador" = Table.SplitColumn(#"Tipo cambiado", "Institución", Splitter.SplitTextByEachDelimiter({". "}, QuoteStyle.Csv, false), {"Institución.1", "Institución.2"}),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Dividir columna por delimitador",{{"Institución.1", "Id"}, {"Institución.2", "Institución"}}),
    #"Primeros caracteres insertados" = Table.AddColumn(#"Columnas con nombre cambiado", "Primeros caracteres", each Text.Start([CÓDIGO CONTABLE], 2), type text),
    #"Columnas con nombre cambiado1" = Table.RenameColumns(#"Primeros caracteres insertados",{{"Primeros caracteres", "dos digitos"}}),
    #"Valor reemplazado" = Table.ReplaceValue(#"Columnas con nombre cambiado1",0,null,Replacer.ReplaceValue,{"MONTO"}),
    #"Filas filtradas" = Table.SelectRows(#"Valor reemplazado", each [MONTO] <> null),
    #"Personalizada agregada1" = Table.AddColumn(#"Filas filtradas", "Resultado del Ejercicio", each if [dos digitos] = "62" then "Ingresos" else if [dos digitos] = "63" then "Gastos" else null),
    #"Personalizada agregada" = Table.AddColumn(#"Personalizada agregada1", "Nivel 3 Modificado", each if [dos digitos] = "62" then "Otros"
else if [dos digitos] = "63" then "Otros"
else [NIVEL 3]),
    #"Número insertado" = Table.AddColumn(#"Personalizada agregada", "NUM CODIGO", each Number.From([CÓDIGO CONTABLE]), type number),
    #"Tipo cambiado1" = Table.TransformColumnTypes(#"Número insertado",{{"NUM CODIGO", Int64.Type}})
in
    #"Tipo cambiado1";

// ===== Lista EP =====
shared #"Lista EP" =
let
    Origen = Origen,
#"Filas filtradas" = Table.SelectRows(Origen, each [Name] = "DETALLES DE INSTITUCIONES.xlsx"),
    #"Otras columnas quitadas" = Table.SelectColumns(#"Filas filtradas",{"Content"}),
    #"Personalizada agregada" = Table.AddColumn(#"Otras columnas quitadas", "Personalizado", each Excel.Workbook([Content])),
    #"Otras columnas quitadas1" = Table.SelectColumns(#"Personalizada agregada",{"Personalizado"}),
    #"Se expandió Personalizado" = Table.ExpandTableColumn(#"Otras columnas quitadas1", "Personalizado", {"Data", "Kind"}, {"Data", "Kind"}),
    #"Filas filtradas1" = Table.SelectRows(#"Se expandió Personalizado", each [Kind] = "Table"),
    #"Otras columnas quitadas2" = Table.SelectColumns(#"Filas filtradas1",{"Data"}),
    #"Se expandió Data" = Table.ExpandTableColumn(#"Otras columnas quitadas2", "Data", {"ID", "INSTITUCIÓN", "NOMBRE DE CAPETA", "NOMBRE COMPLETO DE ENTIDAD", "LOGO"}, {"ID", "INSTITUCIÓN", "NOMBRE DE CAPETA", "NOMBRE COMPLETO DE ENTIDAD", "LOGO"}),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Se expandió Data",{{"ID", type text}, {"NOMBRE COMPLETO DE ENTIDAD", type text}, {"NOMBRE DE CAPETA", type text}, {"INSTITUCIÓN", type text}}),
    #"Personalizada agregada1" = Table.AddColumn(#"Tipo cambiado", "Asiganción", each if [ID] = "01" then "Con Asignación de Recursos" else if [ID] = "02" then "Con Asignación de Recursos" else if [ID] = "03" then "Con Asignación de Recursos" else if [ID] = "04" then "Con Asignación de Recursos" else if [ID] = "05" then "Con Asignación de Recursos" else if [ID] = "06" then "Con Asignación de Recursos" else if [ID] = "07" then "Con Asignación de Recursos" else if [ID] = "08" then "Con Asignación de Recursos" else "Sin Asignación de Recursos")
in
    #"Personalizada agregada1";

// ===== DAX =====
shared #"DAX" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Columnas quitadas" = Table.RemoveColumns(Origen,{"Columna1"})
in
    #"Columnas quitadas";

// ===== Data Presupuesto =====
shared #"Data Presupuesto" =
let
    Origen = Table.NestedJoin(#"Consulta inicial", {"PARTIDA PRESUPUESTARIA"}, #"Plan de cuentas Pre", {"CODIGO"}, "Plan de cuentas Pre", JoinKind.LeftOuter),
    #"Se expandió Plan de cuentas Pre" = Table.ExpandTableColumn(Origen, "Plan de cuentas Pre", {"COMPUTABLE", "NIVEL 0", "NIVEL 1", "NIVEL 2", "NIVEL 4", "NIVEL 6 ", "NIVEL PROPIO"}, {"COMPUTABLE", "NIVEL 0", "NIVEL 1", "NIVEL 2", "NIVEL 4", "NIVEL 6 ", "NIVEL PROPIO"}),
    #"Primeros caracteres insertados" = Table.AddColumn(#"Se expandió Plan de cuentas Pre", "Primeros caracteres", each Text.Start([PARTIDA PRESUPUESTARIA], 1), type text),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Primeros caracteres insertados",{{"Primeros caracteres", Int64.Type}}),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Tipo cambiado",{{"Primeros caracteres", "ORDEN"}}),
    #"Poner En Mayúsculas Cada Palabra" = Table.TransformColumns(#"Columnas con nombre cambiado",{{"NOMBRE DE LA PARTIDA", Text.Proper, type text}, {"ACTIVIDAD PLANIFICADA", Text.Proper, type text}, {"NUEVO / ARRASTRE", Text.Proper, type text}, {"FUENTE", Text.Proper, type text}}),
    #"Poner En Mayúsculas Cada Palabra1" = Table.TransformColumns(#"Poner En Mayúsculas Cada Palabra",{{"NIVEL 0", Text.Proper, type text}, {"NIVEL 1", Text.Proper, type text}, {"NIVEL 2", Text.Proper, type text}, {"NIVEL 4", Text.Proper, type text}, {"NIVEL 6 ", Text.Proper, type text}}),
    #"Texto en mayúsculas" = Table.TransformColumns(#"Poner En Mayúsculas Cada Palabra1",{{"FUENTE", Text.Upper, type text}}),
    #"Poner En Mayúsculas Cada Palabra2" = Table.TransformColumns(#"Texto en mayúsculas",{{"NIVEL PROPIO", Text.Proper, type text}}),
    #"Personalizada agregada" = Table.AddColumn(#"Poner En Mayúsculas Cada Palabra2", "NUM PARTIDA", each [PARTIDA PRESUPUESTARIA]),
    #"Tipo cambiado1" = Table.TransformColumnTypes(#"Personalizada agregada",{{"NUM PARTIDA", Int64.Type}})
in
    #"Tipo cambiado1";

// ===== Consulta2 =====
shared #"Consulta2" =
let
    Origen = ""
in
    Origen;

// ===== Proyección =====
shared #"Proyección" =
let
    Origen = Origen,
    #"Filas filtradas" = Table.SelectRows(Origen, each [Folder Path] = "https://TENANT.sharepoint.com/sites/SITIO_FINANZAS/Repositorio de Datos Interinstitucional/Tablas Auxiliares/"),
    #"Filas filtradas1" = Table.SelectRows(#"Filas filtradas", each [Name] = "DETALLES DE INSTITUCIONES.xlsx"),
    #"Otras columnas quitadas" = Table.SelectColumns(#"Filas filtradas1",{"Content"}),
    #"Personalizada agregada" = Table.AddColumn(#"Otras columnas quitadas", "Personalizado", each Excel.Workbook([Content])),
    #"Se expandió Personalizado" = Table.ExpandTableColumn(#"Personalizada agregada", "Personalizado", {"Name", "Data", "Item", "Kind", "Hidden"}, {"Name", "Data", "Item", "Kind", "Hidden"}),
    #"Filas filtradas2" = Table.SelectRows(#"Se expandió Personalizado", each [Item] = "Proyección"),
    #"Otras columnas quitadas1" = Table.SelectColumns(#"Filas filtradas2",{"Data"}),
    #"Se expandió Data" = Table.ExpandTableColumn(#"Otras columnas quitadas1", "Data", {"Column1", "Column2", "Column3"}, {"Column1", "Column2", "Column3"}),
    #"Encabezados promovidos" = Table.PromoteHeaders(#"Se expandió Data", [PromoteAllScalars=true]),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Encabezados promovidos",{{"N", type text}, {"MesL", type text}, {"Proyectado", type number}})
in
    #"Tipo cambiado";

// ===== Saldo en Bancos =====
shared #"Saldo en Bancos" =
let
    Origen = Origen,
#"Filas filtradas" = Table.SelectRows(Origen, each [Name] = "MATRIZ DE SALDOS BANCARIOS.xlsx"),
    #"Otras columnas quitadas" = Table.SelectColumns(#"Filas filtradas",{"Content"}),
    #"Personalizada agregada" = Table.AddColumn(#"Otras columnas quitadas", "Personalizado", each Excel.Workbook([Content])),
    #"Se expandió Personalizado" = Table.ExpandTableColumn(#"Personalizada agregada", "Personalizado", {"Name", "Data", "Item", "Kind", "Hidden"}, {"Name", "Data", "Item", "Kind", "Hidden"}),
    #"Filas filtradas1" = Table.SelectRows(#"Se expandió Personalizado", each [Name] = "RESUMEN"),
    #"Otras columnas quitadas1" = Table.SelectColumns(#"Filas filtradas1",{"Data"}),
    #"Se expandió Data" = Table.ExpandTableColumn(#"Otras columnas quitadas1", "Data", {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18"}, {"Column1", "Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18"}),
    #"Filas en blanco eliminadas" = Table.SelectRows(#"Se expandió Data", each not List.IsEmpty(List.RemoveMatchingItems(Record.FieldValues(_), {"", null}))),
    #"Tabla transpuesta" = Table.Transpose(#"Filas en blanco eliminadas"),
    #"Columnas quitadas" = Table.RemoveColumns(#"Tabla transpuesta",{"Column1"}),
    #"Filas filtradas2" = Table.SelectRows(#"Columnas quitadas", each [Column2] <> null),
    #"Valor reemplazado" = Table.ReplaceValue(#"Filas filtradas2",0,null,Replacer.ReplaceValue,{"Column2", "Column3", "Column4", "Column5", "Column6", "Column7", "Column8", "Column9", "Column10", "Column11", "Column12", "Column13", "Column14", "Column15", "Column16", "Column17", "Column18", "Column19", "Column20", "Column21", "Column22", "Column23"}),
    #"Valor reemplazado1" = Table.ReplaceValue(#"Valor reemplazado",0,null,Replacer.ReplaceValue,{"Column24"}),
    #"Encabezados promovidos" = Table.PromoteHeaders(#"Valor reemplazado1", [PromoteAllScalars=true]),
    #"Otras columnas con anulación de dinamización" = Table.UnpivotOtherColumns(#"Encabezados promovidos", {"ID", "FECHA DE SALDO REPORTADO"}, "Atributo", "Valor"),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Otras columnas con anulación de dinamización",{{"Atributo", "Fecha"}}),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Columnas con nombre cambiado",{{"Fecha", type date}, {"Valor", type number}, {"ID", type text}}),
    #"Columnas con nombre cambiado1" = Table.RenameColumns(#"Tipo cambiado",{{"FECHA DE SALDO REPORTADO", "Intitución"}}),
    #"Mes insertado" = Table.AddColumn(#"Columnas con nombre cambiado1", "Mes", each Date.Month([Fecha]), Int64.Type),
    #"Personalizada agregada1" = Table.AddColumn(#"Mes insertado", "Año", each Date.Year([Fecha])),
    #"Tipo cambiado1" = Table.TransformColumnTypes(#"Personalizada agregada1",{{"Año", type text}, {"Mes", type text}}),
    #"Valor reemplazado2" = Table.ReplaceValue(#"Tipo cambiado1",0,null,Replacer.ReplaceValue,{"Valor"})
in
    #"Valor reemplazado2";

// ===== Transferencias =====
shared #"Transferencias" =
let
    Origen = Origen,
    #"Filas filtradas" = Table.SelectRows(Origen, each [Folder Path] = "https://TENANT.sharepoint.com/sites/SITIO_FINANZAS/Repositorio de Datos Interinstitucional/Transferencias/Convenios/"),
    #"Personalizada agregada" = Table.AddColumn(#"Filas filtradas", "Personalizado", each Excel.Workbook([Content])),
    #"Otras columnas quitadas" = Table.SelectColumns(#"Personalizada agregada",{"Personalizado", "Name"}),
    #"Se expandió Personalizado" = Table.ExpandTableColumn(#"Otras columnas quitadas", "Personalizado", {"Name", "Data", "Item", "Kind", "Hidden"}, {"Name.1", "Data", "Item", "Kind", "Hidden"}),
    #"Filas filtradas1" = Table.SelectRows(#"Se expandió Personalizado", each [Name.1] = "RESUMEN"),
    #"Filas filtradas2" = Table.SelectRows(#"Filas filtradas1", each [Kind] = "Sheet"),
    #"Otras columnas quitadas1" = Table.SelectColumns(#"Filas filtradas2",{"Data", "Name"}),
    #"Función personalizada invocada" = Table.AddColumn(#"Otras columnas quitadas1", "fx transferencias", each #"fx transferencias"([Data])),
    #"Columnas quitadas" = Table.RemoveColumns(#"Función personalizada invocada",{"Data"}),
    #"Se expandió fx transferencias" = Table.ExpandTableColumn(#"Columnas quitadas", "fx transferencias", {"VIGENCIA", "ID", "ENTIDAD", "FECHA INICIO DE CONVENIO", "FECHA FIN DE CONVENIO", "MONTO DEL CONVENIO", "CANT. TRANSFERENCIAS", "MONTO TRANSFERIDO", "MONTO POR TRANSFERIR", "VALOR JUSTIFICADO", "VALOR POR JUSTIFICAR"}, {"VIGENCIA", "ID", "ENTIDAD", "FECHA INICIO DE CONVENIO", "FECHA FIN DE CONVENIO", "MONTO DEL CONVENIO", "CANT. TRANSFERENCIAS", "MONTO TRANSFERIDO", "MONTO POR TRANSFERIR", "VALOR JUSTIFICADO", "VALOR POR JUSTIFICAR"}),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Se expandió fx transferencias",{{"VALOR POR JUSTIFICAR", type number}, {"VALOR JUSTIFICADO", type number}, {"MONTO POR TRANSFERIR", type number}, {"MONTO TRANSFERIDO", type number}, {"CANT. TRANSFERENCIAS", type number}, {"MONTO DEL CONVENIO", type number}, {"FECHA FIN DE CONVENIO", type text}, {"FECHA INICIO DE CONVENIO", type text}, {"ENTIDAD", type text}, {"ID", type text}, {"VIGENCIA", type text}}),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Tipo cambiado",{{"Name", "AÑO"}}),
    #"Texto extraído antes del delimitador" = Table.TransformColumns(#"Columnas con nombre cambiado", {{"AÑO", each Text.BeforeDelimiter(_, ".xlsx"), type text}})
in
    #"Texto extraído antes del delimitador";

// ===== Transferencia Acu =====
shared #"Transferencia Acu" =
let
    Origen = Origen,
    #"Filas filtradas" = Table.SelectRows(Origen, each Text.EndsWith([Folder Path], "Repositorio de Datos Interinstitucional/Transferencias/Convenios/")),
    #"Filas filtradas1" = Table.SelectRows(#"Filas filtradas", each [Extension] = ".xlsx"),
    #"Otras columnas quitadas" = Table.SelectColumns(#"Filas filtradas1",{"Name", "Content"}),
    #"Personalizada agregada" = Table.AddColumn(#"Otras columnas quitadas", "Personalizado", each Excel.Workbook([Content])),
    #"Se expandió Personalizado" = Table.ExpandTableColumn(#"Personalizada agregada", "Personalizado", {"Name", "Data", "Item", "Kind", "Hidden"}, {"Name.1", "Data", "Item", "Kind", "Hidden"}),
    #"Filas filtradas2" = Table.SelectRows(#"Se expandió Personalizado", each [Kind] = "Sheet"),
    #"Filas filtradas3" = Table.SelectRows(#"Filas filtradas2", each [Name.1] <> "RESUMEN" and not Text.EndsWith([Name.1], "MUNICIPAL")),
    #"Columnas quitadas" = Table.RemoveColumns(#"Filas filtradas3",{"Content", "Item", "Kind", "Hidden"}),
    #"Función personalizada invocada" = Table.AddColumn(#"Columnas quitadas", "fx trans", each #"fx trans"([Data])),
    #"Columnas quitadas1" = Table.RemoveColumns(#"Función personalizada invocada",{"Data"}),
    #"Se expandió fx trans" = Table.ExpandTableColumn(#"Columnas quitadas1", "fx trans", {"CANT. TRANSFERENCIAS", "MONTO TRANSFERIDO", "MONTO POR TRANSFERIR", "N° INFORME PFPI", "N° OFICIO AUTORIZACIÓN", "FECHA DE AUTORIZACIÓN", "FECHA DE TRANSFERENCIA"}, {"CANT. TRANSFERENCIAS", "MONTO TRANSFERIDO", "MONTO POR TRANSFERIR", "N° INFORME PFPI", "N° OFICIO AUTORIZACIÓN", "FECHA DE AUTORIZACIÓN", "FECHA DE TRANSFERENCIA"}),
    #"Columnas con nombre cambiado" = Table.RenameColumns(#"Se expandió fx trans",{{"Name", "Año"}}),
    #"Texto extraído antes del delimitador" = Table.TransformColumns(#"Columnas con nombre cambiado", {{"Año", each Text.BeforeDelimiter(_, ".xlsx"), type text}}),
    #"Dividir columna por posiciones" = Table.SplitColumn(#"Texto extraído antes del delimitador", "Name.1", Splitter.SplitTextByPositions({0, 2, 3}), {"Name.1.1", "Name.1.2", "Name.1.3"}),
    #"Columnas quitadas2" = Table.RemoveColumns(#"Dividir columna por posiciones",{"Name.1.2"}),
    #"Columnas con nombre cambiado1" = Table.RenameColumns(#"Columnas quitadas2",{{"Name.1.1", "ID"}, {"Name.1.3", "NOMBRE"}}),
    #"Columnas quitadas3" = Table.RemoveColumns(#"Columnas con nombre cambiado1",{"CANT. TRANSFERENCIAS"}),
    #"Filas filtradas4" = Table.SelectRows(#"Columnas quitadas3", each [#"N° INFORME PFPI"] <> "FIJO"),
    #"Filas filtradas5" = Table.SelectRows(#"Filas filtradas4", each [#"N° INFORME PFPI"] <> "N° INFORME PFPI"),
    #"Tipo cambiado" = Table.TransformColumnTypes(#"Filas filtradas5",{{"FECHA DE AUTORIZACIÓN", type date}, {"FECHA DE TRANSFERENCIA", type date}, {"N° OFICIO AUTORIZACIÓN", type text}, {"N° INFORME PFPI", type text}, {"MONTO POR TRANSFERIR", type number}, {"MONTO TRANSFERIDO", type number}, {"Año", type text}}),
    #"Últimos caracteres insertados" = Table.AddColumn(#"Tipo cambiado", "Últimos caracteres", each Text.End([NOMBRE], 3), type text),
    #"Columnas con nombre cambiado2" = Table.RenameColumns(#"Últimos caracteres insertados",{{"Últimos caracteres", "3 final"}}),
    #"Personalizada agregada1" = Table.AddColumn(#"Columnas con nombre cambiado2", "ESTADO", each if [3 final] = "ANT" then "ANTERIOR" else "ACTUAL"),
    #"Columnas quitadas4" = Table.RemoveColumns(#"Personalizada agregada1",{"3 final"}),
    #"Tipo cambiado1" = Table.TransformColumnTypes(#"Columnas quitadas4",{{"ESTADO", type text}})
in
    #"Tipo cambiado1";

// ===== Corte =====
shared #"Corte" =
let
    // Obtener fecha y hora actuales en UTC
    FechaHoraUTC = DateTimeZone.UtcNow(),

    // Aplicar la zona horaria deseada (por ejemplo, -5 horas)
    FechaHoraZona = DateTimeZone.SwitchZone(FechaHoraUTC, -5),

    // Quitar información de zona horaria si solo quieres fecha/hora
    FechaHora = DateTimeZone.RemoveZone(FechaHoraZona)
in
    FechaHora;

// ===== MET =====
shared #"MET" =
// tabla auxiliar vacia / marcador del modelo
let
    Origen = Table.FromRows(Json.Document(Binary.Decompress(Binary.FromText("i44FAA==", BinaryEncoding.Base64), Compression.Deflate)), let _t = ((type nullable text) meta [Serialized.Text = true]) in type table [Columna1 = _t]),
    #"Columnas quitadas" = Table.RemoveColumns(Origen,{"Columna1"})
in
    #"Columnas quitadas";
