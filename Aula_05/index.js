const express = require("express")

const app = express()

app.listen(8080, () => {
  console.log("O server está ativo na porta 8080")
})

app.use(express.json())

const {connect, sql} = require('./data/database')

app.post('/Aluno', async (req, res) =>{
  try {
    await connect()

    const {id, nome, idade} = req.body;

    const result = await sql.query(`INSERT INTO Aluno (ID, Nome, Idade)
     VALUES (${id}, ${nome}, ${idade})`)

     res.send("Cadastro realizado com sucesso!")
  } catch (err) {
    console.log(err);
    res.status(500).send("Erro interno")
  } finally{
    await sql.close()
  }

})
