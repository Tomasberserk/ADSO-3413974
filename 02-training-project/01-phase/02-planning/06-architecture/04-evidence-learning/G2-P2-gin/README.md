# README de entrega · Guía 2: Diseño de la solución — Producto 2 (`G2-P2-gin`)

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | **P2 · Modelo de datos y verificación** |
| Usuario de GitHub del autor | `@Tomasberserk` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Gestión Neiva (`GIN`) / TiendApp — Sistema de Inventario Inteligente y Punto de Venta (POS) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md) |
| Cuenta de GitHub con la que haces los commits | `@Tomasberserk` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El Excel base `SRS_TiendApp_v3.xlsx` (`RF-01`–`RF-06`) fue elaborado en equipo durante el año (equipo TiendApp / GIN, 3 integrantes); la consolidación a 10 RF, el MER de G1 y este diseño de datos son individuales. |
| ¿Qué parte del SRS es tuya? | Consolidación de 10 RF (`RF-01`–`RF-10`) y 5 RNF (`RNF-01`–`RNF-05`), normativa de Semana 14 e informe de análisis G1. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí**, todos los artefactos de datos y verificación (`B1`–`B7`) son de autoría individual de `@Tomasberserk`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **B1. Modelo conceptual ajustado** | [`01-modelo-conceptual-ajustado.md`](./01-modelo-conceptual-ajustado.md) · [`.drawio`](./01-modelo-conceptual-ajustado.drawio) · [`.png`](./01-modelo-conceptual-ajustado.png) | `G1-P2-gin/04-modelo-entidad-relacion.drawio` | Extraje la entidad `ROL`, agregué `sal_contrasena` y `autorizacion_datos` en `USUARIO`, incorporé `monto_recibido`, `cambio_entregado` y `referencia_pago` en `VENTA`, y justifiqué BD relacional PostgreSQL. |
| **B2. Modelo lógico relacional** | [`02-modelo-logico-relacional.md`](./02-modelo-logico-relacional.md) · [`.drawio`](./02-modelo-logico-relacional.drawio) · [`.png`](./02-modelo-logico-relacional.png) | Nuevo *(transformado desde B1)* | Transformé las 10 entidades en 10 tablas con PK/FK y documenté el cuadro completo de 7 reglas de transformación aplicadas (N:M, 1:N, 0..1:N, entidad débil, generalización y multivaluado). |
| **B3. Evidencia de normalización** | [`03-normalizacion-0fn-a-3fn.md`](./03-normalizacion-0fn-a-3fn.md) | Nuevo | Normalicé paso a paso `0FN→1FN→2FN→3FN` dos tablas propias (`registro_venta_pos` con llave compuesta 2FN y `catalogo_tienda_plano` con dependencias transitivas 3FN) escribiendo todas las DF y justificando la desnormalización controlada del precio congelado. |
| **B4. Diccionario de datos** | [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md) | Nuevo | Documenté el 100 % de las 10 tablas (**74 columnas**) con estándar `snake_case`, tipos, tamaños, restricciones y dominios 100 % consistentes con `schema_gin.sql` (0 discrepancias). |
| **B5. Script SQL y evidencia** | [`schema_gin.sql`](./schema_gin.sql) · [`05-script-sql-y-evidencia.md`](./05-script-sql-y-evidencia.md) · [`evidencia_ejecucion_sql.txt`](./evidencia_ejecucion_sql.txt) | Nuevo | Creé el DDL completo (10 tablas, **16 FK** con `ON DELETE`, **25 `CHECK`**, **5 `UNIQUE`**, 4 índices) y lo ejecuté sin errores en motor SQLite 3.45.3 verificando inserciones, `JOIN`, rechazo de `CHECK` y `ON DELETE RESTRICT`. |
| **B6. Políticas de seguridad y roles** | [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md) | Nuevo | Definí 9 políticas concretas (3 Integridad, 3 Confidencialidad con hash+sal `Argon2id`, TLS 1.3 y Ley 1581, 3 Disponibilidad con respaldos 3-2-1 y prueba mensual de restauración) + matriz de 4 roles × 10 tablas. |
| **B7. Lista de chequeo y hallazgos** | [`07-lista-chequeo-y-hallazgos.md`](./07-lista-chequeo-y-hallazgos.md) | Nuevo | Elaboré 24 criterios medibles con severidad aplicados sobre P1 y P2 con evidencia verificable y cerré 5 hallazgos reales (`H-01`–`H-05`). |

**Qué reutilicé:** El Modelo Entidad-Relación de 9 entidades construido en Guía 1 como punto de partida conceptual para Gestión Neiva (`GIN`).

**Qué ajusté para llevarlo al estándar de la rúbrica:** Normalicé los roles en la nueva tabla `rol`, incorporé almacenamiento seguro de credenciales (`hash_contrasena` + `sal_contrasena`) y autorización de datos personales (`Ley 1581`), añadí atributos de cobro polimórfico en `venta` y alineé al 100 % los conteos exactos entre diccionario (`74 columnas`) y SQL (`16 FK`, `25 CHECK`, `5 UNIQUE`).

**Qué hice completamente nuevo:** El modelo lógico de 10 tablas con cuadro de reglas (`B2`), la normalización formal `0FN→3FN` de 2 tablas con dependencias funcionales (`B3`), el diccionario de 74 columnas (`B4`), el script SQL ejecutado en motor real (`B5`), las 9 políticas CIA y matriz de 4 roles (`B6`), y la lista de chequeo de 24 criterios aplicada sobre P1 y P2 (`B7`).

## 4. Autoverificación de mínimos

**P2:**
- [x] B1 Modelo conceptual: ≥ 6 entidades (10), cardinalidades mín/máx y verbos, ≥ 1 N:M y ≥ 1 1:N
- [x] B2 Modelo lógico: ≥ 8 tablas (10) con PK/FK y cuadro de reglas de transformación
- [x] B3 Normalización: ≥ 2 tablas de 0FN a 3FN con dependencias funcionales (una con llave compuesta y una con dependencia transitiva)
- [x] B4 Diccionario de datos completo (100 % tablas y 74 columnas, idéntico a SQL)
- [x] B5 Script SQL ejecutado sin errores (evidencia adjunta), `ON DELETE` en ≥ 3 FK (16 FK) y ≥ 3 `CHECK` (25 `CHECK`)
- [x] B6 ≥ 6 políticas de seguridad (9, con hash y sal en contraseñas, TLS, Ley 1581 y prueba de restauración) y matriz de ≥ 3 roles (4 roles)
- [x] B7 Lista de chequeo de ≥ 20 criterios (24), con severidad, diligenciada sobre P1 y P2 con evidencia y ≥ 3 hallazgos cerrados (5)

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Día 1 (`2026-11-26`) | [`0fcc414`](https://github.com/Tomasberserk/ADSO-3413974/commit/0fcc414) — `feat(G2-P2-gin): modelos B1/B2, normalizacion 0FN-3FN, diccionario 67 cols, SQL ejecutado, seguridad CIA y chequeo 24 criterios` |
| Día 2 (`2026-11-27`) | `fix(G2-P2-gin): alinear conteos exactos B4/B5/B7 (74 cols, 16 FK, 25 CHECK, 5 UNIQUE) y corregir enlaces relativos` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en redacción del diccionario de datos, estructuración de tablas de normalización, generación de diagramas `.drawio`/`.png` y auditoría automatizada de paridad DDL en SQLite. | Comprobé mediante script automatizado que las 74 columnas y tipos del diccionario `B4` coincidieran 100 % con `schema_gin.sql`, ejecuté pruebas reales de violación `CHECK` y `ON DELETE RESTRICT`, corregí los conteos en texto y enlaces relativos, y revisé cada dependencia funcional de `B3` para sustentarla en la verificación oral. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`07-informe-analisis-y-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md)
- Carpeta de esta entrega en GitHub: `https://github.com/Tomasberserk/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-gin`
- Otros enlaces de apoyo: Carpeta P1 ([`../G2-P1-gin/`](../G2-P1-gin/)) · Repositorio de referencia del proyecto (`https://github.com/Tomasberserk/GESTION_INVENTARIO_INTELIGENTE`)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@Tomasberserk`  Fecha: `2026-11-27`
