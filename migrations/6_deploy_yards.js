require("dotenv").config();
const Trees = artifacts.require("Trees");
const Co2s = artifacts.require("Co2s");
const GardenPool = artifacts.require("GardenPool");

module.exports = function (deployer) {
  deployer.deploy(GardenPool, Trees.address, Co2s.address, 2);
};
