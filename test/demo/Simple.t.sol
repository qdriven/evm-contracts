// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.7;

import {stdError} from "forge-std/StdError.sol";

import {Test} from "forge-std/Test.sol";

contract ContractBTest is Test {
    uint256 testNumber;

    function setUp() public {
        testNumber = 42;
    }

    function test_NumberIs42() public {
        assert(testNumber==42);
    }

}