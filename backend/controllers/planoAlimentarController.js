const db = require('../firebase-config');
const PlanoAlimentar = require('../model/PlanoAlimentar');

const planoAlimentarController = {
    // Criar um plano alimentar
    async create(req, res) {
        try {
            const planoAlimentar = new PlanoAlimentar(req.body);
            await db.collection('plano_alimentar').add(planoAlimentar.toFirestore());
            res.status(201).json({ message: 'Plano alimentar criado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Obter todos os planos alimentares
    async getAll(req, res) {
        try {
            const snapshot = await db.collection('plano_alimentar').get();
            const planosAlimentares = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            res.status(200).json(planosAlimentares);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Obter um plano alimentar pelo ID
    async getById(req, res) {
        try {
            const { id } = req.params;
            const doc = await db.collection('plano_alimentar').doc(id).get();

            if (!doc.exists) {
                return res.status(404).json({ error: 'Plano alimentar não encontrado.' });
            }

            res.status(200).json({ id: doc.id, ...doc.data() });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Atualizar um plano alimentar
    async update(req, res) {
        try {
            const { id } = req.params;
            const planoAlimentar = new PlanoAlimentar(req.body);

            await db.collection('plano_alimentar').doc(id).update(planoAlimentar.toFirestore());
            res.status(200).json({ message: 'Plano alimentar atualizado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    // Excluir um plano alimentar
    async delete(req, res) {
        try {
            const { id } = req.params;
            await db.collection('plano_alimentar').doc(id).delete();
            res.status(200).json({ message: 'Plano alimentar excluído com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
};

module.exports = planoAlimentarController;
