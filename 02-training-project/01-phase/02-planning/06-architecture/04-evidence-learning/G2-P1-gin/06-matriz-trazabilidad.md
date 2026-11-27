# A7 · Matriz de Trazabilidad Bidireccional (Análisis → Diseño) — GIN (TiendApp)

**Producto:** G2-P1 · Artefactos de diseño  
**Autor (GitHub):** `@Tomasberserk`  
**Cobertura verificada:** **10 / 10 RF (100 %)** · **5 / 5 RNF (100 %)** · **0 clases huérfanas** · **0 tablas huérfanas**

---

## 1. Trazabilidad Hacia Adelante (Requisitos → Clases → Tablas → Componentes → Decisiones)

| Requisito | Clase(s) de diseño (`A2`) | Tabla(s) lógica(s) (`B2`) | Componente(s) (`A5`) | Decisión arquitectónica / Patrón (`A3`, `A4`, `A6`) |
| :---: | :--- | :--- | :--- | :--- |
| **RF-01** | `Producto`, `Tendero` | `producto`, `tienda` | Catálogo y Lotes · Persistencia (DAL) | Soft delete (`activo = FALSE`) y `CHECK` de precios > 0 |
| **RF-02** | `Categoria`, `Producto` | `categoria`, `producto` | Catálogo y Lotes · Persistencia (DAL) | Agregación `Categoria` ◇── `Producto` (`ON DELETE SET NULL`) |
| **RF-03** | `Producto`, `FachadaPOS` | `producto` (`codigo_barras`) | WebApp PWA · Catálogo · POS | Índice `UNIQUE (id_tienda, codigo_barras)` + cámara WebRTC |
| **RF-04** | `Producto`, `Categoria`, `Cajero` | `producto`, `categoria` | WebApp PWA · Catálogo y Lotes | Índice compuesto `(id_tienda, nombre)` para `< 500 ms` |
| **RF-05** | `FachadaPOS`, `Producto`, `Lote`, `LineaVenta` | `producto`, `lote`, `detalle_venta` | Punto de Venta (POS) · Catálogo · DAL | Patrón **Fachada (`FachadaPOS`)** + transacción ACID + FEFO |
| **RF-06** | `AlertaInventario`, `Producto`, `FachadaPOS` | `alerta_inventario`, `producto` | Alertas y Cierre · POS · DAL | Evaluación automática post-descuento en `FachadaPOS` |
| **RF-07** | `Tienda`, `Usuario`, `Tendero`, `Cajero` | `tienda`, `usuario`, `rol` | Seguridad y Multi-Tienda · DAL | Herencia `Usuario`→`Tendero`/`Cajero`; middleware multi-tenant |
| **RF-08** | `Venta`, `LineaVenta`, `IEstrategiaPago`, `PagoEfectivo`, `PagoTransferencia`, `FachadaPOS`, `Cajero` | `venta`, `detalle_venta` | WebApp PWA · Punto de Venta (POS) · DAL | Patrón **Estrategia (`IEstrategiaPago`)** + Composición `Venta`◆──`LineaVenta` |
| **RF-09** | `Lote`, `Producto`, `AlertaInventario`, `Tendero` | `lote`, `alerta_inventario` | Catálogo y Lotes · Alertas y Cierre | Composición `Producto`◆──`Lote` + `cron-alertas-06h` (≤ 15 días) |
| **RF-10** | `CierreCaja`, `Venta`, `Tendero` | `cierre_caja`, `venta` | Alertas y Cierre · Persistencia (DAL) | Consolidación diaria con `DECIMAL(12,2)` sin error de redondeo |
| **RNF-01** | *(transversal)* | Índices en `producto`, `venta` | Proxy Nginx · Aplicación · DAL | Pool de conexiones + índices B-Tree + debounce 200 ms |
| **RNF-02** | *(transversal)* | n/a | WebApp POS e Inventario (PWA) | Diseño web responsivo móvil/escritorio sin capacitación |
| **RNF-03** | *(transversal)* | n/a | WebApp POS e Inventario (PWA) | Estándares HTML5/PWA multi-navegador |
| **RNF-04** | `Tienda`, `Usuario` | `usuario` (`hash_contrasena`, `sal`), `tienda` | Seguridad · Proxy Nginx · BD | Hash + sal (`Argon2id`), TLS 1.3 (`443`), BD sin IP pública, `403` |
| **RNF-05** | `Producto`, `Categoria` | `producto`, `categoria` | Catálogo · Persistencia (DAL) | Paginación e índices compuestos soportando `10 000` productos |

---

## 2. Verificación Hacia Atrás (Cero Clases y Cero Tablas Huérfanas)

| Control | Total en el diseño | Trazadas a ≥ 1 requisito | Huérfanas | Resultado |
| :--- | :---: | :---: | :---: | :---: |
| Clases e interfaces de `A2` (`Tienda`, `Usuario`, `Tendero`, `Cajero`, `Categoria`, `Producto`, `Lote`, `Venta`, `LineaVenta`, `IEstrategiaPago`, `PagoEfectivo`, `PagoTransferencia`, `AlertaInventario`, `CierreCaja`, `FachadaPOS`) | **15** | **15** | **0** | **Cumple (100 %)** |
| Tablas lógicas de `B2` (`tienda`, `rol`, `usuario`, `categoria`, `producto`, `lote`, `cierre_caja`, `venta`, `detalle_venta`, `alerta_inventario`) | **10** | **10** | **0** | **Cumple (100 %)** |
| Componentes de `A5` | **6** | **6** | **0** | **Cumple (100 %)** |

*(Auditoría cruzada Día 2 — `2026-11-27`: verificado 100 % de alineación entre las 15 clases/interfaz de `G2-P1-gin`, las 10 tablas / 74 columnas de `G2-P2-gin` y los 10 RF + 5 RNF de `G1`, sin ciclos ni saltos de capa.)*
