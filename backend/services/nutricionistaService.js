const db = require('../firebase-config');
const Nutricionista = require('../model/Nutricionista');

const NutricionistaService = {
    async create(data) {
        const nutricionista = new Nutricionista(data);
        await db.collection('nutricionista').add(nutricionista.toFirestore());
    },

    async getAll() {
        const snapshot = await db.collection('nutricionista').get();
        return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    },

    async getById(id) {
        const doc = await db.collection('nutricionista').doc(id).get();
        if (!doc.exists) {
            throw new Error('Nutricionista não encontrado.');
        }
        return { id: doc.id, ...doc.data() };
    },

    async getByEmailAndPassword(email, senha) {
        const snapshot = await db.collection('nutricionista')
            .where('email', '==', email)
            .where('senha', '==', senha)
            .get();

        const nutricionistas = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        if (nutricionistas.length === 0) {
            throw new Error('Nutricionista não encontrado.');
        }
        return nutricionistas[0];
    },

    async getBySpecialty(especialidade) {
        const snapshot = await db.collection('nutricionista')
            .where('especialidade', '==', especialidade)
            .get();

        const nutricionistas = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        if (nutricionistas.length === 0) {
            throw new Error('Nenhum nutricionista encontrado com essa especialidade.');
        }
        return nutricionistas;
    },

    async getByName(nome) {
        const snapshot = await db.collection('nutricionista')
            .orderBy('nome')
            .startAt(nome)
            .endAt(nome + '\uf8ff')
            .get();

        const nutricionistas = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        if (nutricionistas.length === 0) {
            throw new Error('Nenhum nutricionista encontrado com esse nome.');
        }
        return nutricionistas;
    },

    async update(id, data) {
        const nutricionista = new Nutricionista(data);
        await db.collection('nutricionista').doc(id).update(nutricionista.toFirestore());
    },

    async delete(id) {
        await db.collection('nutricionista').doc(id).delete();
    },
};

module.exports = NutricionistaService;
