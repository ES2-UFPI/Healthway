const alimentoController = require('../../controllers/alimentoController');
const db = require('../../firebase-config');

jest.mock('../../firebase-config', () => ({
  collection: jest.fn().mockReturnThis(),
  doc: jest.fn().mockReturnThis(),
  get: jest.fn().mockResolvedValue(),
  add: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
}));

describe('alimentoController', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('getAll', () => {
    test('deve retornar todos os alimentos', async () => {
      const mockData = [
        { id: '1', nome: 'Maçã', calorias: 52 },
        { id: '2', nome: 'Banana', calorias: 89 },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao buscar todos os alimentos', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar alimentos.'));

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar alimentos.' });
    });
  });

  describe('getById', () => {
    test('deve retornar um alimento pelo ID', async () => {
      const mockData = { id: '1', nome: 'Maçã', calorias: 52 };
      db.get.mockResolvedValueOnce({
        exists: true,
        id: mockData.id,
        data: () => mockData,
      });

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ id: '1', ...mockData });
    });

    test('deve retornar um erro ao buscar um alimento inexistente', async () => {
      db.get.mockResolvedValueOnce({ exists: false });

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ error: 'Alimento não encontrado.' });
    });

    test('deve retornar um erro ao buscar um alimento', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar alimento.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar alimento.' });
    });
  });

  describe('create', () => {
    test('deve criar um novo alimento', async () => {
      const novoAlimento = { nome: 'Maçã', calorias: 52 };
      db.add.mockResolvedValueOnce({ id: '1' });

      const req = { body: novoAlimento };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(201);
      expect(res.json).toHaveBeenCalledWith({ message: 'Alimento criado com sucesso!' });
    });

    test('deve retornar um erro ao criar um novo alimento', async () => {
      const novoAlimento = { nome: 'Maçã', calorias: 52 };
      db.add.mockRejectedValueOnce(new Error('Erro ao criar alimento.'));

      const req = { body: novoAlimento };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao criar alimento.' });
    });
  });

  describe('update', () => {
    test('deve atualizar um alimento existente', async () => {
      const alimentoAtualizado = { nome: 'Maçã Verde', calorias: 48 };
      db.update.mockResolvedValueOnce();

      const req = { params: { id: '1' }, body: alimentoAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Alimento atualizado com sucesso!' });
    });

    test('deve retornar um erro ao atualizar um alimento', async () => {
      const alimentoAtualizado = { nome: 'Maçã Verde', calorias: 48 };
      db.update.mockRejectedValueOnce(new Error('Erro ao atualizar alimento.'));

      const req = { params: { id: '1' }, body: alimentoAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao atualizar alimento.' });
    });
  });

  describe('delete', () => {
    test('deve excluir um alimento', async () => {
      db.delete.mockResolvedValueOnce();

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.delete(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Alimento excluído com sucesso!' });
    });

    test('deve retornar um erro ao excluir um alimento', async () => {
      db.delete.mockRejectedValueOnce(new Error('Erro ao excluir alimento.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await alimentoController.delete(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao excluir alimento.' });
    });
  });
});