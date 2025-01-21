const PacienteService = require('../services/pacienteServices');

const pacienteController = {
    async create(req, res) {
        try {
            await PacienteService.create(req.body);
            res.status(201).json({ message: 'Paciente criado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getAll(req, res) {
        try {
            const pacientes = await PacienteService.getAll();
            res.status(200).json(pacientes);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getById(req, res) {
        try {
            const paciente = await PacienteService.getById(req.params.id);
            res.status(200).json(paciente);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getByListOfIds(req, res) {
        try {
            const pacientes = await PacienteService.getByListOfIds(req.body.ids);
            res.status(200).json(pacientes);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getByEmailAndPassword(req, res) {
        try {
            const paciente = await PacienteService.getByEmailAndPassword(req.body.email, req.body.senha);
            res.status(200).json(paciente);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async update(req, res) {
        try {
            await PacienteService.update(req.params.id, req.body);
            res.status(200).json({ message: 'Paciente atualizado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async delete(req, res) {
        try {
            await PacienteService.delete(req.params.id);
            res.status(200).json({ message: 'Paciente excluído com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    }
};

module.exports = pacienteController;
