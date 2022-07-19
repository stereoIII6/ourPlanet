require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const s0xFactory = artifacts.require("s0xFactory");
const Trees = artifacts.require("Trees");
const Co2s = artifacts.require("Co2s");
const GardenPool = artifacts.require("GardenPool");

module.exports = function (deployer) {
  deployer.deploy(MLQ).then(function () {
    deployer.deploy(s0xFactory, MLQ.address);
    deployer.deploy(Trees, MLQ.address);
    deployer.deploy(Co2s, MLQ.address);
    deployer.deploy(GardenPool, Trees.address, Co2s.address, MLQ.address, 2);
  });
};
