with perfil_gestor as (
    select * from {{ ref('int_escolas__perfil_gestor') }}
),

indicadores as (
    select * from {{ ref('int_escolas__indicadores') }}
),

final as (
    select
        ind.co_entidade,
        ind.no_dependencia,
        ind.nivel_complexidade,
        ind.tx_esforco_docente_critico,
        gest.perfil_genero,
        gest.prop_gestores_negros,
        
        -- Classificando a escola por maioria racial na gestão
        case
            when gest.prop_gestores_negros >= 0.5 then 'Gestão Maioria Negra (Preta/Parda)'
            else 'Gestão Maioria Branca/Outras'
        end as perfil_raca

    from indicadores ind
    inner join perfil_gestor gest on ind.co_entidade = gest.co_entidade
    -- Filtramos apenas escolas com ICG calculado
    where ind.nivel_complexidade is not null
)

select * from final