/*
1️⃣ ¿Cuántos clientes distintos hay en la base?
2️⃣ ¿Cuántas campañas se registraron en total?
3️⃣ ¿Cuál es la tasa de conversión total (suscripciones / campañas)?
4️⃣ ¿Cuál es la edad mínima, máxima y promedio de los clientes?
5️⃣ ¿Qué porcentaje de clientes tiene crédito en default?
6️⃣ ¿Qué nivel educativo muestra mayor saldo promedio (balance)?
7️⃣ ¿Cuál es el saldo promedio y el máximo por cliente?
8️⃣ ¿Cuál es la duración promedio de los contactos con los clientes durante las campañas?
9️⃣ ¿La tasa de conversión varía según el mes de contacto?
1️⃣0️⃣ ¿Qué profesiones tienen mayor tasa de conversión a suscripción?
1️⃣1️⃣ ¿Existe relación entre la cantidad de contactos y la probabilidad de suscripción?
*/

-- =================================================================================
-- ¿Cuántos clientes distintos hay en la base?
-- =================================================================================
SELECT COUNT(*) AS total_clientes
FROM cliente;

-- =================================================================================
-- ¿Cuántas campañas se registraron en total?
-- =================================================================================
SELECT COUNT(*) AS total_campañas
FROM campaña;

-- =================================================================================
-- ¿Cuál es la tasa de conversión total (suscripciones / campañas)?
-- =================================================================================
SELECT 
  ROUND(
    100.0 * COUNT(CASE WHEN s.contratado = 'yes' THEN 1 END) / COUNT(*),
    2
  ) AS tasa_conversion
FROM campaña AS c
JOIN suscripcion AS s
  ON c.campaña_id = s.campaña_id;

-- =================================================================================
-- ¿Cuál es la edad mínima, máxima y promedio de los clientes?
-- =================================================================================
SELECT 
  MIN(edad) AS edad_minima,
  MAX(edad) AS edad_maxima,
  ROUND(AVG(edad), 2) AS edad_promedio
FROM cliente;

-- =================================================================================
-- ¿Qué porcentaje de clientes tiene crédito en default?
-- =================================================================================
SELECT 
  ROUND(
    100.0 * COUNT(CASE WHEN credito_default = 'yes' THEN 1 END) / COUNT(*),
    2
  ) AS porcentaje_credito_default
FROM cliente;

-- =================================================================================
-- ¿Qué nivel educativo muestra mayor saldo promedio (balance)?
-- =================================================================================
SELECT 
  ne.nombre_nivel,
  ROUND(AVG(c.saldo), 2) AS promedio_saldo
FROM cliente AS c
JOIN nivel_educativo AS ne
  ON c.nivel_id = ne.nivel_id
GROUP BY ne.nombre_nivel
ORDER BY promedio_saldo DESC;

-- =================================================================================
-- ¿Cuál es el saldo promedio y el máximo por cliente?
-- =================================================================================
SELECT 
  ROUND(AVG(saldo), 2) AS saldo_promedio,
  MAX(saldo) AS saldo_maximo
FROM cliente;

-- =================================================================================
-- ¿Cuál es la duración promedio de los contactos con los clientes durante las campañas?
-- =================================================================================
SELECT 
  ROUND(AVG(duracion), 2) AS duracion_promedio_de_campaña
FROM campaña;

-- =================================================================================
-- ¿La tasa de conversión varía según el mes de contacto?
-- =================================================================================
SELECT 
  c.mes,
  COUNT(*) AS total_contactos,
  SUM(CASE WHEN s.contratado = 'yes' THEN 1 ELSE 0 END) AS total_suscripciones,
  ROUND(100.0 * SUM(CASE WHEN s.contratado = 'yes' THEN 1 ELSE 0 END) / COUNT(*), 2) AS tasa_conversion_pct
FROM campaña AS c
JOIN suscripcion AS s
  ON c.campaña_id = s.campaña_id
GROUP BY c.mes
ORDER BY 
  CASE 
    WHEN c.mes = 'jan' THEN 1
    WHEN c.mes = 'feb' THEN 2
    WHEN c.mes = 'mar' THEN 3
    WHEN c.mes = 'apr' THEN 4
    WHEN c.mes = 'may' THEN 5
    WHEN c.mes = 'jun' THEN 6
    WHEN c.mes = 'jul' THEN 7
    WHEN c.mes = 'aug' THEN 8
    WHEN c.mes = 'sep' THEN 9
    WHEN c.mes = 'oct' THEN 10
    WHEN c.mes = 'nov' THEN 11
    WHEN c.mes = 'dec' THEN 12
  END;

-- =================================================================================
-- ¿Qué profesiones tienen mayor tasa de conversión a suscripción?
-- =================================================================================
SELECT
    p.nombre_profesion AS profesion,
    COUNT(*) AS total_contactos,
    SUM(CASE WHEN s.contratado = 'yes' THEN 1 ELSE 0 END) AS total_suscripciones,
    ROUND(
        100.0 * SUM(CASE WHEN s.contratado = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS tasa_conversion_pct
FROM campaña c
JOIN suscripcion s ON c.campaña_id = s.campaña_id
JOIN cliente cl ON c.cliente_id = cl.cliente_id
JOIN profesion p ON cl.profesion_id = p.profesion_id
GROUP BY p.nombre_profesion
ORDER BY tasa_conversion_pct DESC;


-- =================================================================================
-- ¿Existe relación entre la cantidad de contactos y la probabilidad de suscripción?
-- =================================================================================
SELECT
    c.cantidad_contactos AS num_contactos,
    COUNT(*) AS total_registros,
    SUM(CASE WHEN s.contratado = 'yes' THEN 1 ELSE 0 END) AS total_suscripciones,
    ROUND(
        100.0 * SUM(CASE WHEN s.contratado = 'yes' THEN 1 ELSE 0 END) / COUNT(*),
        2
    ) AS tasa_conversion_pct
FROM campaña c
JOIN suscripcion s ON c.campaña_id = s.campaña_id
GROUP BY c.cantidad_contactos
ORDER BY total_suscripciones DESC;
