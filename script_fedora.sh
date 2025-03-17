#!/bin/bash

# Atualiza o sistema
echo "Atualizando o sistema..."
sudo dnf update -y

# Habilita repositórios de terceiros (RPM Fusion e Flathub)
echo "Habilitando repositórios RPM Fusion e Flathub..."
sudo dnf install -y dnf-plugins-core
sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install -y https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# Instala pacotes essenciais
echo "Instalando pacotes essenciais..."
sudo dnf install -y curl wget git unzip tar gcc-c++ make

# Instala o Docker
echo "Instalando o Docker..."
sudo dnf install -y dnf-plugins-core
sudo dnf-3 config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Adicionando usuário ao grupo docker..."
sudo usermod -aG docker $USER
sudo systemctl enable --now docker
sudo docker run hello-world

# Instala o NVM
echo "Instalando o NVM..."
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
echo "exportando variáveis do NVM..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \ . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \ . "$NVM_DIR/bash_completion"
nvm install --lts

# Instala o Maven
echo "Instalando o Maven..."
sudo dnf install -y maven

# Instala o SDKMAN
echo "Instalando o SDKMAN..."
curl -s "https://get.sdkman.io" | bash
echo "exportando variáveis do SDKMAN..."
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Instala o Visual Studio Code
echo "Instalando o Visual Studio Code..."
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
sudo dnf install -y code

# Instala o Google Chrome
echo "Instalando o Google Chrome..."
sudo dnf install -y fedora-workstation-repositories
sudo dnf config-manager --set-enabled google-chrome
sudo dnf install -y google-chrome-stable

# Recarrega o bashrc
echo "Recarregando o .bashrc..."
source ~/.bashrc

# Instala o Java 21.0.6 Oracle
echo "Instalando Java 21.0.6 Oracle..."
sdk install java 21.0.6-oracle

# Executa novamente a instalação do NVM LTS
echo "Reinstalando Node.js LTS pelo NVM..."
nvm install --lts

echo "Instalação concluída! Reinicie seu terminal para aplicar as mudanças."
