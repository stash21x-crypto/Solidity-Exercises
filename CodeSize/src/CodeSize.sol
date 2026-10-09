// SPDX-License-Identifier: BUSL-1.1
pragma solidity ^0.8.13;

contract CodeSize {
    /**
    * The challenge is to create a contract whose runtime code (bytecode) size is greater than 1kb but less than 4kb
    */

    function getCodeSize() public view returns (uint256) {
        return address(this).code.length;
    }

    function a() public pure returns (string memory) {
        return "This string is intentionally long so the compiler emits more bytecode. Repeating this pattern across a few functions pushes the deployed runtime above 1KB while staying under 4KB.";
    }

    function b() public pure returns (string memory) {
        return "This second long string adds more bytecode. The goal is not logic, it is size. Every extra function and long literal increases the contract runtime size.";
    }

    function c() public pure returns (string memory) {
        return "A few long literal strings are enough. Solidity includes them in the deployed runtime, so the contract can easily stay between the required 1KB and 4KB limits.";
    }

    function d() public pure returns (string memory) {
        return "This final function keeps the contract under the limit while making the deployed code large enough to satisfy the challenge test. The functions are intentionally simple.";
    }
}