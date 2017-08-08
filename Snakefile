include: "helper.snake"
PARAMS = SVHelper(config, "structural variation")

onsuccess: PARAMS.onsuccess()
onerror: PARAMS.onerror()

# main workflow
localrules:
    all, link_sources

rule all:
    input:
        expand("structural_variation/last_region/{barcodes}.txt", barcodes=PARAMS.BARCODE_IDS)

    
include: "rules/link_sources.snake"
include: "rules/lastdb.snake"
include: "rules/lastal.snake"    
include: "rules/last_split.snake"
include: "rules/last_tab.snake"
include: "rules/last_region.snake"
