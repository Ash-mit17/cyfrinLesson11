//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNft is ERC721{

    uint256 private _tokenCounter;
    mapping(uint256 => string) private _tokenIdToUri;

    constructor() ERC721("Doggie","DOG"){
        _tokenCounter=0;
    }

    function mintNft(string memory tokenUri) public{
        _tokenIdToUri[_tokenCounter]=tokenUri;
        _safeMint(msg.sender,_tokenCounter);
        _tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns(string memory){
        return _tokenIdToUri[tokenId];
    }

}