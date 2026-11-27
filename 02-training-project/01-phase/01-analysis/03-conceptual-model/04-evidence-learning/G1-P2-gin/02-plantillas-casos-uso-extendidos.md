# Plantillas Extendidas de Casos de Uso Críticos (Anexo A) — GIN (TiendApp)

**Producto:** G1-P2 · Modelo de análisis y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Nota metodológica:** Todas las plantillas expresan únicamente la intención del negocio y la interacción actor–sistema, sin detalles de implementación técnica (sin mención de lenguaje de consultas, tablas físicas, endpoints ni librerías). Cada flujo alterno y excepción coincide 1 a 1 con las guardas `[...]` de los diagramas de actividades [`01-actividad-cu06-venta-pos.png`](./01-actividad-cu06-venta-pos.png) y [`01-actividad-cu02-gestionar-productos.png`](./01-actividad-cu02-gestionar-productos.png) *(verificado en Revisión Día 2 — `2026-11-27`)*.

---

## 1. CU-06 · Registrar venta en POS

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-06 · Registrar venta en POS` |
| **Requisitos que atiende** | `RF-08`, `RF-05`, `RF-03` |
| **Actor primario / secundarios** | Primario: **Cajero** *(o **Tendero**, por generalización)* · Secundario: **Cámara / Lector de Código de Barras** *(opcional, si se extiende con `CU-04`)* |
| **Objetivo del actor** | Registrar la compra de un cliente en mostrador, confirmar el cobro y actualizar el inventario de la tienda en una sola operación. |
| **Precondiciones** | El usuario inició sesión en el sistema (`CU-01`), pertenece a una tienda activa y existe al menos un producto disponible en el catálogo de esa tienda. |
| **Disparador** | El Cajero abre la pantalla de Punto de Venta (POS) al iniciar la atención de un cliente. |
| **Flujo principal** | 1. El Cajero selecciona un producto desde el buscador o los botones de acceso rápido e indica la cantidad solicitada.<br>2. El sistema verifica que la cantidad solicitada sea positiva y que exista stock disponible suficiente para ese producto.<br>3. El sistema agrega el producto al carrito de venta actual, calcula el subtotal del ítem con el precio de venta vigente y actualiza el total general a cobrar.<br>4. El Cajero repite los pasos 1 a 3 hasta incluir todos los productos del cliente.<br>5. El Cajero selecciona el método de pago acordado con el cliente (efectivo o transferencia) y confirma la opción *Registrar venta*.<br>6. El sistema registra la venta confirmada congelando el precio unitario de cada línea y ejecuta obligatoriamente **`CU-07 · Descontar stock automáticamente`** (`«include»`).<br>7. El sistema emite el comprobante de venta, reinicia el carrito para el siguiente cliente y muestra confirmación de venta exitosa. |
| **Flujos alternos** | **1a. Captura por código de barras (`«extend»` hacia `CU-04`):** En el paso 1, si el producto cuenta con código de barras, el Cajero activa el escaneo con cámara o lector; el sistema identifica el producto automáticamente y continúa en el paso 2.<br>**5a. Pago en efectivo con cálculo de cambio:** En el paso 5, si el Cajero elige *Efectivo* e ingresa el monto recibido del cliente, el sistema calcula y muestra el valor del cambio a devolver antes de confirmar el paso 6. |
| **Excepciones** | **2a. Stock insuficiente:** En el paso 2, si la cantidad solicitada supera la existencia disponible del producto, el sistema impide agregar el exceso, muestra la cantidad máxima disponible y permanece en el carrito sin cerrar la venta.<br>**5b. Carrito vacío o cancelación de compra:** En el paso 5, si el cliente desiste de la compra o no existen productos en el carrito, el sistema bloquea la confirmación (o anula el carrito actual), no genera comprobante y no modifica el inventario. |
| **Postcondiciones** | Queda registrada la venta con fecha, método de pago y detalle de productos; el stock de cada producto vendido disminuye exactamente en la cantidad vendida y, si algún producto alcanza su stock mínimo, queda activa su alerta de reposición. |
| **Reglas de negocio** | - Ninguna venta puede dejar un producto con existencia negativa.<br>- El precio de cada ítem vendido queda congelado en el momento de la venta para preservar el historial financiero ante futuros cambios de precio.<br>- Si el producto es perecedero, el descuento descuenta primero del lote con fecha de vencimiento más próxima (FEFO). |
| **Pantalla del prototipo** | [Pantalla 4/4: Punto de Venta Rápido (POS)](./05-prototipo-inicial.md#pantalla-44--cu-06-y-cu-07-punto-de-venta-pos) |

---

## 2. CU-02 · Gestionar productos

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-02 · Gestionar productos` |
| **Requisitos que atiende** | `RF-01`, `RF-02`, `RF-03`, `RF-09` |
| **Actor primario / secundarios** | Primario: **Tendero (Administrador)** · Secundario: **Cámara / Lector de Código de Barras** *(opcional)* |
| **Objetivo del actor** | Mantener actualizado el catálogo de productos de su tienda (registrar nuevos, modificar precios/existencias o desactivar productos que ya no se venden). |
| **Precondiciones** | El Tendero inició sesión con rol de administrador de su tienda (`CU-01`) y existe al menos una categoría disponible en el catálogo. |
| **Disparador** | El Tendero accede al módulo *Inventario / Stock* y selecciona *Agregar producto* o elige un producto existente para editarlo o desactivarlo. |
| **Flujo principal** | 1. El Tendero solicita crear un nuevo producto en el módulo de inventario.<br>2. El sistema presenta el formulario de registro con campos de nombre, código de barras opcional, categoría, unidad de medida, precio de costo, precio de venta, cantidad inicial y stock mínimo.<br>3. El Tendero diligencia los datos del producto y selecciona su categoría correspondiente.<br>4. El sistema valida que los campos obligatorios estén completos, que los precios sean mayores que cero, que las cantidades no sean negativas y que el código de barras (si se ingresó) no esté repetido en la tienda.<br>5. El sistema compara el precio de venta contra el precio de costo para verificar coherencia comercial.<br>6. El sistema registra el producto dentro del catálogo de la tienda, actualiza el listado visible y confirma al Tendero la operación exitosa. |
| **Flujos alternos** | **3a. Producto perecedero con lote (`«extend»` con `CU-09`):** En el paso 3, si el producto maneja fecha de vencimiento, el Tendero activa el registro de lote e ingresa código de lote y fecha de caducidad; el sistema asocia el lote al producto y continúa en el paso 4.<br>**5a. Advertencia de margen negativo:** En el paso 5, si el precio de venta es menor que el precio de costo, el sistema muestra una advertencia no bloqueante solicitando confirmación; si el Tendero confirma (por ejemplo, liquidación), continúa en el paso 6.<br>**1a. Edición o desactivación de producto existente:** En el paso 1, el Tendero selecciona un producto ya registrado para actualizar su precio, stock mínimo o marcarlo como inactivo; el sistema valida los cambios y guarda la actualización conservando el historial de ventas pasadas. |
| **Excepciones** | **4a. Código de barras duplicado en la tienda:** En el paso 4, si el código de barras ya pertenece a otro producto de la misma tienda, el sistema rechaza el registro, informa cuál producto ya usa ese código y ofrece abrirlo para edición.<br>**4b. Datos obligatorios incompletos o inválidos:** En el paso 4, si falta el nombre o se ingresa un precio o cantidad negativa, el sistema resalta los campos inválidos y no guarda el producto. |
| **Postcondiciones** | El producto queda creado, actualizado o desactivado en el catálogo exclusivo de la tienda y queda disponible (si está activo) para búsqueda y venta en el POS. |
| **Reglas de negocio** | - El código de barras debe ser único dentro de cada tienda, aunque dos tiendas distintas pueden registrar el mismo código comercial.<br>- Un producto con ventas históricas no se borra físicamente; se desactiva para no perder trazabilidad contable. |
| **Pantalla del prototipo** | [Pantalla 3/4: Gestión de Inventario](./05-prototipo-inicial.md#pantalla-34--cu-02-cu-03-cu-04-cu-05-y-cu-09-gestión-de-inventario) |

---

## 3. CU-08 · Generar alertas de inventario

| Campo | Contenido |
| :--- | :--- |
| **Identificador y nombre** | `CU-08 · Generar alertas de inventario` |
| **Requisitos que atiende** | `RF-06`, `RF-09` |
| **Actor primario / secundarios** | Primarios: **Temporizador Diario del Sistema** *(iniciador automático de vencimientos)* y evento de extensión desde `CU-07` *(stock bajo)*; destinatario de consulta: **Tendero (Administrador)** |
| **Objetivo del actor** | Detectar oportunamente productos próximos a agotarse o próximos a vencer (≤ 15 días) para que el Tendero reponga existencias o promueva su venta antes de perder capital. |
| **Precondiciones** | Existen productos activos en la tienda con stock mínimo configurado y/o lotes perecederos con fecha de vencimiento registrada. |
| **Disparador** | Ocurre un descuento de stock que deja un producto en o por debajo de su stock mínimo (`«extend»` desde `CU-07`), o el Temporizador Diario ejecuta la revisión programada de fechas de vencimiento. |
| **Flujo principal** | 1. El evento disparador inicia la evaluación de alertas de la tienda.<br>2. El sistema consulta los productos activos cuyo stock actual sea menor o igual a su stock mínimo definido.<br>3. El sistema identifica también los lotes activos con existencia mayor a cero cuya fecha de vencimiento esté a 15 días calendario o menos de la fecha actual.<br>4. El sistema verifica si ya existe una alerta abierta del mismo tipo para ese producto o lote, evitando generar alertas duplicadas.<br>5. El sistema crea cada nueva alerta indicando tipo (*Stock bajo* o *Próximo a vencer*), fecha de generación, prioridad y estado *Activa*.<br>6. El sistema actualiza los contadores del Panel Principal del Tendero y lista las alertas ordenadas por urgencia para su revisión. |
| **Flujos alternos** | **4a. Resolución automática al reponer o agotar lote:** Si durante la evaluación el sistema detecta que un producto con alerta de *Stock bajo* ya supera su stock mínimo tras una reposición, o que un lote próximo a vencer ya llegó a cero unidades, cambia automáticamente el estado de la alerta a *Resuelta*. |
| **Excepciones** | **2a. Producto sin stock mínimo ni lotes configurados:** Si ningún producto tiene umbral mínimo mayor a cero ni fechas de vencimiento registradas, el sistema registra evaluación sin hallazgos y mantiene el panel de alertas en cero sin generar falsas alarmas.<br>**3a. Lote ya vencido:** Si un lote activo presenta fecha de vencimiento anterior a la fecha actual, el sistema genera una alerta crítica de *Producto vencido* para retirar la mercancía del mostrador y bloquea su selección prioritaria en venta. |
| **Postcondiciones** | Todas las condiciones críticas de desabastecimiento o vencimiento ≤ 15 días quedan visibles como alertas activas y trazables en el Panel Principal del Tendero. |
| **Reglas de negocio** | - Ventana preventiva de vencimiento obligatoria: **15 días calendario**.<br>- No debe existir más de una alerta activa simultánea del mismo tipo para un mismo producto o lote. |
| **Pantalla del prototipo** | [Pantalla 2/4: Panel Principal y Alertas](./05-prototipo-inicial.md#pantalla-24--cu-08-panel-principal-y-alertas) |
