--Este es un test donde el analista debe anotar las marcas que usualmentevienen mal escritos
select marca
from {{ ref('silver_full_cost_brasil') }}
where marca in ('SPORTFLIX','PLAYGOOD')
