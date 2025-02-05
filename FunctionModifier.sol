// Modifiers are code that can be run before and / or after a function call.
// Modifiers can be used to:
// - Restrict access
// - Validate inputs
// - Guard against reentrancy hack

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract FunctionModifier {
    // we will use these variables to demonstrate how to use modifiers.
    address public owner;
    uint256 public x = 10;
    bool public locked;

    constructor() {
        // set the transaction sender as the owner of the contract
        owner = msg.sender;
    }

    // modifier to check that the caller is the owner of the contract
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        // underscore is a special character only usedd inside
        // a function modifier and it tells solidity to
        // execute the rest of the code
        _;
    }

    // modifiers can take inputs. This modifier checks that the
    // address passed in is not the zero address
    modifier validAddress(address _addr) {
        require(_addr != address(0), "Not valid address");
        _;
    }

    function changeOwner(address _newOwner) public onlyOwner validAddress(_newOwner) {
        owner = _newOwner;
    }

    // modifiers can be called before and / or after a function
    // this modifier prevents a function from being called while
    // it is still executing
    modifier noReentrancy() {
        require(!locked, "No reentrancy");
        locked = true;
        _;
        locked = false;
    }

    function decrement(uint256 i) public noReentrancy {
        x -= 1;

        if(i > 1) {
            decrement(i - 1);
        }
    }
}