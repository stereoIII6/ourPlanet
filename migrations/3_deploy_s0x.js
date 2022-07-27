require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const USDC = artifacts.require("USDC");
const s0xFactory = artifacts.require("s0xFactory");
const Trees = artifacts.require("Trees");

module.exports = function (deployer) {
  deployer.deploy(s0xFactory, MLQ.address);
  deployer.deploy(Trees, MLQ.address, USDC.address);
};
