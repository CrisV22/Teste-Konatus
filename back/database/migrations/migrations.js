const migrate = (async () => {
    const database = require('../db');
    const Users = require('./users');
    const Maintenances = require('./maintenances');
    const Stages = require('./stages');

    try {
        Maintenances.belongsTo(Users, {
            constraint: true, 
            foreignKey: 'userId'
        });
        Stages.belongsTo(Maintenances, {
            constraint: true, 
            foreignKey: 'maintenanceId'
        });
        await database.sync();
    } catch (error) {
        console.log(error);
    }
});

module.exports = { migrate };