// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "../../contracts/mock/StETHMockERC20.sol";

contract TestMockContract is Test {


    function testMockLido() public {
        startHoax(address(1336));
        // vm.startPrank(address(1336));
        StETHMockERC20 mock = new StETHMockERC20();
        mock.setTotalShares(100);
        mock.setTotalPooledEther(100);
        uint256 sharesToMint = mock.getSharesByPooledEth(100000);
        console.log("mock address is done ", address(mock));
        console.log("msg sender is ", address(msg.sender));
        console.log("msg sender balance is ", msg.sender.balance);
        console.log("share to mint is ", sharesToMint);
        uint256 returnTokenValue = mock.submit{ value: 100000 }(address(1336));
        console.log("return token value ", returnTokenValue);
        console.log("return token balance ", mock.balanceOf(address(1336)));
        vm.warp(100000000);
        // vm.stopPrank();
    }
}
