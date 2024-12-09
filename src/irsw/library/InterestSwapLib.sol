// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

library InterestSwapLib {

    struct InterestSetting {
        uint256 startTime;
        uint256 endTime;
        uint256 intervalTimePeriod;
        address erc20;
        uint256 minPrice;
        uint256 maxPrice;
        uint256 minInterest;
        uint256 midInterest;
        uint256 maxInterest;
        uint256 fixedInterest;
        bool lockStatus;
    }

    struct DepositReceipt {
        uint256 contractTokenId;
        bool provider;
        uint256 syAmount;
        uint256 ptAmount;
        uint256 ytAmount;
        address depositor;
    }

    struct DepositBalance {
        uint256 contractTokenId;
        uint256 syAmount;
        uint256 ptAmount;
        uint256 ytAmount;
    }


    struct SwapRecord {
        uint256 contractTokenId;
        uint256 syAmount;
        uint256 ptAmount;
        uint256 ytAmount;
        uint256 swapTime;
        uint256 blockHight;
    }

}
