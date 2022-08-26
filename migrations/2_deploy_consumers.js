require("dotenv").config();
const PC = artifacts.require("PriceConsumerV3");
/* */ const USDC = artifacts.require("USDC"); // MockUp Testnet */
const VRF = artifacts.require("VRFv2Consumer");
/* 
    Fuji 
        ETH / USD :: 0x86d67c3D38D2bCeE722E601025C25a575021c6EA
        V3 :: 0x7BC470fB2956A46a830959715cEA0229783B74Ac
    Avax
        ETH / USD :: 0x976B3D034E162d8bD72D6b9C989d545b839003b0
        V3 :: 
*/
module.exports = function (deployer) {
  // 0 Fuji // 1 Avax // 2 Fantom Test // 3 Fantom Main // 4 Polygon Mumbai // 5 Polygon Main
  const net = 0;
  deployer.deploy(PC, net);
  // if (net === 0 || net === 2 || net === 4) deployer.deploy(USDC); // we only need to deploy usdc contract on testnet on mainnet we use existing contracts
};
