# Holding — Consolidación financiera multi-entidad

Modelo semántico que **consolida la información financiera de varias entidades** (empresas públicas y
municipales) en un único tablero gerencial. No parte de una base transaccional común: cada entidad
entrega sus **estados financieros y su ejecución presupuestaria como plantillas Excel** en un
repositorio de SharePoint, y el modelo las integra, normaliza y compara.

## Arquitectura

```text
SharePoint — repositorio de datos interinstitucional
  /Instituciones/<entidad>/<año>/   estados financieros y presupuesto (una plantilla Excel por mes)
  /Tablas Auxiliares/               plan de cuentas (EF y presupuesto), detalles de instituciones
  /Transferencias/Convenios/        convenios y transferencias por entidad
        │  SharePoint.Files(...)  →  Power Query
        ▼
  Función de transformación parametrizada  (una misma plantilla → tabla limpia)
        ▼
Power BI — modelo en estrella alrededor de 'Lista EP' (dimensión de entidades) · 98 medidas DAX
```

Todas las consultas están en [`power_query/modelo.pq`](power_query/modelo.pq).

## La técnica central: una plantilla, una función

Cada entidad llena la misma plantilla, pero el contenido real empieza en filas y columnas variables.
En vez de una consulta por archivo, hay **una función M** (`Transformación Estados`,
`Transformacion Presupuesto`, `fx transferencias`) que recibe la hoja cruda y la deja utilizable:

1. elimina filas y columnas en blanco;
2. **transpone, limpia y vuelve a transponer** para aislar la tabla real dentro de la hoja;
3. promueve encabezados y renombra a un esquema fijo;
4. tipa las columnas.

Esa función se **invoca sobre cada archivo** del repositorio (`Table.AddColumn(... each fx([Content]))`),
y la **ruta de la carpeta** se parsea para derivar la entidad, el año y el mes
(`Text.BetweenDelimiters([Folder Path], "Instituciones/", "/")`). El resultado se cruza con el plan de
cuentas por `NestedJoin`. Añadir una entidad o un mes no cambia el modelo: basta con que el archivo
caiga en la carpeta correcta.

## Decisiones técnicas destacadas

- **Dimensión de entidades (`Lista EP`)** en el centro del modelo: todas las tablas de hechos
  (estados, presupuesto, saldos bancarios, transferencias) filtran por ella, lo que permite ver una
  entidad o el consolidado con el mismo conjunto de medidas. Ver [`relaciones.md`](relaciones.md).
- **Ranking entre entidades** con `RANKX(ALLSELECTED(...))`: ejecución presupuestaria, saldos en
  bancos e inversiones (`Ranking EP`, `Ranking SB`, `Ranking IN`).
- **Indicadores financieros** calculados sobre el plan de cuentas jerárquico: índice corriente,
  endeudamiento, dependencia financiera, liquidez y capital de trabajo, cada uno con su medida de
  texto que arma la interpretación.
- **Balance y resultado del ejercicio** a partir de los niveles del plan (`Activos`, `Pasivos`,
  `Patrimonio`, `BALANCE`, `Resultado_ejer`), con la validación de que activo = pasivo + patrimonio.
- **Seguimiento de convenios y transferencias**: monto del convenio, transferido y por transferir,
  vigencia actual/anterior y fechas, resueltos con `CALCULATE` y `CONCATENATEX`.
- **Saldos bancarios por `UNPIVOT`**: la matriz mensual de saldos se despivota a fecha-valor para
  integrarse a la línea de tiempo del modelo.

## Contenido

- [`medidas.dax`](medidas.dax) — 98 medidas agrupadas por tabla.
- [`power_query/modelo.pq`](power_query/modelo.pq) — 11 consultas M, incluida la función de plantilla.
- [`relaciones.md`](relaciones.md) — relaciones del modelo.

## Qué muestra del CV

Este modelo es el que sostiene el tablero gerencial de **entidades consolidadas a partir de las
plantillas de cada estado financiero y de repositorios SharePoint**: el modelo de datos se construyó
desde cero sobre archivos heterogéneos, sin una base transaccional común.

## Stack

SharePoint · Power Query (M: función parametrizada, `Table.Transpose`, `NestedJoin`, parseo de rutas) ·
DAX (RANKX, CALCULATE, CONCATENATEX, indicadores financieros) · Power BI
