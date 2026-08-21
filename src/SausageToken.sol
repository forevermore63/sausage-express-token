// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

/**
 * @title LauraToken ($LAURA)
 * @notice Value-bearing ERC-20 for the new Laura era / Sausage Express Empire.
 *         Transfer fee routes to a treasury controlled by the owner
 *         (intended for Mercedes Sprinter + sausage army accommodation).
 * @dev User must deploy this themselves. Never share private keys.
 */
contract SausageToken is ERC20, Ownable, ReentrancyGuard {
    address public treasury;
    uint256 public feeBps; // basis points, 100 = 1%

    event FeeUpdated(uint256 newFeeBps);
    event TreasuryUpdated(address indexed newTreasury);
    event FeeCollected(address indexed from, uint256 amount);

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 initialSupply,
        address treasury_,
        uint256 feeBps_
    ) ERC20(name_, symbol_) Ownable(msg.sender) {
        require(treasury_ != address(0), "Invalid treasury");
        require(feeBps_ <= 500, "Fee too high (max 5%)");
        treasury = treasury_;
        feeBps = feeBps_;
        _mint(msg.sender, initialSupply);
    }

    function _update(address from, address to, uint256 value) internal virtual override {
        if (from != address(0) && to != address(0) && feeBps > 0 && value > 0) {
            uint256 fee = (value * feeBps) / 10000;
            if (fee > 0) {
                super._update(from, treasury, fee);
                emit FeeCollected(from, fee);
                value -= fee;
            }
        }
        super._update(from, to, value);
    }

    function setFeeBps(uint256 newFeeBps) external onlyOwner {
        require(newFeeBps <= 500, "Fee too high");
        feeBps = newFeeBps;
        emit FeeUpdated(newFeeBps);
    }

    function setTreasury(address newTreasury) external onlyOwner {
        require(newTreasury != address(0), "Invalid treasury");
        treasury = newTreasury;
        emit TreasuryUpdated(newTreasury);
    }

    // Optional: owner can mint more if needed for future phases
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }
}
