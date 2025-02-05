/*
There are 3 types of variables in solidity
1. local
    - declared inside a function
    - not stored on the blockchain
2. state
    - decalred outside a function
    - stored on the blockchain
3. global - > provides information about the blockchain
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Variables {
    // state variables are stored on the blockchain
    string public text = "Hello";
    uint256 public num = 123;

    function doSomething() public view {
        // local variables are not saved on the blockchain
        uint256 i = 456;

        // the given below are global variables
        uint256 timestamp = block.timestamp; // current block timestamp
        address sender = msg.sender; // address of the caller
    }
}