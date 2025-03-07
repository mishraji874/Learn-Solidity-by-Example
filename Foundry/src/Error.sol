// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

contract Error {
    error NotAuthorized();

    function throwError() external {
        require(false, "not authorized");
    }

    function throwCustomError() external {
        revert NotAuthorized();
    }
}