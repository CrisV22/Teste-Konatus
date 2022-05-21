const express = require("express");
const app = express();

const whitelist = [
  "https://www.google.com",
  "http://127.0.0.1:5500",
  "localhost:3500",
];

// Criando uma função para barrar sites não listados no whitelist.
const corsOptions = {
  // origin_1 : (origin_2 -> dominio de que esta requisitando acesso ao back, callback)
  origin: (origin, callback) => {
    // REMOVE || !origin AFTER THE DEVELOPMENT
    if (whitelist.indexOf(origin) !== -1 || !origin) {
      //Se o dominio constar no whitelist, faça:
      callback(null, true);
      // null -> erro
      // true -> origin é passado adiante.
    } else {
      // O expressjs segura grande parte dos erros.
      callback(new Error("Not allowed by CORS."));
    }
  },
  optionsSucessStatus: 200,
};

// Add headers
app.use(function (req, res, next) {
  // Website you wish to allow to connect
  res.setHeader("Access-Control-Allow-Origin", "http://localhost:3500");

  // Request methods you wish to allow
  res.setHeader(
    "Access-Control-Allow-Methods",
    "GET, POST, OPTIONS, PUT, PATCH, DELETE"
  );

  // Request headers you wish to allow
  res.setHeader(
    "Access-Control-Allow-Headers",
    "X-Requested-With,content-type"
  );

  // Set to true if you need the website to include cookies in the requests sent
  // to the API (e.g. in case you use sessions)
  res.setHeader("Access-Control-Allow-Credentials", true);

  // Pass to next layer of middleware
  next();
});

module.exports = corsOptions;
