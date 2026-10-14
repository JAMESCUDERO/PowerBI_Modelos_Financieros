# Relaciones del modelo — Consolidación multi-entidad

| Desde (tabla · columna) | Hacia (tabla · columna) | Cardinalidad | Filtro |
|---|---|---|---|
| Data Estados · Id | Lista EP · ID | M:1 | Single |
| Data Presupuesto · ID Institucion | Lista EP · ID | M:1 | Single |
| Saldo en Bancos · ID | Lista EP · ID | M:1 | Single |
| Transferencias · ID | Lista EP · ID | M:1 | Single |
| Transferencia Acu · ID | Lista EP · ID | M:1 | Single |
| Transferencias · AÑO | Transferencia Acu · Año | M:M | Both |
