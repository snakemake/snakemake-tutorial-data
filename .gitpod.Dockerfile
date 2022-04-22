FROM snakemake/snakemake-tutorial:stable
RUN find /opt/conda -type d -exec chmod 777 {} \; && \
    chmod -R o+w /opt/conda
    
