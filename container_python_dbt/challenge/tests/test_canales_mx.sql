--Este es un test donde el analista debe anotar los canales que usualmentevienen mal escritos
select canal
from {{ ref('silver_full_cost_mexico') }}
where canal in ('ESPN 2')
