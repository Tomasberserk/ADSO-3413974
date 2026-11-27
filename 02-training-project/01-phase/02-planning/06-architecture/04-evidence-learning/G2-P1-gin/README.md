# README de entrega · Guía 2: Diseño de la solución — Producto 1 (`G2-P1-gin`)

## 1. Datos de la entrega

| Campo | Valor |
|---|---|
| Producto | **P1 · Artefactos de diseño** |
| Usuario de GitHub del autor | `@Tomasberserk` |
| Ficha | `3413974` |
| Caso elegido (nombre del proyecto) | Gestión Neiva (`GIN`) / TiendApp — Sistema de Inventario Inteligente y Punto de Venta (POS) |
| Enlace al informe de análisis o SRS del caso (ruta en tu fork) | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md) |
| Cuenta de GitHub con la que haces los commits | `@Tomasberserk` |

## 2. Origen del insumo y trabajo en equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El Excel base `SRS_TiendApp_v3.xlsx` (`RF-01`–`RF-06`) fue elaborado en equipo durante el año (equipo TiendApp / GIN, 3 integrantes); la consolidación a 10 RF y el informe de análisis de Guía 1 fueron individuales. |
| ¿Qué parte del SRS es tuya? | Consolidación integral de los 10 RF (`RF-01`–`RF-10`) y 5 RNF (`RNF-01`–`RNF-05`), normativa de Semana 14 e informe de análisis G1. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí**, todos los artefactos de diseño (`A1`–`A7`) son de autoría individual de `@Tomasberserk`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | No. |

## 3. Qué reutilicé, qué ajusté y qué hice nuevo

| Artefacto | Archivo en esta carpeta | Origen (ruta en mi fork o «nuevo») | Qué ajusté o agregué |
|---|---|---|---|
| **A1. Ficha de interpretación y plataforma** | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx` y `G1-P1-gin/00-insumo-srs-gin.md` | Seleccioné los 10 RF y 5 RNF con ID exacto, justifiqué Python 3.12 (FastAPI) y PostgreSQL 16 con 3 condiciones concretas del caso cada uno y corregí los enlaces relativos hacia `G1`. |
| **A2. Diagrama de clases OO** | [`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md) · [`.drawio`](./02-diagrama-clases.drawio) · [`.png`](./02-diagrama-clases.png) | `G1-P2-gin/03-modelo-dominio.drawio` *(dominio conceptual)* | Evolucioné el modelo conceptual a 14 clases OO + 1 interfaz con visibilidad, tipos, métodos con parámetros, composición (`Venta`◆`LineaVenta`, `Producto`◆`Lote`), agregación (`Categoria`◇`Producto`), herencia (`Usuario`) y polimorfismo (`IEstrategiaPago`). |
| **A3. Patrones de diseño GoF** | [`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md#4-patrones-de-diseño-gof-aplicados-a3--2-patrones-distintos-ambos--singleton) | Nuevo | Apliqué 2 patrones distintos de Singleton (`Strategy` para cobros y `Facade` para orquestar el POS) directamente en el diagrama y justifiqué su mejora en mantenibilidad. |
| **A4. Arquitectura del software** | [`03-arquitectura-software.md`](./03-arquitectura-software.md) · [`.drawio`](./03-arquitectura.drawio) · [`.png`](./03-arquitectura.png) | Nuevo | Definí arquitectura en 3 capas (sin saltos), comunicación HTTPS REST/JSON + SQL, 5 decisiones ligadas a RNF y alternativas descartadas justificadas. |
| **A5. Vista de componentes** | [`04-vista-componentes.md`](./04-vista-componentes.md) · [`.drawio`](./04-vista-componentes.drawio) · [`.png`](./04-vista-componentes.png) | Nuevo | Modelé 6 componentes cohesivos con interfaces provistas y requeridas nombradas, grafo acíclico y mapeo completo a clases y requisitos. |
| **A6. Vista de despliegue** | [`05-vista-despliegue.md`](./05-vista-despliegue.md) · [`.drawio`](./05-vista-despliegue.drawio) · [`.png`](./05-vista-despliegue.png) | Nuevo | Diseñé 4 nodos + almacenamiento de respaldo con protocolos/puertos (`HTTPS 443`, `HTTP 8000`, `TCP 5432`) y decisiones de seguridad y disponibilidad. |
| **A7. Matriz de trazabilidad** | [`06-matriz-trazabilidad.md`](./06-matriz-trazabilidad.md) | Nuevo | Mapeo bidireccional 10/10 RF y 5/5 RNF hacia clases, tablas (`10 tablas / 74 columnas`), componentes y decisiones, verificando 0 clases y 0 tablas huérfanas. |

**Qué reutilicé:** Los requisitos consolidados del proyecto formativo Gestión Neiva (`GIN`) provenientes del SRS de Semanas 04 y 11, la normativa de Semana 14 y el modelo de dominio conceptual de Guía 1.

**Qué ajusté para llevarlo al estándar de la rúbrica:** Transformé el dominio conceptual en un diagrama de clases orientado a objetos de alta cohesión (separando cobro, notificaciones y reportes de `Venta`), añadí tipos, visibilidad, métodos, polimorfismo real mediante interfaz con 2 implementaciones y audité rutas y trazabilidad cruzada contra P2.

**Qué hice completamente nuevo:** La selección tecnológica justificada (`A1`), la aplicación de los patrones GoF `Strategy` y `Facade` (`A3`), la arquitectura en 3 capas frente a RNF (`A4`), la vista de 6 componentes con interfaces (`A5`), la vista de despliegue con 4 nodos y protocolos (`A6`) y la matriz bidireccional (`A7`).

## 4. Autoverificación de mínimos

**P1:**
- [x] A1 Ficha de interpretación: ≥ 8 RF (10 RF) y ≥ 3 RNF (5 RNF) con ID; plataforma justificada
- [x] A2 Diagrama de clases: ≥ 8 clases (14 + 1 interfaz), tipos, métodos, multiplicidades, ≥ 1 composición/agregación y ≥ 1 herencia o interfaz (con ≥ 2 implementaciones)
- [x] A3 ≥ 2 patrones GoF distintos aplicados en el diagrama (`Strategy` y `Facade`, ambos distintos de Singleton)
- [x] A4 Arquitectura con diagrama y tabla de ≥ 3 RNF (5 RNF) → decisión y alternativa descartada
- [x] A5 Vista de componentes: ≥ 5 componentes (6) con interfaces provistas y requeridas
- [x] A6 Vista de despliegue: ≥ 3 nodos (4 + respaldo) con artefactos y protocolos/puertos
- [x] A7 Matriz de trazabilidad análisis → diseño (100 % RF, 0 clases huérfanas)
- [x] Fuente editable (`.drawio` + Mermaid) e imagen exportada (`.png`) de cada diagrama

## 5. Historial de commits

| Día | Qué avancé (mensaje del commit) |
|---|---|
| Día 1 (`2026-11-26`) | [`8a0ea6b`](https://github.com/Tomasberserk/ADSO-3413974/commit/8a0ea6b) — `feat(G2-P1-gin): ficha A1, diagrama clases OO con Strategy/Facade, arquitectura 3 capas, componentes, despliegue y trazabilidad` |
| Día 2 (`2026-11-27`) | `fix(G2-P1-gin): corregir enlaces relativos a G1, cerrar auditoria cruzada con P2 (74 cols) y vincular repositorio GIN` |

## 6. Uso de inteligencia artificial (declaración obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en estructuración de tablas de diseño, diagramación editable `.drawio`/Mermaid, exportación visual `.png` y auditoría automatizada contra `Rubricas_G2.md`. | Verifiqué la separación de responsabilidades en `A2` (retirando alertas y reportes de `Venta`), validé el polimorfismo de `IEstrategiaPago`, comprobé la ausencia de saltos de capa en `A4`/`A5`, corregí enlaces rotos detectados en auditoría y revisé cada decisión arquitectónica para explicarla oralmente. |

## 7. Enlaces

- Informe de análisis / SRS del caso: [`07-informe-analisis-y-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md)
- Carpeta de esta entrega en GitHub: `https://github.com/Tomasberserk/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-gin`
- Otros enlaces de apoyo: Carpeta P2 ([`../G2-P2-gin/`](../G2-P2-gin/)) · Prototipo Figma ([`EcS3ZTPM9bbIsmOtxIaBHa`](https://www.figma.com/design/EcS3ZTPM9bbIsmOtxIaBHa)) · Repositorio de referencia del proyecto (`https://github.com/Tomasberserk/GESTION_INVENTARIO_INTELIGENTE`)

## 8. Declaración de autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar cada artefacto en la verificación oral.

Usuario de GitHub: `@Tomasberserk`  Fecha: `2026-11-27`
