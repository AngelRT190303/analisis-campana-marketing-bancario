DROP TABLE IF EXISTS staging_bank;

CREATE TABLE staging_bank (
    age INTEGER,
    job TEXT,
    marital TEXT,
    education TEXT,
    "default" TEXT,
    balance INTEGER,
    housing TEXT,
    loan TEXT,
    contact TEXT,
    month TEXT,
    day TEXT,
    duration INTEGER,
    campaign INTEGER,
    pdays INTEGER,
    previous INTEGER,
    poutcome TEXT,
    emp_var_rate NUMERIC,
    cons_price_idx NUMERIC,
    cons_conf_idx NUMERIC,
    euribor3m NUMERIC,
    nr_employed NUMERIC,
    y TEXT
);

-- Ahora realizamos la importación de los datos.
COPY staging_bank
FROM 'C:/Users/Angel/Documents/Professional/Portafolio/Proyecto-1/bank-marketing/bank-additional/bank-additional/bank-additional-full.csv'
DELIMITER ';'
CSV HEADER
ENCODING 'UTF8';


-- Llamamos las primeras 10 filas de la tabla.
SELECT * From staging_bank
LIMIT 10;
