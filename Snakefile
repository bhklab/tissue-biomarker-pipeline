import pandas as pd

pset_mapping = {
    "CTRPv2": "CTRPv2-unfiltered",
    "GDSC2": "GDSC_2020(v2-8.2)_unfiltered_u133a",
    "GDSC1": "GDSC1_unfiltered_oldarray",
    "CCLE": "CCLE_2015_unfiltered",
    "GRAY": "GRAY_2017",
    "UHNBreast": "UHNBreast_2019_unfiltered",
    "gCSI": "gCSI_2019",
    "PRISM": "PRISM_2020",
}

rule filter_all:
    input:
        expand("procdata/filtered_{pset_NAME}.RDS", pset_NAME=pset_mapping.keys())

rule preprocess_pset:
    input:
        pset = collect(
            "rawdata/pharmacosets/{pset_IDENTIFIER}.RDS",
            pset_IDENTIFIER=lookup(
                '{pset_NAME}',
                within=pset_mapping,
            )
        )
    output:
        pset = "procdata/filtered_{pset_NAME}.RDS"
    log:
        "logs/preprocess_pset/{pset_NAME}.log"
    script:
        "workflow/scripts/preprocess_pset.R"

rule download_pset:
    output:
        pset = "rawdata/pharmacosets/{pset_IDENTIFIER}.RDS"
    log:
        logfile = "logs/download_pset/{pset_IDENTIFIER}.log"
    script:
        "workflow/scripts/download_pset.sh"