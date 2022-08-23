require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const s0xFactory = artifacts.require("s0xFactory");
const ecoverse = artifacts.require("ecoverse");
const Trees = artifacts.require("Trees");
const Co2s = artifacts.require("Co2s");

module.exports = function (deployer) {
  deployer.deploy(s0xFactory, MLQ.address);
  deployer.deploy(Co2s, Trees.address, 2, MLQ.address);
  deployer.deploy(ecoverse, Trees.address);
};
