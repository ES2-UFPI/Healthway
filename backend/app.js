const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

// Permitir CORS para todas as origens
app.use(cors());

app.get('/', (req, res) => {
    res.json({ message: 'Hello from Express backend!' });
});

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});
