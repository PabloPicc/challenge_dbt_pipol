--Tipo de materialización: incremental. Para que solo detecte nuevos cambios
{{ config(
   materialized="incremental"
) }}

--Se unen todas las tablas de México previamente transformadas y pruneadas
--Mediante row_number eliminamos duplicados y nos quedamos con los registros actualizados
--Esto también permite manejar el problema de los falsos positivos

with todo_brasil as (
select * from {{ref('bronze_prune_brasil_31')}}
union all
select * from {{ref('bronze_prune_brasil_01')}} 
),
row_num_adv as (
    SELECT
        *,
        row_number() over(partition by canal,fecha,hora,version order by max_fecha desc) as row_num
    FROM todo_brasil
)
select
r.Pais,
r.medio,
r.canal, 
r.grupo_comercial,
r.fecha,
r.hora,
r.segmento_time,
r.duracion, 
r.marca, 
r.producto,
r.localidad,
r.sector,
r.subsector,
r.segmento,
r.version,
r.tipo_spot,
r.valordolar
FROM row_num_adv r
WHERE row_num = 1












