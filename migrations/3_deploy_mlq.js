require("dotenv").config();

const PC = artifacts.require("PriceConsumerV3");
const MLQ = artifacts.require("MLQ");
/* */ const USDC = artifacts.require("USDC"); // MockUp Testnet */

module.exports = function (deployer) {
  deployer.deploy(MLQ, USDC.address, PC.address);
};
