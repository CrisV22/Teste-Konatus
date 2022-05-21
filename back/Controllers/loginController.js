const Users = require("../database/migrations/users");
//const { Op } = require("sequelize");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
require("dotenv").config();

const handleLogin = async (req, res) => {
  try {
    const { login, password } = req.body;

    if (!login || !password)
      return res.status(400).json({
        message: "Username and password are required.",
      });

    const foundUser = await Users.findOne({
      where: {
        login: login,
      },
    });
    console.log(foundUser);
    if (!foundUser) return res.sendStatus(401);

    const match = await bcrypt.compare(password, foundUser.password);

    if (match) {
      const accessToken = jwt.sign(
        { id: foundUser.id },
        process.env.ACCESS_TOKEN_SECRET,
        { expiresIn: "10d" }
      );

      const refreshToken = jwt.sign(
        { id: foundUser.id },
        process.env.REFRESH_TOKEN_SECRET,
        { expiresIn: "10d" }
      );

      res.cookie("jwt", refreshToken, {
        httpOnly: true,
        maxAge: 24 * 60 * 60 * 1000,
      });

      res.json({ accessToken }); // Store the access token in memory
    } else {
      res.sendStatus(401); // 401 -> Unauthorized
    }
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

module.exports = {
  handleLogin,
};
