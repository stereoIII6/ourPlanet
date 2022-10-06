require("dotenv").config();
const { ethereum } = require("ethers");
const MLQ = artifacts.require("MLQ");
const Trees = artifacts.require("Trees");
const USDC = artifacts.require("USDC");
const PC = artifacts.require("PriceConsumerV3");

module.exports = function (deployer) {
  // const usdcadr = USDC.address
  let usdcadr;
  // 0 Fuji // 1 Avax // 2 Fantom Test // 3 Fantom Main // 4 Polygon Mumbai // 5 Polygon Main
  const netty = 5;
  if (netty === 0) usdcadr = "0x5a604d07782b7303bd2327d133f13a58bd17dc43"; // Fuji AVAX
  if (netty === 1) usdcadr = "0xb97ef9ef8734c71904d8002f8b6bc66dd9c48a6e"; // Mainnetty AVAX

  if (netty === 2) usdcadr = "0x02092f80664C3FD44bBb9590D0722b7117BB8CeD"; // Test FTM 4002
  if (netty === 3) usdcadr = "0x04068DA6C83AFCFA0e13ba15A6696662335D5B75"; // Mainnetty FTM 250

  if (netty === 4) usdcadr = "0xCfA542b644F8FfA46e79d88cF4E7347E49aD2ddc"; // Mumbai Polygon 80001
  if (netty === 5) usdcadr = "0x2791Bca1f2de4661ED88A30C99A7a9449Aa84174"; // Main Polygon 137

  deployer.deploy(Trees, usdcadr, MLQ.address, PC.address, netty);
};
