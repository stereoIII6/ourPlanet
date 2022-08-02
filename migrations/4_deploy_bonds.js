require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const Trees = artifacts.require("Trees");
const USDC = artifacts.require("USDC");

module.exports = function (deployer) {
  deployer.deploy(Trees, MLQ.address, USDC.address);
};
