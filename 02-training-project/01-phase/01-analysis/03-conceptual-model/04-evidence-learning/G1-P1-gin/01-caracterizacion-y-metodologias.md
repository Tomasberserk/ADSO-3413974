# Caracterización de la Solución y Selección de Metodología — GIN (TiendApp)

**Producto:** G1-P1 · Plan de análisis y casos de uso  
**Autor (GitHub):** `@Tomasberserk`  
**Caso de estudio:** Gestión Neiva (`GIN`) — Sistema de Inventario Inteligente y Punto de Venta (POS)

---

## 1. Caracterización de la Solución de Software

| Dimensión | Característica en Gestión Neiva (GIN) | Implicación para el análisis |
| :--- | :--- | :--- |
| **1. Tipo de proyecto** | Aplicación web responsiva multi-tienda (uso en celular y computador) de control de inventario, alertas de vencimiento y punto de venta (POS) para tiendas de barrio en Neiva. | Requiere validar flujos rápidos de mostrador con usuarios no técnicos y entregas tempranas verificables. |
| **2. Tamaño del equipo** | Equipo pequeño de **3 aprendices** ADSO (roles compartidos entre análisis, diseño, desarrollo y pruebas; esta entrega de análisis es individual). | No es viable una metodología con alta sobrecarga burocrática ni roles exclusivos por cada documento. |
| **3. Estabilidad de requisitos** | **Media-baja (cambiante)**: los módulos núcleo (inventario y POS) son claros, pero las reglas de negocio reales (unidades fraccionadas, alertas a 15 días, formas de pago locales) se refinan al validar con tenderos. | Se necesitan ciclos cortos de refinamiento y validación continua del modelo conceptual antes de codificar. |
| **4. Disponibilidad del cliente** | **Periódica (no tiempo completo)**: como se validó en la encuesta de campo (`08-week/TiendApp_Encuesta_Validacion (1).docx`), los tenderos de barrio atienden su negocio todo el día; pueden reunirse en sesiones cortas semanales o quincenales (12–18 min) para revisar prototipos y encuestas, pero no sentarse a diario con el equipo. | Descarta metodologías que exigen cliente residente a tiempo completo en el sitio de desarrollo. |

---

## 2. Comparación de Metodologías de Desarrollo

Se comparan **4 metodologías** (`RUP`, `Scrum`, `XP` y `RAD`) frente a criterios derivados directamente de las 4 características anteriores:

| Criterio (desde la caracterización) | RUP (Proceso Unificado) | Scrum | XP (Programación Extrema) | RAD (Desarrollo Rápido) |
| :--- | :--- | :--- | :--- | :--- |
| **Ajuste a equipo pequeño (3 personas)** | **Bajo:** exige numerosos roles y artefactos formales por fase que sobrecargan un equipo de 3 aprendices. | **Alto:** solo requiere 3 roles ligeros (Product Owner, Scrum Master, Equipo) y ceremonias breves. | **Alto:** diseñado para equipos pequeños y colaborativos. | **Medio:** requiere equipos especializados en herramientas de prototipado rápido y modelado paralelo. |
| **Manejo de requisitos cambiantes (estabilidad media-baja)** | **Medio:** es iterativo, pero sus hitos de fase (Inicio, Elaboración, Construcción, Transición) hacen más lento re-priorizar en caliente. | **Alto:** Product Backlog vivo y re-priorizable al inicio de cada Sprint (1–2 semanas). | **Alto:** abraza cambios en iteraciones muy cortas con refactorización continua. | **Medio-alto:** los prototipos revelan cambios, pero puede descuidar la solidez del modelo conceptual/datos si se acelera demasiado. |
| **Disponibilidad periódica (no continua) del tendero** | **Medio:** revisiones por fin de fase, pero demasiado espaciadas para validar usabilidad de mostrador. | **Alto:** se adapta muy bien a revisiones breves al cierre de cada Sprint (Sprint Review con mockup/incremento). | **Bajo:** la práctica clásica exige *cliente in situ* (disponible de forma continua), lo cual un tendero no puede cumplir. | **Bajo-medio:** demanda talleres intensivos JAD con participación constante del usuario final. |
| **Trazabilidad documental de análisis (exigida en SENA)** | **Muy alto:** centrado en arquitectura y UML, aunque muy pesado en documentación. | **Medio-alto:** permite incorporar artefactos UML ligeros (casos de uso, modelo de dominio, MER) dentro de la *Definition of Ready* de cada Sprint. | **Bajo:** prioriza pruebas y código sobre diagramas de análisis y trazabilidad formal. | **Bajo-medio:** se enfoca en prototipos funcionales con menor énfasis en modelado formal. |

---

## 3. Selección de Metodología y Justificación

- **Metodología seleccionada:** **Scrum** (metodología ágil iterativa e incremental, única — no híbrida).
- **Justificación con base en las características de GIN:**
  1. **Tamaño del equipo (3 personas):** Scrum elimina la sobrecarga burocrática de RUP y permite que un equipo pequeño avance en bloques enfocados y medibles.
  2. **Requisitos cambiantes del comercio minorista:** el *Product Backlog* priorizado permite atender primero los flujos críticos del tendero (productos, POS y alertas de vencimiento) e incorporar hallazgos de campo sin rehacer todo el análisis.
  3. **Disponibilidad periódica del cliente (tenderos):** la *Sprint Review* al final de cada iteración (1–2 semanas) se ajusta exactamente al tiempo limitado del tendero para validar mockups y flujos, evitando el requisito inviable de cliente a tiempo completo de XP.
  4. **Calidad y trazabilidad en análisis:** al definir los modelos UML y la lista de chequeo como criterios de salida del análisis (Sprint de Descubrimiento / Refinamiento), se garantiza rigor documental sin perder agilidad.
