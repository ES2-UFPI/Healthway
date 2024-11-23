const express = require('express');
const app = express();
const nutricionistaRoutes = require('./routes/nutricionistaRoutes');
const pacienteRoutes = require('./routes/pacienteRoutes');
const consultaRoutes = require('./routes/consultaRoutes');
const planoAlimentarRoutes = require('./routes/planoAlimentarRoutes');
const alimentosRoutes = require('./routes/alimentoRoutes');
const refeicaoRoutes = require('./routes/refeicaoRoutes');

app.use(express.json());
app.use('/api/nutricionistas', nutricionistaRoutes);
app.use('/api/pacientes', pacienteRoutes);
app.use('/api/consultas', consultaRoutes);
app.use('/api/planos-alimentares', planoAlimentarRoutes);
app.use('/api/alimentos', alimentosRoutes);
app.use('/api/refeicoes', refeicaoRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
