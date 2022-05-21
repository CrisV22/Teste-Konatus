const express = require("express");
const router = express.Router();
const stageController = require("../Controllers/stageController");

router
  .route("/")
  .get(stageController.getAllStages)
  .post(stageController.createStage);

module.exports = router;
