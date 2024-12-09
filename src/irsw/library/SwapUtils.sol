// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/utils/Counters.sol";

library SwapContractUtils {

    function addressToPublicKey(address addr) internal pure returns (bytes32) {
        bytes32 hash = keccak256(abi.encodePacked(addr));
        bytes32 publicKey;
        assembly {
            mstore(add(publicKey, 32), mload(add(hash, 32)))
            mstore(add(publicKey, 64), mload(add(hash, 64)))
        }
        return publicKey;
    }

    function increaseAndGetCountractId(  Counters.Counter storage counter ) internal returns (uint256) {
         Counters.increment(counter);
        return Counters.current(counter);
    }

    function latestContractId(Counters.Counter storage counter ) internal view returns (uint256) {
        return Counters.current(counter);
    }

}
