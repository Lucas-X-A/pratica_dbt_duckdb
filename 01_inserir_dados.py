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

    caminho_pasta = Path(DATA_FOLDER)
    arquivos_csv = list(caminho_pasta.glob('*.csv'))

    if not arquivos_csv:
        print(f"Nenhum arquivo CSV encontrado na pasta '{DATA_FOLDER}'.")
        return

    print(f"Iniciando o processamento de {len(arquivos_csv)} arquivo(s)...\n")

    for arquivo in arquivos_csv:
        nome_tabela = arquivo.stem 
        
        print(f"-> Lendo {arquivo.name} e carregando na tabela '{nome_tabela}'...")
        
        try:
            # Separador ';' definido e inferência natural ativada.
            # low_memory=False garante que o Pandas não confunda os tipos ao ler arquivos pesados em pedaços.
            df = pd.read_csv(arquivo, sep=';', low_memory=False)
            
        except UnicodeDecodeError:
            print(f"   Aviso: Falha de encoding (UTF-8) para {arquivo.name}. Acionando fallback para 'ISO-8859-1'...")
            # Fallback focado na correção de acentuação/encoding, mantendo a inferência de tipos
            df = pd.read_csv(arquivo, sep=';', encoding='ISO-8859-1', low_memory=False)

        load_info = pipeline.run(
            df, 
            table_name=nome_tabela,
            write_disposition="replace" 
        )
        
        print(f"Carga da tabela '{nome_tabela}' finalizada com sucesso!\n")

if __name__ == "__main__":
    carregar_dados_educacionais()