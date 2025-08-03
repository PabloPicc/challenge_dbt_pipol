--Tipo de materialización: incremental. Para que solo detecte nuevos cambios
{{ config(
   materialized="incremental"
) }}

--Se realiza el pruneo de las columnas que no usaremos y las transformaciones que nos interesan
--Manipuleo de datos horarios, se divide en segmentos horaios (prime time, grey time, etc)
--Se contempla la localidad "Nacional" como hace Brasil

with bronze_prune as(
select m.medio,
m."Estación/Canal" as canal, 
m."Grupo Comercial" as grupo_comercial,
cast(substring(m."Hora GMT",1,10) as date) as fecha,
substring(m."Hora GMT",12,8) as hora,
case 
	when cast(substring(m."Rango Horario",1,2) as int)>=18 or cast(substring(m."Rango Horario",1,2) as int)<2 then 'PrimeTime'
	when cast(substring(m."Rango Horario",1,2) as int)>=2 and cast(substring(m."Rango Horario",1,2) as int)<8 then 'GreyTime'
	else 'Day'
end as segmento_time,
m."Duración Programada" as duracion, 
m.marca, 
m.producto,
case
	when m.cobertura ='LOCAL' then m.localidad 
	else 'NACIONAL'
end as localidad,
m.sector,
m."Sub Sector" as subsector,
m.categoria as segmento,
m."Versión" as version,
m."Spot Tipo" as tipo_spot
from {{source('mercados_latam','mexico_2024_08_30')}} m
),
bronze_max as(
select max(fecha) as max_fecha
from bronze_prune
),
mexico_30 as(
select p.*, m.max_fecha
from bronze_max m, bronze_prune p
),
bronze_prune_2 as(
select m.medio,
m."Estación/Canal" as canal, 
m."Grupo Comercial" as grupo_comercial,
cast(substring(m."Hora GMT",1,10) as date) as fecha,
substring(m."Hora GMT",12,8) as hora,
case 
	when cast(substring(m."Rango Horario",1,2) as int)>=18 or cast(substring(m."Rango Horario",1,2) as int)<2 then 'PrimeTime'
	when cast(substring(m."Rango Horario",1,2) as int)>=2 and cast(substring(m."Rango Horario",1,2) as int)<8 then 'GreyTime'
	else 'Day'
end as segmento_time,
m."Duración Programada" as duracion, 
m.marca, 
m.producto,
case
	when m.cobertura ='LOCAL' then m.localidad 
	else 'NACIONAL'
end as localidad,
m.sector,
m."Sub Sector" as subsector,
m.categoria as segmento,
m."Versión" as version,
m."Spot Tipo" as tipo_spot
from mexico_2024_08_31 m
),
bronze_max_2 as(
select max(fecha) as max_fecha
from bronze_prune_2
)

select p.*, m.max_fecha
from bronze_max_2 m, bronze_prune_2 p













