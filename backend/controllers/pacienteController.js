const db = require('../firebase-config');
const Paciente = require('../model/Paciente');

const pacienteController = {
    // Criar um paciente
    async create(req, res) {
        try {
        const paciente = new Paciente(req.body);
        await db.collection('Paciente').add(paciente.toFirestore());
        res.status(201).json({ message: 'Paciente criado com sucesso!' });
        } catch (error) {
        res.status(500).json({ error: error.message });
        }
    },

    // Obter todos os pacientes
    async getAll(req, res) {
        try {
        const snapshot = await db.collection('Paciente').get();
        const pacientes = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
        res.status(200).json(pacientes);
        } catch (error) {
        res.status(500).json({ error: error.message });
        }
    },

    // Obter um paciente pelo ID
    async getById(req, res) {
        try {
        const { id } = req.params;
        const doc = await db.collection('Paciente').doc(id).get();

        if (!doc.exists) {
            return res.status(404).json({ error: 'Paciente não encontrado.' });
        }

        res.status(200).json({ id: doc.id, ...doc.data() });
        } catch (error) {
        res.status(500).json({ error: error.message });
        }
    },

    // Atualizar um paciente
    async update(req, res) {
        try {
        const { id } = req.params;
        const paciente = new Paciente(req.body);

        await db.collection('Paciente').doc(id).update(paciente.toFirestore());
        res.status(200).json({ message: 'Paciente atualizado com sucesso!' });
        } catch (error) {
        res.status(500).json({ error: error.message });
        }
    },

    // Excluir um paciente
    async delete(req, res) {
        try {
        const { id } = req.params;
        await db.collection('Paciente').doc(id).delete();
        res.status(200).json({ message: 'Paciente excluído com sucesso!' });
        } catch (error) {
        res.status(500).json({ error: error.message });
        }
    }
};

module.exports = pacienteController;