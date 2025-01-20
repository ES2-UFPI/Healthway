const express = require('express');
const router = express.Router();
const nutricionistaController = require('../controllers/nutricionistaController');

// Rotas
router.post('/', nutricionistaController.create);
router.get('/', nutricionistaController.getAll);
router.get('/:id', nutricionistaController.getById);
router.post('/login', nutricionistaController.getByEmailAndPassword);
router.put('/:id', nutricionistaController.update);
router.delete('/:id', nutricionistaController.delete);
router.get('/specialty/:specialty', nutricionistaController.getBySpecialty);
router.get('/nome/:nome', nutricionistaController.getByName);

module.exports = router;
