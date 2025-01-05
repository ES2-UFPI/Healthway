const e = require('express');
const planoAlimentarController = require('../../controllers/planoAlimentarController');
const db = require('../../firebase-config');

jest.mock('../../firebase-config', () => ({
  collection: jest.fn().mockReturnThis(),
  doc: jest.fn().mockReturnThis(),
  get: jest.fn().mockResolvedValue(),
  add: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
  where: jest.fn().mockReturnThis(),
}));

describe('planoAlimentarController', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('getAll', () => {
    test('deve retornar todos os planos alimentares', async () => {
      const mockData = [
        { id: '1', dt_inicio: '2023-01-01', dt_fim: '2023-01-31' },
        { id: '2', dt_inicio: '2023-02-01', dt_fim: '2023-02-28' },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao buscar todos os planos alimentares', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar planos alimentares.'));

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar planos alimentares.' });
    });
  });

  describe('getById', () => {
    test('deve retornar um plano alimentar pelo ID', async () => {
      const mockData = { id: '1', dt_inicio: '2023-01-01', dt_fim: '2023-01-31' };
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

      await planoAlimentarController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ id: '1', ...mockData });
    });

    test('deve retornar um erro ao buscar um plano alimentar inexistente', async () => {
      db.get.mockResolvedValueOnce({ exists: false });

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ error: 'Plano alimentar não encontrado.' });
    });

    test('deve retornar um erro ao buscar um plano alimentar', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar plano alimentar.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar plano alimentar.' });
    });
  });

  describe('create', () => {
    test('deve criar um novo plano alimentar', async () => {
      const novoPlanoAlimentar = { dt_inicio: '2023-01-01', dt_fim: '2023-01-31' };
      db.add.mockResolvedValueOnce({ id: '1' });

      const req = { body: novoPlanoAlimentar };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(201);
      expect(res.json).toHaveBeenCalledWith({ message: 'Plano alimentar criado com sucesso!' });
    });

    test('deve retornar um erro ao criar um novo plano alimentar', async () => {
      const novoPlanoAlimentar = { dt_inicio: '2023-01-01', dt_fim: '2023-01-31' };
      db.add.mockRejectedValueOnce(new Error('Erro ao criar plano alimentar.'));

      const req = { body: novoPlanoAlimentar };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao criar plano alimentar.' });
    });
  });

  describe('update', () => {
    test('deve atualizar um plano alimentar existente', async () => {
      const planoAlimentarAtualizado = { dt_inicio: '2023-01-01', dt_fim: '2023-01-31' };
      db.update.mockResolvedValueOnce();

      const req = { params: { id: '1' }, body: planoAlimentarAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Plano alimentar atualizado com sucesso!' });
    });

    test('deve retornar um erro ao atualizar um plano alimentar', async () => {
      const planoAlimentarAtualizado = { dt_inicio: '2023-01-01', dt_fim: '2023-01-31' };
      db.update.mockRejectedValueOnce(new Error('Erro ao atualizar plano alimentar.'));

      const req = { params: { id: '1' }, body: planoAlimentarAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao atualizar plano alimentar.' });
    });
  });

  describe('delete', () => {
    test('deve excluir um plano alimentar', async () => {
      db.delete.mockResolvedValueOnce();
  
      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };
  
      await planoAlimentarController.delete(req, res);
  
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Plano alimentar excluído com sucesso!' });
    });
  
    test('deve retornar um erro ao excluir um plano alimentar', async () => {
      db.delete.mockRejectedValueOnce(new Error('Erro ao excluir plano alimentar.'));
  
      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };
  
      await planoAlimentarController.delete(req, res);
  
      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao excluir plano alimentar.' });
    });
  });

  describe('getByPaciente', () => {
    test('deve retornar os planos alimentares de um paciente', async () => {
      const mockData = [
      { id: '1', dt_inicio: '2023-01-01', dt_fim: '2023-01-31', paciente: '1' },
      { id: '2', dt_inicio: '2023-02-01', dt_fim: '2023-02-28', paciente: '1' },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = { params: { paciente: '1' } };
      const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
      };

      await planoAlimentarController.getByPaciente(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao não encontrar planos alimentares de um paciente', async () => {
      db.get.mockResolvedValueOnce({ empty: true });

      const req = { params: { paciente: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getByPaciente(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ message: 'Nenhum plano alimentar encontrado para este paciente.' });
    });

    test('deve retornar um erro ao buscar os planos alimentares de um paciente', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar planos alimentares.'));

      const req = { params: { paciente: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getByPaciente(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar planos alimentares.' });
    });

    test('deve retornar um erro ao buscar os planos alimentares de um paciente sem informar o paciente', async () => {
      const req = { params: {} };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await planoAlimentarController.getByPaciente(req, res);

      expect(res.status).toHaveBeenCalledWith(400);
      expect(res.json).toHaveBeenCalledWith({ error: 'O parâmetro paciente é obrigatório.' });
    });
  });
});