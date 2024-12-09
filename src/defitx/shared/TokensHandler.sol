// SPDX-License-Identifier: LGPL-3.0-only

pragma solidity 0.8.12;

import { ITokensHandler } from "../interfaces/ITokensHandler.sol";

import { Base } from "./Base.sol";
import { Ownable } from "./Ownable.sol";

/**
 * @title Abstract contract returning tokens lost on the contract
 */
abstract contract TokensHandler is ITokensHandler, Ownable {
    receive() external payable {
        // solhint-disable-previous-line no-empty-blocks
    }

    /**
     * @inheritdoc ITokensHandler
     */
    function returnLostTokens(address token, address payable beneficiary) external onlyOwner {
        Base.transfer(token, beneficiary, Base.getBalance(token));
    }
}
