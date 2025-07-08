rm -r Dockerfile .gitpod.yml .github
echo -e "# Snakemake-Tutorial\n\nYour gitpod workspace for the snakemake-tutorial has been initialized. Now you can start with the [basic tutorial](https://snakemake.readthedocs.io/en/stable/tutorial/basics.html)." > README.md
echo \"*\" > .gitignore
conda init
source ~/.bashrc
echo 'conda activate snakemake-tutorial' >> ~/.bashrc"