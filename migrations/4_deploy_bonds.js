require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const Trees = artifacts.require("Trees");
const Co2s = artifacts.require("Co2s");

module.exports = function (deployer) {
  deployer.deploy(Co2s, Trees.address, 2, MLQ.address);
};
