// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract AssemblyVariable {
    function yul_let() public pure returns (uint256 z) {
        assembly {
            // language used for assembly is called Yul
            // local variables
            let x := 123
            z := 456
        }
    }
}