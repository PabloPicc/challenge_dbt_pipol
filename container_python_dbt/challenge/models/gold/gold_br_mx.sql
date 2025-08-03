--Tipo de materialización: Tabla. Será usado por las gerencias
{{ config(
   materialized="table"
) }}

--Se unen las tabla sya procesadas de todos los países

select * from {{ref('silver_full_cost_brasil')}}
union all
select * from {{ref('silver_full_cost_mexico')}} 

