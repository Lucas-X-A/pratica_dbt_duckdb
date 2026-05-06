with icg as (
    select * from {{ ref('stg_raw_data__icg_escolas_2025') }}
),

ied as (
    select * from {{ ref('stg_raw_data__ied_escolas_2025') }}
)

select
    icg.co_entidade,
    icg.no_dependencia,
    icg.complex as nivel_complexidade,
    
    -- Somatório dos níveis críticos de esforço docente (5 e 6)
    coalesce(ied.nivel_5_ed, 0) + coalesce(ied.nivel_6_ed, 0) as tx_esforco_docente_critico

from icg
left join ied on icg.co_entidade = ied.co_entidade