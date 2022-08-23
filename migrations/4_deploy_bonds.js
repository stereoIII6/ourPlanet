require("dotenv").config();
const MLQ = artifacts.require("MLQ");
const Trees = artifacts.require("Trees");
const USDC = artifacts.require("USDC");
const PC = artifacts.require("PriceConsumerV3");

module.exports = function (deployer) {
  // const usdcadr = USDC.address;
  // const usdcadr = "0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e"; // Mainnet AVAX Droppable USDC
  const usdcadr = "0x5a604d07782b7303bd2327d133f13a58bd17dc43"; // Fuji AVAX
  deployer.deploy(Trees, usdcadr, MLQ.address, PC.address);
};
