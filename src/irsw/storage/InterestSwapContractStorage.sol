// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


import { InterestSwapLib } from "../library/InterestSwapLib.sol";
import { SwapContractUtils } from "../library/SwapUtils.sol";

import "../interfaces/lido/IstETH.sol";
import { IInterestSwapContractMarket } from "../interfaces/IInterestSwapProtocol.sol";

contract InterestSwapStorage is IInterestSwapContractMarket {
    Counters.Counter private contractCounter;

    struct InterestSwapContractState {
        uint256 contractTokenId;
        address syTokenAddress;
        mapping(address => InterestSwapLib.DepositReceipt[]) providerDeposit;
        mapping(address => InterestSwapLib.DepositReceipt[]) buyerDeposit;
        mapping(address => InterestSwapLib.SwapRecord[]) buyerClaimableInterests;
        mapping(address => InterestSwapLib.SwapRecord[]) providerClaimableInterests;
        mapping(address => InterestSwapLib.DepositBalance) providerBlance;
        mapping(address => InterestSwapLib.DepositBalance) buyerBalance;
        address[] providerAddresses;
        address[] buyerAddresses;
        uint256 totalLockedAmount;
        uint256 totalLockedProviderAmount;
        uint256 totalLockedBuyerAmount;
        uint256 lockedBlockNumber;
        uint256 lockedBlockNumberTimeStamp;
        bool status;
    }
    mapping(uint256 => InterestSwapContractState) contractStates;
    mapping(uint256 => InterestSwapLib.InterestSetting) contractsInfo;
    ISTETH public stETHContract = ISTETH(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);

    //events definitions
    event SwapContractCreationEvent(
        uint256 indexed contractId,
        uint256 startTime,
        uint256 endTime,
        address erc20Addr,
        uint256 maxPrice,
        uint256 minPrice,
        uint256 minInterest,
        uint256 maxInterest,
        uint256 midInterest
    );
    event OfferEvent(uint256 indexed contractId, uint256 amount, address user);
    event BuyerEvent(uint256 indexed contractId, uint256 amount, address user);
    event LockContractEvent(uint256 indexed contractId);
    event SwapEvent(uint256 indexed contractId);
    event OfferClaimEvent(uint256 indexed contractId);
    event BuyerClaimEvent(uint256 indexed contractId);

    function createSwapContractStorage() public returns (uint256) {
        uint256 contractId = SwapContractUtils.increaseAndGetCountractId(contractCounter);
        contractStates[contractId].contractTokenId = contractId;
        return contractId;
    }

    function setStakingContact(address stakingContractAddress) public {
        stETHContract = ISTETH(stakingContractAddress);
    }

    function setContractInfo(uint256 tokenId, InterestSwapLib.InterestSetting memory contractInfo) public {
        contractsInfo[tokenId] = contractInfo;
    }

    function getContractInfo(uint256 tokenId) public view returns (InterestSwapLib.InterestSetting memory) {
        return contractsInfo[tokenId];
    }

    function getContractStateInfo(uint256 tokenId) public view returns (uint256, uint256, uint256) {
        InterestSwapContractState storage state = contractStates[tokenId];
        return (state.totalLockedAmount, state.totalLockedProviderAmount, state.totalLockedBuyerAmount);
    }

    function getCurrentContractId() public view returns (uint256) {
        return Counters.current(contractCounter);
    }

    function createSwapContract(
        uint startTime,
        uint endTime,
        address erc20Addr,
        uint maxPrice,
        uint minPrice,
        uint minInterest,
        uint maxInterest,
        uint midInterest
    ) public returns (uint256) {
        require(maxInterest< 2000, "maxInterest should be less than 20%");
        require(minInterest< 2000, "minInterest should be less than 20%");
        require(midInterest< 2000, "midInterest should be less than 20%");
        require(minInterest<=maxPrice,"minPrice should be less than mixPrice");

        uint256 contractId = SwapContractUtils.increaseAndGetCountractId(contractCounter);
        contractStates[contractId].contractTokenId = contractId;
        contractsInfo[contractId] = InterestSwapLib.InterestSetting(
            startTime,
            endTime,
            7,
            erc20Addr,
            maxPrice,
            minPrice,
            minInterest,
            maxInterest,
            midInterest,
            0,
            false
        );
        emit SwapContractCreationEvent(
            contractId,
            startTime,
            endTime,
            erc20Addr,
            maxPrice,
            minPrice,
            minInterest,
            maxInterest,
            midInterest
        );
        return contractId;
    }

    function offer(uint256 tokenId, address user, uint256 amount) public payable returns (uint256, uint256, uint256) {
        require(amount == msg.value, "amount should be equal to ethers");
        contractStates[tokenId].providerDeposit[user].push(
            InterestSwapLib.DepositReceipt(tokenId, true, amount, amount, amount, user)
        );
        uint256 stETHAmount = stETHContract.submit{ value: msg.value }(address(this));

        contractStates[tokenId].providerAddresses.push(user);
        contractStates[tokenId].totalLockedAmount += stETHAmount;
        contractStates[tokenId].providerBlance[user].syAmount += stETHAmount;
        contractStates[tokenId].providerBlance[user].ptAmount += amount;
        contractStates[tokenId].providerBlance[user].ytAmount += stETHAmount;
        emit OfferEvent(tokenId, stETHAmount, msg.sender);
        return (
            contractStates[tokenId].providerBlance[user].syAmount,
            contractStates[tokenId].providerBlance[user].ptAmount,
            contractStates[tokenId].providerBlance[user].ytAmount
        );
    }

    function buy(uint256 tokenId, address user, uint256 amount) public payable returns (uint256, uint256, uint256) {
        require(amount == msg.value, "amount should be equal to ethers");
        contractStates[tokenId].buyerDeposit[user].push(
            InterestSwapLib.DepositReceipt(tokenId, false, amount, amount, amount, user)
        );
        uint256 stETHAmount = stETHContract.submit{ value: msg.value }(address(this));

        contractStates[tokenId].buyerAddresses.push(user);
        contractStates[tokenId].totalLockedAmount += stETHAmount;
        contractStates[tokenId].buyerBalance[user].syAmount += stETHAmount;
        contractStates[tokenId].buyerBalance[user].ytAmount += amount;
        contractStates[tokenId].buyerBalance[user].ptAmount += stETHAmount;
        emit BuyerEvent(tokenId, stETHAmount, msg.sender);

        return (
            contractStates[tokenId].buyerBalance[user].syAmount,
            contractStates[tokenId].providerBlance[user].ptAmount,
            contractStates[tokenId].providerBlance[user].ytAmount
        );
    }

    function getProviderPositionByTokenId(uint256 tokenId, address account) public view returns (uint256) {
        return contractStates[tokenId].providerBlance[account].syAmount;
    }

    function getBuyerPositionByTokenId(uint256 tokenId, address account) public view returns (uint256) {
        return contractStates[tokenId].buyerBalance[account].syAmount;
    }

    function lockContract(uint256 tokenId) public {
        contractStates[tokenId].status = true;
        contractStates[tokenId].lockedBlockNumber = block.number;
        contractStates[tokenId].lockedBlockNumberTimeStamp = block.timestamp;
    }

    function calculateBuyerInterest(uint256 tokenId, uint256 currentPrice) internal {
        InterestSwapContractState storage contractState = contractStates[tokenId];
        address[] memory buyerAddresses = contractState.buyerAddresses;
        for (uint256 i = 0; i < buyerAddresses.length; i++) {
            uint256 irAmount = calculateBuyerSwapInterest(tokenId, buyerAddresses[i], currentPrice);
            contractState.buyerClaimableInterests[buyerAddresses[i]].push(
                InterestSwapLib.SwapRecord(tokenId, irAmount, irAmount, irAmount, block.timestamp, block.number)
            );
        }
    }

    function calculateBuyerSwapInterest(
        uint256 tokenId,
        address account,
        uint256 currentPrice
    ) public view returns (uint256) {
        uint256 interestRate = calcualteInterestRate(currentPrice, tokenId);
        uint256 totalBuyerPosition = getBuyerPositionByTokenId(tokenId, account);
        return SafeMath.mul(totalBuyerPosition, interestRate) / 10000;
    }

    function calculateBaseInterestRate(uint256 currentPrice, uint256 tokenId) public view returns (uint256) {

        InterestSwapLib.InterestSetting memory setting = contractsInfo[tokenId];
        if (setting.fixedInterest > 0) {
            return setting.fixedInterest;
        }
        if (currentPrice > setting.maxPrice) {
            return setting.maxInterest;
        }
        if (currentPrice < setting.minPrice) {
            return setting.minInterest;
        }
        return setting.midInterest *10*14; //interest use 18 decimal
    }

    /** 10000 */
    function calcualteInterestRate(uint256 currentPrice, uint256 tokenId) public view returns (uint256) {
        uint currentTimeStampe = block.timestamp;
        uint secondPerDay = 86400;
        uint interval = currentTimeStampe - contractStates[tokenId].lockedBlockNumberTimeStamp;
        uint intervalDay = SafeMath.div(interval, secondPerDay);
        uint baseRate = calculateBaseInterestRate(currentPrice, tokenId);
        uint mulIr = SafeMath.mul(baseRate, intervalDay);
        uint ir = SafeMath.div(mulIr, 365);
        return ir;
    }

    //calcualte fix interest provider swap interest for a given contract
    function calculateProviderSwapInterest(
        uint256 tokenId,
        address depositor,
        address recipient,
        uint256 totalLockedAmount
    ) internal {
        // uint256 totalstEth = stETHContract.getSharesByPooledEth(stETHContract.balanceOf(depositor));
        uint256 providerAmount = getProviderPositionByTokenId(tokenId, recipient);
        uint256 totalProviderAmount = contractStates[tokenId].totalLockedProviderAmount;
        uint256 providerShare = SafeMath.div(providerAmount * 100, totalProviderAmount);
        uint256 swapAmount = SafeMath.mul(totalProviderAmount, providerShare) / 100;
        contractStates[tokenId].providerClaimableInterests[recipient].push(
            InterestSwapLib.SwapRecord(tokenId, swapAmount, swapAmount, swapAmount, block.timestamp, block.number)
        );
    }

    function calculateSwapInterest(uint256 tokenId, uint256 currentPrice, address depositor) external {
        // payout all interest
        calculateBuyerInterest(tokenId, currentPrice);

        uint256 totalLockedAmount = contractStates[tokenId].totalLockedAmount;
        //market maker interest
        InterestSwapContractState storage contractState = contractStates[tokenId];
        address[] memory providerAddresses = contractState.providerAddresses;
        for (uint i = 0; i < providerAddresses.length; i++) {
            address mmAddr = providerAddresses[i];
            calculateProviderSwapInterest(tokenId, depositor, mmAddr, totalLockedAmount);
        }
    }

    function getTotalBuyerInterest(uint256 tokenId, address bueryAddress) public view returns (uint256) {
        InterestSwapLib.SwapRecord[] memory swapCalculateRecords = contractStates[tokenId].buyerClaimableInterests[
            bueryAddress
        ];
        uint256 totalBuyerInterests = 0;
        for (uint i = 0; i < swapCalculateRecords.length; i++) {
            totalBuyerInterests += swapCalculateRecords[i].syAmount;
        }
        return totalBuyerInterests;
    }

    function buyerClaimInerest(uint256 tokenId, address buyerAddress, address depositor) external payable {
        uint256 interests = getTotalBuyerInterest(tokenId, buyerAddress);
        stETHContract.transferFrom(depositor, msg.sender, interests);
    }

    function getProviderTotalPayableInterest(uint256 tokenId, address provider) public view returns (uint256) {
        uint256 providerAmount = getProviderPositionByTokenId(tokenId, provider);
        uint256 totalProviderAmount = contractStates[tokenId].totalLockedProviderAmount;
        uint256 providerShare = SafeMath.div(providerAmount, totalProviderAmount);
        uint256 paybelAmount = SafeMath.mul(totalProviderAmount, providerShare);
        return paybelAmount;
    }

    function getTotalProviderInterest(uint256 tokenId, address provider) public view returns (uint256) {
        InterestSwapLib.SwapRecord[] memory swapCalculateRecords = contractStates[tokenId].providerClaimableInterests[
            provider
        ];
        uint256 totalProviderInterests = 0;
        for (uint i = 0; i < swapCalculateRecords.length; i++) {
            totalProviderInterests += swapCalculateRecords[i].syAmount;
        }

        return totalProviderInterests;
    }

    function providerClaimInterest(uint256 tokenId, address providerAddress, address depositor) external payable {
        uint256 interests = getTotalProviderInterest(tokenId, providerAddress);
        uint256 paybleInterest = getProviderTotalPayableInterest(tokenId, providerAddress);
        if (interests > paybleInterest) {
            stETHContract.transferFrom(depositor, providerAddress, SafeMath.sub(interests, paybleInterest));
        } else {
            contractStates[tokenId].providerBlance[providerAddress].syAmount += SafeMath.sub(interests, paybleInterest);
        }
    }

    function getSwapContractStateLockedBlock(uint256 tokenId) public view returns (uint256) {
        return contractStates[tokenId].lockedBlockNumberTimeStamp;
    }

    function balanceOf() public view returns (uint256) {
        return stETHContract.balanceOf(address(this));
    }

}
