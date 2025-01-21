const AlimentoService = require('../services/alimentoService');


const alimentoController = {
    async create(req, res) {
        try {
            await AlimentoService.create(req.body);
            res.status(201).json({ message: 'Alimento criado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getAll(req, res) {
        try {
            const alimentos = await AlimentoService.getAll();
            res.status(200).json(alimentos);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getByCategory(req, res) {
        try {
            const { categoria } = req.params;
            const alimentos = await AlimentoService.getByCategory(categoria);
            res.status(200).json(alimentos);
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async getById(req, res) {
        try {
            const { id } = req.params;
            const alimento = await AlimentoService.getById(id);
            res.status(200).json(alimento);
        } catch (error) {
            if (error.message === 'Alimento não encontrado.') {
                res.status(404).json({ error: error.message });
            } else {
                res.status(500).json({ error: error.message });
            }
        }
    },

    async update(req, res) {
        try {
            const { id } = req.params;
            await AlimentoService.update(id, req.body);
            res.status(200).json({ message: 'Alimento atualizado com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },

    async delete(req, res) {
        try {
            const { id } = req.params;
            await AlimentoService.delete(id);
            res.status(200).json({ message: 'Alimento excluído com sucesso!' });
        } catch (error) {
            res.status(500).json({ error: error.message });
        }
    },
};

module.exports = alimentoController;
