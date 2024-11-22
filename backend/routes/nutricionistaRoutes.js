const express = require('express');
const router = express.Router();
const nutricionistaController = require('../controllers/nutricionistaController');

// Rotas
router.post('/', nutricionistaController.create);
router.get('/', nutricionistaController.getAll);
router.get('/:id', nutricionistaController.getById);
router.put('/:id', nutricionistaController.update);
router.delete('/:id', nutricionistaController.delete);

module.exports = router;
