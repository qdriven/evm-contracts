// contract deployed to:  0x38628490c3043E5D0bbB26d5a0a62fC77342e9d5
// deployed swap protocol address is  0x38628490c3043E5D0bbB26d5a0a62fC77342e9d5
// deployt tx hash is  undefined
// contract deployed to:  0x05bB67cB592C1753425192bF8f34b95ca8649f09
// deployed swap vault address is  0x05bB67cB592C1753425192bF8f34b95ca8649f09
import { getSigners, loadContract } from '../sdk/utils/deploy.contract'
import { protocol_abi} from "./abis"
import { ethers } from "hardhat"
import { utils } from 'ethers';
import { address } from 'ethers';
import { address } from 'ethers';
import { address } from 'ethers';
const erc20Addr = ethers.utils.getAddress("0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84");

const swapContract = {
  isValid: true,
  startTime: 1990932,
  endTime: 900909,
  intervalTimePeriod: 7,
  erc20: erc20Addr,
  minPrice: 1009,
  maxPrice: 10032,
  minInterest: 1,
  maxInterest: 5,
  fixedInterest:3,
  lockStatus: false
}

const swapContractTypes = ["bool","uint64","uint64","uint64","address",
                          "uint64","uint64","uint64","uint64","uint64","bool"]

                          // contract deployed to:  0x021DBfF4A864Aa25c51F0ad2Cd73266Fde66199d
                          // deployed swap protocol address is  0x021DBfF4A864Aa25c51F0ad2Cd73266Fde66199d
                          // deployt tx hash is  undefined
                          // contract deployed to:  0x4CF4dd3f71B67a7622ac250f8b10d266Dc5aEbcE
                          // deployed swap vault address is  0x4CF4dd3f71B67a7622ac250f8b10d266Dc5aEbcE
async function operations(){
  const signers = getSigners();
  console.log(signers[0])
  const protocolContract = await loadContract("0xDc64a140Aa3E981100a9becA4E685f962f0cF6C9", protocol_abi)
  // protocolContract.setVault("0x5FC8d32690cc91D4c39d9d3abcBD16989F875707");
  // protocolContract.offEth(1,{value: 1000000000});
  // const encodedParams = ethers.utils.defaultAbiCoder.encode(swapContractTypes,swapContract)
  const tokenId =await protocolContract.createSwapContract();
  console.log("token id is ",ethers.BigNumber.from(tokenId.data).toString(),tokenId);
  const  result = await protocolContract.balanceOf("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266");
  const contracts = protocolContract.contracts;
  console.log(result,contracts);

}

operations();



