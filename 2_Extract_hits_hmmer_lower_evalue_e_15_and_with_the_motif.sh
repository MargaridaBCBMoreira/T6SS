# #!/bin/bash

# # Directories for genomic data
# APIBACTER_HITS="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/Hmmer_hits_genomes/Apibacter"
# GILLIAMELLA_HITS="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/Hmmer_hits_genomes/Gilliamella"
# FRISCHELLA_HITS="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/Hmmer_hits_genomes/Frischella"
# SNODGRASSELLA_HITS="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/Hmmer_hits_genomes/Snodgrassella"

# # Array of directories
# BASE_DIR=(
#     "$APIBACTER_HITS"
#     "$GILLIAMELLA_HITS"
#     "$FRISCHELLA_HITS"
#     "$SNODGRASSELLA_HITS"
# )

# # Output directory for filtered hits
# OUTPUT_DIR="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/filtered_hits"
# mkdir -p "$OUTPUT_DIR"

# # Iterate through each directory
# for folder in "${BASE_DIR[@]}"; do
#   if [ -d "$folder" ]; then
#     # Extract folder name (e.g., Apibacter, Gilliamella, etc.)
#     FOLDER_NAME=$(basename "$folder")
    
#     # Output file for filtered hits
#     FILTERED_FILE="${OUTPUT_DIR}/${FOLDER_NAME}_filtered_hits.txt"
#     > "$FILTERED_FILE" # Clear/create the output file
    
#     # Add the first two header lines from an existing HMMER file
#     FIRST_FILE=$(find "$folder" -type f -name "*.txt" | head -n 1)
#     if [ -n "$FIRST_FILE" ]; then
#       # Extract the first two header lines (lines starting with `#`)
#       awk '/^#/{print} NR==2 {exit}' "$FIRST_FILE" >> "$FILTERED_FILE"
#     fi

#     # Iterate through each .txt file in the folder
#     for file in "$folder"/*.txt; do
#       if [ -f "$file" ]; then
#         # Extract all columns for hits with E-value < 1e-15 and append to the output file
#         awk '!/^#/ && $5+0 < 1e-15 {print}' "$file" >> "$FILTERED_FILE"
#       fi
#     done

#     echo "Filtered hits for $FOLDER_NAME saved in $FILTERED_FILE"
#   fi
# done

#!/bin/bash

# Caminhos
INPUT_DIR="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/2_filtered_sequences"
FILTERED_OUTPUT="/media/share/MGS/VM_data/mmoreira/Projects/Distribution_of_RHS_toxins_in_metagenomes/2_filtered_sequences_evalue_DPxG"

# Criar diretório de saída, se não existir
mkdir -p "$FILTERED_OUTPUT"

# Iterar pelos arquivos FASTA no diretório de sequências filtradas
for fasta_file in "$INPUT_DIR"/*.fasta; do
  # Nome base do arquivo (ex. Apibacter_filtered_hit_sequences.fasta -> Apibacter)
  BASE_NAME=$(basename "$fasta_file" _filtered_hit_sequences.fasta)

  # Arquivo de saída para as sequências filtradas
  OUTPUT_FILE="${FILTERED_OUTPUT}/${BASE_NAME}_DPxG_filtered.fasta"

  # Filtrar as sequências contendo o motivo DPxG(18)DPxG
  seqkit grep -s -r -p "DP.G.{18}DP.G" "$fasta_file" > "$OUTPUT_FILE"

  echo "Sequências filtradas de $BASE_NAME salvas em $OUTPUT_FILE"
done

