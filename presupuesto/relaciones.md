# Relaciones del modelo — Ejecución presupuestaria (SAP FM)

| Desde (tabla · columna) | Hacia (tabla · columna) | Cardinalidad | Filtro |
|---|---|---|---|
| Origen Estados · CODIGO_CONTABLE_5 | PlanE_5 · CÓDIGO CONTABLE | M:1 | Single |
| Origen Estados · CODIGO_CONTABLE | PlanE_10 · NumeroCuenta | M:1 | Single |
| Gastos PRE · FUNDSCTR | Centro Gestor SAP · Codigo | M:1 | Single |
| Gasto DEV · Centro | Centro Gestor SAP · Codigo | M:1 | Single |
| Gastos PRE · CMMTITEM | PlanP_6 · CODIGO | M:1 | Single |
| Gasto DEV · PARTIDA | PlanP_6 · CODIGO | M:1 | Single |
| Ingresos PRE · CMMTITEM | PlanP_6 · CODIGO | M:1 | Single |
| Ingresos DEV · PARTIDA | PlanP_6 · CODIGO | M:1 | Single |
| DEBITO · DÉBITO | Gasto DEV · PARTIDA | M:M | Both |
| PlanE_10 · CÓDIGO CONTABLE | DEBITO · CÓDIGO CONTABLE | M:1 | Both |
| Verificacion_Contable · CODIGO_CONTABLE | PlanE_10 · NumeroCuenta | M:1 | Single |
| Ingresos DEV · PARTIDA | CREDITO · CRÉDITO | M:M | Both |
| PlanE_10CREDITO · CÓDIGO CONTABLE | CREDITO · CÓDIGO  | M:1 | Single |
| Origen EstadosINGRESOS · CODIGO_CONTABLE | PlanE_10CREDITO · NumeroCuenta | M:1 | Single |
| Verificacion_Ingresos · CODIGO_CONTABLE | PlanE_10CREDITO · NumeroCuenta | M:1 | Single |
| Gasto DEV · Centro | Centro Gestor · Codigo | M:1 | Single |
| Gastos PRE · FUNDSCTR | Centro Gestor · Codigo | M:1 | Single |
| Gasto COMPROMETIDO · Centro | Centro Gestor SAP · Codigo | M:1 | Single |
| Gasto COMPROMETIDO · Centro | Centro Gestor · Codigo | M:1 | Single |
| Gasto COMPROMETIDO · PARTIDA | PlanP_6 · CODIGO | M:1 | Single |
| Gasto DEV DES · Partida | PlanP_6 · CODIGO | M:1 | Single |
| Gasto DEV DES · Centro | Centro Gestor SAP · Codigo | M:1 | Single |
