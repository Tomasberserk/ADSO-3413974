# Informe de Análisis y Matriz de Trazabilidad (Anexo C) — GIN (TiendApp)

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Caso de estudio:** Gestión Neiva (`GIN`) — Sistema de Inventario Inteligente y Punto de Venta (POS)  
**Metodología de análisis:** Scrum

---

## 1. Requisitos Interpretados (Funcionales y No Funcionales)

A partir de la consolidación del SRS del módulo de inventario (`03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx`) y la Normativa del Proyecto (`03-execute/14-week/02-optional-activity/Normativa_Proyecto_Inventario_Inteligente.docx`), se interpretaron **10 Requisitos Funcionales (`RF-01` a `RF-10`)** y **5 Requisitos No Funcionales (`RNF-01` a `RNF-05`)**:

- **Alcance funcional (`RF-01` a `RF-10`):** cubre el ciclo operativo completo de una tienda de barrio: autenticación multi-tienda con roles (`RF-07`), catálogo de productos y categorías personalizables (`RF-01`, `RF-02`), lectura de códigos de barras y búsqueda en tiempo real (`RF-03`, `RF-04`), registro rápido de ventas en mostrador con descuento atómico de inventario (`RF-08`, `RF-05`), alertas preventivas de stock mínimo y vencimiento de lotes a 15 días (`RF-06`, `RF-09`) y cierre diario de caja (`RF-10`).
- **Restricciones de calidad (`RNF-01` a `RNF-05`):** tiempos de respuesta `< 2 s` en listados, `< 500 ms` en búsquedas y `< 15 s` por venta (`RNF-01`); interfaz responsiva web/móvil usable sin capacitación (`RNF-02`); compatibilidad multi-navegador y móvil (`RNF-03`); aislamiento estricto de datos por tienda con rechazo `403` ante acceso cruzado (`RNF-04`); y escalabilidad hasta 10 000 productos (`RNF-05`).

---

## 2. Inventario y Enlaces a los Modelos de Análisis

| Artefacto | Ubicación relativa | Contenido verificado |
| :--- | :--- | :--- |
| Insumo SRS consolidado | [`../G1-P1-gin/00-insumo-srs-gin.md`](../G1-P1-gin/00-insumo-srs-gin.md) | 10 RF y 5 RNF trazables al fork |
| Caracterización, metodologías y plan | [`../G1-P1-gin/01-caracterizacion-y-metodologias.md`](../G1-P1-gin/01-caracterizacion-y-metodologias.md) y [`02-plan-actividades-analisis.md`](../G1-P1-gin/02-plan-actividades-analisis.md) | 4 metodologías comparadas, Scrum justificado, 8 actividades |
| Diagrama de casos de uso y matriz | [`../G1-P1-gin/04-diagrama-casos-uso.drawio`](../G1-P1-gin/04-diagrama-casos-uso.drawio) · [`.png`](../G1-P1-gin/04-diagrama-casos-uso.png) · [`03-matriz-rf-casos-uso.md`](../G1-P1-gin/03-matriz-rf-casos-uso.md) | 10 CU, 4 actores, 1 `«include»`, 3 `«extend»`, 1 generalización |
| Diagramas de actividades (2 críticos) | [`01-diagramas-actividades.drawio`](./01-diagramas-actividades.drawio) · [`01-actividad-cu06-venta-pos.png`](./01-actividad-cu06-venta-pos.png) · [`01-actividad-cu02-gestionar-productos.png`](./01-actividad-cu02-gestionar-productos.png) | Calles por actor, guardas `[...]` completas, bifurcación/unión |
| Plantillas extendidas de CU (3) | [`02-plantillas-casos-uso-extendidos.md`](./02-plantillas-casos-uso-extendidos.md) | `CU-06`, `CU-02` y `CU-08` sin detalles técnicos |
| Modelo de dominio | [`03-modelo-dominio.drawio`](./03-modelo-dominio.drawio) · [`.png`](./03-modelo-dominio.png) · [`.md`](./03-modelo-dominio.md) | 11 clases conceptuales, 0 métodos, generalización y clase asociación |
| Modelo entidad-relación (MER) | [`04-modelo-entidad-relacion.drawio`](./04-modelo-entidad-relacion.drawio) · [`.png`](./04-modelo-entidad-relacion.png) · [`.md`](./04-modelo-entidad-relacion.md) | 9 entidades en pata de gallo, N:M resuelta (`DETALLE_VENTA`), entidad débil (`LOTE`) |
| Prototipo inicial (4 pantallas) | [`05-prototipo-inicial.md`](./05-prototipo-inicial.md) | 4 pantallas Figma rotuladas con su CU |
| Lista de chequeo y ajustes | [`06-lista-chequeo-y-ajustes.md`](./06-lista-chequeo-y-ajustes.md) | 18 criterios verificables y 5 hallazgos cerrados |

---

## 3. Resultado de la Verificación y Ajustes Realizados

Al aplicar la lista de chequeo de **18 criterios** (5 de cobertura y trazabilidad) en primera revisión se obtuvieron **13 criterios cumplidos** y **5 hallazgos (`H-01` a `H-05`)**:
- Se incorporó el actor iniciador `Temporizador Diario` para el proceso automático de vencimientos (`H-01`).
- Se corrigió la dirección de la flecha `«extend»` desde `CU-04` hacia `CU-06` (`H-02`).
- Se completó la guarda de excepción `[stock insuficiente]` en el diagrama de actividades de `CU-06` (`H-03`).
- Se eliminaron términos técnicos de implementación en las plantillas extendidas de análisis (`H-04`).
- Se rotularon las 4 pantallas del prototipo Figma con sus respectivos casos de uso (`H-05`).

Tras aplicar los ajustes y ejecutar la **segunda verificación (`2026-11-27`)**, los **18 / 18 criterios (100 %)** quedaron en estado **Cumple (Sí)** y todos los enlaces relativos y referencias de trazabilidad fueron auditados sin errores, habilitando la transición limpia hacia la fase de Diseño (Guía 2).

---

## 4. Matriz de Trazabilidad Completa (Anexo C — Cobertura 100 % RF)

| Requisito | Caso de uso | Diagrama de actividades | Plantilla extendida | Clase(s) de dominio | Entidad(es) del MER | Pantalla del prototipo |
| :---: | :--- | :--- | :--- | :--- | :--- | :--- |
| **RF-01** | `CU-02 Gestionar productos` | `01-actividad-cu02` | `CU-02` *(Sec. 2)* | `Producto`, `Tienda`, `Tendero` | `PRODUCTO`, `TIENDA` | Pantalla 3/4 (`CU-02`) |
| **RF-02** | `CU-03 Gestionar categorías` | `01-actividad-cu02` *(selección)* | `CU-02` *(paso 3)* | `Categoria`, `Producto` | `CATEGORIA`, `PRODUCTO` | Pantalla 3/4 (`CU-03`) |
| **RF-03** | `CU-04 Escanear código de barras` | `01-actividad-cu06` *(flujo 1a)* | `CU-06` *(1a)*, `CU-02` *(paso 2)* | `Producto` | `PRODUCTO` (`codigo_barras`) | Pantallas 3/4 y 4/4 (`CU-04`) |
| **RF-04** | `CU-05 Buscar y filtrar inventario` | `01-actividad-cu02` *(consulta)* | `CU-02` *(1a)* | `Producto`, `Categoria` | `PRODUCTO`, `CATEGORIA` | Pantalla 3/4 (`CU-05`) |
| **RF-05** | `CU-07 Descontar stock automáticamente` | `01-actividad-cu06` *(fork/join)* | `CU-06` *(paso 6)* | `Producto`, `Lote`, `LineaVenta` | `PRODUCTO`, `LOTE`, `DETALLE_VENTA` | Pantalla 4/4 (`CU-07`) |
| **RF-06** | `CU-08 Generar alertas de inventario` | `01-actividad-cu06` *(umbral)* | `CU-08` *(Sec. 3)* | `AlertaInventario`, `Producto` | `ALERTA_INVENTARIO`, `PRODUCTO` | Pantalla 2/4 (`CU-08`) |
| **RF-07** | `CU-01 Iniciar sesión` | Precondición `CU-02`/`CU-06` | Precondición `CU-02`/`CU-06` | `Usuario`, `Tendero`, `Cajero`, `Tienda` | `USUARIO`, `TIENDA` | Pantalla 1/4 (`CU-01`) |
| **RF-08** | `CU-06 Registrar venta en POS` | `01-actividad-cu06` | `CU-06` *(Sec. 1)* | `Venta`, `LineaVenta`, `Cajero` | `VENTA`, `DETALLE_VENTA`, `USUARIO` | Pantalla 4/4 (`CU-06`) |
| **RF-09** | `CU-09 Registrar lote` y `CU-08 Alertas` | `01-actividad-cu02` *(3a)* | `CU-02` *(3a)* y `CU-08` *(Sec. 3)* | `Lote`, `Producto`, `AlertaInventario` | `LOTE`, `PRODUCTO`, `ALERTA_INVENTARIO` | Pantallas 2/4 y 3/4 (`CU-08`/`CU-09`) |
| **RF-10** | `CU-10 Generar cierre diario de caja` | — *(no crítico en G1)* | — *(trazado en G2)* | `CierreCaja`, `Venta`, `Tendero` | `CIERRE_CAJA`, `VENTA` | Pantalla 2/4 *(acceso `CU-10`)* |
