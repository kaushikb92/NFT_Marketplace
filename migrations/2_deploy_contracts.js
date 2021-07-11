const FToken = artifacts.require('FToken');
const NFTMarketplace = artifacts.require('NFTMarketplace');

module.exports = async function (deployer) {
  await deployer.deploy(FToken, 'FToken', 'FT', '10000000000000000000000').then(() => deployer.deploy(NFTMarketplace, FToken.address));
};
