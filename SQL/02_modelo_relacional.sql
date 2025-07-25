-- Creamos la tabla cliente con referencias a job y education
-- ============================================
-- 1. Tabla de profesiones (dimensión job)
-- ============================================
CREATE TABLE profesion (
    profesion_id SERIAL PRIMARY KEY,
    nombre_profesion TEXT UNIQUE NOT NULL
);

-- ============================================
-- 2. Tabla de niveles educativos (dimensión education)
-- ============================================
CREATE TABLE nivel_educativo (
    nivel_id SERIAL PRIMARY KEY,
    nombre_nivel TEXT UNIQUE NOT NULL
);
-- ============================================
-- 3. Tabla de clientes
-- ============================================
CREATE TABLE cliente (
    cliente_id SERIAL PRIMARY KEY,
    edad INTEGER,
    estado_civil TEXT,
    credito_default TEXT,
    saldo INTEGER,
    prestamo_vivienda TEXT,
    prestamo_personal TEXT,
    profesion_id INTEGER REFERENCES profesion(profesion_id),
    nivel_id INTEGER REFERENCES nivel_educativo(nivel_id)
);

-- ============================================
-- 4. Tabla de campañas
-- ============================================
CREATE TABLE campaña (
    campaña_id SERIAL PRIMARY KEY,
    cliente_id INTEGER REFERENCES cliente(cliente_id),
    tipo_contacto TEXT,
    mes TEXT,
    dia TEXT,
    duracion INTEGER,
    cantidad_contactos INTEGER,
    dias_desde_contacto_anterior INTEGER,
    cantidad_contactos_previos INTEGER,
    resultado_anterior TEXT,
    -- Métricas macroeconómicas
    variacion_empleo NUMERIC,
    indice_precio_consumo NUMERIC,
    indice_confianza_consumidor NUMERIC,
    euribor_3_meses NUMERIC,
    empleados_promedio NUMERIC
);

-- ============================================
-- 5. Tabla de suscripciones
-- ============================================
CREATE TABLE suscripcion (
    suscripcion_id SERIAL PRIMARY KEY,
    campaña_id INTEGER REFERENCES campaña(campaña_id),
    contratado TEXT
);