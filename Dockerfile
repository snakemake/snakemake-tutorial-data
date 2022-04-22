FROM snakemake/snakemake:stable
ADD environment.yaml .
RUN mamba create -n snakemake-tutorial --clone snakemake; \
    mamba env update -n snakemake-tutorial -f environment.yaml;
RUN mkdir -p /tmp/conda
ENV CONDA_PKGS_DIRS /tmp/conda