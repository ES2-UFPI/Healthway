const consultaController = require('../../controllers/consultaController');
const nutricionistaController = require('../../controllers/nutricionistaController');
const db = require('../../firebase-config');

jest.mock('../../firebase-config', () => ({
  collection: jest.fn().mockReturnThis(),
  doc: jest.fn().mockReturnThis(),
  get: jest.fn().mockResolvedValue(),
  add: jest.fn(),
  update: jest.fn(),
  delete: jest.fn(),
  where: jest.fn().mockReturnThis(),
  orderBy: jest.fn().mockReturnThis(),
  startAt: jest.fn().mockReturnThis(),
  endAt: jest.fn().mockReturnThis(),
}));



describe('nutricionistaController', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('getAll', () => {
    test('deve retornar todos os nutricionistas', async () => {
      const mockData = [
        { id: '1', nome: 'Nutricionista 1' },
        { id: '2', nome: 'Nutricionista 2' },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao buscar todos os nutricionistas', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar nutricionistas.'));

      const req = {};
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getAll(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar nutricionistas.' });
    });
  });

  describe('getById', () => {
    test('deve retornar um nutricionista pelo ID', async () => {
      const mockData = { id: '1', nome: 'Nutricionista 1' };
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

      await nutricionistaController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ id: '1', ...mockData });
    });

    test('deve retornar um erro ao buscar um nutricionista inexistente', async () => {
      db.get.mockResolvedValueOnce({ exists: false });

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ error: 'Nutricionista não encontrado.' });
    });

    test('deve retornar um erro ao buscar um nutricionista', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar nutricionista.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getById(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar nutricionista.' });
    });
  });

  describe('create', () => {
    test('deve criar um novo nutricionista', async () => {
      const novoNutricionista = { nome: 'Nutricionista 1' };
      db.add.mockResolvedValueOnce({ id: '1' });

      const req = { body: novoNutricionista };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(201);
      expect(res.json).toHaveBeenCalledWith({ message: 'Nutricionista criado com sucesso!' });
    });

    test('deve retornar um erro ao criar um novo nutricionista', async () => {
      const novoNutricionista = { nome: 'Nutricionista 1' };
      db.add.mockRejectedValueOnce(new Error('Erro ao criar nutricionista.'));

      const req = { body: novoNutricionista };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.create(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao criar nutricionista.' });
    });
  });

  describe('update', () => {
    test('deve atualizar um nutricionista existente', async () => {
      const nutricionistaAtualizado = { nome: 'Nutricionista Atualizado' };
      db.update.mockResolvedValueOnce();

      const req = { params: { id: '1' }, body: nutricionistaAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Nutricionista atualizado com sucesso!' });
    });

    test('deve retornar um erro ao atualizar um nutricionista', async () => {
      const nutricionistaAtualizado = { nome: 'Nutricionista Atualizado' };
      db.update.mockRejectedValueOnce(new Error('Erro ao atualizar nutricionista.'));

      const req = { params: { id: '1' }, body: nutricionistaAtualizado };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.update(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao atualizar nutricionista.' });
    });
  });

  describe('delete', () => {
    test('deve excluir um nutricionista', async () => {
      db.delete.mockResolvedValueOnce();

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.delete(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith({ message: 'Nutricionista excluído com sucesso!' });
    });

    test('deve retornar um erro ao excluir um nutricionista', async () => {
      db.delete.mockRejectedValueOnce(new Error('Erro ao excluir nutricionista.'));

      const req = { params: { id: '1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.delete(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao excluir nutricionista.' });
    });
  });

  describe('getBySpecialty', () => {
    test('deve retornar nutricionistas pela especialidade', async () => {
      const mockData = [
        { id: '1', nome: 'Nutricionista 1', especialidade: 'Esportiva' },
        { id: '2', nome: 'Nutricionista 2', especialidade: 'Esportiva' },
        { id: '3', nome: 'Nutricionista 3', especialidade: 'Clínica' },
      ];
      db.get.mockResolvedValueOnce({
        empty: false,
        docs: [{ id: mockData[0].id, data: () => mockData[0] },
               { id: mockData[1].id, data: () => mockData[1] }],
      });

      const req = { params: { specialty: 'Esportiva' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getBySpecialty(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith([mockData[0], mockData[1]]);
    });

    test('deve retornar um erro ao não achar nenhum nutricionista com uma especialidade', async () => {
      db.get.mockResolvedValueOnce({ empty: true });

      const req = { params: { especialidade: 'Esportiva' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getBySpecialty(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ message: 'Nenhum nutricionista encontrado com essa especialidade.' });
    });

    test('deve retornar um erro ao buscar nutricionistas pela especialidade', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar nutricionistas.'));

      const req = { params: { especialidade: 'Esportiva' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getBySpecialty(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar nutricionistas.' });
    });
  });

  describe('getByName', () => {
    test('deve retornar nutricionistas pelo nome', async () => {
      const mockData = [
        { id: '1', nome: 'Nutricionista 1' },
        { id: '2', nome: 'Nutricionista 2' },
      ];
      db.get.mockResolvedValueOnce({
        docs: mockData.map(doc => ({ id: doc.id, data: () => doc })),
      });

      const req = { params: { nome: 'Nutricionista' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getByName(req, res);

      expect(res.status).toHaveBeenCalledWith(200);
      expect(res.json).toHaveBeenCalledWith(mockData);
    });

    test('deve retornar um erro ao não achar nenhum nutricionista com o nome', async () => {
      db.get.mockResolvedValueOnce({ empty: true });

      const req = { params: { nome: 'Nutricionista 1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getByName(req, res);

      expect(res.status).toHaveBeenCalledWith(404);
      expect(res.json).toHaveBeenCalledWith({ message: 'Nenhum nutricionista encontrado com esse nome.' });
    });

    test('deve retornar um erro ao buscar nutricionistas pelo nome', async () => {
      db.get.mockRejectedValueOnce(new Error('Erro ao buscar nutricionistas.'));

      const req = { params: { nome: 'Nutricionista 1' } };
      const res = {
        status: jest.fn().mockReturnThis(),
        json: jest.fn(),
      };

      await nutricionistaController.getByName(req, res);

      expect(res.status).toHaveBeenCalledWith(500);
      expect(res.json).toHaveBeenCalledWith({ error: 'Erro ao buscar nutricionistas.' });
    });
  });
});