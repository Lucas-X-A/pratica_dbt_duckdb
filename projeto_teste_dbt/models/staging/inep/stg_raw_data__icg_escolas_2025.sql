with

source as (
    select * from {{ source('raw_data', 'icg_escolas_2025') }}
),

renamed_and_casted as (
    select
        cast(nu_ano_censo as int) as nu_ano_censo,
        cast(no_regiao as varchar) as no_regiao,
        cast(sg_uf as varchar) as sg_uf,
        
        -- Chaves padronizadas como varchar para evitar erro de join
        cast(co_municipio as varchar) as co_municipio,
        cast(no_municipio as varchar) as no_municipio,
        cast(co_entidade as varchar) as co_entidade,
        
        cast(no_entidade as varchar) as no_entidade,
        cast(no_categoria as varchar) as no_categoria,
        cast(no_dependencia as varchar) as no_dependencia,
        cast(complex as varchar) as complex
        
    from source
)

select * from renamed_and_casted