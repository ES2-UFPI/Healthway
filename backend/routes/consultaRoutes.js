const express = require('express');
const router = express.Router();
const consultaController = require('../controllers/consultaController');

// Rotas
router.post('/', consultaController.create);
router.get('/', consultaController.getAll);
router.get('/:id', consultaController.getById);
router.put('/:id', consultaController.update);
router.delete('/:id', consultaController.delete);

module.exports = router;