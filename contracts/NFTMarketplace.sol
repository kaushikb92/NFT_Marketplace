// contracts/NFTMarketplace.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

import "./FToken.sol";
import "./NFToken.sol";

/**
 * @title NFTMarketplace
 * A simple NFT Marketplace, where anyone can buy and sell NFT with merketplace owned custom ERC20 token.
 */
contract NFTMarketplace is NFToken {

    event Transfer(address indexed buyer, address indexed seller, uint tokenId, uint256 amount);
    event Register(address indexed seller, uint tokenId, string tokenUri, uint256 amount);

    // marketplace owner
    address owner;
    // current price of token by token id
    mapping(uint256 => uint256) currentPrice;
    // Fungible token address
    FToken public ftAddress;

    /**
     * Constructor that initializes NFToken and sets the owner of marketplace
     */
    constructor (address _ftAddress) 
    NFToken("NFToken", "NFT") {
        ftAddress = FToken(_ftAddress);
        owner = msg.sender;
    }

    /**
     * Function that takes a token id and returns price of anon fungible token 
     */
    function getCurrentPrice(uint256 _tokenId) public view returns (uint256) {
        require(_exists(_tokenId));
        return currentPrice[_tokenId];
    }

    /**
     * Function that sets a new price of a non fungible token 
     */
    function setCurrentPrice(uint256 _tokenId, uint256 _amount) public {
        require(_exists(_tokenId));
        require(msg.sender != address(0) && msg.sender == ownerOf(_tokenId));
        require(_amount > 0);
        currentPrice[_tokenId] = _amount;
    }

    /**
     * Function that is invoked by the buyer to purchase a non fungible token
     */
    function purchaseNFT(uint256 _tokenId, uint256 _amount) public {
        require(msg.sender != address(0) && msg.sender != address(this));
        require(_amount >= ftAddress.balanceOf(msg.sender));
        require(_exists(_tokenId));
        require(_amount >= currentPrice[_tokenId]);
        address tokenSeller = ownerOf(_tokenId);
        ftAddress.transfer(owner,_amount);
        safeTransferFrom(tokenSeller, msg.sender, _tokenId);
        emit Transfer(msg.sender, tokenSeller, _tokenId, _amount);
    }

    /**
     * Function that is invoked by the seller to mint a non fungible token by listing a new asset and setting up a price
     */
    function generateNFT(uint256 _tokenId, string memory _tokenUri, uint256 _price) public {
        require(msg.sender != address(0) && msg.sender != address(this));
        require(_price > 0);
        require(!_exists(_tokenId));
        mintUniqueTokenTo(msg.sender, _tokenId, _tokenUri);
        setCurrentPrice(_tokenId, _price);
        Register(msg.sender, _tokenId, _tokenUri, _price);
    }
}
