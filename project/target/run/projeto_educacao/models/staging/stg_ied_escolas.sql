
  
  create view "project_data"."main_staging"."stg_ied_escolas__dbt_tmp" as (
    SELECT
    CAST(nu_ano_censo AS INTEGER) AS nu_ano_censo,

    CAST(co_entidade AS BIGINT) AS co_entidade,

    sg_uf,
    no_municipio,
    no_entidade,

    CAST(NULLIF(fun_cat_1, '--') AS DOUBLE) AS fun_cat_1,
    CAST(NULLIF(fun_cat_2, '--') AS DOUBLE) AS fun_cat_2,
    CAST(NULLIF(fun_cat_3, '--') AS DOUBLE) AS fun_cat_3,
    CAST(NULLIF(fun_cat_4, '--') AS DOUBLE) AS fun_cat_4,
    CAST(NULLIF(fun_cat_5, '--') AS DOUBLE) AS fun_cat_5,
    CAST(NULLIF(fun_cat_6, '--') AS DOUBLE) AS fun_cat_6

FROM raw.ied_escolas_2025

WHERE sg_uf = 'RJ'
  );
