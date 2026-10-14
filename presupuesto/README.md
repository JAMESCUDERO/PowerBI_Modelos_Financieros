# Presupuesto — Ejecución presupuestaria y estados financieros (SAP FM)

Modelo semántico que lee **SAP ECC (New GL + Funds Management)** a través de un **data warehouse en
SQL Server** y entrega, en un solo tablero, el **estado de situación financiera**, el **estado de
resultados**, la **ejecución del presupuesto** (codificado → comprometido → devengado → pagado) y un
bloque de **indicadores financieros**.

## Arquitectura

```text
SAP ECC (producción)
  FAGLFLEXT                 saldos de mayor (New GL), montos acumulados por período TSL01..TSL12
  FMBL                      documentos de presupuesto (asignación, reformas, traspasos)
  FMIFIIT                   partidas reales de Funds Management (devengado / recaudado / pagado)
  FMIOI                     compromisos / partidas abiertas
  SKA1 · SKAT               catálogo de cuentas y sus descripciones
  FMFCTRT                   centros gestores (fund centers)
        │  linked server  [SERVIDOR_SAP].[PRD].[prd]
        ▼
SQL Server — PRESUPUESTO_CONTABILIDAD_DM
  PlanCuentasC2026_2 · PlanP_6C · tablas de cruce          plan de cuentas y partidas (niveles 0–7)
        │  Sql.Database(...)  →  Power Query
        ▼
Power BI — modelo en estrella (104 medidas DAX)
```

Las consultas están en [`consultas_sap/`](consultas_sap/) (una por tabla del modelo), ya formateadas.

## Decisiones técnicas destacadas

- **Acumulado mensual desde columnas de período.** SAP guarda cada mes en una columna (`TSL01…TSL12`,
  `TVAL01…`): la consulta las suma acumulando (`ENERO = TSL01`, `FEBRERO = TSL01+TSL02`, …) y luego
  `UNPIVOT` las convierte en filas fecha-valor. Así el modelo tiene una serie temporal real con la que
  hacer comparaciones mes a mes y año contra año.
- **`PIVOT` + `UNPIVOT` en la misma consulta** (ingresos y gastos devengados): primero se pivota por
  período para armar el acumulado y luego se despivota a formato largo, el que consume Power BI.
- **Clasificación del proceso presupuestario en SQL.** `CASE` sobre `BUDCAT` + `PROCESS` traduce los
  códigos de SAP (`9F`/`9G`, `ENTR`/`RETN`/`SUPL`/`SEND`/`RECV`) a conceptos de negocio: presupuesto,
  reforma, traspaso de incremento/reducción.
- **Modelo en estrella.** `Origen Estados` (hechos contables) cruza con el plan de cuentas en dos
  niveles (`PlanE_5`, `PlanE_10`); `Gasto DEV`, `Ingresos DEV`, `Gastos PRE` y `Gasto COMPROMETIDO`
  cruzan con la partida presupuestaria (`PlanP_6`) y el centro gestor. Ver [`relaciones.md`](relaciones.md).
- **Indicadores financieros en DAX** sobre rangos del código contable: apalancamiento, autonomía
  financiera, índice corriente, capital de trabajo y rotación de activos, cada uno con su medida de
  texto que arma la lectura en lenguaje natural.
- **Time intelligence** con `DATEADD` para variación mensual e interanual, y barras incrementales
  (`BAR_INGRESOS`, `BAR_GASTOS`) que separan el primer mes del resto.
- **Controles de cuadre embebidos.** `VERIFIC_PRESU1`…`VERIFIC_PRESU5` validan la cadena
  codificado ≥ certificado ≥ comprometido ≥ devengado ≥ pagado y se consolidan en `UNIFICADO`
  (OK / ERROR): el tablero avisa si una cifra rompe la jerarquía presupuestaria.
- **Presupuesto "computable".** Las medidas de la tabla `MET` separan el gasto computable para metas
  (`DEVENGADO COMPUTADO`, `PORCENTAJE COMPUTADO`, `Margen`) usando la marca `COMPUTABLE` del plan.
- **Conciliación contable vs. presupuestaria.** `DEBE`/`HABER` frente a `DEBE_P`/`HABER_P`
  (`Verificacion_Contable`) para contrastar el devengado por las dos fuentes y reportar la diferencia.

## Contenido

- [`medidas.dax`](medidas.dax) — 104 medidas agrupadas por tabla.
- [`power_query/modelo.pq`](power_query/modelo.pq) — 25 consultas M.
- [`consultas_sap/`](consultas_sap/) — 12 consultas SQL contra el DW/SAP, formateadas.
- [`relaciones.md`](relaciones.md) — 22 relaciones del modelo.

## Stack

SAP ECC (FI New GL · FM) · SQL Server (T-SQL: `PIVOT`/`UNPIVOT`, `CASE`, linked server) ·
Power Query (M) · DAX · Power BI
