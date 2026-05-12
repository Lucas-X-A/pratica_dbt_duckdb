import dlt
import pandas as pd
from pathlib import Path

DATA_FOLDER = "data"
DUCKDB_DATABASE = "project_data.duckdb"

pipeline = dlt.pipeline(
    pipeline_name="educacao_pipeline",
    destination=dlt.destinations.duckdb(
        credentials=DUCKDB_DATABASE
    ),
    dataset_name="raw"
)

def normalizar_nome(nome):
    return (
        nome.lower()
        .replace(" ", "_")
        .replace("-", "_")
    )

def carregar_dados():

    arquivos_csv = list(
        Path(DATA_FOLDER).glob("*.csv")
    )

    for arquivo in arquivos_csv:

        nome_tabela = normalizar_nome(
            arquivo.stem
        )

        print(f"Carregando {arquivo.name}")

        try:
            df = pd.read_csv(
                arquivo,
                sep=";",
                low_memory=False
            )

        except UnicodeDecodeError:

            df = pd.read_csv(
                arquivo,
                sep=";",
                encoding="ISO-8859-1",
                low_memory=False
            )

        df.columns = [
            c.lower()
            for c in df.columns
        ]

        pipeline.run(
            df,
            table_name=nome_tabela,
            write_disposition="replace"
        )

        print(f"Tabela raw.{nome_tabela} criada")

if __name__ == "__main__":
    carregar_dados()