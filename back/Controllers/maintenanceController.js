const Maintenances = require("../database/migrations/maintenances");

const getAllMaintenance = async (req, res) => {
  try {
    const maintenance = await Maintenances.findAll();
    res.status(200).json(maintenance);
  } catch (err) {
    res.status(400).send(err);
  }
};

const createMaintenance = async (req, res) => {
  try {
    const userId = res.userId;
    const { description } = req.body;

    // Impedindo inserção de valores nulos
    if (!description || !userId)
      return res.status(400).json({
        message: "Description or status or name wasn't inserted.",
      });

    // Tratando status

    // Construindo Maintenance
    const newMaintenance = {
      description: description,
      userId: userId,
    };

    //await Maintenances.create(newMaintenance);
    await Maintenances.create(newMaintenance);
    console.log(Maintenances);
    res.status(201).json(newMaintenance);
  } catch (err) {
    res.status(500).json({ message: err.message });
  }
};

module.exports = {
  getAllMaintenance,
  createMaintenance,
};
