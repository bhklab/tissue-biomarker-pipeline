#!/bin/bash

set -euo pipefail
# orcestra -vvv pharmacosets download -d rawdata "{wildcards.pset_IDENTIFIER}" | tee {log}

printf "Downloading pharmacoset data for pharmacoset: %s\n" "${snakemake_wildcards[pset_IDENTIFIER]}" 2>&1 | tee "${snakemake_log}"
printf "Output directory: %s\n" "${snakemake_output[0]}" 2>&1 | tee "${snakemake_log}"

orcestra -vvv pharmacosets download -d rawdata "${snakemake_wildcards[pset_IDENTIFIER]}" 2>&1 | tee "${snakemake_log}"
 
#  The  download_pset.sh  script is a simple bash script that downloads the pharmacoset data from the Orcestra platform. The script is executed]