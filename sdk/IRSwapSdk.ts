//npx hardhat run sdk/IRSwapSdk.ts --network sepolia
import { ethers } from "hardhat"
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { SWAPCONTRACTABI,MOCKSTETHABI } from "./abi";
import { Contract } from 'ethers';
const ALCHEMY_MAINNET_URL="https://eth-sepolia.g.alchemy.com/v2/1zvCvbjmJK1fWq0Q_ITbQ0Pzh7nYtQVV";
const provider = new ethers.JsonRpcProvider(ALCHEMY_MAINNET_URL)
// const contractAddrss = ethers.getAddress("0xB7f8BC63BbcaD18155201308C8f3540b07f84F5e");
//test

export async function setupMockContract(mockContract:string){
  const contractAddrss = ethers.getAddress(mockContract);
  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log("siger address is ",signers[0])
  const mockCotract = new ethers.Contract(contractAddrss,MOCKSTETHABI,signers[0]);

  const log1 = await mockCotract.setTotalShares(100);
  console.log("tx is ",log1);
  const log2 = await mockCotract.setTotalPooledEther(100);
  console.log("tx is ",log2);
  const totalShare = await mockCotract.totalShares();
  console.log("totalShare is ",totalShare);

}

export async function verifyMockContract(irswapContract:string,mockContract:string){
  const contractAddrss = ethers.getAddress(irswapContract);

  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log("siger address is ",signers[0])
  const swapContract = new ethers.Contract(contractAddrss, SWAPCONTRACTABI,signers[0]);
  const mockAddress = await swapContract.stETHContract();
  console.log("mock address is ",mockAddress);
  const newMockAddress = ethers.getAddress(mockContract);
  const tx1 = await swapContract.setStakingContract();
  console.log(tx1)

  const newMock = await swapContract.stETHContract();
  console.log("newMock address is ",newMock);


}

export async function createSwapContract(swapContract: Contract){

  const tx = await swapContract.createSwapContract(100,
    300,
    ethers.getAddress("0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"),
    100,
    90,
    4,
    6,
    5);
    console.log(tx);
}

export async function getSwapContract(contractAddress:string){
  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log("siger address is ",signers[0])
  const swapContract = new ethers.Contract(contractAddress, SWAPCONTRACTABI,signers[0]);
  console.log(swapContract);
  // await createSwapContract(swapContract);
  const amount = ethers.parseEther("0.0001");
  const balanceNow = await swapContract.offer(2,signers[0],amount,{value:amount});
  console.log("current balance is ",balanceNow);
  console.log("current timestamp is ",Date.now())
}

setupMockContract("0x70e0bA845a1A0F2DA3359C97E0285013525FFC49")



// Deploying mock contracts with the account: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
// Mock Contract address: 0x70e0bA845a1A0F2DA3359C97E0285013525FFC49
// starting setup mock conctract
// Deploying contracts with the account: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266
// Contract address: 0x4826533B4897376654Bb4d4AD88B7faFD0C98528
// starting setup mock contract
