const pacienteController = require('../../controllers/pacienteController');
const db = require('../../firebase-config');

jest.mock('../../firebase-config', () => ({
  collection: jest.fn().mockReturnThis(),
  doc: jest.fn().mockReturnThis(),
  get: jest.fn().mockResolvedValue(),
  add: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
}));

describe('pacienteController', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('getAll', () => {
    test('deve retornar todos os pacientes', async () => {
      const mockData = [
        { id: '1', nome: 'João' },
        { id: '2', nome: 'Maria' },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao buscar todos os pacientes', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar pacientes.'));

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar pacientes.' });
    });
  });

  describe('getById', () => {
    test('deve retornar um paciente pelo ID', async () => {
      const mockData = { id: '1', nome: 'João' };
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

      await pacienteController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ id: '1', ...mockData });
    });

    test('deve retornar um erro ao buscar um paciente inexistente', async () => {
      db.get.mockResolvedValueOnce({ exists: false });

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ error: 'Paciente não encontrado.' });
    });

    test('deve retornar um erro ao buscar um paciente', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar paciente.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar paciente.' });
    });
  });

  describe('create', () => {
    test('deve criar um novo paciente', async () => {
      const novoPaciente = { nome: 'João' };
      db.add.mockResolvedValueOnce({ id: '1' });

      const req = { body: novoPaciente };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(201);
      expect(res.json).toHaveBeenCalledWith({ message: 'Paciente criado com sucesso!' });
    });

    test('deve retornar um erro ao criar um novo paciente', async () => {
      const novoPaciente = { nome: 'João' };
      db.add.mockRejectedValueOnce(new Error('Erro ao criar paciente.'));

      const req = { body: novoPaciente };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao criar paciente.' });
    });
  });

  describe('update', () => {
    test('deve atualizar um paciente existente', async () => {
      const pacienteAtualizado = { nome: 'João Silva' };
      db.update.mockResolvedValueOnce();

      const req = { params: { id: '1' }, body: pacienteAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Paciente atualizado com sucesso!' });
    });

    test('deve retornar um erro ao atualizar um paciente', async () => {
      const pacienteAtualizado = { nome: 'João Silva' };
      db.update.mockRejectedValueOnce(new Error('Erro ao atualizar paciente.'));

      const req = { params: { id: '1' }, body: pacienteAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao atualizar paciente.' });
    });
  });

  describe('delete', () => {
    test('deve excluir um paciente', async () => {
      db.delete.mockResolvedValueOnce();
  
      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };
  
      await pacienteController.delete(req, res);
  
      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Paciente excluído com sucesso!' });
    });
  
    test('deve retornar um erro ao excluir um paciente', async () => {
      db.delete.mockRejectedValueOnce(new Error('Erro ao excluir paciente.'));
  
      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };
  
      await pacienteController.delete(req, res);
  
      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao excluir paciente.' });
    });
  });

  describe('getByEmailAndPassword', () => {
    test('deve retornar um paciente pelo email e senha', async () => {
      const mockData = { id: '1', nome: 'João', email: 'joao@example.com', senha: '123456' };
      db.get.mockResolvedValueOnce({
        docs: [{ id: mockData.id, data: () => mockData }],
      });

      const req = { body: { email: 'joao@example.com', senha: '123456' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getByEmailAndPassword(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao não achar nenhum paciente com o email e senha', async () => {
      db.get.mockResolvedValueOnce({ docs: [] });

      const req = { body: { email: 'joao@example.com', senha: '123456' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getByEmailAndPassword(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ error: 'Paciente não encontrado.' });
    });

    test('deve retornar um erro ao buscar um paciente pelo email e senha', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar paciente.'));

      const req = { body: { email: 'joao@example.com', senha: '123456' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await pacienteController.getByEmailAndPassword(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar paciente.' });
    });
  });
});