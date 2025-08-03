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
Pais,
medio,
canal, 
grupo_comercial,
fecha,
hora,
segmento_time,
duracion, 
marca, 
producto,
localidad,
sector,
subsector,
segmento,
 version,
 tipo_spot
FROM row_num_adv
WHERE row_num = 1












