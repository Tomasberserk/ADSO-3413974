# Lista de Chequeo de Validación (Anexo B) y Registro de Ajustes (Anexo D) — GIN (TiendApp)

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Total de criterios verificables:** **18 criterios** (mínimo exigido: 15), de los cuales **5 son de cobertura y trazabilidad** (mínimo exigido: 3).

---

## 1. Lista de Chequeo Diligenciada (Primera Revisión → Segunda Verificación)

| # | Criterio verificable (Sí / No) | Tipo | Artefacto | Rev. 1 | Evidencia verificable | Hallazgo | Rev. 2 |
| :-: | :--- | :--- | :--- | :-: | :--- | :---: | :-: |
| 1 | ¿Al menos el 90 % de los requisitos funcionales del SRS aparecen en al menos un caso de uso? | **Cobertura / Trazabilidad** | Matriz RF→CU | Sí | `G1-P1-gin/03-matriz-rf-casos-uso.md`: 10/10 RF (100 %). | — | Sí |
| 2 | ¿Se distinguen explícitamente los RF de los RNF sin incluir RNF como casos de uso? | Calidad requisitos | Matriz RF→CU | Sí | Sección 2 de `03-matriz-rf-casos-uso.md` separa `RNF-01` a `RNF-05`. | — | Sí |
| 3 | ¿El diagrama de casos de uso cuenta con ≥ 8 casos con nombre verbo + objeto y sin fragmentación CRUD injustificada? | Notación UML | Diagrama CU | Sí | 10 CU (`CU-01` a `CU-10`); `CU-02` y `CU-03` agrupan CRUD. | — | Sí |
| 4 | ¿Están todos los actores fuera de la frontera del sistema y cada proceso automático tiene iniciador explícito? | Notación UML | Diagrama CU | **No** | En borrador inicial `CU-08` (alertas de vencimiento) no mostraba al actor `Temporizador Diario`. | **H-01** | **Sí** |
| 5 | ¿Cada relación `«include»` y `«extend»` tiene dirección correcta y justificación escrita en 1 línea? | Notación UML | Diagrama CU | **No** | En borrador inicial la flecha `«extend»` de `CU-04` apuntaba desde `CU-06` hacia `CU-04` (invertida). | **H-02** | **Sí** |
| 6 | ¿El diagrama de casos de uso se entrega con fuente editable (`.drawio`) e imagen (`.png`) legible? | Entregable | Diagrama CU | Sí | `G1-P1-gin/04-diagrama-casos-uso.drawio` y `.png`. | — | Sí |
| 7 | ¿Existen ≥ 2 diagramas de actividades de casos críticos con inicio, fin, calles por actor y guardas `[...]` en todas las salidas? | Actividades | Diagramas Activ. | **No** | En borrador de `CU-06` faltaba la rama `[stock insuficiente]` con retorno al carrito. | **H-03** | **Sí** |
| 8 | ¿Cada rama alterna o de excepción del diagrama de actividades coincide con la plantilla extendida del mismo caso? | **Cobertura / Trazabilidad** | Actividades ↔ Plantillas | Sí | `CU-06` (`2a`, `5a`, `5b`) y `CU-02` (`3a`, `4a`, `4b`, `5a`) coinciden 1 a 1. | — | Sí |
| 9 | ¿Existen ≥ 3 plantillas extendidas con precondiciones, ≥ 6 pasos, ≥ 1 flujo alterno, ≥ 1 excepción y postcondiciones? | Plantillas | Plantillas CU | Sí | `02-plantillas-casos-uso-extendidos.md` (`CU-06`, `CU-02`, `CU-08`). | — | Sí |
| 10 | ¿Las plantillas extendidas y el modelo de dominio están libres de detalles de implementación (SQL, tablas, frameworks)? | Regla de análisis | Plantillas / Dominio | **No** | En borrador de `CU-02` se mencionaba inicialmente "token JWT" y "tabla `categorias`" en el flujo principal. | **H-04** | **Sí** |
| 11 | ¿El modelo de dominio incluye ≥ 8 clases conceptuales, ≥ 5 con ≥ 2 atributos de negocio, multiplicidades, 0 métodos y 0 claves foráneas? | Dominio | Modelo Dominio | Sí | `03-modelo-dominio.drawio`: 11 clases conceptuales, 0 métodos, 0 FK. | — | Sí |
| 12 | ¿El modelo de dominio incluye al menos 1 generalización o clase de asociación? | Dominio | Modelo Dominio | Sí | Generalización `Usuario`→(`Tendero`, `Cajero`) y clase de asociación `LineaVenta`. | — | Sí |
| 13 | ¿Todo concepto nombrado en las plantillas extendidas existe en el modelo de dominio? | **Cobertura / Trazabilidad** | Plantillas ↔ Dominio | Sí | `Tienda`, `Usuario`, `Categoria`, `Producto`, `Lote`, `Venta`, `LineaVenta`, `AlertaInventario` coinciden. | — | Sí |
| 14 | ¿El MER declara notación, incluye ≥ 6 entidades con identificadores, cardinalidad/participación, ≥ 1 N:M resuelta con atributos y ≥ 1 entidad débil? | Datos (MER) | MER | Sí | `04-modelo-entidad-relacion.drawio`: pata de gallo, 9 entidades, `DETALLE_VENTA` (N:M), `LOTE` (débil). | — | Sí |
| 15 | ¿El prototipo inicial incluye ≥ 3 pantallas y todas están rotuladas con el caso de uso que atienden (0 huérfanas)? | **Cobertura / Trazabilidad** | Prototipo | **No** | El PDF de Week 14 no traía los códigos `CU-01`..`CU-10` rotulados explícitamente en cada pantalla. | **H-05** | **Sí** |
| 16 | ¿La matriz de trazabilidad (Anexo C) traza ≥ 90 % de los RF hasta CU, plantilla/actividad, clase de dominio, entidad MER y pantalla? | **Cobertura / Trazabilidad** | Trazabilidad | Sí | `07-informe-analisis-y-trazabilidad.md`: 10/10 RF (100 %) trazados. | — | Sí |
| 17 | ¿El informe de análisis tiene entre 1 y 2 páginas e incluye las 4 secciones obligatorias? | Documentación | Informe | Sí | `07-informe-analisis-y-trazabilidad.md` (requisitos, enlaces, verificación y ajustes). | — | Sí |
| 18 | ¿Los `README.md` declaran reutilización, ajustes, IA y omiten datos personales reales (solo usuario GitHub)? | Autoría y privacidad | READMEs | Sí | Ambos `README.md` diligenciados únicamente con `@Tomasberserk`. | — | Sí |

---

## 2. Registro de Ajustes Realizados (Anexo D — 5 Hallazgos Corregidos)

| # | Hallazgo (criterio que no cumplía) | Artefacto | Antes | Después | Commit de corrección | ¿Verificado de nuevo? |
| :-: | :--- | :--- | :--- | :--- | :--- | :-: |
| **H-01** | Criterio 4: `CU-08` (alertas automáticas de vencimiento) no mostraba actor iniciador. | `G1-P1-gin/04-diagrama-casos-uso.drawio` | `CU-08` aparecía conectado solo como salida pasiva hacia el Tendero sin disparador temporal. | Se agregó el actor primario `Temporizador Diario` fuera de la frontera asociado a `CU-08`, además de la extensión condicional desde `CU-07`. | *(Se completa con hash del commit de ajuste Día 2)* | Sí |
| **H-02** | Criterio 5: Dirección invertida de la flecha `«extend»` entre `CU-04` y `CU-06`. | `G1-P1-gin/04-diagrama-casos-uso.drawio` y `03-matriz-rf-casos-uso.md` | La flecha apuntaba de `CU-06` hacia `CU-04` confundiendo `«extend»` con `«include»`. | Se corrigió la dirección de `CU-04 Escanear código de barras` ──`«extend»`──> `CU-06 Registrar venta en POS` y se documentó la justificación en 1 línea. | *(Se completa con hash del commit de ajuste Día 2)* | Sí |
| **H-03** | Criterio 7: Decisión sin rama completa de excepción en diagrama de actividades de `CU-06`. | `G1-P2-gin/01-diagramas-actividades.drawio` | El rombo de validación de stock solo modelaba el camino feliz `[stock suficiente]`. | Se añadió la guarda `[stock insuficiente]` con mensaje al Cajero y retorno al carrito, coincidiendo con la excepción `2a` de la plantilla extendida. | *(Se completa con hash del commit de ajuste Día 2)* | Sí |
| **H-04** | Criterio 10: Detalles de implementación técnica dentro del análisis funcional. | `G1-P2-gin/02-plantillas-casos-uso-extendidos.md` | El borrador mencionaba "sesión JWT" y "tabla `categorias`" en pasos de `CU-02`. | Se reescribieron los pasos en lenguaje de negocio puro ("usuario autenticado", "catálogo de categorías de la tienda") sin términos de implementación. | *(Se completa con hash del commit de ajuste Día 2)* | Sí |
| **H-05** | Criterio 15: Pantallas del prototipo sin rotulación de casos de uso. | `G1-P2-gin/05-prototipo-inicial.md` y carpeta `prototipo/` | Las 4 pantallas exportadas desde Figma en Week 14 solo mostraban nombre de vista sin código de CU. | Se rotularon las 4 pantallas con sus casos de uso (`CU-01`, `CU-08`/`CU-10`, `CU-02`–`CU-05`/`CU-09`, `CU-06`–`CU-07`) garantizando 0 pantallas huérfanas. | *(Se completa con hash del commit de ajuste Día 2)* | Sí |
