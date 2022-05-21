const Sequelize = require('sequelize');
const sequelize = new Sequelize('aero-db', 'root', '1234', {
    dialect: 'sqlite',
    host: "./database/.sqlite"
});

module.exports = sequelize;