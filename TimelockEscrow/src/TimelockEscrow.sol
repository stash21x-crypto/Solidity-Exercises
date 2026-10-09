// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract TimelockEscrow {
    address public seller;
    mapping(address => uint256) private deposits;
    mapping(address => uint256) private depositTimes;

    /**
     * The goal of this exercise is to create a Time lock escrow.
     * A buyer deposits ether into a contract, and the seller cannot withdraw it until 3 days passes. Before that, the buyer can take it back
     * Assume the owner is the seller
     */

    constructor() {
        seller = msg.sender;
    }

    
    /**
     * creates a buy order between msg.sender and seller
     * escrows msg.value for 3 days which buyer can withdraw at anytime before 3 days but afterwhich only seller can withdraw
     * should revert if an active escrow still exist or last escrow hasn't been withdrawn
     */
    function createBuyOrder() external payable {
        // your code here
        require(msg.value > 0, "Invalid deposit amount");
        require(deposits[msg.sender] == 0, "Active escrow already exists");

        deposits[msg.sender] = msg.value;
        depositTimes[msg.sender] = block.timestamp;
    }

    /**
     * allows seller to withdraw after 3 days of the escrow with @param buyer has passed
     */
    function sellerWithdraw(address buyer) external {
        // your code here
        require(msg.sender == seller, "Only seller can withdraw");
        uint256 amount = deposits[buyer];
        require(amount > 0, "No active escrow");
        // forge-lint: disable-next-line(block-timestamp)
        require(block.timestamp >= depositTimes[buyer] + 3 days, "Escrow is still locked");

        delete deposits[buyer];
        delete depositTimes[buyer];

        (bool success, ) = payable(seller).call{value: amount}("");
        require(success, "Transfer failed");
    }

    /**
     * allows buyer to withdraw at anytime before the end of the escrow (3 days)
     */
    function buyerWithdraw() external {
        // your code here
        uint256 amount = deposits[msg.sender];
        require(amount > 0, "No active escrow");
        // forge-lint: disable-next-line(block-timestamp)
        require(block.timestamp < depositTimes[msg.sender] + 3 days, "Escrow has expired");

        delete deposits[msg.sender];
        delete depositTimes[msg.sender];

        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }

    // returns the escrowed amount of @param buyer
    function buyerDeposit(address buyer) external view returns (uint256) {
        // your code here
        return deposits[buyer];
    }
}
