# Usar a imagem Node.js como base
FROM node:14

# Definir o diretório de trabalho
WORKDIR /app

# Copiar arquivos do backend para o contêiner
COPY package*.json ./
RUN npm install
COPY . .

# Expor a porta que o servidor Express está usando
EXPOSE 3000

# Comando para iniciar o servidor
CMD ["node", "app.js"]
