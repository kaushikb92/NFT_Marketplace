const FToken = artifacts.require('FToken');

module.exports = async function (deployer) {
  await deployer.deploy(FToken, 'FToken', 'FT', '10000000000000000000000');
};