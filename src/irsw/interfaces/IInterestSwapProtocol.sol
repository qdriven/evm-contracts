// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


interface IInterestSwapContractMarket{

	function createSwapContract(
        uint256 startTime,
        uint256 endTime,
        address erc20Addr,
        uint256 maxPrice,
        uint256 minPrice,
        uint256 minInterest,
        uint256 maxInterest,
        uint256 midInterest) external returns (uint256 );
    function offer(uint256 contractId, address user, uint256 amount) payable external returns (uint256, uint256, uint256);
    function buy(uint256 contractId, address user, uint256 amount) payable external  returns (uint256, uint256, uint256);
    function lockContract(uint256 contractId) external;
    // function getProviderPositionByTokenId(uint256 tokenId, address account) external returns (uint256);
    // function getBuyerPositionByTokenId(uint256 tokenId, address account) external returns (uint256);

    // function swap(uint256 contractId) external;
    // function offerClaim(uint256 contractId) external;
    // function buyerClaim(uint256 contractid) external;
}
