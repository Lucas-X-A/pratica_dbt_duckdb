import dlt
import pandas as pd
from pathlib import Path

# --- Variáveis Globais de Configuração ---
DATA_FOLDER = 'data'
DUCKDB_DATABASE = 'project_data.duckdb'
SCHEMA_NAME = 'raw_data'
# -----------------------------------------

def carregar_dados_educacionais():
    pipeline = dlt.pipeline(
        pipeline_name='educacao_pipeline',
        destination=dlt.destinations.duckdb(credentials=DUCKDB_DATABASE),
        dataset_name=SCHEMA_NAME
    )

    # Mapeia a pasta de dados e busca todos os arquivos .csv
    caminho_pasta = Path(DATA_FOLDER)
    arquivos_csv = list(caminho_pasta.glob('*.csv'))

    if not arquivos_csv:
        print(f"Nenhum arquivo CSV encontrado na pasta '{DATA_FOLDER}'.")
        return

    print(f"Iniciando o processamento de {len(arquivos_csv)} arquivo(s)...\n")

    # Itera sobre cada arquivo CSV encontrado na pasta
    for arquivo in arquivos_csv:
        # Usa o nome do arquivo (sem o .csv) para nomear a tabela no DuckDB
        nome_tabela = arquivo.stem 
        
        print(f"-> Lendo {arquivo.name} e carregando na tabela '{nome_tabela}'...")
        
        # Tenta carregar com o padrão (UTF-8 e vírgula)
        try:
            df = pd.read_csv(arquivo)
        except (UnicodeDecodeError, pd.errors.ParserError):
            print(f"   Aviso: Formato padrão falhou para {arquivo.name}. Acionando fallback (sep=';', encoding='ISO-8859-1')...")
            # Fallback em caso de falha de encoding ou separador
            df = pd.read_csv(arquivo, sep=';', encoding='ISO-8859-1')

        # Executa a ingestão deste arquivo específico usando o dlt
        load_info = pipeline.run(
            df, 
            table_name=nome_tabela,
            write_disposition="replace" 
        )
        
        print(f"Carga da tabela '{nome_tabela}' finalizada com sucesso!\n")

if __name__ == "__main__":
    carregar_dados_educacionais()