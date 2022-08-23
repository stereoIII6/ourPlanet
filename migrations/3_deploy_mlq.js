require("dotenv").config();

const PC = artifacts.require("PriceConsumerV3");
const MLQ = artifacts.require("MLQ");
/* => */ const USDC = artifacts.require("USDC"); // MockUp Testnet */

module.exports = function (deployer) {
  // const adr = USDC.address;
  // const adr = "0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e"; // Mainnet AVAX Droppable USDC
  const adr = "0x5a604d07782b7303bd2327d133f13a58bd17dc43"; // Fuji AVAX
  deployer.deploy(MLQ, adr, PC.address);
};
