# Entrega · Guía 1 · Modelo conceptual — Producto 2 (`G1-P2-gin`)

Ruta de entrega en mi fork:
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/`

Fecha límite: **sábado 28 de noviembre de 2026 a las 6:00 a. m.**

---

## 1. Datos de la entrega

- **Producto:** P2 · Modelo de análisis y verificación
- **Usuario de GitHub del autor:** `@Tomasberserk`
- **Caso de estudio:** Gestión Neiva (`GIN`) / TiendApp — Sistema de Inventario Inteligente y Punto de Venta (POS)
- **Trabajo en equipo del año:** Sí — Equipo proyecto formativo *TiendApp / Gestión Neiva (GIN)* (los modelos, plantillas, verificación y ajustes de esta carpeta son de autoría individual de `@Tomasberserk`)

## 2. Qué reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| SRS módulo de inventario (`RF-01` a `RF-06`, estructura inicial de `Producto` con 11 atributos) | [`03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx`](../../../../../03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx) *(Semana 04)* | En equipo |
| Prototipo inicial de baja fidelidad (4 pantallas diseñadas en Figma) | [`03-execute/14-week/02-optional-activity/Mockup_Sencillo_Inventario_Inteligente.pdf`](../../../../../03-execute/14-week/02-optional-activity/Mockup_Sencillo_Inventario_Inteligente.pdf) *(Semana 14)* | Solo |

## 3. Qué ajusté

| # | Artefacto | Qué cambié y por qué | Enlace al commit |
|---|---|---|---|
| 1 | `01-diagramas-actividades.drawio` y `.png` | Incorporé la guarda `[stock insuficiente]` con retorno al carrito en `CU-06` y validé que cada decisión tenga guardas `[...]` en todas sus salidas coincidiendo 1 a 1 con las plantillas extendidas (`H-03`). Mejora el criterio de **diagramas de actividades completos** de `Rubricas_G1.md`. | Commit Día 1 (`2026-11-26`) — enlace se actualiza tras verificación Día 2 (`2026-11-27`) |
| 2 | `02-plantillas-casos-uso-extendidos.md` y `03-modelo-dominio.drawio` | Eliminé cualquier referencia a detalles técnicos de implementación (tokens JWT, tablas SQL, claves foráneas o métodos) para mantener el análisis 100 % en lenguaje de negocio (`H-04`). Mejora el criterio de **calidad del análisis conceptual** de `Rubricas_G1.md`. | Commit Día 1 (`2026-11-26`) — enlace se actualiza tras verificación Día 2 (`2026-11-27`) |
| 3 | `05-prototipo-inicial.md` y carpeta `prototipo/` | Reutilicé las 4 pantallas del wireframe de Semana 14 y rotulé visualmente cada imagen con los códigos de caso de uso y requisitos que atiende (`CU-01` a `CU-10`), logrando 0 pantallas huérfanas (`H-05`). Mejora el criterio de **prototipo trazable** de `Rubricas_G1.md`. | Commit Día 1 (`2026-11-26`) — enlace se actualiza tras verificación Día 2 (`2026-11-27`) |

## 4. Qué construí nuevo

- **Diagramas de actividades UML de 2 casos críticos (`01-diagramas-actividades.drawio`, `01-actividad-cu06-venta-pos.png`, `01-actividad-cu02-gestionar-productos.png`):** con calles por actor, guardas `[...]` completas y bifurcación/unión (fork/join) en `CU-06`.
- **3 Plantillas extendidas de casos de uso (`02-plantillas-casos-uso-extendidos.md`):** formato Anexo A completo para `CU-06`, `CU-02` y `CU-08` en lenguaje de negocio puro.
- **Modelo de dominio conceptual (`03-modelo-dominio.md`, `.drawio` y `.png`):** 11 clases conceptuales sin métodos ni claves foráneas, generalización (`Usuario` → `Tendero`, `Cajero`) y clase de asociación (`LineaVenta`).
- **Modelo Entidad-Relación en pata de gallo (`04-modelo-entidad-relacion.md`, `.drawio` y `.png`):** 9 entidades con identificadores, cardinalidad/participación explícita, relación N:M resuelta con atributos (`DETALLE_VENTA`) y entidad débil (`LOTE`).
- **Lista de chequeo de 18 criterios y registro de 5 ajustes (`06-lista-chequeo-y-ajustes.md`):** Anexos B y D con primera revisión y segunda verificación 18/18 cumplidos.
- **Informe de análisis y matriz de trazabilidad completa (`07-informe-analisis-y-trazabilidad.md`):** Anexos C y E cubriendo 10/10 RF (100 %).

## 5. Artefactos entregados

**Producto 2**

- [x] Diagramas de actividades (2 críticos — fuente editable e imágenes): [`01-diagramas-actividades.drawio`](./01-diagramas-actividades.drawio) · [`01-actividad-cu06-venta-pos.png`](./01-actividad-cu06-venta-pos.png) · [`01-actividad-cu02-gestionar-productos.png`](./01-actividad-cu02-gestionar-productos.png)
- [x] Plantillas extendidas de casos de uso (3 casos críticos): [`02-plantillas-casos-uso-extendidos.md`](./02-plantillas-casos-uso-extendidos.md)
- [x] Modelo de dominio (documento, fuente editable e imagen): [`03-modelo-dominio.md`](./03-modelo-dominio.md) · [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio) · [`03-modelo-dominio.png`](./03-modelo-dominio.png)
- [x] Modelo entidad-relación (documento, fuente editable e imagen): [`04-modelo-entidad-relacion.md`](./04-modelo-entidad-relacion.md) · [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio) · [`04-modelo-entidad-relacion.png`](./04-modelo-entidad-relacion.png)
- [x] Prototipo inicial (4 pantallas rotuladas): [`05-prototipo-inicial.md`](./05-prototipo-inicial.md) · carpeta [`prototipo/`](./prototipo/)
- [x] Lista de chequeo diligenciada (18 criterios, 5 de cobertura/trazabilidad): [`06-lista-chequeo-y-ajustes.md`](./06-lista-chequeo-y-ajustes.md#1-lista-de-chequeo-diligenciada-primera-revisión--segunda-verificación)
- [x] Registro de ajustes y segunda verificación (5 hallazgos cerrados): [`06-lista-chequeo-y-ajustes.md`](./06-lista-chequeo-y-ajustes.md#2-registro-de-ajustes-realizados-anexo-d--5-hallazgos-corregidos)
- [x] Informe de análisis (Anexo E): [`07-informe-analisis-y-trazabilidad.md`](./07-informe-analisis-y-trazabilidad.md)
- [x] Matriz de trazabilidad (Anexo C — 100 % RF): [`07-informe-analisis-y-trazabilidad.md`](./07-informe-analisis-y-trazabilidad.md#4-matriz-de-trazabilidad-completa-anexo-c--cobertura-100--rf)

## 6. Declaración de autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

Firma (usuario de GitHub y fecha): `@Tomasberserk` — `2026-11-26`

## 7. Uso de inteligencia artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Asistente de IA (Antigravity / Gemini) | Apoyo en redacción estructurada de plantillas de casos de uso, diagramas `.drawio`/`.png`, rotulación de pantallas exportadas desde Figma y validación cruzada de consistencia contra `Rubricas_G1.md`. | Verifiqué correspondencia exacta entre flujos de actividades y plantillas extendidas, comprobé la ausencia de métodos/FK en el modelo de dominio, validé la entidad débil `LOTE` y la tabla asociativa `DETALLE_VENTA` en el MER, y revisé cada tabla de trazabilidad para sustentarla de manera autónoma. |

## 8. Autocontrol antes del push

- [ ] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega *(Día 1: `2026-11-26` completado; Día 2: `2026-11-27` programado para verificación y cierre de enlaces de commit)*.
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada.
