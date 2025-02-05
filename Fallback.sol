// fallback is a special function that is executed either when

// a function that does not exist is called or
// Ether is sent directly to a contract but receive() does not exist or msg.data is not empty
// To better understand the conditions under which Solidity calls the receive or fallback function, refer to the flowchart below:

//                  send Ether
//                       |
//            msg.data is empty?
//                 /           \
//             yes             no
//              |                |
//     receive() exists?     fallback()
//         /        \
//      yes          no
//       |            |
//   receive()     fallback()


// fallback has a 2300 gas limit when called by transfer or send.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Fallback {
    event Log(string func, uint256 gas);

    // Fallback function must be declared as external.
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit Log("fallback", gasleft());
    }

    // Receive is a variant of fallback that is triggered when msg.data is empty
    receive() external payable {
        emit Log("receive", gasleft());
    }

    // Helper function to check the balance of this contract
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}

contract SendToFallback {
    function transferToFallback(address payable _to) public payable {
        _to.transfer(msg.value);
    }

    function callFallback(address payable _to) public payable {
        (bool sent,) = _to.call{value: msg.value}("");
        require(sent, "Failed to send Ether");
    }
}

// fallback can optionally take bytes for input and output

// TestFallbackInputOutput -> FallbackInputOutput -> Counter
contract FallbackInputOutput {
    address immutable target;

    constructor(address _target) {
        target = _target;
    }

    fallback(bytes calldata data) external payable returns (bytes memory) {
        (bool ok, bytes memory res) = target.call{value: msg.value}(data);
        require(ok, "call failed");
        return res;
    }
}

contract Counter {
    uint256 public count;

    function get() external view returns (uint256) {
        return count;
    }

    function inc() external returns (uint256) {
        count += 1;
        return count;
    }
}

contract TestFallbackInputOutput {
    event Log(bytes res);

    function test(address _fallback, bytes calldata data) external {
        (bool ok, bytes memory res) = _fallback.call(data);
        require(ok, "call failed");
        emit Log(res);
    }

    function getTestData() external pure returns (bytes memory, bytes memory) {
        return
            (abi.encodeCall(Counter.get, ()), abi.encodeCall(Counter.inc, ()));
    }
}