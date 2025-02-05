// To write or update a state variables you need to send a transaction.
// On the other hand, you can read state variables, for free, without any transaction fees.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract SimpleStorage {
    // state variable to store a number
    uint256 public num;

    // you need to send a transaction to write a state variable
    function set(uint256 _num) public {
        num = _num;
    }

    //you can read from a state variable without sending a transaction
    function get() public view returns (uint256) {
        return num;
    }
}