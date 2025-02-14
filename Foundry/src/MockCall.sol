// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Target {
    function f(uint256 x, uint256 y) external view returns (uint256) {
        return g();
    }

    function g() internal view returns (uint256) {
        return 1;
    }
}