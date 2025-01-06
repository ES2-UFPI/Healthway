const express = require('express');
const router = express.Router();
const alimentoController = require('../controllers/alimentoController');

// Rotas
router.post('/', alimentoController.create);
router.get('/', alimentoController.getAll);
router.get('/:id', alimentoController.getById);
router.get('/categoria/:categoria', alimentoController.getByCategory); // Nova rota para buscar por categoria
router.put('/:id', alimentoController.update);
router.delete('/:id', alimentoController.delete);

module.exports = router;