// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {NFT_RENT} from "../src/NFT_RENT.sol";
import {RENT} from "../src/RENT.sol";

contract NFT_RENTScript is Script {
    NFT_RENT public rent; 

    function setUp() public {}

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);
        rent = new NFT_RENT(address(new RENT()), 500); // Criar nova instância do contrato RENT
        console2.log("Address: ", address(rent));
        vm.stopBroadcast();
    }
}
