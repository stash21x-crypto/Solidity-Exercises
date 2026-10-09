// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBank {
    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        deposit(msg.value);
    }

    /// @notice used to withdraw ether from the contract (No restriction on withdrawals)
    function removeEther(uint256 amount) external payable {
        withdraw(amount);
    }

    function deposit(uint256 amount) internal pure {
        require(amount > 0, "amount must be > 0");
    }

    function withdraw(uint256 amount) internal {
        require(address(this).balance >= amount, "insufficient balance");
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "withdraw failed");
    }
}
