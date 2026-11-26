# B6 · Políticas de Seguridad de los Datos y Matriz de Roles — GIN (TiendApp)

**Producto:** G2-P2 · Modelo de datos y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Cobertura:** **9 políticas concretas** (3 Integridad, 3 Confidencialidad, 3 Disponibilidad — mínimo exigido: 6) + **Matriz de 4 roles × 10 tablas** (mínimo exigido: 3 roles) + **Tratamiento de datos personales (Ley 1581 de 2012)**.

---

## 1. Políticas de Seguridad Aplicadas al Caso GIN (Triada CIA)

| # | Principio | Política y medida técnica concreta sobre GIN (TiendApp) | Tablas / Columnas involucradas | Requisito |
| :-: | :---: | :--- | :--- | :---: |
| **P1** | **Integridad** | **Restricciones declarativas y referenciales en BD:** todo precio debe ser `> 0`, todo stock `>= 0`, toda venta `monto_recibido >= total`, y se prohíbe borrar productos o usuarios con historial mediante `ON DELETE RESTRICT`. | `producto`, `lote`, `venta`, `detalle_venta`, `usuario` | `RF-01`, `RF-05`, `RF-08` |
| **P2** | **Integridad** | **Transacciones ACID y congelación de precios en POS:** `FachadaPOS.finalizarVenta()` ejecuta la inserción en `venta`/`detalle_venta` y el descuento en `producto`/`lote` dentro de una sola transacción `BEGIN ... COMMIT` con bloqueo de fila (`FOR UPDATE`), preservando `precio_unitario_congelado`. | `venta`, `detalle_venta`, `producto`, `lote` | `RF-05`, `RF-08`, `RF-10` |
| **P3** | **Integridad** | **Aislamiento lógico multi-tienda (anti-IDOR):** toda consulta e inserción en tablas operativas exige predicado `WHERE id_tienda = :tenant_token` inyectado desde el token firmado en Capa 2; cualquier cruce entre tiendas retorna HTTP `403`. | `tienda`, `categoria`, `producto`, `venta`, `cierre_caja`, `alerta_inventario` | `RNF-04`, `RF-07` |
| **P4** | **Confidencialidad** | **Contraseñas con hash y sal (nunca cifradas ni en texto plano):** cada usuario genera una sal criptográfica aleatoria única de 32 bytes almacenada en `sal_contrasena` y un hash irreversible `Argon2id` en `hash_contrasena`; nunca se retorna ni registra en logs. | `usuario.hash_contrasena`, `usuario.sal_contrasena` | `RNF-04`, `RF-07` |
| **P5** | **Confidencialidad** | **Cifrado en tránsito (TLS 1.3) y cifrado en reposo de datos de contacto:** toda comunicación cliente–proxy usa HTTPS (puerto 443, TLS 1.3 obligatorio con HSTS); la BD opera en red privada sin IP pública (TCP 5432) y los volúmenes de almacenamiento + `usuario.telefono_contacto` se protegen con cifrado AES-256 en reposo. | Todo el tráfico API · `usuario.correo`, `usuario.telefono_contacto` | `RNF-04` |
| **P6** | **Confidencialidad** | **Tratamiento de datos personales (Ley 1581 de 2012 — Colombia):** los datos personales de `usuario` (`nombre`, `correo`, `telefono_contacto`) se recolectan exclusivamente con la **finalidad** de autenticación, trazabilidad de caja y notificaciones de la tienda; requieren **autorización previa y expresa** registrada en `usuario.autorizacion_datos = 1`, con derecho de consulta, rectificación y revocatoria (ARCO) y principio de mínimo privilegio. | `usuario` (`nombre`, `correo`, `telefono_contacto`, `autorizacion_datos`) | `RNF-04` |
| **P7** | **Disponibilidad** | **Respaldo automático diario fuera del servidor (regla 3-2-1):** ejecución nocturna a las `02:00 a. m.` de `pg_dump` comprimido y cifrado (AES-256) replicado a almacenamiento externo S3/object-storage por HTTPS 443, con retención de 30 días diarios y 6 copias mensuales. | Instancia completa `gin_db` (10 tablas) | `RNF-01`, `RF-10` |
| **P8** | **Disponibilidad** | **Prueba mensual de restauración con acta verificable:** el primer lunes de cada mes se restaura el último respaldo en un contenedor temporal de pruebas, validando conteo de filas de `venta`, `producto` y `cierre_caja` y verificando un RTO ≤ 30 min y RPO ≤ 24 h, dejando registro en bitácora operativa. | Respaldo `gin_db` | Disponibilidad |
| **P9** | **Disponibilidad** | **Control de tasa (*rate-limiting*) y pooling de conexiones:** Nginx limita intentos de login a 10 peticiones/min por IP para evitar saturación o fuerza bruta, y FastAPI gestiona un pool acotado hacia PostgreSQL impidiendo agotamiento de conexiones en horas pico del mostrador. | Endpoint `/auth/login` · Instancia `gin_db` | `RNF-01`, `RNF-04`, `RNF-05` |

---

## 2. Matriz de Permisos: 4 Roles × 10 Tablas (Principio de Mínimo Privilegio)

*(Todos los permisos de roles humanos están restringidos adicionalmente por el filtro obligatorio `id_tienda = tienda_del_usuario`.)*

| Tabla | `TENDERO` (Administrador de tienda) | `CAJERO` (Operador POS) | `AUDITOR_CONTABLE` (Consulta financiera) | `SISTEMA_CRON` (Temporizador 06:00) |
| :--- | :--- | :--- | :--- | :--- |
| **`tienda`** | `SELECT`, `UPDATE` *(propia)* | `SELECT` *(propia)* | `SELECT` *(propia)* | `SELECT` |
| **`rol`** | `SELECT` | `SELECT` | `SELECT` | — |
| **`usuario`** | `SELECT`, `INSERT`, `UPDATE` *(sin borrar historial)* | `SELECT` *(solo su propia fila, sin hash/sal)* | `SELECT` *(solo id, nombre, rol; sin hash/sal)* | — |
| **`categoria`** | `SELECT`, `INSERT`, `UPDATE`, `DELETE` | `SELECT` | `SELECT` | — |
| **`producto`** | `SELECT`, `INSERT`, `UPDATE` *(desactivar, no DELETE)* | `SELECT`, `UPDATE` *(solo `cantidad_actual` vía `FachadaPOS`)* | `SELECT` | `SELECT` |
| **`lote`** | `SELECT`, `INSERT`, `UPDATE` | `SELECT`, `UPDATE` *(solo `cantidad_disponible` vía FEFO)* | `SELECT` | `SELECT` |
| **`cierre_caja`** | `SELECT`, `INSERT` | — *(sin acceso)* | `SELECT` | — |
| **`venta`** | `SELECT`, `INSERT`, `UPDATE` *(solo anular)* | `SELECT` *(propias del día)*, `INSERT` | `SELECT` | — |
| **`detalle_venta`** | `SELECT`, `INSERT` | `SELECT` *(propias)*, `INSERT` | `SELECT` | — |
| **`alerta_inventario`** | `SELECT`, `UPDATE` *(marcar resuelta)* | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` |
