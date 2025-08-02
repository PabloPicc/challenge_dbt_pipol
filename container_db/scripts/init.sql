--Primero, la definición de datos

create table if not exists brasil_2024_08_31(
    Pais char(6),
    Fecha varchar(9),
    Hora varchar(11),
    Medio  char(2),
    Plaza text,
    Red text,
    Emisora text,
    Operador text,
    Programa text,
    Evento text,
    Marca text,
    Producto text,
    Version text,
    Sector text,
    Subsector text,
    Segmento text,
    Agencia text,
    Duracion int,
    ValorDolar float,
    Falla text,
    EsPrimera bool
);

create table if not exists brasil_2024_09_01 AS
SELECT *
FROM brasil_2024_08_31
;

create table if not exists mexico_2024_08_30(
    Medio text,
    Canal text,
    "Estación/Canal" text,
    "Grupo Estación" text,
    "Grupo Comercial" text,
    "Hora GMT" char(26),
    "Rango Horario" char(13),
    "Seg. Truncados" int,
    "Duración Programada" int,
    Marca text,
    Producto text,
    Localidad text,
    Sector text,
    "Sub Sector" text,
    Categoria text,
    "Versión" text,
    Cobertura varchar(8),
    "Spot Tipo" text
);

create table if not exists mexico_2024_08_31 AS
SELECT *
FROM mexico_2024_08_30
;

--Luego la carga propiamente dicha

COPY brasil_2024_08_31(
    Pais,
    Fecha,
    Hora,
    Medio,
    Plaza,
    Red,
    Emisora,
    Operador,
    Programa,
    Evento,
    Marca,
    Producto,
    Version,
    Sector,
    Subsector,
    Segmento,
    Agencia,
    Duracion,
    ValorDolar,
    Falla,
    EsPrimera
)
FROM '/docker-entrypoint-initdb.d/mercado_brasil_20240831.csv'
DELIMITER ';'
CSV HEADER
--para indicar que la primera lı́nea es el encabezado
ENCODING 'LATIN1';

COPY brasil_2024_09_01(
    Pais,
    Fecha,
    Hora,
    Medio,
    Plaza,
    Red,
    Emisora,
    Operador,
    Programa,
    Evento,
    Marca,
    Producto,
    Version,
    Sector,
    Subsector,
    Segmento,
    Agencia,
    Duracion,
    ValorDolar,
    Falla,
    EsPrimera
)
FROM '/docker-entrypoint-initdb.d/mercado_brasil_20240901.csv'
DELIMITER ';'
CSV HEADER
--para indicar que la primera lı́nea es el encabezado
ENCODING 'LATIN1';

COPY mexico_2024_08_30(
    Medio,
    Canal,
    "Estación/Canal",
    "Grupo Estación",
    "Grupo Comercial",
    "Hora GMT",
    "Rango Horario",
    "Seg. Truncados",
    "Duración Programada",
    Marca,
    Producto,
    Localidad,
    Sector,
    "Sub Sector",
    Categoria,
    "Versión",
    Cobertura,
    "Spot Tipo"
)
FROM '/docker-entrypoint-initdb.d/mercado_mexico_20240830.csv'
DELIMITER ';'
CSV HEADER
--para indicar que la primera lı́nea es el encabezado
ENCODING 'LATIN1';

COPY mexico_2024_08_31(
    Medio,
    Canal,
    "Estación/Canal",
    "Grupo Estación",
    "Grupo Comercial",
    "Hora GMT",
    "Rango Horario",
    "Seg. Truncados",
    "Duración Programada",
    Marca,
    Producto,
    Localidad,
    Sector,
    "Sub Sector",
    Categoria,
    "Versión",
    Cobertura,
    "Spot Tipo"
)
FROM '/docker-entrypoint-initdb.d/mercado_mexico_20240831.csv'
DELIMITER ';'
CSV HEADER
--para indicar que la primera lı́nea es el encabezado
ENCODING 'LATIN1';




