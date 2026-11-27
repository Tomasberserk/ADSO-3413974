# B4 · Diccionario de Datos Completo — GIN (TiendApp)

**Producto:** G2-P2 · Modelo de datos y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Estándar de nombrado declarado:** nombres de tablas en **singular** y minúsculas (`snake_case`); columnas en `snake_case`; llaves primarias `id_<tabla>`; llaves foráneas con prefijo `id_`; restricciones nombradas `fk_<tabla>_<ref>`, `uq_<tabla>_<col>`, `ck_<tabla>_<regla>`.  
**Consistencia:** 100 % idéntico a [`02-modelo-logico-relacional.md`](./02-modelo-logico-relacional.md) y [`schema_gin.sql`](./schema_gin.sql) (10 tablas, **74 columnas** verificadas mediante paridad automatizada contra `PRAGMA table_info` en SQLite 3.45.3).

---

## 1. Tabla `tienda`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_tienda` | `INTEGER` | n/a | `PRIMARY KEY` | Entero positivo único por tienda |
| `nombre_comercial` | `VARCHAR` | 120 | `NOT NULL` | Nombre visible del establecimiento |
| `direccion` | `VARCHAR` | 180 | `NOT NULL` | Dirección física en el municipio |
| `ciudad` | `VARCHAR` | 80 | `NOT NULL` | Ciudad (por defecto Neiva) |
| `telefono_principal` | `VARCHAR` | 20 | `NOT NULL` | Teléfono de contacto atómico |
| `estado_suscripcion` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (IN 'ACTIVA','SUSPENDIDA')` | Estado operativo del comercio |
| `fecha_creacion` | `TIMESTAMP` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha y hora de alta en plataforma |

## 2. Tabla `rol`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_rol` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador del rol |
| `codigo_rol` | `VARCHAR` | 30 | `NOT NULL`, `UNIQUE`, `CHECK (IN 'TENDERO','CAJERO','AUDITOR_CONTABLE','SISTEMA_CRON')` | Código controlado de rol |
| `descripcion` | `VARCHAR` | 150 | `NOT NULL` | Alcance funcional del rol |

## 3. Tabla `usuario`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_usuario` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador único del usuario |
| `id_tienda` | `INTEGER` | n/a | `NOT NULL`, `FK → tienda(id_tienda) ON DELETE RESTRICT` | Tienda a la que pertenece (aislamiento `RNF-04`) |
| `id_rol` | `INTEGER` | n/a | `NOT NULL`, `FK → rol(id_rol) ON DELETE RESTRICT` | Rol asignado |
| `nombre` | `VARCHAR` | 100 | `NOT NULL` | Nombre del operador (dato personal Ley 1581) |
| `correo` | `VARCHAR` | 120 | `NOT NULL`, `UNIQUE` | Correo electrónico único de acceso |
| `hash_contrasena` | `VARCHAR` | 255 | `NOT NULL` | Hash irreversible (`Argon2id`) de la contraseña |
| `sal_contrasena` | `VARCHAR` | 64 | `NOT NULL` | Sal criptográfica aleatoria única por usuario |
| `telefono_contacto` | `VARCHAR` | 20 | `NULL` | Teléfono opcional (dato personal Ley 1581) |
| `autorizacion_datos` | `INTEGER` | n/a | `NOT NULL`, `CHECK (IN 0,1)` | Consentimiento expreso tratamiento datos (`1` = autorizado) |
| `activo` | `INTEGER` | n/a | `NOT NULL`, `DEFAULT 1`, `CHECK (IN 0,1)` | Estado del usuario (`1` = activo, `0` = inactivo) |

## 4. Tabla `categoria`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_categoria` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador de categoría |
| `id_tienda` | `INTEGER` | n/a | `NOT NULL`, `FK → tienda(id_tienda) ON DELETE RESTRICT` | Tienda propietaria de la categoría |
| `nombre` | `VARCHAR` | 60 | `NOT NULL`, `UNIQUE(id_tienda, nombre)` | Nombre único dentro de la tienda |
| `color_hex` | `VARCHAR` | 7 | `NOT NULL`, `DEFAULT '#2563EB'` | Código de color hexadecimal (`#RRGGBB`) |
| `icono` | `VARCHAR` | 40 | `NULL` | Identificador de ícono visual |
| `fecha_creacion` | `TIMESTAMP` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha de creación |

## 5. Tabla `producto`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_producto` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador del producto |
| `id_tienda` | `INTEGER` | n/a | `NOT NULL`, `FK → tienda(id_tienda) ON DELETE RESTRICT` | Tienda propietaria |
| `id_categoria` | `INTEGER` | n/a | `NULL`, `FK → categoria(id_categoria) ON DELETE SET NULL` | Categoría opcional del producto |
| `nombre` | `VARCHAR` | 120 | `NOT NULL` | Nombre comercial del artículo |
| `codigo_barras` | `VARCHAR` | 50 | `NULL`, `UNIQUE(id_tienda, codigo_barras)` | Código EAN/UPC único dentro de la tienda |
| `unidad_medida` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (IN 'UNIDAD','KG','LIBRA','LITRO','PAQUETE')` | Unidad de venta controlada |
| `precio_costo` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (precio_costo > 0)` | Costo de adquisición en COP (> 0) |
| `precio_venta` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (precio_venta > 0)` | Precio vigente al público en COP (> 0) |
| `cantidad_actual` | `INTEGER` | n/a | `NOT NULL`, `DEFAULT 0`, `CHECK (cantidad_actual >= 0)` | Stock disponible no negativo |
| `stock_minimo` | `INTEGER` | n/a | `NOT NULL`, `DEFAULT 5`, `CHECK (stock_minimo >= 0)` | Umbral de alerta de stock bajo (`RF-06`) |
| `activo` | `INTEGER` | n/a | `NOT NULL`, `DEFAULT 1`, `CHECK (IN 0,1)` | Borrado lógico (`0` = desactivado) |

## 6. Tabla `lote`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_producto` | `INTEGER` | n/a | `PK`, `FK → producto(id_producto) ON DELETE CASCADE` | Producto padre (entidad débil) |
| `numero_lote` | `VARCHAR` | 40 | `PK`, `NOT NULL` | Código discriminador del lote |
| `fecha_vencimiento` | `DATE` | n/a | `NOT NULL` | Fecha de caducidad (`YYYY-MM-DD`) |
| `cantidad_disponible` | `INTEGER` | n/a | `NOT NULL`, `CHECK (cantidad_disponible >= 0)` | Unidades restantes del lote |
| `fecha_ingreso` | `DATE` | n/a | `NOT NULL`, `CHECK (fecha_vencimiento >= fecha_ingreso)` | Fecha de recepción de mercancía |

## 7. Tabla `cierre_caja`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_cierre` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador del cierre diario |
| `id_tienda` | `INTEGER` | n/a | `NOT NULL`, `FK → tienda(id_tienda) ON DELETE RESTRICT`, `UNIQUE(id_tienda, fecha_cierre)` | Un cierre único por tienda y día |
| `id_usuario` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT` | Tendero que genera el cierre |
| `fecha_cierre` | `DATE` | n/a | `NOT NULL` | Fecha contable cerrada (`YYYY-MM-DD`) |
| `total_efectivo` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (total_efectivo >= 0)` | Total cobrado en efectivo |
| `total_transferencia` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (total_transferencia >= 0)` | Total cobrado por transferencia |
| `ganancia_estimada` | `DECIMAL` | 12,2 | `NOT NULL` | Margen estimado del día |

## 8. Tabla `venta`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_venta` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador único de la venta |
| `id_tienda` | `INTEGER` | n/a | `NOT NULL`, `FK → tienda(id_tienda) ON DELETE RESTRICT` | Tienda donde ocurre la venta |
| `id_usuario` | `INTEGER` | n/a | `NOT NULL`, `FK → usuario(id_usuario) ON DELETE RESTRICT` | Cajero o Tendero que registra la venta |
| `id_cierre` | `INTEGER` | n/a | `NULL`, `FK → cierre_caja(id_cierre) ON DELETE SET NULL` | Cierre diario al que pertenece (nulo hasta el cierre) |
| `fecha_hora` | `TIMESTAMP` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Instante exacto de confirmación |
| `metodo_pago` | `VARCHAR` | 20 | `NOT NULL`, `CHECK (IN 'EFECTIVO','TRANSFERENCIA')` | Estrategia de cobro aplicada |
| `total` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (total > 0)` | Valor total cobrado en COP |
| `monto_recibido` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (monto_recibido >= total)` | Valor entregado por el cliente |
| `cambio_entregado` | `DECIMAL` | 12,2 | `NOT NULL`, `DEFAULT 0`, `CHECK (cambio_entregado >= 0)` | Vuelto entregado (0 en transferencia) |
| `referencia_pago` | `VARCHAR` | 60 | `NULL` | Comprobante Nequi/Daviplata si aplica |
| `estado` | `VARCHAR` | 20 | `NOT NULL`, `DEFAULT 'CONFIRMADA'`, `CHECK (IN 'CONFIRMADA','ANULADA')` | Estado de la transacción |

## 9. Tabla `detalle_venta`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_venta` | `INTEGER` | n/a | `PK`, `FK → venta(id_venta) ON DELETE CASCADE` | Venta contenedora (composición) |
| `id_producto` | `INTEGER` | n/a | `PK`, `FK → producto(id_producto) ON DELETE RESTRICT` | Producto vendido (impide borrar productos con historial) |
| `cantidad_vendida` | `INTEGER` | n/a | `NOT NULL`, `CHECK (cantidad_vendida > 0)` | Unidades vendidas (> 0) |
| `precio_unitario_congelado` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (precio_unitario_congelado > 0)` | Precio histórico exacto al momento de vender |
| `subtotal` | `DECIMAL` | 12,2 | `NOT NULL`, `CHECK (subtotal > 0)` | `cantidad_vendida * precio_unitario_congelado` |

## 10. Tabla `alerta_inventario`
| Columna | Tipo | Tamaño | Restricciones | Dominio / Regla de negocio |
| :--- | :--- | :---: | :--- | :--- |
| `id_alerta` | `INTEGER` | n/a | `PRIMARY KEY` | Identificador de la alerta |
| `id_tienda` | `INTEGER` | n/a | `NOT NULL`, `FK → tienda(id_tienda) ON DELETE RESTRICT` | Tienda propietaria |
| `id_producto` | `INTEGER` | n/a | `NOT NULL`, `FK → producto(id_producto) ON DELETE CASCADE` | Producto afectado |
| `numero_lote` | `VARCHAR` | 40 | `NULL`, `FK (id_producto, numero_lote) → lote(id_producto, numero_lote) ON DELETE CASCADE` | Lote afectado (solo si la alerta es de vencimiento) |
| `tipo_alerta` | `VARCHAR` | 25 | `NOT NULL`, `CHECK (IN 'STOCK_BAJO','PROXIMO_VENCER','VENCIDO')` | Clasificación del evento |
| `prioridad` | `VARCHAR` | 15 | `NOT NULL`, `CHECK (IN 'ALTA','MEDIA','CRITICA')` | Nivel de urgencia para ordenamiento en Dashboard |
| `estado` | `VARCHAR` | 15 | `NOT NULL`, `DEFAULT 'ACTIVA'`, `CHECK (IN 'ACTIVA','RESUELTA')` | Estado de atención |
| `fecha_generacion` | `TIMESTAMP` | n/a | `NOT NULL`, `DEFAULT CURRENT_TIMESTAMP` | Fecha de creación de la alerta |
| `fecha_resolucion` | `TIMESTAMP` | n/a | `NULL` | Fecha de cierre automático al reponer o agotar |
