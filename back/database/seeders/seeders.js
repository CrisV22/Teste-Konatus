const seed = async () => {
  const database = require("../db");
  const Users = require("../migrations/users");
  const Maintenances = require("../migrations/maintenances");
  const Stages = require("../migrations/stages");
  const usersSeeder = require("./usersSeeder");
  const maintenancesSeeder = require("./maintenancesSeeder");
  const stagesSeeder = require("./stagesSeeder");

  try {
    await Users.bulkCreate(usersSeeder);
    await Maintenances.bulkCreate(maintenancesSeeder);
    await Stages.bulkCreate(stagesSeeder);
  } catch (error) {
    console.log(error);
  }
};

module.exports = { seed };
