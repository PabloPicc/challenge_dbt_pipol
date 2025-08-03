--Tipo de materialización: incremental. Para que solo detecte nuevos cambios
{{ config(
   materialized="view"
) }}

--Se realiza el pruneo de las columnas que no usaremos y las transformaciones que nos interesan
--Manipuleo de datos horarios, se divide en segmentos horarios (prime time, grey time, etc)
--Se tuvo que realizar varias transformaciones en el campo "fecha" ya que vino en un formato poco accesible

with bronze_prune as(
select 
pais,
medio,
emisora as canal, 
red as grupo_comercial,
to_date(fecha,'dd/mm/YYYY') as fecha,
hora,
case 
	when cast(substring(hora,1,2) as int)>=18 or cast(substring(hora,1,2) as int)<2 then 'PrimeTime'
	when cast(substring(hora,1,2) as int)>=2 and cast(substring(hora,1,2) as int)<8 then 'GreyTime'
	else 'Day'
end as segmento_time,
duracion, 
marca, 
producto,
plaza as localidad,
sector,
subsector,
segmento,
version,
evento as tipo_spot,
valordolar
from {{source('mercados_latam','brasil_2024_08_31')}} m
),
bronze_max as(
select max(fecha) as max_fecha
from bronze_prune 
)

select b.*, m.max_fecha
from bronze_max m, bronze_prune b












