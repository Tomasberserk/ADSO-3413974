-- ============================================================================
-- B5 · Script SQL de Creación de Base de Datos — Gestión Neiva (GIN / TiendApp)
-- Producto: G2-P2 · Modelo de datos y verificación
-- Autor (GitHub): @Tomasberserk
-- Estándar: ANSI SQL compatible con PostgreSQL 16 y verificado en SQLite 3
-- ============================================================================

PRAGMA foreign_keys = ON;

CREATE TABLE tienda (
    id_tienda           INTEGER PRIMARY KEY,
    nombre_comercial    VARCHAR(120) NOT NULL,
    direccion           VARCHAR(180) NOT NULL,
    ciudad              VARCHAR(80)  NOT NULL,
    telefono_principal  VARCHAR(20)  NOT NULL,
    estado_suscripcion  VARCHAR(20)  NOT NULL DEFAULT 'ACTIVA',
    fecha_creacion      TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT ck_tienda_estado CHECK (estado_suscripcion IN ('ACTIVA', 'SUSPENDIDA'))
);

CREATE TABLE rol (
    id_rol      INTEGER PRIMARY KEY,
    codigo_rol  VARCHAR(30)  NOT NULL UNIQUE,
    descripcion VARCHAR(150) NOT NULL,
    CONSTRAINT ck_rol_codigo CHECK (codigo_rol IN ('TENDERO', 'CAJERO', 'AUDITOR_CONTABLE', 'SISTEMA_CRON'))
);

CREATE TABLE usuario (
    id_usuario         INTEGER PRIMARY KEY,
    id_tienda          INTEGER      NOT NULL,
    id_rol             INTEGER      NOT NULL,
    nombre             VARCHAR(100) NOT NULL,
    correo             VARCHAR(120) NOT NULL UNIQUE,
    hash_contrasena    VARCHAR(255) NOT NULL,
    sal_contrasena     VARCHAR(64)  NOT NULL,
    telefono_contacto  VARCHAR(20),
    autorizacion_datos INTEGER      NOT NULL,
    activo             INTEGER      NOT NULL DEFAULT 1,
    CONSTRAINT fk_usuario_tienda FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_usuario_rol    FOREIGN KEY (id_rol)    REFERENCES rol (id_rol)       ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_usuario_auth   CHECK (autorizacion_datos IN (0, 1)),
    CONSTRAINT ck_usuario_activo CHECK (activo IN (0, 1))
);

CREATE TABLE categoria (
    id_categoria   INTEGER PRIMARY KEY,
    id_tienda      INTEGER     NOT NULL,
    nombre         VARCHAR(60) NOT NULL,
    color_hex      VARCHAR(7)  NOT NULL DEFAULT '#2563EB',
    icono          VARCHAR(40),
    fecha_creacion TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT uq_categoria_tienda_nombre UNIQUE (id_tienda, nombre),
    CONSTRAINT fk_categoria_tienda FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE producto (
    id_producto     INTEGER PRIMARY KEY,
    id_tienda       INTEGER       NOT NULL,
    id_categoria    INTEGER,
    nombre          VARCHAR(120)  NOT NULL,
    codigo_barras   VARCHAR(50),
    unidad_medida   VARCHAR(20)   NOT NULL,
    precio_costo    DECIMAL(12,2) NOT NULL,
    precio_venta    DECIMAL(12,2) NOT NULL,
    cantidad_actual INTEGER       NOT NULL DEFAULT 0,
    stock_minimo    INTEGER       NOT NULL DEFAULT 5,
    activo          INTEGER       NOT NULL DEFAULT 1,
    CONSTRAINT uq_producto_tienda_codigo UNIQUE (id_tienda, codigo_barras),
    CONSTRAINT fk_producto_tienda    FOREIGN KEY (id_tienda)    REFERENCES tienda (id_tienda)       ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_producto_categoria FOREIGN KEY (id_categoria) REFERENCES categoria (id_categoria) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_producto_unidad    CHECK (unidad_medida IN ('UNIDAD', 'KG', 'LIBRA', 'LITRO', 'PAQUETE')),
    CONSTRAINT ck_producto_costo     CHECK (precio_costo > 0),
    CONSTRAINT ck_producto_venta     CHECK (precio_venta > 0),
    CONSTRAINT ck_producto_stock     CHECK (cantidad_actual >= 0),
    CONSTRAINT ck_producto_minimo    CHECK (stock_minimo >= 0),
    CONSTRAINT ck_producto_activo    CHECK (activo IN (0, 1))
);

CREATE TABLE lote (
    id_producto         INTEGER     NOT NULL,
    numero_lote         VARCHAR(40) NOT NULL,
    fecha_vencimiento   DATE        NOT NULL,
    cantidad_disponible INTEGER     NOT NULL,
    fecha_ingreso       DATE        NOT NULL,
    CONSTRAINT pk_lote PRIMARY KEY (id_producto, numero_lote),
    CONSTRAINT fk_lote_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_lote_cantidad CHECK (cantidad_disponible >= 0),
    CONSTRAINT ck_lote_fechas   CHECK (fecha_vencimiento >= fecha_ingreso)
);

CREATE TABLE cierre_caja (
    id_cierre           INTEGER PRIMARY KEY,
    id_tienda           INTEGER       NOT NULL,
    id_usuario          INTEGER       NOT NULL,
    fecha_cierre        DATE          NOT NULL,
    total_efectivo      DECIMAL(12,2) NOT NULL DEFAULT 0,
    total_transferencia DECIMAL(12,2) NOT NULL DEFAULT 0,
    ganancia_estimada   DECIMAL(12,2) NOT NULL DEFAULT 0,
    CONSTRAINT uq_cierre_tienda_fecha UNIQUE (id_tienda, fecha_cierre),
    CONSTRAINT fk_cierre_tienda  FOREIGN KEY (id_tienda)  REFERENCES tienda (id_tienda)   ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_cierre_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_cierre_efectivo CHECK (total_efectivo >= 0),
    CONSTRAINT ck_cierre_transf   CHECK (total_transferencia >= 0)
);

CREATE TABLE venta (
    id_venta         INTEGER PRIMARY KEY,
    id_tienda        INTEGER       NOT NULL,
    id_usuario       INTEGER       NOT NULL,
    id_cierre        INTEGER,
    fecha_hora       TIMESTAMP     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    metodo_pago      VARCHAR(20)   NOT NULL,
    total            DECIMAL(12,2) NOT NULL,
    monto_recibido   DECIMAL(12,2) NOT NULL,
    cambio_entregado DECIMAL(12,2) NOT NULL DEFAULT 0,
    referencia_pago  VARCHAR(60),
    estado           VARCHAR(20)   NOT NULL DEFAULT 'CONFIRMADA',
    CONSTRAINT fk_venta_tienda  FOREIGN KEY (id_tienda)  REFERENCES tienda (id_tienda)      ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_venta_usuario FOREIGN KEY (id_usuario) REFERENCES usuario (id_usuario)    ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_venta_cierre  FOREIGN KEY (id_cierre)  REFERENCES cierre_caja (id_cierre) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT ck_venta_metodo  CHECK (metodo_pago IN ('EFECTIVO', 'TRANSFERENCIA')),
    CONSTRAINT ck_venta_total   CHECK (total > 0),
    CONSTRAINT ck_venta_monto   CHECK (monto_recibido >= total),
    CONSTRAINT ck_venta_cambio  CHECK (cambio_entregado >= 0),
    CONSTRAINT ck_venta_estado  CHECK (estado IN ('CONFIRMADA', 'ANULADA'))
);

CREATE TABLE detalle_venta (
    id_venta                  INTEGER       NOT NULL,
    id_producto               INTEGER       NOT NULL,
    cantidad_vendida          INTEGER       NOT NULL,
    precio_unitario_congelado DECIMAL(12,2) NOT NULL,
    subtotal                  DECIMAL(12,2) NOT NULL,
    CONSTRAINT pk_detalle_venta PRIMARY KEY (id_venta, id_producto),
    CONSTRAINT fk_detalle_venta    FOREIGN KEY (id_venta)    REFERENCES venta (id_venta)       ON DELETE CASCADE  ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_detalle_cantidad CHECK (cantidad_vendida > 0),
    CONSTRAINT ck_detalle_precio   CHECK (precio_unitario_congelado > 0),
    CONSTRAINT ck_detalle_subtotal CHECK (subtotal > 0)
);

CREATE TABLE alerta_inventario (
    id_alerta        INTEGER PRIMARY KEY,
    id_tienda        INTEGER     NOT NULL,
    id_producto      INTEGER     NOT NULL,
    numero_lote      VARCHAR(40),
    tipo_alerta      VARCHAR(25) NOT NULL,
    prioridad        VARCHAR(15) NOT NULL,
    estado           VARCHAR(15) NOT NULL DEFAULT 'ACTIVA',
    fecha_generacion TIMESTAMP   NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_resolucion TIMESTAMP,
    CONSTRAINT fk_alerta_tienda   FOREIGN KEY (id_tienda) REFERENCES tienda (id_tienda) ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT fk_alerta_producto FOREIGN KEY (id_producto) REFERENCES producto (id_producto) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_alerta_lote     FOREIGN KEY (id_producto, numero_lote) REFERENCES lote (id_producto, numero_lote) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT ck_alerta_tipo     CHECK (tipo_alerta IN ('STOCK_BAJO', 'PROXIMO_VENCER', 'VENCIDO')),
    CONSTRAINT ck_alerta_prio     CHECK (prioridad IN ('ALTA', 'MEDIA', 'CRITICA')),
    CONSTRAINT ck_alerta_estado   CHECK (estado IN ('ACTIVA', 'RESUELTA'))
);

-- Índices de rendimiento para RNF-01 (< 500 ms) y RNF-05 (10 000 productos)
CREATE INDEX idx_producto_tienda_nombre ON producto (id_tienda, nombre);
CREATE INDEX idx_venta_tienda_fecha     ON venta (id_tienda, fecha_hora);
CREATE INDEX idx_lote_vencimiento       ON lote (fecha_vencimiento);
CREATE INDEX idx_alerta_tienda_estado   ON alerta_inventario (id_tienda, estado);
