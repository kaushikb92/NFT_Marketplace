// contracts/NFToken.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC721/ERC721.sol";

/**
 * @title NFToken
 * A simple ERC721 Token, where the token can be minted to an owner.
 * Note they can later distribute the token as they wish using `transfer` and other
 * `ERC721` functions.
 */
contract NFToken is ERC721 {
    /**
     * Constructor that sets a name and a symbol for the token.
     */
    constructor (
        string memory _name, 
        string memory _symbol
        ) ERC721(_name, _symbol)
    { }

    /**
    * Custom accessor to create a unique token and assign to an owner
    */
    function mintUniqueTokenTo(
        address _to,
        uint256 _tokenId,
        string memory _tokenURI
    ) public
    {
        _safeMint(_to, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);
    }
}
