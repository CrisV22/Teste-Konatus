const Sequelize = require("sequelize");
const database = require("../db");

const Stages = database.define(
  "stages",
  {
    id: {
      type: Sequelize.UUID,
      defaultValue: Sequelize.UUIDV4,
      allowNull: false,
      primaryKey: true,
    },
    description: Sequelize.STRING,
    status: {
      type: Sequelize.BOOLEAN,
      defaultValue: false,
      allowNull: false,
    },
    type: {
      type: Sequelize.TINYINT,
      allowNull: false,
    },
    value: {
      type: Sequelize.STRING,
      allowNull: false,
    },
    maintenanceId: {
      type: Sequelize.UUID,
      allowNull: false,
    },
  },
  {
    timstamps: true,
  }
);
module.exports = Stages;
