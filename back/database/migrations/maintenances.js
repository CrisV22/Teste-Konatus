const Sequelize = require('sequelize');
const database = require('../db');

const Maintenances = database.define('maintenances', {
    id: {
        type: Sequelize.UUID,
        defaultValue: Sequelize.UUIDV4,
        allowNull: false,
        primaryKey: true
    },
    description: Sequelize.STRING,
    status: {
        type: Sequelize.BOOLEAN,
        allowNull: false,
        defaultValue: false
    },
    userId: {
        type: Sequelize.UUID,
        allowNull: false,
    }
}, {
    timstamps: true
});
module.exports = Maintenances;