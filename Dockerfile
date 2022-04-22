FROM snakemake/snakemake:stable
ADD environment.yaml .
RUN grep -v snakemake-minimal environment.yaml > /tmp/environment.yaml; mamba env update -n snakemake -f /tmp/environment.yaml
