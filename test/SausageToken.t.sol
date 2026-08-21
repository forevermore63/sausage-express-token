// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/SausageToken.sol";

contract SausageTokenTest is Test {
    SausageToken token;
    address owner = address(0x1);
    address user = address(0x2);
    address treasury = address(0x3);

    function setUp() public {
        vm.prank(owner);
        token = new SausageToken("Sausage Token", "SAUSAGE", 1_000_000 ether, treasury, 100);
    }

    function testInitialSupply() public {
        assertEq(token.totalSupply(), 1_000_000 ether);
        assertEq(token.balanceOf(owner), 1_000_000 ether);
    }

    function testFeeOnTransfer() public {
        vm.prank(owner);
        token.transfer(user, 1000 ether);

        // 1% fee = 10 ether to treasury
        assertEq(token.balanceOf(treasury), 10 ether);
        assertEq(token.balanceOf(user), 990 ether);
    }

    function testSetFee() public {
        vm.prank(owner);
        token.setFeeBps(50); // 0.5%
        assertEq(token.feeBps(), 50);
    }
}
