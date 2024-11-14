# Use uma imagem base Ubuntu
FROM ubuntu:latest

# Evita prompts durante a instalação
ENV DEBIAN_FRONTEND=noninteractive

# Instala dependências necessárias
RUN apt-get update && apt-get install -y \
    curl \
    git \
    wget \
    unzip \
    xz-utils \
    libglu1-mesa \
    chromium-browser \
    && rm -rf /var/lib/apt/lists/*

# Define variáveis de ambiente
ENV FLUTTER_HOME=/usr/local/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

# Download e instalação do Flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME && \
    cd $FLUTTER_HOME && \
    git checkout stable

# Aceita licenças e pré-baixa dependências
RUN flutter precache && \
    flutter doctor && \
    flutter config --enable-web

# Define o diretório de trabalho
WORKDIR /app

# Copia os arquivos do projeto
COPY . .

# Baixa as dependências do projeto
RUN flutter pub get

# Expõe a porta para desenvolvimento
EXPOSE 8080

# Comando para iniciar o servidor de desenvolvimento
CMD ["flutter", "run", "--web-port", "8080", "--web-hostname", "0.0.0.0", "-d", "web-server"]
