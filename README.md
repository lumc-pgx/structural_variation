# Structural Variation Workflow

**Identification of structural variants for the pharmacogenomics pipeline**  

The structural variation module performs the following  operations:  
- Align of amplicons to the reference genome using [LAST](http://last.cbrc.jp/).
- Identify split alignments
- Summarize split alignments

```plantuml
digraph snakemake_dag {
	graph [bb="0,0,147,396",
		bgcolor=white,
		margin=0
	];
	node [fontname=sans,
		fontsize=10,
		label="\N",
		penwidth=2,
		shape=box,
		style=rounded
	];
	edge [color=grey,
		penwidth=2
	];
	0	 [color="0.00 0.6 0.85",
		height=0.5,
		label=last_tab,
		pos="68,162",
		width=0.75694];
	3	 [color="0.19 0.6 0.85",
		height=0.5,
		label=last_region,
		pos="68,90",
		width=0.95139];
	0 -> 3	 [pos="e,68,108.1 68,143.7 68,135.98 68,126.71 68,118.11"];
	1	 [color="0.29 0.6 0.85",
		height=0.5,
		label=last_split,
		pos="68,234",
		width=0.8125];
	1 -> 0	 [pos="e,68,180.1 68,215.7 68,207.98 68,198.71 68,190.11"];
	2	 [color="0.10 0.6 0.85",
		height=0.5,
		label=all,
		pos="68,18",
		width=0.75];
	3 -> 2	 [pos="e,68,36.104 68,71.697 68,63.983 68,54.712 68,46.112"];
	4	 [color="0.38 0.6 0.85",
		height=0.5,
		label=lastdb,
		pos="27,378",
		width=0.75];
	6	 [color="0.57 0.6 0.85",
		height=0.5,
		label=lastal,
		pos="68,306",
		width=0.75];
	4 -> 6	 [pos="e,57.982,324.1 37.135,359.7 41.852,351.64 47.562,341.89 52.782,332.98"];
	5	 [color="0.48 0.6 0.85",
		height=0.5,
		label=link_sources,
		pos="110,378",
		width=1.0347];
	5 -> 6	 [pos="e,78.263,324.1 99.618,359.7 94.735,351.56 88.813,341.69 83.421,332.7"];
	6 -> 1	 [pos="e,68,252.1 68,287.7 68,279.98 68,270.71 68,262.11"];
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
           
