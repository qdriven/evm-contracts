// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.25 <0.9.0;

import { Test } from "forge-std/Test.sol";
import { Foo } from "../src/Foo.sol";

contract FooTest is Test {
    Foo foo;

    function setUp() public {
        foo = new Foo();
    }

    function test_Example() public {
        assertEq(foo.id(42), 42);
    }
}
