import duckdb
import plotly.express as px

# Conexão com o banco gerado pelo dbt
con = duckdb.connect("project_data.duckdb")

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

print("\n" + "=" * 50)
print("HIPÓTESE DA PESQUISA:")
print("A qualificação acadêmica e a forma de ingresso do gestor impactam")
print("diretamente no índice de esforço e sobrecarga dos docentes no RJ?\n")

print("RESULTADOS AGREGADOS:")
print(df.to_string(index=False))
print("=" * 50 + "\n")
print("Abrindo visualização gráfica...")

fig = px.bar(
    df,
    x="categoria_gestao",
    y="media_ied",
    color="categoria_gestao",
    title="Impacto da Qualificação do Gestor na Sobrecarga Docente (RJ 2025)",
    labels={
        "media_ied": "Média IED (Esforço Docente)",
        "categoria_gestao": "Nível de Qualificação do Gestor",
    },
    text_auto=True, 
)

fig.update_traces(texttemplate='%{y:.2f}', textposition='auto') # Formata o texto dos rótulos das barras
fig.update_layout(yaxis_range=[1, 6], showlegend=False)
fig.show()

print("\nCONCLUSÃO:")
print("Análise concluída. O gráfico demonstra visualmente se a média do IED")
print("cai conforme a categoria de gestão sobe de nível.")
