FROM condaforge/mambaforge
ENV SHELL /bin/bash
ADD environment.yaml .
RUN mamba env create -n snakemake-tutorial -f environment.yaml
RUN bash -l -c "(source activate snakemake-tutorial; dot -c && dot -v)"
RUN find /opt/conda -type d -exec chmod 777 {} \; && \
    chmod -R o+w /opt/conda
    
