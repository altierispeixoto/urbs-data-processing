#!/bin/bash

# Define date range
START_DATE="2019-05-01"
END_DATE="2019-05-02"

# Define folders and files
declare -A files=(
  ["linhas"]="linhas.json.xz"
  ["pontoslinha"]="pontosLinha.json.xz"
  ["tabelalinha"]="tabelaLinha.json.xz"
  ["trechositinerarios"]="trechosItinerarios.json.xz"
  ["tabelaveiculo"]="tabelaVeiculo.json.xz"
  ["veiculos"]="veiculos.json.xz"
)

# Function to execute a docker-compose command
execute_docker_command() {
  local script=$1
  shift
  docker-compose exec jupyterlab python "dataprocessing/job/$script" "$@"
}

# Function to process files with a given script
process_files() {
  local script=$1
  local start_date=$2
  local end_date=$3
  for folder in "${!files[@]}"; do
    execute_docker_command "$script" -s "$start_date" -e "$end_date" -fd "$folder" -fl "${files[$folder]}"
  done
}

# Download and decompress files
process_files "download_files.py" "$START_DATE" "$END_DATE"
process_files "decompress_files.py" "$START_DATE" "$END_DATE"

# Execute trust ingestion
execute_docker_command "trust_ingestion.py" -d "2019-05"

# Define jobs
jobs=("line" "timetable" "bus-stop" "tracking")

# Execute refined ingestion for each job
for job in "${jobs[@]}"; do
  execute_docker_command "refined_ingestion.py" -ds "$START_DATE" -de "$END_DATE" -j "$job"
done

# Execute Neo4j ingestion and loader
execute_docker_command "neo4j_ingestion.py" -ds "$START_DATE" -de "$END_DATE"