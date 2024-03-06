//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Token {
    string public name;
    string public symbol;
    uint8 public decimal;
    uint256 public totalSupply; 

    event Transfer(adress from, address to, uint256 amount);

    mapping(adress => uint256) balance;

    function balanceOf(adress _owner) public view returns (uint256) {
        uint256 balanceOfUser = balance[_owner];
        return balanceOfUser;
    }
    function transfer(adress _to, uint256 _value) public returns (bool){
        require(balance[msg.sender] >= _value, "INSUFFICIENT_AMOUNT");
        
        balance[_to] += _value;
        balance[msg.sender] -= _value;
        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
