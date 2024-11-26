const express = require("express");
const db = require("./firebase-config");

const app = express();
const port = 3000;

// Rota para listar documentos de uma coleção
app.get("/api/nutricionistas", async (req, res) => {
    try {
        // Consulta à coleção "nutricionistas"
        const snapshot = await db.collection("nutricionistas").get();

        // Mapeando os dados para um array de objetos
        const nutricionistas = snapshot.docs.map(doc => ({
            id: doc.id, // ID do documento
            nome: doc.data().nome,
            crn: doc.data().crn,
            especialidade: doc.data().especialidade,
            uf: doc.data().uf,
        }));

        // Retornando os dados no formato JSON
        res.status(200).json(nutricionistas);
    } catch (error) {
        console.error("Erro ao buscar nutricionistas:", error);
        res.status(500).send("Erro interno do servidor");
    }
});

// Iniciar o servidor
app.listen(port, () => {
    console.log(`API rodando em http://localhost:${port}`);
});
