-- =============================================================
-- Activa V2: Script de Creación de Tablas de Inteligencia Artificial
-- Compatible con SQL Server 2014+
-- =============================================================

-- Tabla de Configuración de Proveedores IA
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AI_CONFIG' AND xtype='U')
CREATE TABLE AI_CONFIG (
    id INT IDENTITY(1,1) PRIMARY KEY,
    provider VARCHAR(50) NOT NULL,
    api_key_encrypted NVARCHAR(500),
    modelo_default VARCHAR(100),
    endpoint_url NVARCHAR(500),
    activo BIT DEFAULT 1,
    es_default BIT DEFAULT 0,
    orden_fallback INT,
    presupuesto_diario DECIMAL(10,2),
    presupuesto_mensual DECIMAL(10,2),
    max_tokens_por_llamada INT DEFAULT 2000,
    fecha_creacion DATETIME DEFAULT GETDATE(),
    fecha_modificacion DATETIME
);
GO

-- Tabla de Costes por Llamada IA
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AI_COSTES' AND xtype='U')
CREATE TABLE AI_COSTES (
    id INT IDENTITY(1,1) PRIMARY KEY,
    provider VARCHAR(50) NOT NULL,
    modelo VARCHAR(100),
    tokens_entrada INT,
    tokens_salida INT,
    coste_estimado DECIMAL(10,6),
    tipo_operacion VARCHAR(30),
    id_referencia INT,
    exito BIT DEFAULT 1,
    error_msg NVARCHAR(500),
    fecha DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Resúmenes Cacheados (Agente 1)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AI_RESUMENES' AND xtype='U')
CREATE TABLE AI_RESUMENES (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_articulo INT NOT NULL,
    tipo_articulo VARCHAR(3),
    idioma VARCHAR(2),
    resumen NVARCHAR(MAX),
    provider VARCHAR(50),
    modelo VARCHAR(100),
    tokens_usados INT,
    coste_estimado DECIMAL(10,6),
    fecha_creacion DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Briefings Diarios/Semanales (Agentes 2 y 7)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AI_BRIEFINGS' AND xtype='U')
CREATE TABLE AI_BRIEFINGS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE NOT NULL,
    tipo VARCHAR(20),
    contenido_es NVARCHAR(MAX),
    contenido_en NVARCHAR(MAX),
    articulos_incluidos NVARCHAR(MAX),
    provider VARCHAR(50),
    modelo VARCHAR(100),
    tokens_usados INT,
    coste_estimado DECIMAL(10,6),
    fecha_creacion DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Clasificaciones IA (Agente 3)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AI_CLASIFICACIONES' AND xtype='U')
CREATE TABLE AI_CLASIFICACIONES (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_articulo INT NOT NULL,
    categoria_sugerida VARCHAR(3),
    prioridad_sugerida VARCHAR(10),
    keywords_sugeridos NVARCHAR(500),
    empresas_detectadas NVARCHAR(500),
    ubicaciones_detectadas NVARCHAR(500),
    tipo_operacion VARCHAR(20),
    segmento VARCHAR(20),
    aprobado BIT DEFAULT 0,
    aprobado_por INT,
    fecha_creacion DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Artículos Relacionados (Agente 4)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='AI_RELACIONADOS' AND xtype='U')
CREATE TABLE AI_RELACIONADOS (
    id INT IDENTITY(1,1) PRIMARY KEY,
    id_articulo INT NOT NULL,
    id_articulo_relacionado INT NOT NULL,
    score INT,
    razon NVARCHAR(200),
    provider VARCHAR(50),
    fecha_creacion DATETIME DEFAULT GETDATE()
);
GO

-- Tabla de Notificaciones (Agente 6 y General V2)
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='V2_NOTIFICACIONES' AND xtype='U')
CREATE TABLE V2_NOTIFICACIONES (
    id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT,
    tipo VARCHAR(20),
    titulo NVARCHAR(200),
    mensaje NVARCHAR(MAX),
    id_articulo INT,
    leida BIT DEFAULT 0,
    fecha_creacion DATETIME DEFAULT GETDATE()
);
GO

-- Índices de Rendimiento
CREATE INDEX IX_AI_RESUMENES_articulo ON AI_RESUMENES (id_articulo, idioma);
CREATE INDEX IX_AI_BRIEFINGS_fecha ON AI_BRIEFINGS (fecha, tipo);
CREATE INDEX IX_AI_CLASIFICACIONES_articulo ON AI_CLASIFICACIONES (id_articulo);
CREATE INDEX IX_AI_RELACIONADOS_articulo ON AI_RELACIONADOS (id_articulo);
CREATE INDEX IX_V2_NOTIFICACIONES_user ON V2_NOTIFICACIONES (user_id, leida);
CREATE INDEX IX_AI_COSTES_fecha ON AI_COSTES (fecha, tipo_operacion);
GO

PRINT '✅ Todas las tablas de IA para Activa V2 creadas correctamente.'
GO
