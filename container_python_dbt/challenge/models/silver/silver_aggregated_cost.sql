--Tipo de materialización: View. Es una tabla pequeña y de uso totalmente intermedio.
{{ config(
   materialized="view"
) }}

--El promedio no me parece un buen indicador ya que los outliers pueden afctar mucho el número final
--Me parece mejor usar la mediana

SELECT PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valordolar) AS mediana_valor, segmento_time as segmento_time_2
FROM {{ref('bronze_brasil_union')}} 
group by segmento_time_2
