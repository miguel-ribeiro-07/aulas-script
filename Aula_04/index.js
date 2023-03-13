const express = require('express');
const { PrismaClient } = require('@prisma/client');
const sql = require('mssql');

const app = express();
const prisma = new PrismaClient();

const config = {
  user: 'sa',
  password: '123456',
  server: 'localhost',
  port: 1434,
  database: 'SCRIPT',
  trustServerCertificate: true
};

app.get('/alunos', async (req, res) => {
  const pool = await sql.connect(config);
  const result = await pool.request().query('SELECT * FROM aluno');
  res.json(result.recordset);
});


app.listen(8080, () => {
  console.log('Servidor rodando na porta 8080');
});