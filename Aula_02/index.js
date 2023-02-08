const express = require("express");

const app = express();

app.listen(8080, () => console.log("Servidor ativo na porta 8080"));

app.use(express.json());

const bodyParser = require("body-parser");

app.use(bodyParser.urlencoded({ extended: false }));

let nomes = ["Lois", "Lana", "Clark", "Bruce"];

//Entrada via JSON
app.post("/testeGET", (req, res) => {
  const { name } = req.body;
  console.log(name);
});

//Entrada via HTML
app.post("/testeGETHTML", (req, res) => {
  const { name } = req.body;
  console.log(name);
  nomes.push(name);

  return res.send(`<h1>${[nomes]}</h1>`);
});
