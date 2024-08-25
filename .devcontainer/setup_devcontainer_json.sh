#!/bin/bash
# Setup the devcontainer

function devcontainer_json() {
  cat <<EOF
{
  "name": "${COMPOSE_PROJECT_NAME}",
  "dockerComposeFile": "../docker-compose.yml",
  "service": "host",
  "workspaceFolder": "/home/${USER}/workspace/${COMPOSE_PROJECT_NAME}",
  "customizations": {
    "vscode": {
      "extensions": [
        "vscjava.vscode-java-pack",
        "eamodio.gitlens",
        "mhutchie.git-graph",
        "esbenp.prettier-vscode",
        "dbaeumer.vscode-eslint"
      ],
      "settings": {
        "terminal.integrated.defaultProfile.linux": "bash"
      },
      "profiles": {
        "bash": {
            "path": "/bin/bash"
        }
      }
    }
  }
}
EOF
}

project_root=$(dirname "${BASH_SOURCE[0]}")/..
if [ -e "${project_root}"/.env ]; then
  source "${project_root}"/.env
else
  echo "ERROR: ${project_root}/.env not found or not readable"
  exit 1
fi

if [ -e "${project_root}"/.devcontainer/devcontainer.json ]; then
  rm "${project_root}"/.devcontainer/devcontainer.json
fi

touch "${project_root}"/.devcontainer/devcontainer.json
echo $(devcontainer_json) >> "${project_root}"/.devcontainer/devcontainer.json