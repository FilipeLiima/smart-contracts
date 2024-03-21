pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NFT_RENT is ERC721 {
    address private owner;
    address private tokenAddress; // Endereço do token ERC-20
    uint256 private rentAmount;   // Quantidade de tokens ERC-20 necessários para o pagamento

    // Estrutura para armazenar os metadados de um imóvel
    struct PropertyMetadata {
        string name;
        string description;
        string imageURI; // URL do arquivo JSON de metadados
        // Outras informações relevantes do imóvel podem ser adicionadas aqui
    }

    // Mapeamento do ID do token para os metadados do imóvel
    mapping(uint256 => PropertyMetadata) private propertyMetadata;

    // Evento emitido quando um imóvel é alugado
    event Rent(address owner, address renter, uint256 tokenId);

    // Construtor do contrato
    constructor(address _tokenAddress, uint256 _rentAmount) ERC721("NFT_RENT", "NFTRENT") {
        owner = msg.sender;
        tokenAddress = _tokenAddress;
        rentAmount = _rentAmount;
    }

    // Função para atribuir os metadados a um token - AQUI VOU MINTAR OS NFTS E ASSOCIAR OS IDS DO .JSON
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

    // Função para comprar um token ERC-721 com tokens ERC-20
    function buyToken(uint256 tokenId) public {
        IERC20 token = IERC20(tokenAddress);
        require(token.transferFrom(msg.sender, owner, rentAmount), "NFT_RENT: Failed to transfer tokens");
        _mint(msg.sender, tokenId);
        emit Rent(owner, msg.sender, tokenId);
    }
}
