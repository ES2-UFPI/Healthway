const db = require('../firebase-config');
const Consulta = require('../model/Consulta');

const consultaController = {
    // Criar uma consulta
    async create(req, res) {
        try {
            const consulta = new Consulta(req.body);
            await db.collection('consulta').add(consulta.toFirestore());
            res.status(201).json({ message: 'Consulta criada com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Obter todas as consultas
    async getAll(req, res) {
        try {
            const snapshot = await db.collection('consulta').get();
            const consultas = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            res.status(200).json(consultas);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Obter uma consulta pelo ID
    async getById(req, res) {
        try {
            const { id } = req.params;
            const doc = await db.collection('consulta').doc(id).get();

            if (!doc.exists) {
                return res.status(404).json({ error: 'Consulta não encontrada.' });
            }

            res.status(200).json({ id: doc.id, ...doc.data() });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Atualizar uma consulta
    async update(req, res) {
        try {
            const { id } = req.params;
            const consulta = new Consulta(req.body);

            await db.collection('consulta').doc(id).update(consulta.toFirestore());
            res.status(200).json({ message: 'Consulta atualizada com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Excluir uma consulta
    async delete(req, res) {
        try {
            const { id } = req.params;
            await db.collection('consulta').doc(id).delete();
            res.status(200).json({ message: 'Consulta excluída com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
};

module.exports = consultaController;
