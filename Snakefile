include: "helper.snake"
PARAMS = SVHelper(config, "structural variation")


# main workflow
localrules:
    all

rule all:
    input:
        PARAMS.outputs
    
      
rule lastdb:
    input:
        config["GENOME"]
    output:
        PARAMS.database_files
    params:
        db_base = PARAMS.database_base
    conda:
        "envs/last.yaml"
    shell:
        "lastdb -P4 -uNEAR -R01 {params.db_base} {input}"


rule lastal:
    input:
        rules.lastdb.output,
        query = config["ALLELE_FASTQ_PATH"] + "/{barcode}.fastq"
    output:
        "lastal/{barcode}.maf"
    params:
        db_name = PARAMS.database_base
    conda:
        "envs/last.yaml"
    shell:
       "lastal -P1 -Q1 -D100 {params.db_name} {input.query} > {output}"


rule last_split:
    input:
        "lastal/{barcode}.maf"
    output:
        "last_split/{barcode}.maf"
    conda:
        "envs/last.yaml"
    shell:
        "last-split -m1e-6 {input} > {output}"


rule last_tab:
    input:
        "last_split/{barcode}.maf"
    output:
        "last_tab/{barcode}.tab"
    conda:
        "envs/last.yaml"
    shell:
        "maf-convert tab {input} > {output}"


rule last_regions:
    input:
        "last_tab/{barcode}.tab"
    output:
        "last_region/{barcode}.txt"
    script:
        "scripts/parse_tab.py"
