with

source as (
    select * from {{ source('raw_data', 'ied_escolas_2025') }}
),

renamed_and_casted as (
    select
        -- Tratamento robusto para os dados do INEP: 
        -- 1. replace: converte vírgula brasileira para ponto (se houver)
        -- 2. try_cast: converte para double, mas transforma strings ilegíveis (como '--') em NULL
        try_cast(replace(fun_cat_1, ',', '.') as double) as nivel_1_ed,
        try_cast(replace(fun_cat_2, ',', '.') as double) as nivel_2_ed,
        try_cast(replace(fun_cat_3, ',', '.') as double) as nivel_3_ed,
        try_cast(replace(fun_cat_4, ',', '.') as double) as nivel_4_ed,
        try_cast(replace(fun_cat_5, ',', '.') as double) as nivel_5_ed,
        try_cast(replace(fun_cat_6, ',', '.') as double) as nivel_6_ed,
        
        cast(nu_ano_censo as int) as nu_ano_censo,
        cast(no_regiao as varchar) as no_regiao,
        cast(sg_uf as varchar) as sg_uf,
        
        cast(co_municipio as varchar) as co_municipio,
        cast(no_municipio as varchar) as no_municipio,
        cast(co_entidade as varchar) as co_entidade,
        
        cast(no_entidade as varchar) as no_entidade,
        cast(no_categoria as varchar) as no_categoria,
        cast(no_dependencia as varchar) as no_dependencia

    from source
)

select * from renamed_and_casted