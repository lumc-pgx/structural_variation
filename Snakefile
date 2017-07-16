# load config file
configfile: srcdir("config.yaml")

# imports
import os
import glob
import datetime

# globals
INPUT_FILES = glob.glob(config["LAA_DATA_PATH"] + "/*.fastq")
BARCODE_IDS = [".".join(os.path.basename(f).split(".")[:-1]) for f in INPUT_FILES]

LASTDB_PATH = config.get("LASTDB_PATH", "lastdb")
LASTDB_NAME = config.get("LASTDB_NAME", "database")
LASTDB = "{}/{}".format(LASTDB_PATH, LASTDB_NAME)
LASTDB_FILES = expand("{path}.{{suffix}}".format(path=LASTDB), suffix=["bck", "des", "prj", "sds", "ssp", "suf", "tis"])


# handlers for workflow exit status
onsuccess:
    print("Structural variation  workflow completed successfully")
    config_file = "config.{}.json".format("{:%Y-%m-%d_%H:%M:%S}".format(datetime.datetime.now()))
    with open(config_file, "w") as outfile:
        print(json.dumps(config), file=outfile)

onerror:
    print("Error encountered while executing workflow")
    shell("cat {log}")


# main workflow
localrules:
    all

rule all:
    input:
       "lastal/lbc32.maf"
     
      
rule lastdb:
    input:
        config["GENOME"]
    output:
        LASTDB_FILES
    params:
        db_name = LASTDB
    shell:
        "lastdb -P4 -uNEAR -R01 {params.db_name} {input}"


rule lastal:
    input:
        LASTDB_FILES,
        query = config["LAA_DATA_PATH"] + "/{barcode}.fastq"
    output:
        "lastal/{barcode}.maf"
    params:
        db_name = LASTDB
    shell:
       "lastal -P1 {params.db_name} {input.query} | last-split -m1e-6 > {output}"
