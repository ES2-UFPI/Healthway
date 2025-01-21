const NutricionistaService = require('../services/nutricionistaService');

const nutricionistaController = {
    async create(req, res) {
        try {
            await NutricionistaService.create(req.body);
            res.status(201).json({ message: 'Nutricionista criado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getAll(req, res) {
        try {
            const nutricionistas = await NutricionistaService.getAll();
            res.status(200).json(nutricionistas);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getById(req, res) {
        try {
            const { id } = req.params;
            const nutricionista = await NutricionistaService.getById(id);
            res.status(200).json(nutricionista);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getByEmailAndPassword(req, res) {
        try {
            const { email, senha } = req.body;
            const nutricionista = await NutricionistaService.getByEmailAndPassword(email, senha);
            res.status(200).json(nutricionista);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getBySpecialty(req, res) {
        try {
            const { specialty } = req.params;
            const nutricionistas = await NutricionistaService.getBySpecialty(specialty);
            res.status(200).json(nutricionistas);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getByName(req, res) {
        try {
            const { nome } = req.params;
            const nutricionistas = await NutricionistaService.getByName(nome);
            res.status(200).json(nutricionistas);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async update(req, res) {
        try {
            const { id } = req.params;
            await NutricionistaService.update(id, req.body);
            res.status(200).json({ message: 'Nutricionista atualizado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async delete(req, res) {
        try {
            const { id } = req.params;
            await NutricionistaService.delete(id);
            res.status(200).json({ message: 'Nutricionista excluído com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },
};

module.exports = nutricionistaController;
