# PowerBI_Modelos_Financieros

Dos **modelos semánticos de Power BI** de producción del área financiera, documentados pieza por
pieza: **medidas DAX**, **consultas Power Query (M)**, el **SQL embebido contra SAP** y el **modelo de
relaciones**. Son el motor de datos detrás de tableros gerenciales; aquí se publica cómo están
construidos, no el archivo.

| Modelo | Qué resuelve | Origen | Medidas |
|---|---|---|---|
| [`presupuesto/`](presupuesto/) | Ejecución presupuestaria y estados financieros de una entidad | SAP ECC (New GL + Funds Management) → SQL Server (DW) → Power BI | 104 |
| [`holding/`](holding/) | Consolidación financiera de múltiples entidades en un tablero gerencial | Plantillas Excel en repositorios SharePoint → Power BI | 98 |

## Qué contiene cada carpeta

- `medidas.dax` — todas las medidas del modelo, agrupadas por su tabla, tal como están en el modelo.
- `power_query/modelo.pq` — las consultas M (ingesta y transformación).
- `consultas_sap/` *(solo en `presupuesto/`)* — el SQL embebido en Power Query, desescapado y formateado
  para leerse: una consulta por tabla.
- `relaciones.md` — el esquema en estrella (tabla · columna → tabla · columna, cardinalidad y dirección de filtro).

## Datos y confidencialidad

> **No se publica ningún `.pbix` ni ningún dato.** Solo las definiciones del modelo (DAX, M, SQL,
> relaciones), extraídas de los archivos de producción.
>
> Se reemplazaron por marcadores: el servidor del data warehouse (`SERVIDOR_DW`), el servidor SAP
> enlazado (`SERVIDOR_SAP`), el código de sociedad SAP (`EMP1`) y el tenant/sitio de SharePoint
> (`TENANT` / `SITIO_FINANZAS`). La dimensión de centros gestores del modelo de presupuesto es, en
> producción, el catálogo real de la institución; aquí se reemplazó por un **catálogo de ejemplo
> ficticio** (marcado como tal en el código). Una tabla informal se renombró a `Verificacion_Contable`.
>
> Los nombres de objetos (tablas como `DAX`, `DAX GASTOS`, etc.) se conservan como fueron creados: en
> Power BI es común usar tablas sin columnas como contenedores de medidas por área.

## Stack

SAP ECC (FI New GL · Funds Management) · SQL Server (T-SQL, linked server, `PIVOT`/`UNPIVOT`) ·
Power Query (M: función de transformación parametrizada, ingesta desde SharePoint) ·
DAX (CALCULATE, SUMX, time intelligence, RANKX, medidas de texto) · Power BI
