// Maps are created with the syntax of: mapping(keyType => valueType)
// The `keyType` can be any built-in value type, bytes, string or any contract.
// The `valueType` can be any type including another mapping or an array
// Mappings are not iterable

// SPDX-Licesne-Identifier: MIT
pragma solidity ^0.8.26;

contract Mapping {
    // mapping from address to uint
    mapping(address => uint256) public myMap;

    function get(address _addr) public view returns (uint256) {
        // mapping always returns a value
        // if the value was never set, it will return the default value
        return myMap[_addr];
    }

    function set(address _addr, uint256 _i) public {
        // update the value at this adddress
        myMap[_addr] = _i;
    }

    function remove(address _addr) public {
        // reset the value to the default value
        delete myMap[_addr];
    }
}

contract NestedMapping {
    // Nested mapping (mapping from address to another mapping)
    mapping(address => mapping(uint256 => bool)) public nested;

    function get(address _addr1, uint256 _i) public view returns (bool) {
        // you can get values from a nested mapping
        // even when it is not initialized
        return nested[_addr1][_i];
    }

    function set(address _addr1, uint256 _i, bool _boo) public {
        nested[_addr1][_i] = _boo;
    }

    function remove(address _addr1, uint256 _i) public {
        delete nested[_addr1][_i];
    }
}