#!/bin/bash

code=$(command -v code-server || command -v code)

if [ -z $code ]; then
  echo "visual studio code is not installed" >&2
  exit 1
fi

$code --install-extension eamodio.gitlens
$code --install-extension hashicorp.terraform
$code --install-extension esbenp.prettier-vscode
$code --install-extension coenraads.bracket-pair-colorizer-2
$code --install-extension oderwat.indent-rainbow
$code --install-extension zbr.vscode-ansible
$code --install-extension pkief.material-icon-theme
$code --install-extension ms-azuretools.vscode-docker
$code --install-extension redhat.vscode-yaml
$code --install-extension christian-kohler.path-intellisense
$code --install-extension ms-vscode.azurecli
$code --install-extension davidanson.vscode-markdownlint

