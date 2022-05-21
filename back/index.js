const express = require("express");
const app = express();
const migrations = require("./database/migrations/migrations");
const bcrypt = require("bcrypt");
//const Users = require("./database/migrations/users");
const seeder = require("./database/seeders/seeders");
const verifyJWT = require("./middleware/verifyJWT");
const cors = require("cors");

const PORT = process.env.PORT || 3500;
(async () => {
  await migrations.migrate();
  await seeder.seed();
})();

const corsOptions = require("./.config/corsOptions");

app.use(express.json());
app.use(cors());

app.use("/login", require("./Routers/login"));

app.use(verifyJWT);
app.use("/maintenances", require("./Routers/maintenances"));
app.use("/stages", require("./Routers/stages"));

app.listen(PORT, () => console.log(`Server runing on port ${PORT}`));
