const db = require('../firebase-config');
const Alimento = require('../model/Alimento');

const alimentoController = {
    //Criar um novo alimento
    async create(req, res){
        try {
            const alimento = new Alimento(req.body);
            await db.collection('alimento').add(alimento.toFirestore());
            res.status(201).json({ message: 'Alimento criado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Obter todos os alimentos
    async getAll(req, res){
        try {
            const snapshot = await db.collection('alimento').get();
            const alimentos = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            res.status(200).json(alimentos);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Obter um alimento pelo ID
    async getById(req, res){
        try {
            const { id } = req.params;
            const doc = await db.collection('alimento').doc(id).get();

            if (!doc.exists) {
                return res.status(404).json({ error: 'Alimento não encontrado.' });
            }

            res.status(200).json({ id: doc.id, ...doc.data() });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Atualizar um alimento
    async update(req, res){
        try {
            const { id } = req.params;
            const alimento = new Alimento(req.body);

            await db.collection('alimento').doc(id).update(alimento.toFirestore());
            res.status(200).json({ message: 'Alimento atualizado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Excluir um alimento
    async delete(req, res){
        try {
            const { id } = req.params;
            await db.collection('alimento').doc(id).delete();
            res.status(200).json({ message: 'Alimento excluído com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
};

module.exports = alimentoController;
