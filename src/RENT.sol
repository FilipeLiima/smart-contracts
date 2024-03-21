// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RENT is ERC20 {
    address private owner; // Endereço do proprietário do contrato

    // Construtor do contrato ERC20
    constructor() ERC20("RENT", "RNT") {
        owner = msg.sender; // Define o endereço do criador do contrato como proprietário
        _mint(msg.sender, 500000 * 10 ** 18); // Emite 500.000 tokens RNT com 18 casas decimais e atribui ao proprietário
    }
    
    // Modificador para permitir que apenas o proprietário execute certas funções
    modifier onlyOwner () {
        require(msg.sender == owner, "RENT: Only owner");
        _;
    }

    // Função para aprovar que um endereço gaste tokens em nome do usuário
    function approve(address spender, uint256 amount) public override returns (bool) {
        super.approve(spender, amount); // Chama a função approve da biblioteca ERC20
        return true;
    }

    // Função para transferir tokens de um endereço para outro, se aprovado
    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        super.transferFrom(sender, recipient, amount); // Chama a função transferFrom da biblioteca ERC20
        return true;
    }

    // Função para comprar um token ERC721 com tokens ERC20
    function buyERC721(address erc721Contract, uint256 tokenId, uint256 amount) public returns (bool) {
        // Transfere a quantidade especificada de tokens ERC20 para este contrato
        IERC20(tokenAddress).transferFrom(msg.sender, address(this), amount);
        // Assume que o contrato ERC721 possui uma função buy para lidar com a compra
        require(ERC721(erc721Contract).buy(msg.sender, tokenId), "RENT: Failed to buy ERC721");
        return true;
    }

    // Função para verificar o saldo de tokens de um determinado endereço
    function getBalance(address account) public view returns (uint256) {
        return balanceOf(account); // Retorna o saldo de tokens do endereço especificado
    }
}
