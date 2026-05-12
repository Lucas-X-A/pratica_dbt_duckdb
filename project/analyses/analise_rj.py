import duckdb
import plotly.express as px
import pandas as pd

# 1. Conexão com o banco gerado pelo dbt
con = duckdb.connect('project_data.duckdb') 

query = """
    SELECT 
        categoria_gestao, 
        AVG(indice_esforco_docente) as media_ied,
        COUNT(co_entidade) as total_escolas
    FROM main_serving.srv_hipotese_gestor_esforco_rj  -- Adicionado 'main_serving.'
    GROUP BY 1
    ORDER BY 1
"""

df = con.execute(query).df()

fig = px.bar(
    df, 
    x='categoria_gestao', 
    y='media_ied',
    color='categoria_gestao',
    title="Impacto da Qualificação do Gestor na Sobrecarga Docente (RJ 2025)",
    labels={'media_ied': 'Média IED (Esforço Docente)', 'categoria_gestao': 'Nível de Qualificação do Gestor'},
    text_auto='.2f'
)

fig.update_layout(yaxis_range=[1, 6], showlegend=False)
fig.show()

print("Análise concluída. O gráfico mostra se a média do IED cai conforme a gestão sobe de nível.")