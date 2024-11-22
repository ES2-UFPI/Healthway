const db = require('../firebase-config');
const Nutricionista = require('../model/Nutricionista');

const nutricionistaController = {
  // Criar um nutricionista
  async create(req, res) {
    try {
      const nutricionista = new Nutricionista(req.body);
      await db.collection('nutricionista').add(nutricionista.toFirestore());
      res.status(201).json({ message: 'Nutricionista criado com sucesso!' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Obter todos os nutricionistas
  async getAll(req, res) {
    try {
      const snapshot = await db.collection('nutricionista').get();
      const nutricionistas = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));
      res.status(200).json(nutricionistas);
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Obter um nutricionista pelo ID
  async getById(req, res) {
    try {
      const { id } = req.params;
      const doc = await db.collection('nutricionista').doc(id).get();

      if (!doc.exists) {
        return res.status(404).json({ error: 'Nutricionista não encontrado.' });
      }

      res.status(200).json({ id: doc.id, ...doc.data() });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Atualizar um nutricionista
  async update(req, res) {
    try {
      const { id } = req.params;
      const nutricionista = new Nutricionista(req.body);

      await db.collection('nutricionista').doc(id).update(nutricionista.toFirestore());
      res.status(200).json({ message: 'Nutricionista atualizado com sucesso!' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },

  // Excluir um nutricionista
  async delete(req, res) {
    try {
      const { id } = req.params;
      await db.collection('nutricionista').doc(id).delete();
      res.status(200).json({ message: 'Nutricionista excluído com sucesso!' });
    } catch (error) {
      res.status(500).json({ error: error.message });
    }
  },
};

module.exports = nutricionistaController;
