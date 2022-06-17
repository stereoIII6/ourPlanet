require('dotenv').config();
const Gardens = artifacts.require("Gardens.sol");


module.exports = function (deployer) {
  deployer.deploy(Gardens);
};

