// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test, console2, stdError} from "forge-std/Test.sol";
import {Auth} from "../src/Auth.sol";

contract AuthTest is Test {
    Auth public auth;

    function setUp() public {
        auth = new Auth();
    }

    function testSetOwner() public {
        auth.setOwner(address(1));
        assertEq(auth.owner(), address(1));
    }

    // this test will fail
    // function testFailSetOwner() public {
    //     // next call will be called by address(1)
    //     vm.prank(address(1));
    //     auth.setOwner(address(1));

    //     vm.startPrank(address(1));
    //     // all calls until stopPrank will be made by address(1)
    //     auth.setOwner(address(1));
    //     auth.setOwner(address(1));
    //     auth.setOwner(address(1));
    //     vm.stopPrank();
    // }
}