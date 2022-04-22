FROM snakemake/snakemake:stable
ADD environment.yaml .
RUN mamba env create -n snakemake-tutorial -f environment.yaml
