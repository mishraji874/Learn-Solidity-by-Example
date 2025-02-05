// Functions are addresses declared `payable` can receive `ether` into the contract.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Payable {
    // payable address can send ether via transfer or send
    address payable public owner;

    // payable constructor can receive ether
    constructor() payable {
        owner = payable(msg.sender);
    }

    // function to deposit ether into this contract
    // call this function alog with some ether
    // the balance of this contract will be automatically updated
    function deposit() public payable {}

    // call this function along with some ether
    // the function will throw an error since this function is not payable
    function notPayable() public {}

    // function to withdraw all ether from this contract
    function withdraw() public {
        // get the amount of ether stored in this contract
        uint256 amount = address(this).balance;

        // send all ether to owner
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Failed to send ether");
    }

    // function to transfer ether from this contract to address from input
    function transfer(address payable _to, uint256 _amount) public {
        // note that "to" is declared as payable
        (bool success, ) = _to.call{value: _amount}("");
        require(success, "Failed to send ether");
    }
}