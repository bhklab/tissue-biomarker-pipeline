
# snakemake --use-envmodules


pset_names = [
  "GRAY_2017",
  "UHNBreast_2019",
  "CTRPv2_2015",
  "CCLE_2015"
]


rule all:
    input:
        expand("procdata/{pset_name}.RDS", pset_name=pset_names)
        # "procdata/pset_dir/michael.RDS",

rule preprocess_pset:
    input:
        pset = "rawdata/{pset_name}.RDS",
    output:
        pset = "procdata/{pset_name}.RDS"
    log:
        "logs/preprocess_pset/{pset_name}.log"
    script:
        "scripts/preprocess_pset_{wildcards.pset_name}.R"

rule download_pset:
    output:
        pset = "rawdata/{jermiah}.RDS"
    log:
        logfile = "logs/download_pset/{jermiah}.log"
    params:
        timeout = 3600
    script:
        "scripts/download_pset.R"

