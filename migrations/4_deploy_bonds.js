require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const Trees = artifacts.require("Trees");
const USDC = artifacts.require("USDC");
const PC = artifacts.require("PriceConsumerV3");

module.exports = function (deployer) {
  deployer.deploy(Trees, USDC.address, MLQ.address, PC.address);
};
