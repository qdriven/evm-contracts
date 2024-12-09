import { ethers } from "hardhat";
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";
import { SWAPCONTRACTABI } from "../sdk/abi";
import { Contract } from 'ethers';
const irswapContract = "0x4c5859f0F772848b2D91F1D83E2Fe57935348029";

async function createSwapContract(swapContract: Contract){

  const contractId = await swapContract.createSwapContract(
    1691608979,
    1694287379,
    ethers.getAddress("0xae7ab96520DE3A18E5e111B5EaAb095312D7fE84"),
    2000,
    1800,
    4,
    6,
    5
);
    return contractId;
}

async function main(){
  const contractAddrss = ethers.getAddress(irswapContract);

  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log("siger address is ",signers[0])
  const swapContract = new ethers.Contract(contractAddrss, SWAPCONTRACTABI,signers[0]);
  const contractId = 2;
  //  await createSwapContract(swapContract);
  console.log("create contract id is ",contractId);
  const accountBalance  = await swapContract.balanceOf();
  console.log("current balance is ",accountBalance);
  const contractInfo = await swapContract.getContractInfo(contractId);
  // console.log(contractInfo);
  // const contractState = await swapContract.getContractStateInfo(contractId);
  // console.log(contractState.data);

  const offerAmount = ethers.parseEther("1");
  const returnedAmount = await swapContract.offer(2,signers[0],offerAmount,{value:offerAmount});
  console.log("current offered  is ",returnedAmount);

  const amount = ethers.parseEther("0.5");
  const buyAmount = await swapContract.buy(2,signers[0],amount,{value:amount});
  console.log("current buy balance is ",buyAmount);

  const balanceSth = await swapContract.balanceOf();
  console.log("balance of this contract is ",balanceSth);

  const providerBlanace = await swapContract.getProviderPositionByTokenId(2,signers[0]);
  console.log("provider balance of this contract is ",providerBlanace);

  const buyerBalance = await swapContract.getBuyPositionByTokenId(2,signers[0]);
  console.log("provider balance of this contract is ",buyerBalance);

  const currentBaseInterest = await swapContract.calculateBaseInterestRate(1950,2);
  console.log("currentBaseInterest of this contract is ",currentBaseInterest);

  const lockContract = await swapContract.lockContract(2);
  console.log("lock contract ........");
  const ir = await swapContract.calcualteInterestRate(1950,2);
  console.log("current ir is ",ir);
}


main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
