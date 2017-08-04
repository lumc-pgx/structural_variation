# Structural Variation Workflow

**Identification of structural variants for the pharmacogenomics pipeline**  

The structural variation module performs the following  operations:  
- Align of amplicons to the reference genome using [LAST](http://last.cbrc.jp/).
- Identify split alignments
- Summarize split alignments

```plantuml
digraph snakemake_dag {
    graph[bgcolor=white, margin=0];
    node[shape=box, style=rounded, fontname=sans,                 fontsize=10, penwidth=2];
    edge[penwidth=2, color=grey];
	0[label = "lastal", color = "0.22 0.6 0.85", style="rounded"];
	1[label = "last_tab", color = "0.11 0.6 0.85", style="rounded"];
	2[label = "last_regions", color = "0.44 0.6 0.85", style="rounded"];
	3[label = "last_split", color = "0.33 0.6 0.85", style="rounded"];
	4[label = "all", color = "0.56 0.6 0.85", style="rounded"];
	5[label = "lastdb", color = "0.00 0.6 0.85", style="rounded"];
	5 -> 0
	3 -> 1
	1 -> 2
	0 -> 3
	2 -> 4
}
```
 
## Requirements
- [Conda/Miniconda](https://conda.io/miniconda.html)  

## Installation
- Clone the repository
  - `git clone https://git.lumc.nl/PharmacogenomicsPipe/structural_variation.git`

- Change to the structural_variaiton directory
  - `cd structural_variation`

- Create a conda environment for running the pipeline
  - `conda env create -n structural_variation -f environment.yaml`

- In order to use the pipeline on the cluster, update your .profile to use the drmaa library:
  - `echo "export DRMAA_LIBRARY_PATH=libdrmaa.so.1.0" >> ~/.profile`
  - `source ~/.profile`

## Configuration
Pipeline configuration settings can be altered by editing [config.yaml](config.yaml).  

## Execution
- Activate the conda environment
  - `source activate structural_variation`
- For parallel execution on the cluster
  - `pipe-runner`
- To specify that the pipeline should write output to a location other than the default:
  - `pipe-runner --directory path/to/output/directory`
           
