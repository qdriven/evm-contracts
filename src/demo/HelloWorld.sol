// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.7;

contract HelloWorld {
    string private name;
    constructor(string memory _world) {
        name=_world;
    }

    function get() public view returns(string memory){
        return name;
    }

    function set(string memory _world) public {
        name=_world;
    }
}