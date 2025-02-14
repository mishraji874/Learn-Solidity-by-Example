// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {ERC20} from "../src/Send.sol";
import "forge-std/Test.sol";

// Examples of deal and hoax
// deal(address, uint) - set ETH balance of address
// deal(address, address, uint256) - sets ERC20 token balance (works for most tokens)
contract SendTest is Test {
    ERC20 token = new ERC20();

    function testSendEth() public {
        // set eth balance
        deal(address(1), 100);
        assertEq(address(1).balance, 100);

        // set ERC20 balance
        deal(address(token), address(1), 10);
        assertEq(token.balanceOf(address(1)), 10);
    }
}