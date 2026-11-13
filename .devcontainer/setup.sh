#!/bin/bash
set -e

echo "Setting up Snakemake tutorial environment..."

# Clean up workspace
rm -f Dockerfile
echo "*" > .gitignore

# Install pixi
curl -fsSL https://pixi.sh/install.sh | PIXI_NO_PATH_UPDATE=1 bash
export PATH="$HOME/.pixi/bin:$PATH"
echo 'export PATH="$HOME/.pixi/bin:$PATH"' >> ~/.bashrc

# Create and activate the tutorial environment, conda is needed for --sdm conda
[ -f pixi.toml ] || pixi init --import environment.yaml
pixi add conda
echo 'eval "$(pixi shell-hook)"' >> ~/.bashrc

echo "Setup complete!"
