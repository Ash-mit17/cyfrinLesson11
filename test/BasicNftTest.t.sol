//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {DeployBasicNft} from "../script/DeployBasicNft.s.sol";

contract BasicNftTest is Test{
    DeployBasicNft public deployer;
    BasicNft public basicnft;
    address public user = makeAddr("user");
    string public constant PUG = "https://ipfs.io/ipfs/QmSsYRx3LpDAb1GZQm7zZ1AuHZjfbPkD6J7s9r41xu1mf8?filename=pug.png";

    function setUp() external{
        deployer=new DeployBasicNft();
        basicnft = deployer.run();
    }

    function testNameIsCorrect() public{
        string memory expectedName = "Doggie";
        string memory actualName = basicnft.name();
        assertEq(expectedName, actualName);
    }

    function testCanMintAndhaveBalance() public {
        vm.prank(user);
        basicnft.mintNft(PUG);
        assert(basicnft.balanceOf(user) == 1);
    }
}