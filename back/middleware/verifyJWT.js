const jwt = require("jsonwebtoken");
require("dotenv").config();
const Users = require("../database/migrations/users");

const verifyJWT = (req, res, next) => {
  const authHeader = req.headers["authorization"];

  if (!authHeader) return res.sendStatus(401);

  //console.log(authHeader); // Bearer token
  // Creating the token
  const token = authHeader.split(" ")[1];
  // Verifying the token
  jwt.verify(token, process.env.ACCESS_TOKEN_SECRET, async (err, decoded) => {
    if (err) return res.sendStatus(403); // Invalid token
    res.userId = decoded.id;

    next();
  });
};

module.exports = verifyJWT;
