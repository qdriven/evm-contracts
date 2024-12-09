// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./WstETH.sol";
import "../interfaces/lido/IstETH.sol";


contract WstETHMock is WstETH {
    constructor(ISTETH _StETH) public WstETH(_StETH) {}

    function mint(address recipient, uint256 amount) public {
        _mint(recipient, amount);
    }

    function getChainId() external view returns (uint256 chainId) {
        this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
        // solhint-disable-next-line no-inline-assembly
        assembly {
            chainId := chainid()
        }
    }
}
