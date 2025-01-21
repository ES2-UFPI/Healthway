const db = require('../firebase-config');
const Paciente = require('../model/Paciente');

const PacienteService = {
    async create(data) {
        const paciente = new Paciente();
        paciente.fromJson(data);
        await db.collection('paciente').add(paciente.toFirestore());
    },

    async getAll() {
        const snapshot = await db.collection('paciente').get();
        return snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
    },

    async getById(id) {
        const doc = await db.collection('paciente').doc(id).get();
        if (!doc.exists) {
            throw new Error('Paciente não encontrado.');
        }
        return { id: doc.id, ...doc.data() };
    },

    async getByListOfIds(ids) {
        const pacientes = [];
        for (const id of ids) {
            const doc = await db.collection('paciente').doc(id).get();
            if (doc.exists) {
                pacientes.push({ id: doc.id, ...doc.data() });
            }
        }
        return pacientes;
    },

    async getByEmailAndPassword(email, senha) {
        const snapshot = await db.collection('paciente')
            .where('email', '==', email)
            .where('senha', '==', senha)
            .get();

        const pacientes = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        if (pacientes.length === 0) {
            throw new Error('Paciente não encontrado.');
        }
        return pacientes[0];
    },

    async update(id, data) {
        const paciente = new Paciente();
        paciente.fromJson(data);
        await db.collection('paciente').doc(id).update(paciente.toFirestore());
    },

    async delete(id) {
        await db.collection('paciente').doc(id).delete();
    }
};

module.exports = PacienteService;
