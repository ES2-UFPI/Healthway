const db = require('../firebase-config');
const Alimento = require('../model/Alimento');

const AlimentoService = {
    async create(data) {
        const alimento = new Alimento(data);
        return await db.collection('alimentos').add(alimento.toFirestore());
    },

    async getAll() {
        const snapshot = await db.collection('alimentos').get();
        return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    },

    async getByCategory(categoria) {
        const snapshot = await db.collection('alimentos').where('Categoria', '==', categoria).get();
        return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    },

    async getById(id) {
        const doc = await db.collection('alimentos').doc(id).get();
        if (!doc.exists) {
            throw new Error('Alimento não encontrado.');
        }
        return { id: doc.id, ...doc.data() };
    },

    async update(id, data) {
        const alimento = new Alimento(data);
        await db.collection('alimentos').doc(id).update(alimento.toFirestore());
    },

    async delete(id) {
        await db.collection('alimentos').doc(id).delete();
    },
};

module.exports = AlimentoService;
