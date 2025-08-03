--Tipo de materialización: Table. Es una tabla indispensable para llegar al KPI (gold).
{{ config(
   materialized="table"
) }}


--Para Brasil se reemplazan los Nulls con la media correspondiente a su segmento
--Se flaggea la pulicidad a la que realmente se le conoce el costo vs el que usa la mediana de su segmento
with junta as(
select *
from {{ref('bronze_brasil_union')}} bpb
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
--Aqui es donde se corrige en caso de que no se pasen los tests
case
when marca='SPORTFLIX' then '$PORTFLIX'
when marca='PLAYGOOD' then 'PLAY-GOOD'
else marca
end as marca, 
producto,
localidad,
sector,
subsector,
segmento,
version,
tipo_spot,
case
	when valordolar>0 then valordolar
	else mediana_valor
end as valordolar,
case
	when valordolar>0 then True
	else False
end as true_cost
from junta
