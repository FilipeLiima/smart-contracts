// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console2} from "forge-std/Script.sol";
import {RENT} from "../src/RENT.sol";

contract RENTScript is Script {
    RENT public rent; // Declaração da variável rent

    function setUp() public {}

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);
        rent = new RENT();
        console2.log("Address: ", address(rent)); // Correção na impressão do endereço
        vm.stopBroadcast();
    }
}
