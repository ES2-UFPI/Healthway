const express = require('express');
const router = express.Router();
const planoAlimentarController = require('../controllers/planoAlimentarController');

// Rotas
router.post('/', planoAlimentarController.create);
router.get('/', planoAlimentarController.getAll);
router.get('/:id', planoAlimentarController.getById);
router.put('/:id', planoAlimentarController.update);
router.delete('/:id', planoAlimentarController.delete);
router.get('/paciente/:paciente', planoAlimentarController.getByPaciente);
router.get('/nutricionista/:nutricionista', planoAlimentarController.getByNutricionista);

module.exports = router;
