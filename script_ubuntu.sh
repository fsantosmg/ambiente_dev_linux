#!/bin/bash

# Atualiza o sistema
echo "Atualizando o sistema..."
sudo apt update && sudo apt upgrade -y

# Instala pacotes essenciais
echo "Instalando pacotes essenciais..."
sudo apt install -y make build-essential libssl-dev zlib1g-dev \
  libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
  libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev \
  libffi-dev liblzma-dev libgdbm-dev libnss3-dev libdb-dev libfuse2

# Instala o Docker
echo "Instalando o Docker..."
sudo apt install -y ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "Adicionando usuário ao grupo docker..."
sudo usermod -aG docker $USER
sudo systemctl enable docker
sudo systemctl start docker
sudo docker run hello-world

# Instala o NVM
echo "Instalando o NVM..."
curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash
echo "exportando variáveis do NVM..."
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
nvm install --lts
nvm use --lts
echo "Node.js versão LTS instalada e ativada via NVM."

# Instala o Maven
echo "Instalando o Maven..."
sudo apt install -y maven

# Instala o SDKMAN
echo "Instalando o SDKMAN..."
curl -s "https://get.sdkman.io" | bash
source "$HOME/.sdkman/bin/sdkman-init.sh"

# Instala o Visual Studio Code
echo "Instalando o Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/packages.microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt update
sudo apt install -y code
rm packages.microsoft.gpg

# Instala o Google Chrome
echo "Instalando o Google Chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install -y ./google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

# Instala o Expo CLI (via npm)
echo "Instalando o Expo CLI..."
npm install -g expo-cli

# Instala o Poetry (gerenciador de dependências Python)
echo "Instalando o Poetry..."
curl -sSL https://install.python-poetry.org | python3 -
echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc

# Instala o pyenv (gerenciador de versões Python)
echo "Instalando o pyenv..."
curl https://pyenv.run | bash

# Configura o pyenv no bashrc
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init --path)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc
source ~/.bashrc

# Instala Python 3.12.9 com pyenv e define como padrão
echo "Instalando Python 3.12.9 com pyenv..."
pyenv install 3.12.9
pyenv global 3.12.9

# Recarrega o bashrc
echo "Recarregando o .bashrc..."
source ~/.bashrc

# Instala o Java 21.0.6 Oracle via SDKMAN
echo "Instalando Java 21.0.6 Oracle..."
sdk install java 21.0.6-oracle

# Reinstala Node.js LTS via NVM
echo "Reinstalando Node.js LTS pelo NVM..."
nvm install --lts

# Instala Postman, Insomnia e Discord via Snap
echo "Instalando Postman, Insomnia e Discord via Snap..."
sudo snap install postman
sudo snap install insomnia
sudo snap install discord

echo "Instalação concluída! Reinicie seu terminal para aplicar as mudanças."
