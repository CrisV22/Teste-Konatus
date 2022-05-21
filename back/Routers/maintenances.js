const express = require("express");
const router = express.Router();
const maintenanceController = require("../Controllers/maintenanceController");

router
  .route("/")
  .get(maintenanceController.getAllMaintenance)
  .post(maintenanceController.createMaintenance);

module.exports = router;
