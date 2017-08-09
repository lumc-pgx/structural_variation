include: "helper.snake"
PARAMS = SVHelper(config, "structural variation")

onsuccess: PARAMS.onsuccess()
onerror: PARAMS.onerror()

# main workflow
localrules:
    all, link_sources

rule all:
    input:
        PARAMS.outputs

    
include: "rules/link_sources.snake"
include: "rules/lastdb.snake"
include: "rules/lastal.snake"    
include: "rules/last_split.snake"
include: "rules/last_tab.snake"
include: "rules/last_region.snake"
