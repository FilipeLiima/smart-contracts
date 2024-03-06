//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Token {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply; 

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Approval(address indexed owner, address indexed spender, uint256 amount);

    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowance;

    constructor () {
        name = "Token";
        symbol = "NRX";
        decimals = 18;
        totalSupply = 10000 * 10 ** uint256(decimals);
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address _owner) public view returns (uint256) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) public returns (bool){
        require(balances[msg.sender] >= _value, "INSUFFICIENT_AMOUNT");
        
        balances[_to] += _value;
        balances[msg.sender] -= _value;
        
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(allowance[_from][msg.sender] >= _value, "INSUFFICIENT_ALLOWANCE");

        balances[_from] -= _value;
        balances[_to] += _value;
        
        emit Transfer(_from, _to, _value);
        return true;
    }

    function getAllowance(address _owner, address _spender) public view returns (uint256) {
        return allowance[_owner][_spender];
    }
}
