// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "forge-std/Test.sol";
import "forge-std/console.sol";


contract TestNewIRSWapContractStorage is Test {
    InterestSwapStorage irswValue;
    StETHMockERC20 mock;
    uint256 contractId;
    address buyerAccount;
    address providerAccount;

    //1. setup contract
    function setUp() public {
        irswValue = new InterestSwapStorage();
        buyerAccount = address(0x2);
        providerAccount = address(0x1);

        console.log("deploy address InterestSwapStorage ");
        mock = new StETHMockERC20();
        mock.setTotalShares(100);
        mock.setTotalPooledEther(100);
        console.log("mock address is done ", address(mock));
        contractId = irswValue.createSwapContract(1691608979, 1704287379, 0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84, 2000, 1800, 4, 6, 5);
        console.log("set mock address ");
        irswValue.setStakingContact(address(mock));
    }

    function checkContractInfo(uint256 tokenId) public {
        InterestSwapLib.InterestSetting memory existingContractInfo = irswValue.getContractInfo(tokenId);
        console.log("existingContractInfo.minInterest", existingContractInfo.minInterest);
        console.log("existingContractInfo.maxInterest", existingContractInfo.maxInterest);
        console.log("existingContractInfo.midInterest", existingContractInfo.midInterest);
        console.log("existingContractInfo.fixedInterest", existingContractInfo.fixedInterest);
        console.log("existingContractInfo.minPrice", existingContractInfo.minPrice);
        console.log("existingContractInfo.maxPrice", existingContractInfo.maxPrice);

        assertEq(existingContractInfo.minInterest, 4);
        assertEq(existingContractInfo.midInterest, 6);
        assertEq(existingContractInfo.fixedInterest, 0);
    }

    //2. offer 1000
    function testOffer() public {
        address accountAddr = providerAccount;
        // startHoax(accountAddr);
        vm.startPrank(accountAddr);
        vm.deal(accountAddr, 10 ether);
        (uint256 a, uint256 b, uint256 c) = irswValue.offer{ value: 1000 }(contractId, accountAddr, 1000);
        console.log(a, b, c);
        vm.stopPrank();
        irswValue.offer{ value: 1000 }(contractId, accountAddr, 1000);
        console.log(address(msg.sender));
        console.log("contract balance of testing account token ", mock.balanceOf(accountAddr));
        console.log("contract balance of contract account token ", mock.balanceOf(address(irswValue)));
        console.log("contract balance of contract account ", irswValue.balanceOf());

        uint256 providerPosition = irswValue.getProviderPositionByTokenId(contractId, accountAddr);
        console.log("provider position is ",providerPosition);
        // assertEq(providerPosition, 2000);
    }

    //3. testBuyer
    function testBuy() public {
        // address accountAddr = address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);
        // startHoax(accountAddr);
        address accountAddr = buyerAccount;
        vm.startPrank(accountAddr);
        vm.deal(accountAddr, 10 ether);
        (uint256 a, uint256 b, uint256 c) = irswValue.buy{value:100}(contractId, accountAddr, 100);
        console.log(a, b, c);
        irswValue.buy{ value: 1000 }(contractId, accountAddr, 1000);
        uint256 providerPosition = irswValue.getBuyerPositionByTokenId(contractId, accountAddr);
        console.log(providerPosition);
        console.log("buyer position is ",providerPosition);
    }

    function testIRInterestRate() public {
        irswValue.lockContract(contractId);
        vm.warp(86400*365);
        console.log("locked timestamp is ", irswValue.getSwapContractStateLockedBlock(contractId));
        uint256 currentTimeStampe = block.timestamp;
        console.log("current timestample is ", currentTimeStampe);
        uint256 baseRate = irswValue.calculateBaseInterestRate(1900, contractId);
        uint256 irCalculated = irswValue.calcualteInterestRate(1900, contractId);
        console.log("interest base rate is ", baseRate);
        console.log("interest rate calculated is ", irCalculated);
        uint256 secondPerDay = 86400;
        uint256 interval = currentTimeStampe - irswValue.getSwapContractStateLockedBlock(contractId);
        uint256 intervalDay = SafeMath.div(interval, secondPerDay);
        console.log("intevalDay is", intervalDay);
        uint256 mulIr = SafeMath.mul(baseRate, intervalDay);
        uint256 ir = SafeMath.div(mulIr*100, 365);
        console.log("interest rate is ", ir);
        testBuy();
        uint256 totalBuyerPosition = irswValue.getBuyerPositionByTokenId(contractId, buyerAccount);
        console.log("totalBuyerPosition is ", totalBuyerPosition);
        console.log("calculated Buyer interest is ", SafeMath.mul(totalBuyerPosition,irCalculated)/10000);
        uint256 buyerInterest = irswValue.calculateBuyerSwapInterest(contractId,buyerAccount,1900);
        console.log("buyer interest is ",buyerInterest);

    }

}
