const express = require('express');
const app = express();
const nutricionistaRoutes = require('./routes/nutricionistaRoutes');
const pacienteRoutes = require('./routes/pacienteRoutes');

app.use(express.json());
app.use('/api/nutricionistas', nutricionistaRoutes);
app.use('/api/pacientes', pacienteRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
