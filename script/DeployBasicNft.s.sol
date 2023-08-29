//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {BasicNft} from "../src/BasicNft.sol";

contract DeployBasicNft is Script{
    
    function run() external returns(BasicNft){
        BasicNft basicnft;
        vm.startBroadcast();
        basicnft = new BasicNft();
        vm.stopBroadcast();
        return basicnft;
    }
}

//0x250FEE45DBdFA908c421DB09479f387B28441805