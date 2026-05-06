with gestores as (
    select * from {{ ref('stg_raw_data__tabela_gestor_escolar_2025') }}
)

select
    co_entidade,
    qt_gest_bas,
    
    -- Definição da predominância de Gênero
    case
        when qt_gest_bas_fem > qt_gest_bas_masc then 'Maioria Feminina'
        when qt_gest_bas_masc > qt_gest_bas_fem then 'Maioria Masculina'
        else 'Equilibrado / Não Informado'
    end as perfil_genero,
    
    -- Proporção de pessoas Pretas/Pardas na gestão  
    case
        when coalesce(qt_gest_bas, 0) > 0 then
            (coalesce(qt_gest_bas_preta, 0) + coalesce(qt_gest_bas_parda, 0)) / cast(qt_gest_bas as double)
        else 0.0
    end as prop_gestores_negros

from gestores