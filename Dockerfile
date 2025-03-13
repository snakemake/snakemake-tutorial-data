FROM snakemake/snakemake:stable
ADD environment.yaml .
RUN conda create -n snakemake-tutorial --clone snakemake; \
    conda env update -n snakemake-tutorial -f environment.yaml;
RUN mkdir -p /tmp/conda
ENV CONDA_PKGS_DIRS=/tmp/conda