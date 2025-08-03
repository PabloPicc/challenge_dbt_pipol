--Tipo de materialización: Table. Es una tabla indispensable para llegar al KPI (gold).
{{ config(
   materialized="table"
) }}


--Para Brasil se reemplazan los Nulls con la media correspondiente a su segmento
--Se flaggea la pulicidad a la que realmente se le conoce el costo vs el que usa la mediana de su segmento

with junta as(
select *
from {{ref('bronze_mexico_union')}} bpb
inner join {{ref('silver_aggregated_cost')}} c on c.segmento_time_2 =bpb.segmento_time
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
tipo_spot,
mediana_valor as  valordolar,
case
	when 0>1 then True
	else False
end as true_cost
from junta
