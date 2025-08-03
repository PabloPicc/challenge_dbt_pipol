--Este es un test donde el analista debe anotar los canales que usualmente vienen mal escritos
select canal
from {{ ref('silver_full_cost_brasil') }}
where canal in ('ESPN 2')
