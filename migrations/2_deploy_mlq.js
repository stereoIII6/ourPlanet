require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const USDC = artifacts.require("USDC");

module.exports = function (deployer) {
  deployer.deploy(MLQ);
  deployer.deploy(USDC);
};
