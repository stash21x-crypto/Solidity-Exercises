// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract OneWeekLockup {
    /**
     * In this exercise you are expected to create functions that let users deposit ether
     * Users can also withdraw their ether (not more than their deposit) but should only be able to do a week after their last deposit
     * Consider edge cases by which users might utilize to deposit ether
     *
     * Required function
     * - depositEther()
     * - withdrawEther(uint256 )
     * - balanceOf(address )
     */
    mapping(address => uint256) private userBalances;
    mapping(address => uint256) private lastDepositTime;

    function balanceOf(address user) public view returns (uint256) {
        // return the user's balance in the contract
        return userBalances[user];
    }

    function depositEther() external payable {
        /// add code here
        userBalances[msg.sender] += msg.value;
        lastDepositTime[msg.sender] = block.timestamp;
    }

    function withdrawEther(uint256 amount) external returns (bool) {
        /// add code here
        require(userBalances[msg.sender] >= amount, "Insufficient balance");
        // forge-lint: disable-next-line(block-timestamp)
        require(lastDepositTime[msg.sender] + 7 days < block.timestamp, "Withdrawal not allowed yet");
        userBalances[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
        return true;
    }
}
