# Plan de Actividades de Análisis (Metodología Scrum) — GIN (TiendApp)

**Producto:** G1-P1 · Plan de análisis y casos de uso  
**Autor (GitHub):** `@Tomasberserk`  
**Metodología seleccionada:** Scrum (Sprints cortos de refinamiento e incremento verificable)

---

## Cronograma y Plan de Actividades de Análisis

Las actividades están organizadas en **dos Sprints cortos de análisis** coherentes con Scrum (priorizando primero el entendimiento del dominio y los casos de uso de mayor valor para el tendero, y cerrando cada ciclo con validación mediante lista de chequeo y revisión de incremento):

| ID | Actividad de Análisis | Iteración Scrum | Prioridad | Responsable (Rol) | Fecha objetivo | Entregable verificable |
| :---: | :--- | :---: | :---: | :--- | :---: | :--- |
| **ACT-01** | Consolidar el *Product Backlog* inicial de requisitos (RF-01 a RF-10 y RNF-01 a RNF-05) a partir del SRS y la Normativa del proyecto | Sprint 1 (Descubrimiento) | Alta | Product Owner / Analista (`@Tomasberserk`) | 2026-11-26 | `00-insumo-srs-gin.md` |
| **ACT-02** | Caracterizar la solución, comparar metodologías (`RUP`, `Scrum`, `XP`, `RAD`) y definir el marco de trabajo | Sprint 1 (Descubrimiento) | Alta | Scrum Master / Analista (`@Tomasberserk`) | 2026-11-26 | `01-caracterizacion-y-metodologias.md` y `02-plan-actividades-analisis.md` |
| **ACT-03** | Modelar el diagrama de casos de uso UML (actores, frontera, `«include»` y `«extend»`) y construir la matriz Requisito → Caso de Uso | Sprint 1 (Descubrimiento) | Alta | Analista Funcional (`@Tomasberserk`) | 2026-11-26 | `04-diagrama-casos-uso.drawio`, `.png` y `03-matriz-rf-casos-uso.md` |
| **ACT-04** | Detallar los 3 casos de uso críticos (`CU-06`, `CU-02`, `CU-08`) con plantillas extendidas y 2 diagramas de actividades UML | Sprint 2 (Modelado y Verificación) | Alta | Analista Funcional (`@Tomasberserk`) | 2026-11-26 | `G1-P2-gin/01-diagramas-actividades.drawio` y `02-plantillas-casos-uso-extendidos.md` |
| **ACT-05** | Abstraer el Modelo de Dominio (clases conceptuales sin métodos) y estructurar el Modelo Entidad-Relación (notación pata de gallo) | Sprint 2 (Modelado y Verificación) | Alta | Analista de Datos (`@Tomasberserk`) | 2026-11-26 | `G1-P2-gin/03-modelo-dominio.*` y `04-modelo-entidad-relacion.*` |
| **ACT-06** | Alinear y rotular el prototipo inicial de baja fidelidad (4 pantallas Figma) con los casos de uso críticos para *Sprint Review* con tendero | Sprint 2 (Modelado y Verificación) | Media | Diseñador UI/UX (`@Tomasberserk`) | 2026-11-26 | `G1-P2-gin/05-prototipo-inicial.md` y pantallas rotuladas |
| **ACT-07** | Diseñar y aplicar la lista de chequeo (≥ 15 criterios), registrar hallazgos, ejecutar correcciones y realizar segunda verificación | Sprint 2 (Revisión e Inspección) | Alta | Analista QA (`@Tomasberserk`) | 2026-11-27 | `G1-P2-gin/06-lista-chequeo-y-ajustes.md` |
| **ACT-08** | Consolidar el Informe de Análisis (1–2 páginas), la matriz completa de trazabilidad y los `README.md` de entrega | Sprint 2 (Cierre) | Alta | Analista Líder (`@Tomasberserk`) | 2026-11-27 | `G1-P2-gin/07-informe-analisis-y-trazabilidad.md` y `README.md` |

---

## Coherencia con Scrum
- **Entregas incrementales:** Sprint 1 cierra con el alcance funcional delimitado (Casos de Uso + Matriz RF→CU) y Sprint 2 cierra con el modelo conceptual verificado y trazable.
- **Inspección y adaptación:** `ACT-07` materializa la inspección formal del incremento mediante lista de chequeo y corrección de hallazgos antes de pasar a la fase de Diseño (Guía 2).
