// contracts/FToken.sol
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.8.0;

import "../node_modules/@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title FToken
 * A simple ERC20 Token, where all tokens are pre-assigned to the creator.
 * Note they can later distribute these tokens as they wish using `transfer` and other
 * `ERC20` functions.
 */
contract FToken is ERC20 {
    /**
     * Constructor that gives msg.sender all of existing tokens.
     */
    constructor(
        string memory _name,
        string memory _symbol,
        uint256 _initialSupply
    ) ERC20(_name, _symbol) {
        _mint(msg.sender, _initialSupply);
    }
}
