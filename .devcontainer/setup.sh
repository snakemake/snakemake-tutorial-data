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
printf 'eval "$(pixi shell-hook --manifest-path %q)"\n' "$PWD/pixi.toml" >> ~/.bashrc

# Replace the default Codespaces welcome message shown in the first terminal
NOTICE=/usr/local/etc/vscode-dev-containers/first-run-notice.txt
if [ -f "$NOTICE" ]; then
  sudo tee "$NOTICE" > /dev/null <<'MSG'
👋 Welcome to the Snakemake tutorial!

Your Codespace has been initialized with all required software.
Now you can start with the basic tutorial:
https://snakemake.readthedocs.io/en/stable/tutorial/basics.html

MSG
fi

echo "Setup complete!"
