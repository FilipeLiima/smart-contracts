// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT_RENT is ERC721 {
    address owner;

    constructor() ERC721("NFT_RENT", "NFT_RENT") {
        owner = msg.sender;
    }

    function mint(address to, uint256 tokenId) external onlyOwner {
        _mint(to, tokenId);
    }
}
