const express = require("express");

const app = express();

app.use(express.json());

app.listen(8080, () => {
  console.log("Server ativo na porta 8080");
});

const { connect, sql } = require("./db");

app.post("/Clientes", async (req, res) => {
  try {
    await connect();

    const { id, nome, email } = req.body;

    const result = await sql.query(
      `INSERT INTO Clientes (ID_Cliente, Nome, email) VALUES (${id},'${nome}', '${email}')`
    );

    res.send("Contato cadastrado com sucesso");
  } catch (err) {
    console.error(err);
    res.status(500).send("Erro interno");
  } finally {
    await sql.close();
  }
});

app.get("/todosClientes", async (req, res) => {
  try {
    await connect();

    const result = await sql.query("SELECT * FROM Clientes");

    const rows = result.recordset.map(({ ID_Cliente, Nome, email }) => ({
      ID_Cliente,
      Nome,
      email,
    }));

    console.table(rows);
  } catch (err) {
    console.error(err);
    res.status(500).send("Erro interno");
  } finally {
    await sql.close();
  }
});
