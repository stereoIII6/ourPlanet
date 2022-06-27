require('dotenv').config();
const MLQ = artifacts.require("MLQ");


module.exports = function (deployer) {
  deployer.deploy(MLQ,process.env.ADMIN,process.env.AVAX);
};

