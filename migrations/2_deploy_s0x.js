require('dotenv').config();

// const s0xiety = artifacts.require("s0xiety");
const Affilly8 = artifacts.require("Affilly8");


module.exports = function (deployer) {
  // deployer.deploy(s0xiety, process.env.ADMIN);
  deployer.deploy(Affilly8);

};

