import { ethers } from "hardhat";
import { Contract } from "ethers";
import { Signer } from 'ethers';
import type { SignerWithAddress } from "@nomiclabs/hardhat-ethers/signers";


export async function deployNoArgsContract(contractName: string,signer:Signer) : Promise<Contract>{
  const contractFactory = await ethers.getContractFactory(contractName)
  const contractForDeploy = await contractFactory.connect(signer)
    .deploy(); //contract contructor params
  const deploy_tx = await contractForDeploy.deployed();
  console.log("deployt tx hash is ",deploy_tx.hash)
  console.log("contract deployed to: ", contractForDeploy.address);
  return contractForDeploy
}/* `IRSwapProtocol` is a contract that implements an interest rate swap
protocol. It allows users to enter into interest rate swap
agreements, where they can exchange fixed and floating interest rates
on a specified notional amount for a predetermined period of time.
The contract facilitates the calculation and settlement of interest
rate payments between the parties involved in the swap agreement. */


export async function loadContract(contractAddress: string, abi:any) {
  const signers: SignerWithAddress[] = await ethers.getSigners();
  console.log("siger address is ",signers[0])
  const testContract = new ethers.Contract(contractAddress, abi,signers[1])
  return testContract;
}


export async function getSigners(){
  return  await ethers.getSigners();
}

