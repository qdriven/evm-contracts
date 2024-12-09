// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


interface ISTETH {
    function getBufferedEther(uint256 _amount) external view returns (uint256);

    function getPooledEthByShares(uint256 _amount)
        external
        view
        returns (uint256);

    function getSharesByPooledEth(uint256 _amount)
        external
        view
        returns (uint256);

    function submit(address _referralAddress)
        external
        payable
        returns (uint256);

    function withdraw(uint256 _amount, bytes32 _pubkeyHash)
        external
        returns (uint256);

    function approve(address _recipient, uint256 _amount)
        external
        returns (bool);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    function decimals() external view returns (uint256);

    function getTotalShares() external view returns (uint256);

    function getTotalPooledEther() external view returns (uint256);
}
