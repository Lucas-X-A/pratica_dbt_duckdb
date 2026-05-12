-- srv_analise_hipotese_rj.sql

with esforco as (
    select * from "project_data"."main_intermediate"."int_professor_esforco_rj"
),

gestores as (
    select * from "project_data"."main_intermediate"."int_gestor_qualificacao"
),

final as (
    select
        e.co_entidade,
        e.no_entidade,
        e.no_municipio,
        e.ied as indice_esforco_docente,
        g.score_qualificacao_gestor,
        
        -- Categorização do Gestor para o Eixo X do gráfico
        case 
            when g.score_qualificacao_gestor < 0.3 then '1. Baixa Qualificação'
            when g.score_qualificacao_gestor < 0.6 then '2. Qualificação Média'
            when g.score_qualificacao_gestor < 0.8 then '3. Qualificação Alta'
            else '4. Qualificação de Elite'
        end as categoria_gestao,

        -- Flag para destacar escolas com Doutores/Concurso no gráfico
        case 
            when g.score_qualificacao_gestor >= 0.8 then 'Sim'
            else 'Não'
        end as fl_gestao_referencia

    from esforco e
    inner join gestores g 
        on e.co_entidade = g.co_entidade 
        and e.nu_ano_censo = g.nu_ano_censo
)

select * from final