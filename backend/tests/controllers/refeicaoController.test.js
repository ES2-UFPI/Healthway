const refeicaoController = require('../../controllers/refeicaoController');
const db = require('../../firebase-config');

jest.mock('../../firebase-config', () => ({
  collection: jest.fn().mockReturnThis(),
  doc: jest.fn().mockReturnThis(),
  get: jest.fn().mockResolvedValue(),
  add: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
}));

describe('refeicaoController', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('getAll', () => {
    test('deve retornar todas as refeições', async () => {
      const mockData = [
        { id: '1', nome: 'Café da manhã' },
        { id: '2', nome: 'Almoço' },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao buscar todas as refeições', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar refeições.'));

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar refeições.' });
    });
  });

  describe('getById', () => {
    test('deve retornar uma refeição pelo ID', async () => {
      const mockData = { id: '1', nome: 'Café da manhã' };
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

      await refeicaoController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ id: '1', ...mockData });
    });

    test('deve retornar um erro ao buscar uma refeição inexistente', async () => {
      db.get.mockResolvedValueOnce({ exists: false });

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ error: 'Refeição não encontrada.' });
    });

    test('deve retornar um erro ao buscar uma refeição', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar refeição.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar refeição.' });
    });
  });

  describe('create', () => {
    test('deve criar uma nova refeição', async () => {
      const novaRefeicao = { nome: 'Café da manhã' };
      db.add.mockResolvedValueOnce({ id: '1' });

      const req = { body: novaRefeicao };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(201);
      expect(res.json).toHaveBeenCalledWith({ message: 'Refeição criada com sucesso!' });
    });

    test('deve retornar um erro ao criar uma nova refeição', async () => {
      const novaRefeicao = { nome: 'Café da manhã' };
      db.add.mockRejectedValueOnce(new Error('Erro ao criar refeição.'));

      const req = { body: novaRefeicao };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao criar refeição.' });
    });
  });

  describe('update', () => {
    test('deve atualizar uma refeição existente', async () => {
      const refeicaoAtualizada = { nome: 'Café da manhã reforçado' };
      db.update.mockResolvedValueOnce();

      const req = { params: { id: '1' }, body: refeicaoAtualizada };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Refeição atualizada com sucesso!' });
    });

    test('deve retornar um erro ao atualizar uma refeição', async () => {
      const refeicaoAtualizada = { nome: 'Café da manhã reforçado' };
      db.update.mockRejectedValueOnce(new Error('Erro ao atualizar refeição.'));

      const req = { params: { id: '1' }, body: refeicaoAtualizada };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await refeicaoController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao atualizar refeição.' });
    });
  });

  describe('delete', () => {
    test('deve excluir uma refeição', async () => {
      db.delete.mockResolvedValueOnce();
  
      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };
  
      await refeicaoController.delete(req, res);
  
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Refeição excluída com sucesso!' });
    });
  
    test('deve retornar um erro ao excluir uma refeição', async () => {
      db.delete.mockRejectedValueOnce(new Error('Erro ao excluir refeição.'));
  
      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };
  
      await refeicaoController.delete(req, res);
  
      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao excluir refeição.' });
    });
  });
});