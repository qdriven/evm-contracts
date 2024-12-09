import { ethers } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { contractAddress, getSigners, swap_abi } from "./ldo/utils";
import { Contract } from 'ethers';
import { SWAPCONTRACTABI } from "../sdk/abi";

export async function deployStEthMockContract(){
  const [deployer] = await ethers.getSigners();

  console.log("Deploying mock contracts with the account:", deployer.address);

  const mockContract = await ethers.deployContract("StETHMockERC20");
  //0xF6A6F13ee4Ba1895A39c5544513a76A238f3038b
  console.log("Mock Contract address:", await mockContract.getAddress());
  console.log("starting setup mock conctract");

  return mockContract;
}

export async function deployIRSWapContract() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);
  const contract = await ethers.deployContract("InterestSwapStorage");
  //0xF6A6F13ee4Ba1895A39c5544513a76A238f3038b
  console.log("Contract address:", await contract.getAddress());
  console.log("starting setup mock contract");
  return contract;
}

export async function setupIRSwapContract(mockContract:Contract,irswapContract: Contract){
  const mockContractAddr= await mockContract.getAddress();
  console.log("mock contract address is ",mockContractAddr);
  const tx1 = await mockContract.setTotalShares(100);
  const tx2 = await mockContract.setTotalPooledEther(100);
  const tx3 = await irswapContract.setStakingContact(mockContractAddr);
  const mockAddress = await irswapContract.stETHContract();
  console.log("current mock address is ",mockAddress);
  console.log(tx1,tx2,tx3);
}

export async function createTestContracts(){
  const mockContract = await deployStEthMockContract();
  const irswapContract = await deployIRSWapContract();
  setupIRSwapContract(mockContract,irswapContract);
  return irswapContract;
}

export async function getIRSWapContract(irswapContract:string){
  const contractAddrss = ethers.getAddress(irswapContract);

  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log("siger address is ",signers[0])
  const swapContract = new ethers.Contract(contractAddrss, SWAPCONTRACTABI,signers[0]);
  return swapContract;
}
