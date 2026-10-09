// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract BasicBankV2 {
    /// used to store the balance of users
    ///     USER    =>  BALANCE
    mapping(address => uint256) public balances;

    /// @notice deposit ether into the contract
    /// @dev it should work properly when called multiple times
    function addEther() external payable {
        deposit(msg.value);
    }

    /// @notice used to withdraw ether from the contract
    /// @param amount of ether to remove. Cannot execeed balance i.e users cannot withdraw more than they deposited
    function removeEther(uint256 amount) external payable {
        withdraw(amount);
    }

    function deposit(uint256 amount) internal pure {
        require(amount > 0, "Deposit amount must be greater than zero");
    }

    function withdraw(uint256 amount) internal {
        require(amount > 0, "Withdraw amount must be greater than zero");
        (bool success, ) = msg.sender.call{value: amount}("");
        require(success, "Failed to send Ether");
    }
}
