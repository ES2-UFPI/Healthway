const express = require('express');
const app = express();
const nutricionistaRoutes = require('./routes/nutricionistaRoutes');

app.use(express.json());
app.use('/api/nutricionista', nutricionistaRoutes);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
