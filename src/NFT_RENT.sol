// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract NFT_RENT is ERC721 {
    // Endereço do proprietário do contrato
    address private owner;

    // Estrutura para armazenar os metadados de um imóvel
    struct PropertyMetadata {
        string name;
        string description;
        string imageURI; // URL do arquivo JSON de metadados
        // Outras informações relevantes do imóvel podem ser adicionadas aqui
    }

    // Mapeamento do ID do token para os metadados do imóvel
    mapping(uint256 => PropertyMetadata) private propertyMetadata;

    // Construtor do contrato
    constructor() ERC721("NFT_RENT", "NFTRENT") {
        owner = msg.sender;
    }

    // Função para atribuir os metadados a um token - AQUI EU CONSIGO MINTAR VÁRIOS TOKENS ERC721 E ATRIBUIR AO ID DE UM IMÓVEL NO ARQUIVO .JSON
    function setPropertyMetadata(uint256 tokenId, string memory name, string memory description, string memory imageURI) public {
        require(msg.sender == ownerOf(tokenId), "NFT_RENT: Caller is not the owner of the token");
        PropertyMetadata storage metadata = propertyMetadata[tokenId];
        metadata.name = name;
        metadata.description = description;
        metadata.imageURI = imageURI;
    }

    // Função para obter os metadados de um token
    function getPropertyMetadata(uint256 tokenId) public view returns (string memory name, string memory description, string memory imageURI) {
        PropertyMetadata memory metadata = propertyMetadata[tokenId];
        return (metadata.name, metadata.description, metadata.imageURI);
    }
}
