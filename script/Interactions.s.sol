//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract MintBasicNft is Script{

    string public constant PUG = "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";

    function run() external{
        address mostRecentDeployed = DevOpsTools.get_most_recent_deployment(
            "BasicNft",
            block.chainid);
        mintNftOnContract(mostRecentDeployed);
    }

    function mintNftOnContract(address contractAddress) public{
        vm.startBroadcast();
        BasicNft(contractAddress).mintNft(PUG);
        vm.stopBroadcast(); 
    }
}