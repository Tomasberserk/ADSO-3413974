# Entrega · Guía 1 · Modelo conceptual — Producto 1 (`G1-P1-gin`)

Ruta de entrega en mi fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-gin/`

Fecha límite: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**

---

## 1. Datos de la entrega

- **Producto:** P1 · Plan de análisis y casos de uso
- **Usuario de GitHub del autor:** `@Tomasberserk`
- **Caso de estudio:** Gestión Neiva (`GIN`) / TiendApp — Sistema de Inventario Inteligente y Punto de Venta (POS)
- **Trabajo en equipo del año:** Sí — Equipo proyecto formativo *TiendApp / Gestión Neiva (GIN)* (los productos de esta entrega son de autoría individual de `@Tomasberserk`)

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| SRS módulo de inventario (`RF-01` a `RF-06`, `RNF-01` a `RNF-05`, `HU-01` a `HU-04`) | [`03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx`](../../../../../03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx) *(Semana 04)* | En equipo |
| Normativa y alcance del proyecto (problema, objetivos, alcance POS, alertas de vencimiento y cierre diario) | [`03-execute/14-week/02-optional-activity/Normativa_Proyecto_Inventario_Inteligente.docx`](../../../../../03-execute/14-week/02-optional-activity/Normativa_Proyecto_Inventario_Inteligente.docx) *(Semana 14)* | Solo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | `00-insumo-srs-gin.md` | Consolidé en un solo insumo trazable los `RF-01`–`RF-06` del Excel de Semana 04 junto con `RF-07`–`RF-10` de la Normativa de Semana 14 para alcanzar 10 RF completos (superando el mínimo de 8 RF) y separar explícitamente `RNF-01`–`RNF-05`. Mejora el criterio de **cobertura de requisitos y separación RF/RNF** de `Rubricas_G1.md`. | Commit Día 1 (`2026-11-26`) — enlace se actualiza tras verificación Día 2 (`2026-11-27`) |
| 2 | `03-matriz-rf-casos-uso.md` y `04-diagrama-casos-uso.drawio` | Agrupé operaciones CRUD en objetivos de actor (`CU-02 Gestionar productos` y `CU-03 Gestionar categorías`) evitando fragmentación técnica y agregué el actor iniciador `Temporizador Diario` para el proceso automático `CU-08`. Mejora los criterios de **arbitraje UML (Sección 7)** de `Rubricas_G1.md`. | Commit Día 1 (`2026-11-26`) — enlace se actualiza tras verificación Día 2 (`2026-11-27`) |
| 3 | `04-diagrama-casos-uso.drawio` y `03-matriz-rf-casos-uso.md` | Verifiqué la dirección exacta de cada `«include»` (Base → Incluido: `CU-06 → CU-07`) y cada `«extend»` (Extensión → Base: `CU-04 → CU-06`, `CU-08 → CU-07`, `CU-09 → CU-02`), documentando su justificación en una línea. Mejora el criterio de **relaciones UML válidas** de `Rubricas_G1.md`. | Commit Día 1 (`2026-11-26`) — enlace se actualiza tras verificación Día 2 (`2026-11-27`) |

## 4. Qué construí nuevo

- **Consolidación estructurada del SRS (`00-insumo-srs-gin.md`):** listado completo de 10 RF y 5 RNF con origen verificado en el fork.
- **Caracterización de la solución y comparación de metodologías (`01-caracterizacion-y-metodologias.md`):** análisis de los 4 aspectos de la solución, tabla comparativa de 4 metodologías (RUP, Scrum, XP y RAD) y selección justificada de Scrum.
- **Plan de actividades de análisis (`02-plan-actividades-analisis.md`):** cronograma operativo de 8 actividades en 2 Sprints con roles, fechas y entregables trazables.
- **Matriz RF → CU y justificación de relaciones (`03-matriz-rf-casos-uso.md`):** cobertura del 100 % (10/10 RF), distinción frente a 5 RNF y justificación en una línea de cada relación UML.
- **Diagrama de casos de uso editable e imagen (`04-diagrama-casos-uso.drawio` y `04-diagrama-casos-uso.png`):** 10 casos de uso, 4 actores fuera de la frontera, 1 generalización de actor, 1 `«include»` y 3 `«extend»`.

## 5. Artefactos entregados

**Producto 1**

- [x] Insumo SRS consolidado (10 RF y 5 RNF): [`00-insumo-srs-gin.md`](./00-insumo-srs-gin.md)
- [x] Caracterización de la solución: [`01-caracterizacion-y-metodologias.md`](./01-caracterizacion-y-metodologias.md#1-caracterización-de-la-solución)
- [x] Comparación de metodologías y selección justificada: [`01-caracterizacion-y-metodologias.md`](./01-caracterizacion-y-metodologias.md#2-comparación-de-metodologías-de-desarrollo)
- [x] Plan de actividades, cronograma y entregables: [`02-plan-actividades-analisis.md`](./02-plan-actividades-analisis.md)
- [x] Diagrama de casos de uso (fuente editable): [`04-diagrama-casos-uso.drawio`](./04-diagrama-casos-uso.drawio)
- [x] Diagrama de casos de uso (imagen): [`04-diagrama-casos-uso.png`](./04-diagrama-casos-uso.png)
- [x] Matriz requisito → caso de uso: [`03-matriz-rf-casos-uso.md`](./03-matriz-rf-casos-uso.md)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@Tomasberserk` — `2026-11-26`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en estructuración de plantillas Markdown, verificación cruzada contra `Rubricas_G1.md` y generación del archivo XML editable `.drawio` e imagen `.png` del diagrama de casos de uso. | Validé que los 10 RF y 5 RNF correspondieran al proyecto real GIN (TiendApp) trabajado durante el año, comprobé la dirección correcta de las relaciones `«include»` y `«extend»`, aseguré la inclusión del actor `Temporizador Diario` y revisé cada documento para poder sustentarlo oralmente sin apoyo externo. |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1: `2026-11-26` completado; Día 2: `2026-11-27` programado para verificación y cierre de enlaces de commit)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
