# A1 · Ficha de Interpretación del Análisis y Plataforma Tecnológica — GIN (TiendApp)

**Producto:** G2-P1 · Artefactos de diseño  
**Autor (GitHub):** `@Tomasberserk`  
**Caso de estudio:** Gestión Neiva (`GIN`) / TiendApp — Sistema de Inventario Inteligente y Punto de Venta (POS)  
**Insumo de análisis:** [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-gin/00-insumo-srs-gin.md`](../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-gin/00-insumo-srs-gin.md) y [`G1-P2-gin/07-informe-analisis-y-trazabilidad.md`](../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-gin/07-informe-analisis-y-trazabilidad.md)

---

## 1. Requisitos Interpretados del Análisis (10 RF y 5 RNF)

### 1.1 Requisitos Funcionales Seleccionados (10 RF — mínimo exigido: 8)

| ID | Requisito Funcional | Actor(es) | Prioridad |
| :---: | :--- | :--- | :---: |
| **RF-01** | Gestión completa de productos (crear, listar, editar, desactivar) con precios de costo/venta, unidad de medida, stock actual y stock mínimo. | Tendero | Alta |
| **RF-02** | Categorización personalizable de productos por tienda (nombre, color e ícono). | Tendero | Media |
| **RF-03** | Lectura de códigos de barras mediante cámara móvil o lector físico (con ingreso manual alterno). | Tendero, Cajero, Cámara/Lector | Alta |
| **RF-04** | Búsqueda y filtrado en tiempo real por nombre, código de barras o categoría. | Tendero, Cajero | Alta |
| **RF-05** | Descuento automático e inmediato del stock (y del lote FEFO en perecederos) al confirmar una venta. | Cajero, Tendero *(vía POS)* | Alta |
| **RF-06** | Generación automática de alertas de stock bajo cuando `cantidad_actual <= stock_minimo`. | Sistema / Tendero | Alta |
| **RF-07** | Autenticación segura de usuarios y control de acceso por rol (`TENDERO` / `CAJERO`) aislado por tienda. | Tendero, Cajero | Alta |
| **RF-08** | Registro de venta en Punto de Venta (POS) con carrito, cálculo de subtotales/cambio y selección de método de pago (efectivo o transferencia). | Cajero, Tendero | Alta |
| **RF-09** | Registro de lotes con fecha de vencimiento para perecederos y generación de alertas preventivas a ≤ 15 días. | Tendero, Temporizador Diario | Alta |
| **RF-10** | Generación de cierre diario de caja consolidando totales por método de pago y ganancia estimada. | Tendero | Media |

### 1.2 Requisitos No Funcionales con Métrica (5 RNF — mínimo exigido: 3)

| ID | Categoría | Descripción y métrica verificable |
| :---: | :--- | :--- |
| **RNF-01** | Rendimiento | Listado de inventario `< 2 s`, búsqueda y filtrado `< 500 ms`, escaneo `< 1 s`, registro completo de venta en POS `< 15 s`. |
| **RNF-02** | Usabilidad | Interfaz web responsiva (móvil y escritorio) operable por tenderos sin capacitación técnica previa. |
| **RNF-03** | Compatibilidad | Operación en Chrome, Edge, Firefox y Safari móviles/escritorio sin instalación nativa obligatoria. |
| **RNF-04** | Seguridad y aislamiento | Contraseñas almacenadas con hash y sal, comunicaciones cifradas sobre TLS (HTTPS), autorización por rol y bloqueo `403` ante intento de acceso cruzado entre tiendas. |
| **RNF-05** | Escalabilidad | Soporte de hasta `10 000` productos activos por tienda manteniendo tiempos de búsqueda `< 500 ms`. |

---

## 2. Actores y Restricciones del Entorno

| Dimensión | Detalle concreto del caso GIN (TiendApp) |
| :--- | :--- |
| **Actores** | **Tendero (Administrador):** gestiona catálogo, categorías, lotes, alertas y cierres de caja, y también puede vender en POS. **Cajero:** autentica sesión, consulta inventario y registra ventas. **Cámara / Lector:** captura códigos de barras. **Temporizador Diario:** dispara a las 06:00 a. m. la revisión de vencimientos (`≤ 15 días`). |
| **Restricciones operativas y de presupuesto** | Tiendas de barrio en Neiva con presupuesto reducido (infraestructura en un único servidor VPS modesto o contenedores ligeros); uso frecuente desde celulares de gama media y PCs de mostrador; operación diaria continua con conexiones a internet domésticas; mantenimiento a cargo de un equipo pequeño (1–3 desarrolladores ADSO). |

---

## 3. Plataforma Tecnológica Justificada

### 3.1 Lenguaje Orientado a Objetos Seleccionado: **Python 3.12 (con FastAPI + Pydantic)**

| # | Condición concreta del caso GIN | Cómo la satisface Python 3.12 (OO + FastAPI) |
| :-: | :--- | :--- |
| 1 | **Diseño OO tipado y mantenible para equipo pequeño** | Soporta clases, herencia, clases abstractas/interfaces (`ABC`/`Protocol`), encapsulamiento y tipado estático verificable con `typing` y Pydantic, permitiendo implementar limpiamente los patrones Estrategia y Fachada sin verbosidad excesiva. |
| 2 | **Rendimiento bajo presupuesto de servidor modesto (`RNF-01`)** | FastAPI sobre Uvicorn (ASGI asíncrono) entrega latencias de API `< 50 ms` con bajo consumo de RAM en un solo VPS económico, cumpliendo el umbral `< 500 ms` de búsqueda y `< 15 s` por venta. |
| 3 | **Ecosistema maduro para seguridad, BD relacional y tareas programadas (`RNF-04`, `RF-09`)** | Librerías probadas para hashing seguro con sal (`Argon2id`/`bcrypt`), drivers nativos PostgreSQL (`psycopg`/`SQLAlchemy`), generación de reportes PDF/CSV para `RF-10` y programación del `Temporizador Diario` de vencimientos. |

### 3.2 Tipo de Base de Datos Seleccionado: **Base de Datos Relacional — PostgreSQL 16**

| # | Condición concreta del caso GIN | Cómo la satisface PostgreSQL 16 (Relacional) |
| :-: | :--- | :--- |
| 1 | **Consistencia transaccional ACID en ventas y descuento de stock (`RF-05`, `RF-08`)** | Una venta y el descuento de inventario en `producto`/`lote` deben ejecutarse como una transacción atómica: si falla una línea o falta stock, se hace `ROLLBACK` evitando inventarios negativos o ventas sin descuento. |
| 2 | **Integridad referencial estricta y aislamiento multi-tienda (`RNF-04`)** | Las relaciones entre `tienda`, `usuario`, `categoria`, `producto`, `lote`, `venta`, `detalle_venta`, `alerta_inventario` y `cierre_caja` son altamente estructuradas; llaves foráneas, `UNIQUE` compuestos por tienda y restricciones `CHECK` protegen la integridad directamente en el motor. |
| 3 | **Precisión financiera e índices de alto rendimiento (`RF-10`, `RNF-01`, `RNF-05`)** | Soporta tipo exacto `NUMERIC/DECIMAL` para precios y cierres de caja (sin errores de punto flotante) e índices B-Tree / trigrama para búsquedas `< 500 ms` con `10 000` productos. |

*(En la validación local del script DDL del Producto 2 se verifica compatibilidad estándar ANSI SQL ejecutándolo en motor real SQLite 3 con `PRAGMA foreign_keys = ON`, manteniendo tipos ANSI portables a PostgreSQL 16.)*

---

## 4. Lista de Entregables de Diseño Definidos (Guía 2)

| Producto | Código | Entregable | Archivo principal |
| :---: | :---: | :--- | :--- |
| **P1** | `A1` | Ficha de interpretación y plataforma tecnológica | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) |
| **P1** | `A2` | Diagrama de clases OO (≥ 8 clases, composición, herencia e interfaz polimórfica) | [`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md) · `.drawio` · `.png` |
| **P1** | `A3` | Aplicación y justificación de ≥ 2 patrones GoF (`Strategy` y `Facade`) | [`02-diagrama-clases-y-patrones.md`](./02-diagrama-clases-y-patrones.md) |
| **P1** | `A4` | Arquitectura de software (3 capas) y decisiones frente a RNF | [`03-arquitectura-software.md`](./03-arquitectura-software.md) · `.drawio` · `.png` |
| **P1** | `A5` | Vista de componentes con interfaces provistas y requeridas | [`04-vista-componentes.md`](./04-vista-componentes.md) · `.drawio` · `.png` |
| **P1** | `A6` | Vista de despliegue con nodos, artefactos y protocolos/puertos | [`05-vista-despliegue.md`](./05-vista-despliegue.md) · `.drawio` · `.png` |
| **P1** | `A7` | Matriz de trazabilidad bidireccional análisis → diseño | [`06-matriz-trazabilidad.md`](./06-matriz-trazabilidad.md) |
| **P2** | `B1–B7` | Modelo conceptual ajustado, lógico, normalización 0FN–3FN, diccionario, script SQL ejecutado, políticas de seguridad y lista de chequeo ≥ 20 criterios | Carpeta [`../G2-P2-gin/`](../G2-P2-gin/) |
