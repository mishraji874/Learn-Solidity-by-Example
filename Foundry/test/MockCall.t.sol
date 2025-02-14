// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "forge-std/Test.sol";
import {Target} from "../src/MockCall.sol";

contract MockCallTest is Test {
    Target target;

    function setUp() public {
        target = new Target();
    }

    function test() public {
        uint256 x = 1;
        uint256 y = 1;
        vm.mockCall(
            address(target),
            abi.encodeCall(Target.f, (x, y)),
            abi.encode(uint256(99))
        );

        // returns 99
        uint256 res = target.f(x, y);
        console.log("res", res);
    }
}