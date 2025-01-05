const request = require('supertest');
const express = require('express');

// Mock do firebase-admin
jest.mock('firebase-admin', () => ({
  initializeApp: jest.fn(),
  credential: {
    cert: jest.fn()
  },
  firestore: jest.fn(() => ({
    collection: jest.fn()
  }))
}));

// Mock do arquivo de configuração do Firebase
jest.mock('../../firebase-config', () => ({
  collection: jest.fn()
}));

const db = require('../../firebase-config');
const router = require('../../routes/nutricionistaRoutes');

// Criar app Express para testes
const app = express();
app.use(express.json());
app.use('/api/nutricionistas', router);

// testando get nutricionista por especialidade
describe('NutricionistaController Tests', () => {
  beforeEach(() => {
    jest.clearAllMocks();
  });

  describe('GET /api/nutricionistas/specialty/:specialty', () => {
    it('should return nutricionistas when found', async () => {

      const mockNutricionistas = [
        {
          id: '1',
          nome: 'João',
          especialidade: 'esportiva',
          crn: '12345'
        },
        {
          id: '2',
          nome: 'Maria',
          especialidade: 'esportiva',
          crn: '67890'
        }
      ];

      const mockGet = jest.fn().mockResolvedValue({
        empty: false,
        docs: mockNutricionistas.map(doc => ({
          id: doc.id,
          data: () => ({
            nome: doc.nome,
            especialidade: doc.especialidade,
            crn: doc.crn
          })
        }))
      });

      db.collection.mockReturnValue({
        where: jest.fn().mockReturnValue({
          get: mockGet
        })
      });

      const response = await request(app)
        .get('/api/nutricionistas/specialty/esportiva');


      expect(db.collection).toHaveBeenCalledWith('nutricionista');


      expect(response.status).toBe(200);
      expect(Array.isArray(response.body)).toBe(true);
      expect(response.body).toHaveLength(2);
      expect(response.body).toEqual(expect.arrayContaining([
        expect.objectContaining({
          especialidade: 'esportiva'
        })
      ]));
    });

    it('should return 404 when no nutricionistas found', async () => {
      const mockGet = jest.fn().mockResolvedValue({
        empty: true,
        docs: []
      });

      db.collection.mockReturnValue({
        where: jest.fn().mockReturnValue({
          get: mockGet
        })
      });


      const response = await request(app)
        .get('/api/nutricionistas/specialty/inexistente');


      expect(response.status).toBe(404);
      expect(response.body).toEqual({
        message: 'Nenhum nutricionista encontrado com essa especialidade.'
      });
    });

    it('should return 500 when database error occurs', async () => {
      db.collection.mockReturnValue({
        where: jest.fn().mockReturnValue({
          get: jest.fn().mockRejectedValue(new Error('Database error'))
        })
      });

      const response = await request(app)
        .get('/api/nutricionistas/specialty/esportiva');

      expect(response.status).toBe(500);
      expect(response.body).toHaveProperty('error');
    });
  });
});


