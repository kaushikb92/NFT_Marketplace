const FToken = artifacts.require('FToken');
const NFToken = artifacts.require('NFToken');

module.exports = async function (deployer) {
  await deployer.deploy(FToken, 'FToken', 'FT', '10000000000000000000000');
  await deployer.deploy(NFToken, 'NFToken', 'NFT');
};
