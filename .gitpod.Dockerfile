FROM snakemake/snakemake:stable
ADD environment.yaml .
RUN mamba env update -n snakemake -f <(grep -v snakemake-minimal environment.yaml)
