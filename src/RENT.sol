// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RENT is ERC20 {
    address owner;
        constructor() ERC20("RENT", "RNT") {
            owner = msg.sender;
            mint(msg.sender, 500000 * 10 * 18);
    }
    modifier onlyOwner () {
        require(msg.sender == owner, "GFT: Only owner");
        _;
    }
}