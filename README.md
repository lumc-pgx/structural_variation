# Structural Variation Workflow

**Identification of structural variants for the pharmacogenomics pipeline**  

The structural variation module performs the following  operations:  
- Align of amplicons to the reference genome using [LAST](http://last.cbrc.jp/).
- Identify split alignments
- Summarize split alignments

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

