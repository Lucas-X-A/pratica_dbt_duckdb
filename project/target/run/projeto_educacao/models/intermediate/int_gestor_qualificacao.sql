
  
  create view "project_data"."main_intermediate"."int_gestor_qualificacao__dbt_tmp" as (
    -- int_gestor_qualificacao.sql

with stg_gestor as (
    select * from "project_data"."main_staging"."stg_gestor_escolar"
),

stg_escolas_rj as (
    -- Usamos a staging de escolas apenas para filtrar o estado
    select co_entidade from "project_data"."main_staging"."stg_ied_escolas"
    where sg_uf = 'RJ'
),

filtrado_rj as (
    select g.* 
    from stg_gestor g
    inner join stg_escolas_rj e on g.co_entidade = e.co_entidade
),

metricas as (
    select
        co_entidade,
        nu_ano_censo,
        qt_gest_bas as total_gestores,
        -- Índice de Qualificação Acadêmica (IQA)
        -- Pesos: Graduação(1), Especialização(2), Mestrado(3), Doutorado(4)
        case 
            when total_gestores = 0 then null
            else round(
                cast(
                    (qt_graduado * 1) + 
                    (qt_pos_especialista * 2) + 
                    (qt_pos_mestre * 3) + 
                    (qt_pos_doutor * 4) 
                as double) / (4.0 * total_gestores), 4
            )
        end as idx_qualificacao_academica,

        -- Proporção de Acesso Técnico (Concurso/Seleção/Eleição)
        case 
            when total_gestores = 0 then null
            else round(cast(qt_acesso_tecnico as double) / total_gestores, 4)
        end as prop_acesso_tecnico
    from filtrado_rj
)

select 
    *,
    -- Score Composto: Média entre formação e forma de acesso
    round((idx_qualificacao_academica + prop_acesso_tecnico) / 2.0, 4) as score_qualificacao_gestor
from metricas
  );
