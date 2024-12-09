// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.12;

/**
 * @title Abstract contract storing Wrapped Ether address for the current chain
 */
abstract contract Weth {
    address private immutable WETH;

    /**
     * @notice Sets Wrapped Ether address for the current chain
     * @param weth Wrapped Ether address
     */
    constructor(address weth) {
        WETH = weth;
    }

    /**
     * @notice Returns Wrapped Ether address for the current chain
     * @return weth Wrapped Ether address
     */
    function getWeth() public view returns (address weth) {
        return WETH;
    }
}
