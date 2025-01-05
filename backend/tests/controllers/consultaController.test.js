const consultaController = require('../../controllers/consultaController');
const db = require('../../firebase-config');

jest.mock('../../firebase-config', () => ({
  collection: jest.fn().mockReturnThis(),
  doc: jest.fn().mockReturnThis(),
  get: jest.fn().mockResolvedValue(),
  add: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
}));

describe('consultaController', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  test('deve retornar todas as consultas', async () => {
    const mockData = [
      { id: '1', data: '2023-01-01' },
      { id: '2', data: '2023-01-02' },
    ];
    db.get.mockResolvedValueOnce({
      docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
    });

    const req = {};
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.getAll(req, res);

    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.json).toHaveBeenCalledWith(mockData);
  });

  test('deve retornar um erro ao buscar todas as consultas', async () => {
    db.get.mockRejectedValueOnce(new Error('Erro ao buscar consultas.'));

    const req = {};
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.getAll(req, res);

    expect(res.status).toHaveBeenCalledWith(500);
    expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar consultas.' });
  });

  test('deve retornar uma consulta pelo ID', async () => {
    const mockData = { id: '1', data: '2023-01-01' };
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

    await consultaController.getById(req, res);

    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.json).toHaveBeenCalledWith({ id: '1', ...mockData });
  });

  test('deve retornar um erro ao buscar uma consulta inexistente', async () => {
    db.get.mockResolvedValueOnce({ exists: false });

    const req = { params: { id: '1' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.getById(req, res);

    expect(res.status).toHaveBeenCalledWith(404);
    expect(res.json).toHaveBeenCalledWith({ error: 'Consulta não encontrada.' });
  });

  test('deve retornar um erro ao buscar uma consulta', async () => {
    db.get.mockRejectedValueOnce(new Error('Erro ao buscar consulta.'));

    const req = { params: { id: '1' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.getById(req, res);

    expect(res.status).toHaveBeenCalledWith(500);
    expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar consulta.' });
  });

  test('deve criar uma nova consulta', async () => {
    const novaConsulta = { data: '2023-01-01' };
    db.add.mockResolvedValueOnce({ id: '1' });

    const req = { body: novaConsulta };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.create(req, res);

    expect(res.status).toHaveBeenCalledWith(201);
    expect(res.json).toHaveBeenCalledWith({ message: 'Consulta criada com sucesso!' });
  });

  test('deve retornar um erro ao criar uma nova consulta', async () => {
    const novaConsulta = { data: '2023-01-01' };
    db.add.mockRejectedValueOnce(new Error('Erro ao criar consulta.'));

    const req = { body: novaConsulta };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.create(req, res);

    expect(res.status).toHaveBeenCalledWith(500);
    expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao criar consulta.' });
  });

  test('deve atualizar uma consulta existente', async () => {
    const consultaAtualizada = { data: '2023-01-02' };
    db.update.mockResolvedValueOnce();

    const req = { params: { id: '1' }, body: consultaAtualizada };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.update(req, res);

    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.json).toHaveBeenCalledWith({ message: 'Consulta atualizada com sucesso!' });
  });

  test('deve retornar um erro ao atualizar uma consulta', async () => {
    const consultaAtualizada = { data: '2023-01-02' };
    db.update.mockRejectedValueOnce(new Error('Erro ao atualizar consulta.'));

    const req = { params: { id: '1' }, body: consultaAtualizada };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.update(req, res);

    expect(res.status).toHaveBeenCalledWith(500);
    expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao atualizar consulta.' });
  });

  test('deve excluir uma consulta', async () => {
    db.delete.mockResolvedValueOnce();

    const req = { params: { id: '1' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.delete(req, res);

    expect(res.status).toHaveBeenCalledWith(200);
    expect(res.json).toHaveBeenCalledWith({ message: 'Consulta excluída com sucesso!' });
  });

  test('deve retornar um erro ao excluir uma consulta', async () => {
    db.delete.mockRejectedValueOnce(new Error('Erro ao excluir consulta.'));

    const req = { params: { id: '1' } };
    const res = {
      status: jest.fn().mockReturnThis(),
      json: jest.fn(),
    };

    await consultaController.delete(req, res);

    expect(res.status).toHaveBeenCalledWith(500);
    expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao excluir consulta.' });
  });
});