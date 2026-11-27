# Insumo Consolidado de Requisitos (SRS Base) — Gestión Neiva (GIN / TiendApp)

**Autor (GitHub):** `@Tomasberserk`  
**Caso de estudio:** Gestión Neiva (`GIN`) — TiendApp (Sistema de Inventario Inteligente y Punto de Venta para Tiendas de Barrio)  
**Fuentes reutilizadas en este fork:**
- `03-execute/04-week/02-optional-activity/SRS_TiendApp_v3.xlsx` (`RF-01` a `RF-06`, `RNF-01` a `RNF-05`, `HU-01` a `HU-04`, entidad `Producto`).
- `03-execute/06-week/02-optional-activity/TiendApp_Instrumentos_Fase1.docx` y `03-execute/08-week/02-optional-activity/TiendApp_Encuesta_Validacion (1).docx` (entrevista y encuesta de validación de requisitos con tenderos de barrio).
- `03-execute/11-week/02-optional-activity/TiendApp.docx` (síntesis SRS TiendApp v1.2 confirmando `RF-01`–`RF-06`, `RNF-01`–`RNF-05` y soporte `EAN-13/EAN-8/UPC-A` hasta `10 000` productos).
- `03-execute/14-week/02-optional-activity/Normativa_Proyecto_Inventario_Inteligente.docx` (ampliación de alcance: POS rápido, lotes/vencimientos a 15 días, control de roles multi-tienda y cierre diario de caja → `RF-07` a `RF-10`).
- `03-execute/14-week/02-optional-activity/Mockup_Sencillo_Inventario_Inteligente.pdf` (4 pantallas iniciales en Figma).

---

## 1. Requisitos Funcionales (RF)

| ID | Nombre | Descripción funcional | Origen en el fork | Prioridad |
| :---: | :--- | :--- | :--- | :---: |
| **RF-01** | Gestión de productos | Permitir crear, consultar, editar y desactivar productos del catálogo con nombre, precio de costo, precio de venta, unidad de medida, stock mínimo y foto opcional. | `04-week/SRS_TiendApp_v3.xlsx` | Alta |
| **RF-02** | Categorización personalizable | Permitir asignar productos a categorías predefinidas (Bebidas, Lácteos, Aseo, Panadería, Granos) o crear categorías propias por tienda. | `04-week/SRS_TiendApp_v3.xlsx` | Media |
| **RF-03** | Lectura de código de barras | Permitir capturar o buscar un producto mediante código de barras (cámara móvil/web o ingreso manual EAN-8/EAN-13/UPC-A) único dentro de cada tienda. | `04-week/SRS_TiendApp_v3.xlsx` | Alta |
| **RF-04** | Búsqueda y filtrado de inventario | Permitir buscar productos en tiempo real por nombre o código y filtrar por categoría, estado de stock bajo o vencimiento próximo. | `04-week/SRS_TiendApp_v3.xlsx` | Alta |
| **RF-05** | Descuento automático de inventario | Al confirmar una venta, descontar automáticamente la cantidad vendida del stock disponible y registrar el movimiento para auditoría, impidiendo stock negativo. | `04-week/SRS_TiendApp_v3.xlsx` | Alta |
| **RF-06** | Alertas de stock bajo | Notificar automáticamente al tendero cuando la cantidad disponible de un producto sea menor o igual a su stock mínimo definido, desactivando la alerta al reponer. | `04-week/SRS_TiendApp_v3.xlsx` | Alta |
| **RF-07** | Autenticación y control de acceso por rol | Autenticar usuarios (Tendero Administrador y Cajero) garantizando aislamiento estricto de datos por tienda y permisos diferenciados por rol. | `14-week/Normativa_Proyecto_Inventario_Inteligente.docx` | Alta |
| **RF-08** | Registro de venta en Punto de Venta (POS) | Permitir armar un carrito de venta, calcular subtotal y total, seleccionar método de pago (efectivo o transferencia) y emitir comprobante de venta. | `14-week/Normativa_Proyecto_Inventario_Inteligente.docx` | Alta |
| **RF-09** | Control de lotes y alertas de vencimiento | Permitir registrar lotes con fecha de vencimiento para productos perecederos y generar alertas automáticas cuando falten 15 días o menos para vencer. | `14-week/Normativa_Proyecto_Inventario_Inteligente.docx` | Alta |
| **RF-10** | Cierre diario de caja y reporte | Calcular automáticamente el total vendido en el día por método de pago, ganancia estimada y exportar el resumen del cierre diario. | `14-week/Normativa_Proyecto_Inventario_Inteligente.docx` | Media |

---

## 2. Requisitos No Funcionales (RNF)

*(Los RNF son restricciones transversales de calidad; no se modelan como casos de uso sino como atributos de calidad verificables).*

| ID | Categoría | Requisito y métrica verificable | Origen en el fork |
| :---: | :--- | :--- | :--- |
| **RNF-01** | Rendimiento | Carga inicial del listado de productos `< 2 s` con 1 000 productos; búsqueda y filtrado `< 500 ms`; venta completa en POS `< 15 s`. | `04-week/SRS_TiendApp_v3.xlsx` y `14-week/Normativa` |
| **RNF-02** | Usabilidad responsiva | Interfaz adaptable a escritorio (`≥ 1280 px`), tableta (`768 px`) y móvil (`375 px`) sin desplazamiento horizontal; registro de producto en `< 2 min` sin capacitación previa. | `04-week/SRS_TiendApp_v3.xlsx` |
| **RNF-03** | Compatibilidad | Operar sin errores críticos en Chrome 110+, Edge 110+, Firefox 110+, Safari 16+ y dispositivos Android 10+ / iOS 14+. | `04-week/SRS_TiendApp_v3.xlsx` |
| **RNF-04** | Seguridad y aislamiento | Autenticación por sesión segura; cualquier intento de acceso cruzado entre tiendas o fuera de rol debe ser bloqueado (`403`); sin almacenamiento de contraseñas en texto plano. | `04-week/SRS_TiendApp_v3.xlsx` |
| **RNF-05** | Escalabilidad | Mantener búsquedas en `< 500 ms` con catálogos de hasta 10 000 productos mediante paginación e índices. | `04-week/SRS_TiendApp_v3.xlsx` |
