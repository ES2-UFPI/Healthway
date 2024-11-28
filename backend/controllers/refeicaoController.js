const db = require('../firebase-config');
const Refeicao = require('../model/refeicao');

const refeicaoController = {
    //Criar uma nova refeição
    async create(req, res){
        try {
            const refeicao = new Refeicao(req.body);
            await db.collection('refeicao').add(refeicao.toFirestore());
            res.status(201).json({ message: 'Refeição criada com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Obter todas as refeições
    async getAll(req, res){
        try {
            const snapshot = await db.collection('refeicao').get();
            const refeicoes = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
            res.status(200).json(refeicoes);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Obter uma refeição pelo ID
    async getById(req, res){
        try {
            const { id } = req.params;
            const doc = await db.collection('refeicao').doc(id).get();

            if (!doc.exists) {
                return res.status(404).json({ error: 'Refeição não encontrada.' });
            }

            res.status(200).json({ id: doc.id, ...doc.data() });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Atualizar uma refeição
    async update(req, res){
        try {
            const { id } = req.params;
            const refeicao = new Refeicao(req.body);

            await db.collection('refeicao').doc(id).update(refeicao.toFirestore());
            res.status(200).json({ message: 'Refeição atualizada com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    //Excluir uma refeição
    async delete(req, res){
        try {
            const { id } = req.params;
            await db.collection('refeicao').doc(id).delete();
            res.status(200).json({ message: 'Refeição excluída com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
};

module.exports = refeicaoController;
