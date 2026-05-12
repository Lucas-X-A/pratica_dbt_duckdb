SELECT
    CAST(nu_ano_censo AS INTEGER) AS nu_ano_censo,
    CAST(co_entidade AS BIGINT) AS co_entidade,
    CAST(qt_gest_bas AS INTEGER) AS qt_gest_bas,

    -- Renomeando para bater com o que o INT espera:
    CAST(qt_gest_bas_esco_sup_grad AS INTEGER) 
        AS qt_graduado,

    CAST(qt_gest_bas_esco_sup_pos_espec AS INTEGER) 
        AS qt_pos_especialista,

    CAST(qt_gest_bas_esco_sup_pos_mestra AS INTEGER) 
        AS qt_pos_mestre,

    CAST(qt_gest_bas_esco_sup_pos_douto AS INTEGER) 
        AS qt_pos_doutor,

    CAST(qt_gest_bas_diretor AS INTEGER) 
        AS qt_diretor,

    -- Renomeando para facilitar o cálculo de acesso técnico:
    CAST(qt_gest_bas_acesso_cargo_conc AS INTEGER) 
        AS qt_acesso_tecnico, -- Aqui usamos o nome que o INT espera para o concurso

    CAST(qt_gest_bas_acesso_cargo_indic AS INTEGER) 
        AS qt_acesso_indicacao

FROM raw.tabela_gestor_escolar_2025