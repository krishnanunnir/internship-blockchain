var Production = artifacts.require("./Production.sol");

module.exports = function(deployer) {
  deployer.deploy(Production, {gas: 4500000});
};
