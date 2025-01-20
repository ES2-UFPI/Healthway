const express = require('express');
const router = express.Router();
const pacienteController = require('../controllers/pacienteController');

// Rotas
router.post('/', pacienteController.create);
router.get('/', pacienteController.getAll);
router.get('/:id', pacienteController.getById);
router.post('/list', pacienteController.getByListOfIds);
router.post('/login', pacienteController.getByEmailAndPassword);
router.put('/:id', pacienteController.update);
router.delete('/:id', pacienteController.delete);

module.exports = router;
