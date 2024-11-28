const express = require('express');
const router = express.Router();
const refeicaoController = require('../controllers/refeicaoController');

//Rotas
router.post('/', refeicaoController.create);
router.get('/', refeicaoController.getAll);
router.get('/:id', refeicaoController.getById);
router.put('/:id', refeicaoController.update);
router.delete('/:id', refeicaoController.delete);

module.exports = router;