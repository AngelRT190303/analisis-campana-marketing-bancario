-- Ahora procederemos a poblar las tablas dimensionales.
-- ================================================
-- Poblar la tabla job con valores únicos
-- ================================================
INSERT INTO profesion (nombre_profesion)
SELECT DISTINCT job
FROM staging_bank
ORDER BY job;
SELECT * FROM profesion;

-- ================================================
-- Poblar la tabla education con valores únicos
-- ================================================
--ALTER SEQUENCE nivel_educativo_nivel_id_seq RESTART WITH 1;
--DELETE FROM nivel_educativo;
INSERT INTO nivel_educativo (nombre_nivel)
SELECT DISTINCT education
FROM staging_bank
ORDER BY education;
SELECT * FROM nivel_educativo;

-- ================================================
-- Poblar la tabla clientes
-- ================================================
ALTER SEQUENCE cliente_cliente_id_seq RESTART WITH 1;
INSERT INTO cliente (
    edad,
    estado_civil,
    credito_default,
    saldo,
    prestamo_vivienda,
    prestamo_personal,
    profesion_id,
    nivel_id
)
SELECT
    s.age,
    s.marital,
    s."default",
    s.balance,
    s.housing,
    s.loan,
    p.profesion_id,
    n.nivel_id
FROM staging_bank AS s
JOIN profesion AS p
  ON s.job = p.nombre_profesion
JOIN nivel_educativo AS n
  ON s.education = n.nombre_nivel;

SELECT * FROM cliente
LIMIT 10;
SELECT * FROM staging_bank
-- ================================================
-- Poblar la tabla campañas
-- ================================================
INSERT INTO campaña (
    cliente_id,
    tipo_contacto,
    dia,
    mes,
    duracion,
    cantidad_contactos,
    dias_desde_contacto_anterior,
    cantidad_contactos_previos,
    resultado_anterior,
    variacion_empleo,
    indice_precio_consumo,
    indice_confianza_consumidor,
    euribor_3_meses,
    empleados_promedio
)
SELECT
    c.cliente_id,
    s.contact,
    s.day,
    s.month,
    s.duration,
    s.campaign,
    s.pdays,
    s.previous,
    s.poutcome,
    s.emp_var_rate,
    s.cons_price_idx,
    s.cons_conf_idx,
    s.euribor3m,
    s.nr_employed
FROM (
    SELECT *, ROW_NUMBER() OVER () AS rn
    FROM staging_bank
) AS s
JOIN (
    SELECT cliente_id, ROW_NUMBER() OVER () AS rn
    FROM cliente
) AS c
  ON s.rn = c.rn;


SELECT * FROM campaña
LIMIT 10;

-- ================================================
-- Poblar la tabla subcripcion
-- ================================================
INSERT INTO suscripcion (
    campaña_id,
    contratado
)
SELECT
    c.campaña_id,
    s.y
FROM (
    SELECT *, ROW_NUMBER() OVER () AS rn
    FROM staging_bank
) AS s
JOIN (
    SELECT campaña_id, ROW_NUMBER() OVER () AS rn
    FROM campaña
) AS c
  ON s.rn = c.rn
ORDER BY s.rn;


SELECT * FROM suscripcion
LIMIT 10;