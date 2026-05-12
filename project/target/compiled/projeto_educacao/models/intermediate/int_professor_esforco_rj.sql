-- int_professor_esforco_rj.sql
with source as (
    select * from "project_data"."main_staging"."stg_ied_escolas"
    where sg_uf = 'RJ'
),

calculo_total as (
    select
        *,
        -- Soma de todas as categorias para ter o denominador
        (coalesce(fun_cat_1, 0) + coalesce(fun_cat_2, 0) + coalesce(fun_cat_3, 0) + 
         coalesce(fun_cat_4, 0) + coalesce(fun_cat_5, 0) + coalesce(fun_cat_6, 0)) as total_docentes
    from source
),

ied_calculado as (
    select
        co_entidade,
        nu_ano_censo,
        no_entidade,
        no_municipio,
        total_docentes,
        -- Média ponderada: (Qtd na Categoria * Peso da Categoria) / Total
        case 
            when total_docentes = 0 then null
            else round(
                cast(
                    (fun_cat_1 * 1.0) + (fun_cat_2 * 2.0) + (fun_cat_3 * 3.0) + 
                    (fun_cat_4 * 4.0) + (fun_cat_5 * 5.0) + (fun_cat_6 * 6.0)
                as double) / total_docentes, 2
            )
        end as ied
    from calculo_total
)

select * from ied_calculado