// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "forge-std/Test.sol";
import "forge-std/console.sol";


contract TestIRSWapContractStorage is Test {
    InterestSwapStorage irswValue;

    function setUp() public {
        irswValue = new InterestSwapStorage();
        console.log("deploy address InterestSwapStorage ");
    }

    function testCreateSwapContract() public {
        irswValue.createSwapContractStorage();

        InterestSwapLib.InterestSetting memory contractInfo = InterestSwapLib.InterestSetting(
            1000,
            3000,
            7,
            address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84),
            90,
            100,
            4,
            6,
            5,
            0,
            false
        );
        irswValue.setContractInfo(1, contractInfo);
        checkContractInfo(1);
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

    function testCreateSwapContractWithParams() public {
        // InterestSwapLib.InterestSetting memory contractInfo = InterestSwapLib.InterestSetting(
        //       1000,3000,7,address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84),
        //         100,90,
        //         4,6,5,0,false
        //   );
        irswValue.createSwapContract(
                    100,
            300,
            address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84),
            100,
            90,
            4,
            6,
            5
        );
        checkContractInfo(2);
    }

    function testOffer() public {
        address accountAddr = address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);
        (uint256 a, uint256 b, uint256 c) = irswValue.offer(2, accountAddr, 100);
        console.log(a);
        console.log(b);
        console.log(c);
        irswValue.offer(2, accountAddr, 1000);
        uint256 providerPosition = irswValue.getProviderPositionByTokenId(2, accountAddr);
        console.log(providerPosition);
        assertEq(providerPosition, 1100);
    }

    function testBuy() public {
        address accountAddr = address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84);
        (uint256 a, uint256 b, uint256 c) = irswValue.buy(2, accountAddr, 100);
        console.log(a);
        console.log(b);
        console.log(c);
        irswValue.buy(2, accountAddr, 100000);
        uint256 providerPosition = irswValue.getBuyPositionByTokenId(2, accountAddr);
        console.log(providerPosition);
        assertEq(providerPosition, 100100);
    }

    address constant CHEATCODE_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;

    function testLockStatus() public{
        startHoax(address(1336));
        irswValue.createSwapContract(
            100,
            300,
            address(0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84),
            100,
            90,
            4,
            6,
            5
        );
        (uint256 a, uint256 b, uint256 c) = irswValue.offer(2, address(1336), 100);
        (uint256 e, uint256 f, uint256 g) = irswValue.buy(2, address(1336), 100);
        irswValue.lockContract(2);
        uint256 result = irswValue.calculateBaseInterestRate(80,2);
        vm.warp(100000000);
        console.log("locked timestamp is ",irswValue.getSwapContractStateLockedBlock(2));
         uint256 currentTimeStampe = block.timestamp;
         console.log("current timestample is ",currentTimeStampe);
        uint256 secondPerDay = 86400;
        uint256 interval = currentTimeStampe - irswValue.getSwapContractStateLockedBlock(2);
        uint256 intervalDay = SafeMath.div(interval,secondPerDay);
        console.log("intevalDay is", intervalDay );
        uint256 baseRate = irswValue.calculateBaseInterestRate(80,2);
        uint256 mulIr = SafeMath.mul(baseRate,intervalDay);
        console.log("mulIR is ",mulIr);
        uint256 ir = SafeMath.div(mulIr*100,365);
        // uint256 ir = irswValue.calcualteInterestRate(80,2);
        vm.stopPrank();

        console.log("interest base rate is ",result);
        console.log("interest rate is ",ir);
    }


}
