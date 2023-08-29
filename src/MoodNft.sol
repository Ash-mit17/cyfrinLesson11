//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {

    error ERC721Metadata__URI_QueryFor_NonExistentToken();
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private _stokenCounter;
    string private _sadSvgImageUri;
    string private _happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private _tokenIdToMood;

    constructor(
        string memory sadSvg,
        string memory happySvg
    ) ERC721("MOOD NFT", "MN") {
        _sadSvgImageUri = sadSvg;
        _happySvgImageUri = happySvg;
        _stokenCounter = 0;
    }

    function mintNft() public {
        _safeMint(msg.sender, _stokenCounter);
        _tokenIdToMood[_stokenCounter] = Mood.HAPPY;
        _stokenCounter++;
    }

    function flipMood(uint256 tokenId) public{
        if(!_isApprovedOrOwner(msg.sender, tokenId)){
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if(_tokenIdToMood[tokenId] == Mood.HAPPY)
            _tokenIdToMood[tokenId]=Mood.SAD;
        else    
             _tokenIdToMood[tokenId]=Mood.HAPPY;
    }

    function _baseURI() internal pure override returns(string memory){
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) {
            revert ERC721Metadata__URI_QueryFor_NonExistentToken();
        }
        string memory imageURI = _sadSvgImageUri;

        if (_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = _happySvgImageUri;
        }
        return
            string(
                abi.encodePacked(
                    _baseURI(),
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"',
                                name(), // You can add whatever name here
                                '", "description":"An NFT that reflects the mood of the owner, 100% on Chain!", ',
                                '"attributes": [{"trait_type": "moodiness", "value": 100}], "image":"',
                                imageURI,
                                '"}'
                            )
                        )
                    )
                )
            );
    }
}
