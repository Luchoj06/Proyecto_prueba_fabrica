CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol_id INT NOT NULL REFERENCES roles(id),
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE salas (
    id SERIAL PRIMARY KEY,
    codigo VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    temp_min NUMERIC(4,2) DEFAULT 2.00,
    temp_max NUMERIC(4,2) DEFAULT 8.00
);

CREATE TABLE sensores (
    id SERIAL PRIMARY KEY,
    codigo_sensor VARCHAR(50) NOT NULL UNIQUE,
    sala_id INT NOT NULL REFERENCES salas(id),
    estado VARCHAR(20) DEFAULT 'ACTIVO'
);

CREATE TABLE telemetria (
    id BIGSERIAL PRIMARY KEY,
    sensor_id INT NOT NULL REFERENCES sensores(id),
    temperatura NUMERIC(5,2) NOT NULL,
    humedad NUMERIC(5,2) NOT NULL,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE incidentes (
    id SERIAL PRIMARY KEY,
    sensor_id INT NOT NULL REFERENCES sensores(id),
    nivel_sla INT DEFAULT 1,
    estado VARCHAR(20) DEFAULT 'ABIERTO',
    fecha_apertura TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_acuse TIMESTAMP,
    fecha_cierre TIMESTAMP,
    usuario_acuse_id INT REFERENCES usuarios(id),
    usuario_cierre_id INT REFERENCES usuarios(id),
    causa_raiz TEXT,
    accion_correctiva TEXT
);

CREATE TABLE audit_log (
    id BIGSERIAL PRIMARY KEY,
    usuario_id INT REFERENCES usuarios(id),
    accion VARCHAR(100) NOT NULL,
    detalle TEXT,
    fecha_hora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);