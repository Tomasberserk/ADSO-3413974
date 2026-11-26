# B3 · Evidencia de Normalización Paso a Paso (`0FN → 1FN → 2FN → 3FN`) — GIN (TiendApp)

**Producto:** G2-P2 · Modelo de datos y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Alcance:** Normalización paso a paso de **2 tablas propias del proyecto GIN** (1 con **llave compuesta / dependencia parcial en 2FN** y 1 con **dependencia transitiva en 3FN**), escribiendo explícitamente las dependencias funcionales (DF) y el estado antes/después.

---

## Tabla 1 · Registro de Ventas POS (`registro_venta_pos` — Llave Compuesta → 1FN, 2FN y 3FN)

### Estado inicial (`0FN` — sin normalizar)
Imagínese una planilla inicial de mostrador donde cada fila guarda el detalle completo de una venta:

`registro_venta_pos(id_venta, id_producto, fecha_hora, id_usuario, nombre_usuario, codigo_rol, metodo_pago, nombre_producto, id_categoria, nombre_categoria, lotes_descontados, cantidad_vendida, precio_unitario_congelado, subtotal)`

- **Llave primaria compuesta:** `(id_venta, id_producto)`
- **Problema adicional en `0FN`:** la columna `lotes_descontados` guarda varios valores en una misma celda (ejemplo: `"L-01 (2u), L-02 (1u)"`).

### Proceso paso a paso (`0FN → 1FN → 2FN → 3FN`)

| Paso | Violación detectada | Dependencias Funcionales (DF) escritas | Estado después (tablas resultantes) |
| :---: | :--- | :--- | :--- |
| **1FN** *(Atomicidad)* | `lotes_descontados` no es atómico (contiene múltiples códigos de lote y cantidades en una celda). | `(id_producto, numero_lote) → fecha_vencimiento, cantidad_disponible` | Se retira `lotes_descontados` de la tabla y cada lote se modela como fila atómica en la tabla **`lote`**(`id_producto`, `numero_lote`, `fecha_vencimiento`, `cantidad_disponible`, `fecha_ingreso`). |
| **2FN** *(Eliminar dependencias parciales sobre llave compuesta)* | Con PK compuesta `(id_venta, id_producto)`, varios atributos dependen **solo de una parte** de la llave: los datos de cabecera dependen solo de `id_venta` y los datos del catálogo dependen solo de `id_producto`. | • `id_venta → fecha_hora, id_usuario, nombre_usuario, codigo_rol, metodo_pago`<br>• `id_producto → nombre_producto, id_categoria, nombre_categoria`<br>• `(id_venta, id_producto) → cantidad_vendida, precio_unitario_congelado, subtotal` *(dependencia plena)* | Se descompone en 3 tablas:<br>1. **`venta_2fn`**(`id_venta`, `fecha_hora`, `id_usuario`, `nombre_usuario`, `codigo_rol`, `metodo_pago`)<br>2. **`producto_2fn`**(`id_producto`, `nombre_producto`, `id_categoria`, `nombre_categoria`)<br>3. **`detalle_venta`**(`id_venta`, `id_producto`, `cantidad_vendida`, `precio_unitario_congelado`, `subtotal`) |
| **3FN** *(Eliminar dependencias transitivas)* | En `venta_2fn`: `nombre_usuario` y `codigo_rol` dependen de `id_usuario` (que no es llave) y `codigo_rol` depende de `id_rol`. En `producto_2fn`: `nombre_categoria` depende de `id_categoria` (atributo no primo). | • `id_venta → id_usuario → nombre_usuario, id_rol → codigo_rol`<br>• `id_producto → id_categoria → nombre_categoria, color_hex` | Se extraen las entidades determinantes:<br>• **`venta`**(`id_venta`, `id_tienda`, `id_usuario`, `id_cierre`, `fecha_hora`, `metodo_pago`, `total`, `monto_recibido`, `cambio_entregado`, `referencia_pago`, `estado`)<br>• **`usuario`**(`id_usuario`, `id_tienda`, `id_rol`, `nombre`, `correo`, ...)<br>• **`rol`**(`id_rol`, `codigo_rol`, `descripcion`)<br>• **`categoria`**(`id_categoria`, `id_tienda`, `nombre`, `color_hex`, `icono`)<br>• **`producto`**(`id_producto`, `id_tienda`, `id_categoria`, `nombre`, ...)<br>• **`detalle_venta`**(`id_venta`, `id_producto`, `cantidad_vendida`, `precio_unitario_congelado`, `subtotal`) |

---

## Tabla 2 · Catálogo de Inventario por Tienda (`catalogo_tienda_plano` — Dependencia Transitiva → 1FN, 2FN y 3FN)

### Estado inicial (`0FN` — sin normalizar)
Planilla plana heredada del cuaderno/Excel de la tienda:

`catalogo_tienda_plano(id_producto, id_tienda, nombre_tienda, ciudad_tienda, telefonos_tienda, id_categoria, nombre_categoria, color_hex, nombre_producto, codigo_barras, precio_costo, precio_venta, cantidad_actual, stock_minimo)`

- **Llave primaria simple:** `id_producto`
- **Problemas iniciales:** `telefonos_tienda` almacena varios números separados por coma (`"3101112233, 3154445566"`) y los datos de `tienda` y `categoria` se repiten en cada producto provocando anomalías de actualización y borrado.

### Proceso paso a paso (`0FN → 1FN → 2FN → 3FN`)

| Paso | Violación detectada | Dependencias Funcionales (DF) escritas | Estado después (tablas resultantes) |
| :---: | :--- | :--- | :--- |
| **1FN** *(Atomicidad)* | `telefonos_tienda` guarda múltiples números en una misma celda (atributo multivaluado). | `id_tienda → telefono_principal` | Se normaliza a un valor atómico por columna (`telefono_principal` en `tienda`, descartando listas separadas por coma). |
| **2FN** *(Sin dependencias parciales)* | La llave primaria `id_producto` es **simple** (un solo atributo), por lo que no existen subconjuntos propios de la llave. | `id_producto → id_tienda, nombre_tienda, ciudad_tienda, id_categoria, nombre_categoria, color_hex, nombre_producto, codigo_barras, precio_costo, precio_venta, cantidad_actual, stock_minimo` | Ya cumple **2FN** (todas las columnas dependen de la llave completa `id_producto`). |
| **3FN** *(Eliminar dependencias transitivas)* | Existen **dos dependencias transitivas** de atributos no clave sobre otros atributos no clave:<br>1. `nombre_tienda`, `ciudad_tienda` y `telefono_principal` dependen de `id_tienda`.<br>2. `nombre_categoria` y `color_hex` dependen de `id_categoria`. | • `id_producto → id_tienda → nombre_tienda, ciudad_tienda, telefono_principal`<br>• `id_producto → id_categoria → nombre_categoria, color_hex` | Se separa en 3 tablas en **3FN**:<br>1. **`tienda`**(`id_tienda`, `nombre_comercial`, `direccion`, `ciudad`, `telefono_principal`, `estado_suscripcion`, `fecha_creacion`)<br>2. **`categoria`**(`id_categoria`, `id_tienda`, `nombre`, `color_hex`, `icono`, `fecha_creacion`)<br>3. **`producto`**(`id_producto`, `id_tienda`, `id_categoria`, `nombre`, `codigo_barras`, `unidad_medida`, `precio_costo`, `precio_venta`, `cantidad_actual`, `stock_minimo`, `activo`) |

---

## Declaración de Desnormalización Controlada y Justificada

El esquema final de 10 tablas se encuentra en **3FN**, con **una única desnormalización deliberada y documentada por regla de negocio financiera (`RF-08` y `RF-10`)**:
- **`detalle_venta.precio_unitario_congelado`**, **`detalle_venta.subtotal`** y **`venta.total`**: aunque podrían parecer derivados de `producto.precio_venta` y `cantidad_vendida`, **deben persistirse en la venta** porque el precio de un producto cambia con la inflación y los cierres de caja históricos no pueden alterarse retroactivamente cuando el tendero actualiza el precio del catálogo.
