//Criar a biblioteca express
const express = require("express");

//armazenar na váriavel app as funções da biblioteca express
const app = express();

//chamar a função listen para "escutar a porta em que vamos utilizar"
app.listen(8080);

//Criando uma rota de teste

app.get("/teste", () => {
  console.log("Nosso servidor está ativo na porta 8080");
});

//Criando uma rota de teste com HTML
app.get("/testeComHTML", (req, res) => {
  res.send("<h1>Server ativo</h1>");
}); 
