// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Script.sol";
import "../src/SausageToken.sol";

contract DeployScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address treasury = vm.addr(deployerPrivateKey); // default treasury = deployer; change later to multisig

        vm.startBroadcast(deployerPrivateKey);

        SausageToken token = new SausageToken(
            "Laura",
            "LAURA",
            1_000_000_000 * 1e18, // 1 billion tokens
            treasury,
            100 // 1% fee
        );

        console.log("Laura Token ($LAURA) deployed at:", address(token));
        console.log("Treasury set to:", treasury);

        vm.stopBroadcast();
    }
}
