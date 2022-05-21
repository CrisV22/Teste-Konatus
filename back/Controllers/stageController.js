const Stages = require("../database/migrations/stages");

const getAllStages = async (req, res) => {
  try {
    const maintenance = await Stages.findAll();
    res.status(200).json(maintenance);
  } catch (err) {
    res.status(400).send(err);
  }
};

const createStage = async (req, res) => {
  try {
    const userId = res.userId;
    const { maintenanceId, description, type, value } = req.body;

    // Impedindo inserção de valores nulos
    if (!description || !type || !value || !maintenanceId)
      return res.status(400).json({
        message: "Um dos campos esta vazio.",
      });

    // Tratando status

    // Construindo Stage
    const newStage = {
      maintenanceId: maintenanceId,
      description: description,
      type: type,
      value: value,
    };

    //await Stages.create(newStage);
    await Stages.create(newStage);
    console.log(Stages);
    res.status(201).json(newStage);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

module.exports = {
  getAllStages,
  createStage,
};
