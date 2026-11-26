# B5 · Script SQL de Creación y Evidencia de Ejecución Real — GIN (TiendApp)

**Producto:** G2-P2 · Modelo de datos y verificación  
**Autor (GitHub):** `@Tomasberserk`  
**Script DDL ejecutable:** [`schema_gin.sql`](./schema_gin.sql)  
**Log real de ejecución sin errores:** [`evidencia_ejecucion_sql.txt`](./evidencia_ejecucion_sql.txt)

---

## 1. Resumen de Restricciones Implementadas en `schema_gin.sql`

- **Tablas creadas:** **10 / 10 (100 %)** idénticas al modelo lógico (`B2`) y diccionario de datos (`B4`).
- **Llaves primarias (`PRIMARY KEY`):** 8 simples + 2 compuestas (`lote(id_producto, numero_lote)` y `detalle_venta(id_venta, id_producto)`).
- **Llaves foráneas (`FOREIGN KEY`) con acción referencial explícita:** **15 FK** (mínimo exigido: 3), combinando `ON DELETE RESTRICT` (protege historial de ventas/tiendas/usuarios), `ON DELETE CASCADE` (composición `venta`→`detalle_venta` y entidad débil `producto`→`lote`) y `ON DELETE SET NULL` (agregación opcional `categoria`→`producto` y `cierre_caja`→`venta`).
- **Restricciones `UNIQUE`:** 4 (`rol.codigo_rol`, `usuario.correo`, `categoria(id_tienda, nombre)`, `producto(id_tienda, codigo_barras)`, además de `cierre_caja(id_tienda, fecha_cierre)`).
- **Restricciones `CHECK`:** **20 `CHECK`** (mínimo exigido: 3) protegiendo precios `> 0`, stocks `>= 0`, `monto_recibido >= total`, `fecha_vencimiento >= fecha_ingreso` y dominios cerrados.
- **Índices de rendimiento (`RNF-01`, `RNF-05`):** 4 índices compuestos/búsqueda sobre `producto`, `venta`, `lote` y `alerta_inventario`.

---

## 2. Evidencia Verbatim de Ejecución en Motor SQL Real (SQLite 3.45.3)

```text
========================================================================
EVIDENCIA DE EJECUCION REAL DEL SCRIPT DDL — GESTION NEIVA (GIN)
Motor SQL : SQLite 3.45.3 (PRAGMA foreign_keys = ON)
Fecha     : 2026-11-26 00:15:42
Script    : schema_gin.sql
========================================================================

[OK] DDL ejecutado sin errores. Tablas creadas (10): alerta_inventario, categoria, cierre_caja, detalle_venta, lote, producto, rol, tienda, usuario, venta
[OK] Indices de rendimiento creados (4): idx_alerta_tienda_estado, idx_lote_vencimiento, idx_producto_tienda_nombre, idx_venta_tienda_fecha

[OK] Insercion de registros de prueba en las 10 tablas completada sin errores.
[OK] Consulta JOIN verificada: Tienda='Tienda La Economia Neiva' | Cajero='Cajero Demo Turno1' (CAJERO) | Total=10900 | Lineas=2
[OK] Prueba CHECK exitosa (precio negativo rechazado): CHECK constraint failed: ck_producto_venta
[OK] Prueba ON DELETE RESTRICT exitosa (producto vendido protegido): FOREIGN KEY constraint failed
[OK] Prueba ON DELETE SET NULL exitosa (producto.id_categoria tras borrar categoria = None)

RESULTADO FINAL: 10/10 TABLAS CREADAS, RESTRICCIONES PK/FK/UNIQUE/CHECK/ON DELETE VERIFICADAS SIN ERRORES.
```
