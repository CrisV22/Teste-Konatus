const Sequelize = require('sequelize');
const database = require('../db');
const bcrypt = require("bcrypt");

const Users = database.define('users', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true
    },
    login: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    password: {
        type: Sequelize.STRING,
        allowNull: false,
    },
}, {
    timstamps: true,
    hooks: {
        beforeCreate: async (user) => {
            user.password = await bcrypt.hash(user.password, bcrypt.genSaltSync(8));
        },
        beforeUpdate:  async (user) => {
            user.password = await bcrypt.hash(user.password, bcrypt.genSaltSync(8));
        }
    }
});
module.exports = Users;