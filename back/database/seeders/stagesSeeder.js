// Lista de etapas
// Lista de manutenções
const Maintenances = require("../migrations/maintenances");

const stagesSeeder = [
  {
    description: "descrição etapas",
    type: 2,
    value: "numero",
    maintenanceId: "79a1ed11-7a08-40d6-acd1-941f18ad7da1",
  },
  {
    description: "descrição etapas",
    type: 1,
    value: "text",
    maintenanceId: "1ab5642b-25d8-4b85-9022-2cc7d9d41289",
  },
  {
    description: "descrição etapas",
    type: 2,
    value: "numero",
    maintenanceId: "6c76ecfb-ab9c-4a3c-baf6-96cb60ff5494",
  },
  {
    description: "descrição etapas",
    type: 3,
    value: "foto",
    maintenanceId: "9793b2e6-b527-4cfa-a9db-e30be67c636d",
  },
];

module.exports = stagesSeeder;
