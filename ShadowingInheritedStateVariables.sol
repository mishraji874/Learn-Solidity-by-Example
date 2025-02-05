// Unlike functions, state variables cannot be overridden by re-declaring it in the child contract.

// Let's learn how to correctly override inherited state variables.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract A {
    string public name = "Contract A";

    function getName() public view returns (string memory) {
        return name;
    }
}

// shadowing is disallowed in solidity 0.6
// this will not compile
// contract B is A {
//    string public name = "Contract B";
// }

contract C is A {
    // this is the correct way to ovverdide inherited state variables.
    constructor() {
        name = "Contract C";
    }

    // C.getName returns "Contract C"
}